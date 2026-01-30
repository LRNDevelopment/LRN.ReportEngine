using System.Collections.Generic;

public sealed class ImportOptions
{
	// Download staging folder (SharePoint files downloaded here before splitting)
	public string WatchFolder { get; set; } = "";

	// Optional: keep for backward compatibility (not used for processed files now)
	public string ArchiveFolder { get; set; } = "";

	// If processing fails, the downloaded file is moved here for inspection
	public string ErrorFolder { get; set; } = "";

	public int PollSeconds { get; set; } = 300;

	// Comma-separated candidates. The first sheet that exists is used.
	// Example: "Master Line Level,Line Level,LineLevel,Master_Line_Level"
	public string? SheetName { get; set; } = "LineLevel";

	// Claim-level candidates (comma-separated). If empty, defaults are used in code.
	public string? ClaimSheetName { get; set; } = "Claim Level,ClaimLevel,Master Claim Level,Master_Claim_Level,Claim_Level";

	public int HeaderRow { get; set; } = 1;

	// Billing frequency feature toggle
	public bool EnableBillingFrequency { get; set; } = false;

	// DB settings (used only when EnableBillingFrequency=true)
	public string DestinationTable { get; set; } = "dbo.BillingFrequency";

	// File status table (tracks processed/error; prevents reprocessing)
	public string FileStatusTable { get; set; } = "dbo.BillingFrequencyFileStatus";

	// Output root for split reports:
	// \LabReportOutputs\Masters\{Lab}\Master\<Month>\<Latest date>\{ClaimLevel|LineLevel}
	public string ReportOutputsRoot { get; set; } = "";

	// If false, delete the downloaded staging file after successful processing
	public bool KeepDownloadedFiles { get; set; } = false;

	public List<LabFileMap> Labs { get; set; } = new();

	public SharePointOptions SharePoint { get; set; } = new();
}

public sealed class LabFileMap
{
	public int LabId { get; set; }

	// Folder name used in the output path ({Lab})
	public string LabName { get; set; } = "";

	// SharePoint lab root folder path under the selected Drive root (e.g. "Data Analysis/Certus/To Daryl/Master Data")
	public string SharePointRootPath { get; set; } = "";

	// Wildcard pattern to match the file inside the latest date folder (e.g. "Certus_Master File_*.xlsx")
	public string FilePattern { get; set; } = "*.xlsx";
	public string SharePointFilePattern { get; set; }
}

public sealed class SharePointOptions
{
	public bool Enabled { get; set; } = false;

	// App-only auth (Client Credentials)
	public string TenantId { get; set; } = "";
	public string ClientId { get; set; } = "";
	public string ClientSecret { get; set; } = "";

	// Graph site/drive mode
	public string Hostname { get; set; } = "";   // e.g. "3eclaimsprocessingllc.sharepoint.com"
	public string SitePath { get; set; } = "";   // e.g. "/sites/3EClaimsProcessingLLC"
	public string DriveName { get; set; } = "Documents";

	// Optional: move processed file in SharePoint (NOT local archive)
	public bool MoveToProcessed { get; set; } = false;
	public string? ProcessedFolderPath { get; set; } = null;
}
