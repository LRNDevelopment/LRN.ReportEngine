using LRN.Notifications;
using LRN.SqlServiceMonitor;
using LRN.SqlServiceMonitor.Notifications;
using Microsoft.Extensions.DependencyInjection;
using Microsoft.Extensions.Hosting;
using Microsoft.Extensions.Logging;
using Microsoft.Extensions.Logging.EventLog;

var builder = Host.CreateApplicationBuilder(args);

// Run as Windows Service
builder.Services.AddWindowsService(options =>
{
    options.ServiceName = "LRN SQL Service Monitor";
});

// Event Log (optional but recommended for services)
builder.Logging.AddEventLog(new EventLogSettings
{
    SourceName = "LRN.SqlServiceMonitor",
    LogName = "Application"
});

// Options
builder.Services.Configure<WatchdogOptions>(builder.Configuration.GetSection("Watchdog"));
builder.Services.Configure<AlertOptions>(builder.Configuration.GetSection("Alerts"));

// Register Notifications library (SMTP + Teams Webhook)
builder.Services.AddMyCompanyNotifications(builder.Configuration);

// Composite notifier used by the worker
builder.Services.AddSingleton<IAlertNotifier, AlertNotifier>();

// Worker
builder.Services.AddHostedService<SqlWatchdogWorker>();

var host = builder.Build();
await host.RunAsync();
