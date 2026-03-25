using DenialDatabaseProcessorWorker.Models;
using DenialDatabaseProcessorWorker.Services;
using DenialDatabaseProcessorWorker.Services.SharePoint;
using DenialDatabaseProcessorWorker.Worker;
using LRN.DenialDatabaseWorker.Services;
using Microsoft.Extensions.DependencyInjection;        // for AddHttpClient, AddWindowsService, etc.
using Microsoft.Extensions.Hosting;
using Microsoft.Extensions.Hosting.WindowsServices;
using Microsoft.Extensions.Logging;

var builder = Host.CreateApplicationBuilder(args);

// Configuration bindings
builder.Services.Configure<ProcessorOptions>(
    builder.Configuration.GetSection(ProcessorOptions.SectionName));

builder.Services.Configure<List<LabConfig>>(
    builder.Configuration.GetSection("Labs"));

// Logging
builder.Logging.ClearProviders();
builder.Logging.AddConsole();

// Only add EventLog on Windows to avoid cross-platform issues
if (OperatingSystem.IsWindows())
{
    builder.Logging.AddEventLog();
}

// Core services
builder.Services.AddSingleton<CsvStepLogger>();
builder.Services.AddSingleton<ExcelTableReader>();
builder.Services.AddSingleton<DenialCodeNormalizer>();
builder.Services.AddSingleton<DenialDatabaseBuilder>();
builder.Services.AddSingleton<ExcelWriter>();
builder.Services.AddSingleton<DenialInsightBuilder>();
builder.Services.AddSingleton<TaskBoardBuilder>();

// SharePoint uploader (Graph REST + ClientSecret credential)
// If SharePoint.Enabled=false, uploader becomes a no-op.
builder.Services.AddHttpClient<SharePointGraphClient>();
builder.Services.AddSingleton<ISharePointUploader, SharePointUploader>();

// Worker
builder.Services.AddHostedService<DenialDatabaseWorker>();

// Windows service support (only on Windows)
if (OperatingSystem.IsWindows())
{
    builder.Services.AddWindowsService(options =>
    {
        options.ServiceName = "LRN - Denial Database Processor";
    });
}

var host = builder.Build();
await host.RunAsync();