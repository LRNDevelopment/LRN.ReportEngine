using DenialDatabaseProcessorWorker.Builders;
using DenialDatabaseProcessorWorker.BulkWriters;
using DenialDatabaseProcessorWorker.Models;
using DenialDatabaseProcessorWorker.Notifications;
using DenialDatabaseProcessorWorker.Services;
using DenialDatabaseProcessorWorker.Services.SharePoint;
using DenialDatabaseProcessorWorker.Utils;
using Microsoft.Extensions.Hosting;
using Microsoft.Extensions.Logging;
using Microsoft.Extensions.Options;
using System.Text;

namespace DenialDatabaseProcessorWorker.Worker;

public sealed class DenialDatabaseWorker : BackgroundService
{
    private readonly ILogger<DenialDatabaseWorker> _logger;
    private readonly ProcessorOptions _options;
    private readonly List<LabConfig> _labs;
    private readonly ITeamsNotifier _teamsNotifier;
    private readonly CsvStepLogger _stepLogger;
    private readonly ExcelTableReader _excelReader;
    private readonly DenialDatabaseBuilder _builder;
    private readonly ExcelWriter _excelWriter;
    private readonly ISharePointUploader _uploader;
    private readonly DenialInsightBuilder _insightBuilder;
    private readonly FileResolver _fileResolver;
    private readonly OutputPathBuilder _outputPathBuilder;
    private readonly DenialAnalysisRunLogRepository _runLogRepo;
    private readonly DenialTaskBoardRepository _denialTaskBoardRepo;
    private readonly IErrorLogger _errorLogger;
    private readonly SharePointGraphOptions _spOpt;
    private readonly IConfiguration _config;

    public DenialDatabaseWorker(
        ILogger<DenialDatabaseWorker> logger,
        IOptions<ProcessorOptions> options,
        IOptions<List<LabConfig>> labs,
        CsvStepLogger stepLogger,
        ExcelTableReader excelReader,
        DenialDatabaseBuilder builder,
        ExcelWriter excelWriter,
        ISharePointUploader uploader,
        DenialInsightBuilder insightBuilder,
        FileResolver fileResolver,
        OutputPathBuilder outputPathBuilder,
        DenialAnalysisRunLogRepository runLogRepo,
        DenialTaskBoardRepository denialTaskBoardRepo,
        IErrorLogger errorLogger,
        IOptions<SharePointGraphOptions> spOpt,
        ITeamsNotifier teamsNotifier,
        IConfiguration config)
    {
        _logger = logger;
        _options = options.Value;
        _labs = labs.Value ?? new();

        _stepLogger = stepLogger;
        _excelReader = excelReader;
        _builder = builder;
        _excelWriter = excelWriter;
        _uploader = uploader;
        _insightBuilder = insightBuilder;
        _fileResolver = fileResolver;
        _outputPathBuilder = outputPathBuilder;
        _runLogRepo = runLogRepo;
        _denialTaskBoardRepo = denialTaskBoardRepo;
        _errorLogger = errorLogger;
        _spOpt = spOpt.Value;
        _teamsNotifier = teamsNotifier;
        _config = config;
    }

    protected override async Task ExecuteAsync(CancellationToken stoppingToken)
    {
        if (_labs.Count == 0)
        {
            _logger.LogWarning("No labs configured. Nothing to do.");
            return;
        }

        try
        {
            foreach (var lab in _labs)
            {
                if (stoppingToken.IsCancellationRequested)
                    break;

                await ProcessLabAsync(lab, stoppingToken);
            }
        }
        catch (Exception ex)
        {
            _logger.LogError(ex, "Top-level worker failure.");
        }
        finally
        {
            if (_options.RunOnceOnStartup)
            {
                _logger.LogInformation("RunOnceOnStartup=true. Stopping host.");
                Environment.ExitCode = 0;
            }
        }

        if (!_options.RunOnceOnStartup)
        {
            while (!stoppingToken.IsCancellationRequested)
            {
                await Task.Delay(TimeSpan.FromMinutes(120), stoppingToken);

                foreach (var lab in _labs)
                {
                    if (stoppingToken.IsCancellationRequested)
                        break;

                    await ProcessLabAsync(lab, stoppingToken);
                }
            }
        }
    }

