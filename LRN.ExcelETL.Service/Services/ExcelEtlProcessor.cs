using Common.Logging;
using LRN.DataLibrary.Repository.Interfaces;
using LRN.ExcelToSqlETL.Core.Constants;
using LRN.ExcelToSqlETL.Core.DtoModels;
using LRN.ExcelToSqlETL.Core.Interface;
using LRN.ExcelToSqlETL.Core.Models;
using Microsoft.Extensions.Configuration;
using Newtonsoft.Json;
using System.Data;
using System.IO;
using System.Linq;
using System.Threading.Tasks;
using static LRN.ExcelToSqlETL.Core.Constants.CommonConst;

namespace LRN.ExcelETL.Service.Services
{
    public class ExcelEtlProcessor
    {
        private readonly IExcelMapperLoader _mapper;
        private readonly IFileReader _reader;
        private readonly IDataValidator _validator;
        private readonly IDataImporter _importer;
        private readonly ILoggerService _logger;
        private readonly IConfiguration _config;
        private readonly IImportFilesRepository _importRepo;
        private static List<FileLog> ImportLog;
        private static int _fileId = 0;

        public ExcelEtlProcessor(
            IExcelMapperLoader mapper,
            IFileReader reader,
            IDataValidator validator,
            IDataImporter importer,
            ILoggerService logger,
            IConfiguration config,
            IImportFilesRepository importRepo)
        {
            _mapper = mapper;
            _reader = reader;
            _validator = validator;
            _importer = importer;
            _logger = logger;
            _config = config;
            _importRepo = importRepo;
            ImportLog = new List<FileLog>();
        }

        private async Task HandleFileProcessingAsync(ImportFileDto fileDto, string fileName, string jsonPath)
        {
            try
            {
                _logger.Info($"Processing file {fileName}...");


                var mapping = _mapper.LoadMapping(jsonPath);
                using var stream = File.OpenRead(fileDto.ImportFilePath);
                var readResults = await _reader.ReadAsync(stream, mapping, _fileId);

                foreach (var result in readResults)
                {
                    var validation = _validator.Validate(result.Data, mapping, _fileId).Result;
                    if (!validation.IsValid)
                    {
                        foreach (var error in validation.Errors)
                        {
                            ImportLog.Add(new FileLog { ImportFileId = _fileId, LogType = "Error", LogMessage = $"Validation error in {fileName}: {error}" });
                            _logger.Error($"Validation error in {fileName}: {error}");
                        }
                        continue;
                    }

                    if (result.Data.Columns.Contains("ImportedFileID"))
                    {
                        foreach (DataRow row in result.Data.Rows)
                        {
                            row["ImportedFileID"] = fileDto.ImportedFileId;
                        }
                    }

                    await _importer.ImportAsync(result.Data, mapping.TargetTable, _fileId);

                    // Update file stats after import
                    fileDto.ExcelRowCount = result.TotalRows;
                    fileDto.ImportedRowCount = result.ImportedRows;
                    fileDto.FileStatus = (int)FileStatusEnum.ImportInProgresss;

                    await _importRepo.UpdateFileAsync(fileDto);

                    await _importRepo.ProcessImportFilesAsync(fileDto);

                    _logger.Info($"Imported {result.ImportedRows} rows to {mapping.TargetTable}.");
                }
            }
            catch (Exception ex)
            {
                _logger.Error($"Error processing file {fileName}: {ex.Message}");
                fileDto.FileStatus = (int)FileStatusEnum.ImportFailed;
                await _importRepo.UpdateFileAsync(fileDto);
            }
        }

        private async Task ProcessFilesAsync(List<ImportFileDto> files)
        {
            foreach (var file in files)
            {
                string fileName = Path.GetFileName(file.ImportFileName);
                _logger.Info($"File Processing Start for: {fileName}");

                var mappingDtl = _validator.FileMapping(JsonConvert.DeserializeObject<MappingConfigRoot>(File.ReadAllText(MappingJSONPath)), fileName);
                var jsonPath = Path.Combine(JSONPath, mappingDtl.JsonMappingPath);

                if (!File.Exists(jsonPath))
                {
                    _logger.Error($"Mapping file not found: {jsonPath}");
                    file.FileStatus = (int)FileStatusEnum.ImportFailed;
                    await _importRepo.UpdateFileAsync(file);
                    continue;
                }

                // Update file status to InProgress
                file.FileStatus = (int)FileStatusEnum.ImportInProgresss;
                await _importRepo.UpdateFileAsync(file);

                await HandleFileProcessingAsync(file, fileName, jsonPath);

                _logger.Info($"File Processing completed for: {fileName}");
            }
        }

