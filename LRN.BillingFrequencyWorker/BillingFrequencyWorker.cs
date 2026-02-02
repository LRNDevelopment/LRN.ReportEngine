using Common.Logging;
using LRN.ExcelValidator.Services;
using Microsoft.Extensions.Hosting;
using Microsoft.Extensions.Logging;
using Microsoft.Extensions.Options;
using System.Diagnostics;
using System.Text.RegularExpressions;

public sealed class BillingFrequencyWorker : BackgroundService
{
    private readonly ILogger<BillingFrequencyWorker> _logger;   // console/eventlog
    private readonly ILoggerService _fileLog;                   // log4net file (only what we write)
    private readonly ImportOptions _opt;
    private readonly string _connStr;
    private readonly SharePointDownloader _sp;
    private readonly BillingFrequencyFileStatusStore _status;
    private readonly IExcelSchemaValidator _schemaValidator;

    public BillingFrequencyWorker(
        ILogger<BillingFrequencyWorker> logger,
        ILoggerService fileLog,
        IOptions<ImportOptions> options,
        Microsoft.Extensions.Configuration.IConfiguration config,
        SharePointDownloader sp,
        BillingFrequencyFileStatusStore status,
        IExcelSchemaValidator schemaValidator)
    {
        _logger = logger;
        _fileLog = fileLog;
        _opt = options.Value;
        _connStr = config.GetConnectionString("DefaultConnection") ?? "";
        _sp = sp;
        _status = status;
        _schemaValidator = schemaValidator;
    }

    protected override async Task ExecuteAsync(CancellationToken stoppingToken)
    {
        EnsureFolders();

        _logger.LogInformation("Worker started. SharePoint.Enabled={Enabled}. EnableBillingFrequency={BillingFreq}",
            _opt.SharePoint.Enabled, _opt.EnableBillingFrequency);

        _fileLog.Info($"Worker started. SharePoint.Enabled={_opt.SharePoint.Enabled}, EnableBillingFrequency={_opt.EnableBillingFrequency}");

        while (!stoppingToken.IsCancellationRequested)
        {
            try
            {
                if (_opt.SharePoint.Enabled)
                {
                    await ProcessSharePointOnceAsync(stoppingToken);
                }
                else
                {
                    _logger.LogWarning("SharePoint is disabled. Nothing to do.");
                    _fileLog.Warn("SharePoint is disabled. Nothing to do.");
                }
            }
            catch (OperationCanceledException) when (stoppingToken.IsCancellationRequested)
            {
                // graceful shutdown
            }
            catch (Exception ex)
            {
                _logger.LogError(ex, "Top-level worker loop error.");
                _fileLog.Error("Top-level worker loop error.", ex);
            }

            try
            {
                await Task.Delay(TimeSpan.FromSeconds(Math.Max(10, _opt.PollSeconds)), stoppingToken);
            }
            catch (OperationCanceledException) { }
        }
    }

    private void EnsureFolders()
    {
        if (string.IsNullOrWhiteSpace(_opt.WatchFolder))
            _opt.WatchFolder = Path.Combine(AppContext.BaseDirectory, "input");

        if (string.IsNullOrWhiteSpace(_opt.ErrorFolder))
            _opt.ErrorFolder = Path.Combine(AppContext.BaseDirectory, "error");

        if (string.IsNullOrWhiteSpace(_opt.ReportOutputsRoot))
            _opt.ReportOutputsRoot = Path.Combine(AppContext.BaseDirectory, "LabReportOutputs");

        Directory.CreateDirectory(_opt.WatchFolder);
        Directory.CreateDirectory(_opt.ErrorFolder);
        Directory.CreateDirectory(_opt.ReportOutputsRoot);
        Directory.CreateDirectory(Path.Combine(AppContext.BaseDirectory, "logs"));
    }