    private async Task ProcessLabAsync(LabConfig lab, CancellationToken ct)
    {
        string payerPolicyFile = string.Empty;
        string claimActionMapperFile = string.Empty;
        string outFile = string.Empty;
        string runId = string.Empty;

        try
        {
            payerPolicyFile = _fileResolver.GetLatestPayerPolicyFile(lab);
            claimActionMapperFile = _fileResolver.GetLatestClaimActionMapper(lab);

            if (string.IsNullOrWhiteSpace(payerPolicyFile) || !File.Exists(payerPolicyFile))
                throw new FileNotFoundException("Latest payer policy file not found.", payerPolicyFile);

            if (string.IsNullOrWhiteSpace(claimActionMapperFile) || !File.Exists(claimActionMapperFile))
                throw new FileNotFoundException("Latest claim action mapper file not found.", claimActionMapperFile);

            runId = _fileResolver.ExtractRunId(payerPolicyFile);

            if (string.IsNullOrWhiteSpace(runId))
                throw new InvalidOperationException($"Unable to extract RunId from file: {payerPolicyFile}");

            if (await _runLogRepo.ExistsAsync(runId))
            {
                _logger.LogInformation(
                    "RunId {RunId} already processed. Skipping lab {LabName}.",
                    runId,
                    lab.LabName);
                return;
            }

            var (yearFolder, monthFolder, weekFolder) = _fileResolver.ExtractFolderStructure(payerPolicyFile);
            outFile = _outputPathBuilder.BuildOutputPath(
                _options.OutputRoot,
                lab.LabName,
                runId,
                yearFolder,
                monthFolder,
                weekFolder);

            await _stepLogger.LogAsync(
                lab,
                "Start",
                "InProgress",
                payerPolicyFile,
                claimActionMapperFile,
                outFile,
                null,
                ct);

            // 1. Load existing tasks
            var existingTasks = await _denialTaskBoardRepo.GetExistingTasksAsync(lab.LabId);

            // 2. Load Claim Action Mapper
            await _stepLogger.LogAsync(
                lab,
                "Load ClaimActionMapper excel",
                "InProgress",
                payerPolicyFile,
                claimActionMapperFile,
                outFile,
                null,
                ct);

            var claimRows = _excelReader.Read(claimActionMapperFile, "Denial Classifier");
            var claimMapperIndex = new ClaimActionMapperIndex(claimRows);

            await _stepLogger.LogAsync(
                lab,
                "Load ClaimActionMapper excel",
                "Completed",
                payerPolicyFile,
                claimActionMapperFile,
                outFile,
                null,
                ct);

            // 3. Load Payer Policy
            await _stepLogger.LogAsync(
                lab,
                "Load PayerPolicy excel",
                "InProgress",
                payerPolicyFile,
                claimActionMapperFile,
                outFile,
                null,
                ct);

            var payerRows = _excelReader.Read(payerPolicyFile);

            await _stepLogger.LogAsync(
                lab,
                "Load PayerPolicy excel",
                "Completed",
                payerPolicyFile,
                claimActionMapperFile,
                outFile,
                null,
                ct);

            // 4. Normalize + map
            await _stepLogger.LogAsync(
                lab,
                "Normalize DenialCode + map fields",
                "InProgress",
                payerPolicyFile,
                claimActionMapperFile,
                outFile,
                null,
                ct);

            var (headers, finalRows) = _builder.Build(payerRows, claimMapperIndex);

            await _stepLogger.LogAsync(
                lab,
                "Normalize DenialCode + map fields",
                "Completed",
                payerPolicyFile,
                claimActionMapperFile,
                outFile,
                null,
                ct);

            // 5. Build insight
            await _stepLogger.LogAsync(
                lab,
                "Build insight rows",
                "InProgress",
                payerPolicyFile,
                claimActionMapperFile,
                outFile,
                null,
                ct);

            var insight = _insightBuilder.Build(finalRows);

            await _stepLogger.LogAsync(
                lab,
                "Build insight rows",
                "Completed",
                payerPolicyFile,
                claimActionMapperFile,
                outFile,
                null,
                ct);

            // 6. Build task board
            await _stepLogger.LogAsync(
                lab,
                "Build task board rows",
                "InProgress",
                payerPolicyFile,
                claimActionMapperFile,
                outFile,
                null,
                ct);

            var taskBuilder = new TaskBoardBuilder(lab.LabId, lab.LabName, runId, existingTasks);
            var taskRows = taskBuilder.Build(finalRows);

            await _stepLogger.LogAsync(
                lab,
                "Build task board rows",
                "Completed",
                payerPolicyFile,
                claimActionMapperFile,
                outFile,
                null,
                ct);

            // 7. Write Excel
            await _stepLogger.LogAsync(
                lab,
                "Write DenialDatabase excel",
                "InProgress",
                payerPolicyFile,
                claimActionMapperFile,
                outFile,
                null,
                ct);

            _excelWriter.Write(
                outFile,
                headers,
                finalRows,
                insight.Headers,
                insight.Rows,
                taskRows);

            await _stepLogger.LogAsync(
                lab,
                "Write DenialDatabase excel",
                "Completed",
                payerPolicyFile,
                claimActionMapperFile,
                outFile,
                null,
                ct);

            // 8. Resolve mapper root + mapper paths
            var mapperRoot = ResolveMapperRoot(lab, claimActionMapperFile);

            var insightMapperRelative = _config["DenialDatabaseProcessor:DenialInshightMapperPath"];
            var lineItemMapperRelative = _config["DenialDatabaseProcessor:DenialLineItemMapperPath"];
            var taskBoardMapperRelative = _config["DenialDatabaseProcessor:TaskBoardMapperPath"];

            if (string.IsNullOrWhiteSpace(insightMapperRelative))
                throw new InvalidOperationException("Config missing: DenialDatabaseProcessor:DenialInshightMapperPath");

            if (string.IsNullOrWhiteSpace(lineItemMapperRelative))
                throw new InvalidOperationException("Config missing: DenialDatabaseProcessor:DenialLineItemMapperPath");

            if (string.IsNullOrWhiteSpace(taskBoardMapperRelative))
                throw new InvalidOperationException("Config missing: DenialDatabaseProcessor:TaskBoardMapperPath");

            var insightMapperPath = Path.Combine(mapperRoot, insightMapperRelative);
            var lineItemMapperPath = Path.Combine(mapperRoot, lineItemMapperRelative);
            var taskBoardMapperPath = Path.Combine(mapperRoot, taskBoardMapperRelative);

            ValidateMapperFileExists(insightMapperPath, nameof(insightMapperPath));
            ValidateMapperFileExists(lineItemMapperPath, nameof(lineItemMapperPath));
            ValidateMapperFileExists(taskBoardMapperPath, nameof(taskBoardMapperPath));

            // 9. Create bulk writers
            var insightWriter = new DenialInsightBulkWriter(
                lab.LabConnectionString,
                insightMapperPath);

            var lineItemWriter = new DenialLineItemBulkWriter(
                lab.LabConnectionString,
                lineItemMapperPath);

            var taskBoardWriter = new DenialTaskBoardBulkWriter(
                lab.LabConnectionString,
                taskBoardMapperPath);

            // 10. Write database tables  <-- MISSING IN YOUR CURRENT CODE
            await _stepLogger.LogAsync(
                lab,
                "Write Denial tables",
                "InProgress",
                payerPolicyFile,
                claimActionMapperFile,
                outFile,
                null,
                ct);

            await insightWriter.WriteAsync(insight.Rows, lab, runId);
            await lineItemWriter.WriteAsync(finalRows, lab, runId);
            await taskBoardWriter.WriteAsync(taskRows, lab, runId);

            await _stepLogger.LogAsync(
                lab,
                "Write Denial tables",
                "Completed",
                payerPolicyFile,
                claimActionMapperFile,
                outFile,
                null,
                ct);

            // 11. Insert RunLog
            await _runLogRepo.InsertAsync(runId, lab.LabId, outFile);

            // 12. Upload to SharePoint
            await _stepLogger.LogAsync(
                lab,
                "Upload to SharePoint",
                "InProgress",
                payerPolicyFile,
                claimActionMapperFile,
                outFile,
                null,
                ct);

            await _uploader.UploadIfEnabledAsync(lab, outFile, DateTime.Now, ct);

            await _stepLogger.LogAsync(
                lab,
                "Upload to SharePoint",
                "Completed",
                payerPolicyFile,
                claimActionMapperFile,
                outFile,
                null,
                ct);

            await _stepLogger.LogAsync(
                lab,
                "Completed",
                "Completed",
                payerPolicyFile,
                claimActionMapperFile,
                outFile,
                null,
                ct);
        }
        catch (Exception ex)
        {
            _logger.LogError(ex, "Lab processing failed: {LabName}", lab.LabName);

            await _errorLogger.LogAsync(
                string.IsNullOrWhiteSpace(runId) ? "UNKNOWN" : runId,
                lab.LabName,
                "ProcessLabAsync",
                string.IsNullOrWhiteSpace(payerPolicyFile) ? string.Empty : Path.GetFileName(payerPolicyFile),
                payerPolicyFile,
                ex,
                ct);

            await _stepLogger.LogAsync(
                lab,
                "Failed",
                "ERROR",
                payerPolicyFile,
                claimActionMapperFile,
                outFile,
                ex.ToString(),
                ct);

            await NotifyFileUploadFailedAsync(
                "Denial Analysis Report",
                payerPolicyFile,
                lab.SharePointUploadPath,
                ex,
                ct);
        }
    }

