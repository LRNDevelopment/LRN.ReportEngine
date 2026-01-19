using Microsoft.Extensions.Hosting;
using Microsoft.Extensions.Logging;
using Microsoft.Extensions.Options;
using System.ComponentModel;
using System.ServiceProcess;
using LRN.SqlServiceMonitor.Notifications;

namespace LRN.SqlServiceMonitor;

public sealed class SqlWatchdogWorker : BackgroundService
{
    private readonly ILogger<SqlWatchdogWorker> _logger;
    private readonly WatchdogOptions _opt;
    private readonly IAlertNotifier _notifier;

    // Track last known status to avoid spamming
    private readonly Dictionary<string, ServiceControllerStatus?> _lastStatus = new();

    // Cooldown per (service + eventType) to prevent repeated alerts in noisy situations
    private readonly Dictionary<string, DateTimeOffset> _lastEventSentUtc = new();

    public SqlWatchdogWorker(
        ILogger<SqlWatchdogWorker> logger,
        IOptions<WatchdogOptions> opt,
        IAlertNotifier notifier)
    {
        _logger = logger;
        _opt = opt.Value;
        _notifier = notifier;
    }

    protected override async Task ExecuteAsync(CancellationToken stoppingToken)
    {
        _logger.LogInformation("SQL Watchdog started. Machine={Machine}, SQL={Sql}, Agent={Agent}",
            _opt.MachineName, _opt.SqlServiceName, _opt.SqlAgentServiceName);

        while (!stoppingToken.IsCancellationRequested)
        {
            try
            {
                // 1) SQL Server service
                var sqlRunning = await EnsureServiceRunningWithAlertsAsync(
                    serviceName: _opt.SqlServiceName,
                    friendlyName: "SQL Server",
                    stoppingToken);

                // 2) SQL Agent (only if SQL is up)
                if (sqlRunning)
                {
                    await EnsureServiceRunningWithAlertsAsync(
                        serviceName: _opt.SqlAgentServiceName,
                        friendlyName: "SQL Server Agent",
                        stoppingToken);
                }
            }
            catch (Exception ex)
            {
                _logger.LogError(ex, "Watchdog loop error.");
                await SendEventAsync("WATCHDOG", "ERROR",
                    title: "SQL Watchdog - loop error",
                    body: ex.ToString(),
                    stoppingToken);
            }

            await Task.Delay(TimeSpan.FromSeconds(_opt.PollSeconds), stoppingToken);
        }
    }

    private async Task<bool> EnsureServiceRunningWithAlertsAsync(
        string serviceName,
        string friendlyName,
        CancellationToken ct)
    {
        ServiceControllerStatus? currentStatus = null;

        try
        {
            using var sc = new ServiceController(serviceName, _opt.MachineName);

            currentStatus = sc.Status;
            var last = GetLastStatus(serviceName);

            // If status changed, log it (and notify "recovered" when it becomes Running)
            if (last == null || last.Value != currentStatus.Value)
            {
                _logger.LogInformation("{Name} status changed: {Old} -> {New}",
                    friendlyName, last?.ToString() ?? "Unknown", currentStatus);

                // Notify "recovered" when it transitions back to running
                if (currentStatus == ServiceControllerStatus.Running &&
                    last.HasValue && last.Value != ServiceControllerStatus.Running)
                {
                    await SendEventAsync(serviceName, "RECOVERED",
                        title: $"{friendlyName} recovered",
                        body: BuildMessage(serviceName, friendlyName,
                            $"Service is RUNNING again. Previous status was {last}."),
                        ct);
                }

                SetLastStatus(serviceName, currentStatus);
            }

            if (currentStatus == ServiceControllerStatus.Running)
                return true;

            // 1) Detected failure (down/not running)
            await SendEventAsync(serviceName, "DOWN_DETECTED",
                title: $"{friendlyName} DOWN detected",
                body: BuildMessage(serviceName, friendlyName,
                    $"Detected service status: {currentStatus}. Restart will be attempted."),
                ct);

            // 2) Restart attempt starts
            await SendEventAsync(serviceName, "RESTARTING",
                title: $"{friendlyName} restarting",
                body: BuildMessage(serviceName, friendlyName,
                    $"Restart attempt started. Current status: {currentStatus}."),
                ct);

            // 3) Attempt restart
            var ok = await RestartAsync(sc, friendlyName);

            if (ok)
            {
                // 4) Restart success
                await SendEventAsync(serviceName, "RESTART_SUCCESS",
                    title: $"{friendlyName} restart SUCCESS",
                    body: BuildMessage(serviceName, friendlyName,
                        "Restart completed successfully. Service is RUNNING."),
                    ct);

                SetLastStatus(serviceName, ServiceControllerStatus.Running);
                return true;
            }
            else
            {
                // 5) Restart failed
                sc.Refresh();
                var after = SafeGetStatus(sc);

                await SendEventAsync(serviceName, "RESTART_FAILED",
                    title: $"{friendlyName} restart FAILED",
                    body: BuildMessage(serviceName, friendlyName,
                        $"Restart attempt failed. Current status after attempt: {after?.ToString() ?? "Unknown"}"),
                    ct);

                SetLastStatus(serviceName, after);
                return false;
            }
        }
        catch (InvalidOperationException ex)
        {
            _logger.LogError(ex, "Service {Service} cannot be opened on {Machine}.", serviceName, _opt.MachineName);
            await SendEventAsync(serviceName, "CONTROL_ERROR",
                title: $"{friendlyName} monitoring/control error",
                body: BuildMessage(serviceName, friendlyName, ex.Message),
                ct);
            SetLastStatus(serviceName, currentStatus);
            return false;
        }
        catch (Win32Exception ex)
        {
            _logger.LogError(ex, "Win32 error controlling {Service} on {Machine}.", serviceName, _opt.MachineName);
            await SendEventAsync(serviceName, "CONTROL_ERROR",
                title: $"{friendlyName} Win32 control error",
                body: BuildMessage(serviceName, friendlyName,
                    $"{ex.Message} (NativeErrorCode={ex.NativeErrorCode})"),
                ct);
            SetLastStatus(serviceName, currentStatus);
            return false;
        }
    }

