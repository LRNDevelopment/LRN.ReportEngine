namespace DenialDatabaseProcessorWorker.Models;

public sealed class LabConfig
{
    public string LabName { get; init; } = "";
    public int LabId { get; init; }

    public string PayerPolicyFile { get; init; } = "";
    public string ClaimActionMapper { get; init; } = "";

    public string PolicyActionMapper { get; init; } = "";

    /// <summary>
    /// A SharePoint folder link (often AllItems.aspx?id=...).
    /// The worker extracts the 'id=' folder path and uploads under it.
    /// </summary>
    public string SharePointUploadPath { get; init; } = "";
}