    private string ResolveMapperRoot(LabConfig lab, string claimActionMapperFile)
    {
        // Prefer explicit config from lab.ClaimActionMapper.
        // If it is a file path, use its directory.
        // If it is a directory path, use it directly.
        // Otherwise fall back to the directory of the resolved latest mapper excel.

        if (!string.IsNullOrWhiteSpace(lab.ClaimActionMapper))
        {
            if (Directory.Exists(lab.ClaimActionMapper))
                return lab.ClaimActionMapper;

            if (File.Exists(lab.ClaimActionMapper))
                return Path.GetDirectoryName(lab.ClaimActionMapper)
                       ?? throw new InvalidOperationException(
                           $"Unable to resolve mapper root from file path: {lab.ClaimActionMapper}");
        }

        if (!string.IsNullOrWhiteSpace(claimActionMapperFile) && File.Exists(claimActionMapperFile))
        {
            return Path.GetDirectoryName(claimActionMapperFile)
                   ?? throw new InvalidOperationException(
                       $"Unable to resolve mapper root from claimActionMapperFile: {claimActionMapperFile}");
        }

        throw new DirectoryNotFoundException(
            $"Unable to resolve mapper root. lab.ClaimActionMapper='{lab.ClaimActionMapper}', claimActionMapperFile='{claimActionMapperFile}'.");
    }