    private async Task ProcessSharePointOnceAsync(CancellationToken ct)
    {
        var currentYear = DateTime.Now.Year;

        foreach (var lab in _opt.Labs)
        {
            ct.ThrowIfCancellationRequested();

            SharePointDownloader.SelectedFile? selected = null;

            try
            {
                selected = await _sp.TryGetLatestFileForLabAsync(lab, currentYear, ct);
                if (selected == null)
                {
                    _logger.LogInformation("Lab {LabId}: no eligible SharePoint file found.", lab.LabId);
                    _fileLog.Info($"Lab {lab.LabId}: no eligible SharePoint file found.");
                    continue;
                }

                // Skip if already processed
                if (await _status.IsProcessedAsync(selected.LabId, selected.DriveId, selected.ItemId, selected.ETagKey, ct))
                {
                    _logger.LogInformation("Lab {LabId}: already processed, skipping: {File}", lab.LabId, selected.Name);
                    _fileLog.Info($"Lab {lab.LabId}: already processed, skipping: {selected.Name}");
                    continue;
                }

                await _status.UpsertStatusAsync(
                    selected.LabId, selected.DriveId, selected.ItemId, selected.ETagKey,
                    selected.Name, selected.SharePointPath, selected.LastModifiedUtc,
                    status: "IN_PROGRESS",
                    statusMessage: "Downloading from SharePoint",
                    processedAtUtc: null,
                    ct: ct);

                // Download to staging
                var stagingFileName = $"{GetLabFolderName(lab)}_{selected.Name}";
                stagingFileName = SanitizeFileName(stagingFileName);
                var stagingPath = Path.Combine(_opt.WatchFolder, stagingFileName);

                _logger.LogInformation("Lab {LabId}: downloading {SpPath} -> {Local}", lab.LabId, selected.SharePointPath, stagingPath);
                _fileLog.Info($"Lab {lab.LabId}: downloading {selected.SharePointPath} -> {stagingPath}");

                await _sp.DownloadFileAsync(selected.DriveId, selected.ItemId, stagingPath, ct);

                // Validate download looks like XLSX
                XlsxFileValidator.ValidateDownloadedXlsxOrThrow(stagingPath);

                // -------- Column validation (NEW) --------
                var lineSchemaPath = ResolvePath(!string.IsNullOrWhiteSpace(lab.LineLevelSchemaJsonPath)
                    ? lab.LineLevelSchemaJsonPath!
                    : _opt.LineLevelSchemaJsonPath);
                var claimSchemaPath = ResolvePath(!string.IsNullOrWhiteSpace(lab.ClaimLevelSchemaJsonPath)
                    ? lab.ClaimLevelSchemaJsonPath!
                    : _opt.ClaimLevelSchemaJsonPath);

                var lineValidation = _schemaValidator.Validate(stagingPath, _opt.SheetName, lineSchemaPath);
                var claimValidation = _schemaValidator.Validate(stagingPath, _opt.ClaimSheetName, claimSchemaPath);

                if (!lineValidation.IsValid || !claimValidation.IsValid)
                {
                    var msg = BuildSchemaErrorMessage(lineValidation, claimValidation, _opt.SheetName, _opt.ClaimSheetName);

                    _logger.LogError("Lab {LabId}: schema validation failed for file {File}. {Msg}", lab.LabId, selected.Name, msg);
                    _fileLog.Error($"Lab {lab.LabId}: schema validation failed for {selected.Name}. {msg}");

                    await _status.UpsertStatusAsync(
                        selected.LabId, selected.DriveId, selected.ItemId, selected.ETagKey,
                        selected.Name, selected.SharePointPath, selected.LastModifiedUtc,
                        status: "ERROR",
                        statusMessage: msg,
                        processedAtUtc: null,
                        ct: ct,
                        errorLogInfo: msg);

                    // Move the downloaded XLSX to ErrorFolder with error txt (so we don't keep retrying)
                    MoveToErrorFolder(stagingPath, msg);

                    continue;
                }

                // Determine output folders from SharePoint path
                var (monthFolder, dateFolder) = ParseMonthAndDateFolder(selected.SharePointPath);

                var baseOut = Path.Combine(
                    _opt.ReportOutputsRoot,
                    "Masters",
                    GetLabFolderName(lab),
                    "Master",
                    monthFolder,
                    dateFolder);

                var claimDir = Path.Combine(baseOut, "ClaimLevel");
                var lineDir = Path.Combine(baseOut, "LineLevel");

                Directory.CreateDirectory(claimDir);
                Directory.CreateDirectory(lineDir);

                var baseName = SanitizeFileName(Path.GetFileNameWithoutExtension(selected.Name));

                // CSV outputs
                var claimOutPath = Path.Combine(claimDir, $"{baseName}_ClaimLevel.csv");
                var lineOutPath = Path.Combine(lineDir, $"{baseName}_LineLevel.csv");

                await _status.UpsertStatusAsync(
                    selected.LabId, selected.DriveId, selected.ItemId, selected.ETagKey,
                    selected.Name, selected.SharePointPath, selected.LastModifiedUtc,
                    status: "IN_PROGRESS",
                    statusMessage: $"Exporting ClaimLevel + LineLevel to CSV. Output={baseOut}",
                    processedAtUtc: null,
                    ct: ct);

                // Export to CSV (fast, no formatting)
                var sw = Stopwatch.StartNew();

                // LineLevel
                await ExcelCsvExporter.ExportSingleSheetToCsvAsync(stagingPath, _opt.SheetName, lineOutPath, ct);
_logger.LogInformation("Lab {LabId}: LineLevel CSV export took {Ms} ms", lab.LabId, sw.ElapsedMilliseconds);
                _fileLog.Info($"Lab {lab.LabId}: LineLevel CSV export took {sw.ElapsedMilliseconds} ms -> {lineOutPath}");

                // ClaimLevel
                sw.Restart();
                await ExcelCsvExporter.ExportSingleSheetToCsvAsync(stagingPath, _opt.ClaimSheetName, claimOutPath, ct);
_logger.LogInformation("Lab {LabId}: ClaimLevel CSV export took {Ms} ms", lab.LabId, sw.ElapsedMilliseconds);
                _fileLog.Info($"Lab {lab.LabId}: ClaimLevel CSV export took {sw.ElapsedMilliseconds} ms -> {claimOutPath}");

                // Optional: Billing frequency processing (kept separate & toggleable)
                if (_opt.EnableBillingFrequency)
                {
                    if (string.IsNullOrWhiteSpace(_connStr))
                        throw new InvalidOperationException("EnableBillingFrequency=true but DefaultConnection is missing.");

                    await _status.UpsertStatusAsync(
                        selected.LabId, selected.DriveId, selected.ItemId, selected.ETagKey,
                        selected.Name, selected.SharePointPath, selected.LastModifiedUtc,
                        status: "IN_PROGRESS",
                        statusMessage: "Calculating billing frequency and loading into SQL.",
                        processedAtUtc: null,
                        ct: ct);

                    var rows = CsvLineLevelReader.ReadLineLevelRows(lineOutPath, headerRow: _opt.HeaderRow);
                    var countsDt = BillingGrouper.BuildBillingCounts(rows, lab.LabId);

                    await BillingSqlLoader.ReplaceLabDataAsync(_connStr, _opt.DestinationTable, lab.LabId, countsDt, ct);

                    _fileLog.Info($"Lab {lab.LabId}: Billing frequency loaded to { _opt.DestinationTable }.");
                }

                // Mark PROCESSED
                await _status.UpsertStatusAsync(
                    selected.LabId, selected.DriveId, selected.ItemId, selected.ETagKey,
                    selected.Name, selected.SharePointPath, selected.LastModifiedUtc,
                    status: "PROCESSED",
                    statusMessage: $"Saved LineLevel='{lineOutPath}', ClaimLevel='{claimOutPath}'. BillingFrequency={( _opt.EnableBillingFrequency ? "DONE" : "SKIPPED")}.",
                    processedAtUtc: DateTimeOffset.UtcNow,
                    ct: ct);

                _fileLog.Info($"Lab {lab.LabId}: PROCESSED {selected.Name}.");

                // Optional SharePoint move (still supported by config)
                var processedFolderId = await _sp.TryResolveProcessedFolderIdAsync(ct);
                if (!string.IsNullOrWhiteSpace(processedFolderId))
                {
                    await _sp.MoveItemAsync(selected.DriveId, selected.ItemId, processedFolderId!, ct);
                    _fileLog.Info($"Lab {lab.LabId}: moved SharePoint file to processed folder.");
                }

                // Cleanup staging file
                if (!_opt.KeepDownloadedFiles)
                    TryDelete(stagingPath);
            }
            catch (OperationCanceledException) when (ct.IsCancellationRequested)
            {
                throw;
            }
            catch (Exception ex)
            {
                _logger.LogError(ex, "Lab {LabId}: error processing SharePoint file.", lab.LabId);
                _fileLog.Error($"Lab {lab.LabId}: error processing SharePoint file.", ex);

                if (selected != null)
                {
                    await _status.UpsertStatusAsync(
                        selected.LabId, selected.DriveId, selected.ItemId, selected.ETagKey,
                        selected.Name, selected.SharePointPath, selected.LastModifiedUtc,
                        status: "ERROR",
                        statusMessage: ex.Message,
                        processedAtUtc: null,
                        ct: ct,
                        errorLogInfo: ex.ToString());
                }
            }
        }
    }

