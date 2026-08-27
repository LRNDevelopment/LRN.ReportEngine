# Type Reconciliation — Line Level / Claim Level bulk copy

Requirement 7 of the import rework. For every mapped field this compares three declarations:

| Source | What it says |
|---|---|
| **Spreadsheet** | `services/LRN.MasterFileProcessorWorker/Schemas/ClaimLevelLineLevel_Fields.xlsx`, column `Type` |
| **Source schema** | the value actually produced in the standardized CSV, i.e. always **text** |
| **Target** | the column type in the generated `sql/Labs/**` DDL |

Generated tables come from `sql/generate_sql.py`. Re-run it after changing a lab mapping.

---

## A. Audit block — resolved

The nine audit columns are defined once, in `BulkLoad/AuditColumns.cs`, and the generator reads that
same list. Names, types and order are therefore identical across every lab and both levels.

| Column | Spreadsheet | Chosen target | Reason |
|---|---|---|---|
| `FileLogId` | `nvarchar` | `BIGINT NOT NULL` | **Changed.** It is a foreign key to `dbo.LineClaimFileLogs.FileLogId`, which is an identity column. Storing a key as text would prevent the join and the index from being used. |
| `RunId` | `nvarchar` | `VARCHAR(30) NOT NULL` | Sized to match `dbo.LRN_Run_Log.RunID varchar(30)` in `sql/Create_ProcessLogs.sql` — the only authoritative RunId type in the repo. Observed values (`20260724R0044`) are 13 chars. The brief sketched `VARCHAR(50)`; FK-compatibility with the existing table wins. |
| `WeekFolder` | `nvarchar` | `NVARCHAR(200) NULL` | Values like `7/24/2026 - 07/28/2026`. |
| `SourceFullPath` | `nvarchar` | `NVARCHAR(1000) NULL` | SharePoint server-relative paths are long. |
| `FileName` | `nvarchar` | `NVARCHAR(400) NULL` | |
| `FileType` | `nvarchar` | `VARCHAR(20) NOT NULL` | Closed set: `Line Level` / `Claim Level`. ASCII only. |
| `RowHash` | `nvarchar` | `CHAR(64) NOT NULL` | **Changed.** SHA-256 lower-case hex is exactly 64 ASCII chars. Fixed-width `CHAR` halves the storage of `NVARCHAR(64)` and makes the dedupe index materially smaller. |
| `LabID` | `nvarchar` | `INT NOT NULL` | **Changed.** Joins `LRNMaster.dbo.LabMaster.LabId`, which is `int`. |
| `LabName` | `nvarchar` | `NVARCHAR(200) NOT NULL` | |

> ### ⚠ A1 — Unverified assumption
> `dbo.LineClaimFileLogs` has no DDL anywhere in the repo, so its real column types could not be
> read. The types above are inferred from how the columns are used. **Before deploying, run
> `sp_help 'dbo.LineClaimFileLogs'` on one lab database and confirm.** If any differ, correct
> `BulkLoad/AuditColumns.cs` and re-run `sql/generate_sql.py` — that is the only edit needed.

---

## B. Business columns — deliberately left as text

The spreadsheet declares **`nvarchar` for ~95% of all columns**, including every money, date and
count field. The only non-`nvarchar` declarations in the whole workbook are `RecordId int` and
`InsertedDateTime datetime` (plus `InsuranceBalance_Decimal decimal` on some claim sheets).

The brief asks for "the widest lossless type". For a value arriving from a **text CSV**, the widest
lossless type *is* `NVARCHAR`. Converting `ChargeAmount` to `DECIMAL(19,4)` is a **narrowing** change:
any row where that CSV cell holds `""`, `"N/A"`, `"1,234.00"` or `"$37"` would fail the load. So the
generated landing tables keep `NVARCHAR`, and the typed columns below are **proposed, not applied**.

