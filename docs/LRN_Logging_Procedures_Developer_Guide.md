# LRN report logging — developer guide

Two stored procedures in **`LRNMaster`** record what your report did. Call these instead of writing
to the tables directly, so column changes stay behind the contract.

| Procedure | Purpose | Called |
|---|---|---|
| `dbo.usp_ReportRunIdInfoLog_Insert` | progress / diagnostic trail | many times per run |
| `dbo.usp_ReportsWorkflowTracker_Upsert` | one status row per report per run | once or twice per report |

Both are granted `EXECUTE` to `public`. Neither needs you to know a LabId, a lab name or a week
folder — the tracker resolves all of that from the `RunId`.

`CreatedOn` defaults to `GETDATE()` on both. **Do not pass it.**

### What a RunId looks like

    R20260803CRT0001
    │ │        │  └── the lab's run number, continuous — it never resets
    │ │        └───── lab code, from dbo.Labs.ShortName
    │ └────────────── date the run started, YYYYMMDD
    └──────────────── literal 'R'

| | | | | | |
|---|---|---|---|---|---|
| `AUG` Augustus | `BCT` BeechTree | `COV` Cove | `CRT` Certus | `ELX` Elixir | `INH` InHealth |
| `NWL` Northwest | `PAL` PCRDx-AL | `PCO` PCRDx-CO | `PHY` Phi Life | `PLA` PCR Labs of America | `RST` Rising Tides |

You never build one — take the RunId you were given. Ids in the older global format
(`20260801R0007`) are still valid and still in the tables; the two shapes never collide, since the
new one starts with `R` and the old one with a digit.

---

## 1. `usp_ReportRunIdInfoLog_Insert`

Your running commentary: started, row counts, warnings, failures, finished.

```sql
EXEC dbo.usp_ReportRunIdInfoLog_Insert
     @RunId          = 'R20260803CRT0001',
     @ReportType     = 'Denial Report',
     @SourceSystem   = 'Certus',
     @SourceFileName = 'R20260803CRT0001_Certus_Denial_07.20.2026.csv',
     @LogType        = 'Info',
     @LogMessage     = 'Loaded 60,625 rows.',
     @CreatedBy      = 'LRN.DenialDatabaseWorker';
```

| Parameter | Type | Required | Notes |
|---|---|:--:|---|
| `@RunId` | `varchar(30)` | ✔ | The run this belongs to. Rejected if blank. |
| `@ReportType` | `varchar(100)` | ✔ | Free text. Use a name from §3 where it fits. |
| `@SourceSystem` | `varchar(100)` | ✔ | Lab name, or `SharePoint`, `LIMS`, … |
| `@SourceFileName` | `nvarchar(400)` | | File this entry is about. File name only, not the full path. |
| `@LogType` | `varchar(50)` | ✔ | One of `Start` `Info` `Warning` `Error` `End`. Anything else is **rejected**. |
| `@LogMessage` | `nvarchar(MAX)` | | Free text. Put the full exception here on `Error`. |
| `@CreatedBy` | `varchar(100)` | ✔ | Your service or job name, not a person. |
| `@ReportRunIdInfoLogId` | `bigint` | | `OUTPUT` — the new row's id, if you want it. |

`@ReportType` is deliberately free text because this is a progress log and you may want finer labels
than the master list. When the value does match `ReportTypeMaster`, the id is resolved and stored
alongside so the log still joins to the master.

### A typical run

