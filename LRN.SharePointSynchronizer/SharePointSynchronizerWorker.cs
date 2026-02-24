using Microsoft.Extensions.Hosting;
using Microsoft.Extensions.Logging;
using Microsoft.Extensions.Options;
using System.Collections.Concurrent;

public sealed class SharePointSynchronizerWorker : BackgroundService
{
    private readonly ILogger<SharePointSynchronizerWorker> _logger;
    private readonly SharePointDownloader _sp;
    private readonly ImportOptions _import;
    private readonly SharePointSynchronizerOptions _opt;

    // in-memory de-dupe caches (safe for a worker singleton)
    private readonly ConcurrentDictionary<string, DateTime> _uploadedLocalStamp = new(StringComparer.OrdinalIgnoreCase);
    private readonly ConcurrentDictionary<string, string> _downloadedRemoteVersion = new(StringComparer.OrdinalIgnoreCase);

    public SharePointSynchronizerWorker(
        ILogger<SharePointSynchronizerWorker> logger,
        SharePointDownloader sp,
        IOptions<ImportOptions> import,
        IOptions<SharePointSynchronizerOptions> opt)
    {
        _logger = logger;
        _sp = sp;
        _import = import.Value;
        _opt = opt.Value;
    }

    protected override async Task ExecuteAsync(CancellationToken stoppingToken)
    {
        if (!_opt.Enabled)
        {
            _logger.LogInformation("SharePointSynchronizerWorker disabled.");
            return;
        }

        while (!stoppingToken.IsCancellationRequested)
        {
            try
            {
                await RunOnceAsync(stoppingToken);
            }
            catch (OperationCanceledException) when (stoppingToken.IsCancellationRequested) { }
            catch (Exception ex)
            {
                _logger.LogError(ex, "SharePointSynchronizerWorker cycle failed.");
            }

            try
            {
                await Task.Delay(TimeSpan.FromSeconds(Math.Max(10, _opt.PollSeconds)), stoppingToken);
            }
            catch (OperationCanceledException) when (stoppingToken.IsCancellationRequested) { }
        }
    }

    private async Task RunOnceAsync(CancellationToken ct)
    {
        if (!_import.SharePoint.Enabled)
        {
            _logger.LogWarning("SharePoint is disabled (ImportOptions.SharePoint.Enabled=false). Sync skipped.");
            return;
        }

        var driveId = await _sp.TryGetDriveIdAsync(ct);
        if (string.IsNullOrWhiteSpace(driveId))
        {
            _logger.LogWarning("Unable to resolve SharePoint drive id. Sync skipped.");
            return;
        }

        foreach (var item in _opt.Items ?? Enumerable.Empty<SharePointSyncItem>())
        {
            ct.ThrowIfCancellationRequested();

            try
            {
                Directory.CreateDirectory(item.ServerPath);

                if (item.UploadNewServerFilesToSharePoint)
                    await UploadNewLocalFilesAsync(driveId!, item, ct);

                if (item.DownloadLatestSharePointFileToServer)
                    await DownloadLatestSharePointFileAsync(driveId!, item, ct);
            }
            catch (OperationCanceledException) when (ct.IsCancellationRequested) { throw; }
            catch (Exception ex)
            {
                _logger.LogError(ex, "Sync item '{Name}' failed.", item.Name);
            }
        }
    }

    private async Task UploadNewLocalFilesAsync(string driveId, SharePointSyncItem item, CancellationToken ct)
    {
        var files = Directory.EnumerateFiles(item.ServerPath, item.FileName, SearchOption.TopDirectoryOnly)
            .Select(p => new FileInfo(p))
            .OrderBy(f => f.LastWriteTimeUtc)
            .ThenBy(f => f.Name, StringComparer.OrdinalIgnoreCase)
            .ToList();

        foreach (var f in files)
        {
            ct.ThrowIfCancellationRequested();

            var cacheKey = $"UL|{item.Name}|{f.FullName}";
            var stamp = f.LastWriteTimeUtc;

            if (_uploadedLocalStamp.TryGetValue(cacheKey, out var lastUploadedStamp) && lastUploadedStamp >= stamp)
                continue;

            await _sp.UploadFileToFolderPathAsync(driveId, item.SharePointFolder, f.FullName, f.Name, ct);
            _uploadedLocalStamp[cacheKey] = stamp;

            _logger.LogInformation("[{Name}] Uploaded local file -> SharePoint: {File} => {Folder}", item.Name, f.Name, item.SharePointFolder);
        }
    }

    private async Task DownloadLatestSharePointFileAsync(string driveId, SharePointSyncItem item, CancellationToken ct)
    {
        SharePointDownloader.SharePointFileEntry? remote;
        try
        {
            remote = await _sp.FindLatestFileInFolderPathAsync(driveId, item.SharePointFolder, item.FileName, ct);
        }
        catch (Exception ex)
        {
            _logger.LogWarning(ex, "[{Name}] Failed reading SharePoint folder '{Folder}'.", item.Name, item.SharePointFolder);
            return;
        }

        if (remote == null)
        {
            _logger.LogDebug("[{Name}] No SharePoint file matched pattern '{Pattern}' in '{Folder}'.", item.Name, item.FileName, item.SharePointFolder);
            return;
        }

        var versionKey = remote.ETag ?? remote.LastModifiedUtc?.UtcDateTime.Ticks.ToString() ?? string.Empty;
        var cacheKey = $"DL|{item.Name}|{remote.Name}";

        if (!string.IsNullOrWhiteSpace(versionKey)
            && _downloadedRemoteVersion.TryGetValue(cacheKey, out var seenVersion)
            && string.Equals(seenVersion, versionKey, StringComparison.Ordinal))
        {
            return;
        }

        var localPath = Path.Combine(item.ServerPath, remote.Name);
        Directory.CreateDirectory(item.ServerPath);

        if (File.Exists(localPath) && item.RenameExistingLocalAsObsolete)
        {
            var obsoleteName = $"obsolete_{DateTime.Now:yyyyMMddHHmmss}_{Path.GetFileName(localPath)}";
            var obsoletePath = Path.Combine(item.ServerPath, obsoleteName);
            File.Move(localPath, obsoletePath, overwrite: true);
            _logger.LogInformation("[{Name}] Existing local file renamed: {Old} -> {New}", item.Name, Path.GetFileName(localPath), obsoleteName);
        }

        await _sp.DownloadFileAsync(remote.DriveId, remote.ItemId, localPath, ct);

        if (!string.IsNullOrWhiteSpace(versionKey))
            _downloadedRemoteVersion[cacheKey] = versionKey;

        _logger.LogInformation("[{Name}] Downloaded SharePoint file -> local: {File} <= {Folder}", item.Name, remote.Name, item.SharePointFolder);
    }
}
