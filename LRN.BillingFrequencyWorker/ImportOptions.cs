public sealed class ImportOptions
{
	public string WatchFolder { get; set; } = "";
	public string ArchiveFolder { get; set; } = "";
	public string ErrorFolder { get; set; } = "";
	public string SearchPattern { get; set; } = "*.xlsx";
	public int PollSeconds { get; set; } = 60;

	public string? SheetName { get; set; } = "LineLevel";
	public int HeaderRow { get; set; } = 1;

	public string DestinationTable { get; set; } = "dbo.BillingCounts";
	public List<LabFileMap> Labs { get; set; } = new();
}

public sealed class LabFileMap
{
	public int LabId { get; set; }
	public string FilePattern { get; set; } = ""; // wildcard pattern
}
