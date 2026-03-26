using DenialDatabaseProcessorWorker.Models;
using DenialDatabaseProcessorWorker.Services;
using DenialDatabaseProcessorWorker.Services.SharePoint;
using DenialDatabaseProcessorWorker.Worker;

var builder = Host.CreateApplicationBuilder(args);

// -------------------------------
// Bind ProcessorOptions
// -------------------------------
builder.Services.Configure<ProcessorOptions>(builder.Configuration.GetSection(ProcessorOptions.SectionName));
builder.Services.PostConfigure<ProcessorOptions>(options =>
{
	options.Configuration = builder.Configuration;
});

// -------------------------------
// Bind Labs
// -------------------------------
builder.Services.Configure<List<LabConfig>>(builder.Configuration.GetSection("Labs"));

// -------------------------------
// Logging
// -------------------------------
builder.Logging.ClearProviders();
builder.Logging.AddConsole();

if (OperatingSystem.IsWindows())
{
	builder.Logging.AddEventLog();
}

// -------------------------------
// Core Services
// -------------------------------
builder.Services.AddSingleton<CsvStepLogger>();
builder.Services.AddSingleton<ExcelTableReader>();
builder.Services.AddSingleton<DenialCodeNormalizer>();
builder.Services.AddSingleton<DenialDatabaseBuilder>();
builder.Services.AddSingleton<ExcelWriter>();
builder.Services.AddSingleton<DenialInsightBuilder>();

// -------------------------------
// NEW: Required Services for Final Architecture
// -------------------------------
builder.Services.AddSingleton<FileResolver>();
builder.Services.AddSingleton<OutputPathBuilder>();
builder.Services.AddSingleton<TaskBoardBulkWriter>();
builder.Services.AddSingleton<DenialAnalysisRunLogRepository>();

// -------------------------------
// SharePoint uploader
// -------------------------------
builder.Services.AddHttpClient<SharePointGraphClient>();
builder.Services.AddSingleton<ISharePointUploader, SharePointUploader>();

// -------------------------------
// Worker
// -------------------------------
builder.Services.AddHostedService<DenialDatabaseWorker>();

// -------------------------------
// Windows Service Support
// -------------------------------
if (OperatingSystem.IsWindows())
{
	builder.Services.AddWindowsService(options =>
	{
		options.ServiceName = "LRN - Denial Database Processor";
	});
}

var host = builder.Build();
await host.RunAsync();