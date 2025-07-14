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
                        _logger.LogInformation($"Processed file {file.ImportedFileId} successfully.");
                    }
                    catch (Exception ex)
                    {
                        file.FileStatus = (int)CommonConst.FileStatusEnum.ImportFailed;
                        await importRepo.UpdateFileAsync(file);
                        _logger.LogError($"Failed to process file {file.ImportedFileId}: {ex.Message}");
                    }
                }

                await Task.Delay(TimeSpan.FromMinutes(3), stoppingToken);
            }
            catch (Exception ex)
            {
                _logger.LogError($"An error occurred while processing files: {ex.Message}");
            }
        }
    }
}
