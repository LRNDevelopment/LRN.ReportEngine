using Common.Logging;
using LRN.DataLibrary.Abstractions;
using LRN.DataLibrary.Entities;
using System.Text;

namespace Common.Logging.ProcessLogging;

public sealed class ProcessLogService
{
    private readonly ILoggerService _log;
    private readonly ILrnLogRepository _repo;

    public ProcessLogService(ILoggerService log, ILrnLogRepository repo)
    {
        _log = log;
        _repo = repo;
    }

    public async Task<(RunContext Ctx, LrnRunLog Run)> StartRunAsync(int labId, string labName, string workRoot, string sourceSystem, CancellationToken ct)
    {
        var run = await _repo.CreateRunAsync(labId, labName, sourceSystem, ct);

        var runDir = Path.Combine(workRoot, labName, run.RunID.ToString());
        Directory.CreateDirectory(runDir);

        var ctx = new RunContext
        {
            RunId = run.RunID,
            LabId = labId,
            LabName = labName,
            WorkDir = runDir,
            StepLogCsvPath = Path.Combine(runDir, $"LRN_STEP_LOG_{run.RunID}.csv"),
            ErrorLogCsvPath = Path.Combine(runDir, $"LRN_ERROR_LOG_{run.RunID}.csv"),
            RunSummaryCsvPath = Path.Combine(runDir, $"LRN_RUN_LOG_{run.RunID}.csv")
        };

        // Create empty CSVs with headers so you'll always get a file uploaded even if the run crashes early.
        ProcessLogCsvWriter.EnsureHeaders(ctx.StepLogCsvPath, StepHeaders);
        ProcessLogCsvWriter.EnsureHeaders(ctx.ErrorLogCsvPath, ErrorHeaders);

        WriteRunSummary(ctx, run);
        _log.Info($"Run started. RunID={run.RunID}, Lab={labName}, WorkDir={runDir}");

        return (ctx, run);
    }

    public async Task<StepContext> StartStepAsync(RunContext runCtx, string labName, long runId, int stepSeq, string stepName, string stepCategory,
        string sourceSystem, string? fileIn, string? pathIn, long? recordsIn, CancellationToken ct)
    {
        var step = await _repo.StartStepAsync(runId, labName, stepSeq, stepName, stepCategory, sourceSystem, fileIn, pathIn, recordsIn, ct);

        _log.Info($"Step started. RunID={runId}, StepSeq={stepSeq}, Step={stepName}");

        return new StepContext
        {
            StepLogId = step.StepLogId,
            StepSeq = stepSeq,
            StepName = stepName,
            StepCategory = stepCategory,
            StartTimeUtc = step.StartTimeUSST,
            RecordsIn = recordsIn,
            FileNameIn = fileIn,
            PathIn = pathIn
        };
    }

    public async Task CompleteStepAsync(RunContext runCtx, long runId, string labName, StepContext step,
        string sourceSystem, string status, long? recordsOut, string? fileOut, string? pathOut,
        string? errorCode, string? errorMessage, string? errorDetail, CancellationToken ct)
    {
        await _repo.CompleteStepAsync(step.StepLogId, status, recordsOut, fileOut, pathOut, errorCode, errorMessage, errorDetail, ct);

        var end = DateTimeOffset.UtcNow;

        ProcessLogCsvWriter.AppendRow(runCtx.StepLogCsvPath, StepHeaders, new Dictionary<string, string?>
        {
            ["RunID"] = runId.ToString(),
            ["LabName"] = labName,
            ["StepSeq"] = step.StepSeq.ToString(),
            ["StepName"] = step.StepName,
            ["StepCategory"] = step.StepCategory,
            ["SourceSystem"] = sourceSystem,
            ["StartTimeUSST"] = step.StartTimeUtc.ToString("O"),
            ["EndTimeUSST"] = end.ToString("O"),
            ["Status"] = status,
            ["RecordsIn"] = step.RecordsIn?.ToString(),
            ["RecordsOut"] = recordsOut?.ToString(),
            ["FileNameIn"] = step.FileNameIn,
            ["FileNameOut"] = fileOut,
            ["PathIn"] = step.PathIn,
            ["PathOut"] = pathOut,
            ["ErrorCode"] = errorCode,
            ["ErrorMessage"] = errorMessage,
            ["ErrorDetail"] = errorDetail,
            ["RetryCount"] = "0",
            ["ExecutedBy"] = Environment.UserName,
            ["Host"] = Environment.MachineName,
            ["ModuleVersion"] = typeof(ProcessLogService).Assembly.GetName().Version?.ToString()
        });

        if (status == LrnStatuses.Failed)
            _log.Error($"Step failed. RunID={runId}, StepSeq={step.StepSeq}, Step={step.StepName}. {errorMessage}");
        else
            _log.Info($"Step completed. RunID={runId}, StepSeq={step.StepSeq}, Step={step.StepName}, Status={status}");
    }