    private static string BuildSchemaErrorMessage(
        LRN.ExcelValidator.Models.SchemaValidationResult lineValidation,
        LRN.ExcelValidator.Models.SchemaValidationResult claimValidation,
        string lineCandidates,
        string claimCandidates)
    {
        var parts = new List<string>();

        if (lineValidation.SheetUsed == null)
            parts.Add($"LineLevel sheet not found. Candidates: {lineCandidates}");
        else if (lineValidation.MissingRequiredColumns.Count > 0)
            parts.Add($"LineLevel missing columns: {string.Join(", ", lineValidation.MissingRequiredColumns)} (sheet='{lineValidation.SheetUsed}')");

        if (claimValidation.SheetUsed == null)
            parts.Add($"ClaimLevel sheet not found. Candidates: {claimCandidates}");
        else if (claimValidation.MissingRequiredColumns.Count > 0)
            parts.Add($"ClaimLevel missing columns: {string.Join(", ", claimValidation.MissingRequiredColumns)} (sheet='{claimValidation.SheetUsed}')");

        return string.Join(" | ", parts);
    }

    private void MoveToErrorFolder(string stagingPath, string msg)
    {
        try
        {
            Directory.CreateDirectory(_opt.ErrorFolder);

            var name = Path.GetFileNameWithoutExtension(stagingPath);
            var ext = Path.GetExtension(stagingPath);
            var ts = DateTime.Now.ToString("yyyyMMdd_HHmmss");

            var destXlsx = Path.Combine(_opt.ErrorFolder, $"{name}_{ts}{ext}");
            if (File.Exists(destXlsx)) File.Delete(destXlsx);
            File.Move(stagingPath, destXlsx);

            var destTxt = Path.Combine(_opt.ErrorFolder, $"{name}_{ts}.error.txt");
            File.WriteAllText(destTxt, msg);

            _fileLog.Warn($"Moved file to error folder: {destXlsx}");
        }
        catch (Exception ex)
        {
            _fileLog.Error("Failed to move file to error folder.", ex);
        }
    }

