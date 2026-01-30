using Azure.Core;
using Azure.Identity;
using Common.Logging;
using Microsoft.Extensions.Logging;
using Microsoft.Extensions.Options;
using System.Net.Http.Headers;
using System.Text.Json;
using System.Text.RegularExpressions;

public sealed class SharePointDownloader
{
	private readonly HttpClient _http;
	private readonly ILoggerService _logger;
	private readonly ImportOptions _opt;

	private string? _siteId;
	private string? _driveId;

	public SharePointDownloader(HttpClient http, IOptions<ImportOptions> opt, ILoggerService logger)
	{
		_http = http;
		_opt = opt.Value;
		_logger = logger;
	}

	public sealed record SelectedFile(
		int LabId,
		string DriveId,
		string ItemId,
		string Name,
		string ETagKey,
		DateTimeOffset? LastModifiedUtc,
		string SharePointPath);

	public async Task<SelectedFile?> TryGetLatestFileForLabAsync(LabFileMap lab, int currentYear, CancellationToken ct)
	{
		if (!_opt.SharePoint.Enabled) return null;

		await EnsureGraphAuthAsync(ct);

		_siteId ??= await GetSiteIdAsync(ct);
		_driveId ??= await GetDriveIdAsync(_siteId!, ct);

		// 1) Lab root folder
		var labRootId = await GetItemIdByPathAsync(_driveId!, lab.SharePointRootPath, ct);

		// 2) Year folder (prefer current year; fallback to latest year)
		var yearChildren = await ListChildrenPagedAsync(_driveId!, labRootId, ct);
		var yearFolder = yearChildren
			.Where(x => x.IsFolder)
			.Select(x => new { Item = x, Year = TryParseYearFolder(x.Name) })
			.Where(x => x.Year != null)
			.OrderByDescending(x => x.Year == currentYear) // true first
			.ThenByDescending(x => x.Year)
			.Select(x => x.Item)
			.FirstOrDefault();

		if (yearFolder == null)
		{
			_logger.Warn($"Lab {lab.LabId}: No year folder found under '{lab.SharePointRootPath}'.");
			return null;
		}

		if (!yearFolder.Name.Equals(currentYear.ToString(), StringComparison.OrdinalIgnoreCase))
			_logger.Warn($"Lab {lab.LabId}: Current year '{currentYear}' not found; using '{yearFolder.Name}'.");

		// 3) Latest month folder inside year (e.g. '01. January')
		var monthChildren = await ListChildrenPagedAsync(_driveId!, yearFolder.Id, ct);
		var monthFolder = monthChildren
			.Where(x => x.IsFolder)
			.OrderByDescending(MonthSortKey)
			.FirstOrDefault();

		if (monthFolder == null)
		{
			_logger.Warn($"Lab {lab.LabId}: No month folders found under year folder '{yearFolder.Name}'.");
			return null;
		}

		// 4) Latest date-range folder inside month (e.g. '01.20.2026 - 01.26.2026')
		var dateChildren = await ListChildrenPagedAsync(_driveId!, monthFolder.Id, ct);
		var dateFolder = dateChildren
			.Where(x => x.IsFolder)
			.OrderByDescending(DateRangeSortKey)
			.FirstOrDefault();

		if (dateFolder == null)
		{
			_logger.Warn($"Lab {lab.LabId}: No date-range folders found under month folder '{monthFolder.Name}'.");
			return null;
		}

		// 5) Pick latest matching file by pattern
		var fileChildren = await ListChildrenPagedAsync(_driveId!, dateFolder.Id, ct);
		var file = fileChildren
			.Where(x => !x.IsFolder && WildcardMatch(x.Name, lab.SharePointFilePattern))
			.OrderByDescending(x => x.LastModifiedUtc ?? DateTimeOffset.MinValue)
			.FirstOrDefault();

		if (file == null)
		{
			_logger.Warn($"Lab {lab.LabId}: No file matched '{lab.SharePointFilePattern}' in '{dateFolder.Name}'.");
			return null;
		}

		var eTagKey = file.ETag ?? string.Empty;
		var spPath = $"{lab.SharePointRootPath}/{yearFolder.Name}/{monthFolder.Name}/{dateFolder.Name}/{file.Name}";

		return new SelectedFile(lab.LabId, _driveId!, file.Id, file.Name, eTagKey, file.LastModifiedUtc, spPath);
	}

