public sealed class ImportOptions
{
	public string WatchFolder { get; set; } = "";
	public string ArchiveFolder { get; set; } = "";
	public string ErrorFolder { get; set; } = "";
	public string PayerPolicyDataFile { get; set; } = "";
	public string SearchPattern { get; set; } = "*.xlsx";
	public int PollSeconds { get; set; } = 300;

	public string? SheetName { get; set; } = "LineLevel";
	public int HeaderRow { get; set; } = 1;

	public string DestinationTable { get; set; } = "dbo.BillingFrequency";
	public string FileStatusTable { get; set; } = "dbo.BillingFrequencyFileStatus";

	public List<LabFileMap> Labs { get; set; } = new();
	public SharePointOptions SharePoint { get; set; } = new();
}

public sealed class LabFileMap
{
	public int LabId { get; set; }

	// For local/manual drops into WatchFolder (optional)
	public string FilePattern { get; set; } = "";

	// SharePoint navigation per lab
	// If SharePoint.SharedFolderUrl is set, this path is treated as RELATIVE to that shared folder.
	// Otherwise, it is treated as RELATIVE to the drive root.
	public string SharePointRootPath { get; set; } = "";

	public string SharePointFilePattern { get; set; } = "*.xlsx";
}

public sealed class SharePointOptions
{
	public bool Enabled { get; set; } = false;

	public string TenantId { get; set; } = "";
	public string ClientId { get; set; } = "";
	public string ClientSecret { get; set; } = "";

	// Domain only, e.g. 3eclaimsprocessingllc.sharepoint.com
	// (Leave blank if you use SharedFolderUrl)
	public string Hostname { get; set; } = "";

	// e.g. /sites/3EClaimsProcessingLLC
	// (Leave blank if you use SharedFolderUrl)
	public string SitePath { get; set; } = "";

	// Document library name, usually "Documents"
	public string DriveName { get; set; } = "Documents";

	// Optional: move processed files on SharePoint
	public bool MoveToProcessed { get; set; } = false;
	public string? ProcessedFolderPath { get; set; } = null;

	// Optional: If you only have a SharePoint sharing URL (a long link like ...sharepoint.com/:f:/s/...),
	// put it here. If set, the worker will use the shared folder as the root for all Lab.SharePointRootPath values.
	public string? SharedFolderUrl { get; set; } = null;
}
