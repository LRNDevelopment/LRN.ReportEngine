using Microsoft.Extensions.DependencyInjection;
using Microsoft.Extensions.Hosting;

var builder = Host.CreateApplicationBuilder(args);

builder.Services.Configure<ImportOptions>(builder.Configuration.GetSection("BillingFrequency"));
builder.Services.AddHostedService<BillingFrequencyWorker>();

builder.Services.AddWindowsService(options =>
{
	options.ServiceName = "Billing Frequency Worker";
});

var host = builder.Build();
host.Run();
