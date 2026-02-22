using Common.Logging;
using LRN.ExcelValidator.Services;
using Microsoft.Extensions.DependencyInjection;
using Microsoft.Extensions.Hosting;
using Microsoft.Extensions.Logging;

Host.CreateDefaultBuilder(args)
    .UseContentRoot(AppContext.BaseDirectory) // important for Windows Service + finding appsettings.json
    .UseWindowsService(o => o.ServiceName = "LRN.MasterFileProcessorWorker")
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
        var sec = context.Configuration.GetSection("MasterFileProcessor");
        if (!sec.Exists()) sec = context.Configuration.GetSection("BillingFrequency");
        services.Configure<ImportOptions>(sec);

        // Process log (Run_Log / Step_Log / Error_Log) - matches LRN_Process_Log_Template.xlsx
        services.Configure<ProcessLogOptions>(context.Configuration.GetSection("ProcessLog"));
        services.AddSingleton<IProcessLogRepository, SqlProcessLogRepository>();
        services.AddSingleton<IProcessLogService, ProcessLogService>();

        services.AddHttpClient<SharePointDownloader>();
        services.AddSingleton<MasterFileProcessorFileStatusStore>();

        // File logger (log4net) - logs only what you explicitly write via ILoggerService
        services.AddSingleton<ILoggerService, LogManagerService>();

        // Global schema validator library
        services.AddExcelValidator();

        services.AddHostedService<MasterFileProcessorWorker>();
    })
    .Build()
    .Run();
