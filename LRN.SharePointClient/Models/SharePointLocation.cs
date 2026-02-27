namespace LRN.SharePointClient.Models;

/// <summary>
/// Identifies a SharePoint document library folder via Microsoft Graph.
/// </summary>
public record SharePointLocation(
    string SiteId,
    string DriveId,
    string FolderPath // path relative to drive root, no leading slash
);
