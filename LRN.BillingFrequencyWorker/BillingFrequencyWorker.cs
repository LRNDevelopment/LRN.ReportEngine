using Common.Logging;
using Microsoft.Extensions.Hosting;
using Microsoft.Extensions.Logging;
using Microsoft.Extensions.Options;
using System.Globalization;
using System.Data;

public sealed class BillingFrequencyWorker : BackgroundService
{
    private readonly ILogger<BillingFrequencyWorker> _logger;
    private readonly ILoggerService _fileLog;
    private readonly ImportOptions _opt;
    private readonly string _connStr;

    private readonly string _statePath;
    private BillingFrequencyProcessedState _state = new();

    public BillingFrequencyWorker(
        ILogger<BillingFrequencyWorker> logger,
        ILoggerService fileLog,
        IOptions<ImportOptions> options,
        Microsoft.Extensions.Configuration.IConfiguration config)
    {
        _logger = logger;
        _fileLog = fileLog;
        _opt = options.Value;
        _connStr = config.GetConnectionString("DefaultConnection") ?? "";

        // Persist last processed per lab so we don't repeatedly reload the same file
        _statePath = Path.Combine(AppContext.BaseDirectory, "state", "billing_frequency_state.json");
    }

    protected override async Task ExecuteAsync(CancellationToken stoppingToken)
    {
        EnsureFolders();
        _state = BillingFrequencyProcessedState.Load(_statePath);

        _logger.LogInformation("Worker started. EnableBillingFrequency={Enabled}. PollSeconds={PollSeconds}.",
            _opt.EnableBillingFrequency, _opt.PollSeconds);

        _fileLog.Info($"Worker started. EnableBillingFrequency={_opt.EnableBillingFrequency}, PollSeconds={_opt.PollSeconds}.");

        while (!stoppingToken.IsCancellationRequested)
        {
            try
            {
                if (!_opt.EnableBillingFrequency)
                {
                    _logger.LogWarning("EnableBillingFrequency=false. Nothing to do.");
                    _fileLog.Warn("EnableBillingFrequency=false. Nothing to do.");
                }
                else
                {
                    await ProcessOnceAsync(stoppingToken);
                }
            }
            catch (OperationCanceledException) when (stoppingToken.IsCancellationRequested)
            {
                throw;
            }
            catch (Exception ex)
            {
                _logger.LogError(ex, "Billing frequency worker error.");
                _fileLog.Error("Billing frequency worker error.", ex);
            }

            await Task.Delay(TimeSpan.FromSeconds(Math.Max(5, _opt.PollSeconds)), stoppingToken);
        }
    }

    private async Task ProcessOnceAsync(CancellationToken ct)
    {
        if (string.IsNullOrWhiteSpace(_connStr))
            throw new InvalidOperationException("DefaultConnection is missing.");

        var outputRoot = ResolvePath(Path.Combine(_opt.ReportOutputsRoot ?? "", "Output"));
        if (string.IsNullOrWhiteSpace(outputRoot) || !Directory.Exists(outputRoot))
        {
            _logger.LogWarning("Output root folder not found: {Path}", outputRoot);
            _fileLog.Warn($"Output root folder not found: {outputRoot}");
            return;
        }

        foreach (var lab in _opt.Labs)
        {
            ct.ThrowIfCancellationRequested();

            try
            {
                var labPrefix = GetLabOutputPrefix(lab); // e.g. Cove
                var latestLineFile = FindLatestFile(outputRoot, $"{labPrefix}_LineLevel.csv");

                if (latestLineFile == null)
                {
                    _logger.LogInformation("Lab {LabId}: no LineLevel CSV found under {Root}.", lab.LabId, outputRoot);
                    continue;
                }

                var lastWriteUtc = File.GetLastWriteTimeUtc(latestLineFile);

                if (_state.IsProcessed(lab.LabId, latestLineFile, lastWriteUtc))
                {
                    _logger.LogInformation("Lab {LabId}: latest LineLevel already processed: {File}", lab.LabId, latestLineFile);
                    continue;
                }

                _logger.LogInformation("Lab {LabId}: processing billing frequency from {File}", lab.LabId, latestLineFile);
                _fileLog.Info($"Lab {lab.LabId}: processing billing frequency from {latestLineFile}");

                // 1) Read standardized LineLevel CSV and build billing counts
                var rows = CsvLineLevelReader.ReadLineLevelRows(latestLineFile, headerRow: _opt.HeaderRow);
                var countsDt = BillingGrouper.BuildBillingCounts(rows, lab.LabId);

                // 2) Load to SQL (replace lab slice)
                await BillingSqlLoader.ReplaceLabDataAsync(_connStr, _opt.DestinationTable, lab.LabId, countsDt, ct);

                // 3) Write a BillingFrequency CSV next to the LineLevel file by default
                var outputFolder = Path.GetDirectoryName(latestLineFile) ?? outputRoot;
                var outPath = Path.Combine(outputFolder, $"{labPrefix}_BillingFrequency.csv");

                BillingFrequencyCsvWriter.Write(countsDt, outPath);

                _logger.LogInformation("Lab {LabId}: billing frequency written to {OutPath}", lab.LabId, outPath);
                _fileLog.Info($"Lab {lab.LabId}: billing frequency written -> {outPath}");

                _state.MarkProcessed(lab.LabId, latestLineFile, lastWriteUtc, outPath);
                BillingFrequencyProcessedState.Save(_statePath, _state);
            }
            catch (Exception ex)
            {
                _logger.LogError(ex, "Lab {LabId}: error building billing frequency.", lab.LabId);
                _fileLog.Error($"Lab {lab.LabId}: error building billing frequency.", ex);
            }
        }
    }

    private static string? FindLatestFile(string root, string exactFileName)
    {
        try
        {
            // Search all date folders under Output (YYYY/MM.MMM/MM.dd.yyyy)
            var files = Directory.EnumerateFiles(root, exactFileName, SearchOption.AllDirectories);

            string? best = null;
            DateTime bestWrite = DateTime.MinValue;

            foreach (var f in files)
            {
                var t = File.GetLastWriteTimeUtc(f);
                if (t > bestWrite)
                {
                    bestWrite = t;
                    best = f;
                }
            }

            return best;
        }
        catch
        {
            return null;
        }
    }

    private void EnsureFolders()
    {
        try
        {
            Directory.CreateDirectory(ResolvePath(_opt.ReportOutputsRoot));
            Directory.CreateDirectory(Path.Combine(AppContext.BaseDirectory, "state"));
            Directory.CreateDirectory(Path.Combine(AppContext.BaseDirectory, "logs"));
        }
        catch { }
    }

    private static string GetLabOutputPrefix(LabFileMap lab)
    {
        var name = !string.IsNullOrWhiteSpace(lab.LabName)
            ? lab.LabName.Trim()
            : lab.LabId.ToString(CultureInfo.InvariantCulture);

        name = name.Replace(' ', '_');
        return SanitizeFileName(name);
    }

    private static string SanitizeFileName(string input)
    {
        foreach (var c in Path.GetInvalidFileNameChars())
            input = input.Replace(c, '_');
        return input.Trim();
    }

    private static string ResolvePath(string path)
    {
        if (string.IsNullOrWhiteSpace(path)) return path;
        if (Path.IsPathRooted(path)) return path;

        var normalized = path.Replace('/', Path.DirectorySeparatorChar).Replace('\\', Path.DirectorySeparatorChar);
        return Path.Combine(AppContext.BaseDirectory, normalized);
    }
}
