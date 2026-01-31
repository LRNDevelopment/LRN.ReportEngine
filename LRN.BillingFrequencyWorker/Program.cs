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

        // File logs via log4net (so you can see progress during long exports)
        // NOTE: the provider reads log4net.config from AppContext.BaseDirectory.
        var log4NetConfigPath = Path.Combine(AppContext.BaseDirectory, "log4net.config");
        var logDir = Path.Combine(AppContext.BaseDirectory, "logs");
        logging.AddProvider(new Log4NetLoggerProvider(log4NetConfigPath, logDir));
    })
    .ConfigureServices((context, services) =>
    {
        services.Configure<ImportOptions>(context.Configuration.GetSection("BillingFrequency"));

        services.AddHttpClient<SharePointDownloader>();
        services.AddSingleton<BillingFrequencyFileStatusStore>();

        services.AddHostedService<BillingFrequencyWorker>();
    })
    .Build()
    .Run();
