using LRN.DataLibrary.Repository.Interfaces;
using LRN.ExcelETL.Service.Services;
using LRN.ExcelToSqlETL.Core.Constants;
using Microsoft.Extensions.Hosting;
using Microsoft.Extensions.Logging;
using System;
using System.Linq;
using System.Threading;
using System.Threading.Tasks;

public class FileProcessingWorker : BackgroundService
{
    private readonly ILogger<FileProcessingWorker> _logger;
    private readonly ExcelEtlProcessor _fileReader;
    private readonly IImportFilesRepository _importRepo;

    public FileProcessingWorker(ILogger<FileProcessingWorker> logger, ExcelEtlProcessor fileReader, IImportFilesRepository importRepo)
    {
        _logger = logger;
        _fileReader = fileReader;
        _importRepo = importRepo;
    }

    protected override async Task ExecuteAsync(CancellationToken stoppingToken)
    {
        while (!stoppingToken.IsCancellationRequested)
        {
            try
            {
                // Query for files with 'queued' status asynchronously
                var filesToProcess = await _importRepo.GetImportFilesAsync(); // Now using await
                var queuedFiles = filesToProcess.Where(c => c.FileStatus == (int)CommonConst.FileStatusEnum.ImportQueued).ToList();

                if (queuedFiles.Any())
                {
                    foreach (var file in queuedFiles)
                    {
                        try
                        {
                          
                            // Process the file (ETL logic here)
                            await _fileReader.ProcessImportFileAsync((int)file.ImportedFileId);

                            _logger.LogInformation($"Processed file {file.ImportedFileId} successfully.");
                        }
                        catch (Exception ex)
                        {
                            // If error occurs during processing, update the file status to 'failed'
                            file.FileStatus = (int)CommonConst.FileStatusEnum.ImportFailed;
                            await _importRepo.UpdateFileAsync(file);  // Assuming an async update method
                            _logger.LogError($"Failed to process file {file.ImportedFileId}: {ex.Message}");
                        }
                    }
                }

                // Delay before checking for new files (every 1 minute)
                await Task.Delay(TimeSpan.FromMinutes(1), stoppingToken);
            }
            catch (Exception ex)
            {
                _logger.LogError($"An error occurred while processing files: {ex.Message}");
            }
        }
    }
}
