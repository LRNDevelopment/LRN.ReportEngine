using Common.Logging;
using LRN.DataLibrary.Abstractions;
using LRN.DataLibrary.Db;
using LRN.DataLibrary.Entities;
using LRN.SharePointOutputUploaderWorker.Options;
using LRN.SharePointUploader;
using Microsoft.EntityFrameworkCore;
using Microsoft.Extensions.Options;

namespace LRN.SharePointOutputUploaderWorker.Services;

public sealed class OutputUploaderService
{
    private readonly ILoggerService _log;
    private readonly OutputUploaderOptions _opts;
    private readonly IReadOnlyList<UploaderLabOptions> _labs;
    private readonly LrnLogDbContext _db;
    private readonly ILrnLogRepository _repo;
    private readonly SharePointUploadService _uploader;

    public OutputUploaderService(
        ILoggerService log,
        IOptions<OutputUploaderOptions> opts,
        List<UploaderLabOptions> labs,
        LrnLogDbContext db,
        ILrnLogRepository repo,
        SharePointUploadService uploader)
    {
        _log = log;
        _opts = opts.Value;
        _labs = labs;
        _db = db;
        _repo = repo;
        _uploader = uploader;
    }

    public async Task ProcessPendingRunsAsync(CancellationToken ct)
    {
        foreach (var lab in _labs)
        {
            ct.ThrowIfCancellationRequested();

            var run = await _db.RunLogs
                .Where(r => r.LabId == lab.LabId
                            && r.PayerPolicyValidationStatus == LrnStatuses.Success
                            && r.CodingValidationStatus == LrnStatuses.Success
                            && r.OutputsCopiedToSharePoint == LrnStatuses.Pending)
                .OrderBy(r => r.RunID)
                .FirstOrDefaultAsync(ct);

            if (run == null)
                continue;

            await UploadForRunAsync(lab, run, ct);
        }
    }

    private async Task UploadForRunAsync(UploaderLabOptions lab, LrnRunLog run, CancellationToken ct)
    {
        var runId = run.RunID;
        var localRoot = Path.IsPathRooted(_opts.ServerOutputsRoot)
            ? _opts.ServerOutputsRoot
            : Path.Combine(AppContext.BaseDirectory, _opts.ServerOutputsRoot);

        var labDir = Path.Combine(localRoot, lab.LabName);

        var payerPolicy = FindFirst(labDir, $"*PayerPolicy*{runId}*.csv");
        var codingMaster = FindFirst(labDir, $"*CodingMaster*{runId}*.csv");

        if (payerPolicy == null || codingMaster == null)
        {
            _log.Warn($"[{lab.LabName}] Pending run {runId} but peer outputs not found yet. Folder={labDir}");
            return;
        }

        var step = await _repo.StartStepAsync(runId, lab.LabName, 80, "UploadPeerOutputsToSharePoint", "SharePoint", _opts.SourceSystem,
            fileIn: $"{Path.GetFileName(payerPolicy)} | {Path.GetFileName(codingMaster)}", pathIn: labDir, recordsIn: null, ct: ct);

        try
        {
            await _uploader.UploadAsync(lab.Output, payerPolicy, Path.GetFileName(payerPolicy), ct);
            await _uploader.UploadAsync(lab.Output, codingMaster, Path.GetFileName(codingMaster), ct);

            run.OutputsCopiedToSharePoint = LrnStatuses.Success;
            run.MasterSyncPerformed = true;
            await _repo.UpdateRunAsync(run, ct);

            await _repo.CompleteStepAsync(step.StepLogId, LrnStatuses.Success, null,
                fileOut: $"{Path.GetFileName(payerPolicy)} | {Path.GetFileName(codingMaster)}",
                pathOut: lab.Output.FolderPath, errorCode: null, errorMessage: null, errorDetail: null, ct: ct);

            _log.Info($"[{lab.LabName}] Uploaded peer outputs for RunID={runId}.");
        }
        catch (Exception ex)
        {
            run.OutputsCopiedToSharePoint = LrnStatuses.Failed;
            run.TotalErrors += 1;
            await _repo.UpdateRunAsync(run, ct);

            await _repo.CompleteStepAsync(step.StepLogId, LrnStatuses.Failed, null,
                fileOut: null, pathOut: null, errorCode: "SP_PEER_UPLOAD", errorMessage: ex.Message, errorDetail: ex.ToString(), ct: ct);

            await _repo.LogErrorAsync(new LrnErrorLog
            {
                RunID = runId,
                LabName = lab.LabName,
                ErrorTimeIST = DateTimeOffset.UtcNow.ToOffset(TimeSpan.FromHours(5.5)),
                Severity = "Error",
                StepName = "UploadPeerOutputsToSharePoint",
                ErrorCode = "SP_PEER_UPLOAD",
                ErrorSummary = "Failed to upload peer outputs to SharePoint.",
                FileName = $"{Path.GetFileName(payerPolicy)} | {Path.GetFileName(codingMaster)}",
                FilePath = labDir,
                RecommendedAction = "Check SharePoint output path/permissions and retry.",
                SourceSystem = _opts.SourceSystem,
                Status = "Open"
            }, ct);

            _log.Error($"[{lab.LabName}] Upload peer outputs failed for RunID={runId}", ex);
        }

        // Optional: upload worker-specific logs to lab.Logs if you want.
    }

    private static string? FindFirst(string folder, string pattern)
    {
        if (string.IsNullOrWhiteSpace(folder) || !Directory.Exists(folder))
            return null;

        return Directory.EnumerateFiles(folder, pattern, SearchOption.TopDirectoryOnly)
            .OrderByDescending(File.GetLastWriteTimeUtc)
            .FirstOrDefault();
    }
}
