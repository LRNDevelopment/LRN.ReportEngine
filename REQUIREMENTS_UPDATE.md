# Requested Changes Summary (Feb 18, 2026)

This update implements:

1) SharePoint output + logging folder structure (YYYY/MMM/DD)  
2) “Newest date first” input selection from SharePoint (fallback to previous dates)  
3) Splitting the solution into **two independent worker processors**:
   - **Master File Processor** (creates ClaimLevel + LineLevel outputs + logs + uploads)
   - **Billing Frequency Processor** (builds Billing Frequency list from the generated LineLevel CSV, loads it to SQL, and writes a BillingFrequency CSV locally)

---

## 1) SharePoint Output Upload (Payer Policy Validation Report)

**Destination SharePoint folder (root):**
- `10. Automation/LRN-Output/Payer Policy Validation Report/Lab`

**Folder structure under that root:**
- `YYYY/<MM.MMM>/<MM.dd.yyyy>/`

**Files inside the day folder:**
- `<Lab>_ClaimLevel.csv`
- `<Lab>_LineLevel.csv`

Example:
- `2026/02.Feb/02.18.2026/Cove_ClaimLevel.csv`
- `2026/02.Feb/02.18.2026/Cove_LineLevel.csv`

---

## 2) Master Processor Daily Log Upload

**Destination SharePoint folder:**
- `10. Automation/LRN-Logs/Master File Processor`

**Daily file name format:**
- `Master_File_Processor_Log_<ddMMMyyyy>.csv`

Example:
- `Master_File_Processor_Log_18Feb2026.csv`

---

## 3) Local Server Output Folder Structure

The server does **not** create separate `ClaimLevel/` and `LineLevel/` folders.

Local output is written to:
- `<ReportOutputsRoot>/Output/YYYY/<MM.MMM>/<MM.dd.yyyy>/`

and the two CSV files are saved directly in that folder.

---

## 4) Input File Selection Logic (SharePoint)

When reading master files from SharePoint for processing:
- Start from the newest date folder in the newest month
- If the newest date folder does not contain a matching file, automatically check previous date folder(s) until a match is found

---

## 5) Worker Split (Two Independent Worker Processors)

### A) Master File Processor Worker
**Project:**
- `LRN.MasterFileProcessorWorker`

**Purpose:**
- Downloads the latest master file from SharePoint (newest date folder first, fallback to prior dates)
- Validates schemas (ClaimLevel + LineLevel)
- Generates standardized:
  - `<Lab>_ClaimLevel.csv`
  - `<Lab>_LineLevel.csv`
- Uploads the two outputs to SharePoint output folder
- Writes + uploads daily master processor log (`Master_File_Processor_Log_<ddMMMyyyy>.csv`)
- Writes file status log (local + optional SharePoint upload)

**Config section used (NEW):**
- `MasterFileProcessor`

(Backward compatible fallback: `BillingFrequency`)

### B) Billing Frequency Processor Worker
**Project:**
- `LRN.BillingFrequencyWorker`

**Purpose:**
- Finds the **latest generated** `<Lab>_LineLevel.csv` under:
  - `<ReportOutputsRoot>/Output/**/<Lab>_LineLevel.csv`
- Builds Billing Frequency list
- Loads it to SQL (`DestinationTable`)
- Writes a local CSV next to the LineLevel file:
  - `<Lab>_BillingFrequency.csv`

**Config section used (NEW):**
- `BillingFrequencyProcessor`

(Backward compatible fallback: `BillingFrequency`)

---

## 6) Separate Uploader Project (Optional)

**Project:**
- `LRN.SharePointUploader`

It scans local outputs on the server and uploads them to the required SharePoint paths.  
Use this if you want to decouple “processing” from “uploading” (schedule them separately).

---

## Config Key Mapping (Important)

Under the SharePoint config object, the worker code expects:

- `UploadOutputs` (bool)
- `OutputUploadFolderPath` (string)
- `UploadMasterProcessorLog` (bool)
- `MasterProcessorLogUploadFolderPath` (string)
- `FileStatusLogUploadFolderPath` (string)