This is a reversible decision. `sql/generate_sql.py` already maps `decimal` → `DECIMAL(19,4)`,
`int` → `INT` and `date`/`datetime` → `DATETIME2(3)`; changing the spreadsheet's declared type is all
that is needed to switch a column over.

### B1 — Recommended typed columns (currency)

Per the brief, `DECIMAL(19,4)` — never `MONEY` (4-dp fixed, no rounding control) or `FLOAT`
(binary, cannot represent `0.10` exactly).

`ChargeAmount`, `ChargeAmountPerUnit`, `AllowedAmount`, `AllowedAmountPerUnit`, `InsurancePayment`,
`InsurancePaymentPerUnit`, `PatientPayment`, `PatientPaymentPerUnit`, `TotalPayments`,
`InsuranceAdjustments`, `PatientAdjustments`, `TotalAdjustments`, `InsuranceBalance`,
`PatientBalance`, `PatientBalancePerUnit`, `TotalBalance`, `ClaimAmount`, `MedicareFee`

### B2 — Recommended typed columns (dates)

`DATE` where no time component exists, else `DATETIME2(3)`.

`DateofService`, `ChargeEnteredDate`, `FirstBilledDate`, `CheckDate`, `PostingDate`, `DenialDate`,
`ProcInsResponsibleCarrierOriginalFilingDate`, `ProcInsLastRefiledDeniedDate`

⚠ `ExpectedPaymentMonth` and `EnteredWeek` / `BilledWeek` / `PostedWeek` look date-like but hold
period labels (`Apr'25`, `7/24/2026 - 07/28/2026`). They **must stay text**.

### B3 — Recommended typed columns (integers)

`Units`, `DaystoDOS`, `DaystoBill`, `DaystoPost`, `ICDPointer`

⚠ `RollingDays` is a **bucket label** (`Rolling90`, `Rolling180`, `YTD`), not a number — despite the
name. Keep as text. `CptWithUnits` is `80053*1` — text.

### B4 — Columns that must stay `VARCHAR`/`NVARCHAR` whatever they look like

These are the traps the brief called out, confirmed present in this data:

| Column | Why it is not numeric |
|---|---|
| `CPTCode` | `80053`, but also `G0480`, `0016M` — alphanumeric HCPCS/PLA codes |
| `ICDCode`, `CombinedLineLevelICD`, `CoveredIcd10CodesBilled` | `E11.42`, and multi-value lists |
| `DenialCode`, `UpdatedDenialCode`, `CombinedLineLevelDenialCode` | `CO-45`, `PR1`, and `;`-joined lists |
| `PatientID`, `AccessionNumber`, `ClaimID`, `SubscriberId` | leading-zero identifiers; numeric typing silently drops the zeros |
| `Modifier` | `26`, `59`, `TC`, and `59,26` pairs |
| `POS`, `TOS` | leading-zero place-of-service codes (`01`, `11`) |
| `Payer_Code`, `Global_Payer_ID` | opaque identifiers |

### B5 — `BIT` vs `CHAR(1)` flags

`T_F` is the only flag-shaped column; the sample carries `1`/`0`. It is **not** typed `BIT` because
its domain has not been confirmed — a third value would fail the load. Left `NVARCHAR(255)`.

### B6 — `NVARCHAR` vs `VARCHAR` consistency

All business columns are `NVARCHAR`. The lab data contains patient and provider names of unknown
origin, and the cost of Unicode is far lower than the cost of mangling one. Only closed-domain,
provably-ASCII columns are `VARCHAR`: `RunId`, `FileType`, `RowHash`.

### B7 — Lengths

The spreadsheet declares no length, so sizes come from the column's role
(`sql/generate_sql.py`, `LONG_1000` / `LONG_500`):

| Pattern | Size |
|---|---|
| path, remark, comment, reason, description, codes, icd, address, notes | `NVARCHAR(1000)` |
| name, provider, clinic, panel, payer, status, category, action | `NVARCHAR(500)` |
| everything else | `NVARCHAR(255)` |

