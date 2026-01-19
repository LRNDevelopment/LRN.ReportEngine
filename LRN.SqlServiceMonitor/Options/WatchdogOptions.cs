namespace LRN.SqlServiceMonitor;

public sealed class WatchdogOptions
{
    public string MachineName { get; set; } = ".";
    public string SqlServiceName { get; set; } = "MSSQLSERVER";
    public string SqlAgentServiceName { get; set; } = "SQLSERVERAGENT";
    public int PollSeconds { get; set; } = 15;
    public int RestartTimeoutSeconds { get; set; } = 60;

    // Prevent alert spam when a service is stuck/down
    public int IncidentCooldownMinutes { get; set; } = 10;
}