	public async Task DownloadFileAsync(string driveId, string itemId, string localPath, CancellationToken ct)
	{
		var url = $"https://graph.microsoft.com/v1.0/drives/{driveId}/items/{itemId}/content";

		using var resp = await _http.GetAsync(url, HttpCompletionOption.ResponseHeadersRead, ct);
		resp.EnsureSuccessStatusCode();

		await using var remote = await resp.Content.ReadAsStreamAsync(ct);
		await using var local = new FileStream(localPath, FileMode.Create, FileAccess.Write, FileShare.None);
		await remote.CopyToAsync(local, ct);
	}

	public async Task<string?> TryResolveProcessedFolderIdAsync(CancellationToken ct)
	{
		var sp = _opt.SharePoint;
		if (!sp.MoveToProcessed || string.IsNullOrWhiteSpace(sp.ProcessedFolderPath))
			return null;

		await EnsureGraphAuthAsync(ct);
		_siteId ??= await GetSiteIdAsync(ct);
		_driveId ??= await GetDriveIdAsync(_siteId!, ct);

		return await GetItemIdByPathAsync(_driveId!, sp.ProcessedFolderPath!, ct);
	}

	public async Task MoveItemAsync(string driveId, string itemId, string newParentFolderId, CancellationToken ct)
	{
		var url = $"https://graph.microsoft.com/v1.0/drives/{driveId}/items/{itemId}";
		var body = "{\"parentReference\":{\"id\":\"" + newParentFolderId + "\"}}";

		using var req = new HttpRequestMessage(HttpMethod.Patch, url)
		{
			Content = new StringContent(body, System.Text.Encoding.UTF8, "application/json")
		};

		using var resp = await _http.SendAsync(req, ct);
		resp.EnsureSuccessStatusCode();
	}

	// ---------------- Auth + Site/Drive ----------------

	private async Task EnsureGraphAuthAsync(CancellationToken ct)
	{
		var sp = _opt.SharePoint;

		if (string.IsNullOrWhiteSpace(sp.TenantId) ||
			string.IsNullOrWhiteSpace(sp.ClientId) ||
			string.IsNullOrWhiteSpace(sp.ClientSecret))
		{
			throw new InvalidOperationException("SharePoint auth config missing (TenantId/ClientId/ClientSecret).");
		}

		var credential = new ClientSecretCredential(sp.TenantId, sp.ClientId, sp.ClientSecret);

		var token = await credential.GetTokenAsync(
			new TokenRequestContext(new[] { "https://graph.microsoft.com/.default" }), ct);

		_http.DefaultRequestHeaders.Authorization = new AuthenticationHeaderValue("Bearer", token.Token);
		_http.DefaultRequestHeaders.Accept.Clear();
		_http.DefaultRequestHeaders.Accept.Add(new MediaTypeWithQualityHeaderValue("application/json"));
	}

	private async Task<string> GetSiteIdAsync(CancellationToken ct)
	{
		var sp = _opt.SharePoint;

		if (string.IsNullOrWhiteSpace(sp.Hostname) || string.IsNullOrWhiteSpace(sp.SitePath))
			throw new InvalidOperationException("SharePoint Hostname/SitePath missing.");

		var url = $"https://graph.microsoft.com/v1.0/sites/{sp.Hostname}:{sp.SitePath}";
		var json = await _http.GetStringAsync(url, ct);

		using var doc = JsonDocument.Parse(json);
		return doc.RootElement.GetProperty("id").GetString()!;
	}

	private async Task<string> GetDriveIdAsync(string siteId, CancellationToken ct)
	{
		var url = $"https://graph.microsoft.com/v1.0/sites/{siteId}/drives";
		var json = await _http.GetStringAsync(url, ct);

		using var doc = JsonDocument.Parse(json);
		foreach (var d in doc.RootElement.GetProperty("value").EnumerateArray())
		{
			var name = d.GetProperty("name").GetString();
			if (string.Equals(name, _opt.SharePoint.DriveName, StringComparison.OrdinalIgnoreCase))
				return d.GetProperty("id").GetString()!;
		}

		throw new InvalidOperationException($"DriveName '{_opt.SharePoint.DriveName}' not found on site.");
	}