```sql
DECLARE @RunId varchar(30) = 'R20260803CRT0001';

EXEC dbo.usp_ReportRunIdInfoLog_Insert @RunId, 'Denial Report', 'Certus',
     'R20260803CRT0001_Certus_Denial.csv', 'Start', 'Denial Report started.', 'MyService';

EXEC dbo.usp_ReportRunIdInfoLog_Insert @RunId, 'Denial Report', 'Certus',
     'R20260803CRT0001_Certus_Denial.csv', 'Info',  'Read 60,625 source rows.', 'MyService';

EXEC dbo.usp_ReportRunIdInfoLog_Insert @RunId, 'Denial Report', 'Certus',
     'R20260803CRT0001_Certus_Denial.csv', 'Warning', '12 rows had no payer code.', 'MyService';

EXEC dbo.usp_ReportRunIdInfoLog_Insert @RunId, 'Denial Report', 'Certus',
     'R20260803CRT0001_Certus_Denial.csv', 'End',   'Denial Report finished in 41s.', 'MyService';
```

On failure, log the exception and then close the run:

```sql
EXEC dbo.usp_ReportRunIdInfoLog_Insert @RunId, 'Denial Report', 'Certus', NULL,
     'Error', @ErrorMessageIncludingStackTrace, 'MyService';

EXEC dbo.usp_ReportRunIdInfoLog_Insert @RunId, 'Denial Report', 'Certus', NULL,
     'End', 'Denial Report ended with failure.', 'MyService';
```

---

## 2. `usp_ReportsWorkflowTracker_Upsert`

One row per report per run. This drives the workflow dashboard.

```sql
EXEC dbo.usp_ReportsWorkflowTracker_Upsert
     @RunId       = 'R20260803CRT0001',
     @ReportName  = 'Denial Report',
     @Status      = 'Success',
     @RowCount    = 60625,
     @StartedOn   = '2026-08-01T10:15:00',
     @CompletedOn = '2026-08-01T10:15:41',
     @Remarks     = NULL,
     @CreatedBy   = 'LRN.DenialDatabaseWorker';
```

| Parameter | Type | Required | Notes |
|---|---|:--:|---|
| `@RunId` | `varchar(30)` | ✔ | Everything about the lab is looked up from this. |
| `@ReportName` | `varchar(200)` | ✔ | **Must** be an active name from §3. A typo is rejected, not stored. |
| `@Status` | `varchar(50)` | ✔ | One of `InProgress` `Success` `Failed` `Skipped`. Anything else is rejected. |
| `@RowCount` | `bigint` | | Rows produced. |
| `@StartedOn` | `datetime2(3)` | | Preserved from the first call — a later update never overwrites it. |
| `@CompletedOn` | `datetime2(3)` | | |
| `@Remarks` | `nvarchar(MAX)` | | Put the failure reason here on `Failed`. |
| `@CreatedBy` | `varchar(100)` | ✔ | Your service or job name. |
| `@LabId` | `int` | | Only if `LRN_Run_Log` has no lab for this run yet. |
| `@WeekFolder` | `varchar(200)` | | Resolved for you — see below. Pass it only to override. |
| `@LabName` | `varchar(200)` | | Only if `LRN_Run_Log` has no lab for this run yet. |

**You do not pass LabId, LabName or WeekFolder.** They are read from `dbo.LRN_Run_Log` by `RunId`,
and `ReportTypeId` from `dbo.ReportTypeMaster` by `@ReportName`.

### Where WeekFolder comes from

If you do not send `@WeekFolder` it is resolved in this order, first non-NULL winning:

1. `dbo.LRN_Run_Log` for the RunId
2. the RunId's existing tracker rows — preferring the same lab, then `Line Level Master` /
   `Claim Level Master`, then the most recently touched

The run log frequently holds NULL, so in practice step 2 is what fills it: the master file processor
stamps the week folder on its own two rows and every other report of that run inherits it. An empty
string counts as not supplied.

Once resolved it also backfills any row of that run still holding NULL, so reports that logged before
the week folder was known get corrected. Only NULLs are touched — a value you passed is never
overwritten.

Nothing fails if the week folder cannot be found anywhere; the column simply stays NULL.

### Derived reports

`Clinic Summary` and `Sales Rep Summary` are built from the line-level and claim-level data rather
than run on their own, so the master file processor marks them `Success` against the same RunId once
**both** of those have actually loaded for that lab. `Remarks` records why:
*Derived from Line Level Master and Claim Level Master.*

