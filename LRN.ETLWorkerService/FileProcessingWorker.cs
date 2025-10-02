using LRN.DataLibrary.Repository.Interfaces;
using LRN.ExcelETL.Service.Services;
using LRN.ExcelToSqlETL.Core.Constants;
using Microsoft.Extensions.DependencyInjection;
using Microsoft.Extensions.Hosting;
using Microsoft.Extensions.Logging;
using System;
using System.Linq;
using System.Threading;
using System.Threading.Tasks;

public class FileProcessingWorker : BackgroundService
{
    private readonly ILogger<FileProcessingWorker> _logger;
    private readonly IServiceScopeFactory _scopeFactory;

    public FileProcessingWorker(ILogger<FileProcessingWorker> logger, IServiceScopeFactory scopeFactory)
    {
        _logger = logger;
        _scopeFactory = scopeFactory;
    }

    protected override async Task ExecuteAsync(CancellationToken stoppingToken)
    {
        while (!stoppingToken.IsCancellationRequested)
        {
            using var scope = _scopeFactory.CreateScope();
            var fileReader = scope.ServiceProvider.GetRequiredService<ExcelEtlProcessor>();
            var importRepo = scope.ServiceProvider.GetRequiredService<IImportFilesRepository>();

            try
            {
                var filesToProcess = await importRepo.GetImportFilesAsync();
                var queuedFiles = filesToProcess
                    .Where(c => c.FileStatusId == (int)CommonConst.FileStatusEnum.ImportQueued)
                    .ToList();

                foreach (var file in queuedFiles)
                {
                    try
                    {
                        await fileReader.ProcessImportFileAsync((int)file.ImportedFileId);
                        _logger.LogInformation("Processed file {FileId} successfully.", file.ImportedFileId);
                    }
                    catch (Exception ex)
                    {
                        file.FileStatus = (int)CommonConst.FileStatusEnum.ImportFailed;
                        await importRepo.UpdateFileAsync(file);
                        _logger.LogError(ex, "Failed to process file {FileId}: {Message}", file.ImportedFileId, ex.Message);
                    }
                }

                try
                {
                    await Task.Delay(TimeSpan.FromMinutes(10), stoppingToken);
                }
                catch (TaskCanceledException)
                {
                    _logger.LogWarning("Worker delay was canceled (likely due to shutdown).");
                    break; // Optional: gracefully break the loop
                }
            }
            catch (TaskCanceledException)
            {
                _logger.LogWarning("File processing task was canceled.");
                break;
            }
            catch (Exception ex)
            {
                _logger.LogError(ex, "An unexpected error occurred while processing files.");
            }
        }

        _logger.LogInformation("FileProcessingWorker is stopping.");
    }

}
