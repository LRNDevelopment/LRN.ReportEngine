public sealed class ImportOptions
{
    // Local staging download folder
    public string WatchFolder { get; set; } = "";

    // Where to move a bad XLSX (and error txt) so it won't keep retrying
    public string ErrorFolder { get; set; } = "";

    // Root for outputs:
    // \LabReportOutputs\Masters\{Lab}\Master\<Month>\<LatestDate>\(ClaimLevel|LineLevel)
    public string ReportOutputsRoot { get; set; } = "";

    // If true, keep the downloaded XLSX in WatchFolder after processing (useful for debugging)
    public bool KeepDownloadedFiles { get; set; } = false;

    // Poll interval
    public int PollSeconds { get; set; } = 60;

    // Sheet candidates (comma separated). Worker picks first one that exists.
    // Example: "Master Line Level,Line Level,LineLevel,Master_Line_Level"
    public string SheetName { get; set; } = "Master Line Level,Line Level,LineLevel,Master_Line_Level";

    // Claim sheet candidates
    public string ClaimSheetName { get; set; } = "Claim Level,ClaimLevel,Master Claim Level,Master_Claim_Level,Claim_Level";

    // Header row for schema validator & billing-frequency reader
    public int HeaderRow { get; set; } = 1;

    // Optional billing frequency (can be enabled later)
    public bool EnableBillingFrequency { get; set; } = false;
    public string DestinationTable { get; set; } = "dbo.BillingFrequency";

    // Processed status table (SQL)
    public string FileStatusTable { get; set; } = "dbo.BillingFrequencyFileStatus";

    // Schema JSON (relative paths are resolved from AppContext.BaseDirectory)
    public string LineLevelSchemaJsonPath { get; set; } = "Schemas/LineLevel.schema.json";
    public string ClaimLevelSchemaJsonPath { get; set; } = "Schemas/ClaimLevel.schema.json";

    public SharePointOptions SharePoint { get; set; } = new();

    public List<LabFileMap> Labs { get; set; } = new();
}

public sealed class SharePointOptions
{
    public bool Enabled { get; set; } = false;

    // Graph app-only authentication
    public string TenantId { get; set; } = "";
    public string ClientId { get; set; } = "";
    public string ClientSecret { get; set; } = "";

    // Example:
    // Hostname: "3eclaimsprocessingllc.sharepoint.com"
    // SitePath: "/sites/3EClaimsProcessingLLC"
    public string Hostname { get; set; } = "";
    public string SitePath { get; set; } = "";

    // Drive name (often "Documents")
    public string DriveName { get; set; } = "Documents";

    // OPTIONAL: move processed file to a processed folder
    public bool MoveToProcessed { get; set; } = false;
    public string? ProcessedFolderPath { get; set; }
}

public sealed class LabFileMap
{
    public int LabId { get; set; }
    public string LabName { get; set; } = "";

    // SharePoint root path for this Lab (relative to drive root, no leading slash)
    // Example: "Data Analysis/Certus/To Daryl/Master Data"
    public string SharePointRootPath { get; set; } = "";

    // File pattern inside the latest date folder (wildcards)
    // Example: "Certus_Master File_*.xlsx"
    public string SharePointFilePattern { get; set; } = "*.xlsx";

    // Optional per-lab schema overrides (relative to app base)
    public string? LineLevelSchemaJsonPath { get; set; }
    public string? ClaimLevelSchemaJsonPath { get; set; }
}
