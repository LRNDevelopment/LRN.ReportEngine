# Production deployment

Everything needed, one self-contained script per database. Nothing else from `sql/` is required —
these bundles have no `:r` includes, so they run straight from SSMS without SQLCMD mode.

```
LRNMaster.sql                    schema, seed data and stored procedures
LRNMaster_LabIdAlignment.sql     ONE-TIME data migration (dry run by default)

Augustus_LRN.sql      CoveLRN.sql          NWL_LRN.sql        PCRLOA_LRN.sql
BeechTree_LRN.sql     Elixir_LRN.sql       PCRAL_LRN.sql      PhiLife_LRN.sql
Certus_LRN.sql        InHealthDTRLRN.sql   PCRCO_LRN.sql      RisingTides.sql
```

The 12 lab bundles are built from `sql/Existing_LineLevel_ClaimLevel_DATA.sql` — the schema the
other teams already run. Every production column is reproduced verbatim: same name, same type, same
nullability, including the `InsuranceBalance_Decimal` computed column and the identity primary key.

**Idempotent.** Creates what is missing, adds missing columns, widens undersized ones. The only DROP
is the obsolete `*_Staging` tables (see below); it never drops a data table, renames, narrows or
retypes anything, and never deletes lab data. Re-running is safe.

---

## Run order

### 1. LRNMaster schema

```
sqlcmd -S <server> -d LRNMaster -E -b -I -i LRNMaster.sql
```

### 2. Each lab database

Independent of one another and of LRNMaster — run only the labs you are enabling.

```
sqlcmd -S <server> -d Augustus_LRN   -E -b -I -i Augustus_LRN.sql
sqlcmd -S <server> -d BeechTree_LRN  -E -b -I -i BeechTree_LRN.sql
sqlcmd -S <server> -d Certus_LRN     -E -b -I -i Certus_LRN.sql
sqlcmd -S <server> -d CoveLRN        -E -b -I -i CoveLRN.sql
sqlcmd -S <server> -d Elixir_LRN     -E -b -I -i Elixir_LRN.sql
sqlcmd -S <server> -d InHealthDTRLRN -E -b -I -i InHealthDTRLRN.sql
sqlcmd -S <server> -d NWL_LRN        -E -b -I -i NWL_LRN.sql
sqlcmd -S <server> -d PCRAL_LRN      -E -b -I -i PCRAL_LRN.sql
sqlcmd -S <server> -d PCRCO_LRN      -E -b -I -i PCRCO_LRN.sql
sqlcmd -S <server> -d PCRLOA_LRN     -E -b -I -i PCRLOA_LRN.sql
sqlcmd -S <server> -d PhiLife_LRN    -E -b -I -i PhiLife_LRN.sql
sqlcmd -S <server> -d RisingTides    -E -b -I -i RisingTides.sql
```

### 3. LabId alignment — last, and only once

⚠ **Take a backup first.** This rewrites `LabId` on ~194,000 rows.

```
sqlcmd -S <server> -d LRNMaster -E -b -I -i LRNMaster_LabIdAlignment.sql
```

**Dry run by default** — it reports exactly what would change and rolls back. Review the output,
then set `@Commit = 1` in section 2 of the file and run it again to apply.

> `-I` enables `QUOTED_IDENTIFIER`, which SQL Server requires for any INSERT/UPDATE on a table with a
> `PERSISTED` computed column. Without it the lab scripts fail with error 1934. The .NET client sets
> it automatically, so the worker itself is unaffected. For SQL auth use `-U <user> -P <password>`
> instead of `-E`.

---

## What lands where

### LRNMaster.sql

| Object | Change |
|---|---|
| `ReportRunIdInfoLog` | created; `+ SourceFileName` |
| `ReportsWorkflowTracker` | created; `+ ReportTypeId` (FK); `vw_ReportsWorkflowTracker_Wide` |
| `ReportTypeMaster` | created + seeded with the 14 report types in workbook order (`+ DisplayOrder`) |
| `LRN_Run_Log` | `+ LabId`, `+ WeekFolder`, backfilled from `dbo.Labs` by name |
| `LRN_Step_Log` | `+ LabId`, backfilled from `dbo.Labs` by name |
| `usp_ReportRunIdInfoLog_Insert` | created / altered — the entry point for other teams |
| `usp_ReportsWorkflowTracker_Upsert` | created / altered — resolves lab context from RunId alone |
| `usp_ReportsWorkflowTracker_Pivot` | created / altered — the workbook layout; `@Mode` for one row per lab |
| `usp_ReportRunIdInfoLog_Get` | created / altered — reads a run's log back; `@LogType='Error'` for triage |

