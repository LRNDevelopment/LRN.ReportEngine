using Common.Logging;
using LRN.ExcelValidator.Services;
using LRN.MasterFileProcessorWorker.BulkLoad;
using LRN.Notifications;
using Microsoft.Extensions.DependencyInjection;
using Microsoft.Extensions.Hosting;
using Microsoft.Extensions.Logging;

// Self-tests for the line/claim bulk-copy pipeline. Runs without a database or a test framework.
if (args.Contains("--selftest", StringComparer.OrdinalIgnoreCase))
	return SelfTests.Run();

var host = Host.CreateDefaultBuilder(args)
	.UseContentRoot(AppContext.BaseDirectory)
	.UseWindowsService(o => o.ServiceName = "LRN - Master File Processor")
	.ConfigureLogging((context, logging) =>
	{
		logging.ClearProviders();
		logging.AddConsole();
		logging.AddEventLog();
	})
	.ConfigureServices((context, services) =>
	{
		services.Configure<ImportOptions>(context.Configuration.GetSection("MasterFileProcessor"));
		services.Configure<ProcessLogOptions>(context.Configuration.GetSection("ProcessLog"));

		services.AddSingleton<ILoggerService, LogManagerService>();
		services.AddHttpClient<SharePointDownloader>();
		services.AddExcelValidator();
		services.AddMyCompanyNotifications(context.Configuration);


		services.AddSingleton<MasterFileProcessorFileStatusStore>();

		services.AddSingleton<IProcessLogRepository, SqlProcessLogRepository>();
		services.AddSingleton<IProcessLogCsvWriter, ProcessLogCsvWriter>();
		services.AddSingleton<IProcessLogWorkbookWriter, ProcessLogWorkbookWriter>();
		services.AddSingleton<IProcessLogService, ProcessLogService>();
		services.AddSingleton<LabModeMedianRepository>();
		services.AddSingleton<LabInsuranceMasterRepository>();
		services.AddSingleton<ModeMedianReportPublisher>();

		// Line-level / claim-level bulk copy. Additive: the existing LRN_Run_Log / LRN_Step_Log /
		// LRN_Error_Log pipeline above is untouched and keeps firing.
		services.Configure<LineClaimImportOptions>(context.Configuration.GetSection(LineClaimImportOptions.SectionName));
		services.AddSingleton<LabMappingLoader>();
		services.AddSingleton<LabRegistry>();
		services.AddSingleton<LineClaimBulkLoader>();
		services.AddSingleton<LineClaimFileLogRepository>();
		services.AddSingleton<ReportRunIdInfoLogger>();
		services.AddSingleton<ReportsWorkflowTrackerRepository>();
		services.AddSingleton<LineClaimImportService>();

		services.AddHostedService<MasterFileProcessorWorker>();
	})
	.Build();

await host.RunAsync();
return 0;