using Common.Logging;
using LRN.ExcelValidator.Services;
using Microsoft.Extensions.DependencyInjection;
using Microsoft.Extensions.Hosting;

var builder = Host.CreateApplicationBuilder(args);

// Bind EXISTING config (do not change appsettings structure)
builder.Services.Configure<ImportOptions>(builder.Configuration.GetSection("MasterFileProcessor"));
builder.Services.Configure<ProcessLogOptions>(builder.Configuration.GetSection("ProcessLog"));

// log4net wrapper (file log)
builder.Services.AddSingleton<ILoggerService, LogManagerService>();

// SharePoint client (Graph over raw HttpClient)
builder.Services.AddHttpClient<SharePointDownloader>();

// Excel schema validator (uses your existing lab schemas)
builder.Services.AddExcelValidator();

// SQL status store
builder.Services.AddSingleton<MasterFileProcessorFileStatusStore>();

// Process logging (DB + CSV + Workbook)
builder.Services.AddSingleton<IProcessLogRepository, SqlProcessLogRepository>();
builder.Services.AddSingleton<IProcessLogCsvWriter, ProcessLogCsvWriter>();
builder.Services.AddSingleton<IProcessLogWorkbookWriter, ProcessLogWorkbookWriter>();
builder.Services.AddSingleton<IProcessLogService, ProcessLogService>();

// Run the existing worker
builder.Services.AddHostedService<MasterFileProcessorWorker>();

await builder.Build().RunAsync();
