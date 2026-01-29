using Microsoft.Extensions.Hosting;
using Microsoft.Extensions.Logging;
using Microsoft.Extensions.Options;
using Microsoft.Extensions.Configuration;
using System.Data;

public sealed class BillingFrequencyWorker : BackgroundService
{
    private readonly ILogger<BillingFrequencyWorker> _logger;
    private readonly ImportOptions _opt;
    private readonly string _connStr;

    private readonly SharePointDownloader _sp;
    private readonly BillingFrequencyFileStatusStore _statusStore;

    private string? _processedFolderIdCache;

    public BillingFrequencyWorker(
        ILogger<BillingFrequencyWorker> logger,
        IOptions<ImportOptions> options,
        IConfiguration config,
        SharePointDownloader sp,
        BillingFrequencyFileStatusStore statusStore)
    {
        _logger = logger;
        _opt = options.Value;
        _connStr = config.GetConnectionString("DefaultConnection")!;
        _sp = sp;
        _statusStore = statusStore;
    }

    protected override async Task ExecuteAsync(CancellationToken stoppingToken)
    {
        _logger.LogInformation(
            "Billing Frequency Worker started. Watch={Watch} Archive={Archive} Error={Error} PollSeconds={Poll} Labs={LabCount}",
            _opt.WatchFolder, _opt.ArchiveFolder, _opt.ErrorFolder, _opt.PollSeconds, _opt.Labs.Count);

        while (!stoppingToken.IsCancellationRequested)
        {
            try
            {
                ValidateFolders();
                Directory.CreateDirectory(_opt.WatchFolder);
                Directory.CreateDirectory(_opt.ArchiveFolder);
                Directory.CreateDirectory(_opt.ErrorFolder);

                // Resolve processed folder id once if move is enabled
                if (_processedFolderIdCache == null && _opt.SharePoint.MoveToProcessed)
                {
                    _processedFolderIdCache = await _sp.TryResolveProcessedFolderIdAsync(stoppingToken);
                    if (string.IsNullOrWhiteSpace(_processedFolderIdCache))
                        _logger.LogWarning("MoveToProcessed is enabled but ProcessedFolderPath could not be resolved.");
                }

                int year = DateTime.Now.Year;

                foreach (var lab in _opt.Labs)
                {
                    stoppingToken.ThrowIfCancellationRequested();

                    if (string.IsNullOrWhiteSpace(lab.SharePointRootPath))
                    {
                        _logger.LogWarning("Lab {LabId}: SharePointRootPath is empty. Skipping.", lab.LabId);
                        continue;
                    }

                    var selected = await _sp.TryGetLatestFileForLabAsync(lab, year, stoppingToken);
                    if (selected == null) continue;

                    if (await _statusStore.IsProcessedAsync(selected.LabId, selected.DriveId, selected.ItemId, selected.ETagKey, stoppingToken))
                    {
                        _logger.LogInformation("Lab {LabId}: already processed. Skipping {File}.", selected.LabId, selected.Name);
                        continue;
                    }

                    string localFileName = $"{selected.LabId}_{SanitizeFileName(selected.Name)}";
                    string localFinal = Path.Combine(_opt.WatchFolder, localFileName);
                    string localTmp = localFinal + ".download";

                    try
                    {
                        await _statusStore.UpsertStatusAsync(
                            selected.LabId, selected.DriveId, selected.ItemId, selected.ETagKey,
                            selected.Name, selected.SharePointPath, selected.LastModifiedUtc,
                            status: "DOWNLOADING",
                            statusMessage: "Downloading file from SharePoint.",
                            processedAtUtc: null,
                            ct: stoppingToken);

                        SafeDelete(localTmp);
                        await _sp.DownloadFileAsync(selected.DriveId, selected.ItemId, localTmp, stoppingToken);

                        SafeDelete(localFinal);
                        File.Move(localTmp, localFinal);

                        await _statusStore.UpsertStatusAsync(
                            selected.LabId, selected.DriveId, selected.ItemId, selected.ETagKey,
                            selected.Name, selected.SharePointPath, selected.LastModifiedUtc,
                            status: "DOWNLOADED",
                            statusMessage: $"Downloaded to {localFinal}",
                            processedAtUtc: null,
                            ct: stoppingToken);

                        // Extract excel
                        var rows = BillingExcelReader.ReadLineLevelRows(localFinal, _opt.SheetName, _opt.HeaderRow);
                        if (rows.Count == 0)
                            throw new InvalidOperationException($"No line-level rows found in '{localFinal}'.");

                        // Group counts
                        DataTable countsDt = BillingGrouper.BuildBillingCounts(rows, selected.LabId);

                        // Load to SQL (delete existing for lab + bulk insert)
                        await BillingSqlLoader.ReplaceLabDataAsync(_connStr, _opt.DestinationTable, selected.LabId, countsDt, stoppingToken);

                        await _statusStore.UpsertStatusAsync(
                            selected.LabId, selected.DriveId, selected.ItemId, selected.ETagKey,
                            selected.Name, selected.SharePointPath, selected.LastModifiedUtc,
                            status: "PROCESSED",
                            statusMessage: $"Loaded {countsDt.Rows.Count} grouped rows from {rows.Count} line rows.",
                            processedAtUtc: DateTimeOffset.UtcNow,
                            ct: stoppingToken);

                        // Optional: move file on SharePoint after success
                        if (_opt.SharePoint.MoveToProcessed && !string.IsNullOrWhiteSpace(_processedFolderIdCache))
                        {
                            try
                            {
                                await _sp.MoveItemAsync(selected.DriveId, selected.ItemId, _processedFolderIdCache!, stoppingToken);
                                _logger.LogInformation("Lab {LabId}: moved SharePoint file to processed folder: {File}", selected.LabId, selected.Name);
                            }
                            catch (Exception exMove)
                            {
                                _logger.LogError(exMove, "Lab {LabId}: failed to move SharePoint file to processed folder: {File}", selected.LabId, selected.Name);
                            }
                        }

                        // Archive local file
                        SafeMoveToFolder(localFinal, _opt.ArchiveFolder, "archived");
                    }
                    catch (Exception ex)
                    {
                        string msg = ex.ToString();
                        if (msg.Length > 3500) msg = msg[..3500];

                        _logger.LogError(ex, "Lab {LabId}: failed processing SharePoint file {File}", selected.LabId, selected.Name);

                        await _statusStore.UpsertStatusAsync(
                            selected.LabId, selected.DriveId, selected.ItemId, selected.ETagKey,
                            selected.Name, selected.SharePointPath, selected.LastModifiedUtc,
                            status: "ERROR",
                            statusMessage: msg,
                            processedAtUtc: null,
                            ct: stoppingToken);

                        SafeMoveToFolder(localFinal, _opt.ErrorFolder, "error");
                        SafeDelete(localTmp);
                    }
                }

                await Task.Delay(TimeSpan.FromSeconds(_opt.PollSeconds), stoppingToken);
            }
            catch (TaskCanceledException) { }
            catch (Exception ex)
            {
                _logger.LogError(ex, "Worker loop error");
                await Task.Delay(TimeSpan.FromSeconds(30), stoppingToken);
            }
        }
    }

