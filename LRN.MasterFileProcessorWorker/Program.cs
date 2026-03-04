using Common.Logging;
using LRN.ExcelValidator.Services;
using Microsoft.Extensions.DependencyInjection;
using Microsoft.Extensions.Hosting;
using Microsoft.Extensions.Logging;

var host = Host.CreateDefaultBuilder(args)
	.UseContentRoot(AppContext.BaseDirectory)
	.UseWindowsService(o => o.ServiceName = "LRN - Master File Processor")
	.ConfigureLogging((context, logging) =>
	{
		logging.ClearProviders();
		logging.AddConsole();   // useful when running EXE manually
		logging.AddEventLog();  // useful when running as Windows Service
	})
	.ConfigureServices((context, services) =>
	{
		services.Configure<ImportOptions>(context.Configuration.GetSection("MasterFileProcessor"));
		services.Configure<ProcessLogOptions>(context.Configuration.GetSection("ProcessLog"));

		services.AddSingleton<ILoggerService, LogManagerService>();
		services.AddHttpClient<SharePointDownloader>();
		services.AddExcelValidator();

		services.AddSingleton<MasterFileProcessorFileStatusStore>();

		services.AddSingleton<IProcessLogRepository, SqlProcessLogRepository>();
		services.AddSingleton<IProcessLogCsvWriter, ProcessLogCsvWriter>();
		services.AddSingleton<IProcessLogWorkbookWriter, ProcessLogWorkbookWriter>();
		services.AddSingleton<IProcessLogService, ProcessLogService>();

		services.AddHostedService<MasterFileProcessorWorker>();
	})
	.Build();

await host.RunAsync();