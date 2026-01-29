# Billing Frequency Worker (SharePoint-driven)

## Flow (per lab)
1. Lab SharePoint root path (configured)
2. Go to **current year** folder (fallback to latest year if current missing)
3. Inside year, pick the **latest month** folder
4. Inside month, pick the **latest date-range** folder
5. Inside date-range, pick the latest file matching `SharePointFilePattern`
6. Skip if already **PROCESSED** for (LabId + ItemId + ETagKey)
7. Download to server `WatchFolder`, extract, group, and load to SQL
8. Mark file status row as PROCESSED or ERROR

## One-time SQL
Run:
`sql/Create_BillingFrequencyFileStatus.sql`

## Logging
When installed as a Windows Service, logs appear in:
Event Viewer → Windows Logs → Application

## Notes
- `MoveToProcessed=true` will move the SharePoint file after success (requires Graph write permissions).
