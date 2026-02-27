using Common.Logging;
using LRN.SharePointOutputUploaderWorker.Options;
using LRN.SharePointOutputUploaderWorker.Services;
using Microsoft.Extensions.Options;

namespace LRN.SharePointOutputUploaderWorker;

public sealed class Worker : BackgroundService
{
    private readonly ILoggerService _log;
    private readonly IServiceScopeFactory _scopeFactory;
    private readonly OutputUploaderOptions _opts;

    public Worker(ILoggerService log, IServiceScopeFactory scopeFactory, IOptions<OutputUploaderOptions> opts)
    {
        _log = log;
        _scopeFactory = scopeFactory;
        _opts = opts.Value;
    }

    protected override async Task ExecuteAsync(CancellationToken stoppingToken)
    {
        _log.Info($"SharePointOutputUploaderWorker started. PollingIntervalSeconds={_opts.PollingIntervalSeconds}");

        while (!stoppingToken.IsCancellationRequested)
        {
            try
            {
                using var scope = _scopeFactory.CreateScope();
                var svc = scope.ServiceProvider.GetRequiredService<OutputUploaderService>();
                await svc.ProcessPendingRunsAsync(stoppingToken);
            }
            catch (Exception ex)
            {
                _log.Error("Top-level uploader loop error.", ex);
            }

            try
            {
                await Task.Delay(TimeSpan.FromSeconds(Math.Max(30, _opts.PollingIntervalSeconds)), stoppingToken);
            }
            catch (TaskCanceledException) { }
        }
    }
}
