namespace LRN.SqlServiceMonitor;

public sealed class AlertOptions
{
    public bool Enabled { get; set; } = true;

    // Email envelope defaults
    public string EmailFrom { get; set; } = "";
    public List<string> EmailTo { get; set; } = new();
    public List<string> EmailCc { get; set; } = new();
    public List<string> EmailBcc { get; set; } = new();

    public string EmailSubjectPrefix { get; set; } = "[SQL Watchdog]";
    public string TeamsTitlePrefix { get; set; } = "[SQL Watchdog]";
}
