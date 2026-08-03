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

---

## 1. `usp_ReportRunIdInfoLog_Insert`

Your running commentary: started, row counts, warnings, failures, finished.

```sql
EXEC dbo.usp_ReportRunIdInfoLog_Insert
     @RunId          = '20260801R0003',
     @ReportType     = 'Denial Report',
     @SourceSystem   = 'Certus',
     @SourceFileName = '20260801R0003_Certus_Denial_07.20.2026.csv',
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
DECLARE @RunId varchar(30) = '20260801R0003';

EXEC dbo.usp_ReportRunIdInfoLog_Insert @RunId, 'Denial Report', 'Certus',
     '20260801R0003_Certus_Denial.csv', 'Start', 'Denial Report started.', 'MyService';

EXEC dbo.usp_ReportRunIdInfoLog_Insert @RunId, 'Denial Report', 'Certus',
     '20260801R0003_Certus_Denial.csv', 'Info',  'Read 60,625 source rows.', 'MyService';

EXEC dbo.usp_ReportRunIdInfoLog_Insert @RunId, 'Denial Report', 'Certus',
     '20260801R0003_Certus_Denial.csv', 'Warning', '12 rows had no payer code.', 'MyService';

EXEC dbo.usp_ReportRunIdInfoLog_Insert @RunId, 'Denial Report', 'Certus',
     '20260801R0003_Certus_Denial.csv', 'End',   'Denial Report finished in 41s.', 'MyService';
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
     @RunId       = '20260801R0003',
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
| `@WeekFolder` | `varchar(200)` | | Same. |

**You do not pass LabId, LabName or WeekFolder.** They are read from `dbo.LRN_Run_Log` by `RunId`,
and `ReportTypeId` from `dbo.ReportTypeMaster` by `@ReportName`.

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

Use these **exactly** in `@ReportName`. All 13 are active.

| Id | ReportTypeName | | Id | ReportTypeName |
|---:|---|---|---:|---|
| 1 | `Claim Level Master` | | 8 | `Line Level Master` |
| 2 | `Clinic Summary` | | 9 | `LIS Summary` |
| 3 | `Coding Validation` | | 10 | `Payer Policy Validation` |
| 4 | `Collection Summary` | | 11 | `Prediction Analysis` |
| 5 | `Denial Report` | | 12 | `Production Summary` |
| 6 | `Executive Summary` | | 13 | `Sales Rep Summary` |
| 7 | `Forecasting` | | | |

Always current:

```sql
SELECT ReportTypeId, ReportTypeName FROM LRNMaster.dbo.ReportTypeMaster
WHERE IsActive = 1 ORDER BY ReportTypeName;
```

Need a name that is not listed? Ask for it to be added to `ReportTypeMaster` — do not invent one, the
tracker will reject it.

### One call per report

```sql
EXEC dbo.usp_ReportsWorkflowTracker_Upsert @RunId='20260801R0003', @ReportName='Line Level Master',       @Status='Success', @RowCount=195161, @CreatedBy='MyService';
EXEC dbo.usp_ReportsWorkflowTracker_Upsert @RunId='20260801R0003', @ReportName='Claim Level Master',      @Status='Success', @RowCount=60625,  @CreatedBy='MyService';
EXEC dbo.usp_ReportsWorkflowTracker_Upsert @RunId='20260801R0003', @ReportName='LIS Summary',             @Status='Success', @CreatedBy='MyService';
EXEC dbo.usp_ReportsWorkflowTracker_Upsert @RunId='20260801R0003', @ReportName='Production Summary',      @Status='Success', @CreatedBy='MyService';
EXEC dbo.usp_ReportsWorkflowTracker_Upsert @RunId='20260801R0003', @ReportName='Collection Summary',      @Status='Success', @CreatedBy='MyService';
EXEC dbo.usp_ReportsWorkflowTracker_Upsert @RunId='20260801R0003', @ReportName='Denial Report',           @Status='Success', @CreatedBy='MyService';
EXEC dbo.usp_ReportsWorkflowTracker_Upsert @RunId='20260801R0003', @ReportName='Executive Summary',       @Status='Success', @CreatedBy='MyService';
EXEC dbo.usp_ReportsWorkflowTracker_Upsert @RunId='20260801R0003', @ReportName='Clinic Summary',          @Status='Success', @CreatedBy='MyService';
EXEC dbo.usp_ReportsWorkflowTracker_Upsert @RunId='20260801R0003', @ReportName='Sales Rep Summary',       @Status='Success', @CreatedBy='MyService';
EXEC dbo.usp_ReportsWorkflowTracker_Upsert @RunId='20260801R0003', @ReportName='Coding Validation',       @Status='Success', @CreatedBy='MyService';
EXEC dbo.usp_ReportsWorkflowTracker_Upsert @RunId='20260801R0003', @ReportName='Payer Policy Validation', @Status='Success', @CreatedBy='MyService';
EXEC dbo.usp_ReportsWorkflowTracker_Upsert @RunId='20260801R0003', @ReportName='Forecasting',             @Status='Success', @CreatedBy='MyService';
EXEC dbo.usp_ReportsWorkflowTracker_Upsert @RunId='20260801R0003', @ReportName='Prediction Analysis',     @Status='Success', @CreatedBy='MyService';
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

```sql
-- your progress trail for a run
SELECT CreatedOn, LogType, ReportType, SourceSystem, SourceFileName, LogMessage
FROM   LRNMaster.dbo.ReportRunIdInfoLog
WHERE  RunId = '20260801R0003'
ORDER BY ReportRunIdInfoLogId;

-- the dashboard row
SELECT LabName, ReportName, Status, [RowCount], StartedOn, CompletedOn, Remarks
FROM   LRNMaster.dbo.ReportsWorkflowTracker
WHERE  RunId = '20260801R0003'
ORDER BY ReportName;

-- everything for a run, laid out like the tracker spreadsheet
SELECT * FROM LRNMaster.dbo.vw_ReportsWorkflowTracker_Wide
WHERE  [RunID] = '20260801R0003';

-- errors across all labs today
SELECT RunId, ReportType, SourceSystem, LogMessage
FROM   LRNMaster.dbo.ReportRunIdInfoLog
WHERE  LogType = 'Error' AND CreatedOn >= CAST(GETDATE() AS date)
ORDER BY CreatedOn DESC;
```

---

## Checklist

- [ ] `Start` and `End` in `ReportRunIdInfoLog` for every report, every run — including failures
- [ ] `Error` with the full exception whenever something throws
- [ ] Exactly one `ReportsWorkflowTracker` row per report per run, `@ReportName` from §3
- [ ] `Skipped` with a reason when the report deliberately did not run
- [ ] `@CreatedBy` is your service name, not a person
- [ ] Logging wrapped so it can never fail your report
- [ ] `CreatedOn` never passed