    private Task<bool> RestartAsync(ServiceController sc, string friendlyName)
    {
        var timeout = TimeSpan.FromSeconds(_opt.RestartTimeoutSeconds);

        try
        {
            sc.Refresh();

            // If stop/start pending, wait for it to settle
            if (sc.Status is ServiceControllerStatus.StopPending or ServiceControllerStatus.StartPending)
            {
                _logger.LogWarning("{Name} is pending ({Status}); waiting...", friendlyName, sc.Status);

                // Wait either to stop or run, depending on direction
                if (sc.Status == ServiceControllerStatus.StopPending)
                    sc.WaitForStatus(ServiceControllerStatus.Stopped, timeout);
                else
                    sc.WaitForStatus(ServiceControllerStatus.Running, timeout);

                sc.Refresh();
            }

            // Stop if needed
            if (sc.Status != ServiceControllerStatus.Stopped)
            {
                _logger.LogInformation("Stopping {Name}...", friendlyName);
                sc.Stop();
                sc.WaitForStatus(ServiceControllerStatus.Stopped, timeout);
            }

            // Start
            _logger.LogInformation("Starting {Name}...", friendlyName);
            sc.Start();
            sc.WaitForStatus(ServiceControllerStatus.Running, timeout);

            sc.Refresh();
            return Task.FromResult(sc.Status == ServiceControllerStatus.Running);
        }
        catch (Exception ex)
        {
            _logger.LogError(ex, "Restart failed for {Name}.", friendlyName);
            return Task.FromResult(false);
        }
    }

    // ---------- Notification helpers ----------

    private async Task SendEventAsync(string serviceKey, string eventType, string title, string body, CancellationToken ct)
    {
        // Cooldown per event type to prevent repeated alerts every poll if things are stuck
        var cooldown = TimeSpan.FromMinutes(_opt.IncidentCooldownMinutes);
        var key = $"{serviceKey}:{eventType}".ToUpperInvariant();
        var now = DateTimeOffset.UtcNow;

        if (_lastEventSentUtc.TryGetValue(key, out var last) && (now - last) < cooldown)
        {
            _logger.LogWarning("Cooldown active: skipping notify for {Key}.", key);
            return;
        }

        _lastEventSentUtc[key] = now;

        await _notifier.NotifyAsync(title, body, ct);
    }

    private string BuildMessage(string serviceName, string friendlyName, string details)
    {
        return
$@"Machine: {_opt.MachineName}
Service: {friendlyName}
ServiceName: {serviceName}
Time (UTC): {DateTimeOffset.UtcNow:O}

Details:
{details}";
    }

    private ServiceControllerStatus? SafeGetStatus(ServiceController sc)
    {
        try { sc.Refresh(); return sc.Status; }
        catch { return null; }
    }

    private ServiceControllerStatus? GetLastStatus(string serviceName)
        => _lastStatus.TryGetValue(serviceName, out var s) ? s : null;

    private void SetLastStatus(string serviceName, ServiceControllerStatus? status)
        => _lastStatus[serviceName] = status;
}