    private static void ValidateMapperFileExists(string path, string name)
    {
        if (string.IsNullOrWhiteSpace(path) || !File.Exists(path))
            throw new FileNotFoundException($"Mapper file not found for {name}: {path}", path);
    }

    private Task NotifyFileSynchronizedAsync(string fileType, string remotePath, string localPath, CancellationToken ct)
    {
        var fileName = Path.GetFileName(localPath);
        var remoteUrl = SharePointWebLinkBuilder.TryBuildFileUrl(_spOpt, remotePath);

        var message = new StringBuilder()
            .AppendLine("🟢 File synchronized successfully.\n")
            .AppendLine($"📁 Type: {fileType}  \n")
            .AppendLine(string.IsNullOrWhiteSpace(remoteUrl)
                ? $"📁 Source: {remotePath}\n"
                : $"📄 Source: [{fileName}]({remoteUrl})\n")
            .Append($"Destination: {localPath}")
            .ToString();

        return _teamsNotifier.SendAsync("🤖 LRN : Denial Database Processor", message, ct);
    }

    private Task NotifyFileUploadFailedAsync(string fileType, string localFile, string remotePath, Exception ex, CancellationToken ct)
    {
        var fileName = Path.GetFileName(localFile);
        var remoteUrl = SharePointWebLinkBuilder.TryBuildFileUrl(_spOpt, remotePath);

        var message = new StringBuilder()
            .AppendLine("⚠️ File upload failed.\n")
            .AppendLine($"Type: {fileType} \n")
            .AppendLine(string.IsNullOrWhiteSpace(remoteUrl)
                ? $"📁 SharePoint: {remotePath}\n"
                : $"📄 SharePoint: [{fileName}]({remoteUrl})\n")
            .AppendLine($"Source: {localFile} \n")
            .Append($"Error: {ex.Message}")
            .ToString();

        return _teamsNotifier.SendAsync("🤖 LRN : Denial Database Processor", message, ct);
    }
}