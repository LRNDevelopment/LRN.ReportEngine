using Common.Logging;
using LRN.ExcelValidator.Services;
using Microsoft.Extensions.DependencyInjection;
using Microsoft.Extensions.Hosting;
using Microsoft.Extensions.Logging;

Host.CreateDefaultBuilder(args)
    .UseContentRoot(AppContext.BaseDirectory) // important for Windows Service + finding appsettings.json
    .UseWindowsService(o => o.ServiceName = "LRN.BillingFrequencyWorker")
    .ConfigureLogging((context, logging) =>
    {
        logging.ClearProviders();

        // Console is helpful when running locally
        logging.AddConsole();

        // EventLog is helpful when installed as a Windows Service
        logging.AddEventLog();

        // Show only OUR categories; suppress framework noise
        logging.AddFilter((provider, category, level) =>
        {
            if (category.StartsWith("Microsoft.", StringComparison.OrdinalIgnoreCase)) return false;
            if (category.StartsWith("System.", StringComparison.OrdinalIgnoreCase)) return false;
            return level >= LogLevel.Information;
        });
    })
    .ConfigureServices((context, services) =>
    {
        services.Configure<ImportOptions>(context.Configuration.GetSection("BillingFrequency"));

        services.AddHttpClient<SharePointDownloader>();
        services.AddSingleton<BillingFrequencyFileStatusStore>();

        // File logger (log4net) - logs only what you explicitly write via ILoggerService
        services.AddSingleton<ILoggerService, LogManagerService>();

        // Global schema validator library
        services.AddExcelValidator();

        services.AddHostedService<BillingFrequencyWorker>();
    })
    .Build()
    .Run();
