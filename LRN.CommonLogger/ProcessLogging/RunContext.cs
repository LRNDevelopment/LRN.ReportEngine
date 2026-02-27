namespace Common.Logging.ProcessLogging;

public sealed class RunContext
{
    public long RunId { get; init; }
    public int LabId { get; init; }
    public string LabName { get; init; } = string.Empty;

    public string WorkDir { get; init; } = string.Empty;

    public string StepLogCsvPath { get; init; } = string.Empty;
    public string ErrorLogCsvPath { get; init; } = string.Empty;
    public string RunSummaryCsvPath { get; init; } = string.Empty;
}
