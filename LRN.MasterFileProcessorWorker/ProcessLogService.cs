using Microsoft.Extensions.Options;
using System;
using System.Reflection;
using System.Threading;
using System.Threading.Tasks;

public interface IProcessLogService
{
    Task<ProcessRunContext> StartRunAsync(string labName, string? pipelineName, string? triggerType, string? triggeredBy, CancellationToken ct);
    Task StepStartAsync(ProcessRunContext ctx, StepLogRow step, CancellationToken ct);
    Task StepEndAsync(ProcessRunContext ctx, StepLogRow step, CancellationToken ct);
    Task LogErrorAsync(ProcessRunContext ctx, ErrorLogRow err, CancellationToken ct);
    Task CompleteRunAsync(ProcessRunContext ctx, RunLogRow finalUpdate, CancellationToken ct);

    DateTime NowIST();
}

public sealed class ProcessLogService : IProcessLogService
{
    private readonly IProcessLogRepository _repo;
    private readonly ProcessLogOptions _opt;
    private readonly TimeZoneInfo _tz;
    private readonly string _host;
    private readonly string _version;

    public ProcessLogService(IProcessLogRepository repo, IOptions<ProcessLogOptions> opt)
    {
        _repo = repo;
        _opt = opt.Value ?? new ProcessLogOptions();
        _tz = ResolveIstTimeZone();
        _host = Environment.MachineName;
        _version = (Assembly.GetEntryAssembly() ?? Assembly.GetExecutingAssembly())
                      .GetName().Version?.ToString() ?? "";
    }

    public DateTime NowIST()
    {
        var utc = DateTime.UtcNow;
        return TimeZoneInfo.ConvertTimeFromUtc(utc, _tz);
    }

    private static TimeZoneInfo ResolveIstTimeZone()
    {
        // Windows: "India Standard Time"; Linux: "Asia/Kolkata"
        try { return TimeZoneInfo.FindSystemTimeZoneById("India Standard Time"); }
        catch { return TimeZoneInfo.FindSystemTimeZoneById("Asia/Kolkata"); }
    }

    public async Task<ProcessRunContext> StartRunAsync(string labName, string? pipelineName, string? triggerType, string? triggeredBy, CancellationToken ct)
    {
        if (!_opt.Enabled)
            return new ProcessRunContext { RunId = "", LabName = labName ?? "", StartTimeIST = NowIST() };

        var runId = await _repo.NextRunIdAsync(ct);
        var start = NowIST();

        var row = new RunLogRow
        {
            RunID = runId,
            LabName = labName,
            PipelineName = string.IsNullOrWhiteSpace(pipelineName) ? _opt.DefaultPipelineName : pipelineName,
            TriggerType = string.IsNullOrWhiteSpace(triggerType) ? _opt.DefaultTriggerType : triggerType,
            TriggeredBy = string.IsNullOrWhiteSpace(triggeredBy) ? _opt.DefaultTriggeredBy : triggeredBy,
            StartTimeIST = start,
            OverallStatus = "IN_PROGRESS",
            LatestMasterFileFound = "NO",
            MandatoryColumnCheck = "SKIPPED",
            SplitOutputWrittenToSharePoint = "SKIPPED",
            PayerPolicyValidationStatus = "SKIPPED",
            CodingValidationStatus = "SKIPPED",
            AveragesProcessStatus = "SKIPPED",
            OutputsCopiedToSharePoint = "SKIPPED",
            MasterSyncPerformed = "SKIPPED",
            TotalErrors = 0,
            TotalWarnings = 0
        };

        await _repo.InsertRunAsync(row, ct);

        return new ProcessRunContext { RunId = runId, LabName = labName, StartTimeIST = start };
    }

    public async Task StepStartAsync(ProcessRunContext ctx, StepLogRow step, CancellationToken ct)
    {
        if (!_opt.Enabled || string.IsNullOrWhiteSpace(ctx.RunId)) return;

        step.RunID = ctx.RunId;
        step.LabName ??= ctx.LabName;
        step.StartTimeIST ??= NowIST();
        step.Status ??= "IN_PROGRESS";
        step.ExecutedBy ??= Environment.UserName;
        step.Host ??= _host;
        step.ModuleVersion ??= _version;

        await _repo.UpsertStepAsync(step, ct);
    }

    public async Task StepEndAsync(ProcessRunContext ctx, StepLogRow step, CancellationToken ct)
    {
        if (!_opt.Enabled || string.IsNullOrWhiteSpace(ctx.RunId)) return;

        step.RunID = ctx.RunId;
        step.LabName ??= ctx.LabName;
        step.EndTimeIST ??= NowIST();

        if (step.StartTimeIST.HasValue && step.EndTimeIST.HasValue)
        {
            var dur = step.EndTimeIST.Value - step.StartTimeIST.Value;
            step.DurationSeconds = (int)Math.Max(0, dur.TotalSeconds);
        }

        step.ExecutedBy ??= Environment.UserName;
        step.Host ??= _host;
        step.ModuleVersion ??= _version;

        await _repo.UpsertStepAsync(step, ct);
    }

    public async Task LogErrorAsync(ProcessRunContext ctx, ErrorLogRow err, CancellationToken ct)
    {
        if (!_opt.Enabled || string.IsNullOrWhiteSpace(ctx.RunId)) return;

        err.RunID = ctx.RunId;
        err.LabName ??= ctx.LabName;
        if (err.ErrorTimeIST == default) err.ErrorTimeIST = NowIST();
        if (string.IsNullOrWhiteSpace(err.Severity)) err.Severity = "ERROR";
        if (string.IsNullOrWhiteSpace(err.Status)) err.Status = "OPEN";

        await _repo.InsertErrorAsync(err, ct);
        await _repo.IncrementRunCountAsync(ctx.RunId, isWarning: err.Severity.Equals("WARNING", StringComparison.OrdinalIgnoreCase), ct);
    }

    public async Task CompleteRunAsync(ProcessRunContext ctx, RunLogRow finalUpdate, CancellationToken ct)
    {
        if (!_opt.Enabled || string.IsNullOrWhiteSpace(ctx.RunId)) return;

        var end = NowIST();
        finalUpdate.RunID = ctx.RunId;
        finalUpdate.LabName = ctx.LabName;
        finalUpdate.EndTimeIST = end;
        finalUpdate.StartTimeIST ??= ctx.StartTimeIST;
        finalUpdate.DurationSeconds = (int)Math.Max(0, (end - ctx.StartTimeIST).TotalSeconds);
        await _repo.UpdateRunAsync(finalUpdate, ct);
    }
}
