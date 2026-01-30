using Microsoft.Extensions.DependencyInjection;
using Microsoft.Extensions.Hosting;
using Microsoft.Extensions.Hosting.WindowsServices;
using Microsoft.Extensions.Logging;

var builder = Host.CreateDefaultBuilder(args)
    .UseContentRoot(AppContext.BaseDirectory) // helps Windows Service find appsettings.json in published folder
    .ConfigureLogging(logging =>
    {
        logging.ClearProviders();
        logging.AddConsole();
        logging.AddDebug();

        // EventLog is useful only when running as a Windows Service
        if (OperatingSystem.IsWindows() && WindowsServiceHelpers.IsWindowsService())
        {
            logging.AddEventLog();
        }
    })
    .ConfigureServices((context, services) =>
    {
        services.Configure<ImportOptions>(context.Configuration.GetSection("BillingFrequency"));

        services.AddHttpClient<SharePointDownloader>();
        services.AddSingleton<BillingFrequencyFileStatusStore>();

        services.AddHostedService<BillingFrequencyWorker>();
    });

// Only configure Windows Service hosting when actually running as a service.
if (OperatingSystem.IsWindows() && WindowsServiceHelpers.IsWindowsService())
{
    builder.UseWindowsService(o => o.ServiceName = "Billing Frequency Worker");
}

builder.Build().Run();
