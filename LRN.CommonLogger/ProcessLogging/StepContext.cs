namespace Common.Logging.ProcessLogging;

public sealed class StepContext
{
    public long StepLogId { get; init; }
    public int StepSeq { get; init; }
    public string StepName { get; init; } = string.Empty;

    public string StepCategory { get; init; } = string.Empty;

    public DateTimeOffset StartTimeUtc { get; init; }

    public long? RecordsIn { get; init; }
    public string? FileNameIn { get; init; }
    public string? PathIn { get; init; }
}
