using System.Data;
using System.Text;
using DenialDatabaseProcessorWorker.Builders;
using DenialDatabaseProcessorWorker.BulkWriters;
using DenialDatabaseProcessorWorker.Models;
using DenialDatabaseProcessorWorker.Normalizers;
using DenialDatabaseProcessorWorker.Notifications;
using DenialDatabaseProcessorWorker.Services;
using DenialDatabaseProcessorWorker.Services.SharePoint;
using DenialDatabaseProcessorWorker.Utils;
using Microsoft.Extensions.Hosting;
using Microsoft.Extensions.Logging;
using Microsoft.Extensions.Options;

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
    private readonly SharePointGraphOptions _spOpt;

    public DenialDatabaseWorker(
        ILogger<DenialDatabaseWorker> logger,
        IOptions<ProcessorOptions> options,
        IOptions<List<LabConfig>> labs,
        CsvStepLogger stepLogger,
        ExcelTableReader excelReader,
        DenialDatabaseBuilder builder,
        ExcelWriter excelWriter,
        ITeamsNotifier teamsNotifier,
        DenialInsightBuilder insightBuilder,
        FileResolver fileResolver,
        OutputPathBuilder outputPathBuilder,
        DenialAnalysisRunLogRepository runLogRepo,
        DenialTaskBoardRepository denialTaskBoardRepo,
        ISharePointUploader uploader,
        IOptions<SharePointGraphOptions> spOpt)
    {
        _logger = logger;
        _options = options.Value;
        _labs = labs.Value;
        _stepLogger = stepLogger;
        _excelReader = excelReader;
        _builder = builder;
        _excelWriter = excelWriter;
        _insightBuilder = insightBuilder;
        _fileResolver = fileResolver;
        _outputPathBuilder = outputPathBuilder;
        _runLogRepo = runLogRepo;
        _denialTaskBoardRepo = denialTaskBoardRepo;
        _uploader = uploader;
        _spOpt = spOpt.Value;
        _teamsNotifier = teamsNotifier;
    }

    protected override async Task ExecuteAsync(CancellationToken stoppingToken)
    {
        if (_options.RunOnceOnStartup)
        {
            foreach (var lab in _labs)
                await ProcessLabAsync(lab, stoppingToken);

            _logger.LogInformation("RunOnceOnStartup=true. Worker completed.");
        }
        else
        {
            while (!stoppingToken.IsCancellationRequested)
            {
                foreach (var lab in _labs)
                    await ProcessLabAsync(lab, stoppingToken);

                await Task.Delay(TimeSpan.FromMinutes(_options.IntervalMinutes), stoppingToken);
            }
        }
    }

    private async Task ProcessLabAsync(LabConfig lab, CancellationToken ct)
    {
        string payerPolicyFile = "";
        string claimActionMapperFile = "";
        string outFile = "";
        string runId = "";

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
                _logger.LogInformation("RunId {RunId} already processed. Skipping lab {LabName}.", runId, lab.LabName);
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

            await _stepLogger.LogAsync(lab, "Start", "InProgress", payerPolicyFile, claimActionMapperFile, outFile, null, ct);

            // 1. Load existing tasks
            var existingTasks = await _denialTaskBoardRepo.GetExistingTasksAsync(lab.LabId);

            // 2. Load Claim Action Mapper
            await _stepLogger.LogAsync(lab, "Load ClaimActionMapper excel", "InProgress", payerPolicyFile, claimActionMapperFile, outFile, null, ct);
            var claimRows = _excelReader.Read(claimActionMapperFile, "Denial Classifier");
            var claimMapperIndex = new ClaimActionMapperIndex(claimRows);
            await _stepLogger.LogAsync(lab, "Load ClaimActionMapper excel", "Completed", payerPolicyFile, claimActionMapperFile, outFile, null, ct);

            // 3. Load Payer Policy
            await _stepLogger.LogAsync(lab, "Load PayerPolicy excel", "InProgress", payerPolicyFile, claimActionMapperFile, outFile, null, ct);
            var payerRows = _excelReader.Read(payerPolicyFile);
            await _stepLogger.LogAsync(lab, "Load PayerPolicy excel", "Completed", payerPolicyFile, claimActionMapperFile, outFile, null, ct);

            // 4. Normalize + map
            await _stepLogger.LogAsync(lab, "Normalize DenialCode + map fields", "InProgress", payerPolicyFile, claimActionMapperFile, outFile, null, ct);
            var (headers, finalRows) = _builder.Build(payerRows, claimMapperIndex);

            // Lab-specific insurance amount rule:
            // Augustus (19), Certus (18), and NorthWest (20) must use Billed Amount
            // as Insurance Balance for insight, task-board creation, Excel export, and DB inserts.
            ApplyLabSpecificInsuranceBalanceRule(lab, finalRows);

            await _stepLogger.LogAsync(lab, "Normalize DenialCode + map fields", "Completed", payerPolicyFile, claimActionMapperFile, outFile, null, ct);

            // 5. Build insight
            await _stepLogger.LogAsync(lab, "Build insight rows", "InProgress", payerPolicyFile, claimActionMapperFile, outFile, null, ct);
            var insight = _insightBuilder.Build(finalRows);
            await _stepLogger.LogAsync(lab, "Build insight rows", "Completed", payerPolicyFile, claimActionMapperFile, outFile, null, ct);

            // 6. Build task board
            await _stepLogger.LogAsync(lab, "Build task board rows", "InProgress", payerPolicyFile, claimActionMapperFile, outFile, null, ct);
            var taskBuilder = new TaskBoardBuilder(lab.LabId, lab.LabName, runId, existingTasks);
            var taskRows = taskBuilder.Build(finalRows);
            await _stepLogger.LogAsync(lab, "Build task board rows", "Completed", payerPolicyFile, claimActionMapperFile, outFile, null, ct);

            // 7. Write Excel
            await _stepLogger.LogAsync(lab, "Write DenialDatabase excel", "InProgress", payerPolicyFile, claimActionMapperFile, outFile, null, ct);

            var filteredLineRows = finalRows
              .Where(r =>
                  r.TryGetValue("DenialCode_Original", out var originalCode) &&
                  !string.IsNullOrWhiteSpace(originalCode))
              .ToList();

            var exportResult = _excelWriter.Write(
                                outFile,
                                insight.Headers,
                                insight.Rows,
                                filteredLineRows,
                                taskRows,
                                null,
                                null);

            await _stepLogger.LogAsync(lab, "Write DenialDatabase export package", "Completed", payerPolicyFile, claimActionMapperFile, exportResult.ZipPath, null, ct);

            // 8. Convert rows to DataTables (simple, column-per-key)
            var insightTable = ToDataTable(insight.Rows);
            var lineItemTable = DenialLineItemTableBuilder.Build(filteredLineRows,lab,runId);
            var taskBoardTable = ToDataTable(taskRows);

            // 9. Bulk writers (manual, per-lab connection string)
            var insightWriter = new DenialInsightBulkWriter(lab.LabConnectionString);
            var lineItemWriter = new DenialLineItemBulkWriter(lab.LabConnectionString);
            var taskBoardWriter = new DenialTaskBoardBulkWriter(lab.LabConnectionString);

            // 10. Write DB tables
            await _stepLogger.LogAsync(lab, "Write Denial tables", "InProgress", payerPolicyFile, claimActionMapperFile, outFile, null, ct);

            await insightWriter.WriteAsync(insightTable, lab, runId);
            await lineItemWriter.WriteAsync(lineItemTable, lab, runId);
            await taskBoardWriter.WriteAsync(taskBoardTable, lab, runId);

            await _stepLogger.LogAsync(lab, "Write Denial tables", "Completed", payerPolicyFile, claimActionMapperFile, outFile, null, ct);

            // 11. Insert RunLog
            await _runLogRepo.InsertAsync(runId, lab.LabId, exportResult.ZipPath);

            // 12. Upload to SharePoint
            await _stepLogger.LogAsync(lab, "Upload to SharePoint", "InProgress", payerPolicyFile, claimActionMapperFile, outFile, null, ct);
            await _uploader.UploadIfEnabledAsync(lab, exportResult.ZipPath, DateTime.Now, ct);
            await _stepLogger.LogAsync(lab, "Upload to SharePoint", "Completed", payerPolicyFile, claimActionMapperFile, outFile, null, ct);

            await _stepLogger.LogAsync(lab, "Completed", "Completed", payerPolicyFile, claimActionMapperFile, outFile, null, ct);
        }
        catch (Exception ex)
        {
            _logger.LogError(ex, "Lab processing failed: {LabName}", lab.LabName);
            await _stepLogger.LogAsync(lab, "Failed", "Failed", payerPolicyFile, claimActionMapperFile, outFile, ex.ToString(), ct);
        }
    }

    private static DataTable ToDataTable(List<Dictionary<string, string>> rows)
    {
        var table = new DataTable();

        if (rows.Count == 0)
            return table;

        // Create columns
        foreach (var key in rows[0].Keys)
            table.Columns.Add(key, typeof(string));

        // Normalized INT column names (SQL names)
        string[] intColumns =
                    {"PaymentDays",
                    "Payment Days"  };

        foreach (var row in rows)
        {
            var dr = table.NewRow();

            foreach (var kv in row)
            {
                var value = kv.Value?.Trim();

                //// Normalize the Excel key so ANY variation matches
                //var normalizedKey = kv.Key
                //	.Replace(" ", "")
                //	.Replace("_", "")
                //	.Replace("-", "")
                //	.Replace("(", "")
                //	.Replace(")", "")
                //	.Trim()
                //	.ToLower();

                // ⭐ FIX 1: Clean percentage values
                if (!string.IsNullOrEmpty(value) && value.EndsWith("%"))
                {
                    var cleaned = value.Replace("%", "");
                    if (decimal.TryParse(cleaned, out var dec))
                        dr[kv.Key] = dec.ToString();
                    else
                        dr[kv.Key] = DBNull.Value;

                    continue;
                }

                // ⭐ FIX 2: Universal INT cleaner (handles ANY Excel variation)
                if (intColumns.Contains(kv.Key))
                {
                    // If Excel put a date → NULL
                    if (DateTime.TryParse(value, out _))
                    {
                        dr[kv.Key] = DBNull.Value;
                        continue;
                    }

                    // If numeric → keep it
                    if (int.TryParse(value, out var intVal))
                    {
                        dr[kv.Key] = intVal;
                        continue;
                    }

                    // Anything else → NULL
                    dr[kv.Key] = DBNull.Value;
                    continue;
                }

                // ⭐ FIX 3: Empty → NULL
                if (string.IsNullOrWhiteSpace(value))
                {
                    dr[kv.Key] = DBNull.Value;
                    continue;
                }

                // Default: keep as string
                dr[kv.Key] = value;
            }

            table.Rows.Add(dr);
        }

        return table;
    }

    private static void ApplyLabSpecificInsuranceBalanceRule(LabConfig lab, List<Dictionary<string, string>> rows)
    {
        if (!ShouldUseBilledAmountAsInsuranceBalance(lab) || rows == null || rows.Count == 0)
            return;

        foreach (var row in rows)
        {
            var billedAmount = GetValueByAnyKey(row, "Billed Amount", "BilledAmount");

            // Keep the target Excel-style key because builders/export mapping read "Insurance Balance".
            row["Insurance Balance"] = billedAmount;

            // Keep the SQL-style key in sync in case a later mapper/table builder reads this form.
            row["InsuranceBalance"] = billedAmount;
        }
    }

    private static bool ShouldUseBilledAmountAsInsuranceBalance(LabConfig lab)
    {
        if (lab == null)
            return false;

        if (lab.LabId is 18 or 19 or 20)
            return true;

        var labName = lab.LabName?.Trim() ?? string.Empty;

        return labName.Contains("Certus", StringComparison.OrdinalIgnoreCase)
            || labName.Contains("Augustus", StringComparison.OrdinalIgnoreCase)
            || labName.Contains("NorthWest", StringComparison.OrdinalIgnoreCase)
            || labName.Contains("Northwest", StringComparison.OrdinalIgnoreCase)
            || labName.Contains("North West", StringComparison.OrdinalIgnoreCase);
    }

    private static string GetValueByAnyKey(Dictionary<string, string> row, params string[] keys)
    {
        foreach (var key in keys)
        {
            if (row.TryGetValue(key, out var value))
                return value ?? string.Empty;

            var actualKey = row.Keys.FirstOrDefault(k => string.Equals(k, key, StringComparison.OrdinalIgnoreCase));
            if (actualKey != null && row.TryGetValue(actualKey, out value))
                return value ?? string.Empty;
        }

        return string.Empty;
    }

    private Task NotifyFileSynchronizedAsync(string fileType, string remotePath, string localPath, CancellationToken ct)
    {
        var fileName = Path.GetFileName(localPath);
        var remoteUrl = SharePointWebLinkBuilder.TryBuildFileUrl(_spOpt, remotePath);

        var message = new StringBuilder()
            .AppendLine("🟢 File synchronized successfully.\n")
            .AppendLine($"📁 Type: {fileType} \n")
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