    private static (string MonthFolder, string DateFolder) ParseMonthAndDateFolder(string sharePointPath)
    {
        // Expected: .../<Year>/<Month>/<DateRange>/<File>
        var parts = sharePointPath.Split('/', StringSplitOptions.RemoveEmptyEntries | StringSplitOptions.TrimEntries);

        // try to locate a 4-digit year segment
        int yearIndex = -1;
        for (int i = 0; i < parts.Length; i++)
        {
            if (Regex.IsMatch(parts[i], @"^\d{4}$"))
            {
                yearIndex = i;
                break;
            }
        }

        if (yearIndex >= 0 && yearIndex + 2 < parts.Length)
        {
            return (parts[yearIndex + 1], parts[yearIndex + 2]);
        }

        // fallback: assume last segments
        if (parts.Length >= 3)
            return (parts[^3], parts[^2]);

        return ("UnknownMonth", "UnknownDate");
    }

    private static string GetLabFolderName(LabFileMap lab)
    {
        if (!string.IsNullOrWhiteSpace(lab.LabName))
            return SanitizePathSegment(lab.LabName);

        return SanitizePathSegment(lab.LabId.ToString());
    }

    private static string SanitizePathSegment(string input)
    {
        foreach (var c in Path.GetInvalidFileNameChars())
            input = input.Replace(c, '_');
        return input.Trim();
    }

    private static string SanitizeFileName(string input)
    {
        foreach (var c in Path.GetInvalidFileNameChars())
            input = input.Replace(c, '_');
        return input.Trim();
    }

    private static void TryDelete(string path)
    {
        try
        {
            if (File.Exists(path))
                File.Delete(path);
        }
        catch { }
    }

    private static string ResolvePath(string path)
    {
        if (string.IsNullOrWhiteSpace(path)) return path;
        if (Path.IsPathRooted(path)) return path;

        var normalized = path.Replace('/', Path.DirectorySeparatorChar).Replace('\\', Path.DirectorySeparatorChar);
        return Path.Combine(AppContext.BaseDirectory, normalized);
    }
}
