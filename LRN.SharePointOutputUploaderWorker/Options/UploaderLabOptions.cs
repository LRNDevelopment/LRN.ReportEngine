using LRN.SharePointClient.Models;

namespace LRN.SharePointOutputUploaderWorker.Options;

public sealed class UploaderLabOptions
{
    public int LabId { get; set; }
    public string LabName { get; set; } = string.Empty;

    public SharePointLocation Output { get; set; } = new SharePointLocation("", "", "");
    public SharePointLocation Logs { get; set; } = new SharePointLocation("", "", "");
}
