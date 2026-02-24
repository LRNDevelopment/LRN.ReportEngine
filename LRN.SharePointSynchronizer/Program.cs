using Microsoft.Extensions.Configuration;
using Microsoft.Extensions.DependencyInjection;
using Microsoft.Extensions.Hosting;
using Microsoft.Extensions.Logging;
using Microsoft.Extensions.Options;

internal static class Program
{
    public static async Task Main(string[] args)
    {
        var builder = Host.CreateApplicationBuilder(args);

        builder.Services.AddWindowsService(o => o.ServiceName = "LRN SharePoint Synchronizer");

        builder.Logging.ClearProviders();
        builder.Logging.AddSimpleConsole(o =>
        {
            o.SingleLine = true;
            o.TimestampFormat = "HH:mm:ss ";
        });
#if WINDOWS
        builder.Logging.AddEventLog();
#endif
        builder.Logging.SetMinimumLevel(LogLevel.Information);

        // Bind ImportOptions from either section name for compatibility.
        var import = builder.Configuration.GetSection("MasterFileProcessor").Get<ImportOptions>();
        if (import == null)
            import = builder.Configuration.GetSection("BillingFrequency").Get<ImportOptions>() ?? new ImportOptions();
        builder.Services.AddSingleton(Options.Create(import));

        builder.Services.AddHttpClient<SharePointDownloader>();
        builder.Services.AddSharePointSynchronizer(builder.Configuration);

        var host = builder.Build();
        await host.RunAsync();
    }
}
