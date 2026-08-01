# Production deployment

One self-contained script per database — 12 lab databases plus `LRNMaster`. Nothing else from
`sql/` is needed.

The lab scripts are built from **`sql/Existing_LineLevel_ClaimLevel_DATA.sql`**, the schema the other
teams already run in production. Every production column is reproduced verbatim: same name, same
type, same nullability, including the `InsuranceBalance_Decimal` computed column. Nothing is
renamed, retyped, narrowed or dropped.

Every script is **idempotent**: it creates what is missing and adds missing columns only. Re-running
is safe and never deletes data.

See **`SchemaAlignmentReport.md`** at the repo root for the column-by-column diff behind these files.

## Run order

**1. LRNMaster first.**

```
sqlcmd -S <server> -d LRNMaster -E -b -i LRNMaster.sql
```

**2. Then each lab database** — independent of one another, so run only the labs you are enabling.

```
sqlcmd -S <server> -d Augustus_LRN   -E -b -i Augustus_LRN.sql
sqlcmd -S <server> -d BeechTree_LRN  -E -b -i BeechTree_LRN.sql
sqlcmd -S <server> -d Certus_LRN     -E -b -i Certus_LRN.sql
sqlcmd -S <server> -d CoveLRN        -E -b -i CoveLRN.sql
sqlcmd -S <server> -d Elixir_LRN     -E -b -i Elixir_LRN.sql
sqlcmd -S <server> -d InHealthDTRLRN -E -b -i InHealthDTRLRN.sql
sqlcmd -S <server> -d NWL_LRN        -E -b -i NWL_LRN.sql
sqlcmd -S <server> -d PCRAL_LRN      -E -b -i PCRAL_LRN.sql
sqlcmd -S <server> -d PCRCO_LRN      -E -b -i PCRCO_LRN.sql
sqlcmd -S <server> -d PCRLOA_LRN     -E -b -i PCRLOA_LRN.sql
sqlcmd -S <server> -d PhiLife_LRN    -E -b -i PhiLife_LRN.sql
sqlcmd -S <server> -d RisingTides    -E -b -i RisingTides.sql
```

For SQL auth use `-U <user> -P <password>` instead of `-E`. In SSMS just open and run — no SQLCMD
mode needed, there are no `:r` includes.

## What lands where

### LRNMaster

| Object | Change |
|---|---|
| `ReportRunIdInfoLog` | created; `+ SourceFileName` |
| `ReportsWorkflowTracker` | created; `+ ReportTypeId` (FK); `vw_ReportsWorkflowTracker_Wide` |
| `ReportTypeMaster` | created + seeded with the 13 report types, all active |
| `LRN_Run_Log` | `+ LabId`, `+ WeekFolder` |
| `LRN_Step_Log` | `+ LabId` |
| `usp_ReportRunIdInfoLog_Insert` | created / altered |
| `usp_ReportsWorkflowTracker_Upsert` | created / altered |

### Each lab database

| Object | Change |
|---|---|
| `LineClaimFileLogs` | created, or `+ Status, RowsCopied, ErrorMessage, CompletedDateTime` |
| `LineLevelData` | production schema verbatim, plus the columns listed in the alignment report |
| `ClaimLevelData` | production schema verbatim, plus the columns listed in the alignment report |
| `LineLevelData_Staging`, `ClaimLevelData_Staging` | same shape, minus the identity column |
| `InsuranceBalance_Decimal` | added to **all four tables in every lab** — see below |

### `InsuranceBalance_Decimal`

`InsuranceBalance` is stored as `nvarchar` everywhere, so aggregating it needs a cast in every
query. All four tables now carry:

```sql
[InsuranceBalance_Decimal] AS (TRY_CAST([InsuranceBalance] AS [decimal](18,2))) PERSISTED
```

Production already had this on three `ClaimLevelData` tables (Augustus, Certus, NWL); it is now on
line level and claim level for all 12 labs, including the staging tables so a staged load reads the
same as the live one.

`TRY_CAST` yields `NULL` for non-numeric text rather than failing the row. `PERSISTED` stores the
result, so it can be indexed and costs nothing to read. Nothing writes to it — it is absent from
every lab mapping, so it appears in neither the `SqlBulkCopy` column list nor the swap's
`INSERT ... SELECT`.

> ⚠ **A `PERSISTED` computed column requires `QUOTED_IDENTIFIER ON` for any INSERT or UPDATE on the
> table.** The .NET client sets this by default, so the worker is unaffected. `sqlcmd` does **not** —
> pass `-I` when writing to these tables by hand, or the insert fails with error 1934. Reads are
> unaffected.

Staging tables are this worker's own — production does not have them. The load writes to staging,
verifies the row count, then truncates and swaps into the live table inside one short transaction,
so a failed load can never leave a lab table empty.

## Verifying

```
dotnet run --project LRN.MasterFileProcessorWorker -- --diagnose
```

Checks config, mappings, connections and every target table's columns. Expect `All checks passed`.

By hand:

```sql
-- LRNMaster
SELECT * FROM dbo.ReportTypeMaster ORDER BY ReportTypeId;   -- 13 rows, IsActive = 1
SELECT name FROM sys.procedures WHERE name LIKE 'usp_Report%';

-- a lab database
SELECT COUNT(*) FROM sys.columns WHERE object_id = OBJECT_ID('dbo.LineLevelData');
SELECT COUNT(*) FROM sys.columns WHERE object_id = OBJECT_ID('dbo.ClaimLevelData');
```

## Regenerating

```
python sql/align_with_production.py    # lab bundles + SchemaAlignmentReport.md
python sql/generate_sql.py             # LRNMaster.sql
```

Do not hand-edit anything in this folder.

## Note on database names

The names here are production's, taken from `Existing_LineLevel_ClaimLevel_DATA.sql`. The dev server
differs in places — for example dev has `CertusLRN` where production has `Certus_LRN`. Point
`MasterFileProcessor:Labs[].LabDbConnectionString` at whichever is correct for the environment you
are deploying to.