        public async Task ProcessImportFileAsync(int fileId)
        {
            _logger.Info("-----------Bulk Copy Process Initiated--------------");
            _fileId = fileId;

            ImportLog.Add(new FileLog { ImportFileId = fileId, LogType = "Info", LogMessage = "Import Process Started" });
            var file = await _importRepo.GetImportFileById(fileId);
            if (file == null)
            {
                _logger.Error($"File with ID {fileId} not found.");
                ImportLog.Add(new FileLog { ImportFileId = fileId, LogType = "Error", LogMessage = $"File with ID {fileId} not found" });
                return;
            }

            try
            {
                string configPath = MappingJSONPath;

                if (!File.Exists(configPath))
                {
                    _logger.Error($"Mapping config file not found: {configPath}");
                    ImportLog.Add(new FileLog { ImportFileId = fileId, LogType = "Error", LogMessage = $"Mapping config file not found: {configPath}" });
                    return;
                }

                var masterConfig = JsonConvert.DeserializeObject<MappingConfigRoot>(File.ReadAllText(configPath));
                file.FileStatus = (int)FileStatusEnum.ImportInProgresss;
                await _importRepo.UpdateFileAsync(file);

                var mappingDtl = _validator.FileMapping(masterConfig, file.ImportFileName);
                var jsonPath = Path.Combine(JSONPath, mappingDtl.JsonMappingPath);

                if (!File.Exists(jsonPath))
                {
                    _logger.Error($"Mapping file not found: {jsonPath}");
                    ImportLog.Add(new FileLog { ImportFileId = fileId, LogType = "Error", LogMessage = $"Mapping file not found: {jsonPath}" });
                    return;
                }

                await HandleFileProcessingAsync(file, file.ImportFileName, jsonPath);

                file.FileStatus = (int)FileStatusEnum.ImportSuccess;

                await _importRepo.UpdateFileAsync(file);

                await _importRepo.InsertFileLog(ImportLog);
            }
            catch (Exception ex)
            {
                _logger.Error($"Error processing file {file.ImportFileName}: {ex.Message}");

                ImportLog.Add(new FileLog
                {
                    ImportFileId = fileId,
                    LogType = "Error",
                    LogMessage = $"Error processing file {file.ImportFileName}: {ex.Message} : INNER EXCEPTION : {(ex.InnerException != null ? ex.InnerException.Message : string.Empty)}"
                });

                file.FileStatus = (int)FileStatusEnum.ImportFailed;
                await _importRepo.UpdateFileAsync(file);
                await _importRepo.InsertFileLog(ImportLog);
            }

        }

        public async Task RunAsync()
        {
            try
            {
                _logger.Info("-----------Bulk Copy Process Initiated--------------");

                var configPath = MappingJSONPath;
                if (!File.Exists(configPath))
                {
                    _logger.Error($"Mapping config file not found: {configPath}");
                    return;
                }

                var masterConfig = JsonConvert.DeserializeObject<MappingConfigRoot>(File.ReadAllText(configPath));
                var excelFiles = Directory.GetFiles(InputFilePath, "*.xlsx");

                var importFileDtos = excelFiles.Select(file => new ImportFileDto
                {
                    ImportFileName = Path.GetFileName(file)
                }).ToList();

                importFileDtos = await _importRepo.InsertImportFilesDataAsync(importFileDtos);

                await ProcessFilesAsync(importFileDtos);

                _logger.Info("-----------Bulk Copy Process Completed--------------");
            }
            catch (Exception ex)
            {
                _logger.Error("Error on importing data : ", ex);
                throw;
            }

        }
    }
}