    public async Task LogErrorAsync(RunContext runCtx, LrnErrorLog err, CancellationToken ct)
    {
        await _repo.LogErrorAsync(err, ct);

        ProcessLogCsvWriter.AppendRow(runCtx.ErrorLogCsvPath, ErrorHeaders, new Dictionary<string, string?>
        {
            ["RunID"] = err.RunID.ToString(),
            ["LabName"] = err.LabName,
            ["ErrorTimeIST"] = err.ErrorTimeIST.ToString("O"),
            ["Severity"] = err.Severity,
            ["StepName"] = err.StepName,
            ["ErrorCode"] = err.ErrorCode,
            ["ErrorSummary"] = err.ErrorSummary,
            ["MissingColumns"] = err.MissingColumns,
            ["SheetName"] = err.SheetName,
            ["FileName"] = err.FileName,
            ["FilePath"] = err.FilePath,
            ["RecommendedAction"] = err.RecommendedAction,
            ["SourceSystem"] = err.SourceSystem,
            ["Status"] = err.Status
        });

        if (string.Equals(err.Severity, "Warning", StringComparison.OrdinalIgnoreCase))
            _log.Warn($"[{err.LabName}] {err.ErrorSummary}");
        else
            _log.Error($"[{err.LabName}] {err.ErrorSummary}");
    }

    public async Task CompleteRunAsync(RunContext ctx, LrnRunLog run, string overallStatus, string? notes, CancellationToken ct)
    {
        run.EndTimeUSST = DateTimeOffset.UtcNow;
        run.OverallStatus = overallStatus;
        run.Notes = notes;
        await _repo.UpdateRunAsync(run, ct);

        WriteRunSummary(ctx, run);
        _log.Info($"Run completed. RunID={run.RunID}, Status={overallStatus}");
    }

    private static readonly string[] StepHeaders =
    {
        "RunID","LabName","StepSeq","StepName","StepCategory","SourceSystem","StartTimeUSST","EndTimeUSST","Status",
        "RecordsIn","RecordsOut","FileNameIn","FileNameOut","PathIn","PathOut","ErrorCode","ErrorMessage","ErrorDetail",
        "RetryCount","ExecutedBy","Host","ModuleVersion"
    };

    private static readonly string[] ErrorHeaders =
    {
        "RunID","LabName","ErrorTimeIST","Severity","StepName","ErrorCode","ErrorSummary","MissingColumns","SheetName",
        "FileName","FilePath","RecommendedAction","SourceSystem","Status"
    };

    private static readonly string[] RunHeaders =
    {
        "RunID","LabId","LabName","StartTimeUSST","EndTimeUSST","OverallStatus","SourceSystem","UpdatedOn","LatestMasterFileFound",
        "InputMasterSharePointPath","InputMasterFileName","InputMasterFileModifiedTime","MandatoryColumnCheck","SplitOutputWrittenToSharePoint",
        "PayerPolicyValidationStatus","CodingValidationStatus","AveragesProcessStatus","OutputsCopiedToSharePoint","MasterSyncPerformed",
        "TotalErrors","TotalWarnings","Notes"
    };

    private static void WriteRunSummary(RunContext ctx, LrnRunLog run)
    {
		Directory.CreateDirectory(Path.GetDirectoryName(ctx.RunSummaryCsvPath) ?? AppContext.BaseDirectory);

		var utf8NoBom = new UTF8Encoding(encoderShouldEmitUTF8Identifier: false);
		using var sw = new StreamWriter(ctx.RunSummaryCsvPath, append: false, encoding: utf8NoBom);

		sw.WriteLine(string.Join(',', RunHeaders.Select(Escape)));

		var row = new Dictionary<string, string?>
        {
            ["RunID"] = run.RunID.ToString(),
            ["LabId"] = run.LabId.ToString(),
            ["LabName"] = run.LabName,
            ["StartTimeUSST"] = run.StartTimeUSST.ToString("O"),
            ["EndTimeUSST"] = run.EndTimeUSST?.ToString("O"),
            ["OverallStatus"] = run.OverallStatus,
            ["SourceSystem"] = run.SourceSystem,
            ["UpdatedOn"] = run.UpdatedOn.ToString("O"),
            ["LatestMasterFileFound"] = run.LatestMasterFileFound.ToString(),
            ["InputMasterSharePointPath"] = run.InputMasterSharePointPath,
            ["InputMasterFileName"] = run.InputMasterFileName,
            ["InputMasterFileModifiedTime"] = run.InputMasterFileModifiedTime?.ToString("O"),
            ["MandatoryColumnCheck"] = run.MandatoryColumnCheck,
            ["SplitOutputWrittenToSharePoint"] = run.SplitOutputWrittenToSharePoint,
            ["PayerPolicyValidationStatus"] = run.PayerPolicyValidationStatus,
            ["CodingValidationStatus"] = run.CodingValidationStatus,
            ["AveragesProcessStatus"] = run.AveragesProcessStatus,
            ["OutputsCopiedToSharePoint"] = run.OutputsCopiedToSharePoint,
            ["MasterSyncPerformed"] = run.MasterSyncPerformed.ToString(),
            ["TotalErrors"] = run.TotalErrors.ToString(),
            ["TotalWarnings"] = run.TotalWarnings.ToString(),
            ["Notes"] = run.Notes
        };

        var line = string.Join(',', RunHeaders.Select(h => Escape(row.TryGetValue(h, out var v) ? v : null)));
        sw.WriteLine(line);
    }

    private static string Escape(string? value)
    {
        value ??= string.Empty;
        var mustQuote = value.Contains(',') || value.Contains('"') || value.Contains('\n') || value.Contains('\r');
        if (!mustQuote) return value;
        return "\"" + value.Replace("\"", "\"\"") + "\"";
    }
}