Clinic Summary is marked for every lab; Sales Rep Summary only for the labs that have the data
(currently Cove and Elixir). The list lives in `appsettings.json` under
`LineClaimImport:DerivedReports` — an empty `LabIds` means every lab.

If either level fails or is skipped, neither is marked and the reason goes to `ReportRunIdInfoLog`.
Do not write these two yourself for those labs; you would be overwriting a row the processor owns.

### Upsert behaviour

The key is `(RunId, LabID, ReportName)`. Calling twice **updates**, it does not duplicate — so the
normal pattern is to mark `InProgress` at the start and the real outcome at the end:

```sql
-- at the start
EXEC dbo.usp_ReportsWorkflowTracker_Upsert
     @RunId = @RunId, @ReportName = 'Denial Report', @Status = 'InProgress',
     @StartedOn = SYSDATETIME(), @CreatedBy = 'MyService';

-- at the end
EXEC dbo.usp_ReportsWorkflowTracker_Upsert
     @RunId = @RunId, @ReportName = 'Denial Report', @Status = 'Success',
     @RowCount = 60625, @CompletedOn = SYSDATETIME(), @CreatedBy = 'MyService';
```

The second call keeps the original `StartedOn`, so the dashboard shows the true duration.

On failure:

```sql
EXEC dbo.usp_ReportsWorkflowTracker_Upsert
     @RunId = @RunId, @ReportName = 'Denial Report', @Status = 'Failed',
     @CompletedOn = SYSDATETIME(), @Remarks = 'Source file missing for week 07.20.2026',
     @CreatedBy = 'MyService';
```

If your report legitimately did not run — nothing to process, or switched off — use `Skipped` with a
reason in `@Remarks`. Do not leave the row absent; a missing row is indistinguishable from a crash.

---

## 3. Report names

Use these **exactly** in `@ReportName`. All 14 are active. The order below is the column order of
the workflow dashboard, which is what `DisplayOrder` carries — `ReportTypeId` is only insert order.

| # | ReportTypeName | | # | ReportTypeName |
|---:|---|---|---:|---|
| 1 | `Line Level Master` | | 8 | `Clinic Summary` |
| 2 | `Claim Level Master` | | 9 | `Sales Rep Summary` |
| 3 | `LIS Summary` | | 10 | `Coding Validation` |
| 4 | `Production Summary` | | 11 | `Payer Policy Validation` |
| 5 | `Collection Summary` | | 12 | `Forecasting` |
| 6 | `Denial Report` | | 13 | `Prediction Analysis` |
| 7 | `Executive Summary` | | 14 | `Error Log` |

Always current:

```sql
SELECT ReportTypeId, ReportTypeName FROM LRNMaster.dbo.ReportTypeMaster
WHERE IsActive = 1 ORDER BY DisplayOrder;
```

Need a name that is not listed? Ask for it to be added to `ReportTypeMaster` — do not invent one, the
tracker will reject it.

### One call per report

