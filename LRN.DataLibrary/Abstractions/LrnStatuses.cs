namespace LRN.DataLibrary.Abstractions;

/// <summary>
/// String statuses so DB storage stays simple and interop-friendly.
/// </summary>
public static class LrnStatuses
{
    public const string Pending = "Pending";
    public const string Success = "Success";
    public const string Failed = "Failed";
    public const string Skipped = "Skipped";
    public const string NoNewFile = "NoNewFile";
}
