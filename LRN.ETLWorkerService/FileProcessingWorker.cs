using LRN.DataLibrary.Repository.Interfaces;
using LRN.ExcelETL.Service.Services;
using LRN.ExcelToSqlETL.Core.Constants;
using Common.Logging;
using Microsoft.Extensions.DependencyInjection;
using Microsoft.Extensions.Hosting;
//using Microsoft.Extensions.Logging;
using System;
using System.Linq;
using System.Threading;
using System.Threading.Tasks;

public class FileProcessingWorker : BackgroundService
{
   // private readonly ILogger<FileProcessingWorker> _logger;

    private readonly ILoggerService _logger;

    private readonly IServiceScopeFactory _scopeFactory;

    public FileProcessingWorker(ILoggerService logger,  IServiceScopeFactory scopeFactory)
    {
        _logger = logger;
        _scopeFactory = scopeFactory;
    }

    protected override async Task ExecuteAsync(CancellationToken stoppingToken)
    {
        _logger.Info("ETL Worker Service started successfully");
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
                       // HandleMasterFileIfRequired(file);
                        await fileReader.ProcessImportFileAsync((int)file.ImportedFileId);
                        //_logger.Info("Processed file {FileId} successfully.", file.ImportedFileId);
                        _logger.Info($"Processed file {file.ImportedFileId} successfully.");

                    }
                    catch (Exception ex)
                    {
                        file.FileStatus = (int)CommonConst.FileStatusEnum.ImportFailed;
                        await importRepo.UpdateFileAsync(file);
                        // _logger.Error(ex, "Failed to process file {FileId}: {Message}", file.ImportedFileId, ex.Message);
                        _logger.Error($"Failed to process file {file.ImportedFileId}: {ex.Message}",ex);

                    }
                }

                try
                {
                    await Task.Delay(TimeSpan.FromMinutes(1), stoppingToken);
                }
                catch (TaskCanceledException)
                {
                    _logger.Warn("Worker delay was canceled (likely due to shutdown).");
                    break; // Optional: gracefully break the loop
                }
            }
            catch (TaskCanceledException)
            {
                _logger.Warn("File processing task was canceled.");
                break;
            }
            catch (Exception ex)
            {
                _logger.Error($"Processed file {"An unexpected error occurred while processing files."} successfully.",ex);
            }
        }

        _logger.Info("FileProcessingWorker is stopping.");
    }
    private void HandleMasterFileIfRequired(dynamic file)
    {
        if (file.IsMasterImport != 1)
            return;

        string sourceFileFullPath = file.ImportFilePath;
        string masterDir = CommonConst.MasterFilesPath;
        string archiveDir = CommonConst.ArchiveFilesPath;
        string fileTypeName = file.FileTypeName; // e.g., "InsuranceMaster", "CustomerMaster", etc.

        Directory.CreateDirectory(masterDir);
        Directory.CreateDirectory(archiveDir);

        // Identify existing master file by FileTypeName
        // Look for files that start with the FileTypeName
        var existingMasterFile = Directory.GetFiles(masterDir)
            .FirstOrDefault(f => Path.GetFileNameWithoutExtension(f)
                .StartsWith(fileTypeName, StringComparison.OrdinalIgnoreCase));

        if (existingMasterFile != null)
        {
            // Archive the existing file with timestamp
            string timestamp = DateTime.Now.ToString("ddMMyy_HHmmss");
            string archiveFileName = $"{Path.GetFileNameWithoutExtension(existingMasterFile)}_{timestamp}{Path.GetExtension(existingMasterFile)}";
            string archiveFile = Path.Combine(archiveDir, archiveFileName);

            File.Move(existingMasterFile, archiveFile, overwrite: true);
        }

        // Verify source file exists
        if (!File.Exists(sourceFileFullPath))
        {
            throw new FileNotFoundException($"Source file not found: {sourceFileFullPath}");
        }

        // Create new master file name with timestamp
        string timestampNew = DateTime.Now.ToString("ddMMyy_HHmmss");
        string extension = Path.GetExtension(sourceFileFullPath);
        string masterFileName = $"{fileTypeName}_{timestampNew}{extension}";
        string masterFile = Path.Combine(masterDir, masterFileName);

        File.Copy(sourceFileFullPath, masterFile, overwrite: true);
    }
    //private void HandleMasterFileIfRequired(dynamic file)
    //{
    //    if (file.IsMasterImport != 1)
    //        return;

    //    string sourceFileFullPath = file.ImportFilePath; // Already contains full path
    //    string masterDir = CommonConst.MasterFilesPath;
    //    string archiveDir = CommonConst.ArchiveFilesPath;
    //    string MasterFileTypeName = file.FileTypeName;


    //    Directory.CreateDirectory(masterDir);
    //    Directory.CreateDirectory(archiveDir);

    //    // Identify same type file in MasterFiles
    //    var existingMasterFile = Directory.GetFiles(masterDir)
    //        .FirstOrDefault(f => f.Contains(file.ImportFileTypeId.ToString()));

    //    if (existingMasterFile != null)
    //    {
    //        string archiveFile = Path.Combine(
    //            archiveDir,
    //            Path.GetFileName(existingMasterFile)
    //        );

    //        File.Move(existingMasterFile, archiveFile, overwrite: true);
    //    }

    //    // Extract just the filename from the full path
    //    string fileName = Path.GetFileName(sourceFileFullPath);
    //    string masterFile = Path.Combine(masterDir, fileName);

    //    // Verify source file exists
    //    if (!File.Exists(sourceFileFullPath))
    //    {
    //        throw new FileNotFoundException($"Source file not found: {sourceFileFullPath}");
    //    }

    //    File.Copy(sourceFileFullPath, masterFile, overwrite: true);
    //}



}
