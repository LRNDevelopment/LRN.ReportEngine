public sealed class ImportOptions
{
	public string WatchFolder { get; set; } = "";
	public string ArchiveFolder { get; set; } = "";
	public string ErrorFolder { get; set; } = "";
	public int PollSeconds { get; set; } = 300;

	public string? SheetName { get; set; } = "Master Line Level";
	public int HeaderRow { get; set; } = 1;

	public string DestinationTable { get; set; } = "dbo.BillingFrequency";

	// Processed/Error tracking table (no identity needed)
	public string FileStatusTable { get; set; } = "dbo.BillingFrequencyFileStatus";

	public SharePointOptions SharePoint { get; set; } = new();
	public List<LabFileMap> Labs { get; set; } = new();
}

public sealed class LabFileMap
{
	public int LabId { get; set; }

	// Example: "Data Analysis/Inhealth & DTR"
	// The downloader will navigate: <Root>/<CurrentYear>/<LatestMonth>/<LatestDateRange>/
	public string SharePointRootPath { get; set; } = "";

	// Example: "InHealth*.xlsx" or "Cove*.xlsx"
	public string SharePointFilePattern { get; set; } = "*.xlsx";
}

public sealed class SharePointOptions
{
	public bool Enabled { get; set; }

	// App-only auth (Client Secret)
	public string TenantId { get; set; } = "";
	public string ClientId { get; set; } = "";
	public string ClientSecret { get; set; } = "";

	// Site/Drive
	public string Hostname { get; set; } = ""; // e.g. "3eclaimsprocessingllc.sharepoint.com" (domain only)
	public string SitePath { get; set; } = ""; // e.g. "/sites/3EClaimsProcessingLLC"
	public string DriveName { get; set; } = "Documents";

	// Optional: move successfully loaded files to a processed folder
	public bool MoveToProcessed { get; set; }
	public string? ProcessedFolderPath { get; set; } = null; // e.g. "Data Analysis/Processed/BillingFreq"
}
