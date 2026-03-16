namespace LRN.SharePointClient.Models;

public sealed class SharePointPublishedFile
{
	public string? FileName { get; set; }
	public string? LocalPath { get; set; }
	public string? RelativeSharePointPath { get; set; }
	public string? WebUrl { get; set; }       // driveItem.webUrl
	public string? ShareLinkUrl { get; set; } // createLink().link.webUrl

	public string? NotificationUrl =>
		!string.IsNullOrWhiteSpace(ShareLinkUrl) ? ShareLinkUrl :
		!string.IsNullOrWhiteSpace(WebUrl) ? WebUrl :
		LocalPath;
}