⚠ These are estimates, not measurements. If a real export overflows one, the load fails loudly
(string-truncation error) rather than silently truncating — adjust the pattern and regenerate.

---

## C. Completeness gaps (Requirement 8)

Every column in the spreadsheet must exist in the target table. Comparing each lab JSON's
`SqlColumn` list against its spreadsheet sheet (excluding the pipeline-owned `RecordId`, the nine
audit columns and `InsertedDateTime`):

### C1 — Complete: bulk copy **enabled**

| Lab | Claim | Line | Note |
|---|---|---|---|
| Beech_Tree | ✅ | ✅ | |
| Elixir | ✅ | ✅ | |
| PCR Labs of America | ✅ | ✅ | |
| Rising Tides | ✅ | ✅ | |
| NorthWest | `InsuranceBalance_Decimal` | ✅ | derived column, see C3 |
| Certus | `InsuranceBalance_Decimal` | ✅ | derived column, see C3 |
| Augustus | `InsuranceBalance_Decimal` | ✅ | derived column, see C3 |

### C2 — Incomplete: bulk copy **disabled** pending the missing `CsvHeader` values

`BulkCopyToTable: false` in these JSONs, with a `_comment` pointing here. They are configured and
inert — the worker logs an informational skip and moves on.

| Lab | Level | Missing | Columns |
|---|---|---|---|
| Cove | Claim | 25 | `Aging`, `LISPatientName`, `PanelType`, `EnteredWeek`, `EnteredStatus`, `LastActivityDate`, `EmedixSubmissionDate`, `ClaimType`, `BilledStatus`, `PostedWeek`, `ModField`, `CheqNo`, `DuplicatePaymentPosted`, `ActualPayment`, `ProcTotalBal`, `DeniedStatus`, `ScrubberEditReason`, `EmedixRejectionDate`, `EmedixRejection`, `RejectionCategory`, `TimeToPay`, `Adjudicated`, `AdjudicatedAmount`, `Bucket30`, `Bucket60` |
| InHealthDTR | Claim | 6 | `DOE_Year`, `DOE_Month`, `AgingBucket`, `BilledUnbilled`, `CPTCode`, `Units` |
| InHealthDTR | Line | 3 | `PostingDate`, `CPTUnits`, `PostedWeek` |
| PhiLife | Claim | 43 | `UID`, `LISPatientName`, `SubscriberId`, `PanelType`, `EnteredWeek`, `EnteredStatus`, `LastActivityDate`, `EmedixSubmissionDate`, `ClaimType`, `BilledStatus`, `ModField`, `CheqNo`, `DuplicatePaymentPosted`, `ActualPayment`, `ProcTotalBal`, `DeniedStatus`, `ScrubberEditReason`, `EmedixRejectionDate`, `EmedixRejection`, `RejectionCategory`, `TimeToPay`, `Adjudicated`, `Bucket30`, `Bucket30Amount`, `Bucket60`, `Bucket60Amount`, `CPTCode`, `Units`, `ChargeAmountPerUnit`, `AllowedAmountPerUnit`, `InsurancePaymentPerUnit`, `PatientPaymentPerUnit`, `PatientBalancePerUnit`, `PaymentPostedDate`, `PayStatus`, `DenialDate`, `ResponsibleParty`, `EndDOS`, `BillOccurance`, `EntryUser`, `CPTUnits`, `CPTMOD`, `CPTs` |
| PhiLife | Line | 34 | `PostingDate`, `UID`, `T_F`, `CombinedLineLevelICD`, `ClaimAmount`, `CptWithUnits`, `Proc`, `EnteredStatus`, `BilledStatus`, `ProcTotalBal`, `UpdatedDenialCode`, `CombinedLineLevelDenialCode`, `Loc`, `ProcInsLastRefiledDeniedReason`, `ProcInsResponsibleCarrierOriginalFilingDate`, `ProcInsStatus`, `ProcInsLastRefiledDeniedDate`, `CPTCodeXUnitsXModifierOrginal`, `CPTCodeXUnitsXModifier`, `BilledUnbilled`, `PaymentPercent`, `Aging`, `AgingBucket`, `BilledWeek`, `FullyPaidCount`, `FullyPaidAmount`, `AdjudicatedCount`, `AdjudicatedAmount`, `Days30Count`, `Days30Amount`, `Days60Count`, `Days60Amount`, `DOE_Year`, `DOE_Month` |

