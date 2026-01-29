using Microsoft.Extensions.DependencyInjection;
using Microsoft.Extensions.Hosting;
using Microsoft.Extensions.Logging;

Host.CreateDefaultBuilder(args)
    .UseContentRoot(AppContext.BaseDirectory) // important for Windows Service to find appsettings.json
    .UseWindowsService(o => o.ServiceName = "Billing Frequency Worker")
    .ConfigureLogging(logging =>
    {
        // Default providers include Console/Debug; EventLog helps for Windows Service diagnostics
        logging.AddEventLog();
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