    private void ValidateFolders()
    {
        if (string.IsNullOrWhiteSpace(_opt.WatchFolder) ||
            string.IsNullOrWhiteSpace(_opt.ArchiveFolder) ||
            string.IsNullOrWhiteSpace(_opt.ErrorFolder))
        {
            throw new InvalidOperationException("WatchFolder/ArchiveFolder/ErrorFolder must be configured (BillingFrequency section).");
        }
    }

    private static void SafeMoveToFolder(string filePath, string destFolder, string tag)
    {
        try
        {
            if (!File.Exists(filePath)) return;

            Directory.CreateDirectory(destFolder);
            var stamp = DateTime.Now.ToString("yyyyMMdd_HHmmss");
            var dest = Path.Combine(destFolder,
                $"{Path.GetFileNameWithoutExtension(filePath)}_{tag}_{stamp}{Path.GetExtension(filePath)}");

            File.Move(filePath, dest, overwrite: true);
        }
        catch { }
    }

    private static void SafeDelete(string path)
    {
        try
        {
            if (File.Exists(path)) File.Delete(path);
        }
        catch { }
    }

    private static string SanitizeFileName(string name)
    {
        foreach (var c in Path.GetInvalidFileNameChars())
            name = name.Replace(c, '_');
        return name;
    }
}
