# Line Level / Claim Level bulk copy

Loads each lab's standardized line-level and claim-level CSV into that lab's own database, with a
fixed audit block on every row and a full log trail.

Everything here is **additive**. `LRN_Run_Log`, `LRN_Step_Log`, `LRN_Error_Log` and the existing
`LineClaimFileLogs` columns are unchanged and still written exactly as before.

---

## Deploying

The whole feature is inert until you turn it on, so deploy in this order.

**1. Create the tables.** Every script is idempotent — safe to re-run.

```bash
# LRNMaster
sqlcmd -S <server> -d LRNMaster -i sql/LRNMaster/01_ReportRunIdInfoLog.sql
sqlcmd -S <server> -d LRNMaster -i sql/LRNMaster/02_ReportsWorkflowTracker.sql

# each lab database
sqlcmd -S <server> -d NWL_LRN -i sql/Labs/_Common/02_LineClaimFileLogs.sql
sqlcmd -S <server> -d NWL_LRN -i sql/Labs/NWL_LRN/01_LineLevelData.sql
sqlcmd -S <server> -d NWL_LRN -i sql/Labs/NWL_LRN/02_ClaimLevelData.sql
```

Or run `sql/00_DeployAll.sql` in SSMS with **SQLCMD Mode** on (Query ▸ SQLCMD Mode).

**2. Confirm `LabMaster` and the connection strings.** The authoritative lab list is
`LRNMaster.dbo.LabMaster` (`LabId`, `LabName`, `ConnectionKey`, `IsActive`). For each active row,
`ConnectionKey` must resolve to a connection string in configuration:

```jsonc
"ConnectionStrings": {
  "DefaultConnection": "...LRNMaster...",
  "NWL_LRN": "...the key named in LabMaster.ConnectionKey..."
}
```

A lab with no matching mapping file or no resolvable connection string is **logged and skipped**, not
failed.

**3. Switch it on.**

```jsonc
"LineClaimImport": {
  "Enabled": true,
  "LabMappingsFolder": "Schemas/LabMappings",
  "FailFastOnInvalidMapping": true
}
```

Then set `BulkCopyToTable: true` on the levels you want loaded. Start with one lab.

---

## Onboarding a new lab

1. **Add the row to `LRNMaster.dbo.LabMaster`** — `LabId`, `LabName`, `ConnectionKey`, `IsActive = 1`.
2. **Add the connection string** under that `ConnectionKey`.
3. **Add the sheet** to `Schemas/ClaimLevelLineLevel_Fields.xlsx` (one sheet per lab, `CLAIM LEVEL` in
   columns A/B, `LINE LEVEL` in D/E).
4. **Create `Schemas/LabMappings/<Lab>FieldMappings.json`**:

```jsonc
{
  "LabId": 20,
  "LabName": "NorthWest",
  "DatabaseName": "NWL_LRN",
  "LineLevel": {
    "Enabled": true,
    "CreateCsv": true,
    "BulkCopyToTable": false,     // leave false until the first dry run looks right
    "TruncateBeforeLoad": true,
    "BatchSize": 10000,
    "BulkCopyTimeoutSeconds": 900,
    "SqlTableName": "dbo.LineLevelData",
    "StagingTableName": "dbo.LineLevelData_Staging",
    "Fields": [
      { "CsvHeader": "Claim ID", "SqlColumn": "ClaimID", "IncludeInHash": true }
    ]
  },
  "ClaimLevel": { /* same shape */ }
}
```

`CsvHeader` must match the **standardized CSV** header — the output of `StandardCsvExporter`, not the
raw lab file. `SqlColumn` must match the spreadsheet. Never map an audit column
(`FileLogId`, `RunId`, `WeekFolder`, `SourceFullPath`, `FileName`, `FileType`, `RowHash`) — the
loader stamps those, and mapping one fails validation at startup. `LabID` and `LabName` are the
exception and may be mapped.

5. **Add the lab to `LABS` in `sql/generate_sql.py`** and regenerate:

```bash
python sql/generate_sql.py
```

Never hand-edit `sql/Labs/**` — it is generated.

6. **Deploy** the new scripts, then flip `BulkCopyToTable: true`.

---

## Toggles

Per lab, per level, independent — line level on with claim level off is supported.

| Key | Default | Effect |
|---|---|---|
| `Enabled` | `true` | `false` skips the level end to end |
| `CreateCsv` | `true` | `false` skips **publishing the CSV file only**. The load still runs |
| `BulkCopyToTable` | `false` | must be `true` to write to SQL. The only toggle that controls the load |
| `TruncateBeforeLoad` | `true` | truncate-and-reload |
| `BatchSize` | `10000` | `SqlBulkCopy` batch |
| `BulkCopyTimeoutSeconds` | `900` | never `0` — a hung load must fail, not block the run |

Every skip is logged to `ReportRunIdInfoLog` as `Info` and to `ReportsWorkflowTracker` as `Skipped`.
Nothing is dropped silently.

The defaults reproduce today's behaviour, so an existing lab JSON that is never touched keeps working
after deploy — and does not start writing to SQL until someone opts it in.

---

## How a load runs

`TRUNCATE`, bulk copy and verify, all in one transaction:

1. Insert the `LineClaimFileLogs` row -> `FileLogId`.
2. `BEGIN TRAN`, then `TRUNCATE` the destination.
3. Stream the CSV straight into it with `SqlBulkCopy` (`EnableStreaming`, explicit column mappings
   by name, never ordinal), enlisted in the same transaction.
4. Count the destination and compare with the CSV row count - still inside the transaction.
5. Commit on a match; otherwise roll back, leaving the table exactly as it was.
6. Update the file log, `ReportRunIdInfoLog` and `ReportsWorkflowTracker`.

The trade is a `TABLOCK` on the destination for the duration of the load - about 18s for a 195k row
lab - during which readers block unless the database has read-committed snapshot on. The load runs
once per lab per run, so that window is acceptable.

**Truncate scope is per run per level.** The pipeline produces exactly one line-level and one
claim-level CSV per lab per run, so per-file and per-run truncation are equivalent. If a run ever
starts producing two files of the same level for one lab, this must move to truncate-once-per-run or
the second file will discard the first one's rows.


---

## Failure isolation

One lab failing never affects another. Within a lab, line level and claim level are isolated from
each other, and the whole import is wrapped so that a bulk-copy failure still lets the rest of the
lab's run (SharePoint upload, status log) finish. Failures land in `ReportRunIdInfoLog` (`Error`),
`ReportsWorkflowTracker` (`Failed`), `LineClaimFileLogs.Status` and `LRN_Step_Log` (step 85).

---

## Tests

```bash
dotnet run --project LRN.MasterFileProcessorWorker -- --selftest
```

40 assertions covering RowHash determinism and normalization, mapping validation, audit stamping and
the config toggles. Needs no database and exits non-zero on failure.

---

## The tracker table

`ReportsWorkflowTracker` is stored **tall** (one row per `RunId` + `LabID` + `ReportName`) and
upserted via `MERGE` on the unique key, so re-running a `RunId` updates in place.
`dbo.vw_ReportsWorkflowTracker_Wide` reproduces the exact column layout of
`Reports_Workflow_Tracker_v1.0.xlsx` for export.

---

See `TypeReconciliation.md` for column typing decisions, the completeness gaps per lab, and the
outstanding CSV/mapping mismatches.
