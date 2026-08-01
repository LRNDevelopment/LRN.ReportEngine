using System.Diagnostics;

namespace LRN.MasterFileProcessorWorker.BulkLoad;

/// <summary>Everything the import needs about the file being loaded, from the worker's run context.</summary>
public sealed record LineClaimImportRequest(
    string RunId,
    string? WeekFolder,
    string? SourceFullPath,
    string? SourceFileName,
    DateTime? FileCreatedDateTime,
    string LineLevelCsvPath,
    string ClaimLevelCsvPath);

public sealed record LineClaimImportOutcome(string FileType, bool Succeeded, bool Skipped, long RowsCopied, string? Message);

/// <summary>
/// Per-lab, per-level import: file log -> bulk load -> verify -> run info log -> workflow tracker.
/// <para>
/// One lab's failure never aborts another: <see cref="ImportAllLabsAsync"/> isolates each lab, and
/// within a lab each level is isolated too. Failures are logged everywhere and the loop continues.
/// </para>
/// <para>
/// This service is purely additive. It does not touch LRN_Run_Log / LRN_Step_Log / LRN_Error_Log,
/// which the worker keeps writing exactly as before.
/// </para>
/// </summary>
public sealed class LineClaimImportService
{
    private readonly LineClaimBulkLoader _loader;
    private readonly LineClaimFileLogRepository _fileLog;
    private readonly ReportRunIdInfoLogger _runInfo;
    private readonly ReportsWorkflowTrackerRepository _tracker;
    private readonly ILogger<LineClaimImportService> _logger;

    public LineClaimImportService(
        LineClaimBulkLoader loader,
        LineClaimFileLogRepository fileLog,
        ReportRunIdInfoLogger runInfo,
        ReportsWorkflowTrackerRepository tracker,
        ILogger<LineClaimImportService> logger)
    {
        _loader = loader;
        _fileLog = fileLog;
        _runInfo = runInfo;
        _tracker = tracker;
        _logger = logger;
    }

    /// <summary>Imports both levels for every resolved lab. Never throws for a single lab's failure.</summary>
    public async Task<IReadOnlyList<LineClaimImportOutcome>> ImportAllLabsAsync(
        IReadOnlyList<ResolvedLab> labs,
        Func<ResolvedLab, LineClaimImportRequest?> requestFactory,
        CancellationToken ct)
    {
        var outcomes = new List<LineClaimImportOutcome>();

        foreach (var lab in labs)
        {
            ct.ThrowIfCancellationRequested();

            LineClaimImportRequest? request;

            try
            {
                request = requestFactory(lab);
            }
            catch (Exception ex)
            {
                _logger.LogError(ex, "Lab {LabId}: could not build the import request. Skipping this lab.", lab.LabId);
                continue;
            }

            if (request is null)
                continue;

            outcomes.AddRange(await ImportLabAsync(lab, request, ct).ConfigureAwait(false));
        }

        return outcomes;
    }

    public async Task<IReadOnlyList<LineClaimImportOutcome>> ImportLabAsync(
        ResolvedLab lab,
        LineClaimImportRequest request,
        CancellationToken ct)
    {
        var results = new List<LineClaimImportOutcome>(2);

        results.Add(await ImportLevelAsync(lab, request, FileTypes.LineLevel, lab.Mapping.LineLevel,
            request.LineLevelCsvPath, WorkflowReportNames.LineLevelMaster, ct).ConfigureAwait(false));

        results.Add(await ImportLevelAsync(lab, request, FileTypes.ClaimLevel, lab.Mapping.ClaimLevel,
            request.ClaimLevelCsvPath, WorkflowReportNames.ClaimLevelMaster, ct).ConfigureAwait(false));

        return results;
    }