```sql
EXEC dbo.usp_ReportsWorkflowTracker_Upsert @RunId='R20260803CRT0001', @ReportName='Line Level Master',       @Status='Success', @RowCount=195161, @CreatedBy='MyService';
EXEC dbo.usp_ReportsWorkflowTracker_Upsert @RunId='R20260803CRT0001', @ReportName='Claim Level Master',      @Status='Success', @RowCount=60625,  @CreatedBy='MyService';
EXEC dbo.usp_ReportsWorkflowTracker_Upsert @RunId='R20260803CRT0001', @ReportName='LIS Summary',             @Status='Success', @CreatedBy='MyService';
EXEC dbo.usp_ReportsWorkflowTracker_Upsert @RunId='R20260803CRT0001', @ReportName='Production Summary',      @Status='Success', @CreatedBy='MyService';
EXEC dbo.usp_ReportsWorkflowTracker_Upsert @RunId='R20260803CRT0001', @ReportName='Collection Summary',      @Status='Success', @CreatedBy='MyService';
EXEC dbo.usp_ReportsWorkflowTracker_Upsert @RunId='R20260803CRT0001', @ReportName='Denial Report',           @Status='Success', @CreatedBy='MyService';
EXEC dbo.usp_ReportsWorkflowTracker_Upsert @RunId='R20260803CRT0001', @ReportName='Executive Summary',       @Status='Success', @CreatedBy='MyService';
EXEC dbo.usp_ReportsWorkflowTracker_Upsert @RunId='R20260803CRT0001', @ReportName='Clinic Summary',          @Status='Success', @CreatedBy='MyService';
EXEC dbo.usp_ReportsWorkflowTracker_Upsert @RunId='R20260803CRT0001', @ReportName='Sales Rep Summary',       @Status='Success', @CreatedBy='MyService';
EXEC dbo.usp_ReportsWorkflowTracker_Upsert @RunId='R20260803CRT0001', @ReportName='Coding Validation',       @Status='Success', @CreatedBy='MyService';
EXEC dbo.usp_ReportsWorkflowTracker_Upsert @RunId='R20260803CRT0001', @ReportName='Payer Policy Validation', @Status='Success', @CreatedBy='MyService';
EXEC dbo.usp_ReportsWorkflowTracker_Upsert @RunId='R20260803CRT0001', @ReportName='Forecasting',             @Status='Success', @CreatedBy='MyService';
EXEC dbo.usp_ReportsWorkflowTracker_Upsert @RunId='R20260803CRT0001', @ReportName='Prediction Analysis',     @Status='Success', @CreatedBy='MyService';
```

---

## 4. Calling from C#

```csharp
await using var conn = new SqlConnection(lrnMasterConnectionString);
await using var cmd  = new SqlCommand("dbo.usp_ReportRunIdInfoLog_Insert", conn)
{
    CommandType = CommandType.StoredProcedure
};

cmd.Parameters.Add("@RunId",          SqlDbType.VarChar,   30).Value = runId;
cmd.Parameters.Add("@ReportType",     SqlDbType.VarChar,  100).Value = "Denial Report";
cmd.Parameters.Add("@SourceSystem",   SqlDbType.VarChar,  100).Value = labName;
cmd.Parameters.Add("@SourceFileName", SqlDbType.NVarChar, 400).Value = (object?)fileName ?? DBNull.Value;
cmd.Parameters.Add("@LogType",        SqlDbType.VarChar,   50).Value = "Info";
cmd.Parameters.Add("@LogMessage",     SqlDbType.NVarChar,  -1).Value = (object?)message  ?? DBNull.Value;
cmd.Parameters.Add("@CreatedBy",      SqlDbType.VarChar,  100).Value = "MyService";

await conn.OpenAsync(ct);
await cmd.ExecuteNonQueryAsync(ct);
```

**Wrap logging in its own try/catch.** A logging outage must never fail your report. The reference
implementation swallows the exception and falls back to the file logger.

---

## 5. Errors you may get

| Message | Cause |
|---|---|
| `@RunId is required.` | Blank or null `@RunId`. |
| `@LogType must be Start, Info, Warning, Error or End.` | Unrecognised `@LogType`. |
| `@Status must be Success, Failed, Skipped or InProgress.` | Unrecognised `@Status`. |
| `"X" is not an active report in dbo.ReportTypeMaster.` | `@ReportName` typo, or the name needs adding. |
| `RunId "X" was not found in dbo.LRN_Run_Log and no @LabId was supplied.` | The run has not been registered yet. Pass `@LabId` and `@WeekFolder`, or log the run first. |

All are raised at severity 16 and write nothing.

---

## 6. Checking your output

Two read procedures. You do not need `SELECT` on the tables to use them.

### `usp_ReportRunIdInfoLog_Get` — your log trail

Send a RunId, get that run's whole trail oldest-first. Add `@LogType` to narrow it.

