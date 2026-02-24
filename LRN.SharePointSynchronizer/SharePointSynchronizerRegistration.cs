using Microsoft.Extensions.Configuration;
using Microsoft.Extensions.DependencyInjection;

public static class SharePointSynchronizerRegistration
{
    public static IServiceCollection AddSharePointSynchronizer(this IServiceCollection services, IConfiguration config)
    {
        services.Configure<SharePointSynchronizerOptions>(config.GetSection("SharePointSynchronizer"));
        services.AddHostedService<SharePointSynchronizerWorker>();
        return services;
    }
}