Existing columns on `LRN_Run_Log` and `LRN_Step_Log` are untouched.

### LRNMaster_LabIdAlignment.sql

Makes `dbo.Labs` the single global lab registry for every LRN application.

| Step | Change |
|---|---|
| 1 | Backfills placeholder `ConnectionKey` values in `dbo.Labs` from `LRNMetricsLab` |
| 2 | Remaps `LabId` — `7→6` PCRDx-AL, `8→7` PCRDx-CO, `19→24` Augustus, `20→23` NorthWest |
| 3 | Replaces `LRNMetricsLab` with a **view** over `dbo.Labs`; the old table is kept as `LRNMetricsLab_Backup` |

Affects `DenialTaskBoard`, `DenialLineItem`, `DenialInsight`, `DenialAnalysisRunLog`,
`LabInsuranceMaster`, `LabMedians`, `LabModes`. One transaction; verifies zero orphaned rows before
committing; rolls back on any failure.

Reverting step 3 is `DROP VIEW dbo.LRNMetricsLab` plus renaming the backup table back.

### Each lab database

| Object | Change |
|---|---|
| `LineClaimFileLogs` | created, or `+ Status, RowsCopied, ErrorMessage, CompletedDateTime` |
| `LineLevelData` | production schema verbatim, plus the columns in `SchemaAlignmentReport.md` |
| `ClaimLevelData` | production schema verbatim, plus the columns in `SchemaAlignmentReport.md` |
| `LineLevelData_Staging`, `ClaimLevelData_Staging` | **dropped** if present — superseded by the single-transaction load |
| `InsuranceBalance_Decimal` | `AS (TRY_CAST([InsuranceBalance] AS [decimal](18,2))) PERSISTED`, on all four tables |

The load runs `TRUNCATE`, `SqlBulkCopy` and the row-count check inside **one transaction** and
commits only when the destination count matches the CSV. A failure at any point rolls the table back
to exactly what it held before, so a failed load can never leave a lab table empty or half-filled.

An earlier design staged into a second table first. It gave the same guarantee but stored a full
duplicate of every lab's data — on `NWL_LRN` that was 3.3 GB of a 31 GB database and helped fill the
PRIMARY filegroup. The deployment scripts now **drop** any staging table they find.

---

## Verifying

```
dotnet run --project LRN.MasterFileProcessorWorker -- --diagnose
```

Checks config, mappings, connections and every target table's columns. Expect `All checks passed`.

By hand:

```sql
-- LRNMaster
SELECT * FROM dbo.ReportTypeMaster ORDER BY DisplayOrder;   -- 14 rows, IsActive = 1
EXEC dbo.usp_ReportsWorkflowTracker_Pivot;                   -- the dashboard, wide
SELECT name FROM sys.procedures WHERE name LIKE 'usp_Report%';
SELECT COL_LENGTH('dbo.LRN_Run_Log','LabId'), COL_LENGTH('dbo.ReportRunIdInfoLog','SourceFileName');

-- after the alignment: expect zero rows
SELECT d.LabId, COUNT(*) FROM dbo.DenialTaskBoard d
WHERE NOT EXISTS (SELECT 1 FROM dbo.Labs L WHERE L.LabId = d.LabId) GROUP BY d.LabId;

-- a lab database
SELECT COUNT(*) FROM sys.columns WHERE object_id = OBJECT_ID('dbo.LineLevelData');
SELECT name FROM sys.computed_columns WHERE name = 'InsuranceBalance_Decimal';
```

---

## Regenerating

```
python sql/align_with_production.py    # the 12 lab bundles + SchemaAlignmentReport.md
python sql/generate_sql.py             # LRNMaster.sql + LRNMaster_LabIdAlignment.sql
```

Do not hand-edit the `.sql` files in this folder. This README is maintained by hand.

## Note on database names

These are production's names, from `Existing_LineLevel_ClaimLevel_DATA.sql`. The dev server differs
in places — dev has `CertusLRN` where production has `Certus_LRN`. Point
`MasterFileProcessor:Labs[].LabDbConnectionString` at whichever is right for the environment.