```sql
EXEC LRNMaster.dbo.usp_ReportRunIdInfoLog_Get @RunId = 'R20260803CRT0001';                      -- all types
EXEC LRNMaster.dbo.usp_ReportRunIdInfoLog_Get @RunId = 'R20260803CRT0001', @LogType = 'Error';  -- errors only
EXEC LRNMaster.dbo.usp_ReportRunIdInfoLog_Get @RunId = 'R20260803CRT0001', @LogType = 'Error,Warning';

-- just your own report's entries
EXEC LRNMaster.dbo.usp_ReportRunIdInfoLog_Get
     @RunId = 'R20260803CRT0001', @ReportType = 'Denial Report';

-- errors across every lab today, newest first
EXEC LRNMaster.dbo.usp_ReportRunIdInfoLog_Get
     @LogType = 'Error', @FromDate = '2026-08-01', @Newest = 1;

-- counts per type as a second result set
EXEC LRNMaster.dbo.usp_ReportRunIdInfoLog_Get @RunId = 'R20260803CRT0001', @IncludeSummary = 1;
```

| Parameter | Default | Meaning |
|---|---|---|
| `@RunId` | `NULL` | one run; `NULL` = every run (pair with the dates) |
| `@LogType` | `NULL` | **`NULL` = every type.** One name, or a comma-separated list |
| `@ReportType` | `NULL` | e.g. `'Line Level'`, `'Denial Report'` |
| `@SourceSystem` | `NULL` | lab name, or `'SharePoint'` |
| `@FromDate` / `@ToDate` | `NULL` | on `CreatedOn`; `@ToDate` includes the whole day |
| `@Newest` | `0` | `1` = newest first |
| `@IncludeSummary` | `0` | `1` = second result set, count + first/last per type |

A misspelt `@LogType` is **rejected with an error** listing the types actually present. It does not
return an empty set — during triage, "no rows" and "no errors" must never look the same.

### `usp_ReportsWorkflowTracker_Pivot` — the dashboard

The tracker in the layout of `Reports_Workflow_Tracker_v1.0.xlsx`: one row per RunId + Lab, every
report type its own column, status as the value.

```sql
EXEC LRNMaster.dbo.usp_ReportsWorkflowTracker_Pivot;                            -- everything
EXEC LRNMaster.dbo.usp_ReportsWorkflowTracker_Pivot @RunId = 'R20260803CRT0001';
EXEC LRNMaster.dbo.usp_ReportsWorkflowTracker_Pivot @LabId = 18;
EXEC LRNMaster.dbo.usp_ReportsWorkflowTracker_Pivot @ShowBlankAs = 'Not Run';

-- one row per lab
EXEC LRNMaster.dbo.usp_ReportsWorkflowTracker_Pivot @Mode = 'Latest';        -- newest run, pass or fail
EXEC LRNMaster.dbo.usp_ReportsWorkflowTracker_Pivot @Mode = 'LatestSuccess'; -- newest clean run
```

`@Mode = 'Latest'` is "where does every lab stand right now"; `'LatestSuccess'` is "when was each lab
last good" — the run you compare a broken one against. A clean run has nothing `Failed` and at least
one `Success`; `Skipped` does not disqualify it. A lab missing from `'LatestSuccess'` has never had a
clean run in the window, which is itself worth knowing.

A blank cell means that report never wrote a tracker row for the run — **not** the same as a
failure. If your report's column is blank, it is not calling §2 yet.

---

## Checklist

- [ ] `Start` and `End` in `ReportRunIdInfoLog` for every report, every run — including failures
- [ ] `Error` with the full exception whenever something throws
- [ ] Exactly one `ReportsWorkflowTracker` row per report per run, `@ReportName` from §3
- [ ] `Skipped` with a reason when the report deliberately did not run
- [ ] `@CreatedBy` is your service name, not a person
- [ ] Logging wrapped so it can never fail your report
- [ ] `CreatedOn` never passed