	private async Task<string> GetItemIdByPathAsync(string driveId, string path, CancellationToken ct)
	{
		var normalized = Uri.EscapeDataString(path).Replace("%2F", "/");
		var url = $"https://graph.microsoft.com/v1.0/drives/{driveId}/root:/{normalized}";
		var json = await _http.GetStringAsync(url, ct);

		using var doc = JsonDocument.Parse(json);
		return doc.RootElement.GetProperty("id").GetString()!;
	}

	// ---------------- Children listing (paged) ----------------

	private sealed record DriveChild(string Id, string Name, bool IsFolder, DateTimeOffset? LastModifiedUtc, string? ETag);

	private async Task<List<DriveChild>> ListChildrenPagedAsync(string driveId, string folderId, CancellationToken ct)
	{
		var results = new List<DriveChild>();
		string? url = $"https://graph.microsoft.com/v1.0/drives/{driveId}/items/{folderId}/children";

		while (!string.IsNullOrWhiteSpace(url))
		{
			using var resp = await _http.GetAsync(url, ct);
			resp.EnsureSuccessStatusCode();

			var json = await resp.Content.ReadAsStringAsync(ct);
			using var doc = JsonDocument.Parse(json);

			foreach (var item in doc.RootElement.GetProperty("value").EnumerateArray())
			{
				var id = item.GetProperty("id").GetString()!;
				var name = item.GetProperty("name").GetString()!;
				var isFolder = item.TryGetProperty("folder", out _);

				DateTimeOffset? lm = null;
				if (item.TryGetProperty("lastModifiedDateTime", out var lmEl) &&
					DateTimeOffset.TryParse(lmEl.GetString(), out var lmParsed))
					lm = lmParsed;

				string? eTag = item.TryGetProperty("eTag", out var etEl) ? etEl.GetString() : null;

				results.Add(new DriveChild(id, name, isFolder, lm, eTag));
			}

			url = doc.RootElement.TryGetProperty("@odata.nextLink", out var next) ? next.GetString() : null;
		}

		return results;
	}

	// ---------------- Sorting / parsing ----------------

	private static int? TryParseYearFolder(string name)
	{
		if (int.TryParse(name.Trim(), out var y) && y is >= 2000 and <= 2100)
			return y;
		return null;
	}

	private static (int has, int month, long ticks) MonthSortKey(DriveChild folder)
	{
		var m = TryParseLeadingNumber(folder.Name);
		if (m is >= 1 and <= 12)
			return (1, m.Value, (folder.LastModifiedUtc ?? DateTimeOffset.MinValue).Ticks);

		return (0, 0, (folder.LastModifiedUtc ?? DateTimeOffset.MinValue).Ticks);
	}

	private static (int has, long dateTicks, long ticks) DateRangeSortKey(DriveChild folder)
	{
		var dt = TryParseFirstDateFromName(folder.Name);
		if (dt != null)
			return (1, dt.Value.Ticks, (folder.LastModifiedUtc ?? DateTimeOffset.MinValue).Ticks);

		return (0, 0, (folder.LastModifiedUtc ?? DateTimeOffset.MinValue).Ticks);
	}

	private static int? TryParseLeadingNumber(string name)
	{
		var m = Regex.Match(name.Trim(), @"^(?<n>\d{1,2})\.");
		if (!m.Success) return null;
		return int.TryParse(m.Groups["n"].Value, out var n) ? n : null;
	}

	private static DateTime? TryParseFirstDateFromName(string name)
	{
		var m = Regex.Match(name, @"(?<mm>\d{1,2})\.(?<dd>\d{1,2})\.(?<yyyy>\d{4})");
		if (!m.Success) return null;

		if (!int.TryParse(m.Groups["mm"].Value, out var mm)) return null;
		if (!int.TryParse(m.Groups["dd"].Value, out var dd)) return null;
		if (!int.TryParse(m.Groups["yyyy"].Value, out var yyyy)) return null;

		try { return new DateTime(yyyy, mm, dd); }
		catch { return null; }
	}

	private static bool WildcardMatch(string input, string pattern)
	{
		var regex = "^" + Regex.Escape(pattern).Replace("\\*", ".*").Replace("\\?", ".") + "$";
		return Regex.IsMatch(input, regex, RegexOptions.IgnoreCase);
	}
}
