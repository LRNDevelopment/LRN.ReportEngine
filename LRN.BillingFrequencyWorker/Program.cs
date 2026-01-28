using Microsoft.Extensions.DependencyInjection;
using Microsoft.Extensions.Hosting;
using Microsoft.Extensions.Logging;

Host.CreateDefaultBuilder(args)
	.UseContentRoot(AppContext.BaseDirectory)
	.UseWindowsService(o => o.ServiceName = "Billing Frequency Worker")
	.ConfigureLogging(logging => logging.AddEventLog()) // 👈
	.ConfigureServices((context, services) =>
	{
		services.Configure<ImportOptions>(context.Configuration.GetSection("BillingFrequency"));
		services.AddHostedService<BillingFrequencyWorker>();
	})
	.Build()
	.Run();
