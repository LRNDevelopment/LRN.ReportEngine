using System.ComponentModel.DataAnnotations;

public sealed class SharePointSynchronizerOptions
{
    public bool Enabled { get; set; } = true;
    public int PollSeconds { get; set; } = 60;
    public List<SharePointSyncItem> Items { get; set; } = new();
}

public sealed class SharePointSyncItem
{
    [Required]
    public string Name { get; set; } = "DefaultSync";

    // Local folder to monitor / download into
    [Required]
    public string ServerPath { get; set; } = "";

    // Wildcard pattern, e.g. Beech Tree_PayerPolicy*.xlsx
    [Required]
    public string FileName { get; set; } = "*.*";

    // SharePoint folder path under the drive root (or under configured root if your downloader resolves that)
    [Required]
    public string SharePointFolder { get; set; } = "";

    // Local -> SharePoint
    public bool UploadNewServerFilesToSharePoint { get; set; } = true;

    // SharePoint -> Local (master-file refresh)
    public bool DownloadLatestSharePointFileToServer { get; set; } = true;

    // When SharePoint has a newer file and local file exists, rename local to obsolete_<timestamp>_<name>
    public bool RenameExistingLocalAsObsolete { get; set; } = true;
}
