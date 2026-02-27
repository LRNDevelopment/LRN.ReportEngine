using Common.Logging;
using Common.Logging.ProcessLogging;
using LRN.DataLibrary.Abstractions;
using LRN.DataLibrary.Db;
using LRN.DataLibrary.Repositories;
using LRN.SharePointClient.Abstractions;
using LRN.SharePointClient.Graph;
using LRN.SharePointOutputUploaderWorker.Options;
using LRN.SharePointUploader;
using Microsoft.EntityFrameworkCore;
using Microsoft.Extensions.Options;

var builder = Host.CreateApplicationBuilder(args);

builder.Services.Configure<GraphAuthOptions>(builder.Configuration.GetSection("GraphAuth"));
builder.Services.Configure<OutputUploaderOptions>(builder.Configuration.GetSection("OutputUploader"));

builder.Services.AddSingleton(sp => builder.Configuration.GetSection("Labs").Get<List<UploaderLabOptions>>() ?? new List<UploaderLabOptions>());

builder.Services.AddSingleton<ILoggerService, LogManagerService>();

var conn = builder.Configuration.GetConnectionString("LrnLogDb");
if (string.IsNullOrWhiteSpace(conn))
    throw new InvalidOperationException("ConnectionStrings:LrnLogDb is required.");

builder.Services.AddDbContext<LrnLogDbContext>(opt => opt.UseSqlServer(conn));
builder.Services.AddScoped<ILrnLogRepository, LrnLogRepository>();
builder.Services.AddScoped<ProcessLogService>();

builder.Services.AddHttpClient("graph-auth");
builder.Services.AddHttpClient("graph");

builder.Services.AddScoped<IGraphTokenProvider>(sp =>
{
    var http = sp.GetRequiredService<IHttpClientFactory>().CreateClient("graph-auth");
    var opt = sp.GetRequiredService<IOptions<GraphAuthOptions>>().Value;
    return new GraphTokenProvider(http, opt);
});

builder.Services.AddScoped<ISharePointClient>(sp =>
{
    var http = sp.GetRequiredService<IHttpClientFactory>().CreateClient("graph");
    var token = sp.GetRequiredService<IGraphTokenProvider>();
    return new GraphSharePointClient(http, token);
});

builder.Services.AddScoped<SharePointUploadService>();

builder.Services.AddScoped<Services.OutputUploaderService>();

builder.Services.AddHostedService<Worker>();

await builder.Build().RunAsync();
