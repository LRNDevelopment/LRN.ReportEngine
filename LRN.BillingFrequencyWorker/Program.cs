using Common.Logging;
using Microsoft.Extensions.DependencyInjection;
using Microsoft.Extensions.Hosting;
using Microsoft.Extensions.Logging;

Host.CreateDefaultBuilder(args)
    .UseContentRoot(AppContext.BaseDirectory) // important for Windows Service + finding appsettings.json
    .UseWindowsService(o => o.ServiceName = "LRN.BillingFrequencyWorker")
    .ConfigureLogging(logging =>
    {
        logging.ClearProviders();
        logging.AddConsole();
        logging.AddEventLog(); // Windows Event Log when running as a service
    })
    .ConfigureServices((context, services) =>
    {
        services.Configure<ImportOptions>(context.Configuration.GetSection("BillingFrequency"));

        services.AddHttpClient<SharePointDownloader>();
        services.AddSingleton<BillingFrequencyFileStatusStore>();
		services.AddSingleton<ILoggerService, LogManagerService>();
		services.AddHostedService<BillingFrequencyWorker>();
    })
    .Build()
    .Run();