**To enable one of these labs:** add the missing `{ "CsvHeader": ..., "SqlColumn": ..., "IncludeInHash": ... }`
entries to its JSON, add the lab to `LABS` in `sql/generate_sql.py`, re-run the generator, deploy the
new script, then set `BulkCopyToTable: true`.

### C3 — `InsuranceBalance_Decimal`

Present on the NorthWest / Certus / Augustus **claim** sheets only, declared `decimal`. It is a
derived numeric copy of `InsuranceBalance`, not a CSV column, so there is no `CsvHeader` to map. It is
**not** created by the generator. If it is needed, add it as a computed column:

```sql
ALTER TABLE dbo.ClaimLevelData
    ADD InsuranceBalance_Decimal AS TRY_CONVERT(DECIMAL(19,4), InsuranceBalance) PERSISTED;
```

---

## D. CSV ↔ mapping disagreements (gap G4)

Independent of typing, these mappings do not line up with what the exporter actually writes. Each one
silently produces a `NULL` column or drops data. The loader now logs both directions at `Warning`
into `ReportRunIdInfoLog` on every run, so they surface immediately.

| Lab / level | JSON expects `CsvHeader` | Exporter actually writes | Effect |
|---|---|---|---|
| NWL line | `Posting Date` | `Payment Posted Date` | `PostingDate` loads NULL |
| NWL line | `Claim amount` | *(nothing — consumed as a built-in alias of `ChargeAmount`)* | `ClaimAmount` loads NULL |
| NWL line | — | `LineLevelUID` | dropped, no mapping |
| NWL line | — | `Source` | dropped, no mapping — this is the Webpm/Daq system label |

⚠ `Proc-Ins Responsible Carrier Original Filing Date`, `Proc-Ins Status` and
`Proc-Ins Last Refiled/Denied Date` are mapped in the NWL JSON but were absent from the reconstructed
header used for this analysis. **Confirm against a real export before trusting them.**

`Source` is worth fixing first: for NorthWest it is the only thing distinguishing Webpm rows from Daq
rows in the loaded table.

---

## E. RowHash (§5.3)

Implemented in `BulkLoad/RowHasher.cs`, reusing the repo's **existing** `IncludeInHash` convention
rather than introducing a new one.

- Business columns only, in lab-JSON order. Audit block, `RecordId` and `InsertedDateTime` excluded.
- Trim → invariant upper-case; numbers re-formatted invariantly (`1.50` ≡ `1.5`); dates as `yyyy-MM-dd`.
- `NULL`/empty → sentinel `U+00A0`; fields joined with `U+001F` (unit separator) — neither can occur in the CSV.
- SHA-256, lower-case hex, stored `CHAR(64)`.

⚠ The order is fixed by the JSON. **Appending** fields is safe; **reordering or removing** a hashed
field changes every hash. `CsvRowHash` (a separate spreadsheet column) is *not* this value and is
loaded as-is from the CSV.

---

## F. Timestamps

**IST throughout**, matching `ProcessLogService.NowIST()` and the rest of this pipeline.
`ReportRunIdInfoLog.CreatedOn` and `ReportsWorkflowTracker.CreatedOn` are written by the application
in IST; the `SYSDATETIME()` defaults on those columns are a server-local fallback only and are not
used on the normal path.