    private async Task<LineClaimImportOutcome> ImportLevelAsync(
        ResolvedLab lab,
        LineClaimImportRequest request,
        string fileType,
        LevelMapping? level,
        string csvPath,
        string reportName,
        CancellationToken ct)
    {
        var startedOn = ReportRunIdInfoLogger.IstNow();
        var sourceSystem = lab.LabName;
        var stopwatch = Stopwatch.StartNew();

        // ---- skip paths. Every one is logged; none is silent. ----
        var skipReason = ResolveSkipReason(level);

        if (skipReason is not null)
        {
            _logger.LogInformation("Lab {LabId} [{FileType}]: skipped - {Reason}", lab.LabId, fileType, skipReason);

            await _runInfo.InfoAsync(request.RunId, fileType, sourceSystem,
                $"{fileType} skipped for lab {lab.LabName} ({lab.LabId}): {skipReason}", ct, Path.GetFileName(csvPath)).ConfigureAwait(false);

            await _tracker.UpsertAsync(request.RunId, lab.LabId, lab.LabName, request.WeekFolder,
                reportName, fileType, WorkflowStatus.Skipped, null, startedOn,
                ReportRunIdInfoLogger.IstNow(), skipReason, ct).ConfigureAwait(false);

            return new LineClaimImportOutcome(fileType, Succeeded: true, Skipped: true, 0, skipReason);
        }

        long fileLogId = 0;

        try
        {
            await _runInfo.StartAsync(request.RunId, fileType, sourceSystem,
                $"{fileType} bulk copy started for lab {lab.LabName} ({lab.LabId}). Source: {request.SourceFileName}", ct, Path.GetFileName(csvPath))
                .ConfigureAwait(false);

            await _tracker.UpsertAsync(request.RunId, lab.LabId, lab.LabName, request.WeekFolder,
                reportName, fileType, WorkflowStatus.InProgress, null, startedOn, null, null, ct).ConfigureAwait(false);

            // 1. file log row -> FileLogId, which is stamped onto every data row.
            fileLogId = await _fileLog.InsertAsync(
                lab.ConnectionString, request.RunId, request.WeekFolder, lab.LabName,
                request.SourceFullPath, Path.GetFileName(csvPath), fileType,
                request.FileCreatedDateTime, ct).ConfigureAwait(false);

            await _runInfo.InfoAsync(request.RunId, fileType, sourceSystem,
                $"LineClaimFileLogs row {fileLogId} created. Truncate + load into {level!.SqlTableName} starting.", ct, Path.GetFileName(csvPath))
                .ConfigureAwait(false);

            var audit = new AuditColumns.AuditValues(
                FileLogId: fileLogId,
                RunId: request.RunId,
                WeekFolder: request.WeekFolder,
                SourceFullPath: request.SourceFullPath,
                FileName: Path.GetFileName(csvPath),
                FileType: fileType,
                LabId: lab.LabId,
                LabName: lab.LabName);

            // 2. stage -> verify -> swap -> verify
            var result = await _loader.LoadAsync(lab, level!, fileType, csvPath, audit, ct).ConfigureAwait(false);

            stopwatch.Stop();

            if (result.Skipped)
            {
                await _fileLog.TryCompleteAsync(lab.ConnectionString, fileLogId,
                    WorkflowStatus.Skipped, 0, result.SkipReason, ct).ConfigureAwait(false);

                await _runInfo.WarningAsync(request.RunId, fileType, sourceSystem,
                    $"{fileType} produced no load: {result.SkipReason}", ct, Path.GetFileName(csvPath)).ConfigureAwait(false);

                await _tracker.UpsertAsync(request.RunId, lab.LabId, lab.LabName, request.WeekFolder,
                    reportName, fileType, WorkflowStatus.Skipped, 0, startedOn,
                    ReportRunIdInfoLogger.IstNow(), result.SkipReason, ct).ConfigureAwait(false);

                return new LineClaimImportOutcome(fileType, true, true, 0, result.SkipReason);
            }

            await _fileLog.TryCompleteAsync(lab.ConnectionString, fileLogId,
                WorkflowStatus.Success, result.RowsInTable, null, ct).ConfigureAwait(false);

            await _runInfo.InfoAsync(request.RunId, fileType, sourceSystem,
                $"{fileType} bulk copy completed. Rows={result.RowsInTable}, Table={level!.SqlTableName}, Duration={stopwatch.ElapsedMilliseconds} ms.", ct, Path.GetFileName(csvPath))
                .ConfigureAwait(false);

            if (result.MissingCsvHeaders.Count > 0 || result.UnmappedCsvHeaders.Count > 0)
            {
                await _runInfo.WarningAsync(request.RunId, fileType, sourceSystem,
                    $"Mapping gaps. Mapped-but-absent-in-CSV: [{string.Join("; ", result.MissingCsvHeaders)}]. " +
                    $"In-CSV-but-unmapped: [{string.Join("; ", result.UnmappedCsvHeaders)}].", ct, Path.GetFileName(csvPath)).ConfigureAwait(false);
            }

            await _tracker.UpsertAsync(request.RunId, lab.LabId, lab.LabName, request.WeekFolder,
                reportName, fileType, WorkflowStatus.Success, result.RowsInTable, startedOn,
                ReportRunIdInfoLogger.IstNow(), null, ct).ConfigureAwait(false);

            await _runInfo.EndAsync(request.RunId, fileType, sourceSystem,
                $"{fileType} processing ended for lab {lab.LabName} ({lab.LabId}).", ct, Path.GetFileName(csvPath)).ConfigureAwait(false);

            return new LineClaimImportOutcome(fileType, true, false, result.RowsInTable, null);
        }
        catch (Exception ex)
        {
            stopwatch.Stop();
            _logger.LogError(ex, "Lab {LabId} [{FileType}]: bulk copy failed.", lab.LabId, fileType);

            if (fileLogId > 0)
            {
                await _fileLog.TryCompleteAsync(lab.ConnectionString, fileLogId,
                    WorkflowStatus.Failed, null, ex.Message, ct).ConfigureAwait(false);
            }

            await _runInfo.ErrorAsync(request.RunId, fileType, sourceSystem, ex, ct).ConfigureAwait(false);

            await _tracker.UpsertAsync(request.RunId, lab.LabId, lab.LabName, request.WeekFolder,
                reportName, fileType, WorkflowStatus.Failed, null, startedOn,
                ReportRunIdInfoLogger.IstNow(), ex.Message, ct).ConfigureAwait(false);

            await _runInfo.EndAsync(request.RunId, fileType, sourceSystem,
                $"{fileType} processing ended with failure for lab {lab.LabName} ({lab.LabId}).", ct, Path.GetFileName(csvPath)).ConfigureAwait(false);

            return new LineClaimImportOutcome(fileType, false, false, 0, ex.Message);
        }
    }

    /// <summary>
    /// Why this level would not be loaded, or null to load it.
    /// <para>
    /// Deliberately does NOT consider CreateCsv. Whether the standardized CSV is published to the
    /// output folder is a separate concern from whether the rows reach SQL: the file is always
    /// produced in the staging folder, and the loader reads it from there when publishing is off.
    /// Only Enabled and BulkCopyToTable decide whether a load happens.
    /// </para>
    /// </summary>
    private static string? ResolveSkipReason(LevelMapping? level)
    {
        if (level is null) return "no mapping section for this level in the lab JSON";
        if (!level.Enabled) return "Enabled=false";
        if (!level.BulkCopyToTable) return "BulkCopyToTable=false";
        return null;
    }
}
