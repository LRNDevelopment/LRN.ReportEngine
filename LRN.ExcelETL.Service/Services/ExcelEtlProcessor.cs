using Common.Logging;
using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Threading.Tasks;
using LRN.DataLibrary.Repository.Interfaces;
using LRN.ExcelToSqlETL.Core.DtoModels;
using LRN.ExcelToSqlETL.Core.Interface;
using LRN.ExcelToSqlETL.Core.Models;
using Microsoft.Extensions.Configuration;
using Newtonsoft.Json;
using System.Data;
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
        private readonly IFileCSVReader _fileCSVReader;

        public ExcelEtlProcessor(
            IExcelMapperLoader mapper,
            IFileReader reader,
            IDataValidator validator,
            IDataImporter importer,
            ILoggerService logger,
            IConfiguration config,
            IImportFilesRepository importRepo,
            IFileCSVReader fileCSVReader)
        {
            _mapper = mapper;
            _reader = reader;
            _validator = validator;
            _importer = importer;
            _logger = logger;
            _config = config;
            _importRepo = importRepo;
            _fileCSVReader = fileCSVReader;
        }

        private async Task HandleFileProcessingAsync(
            ImportFileDto fileDto,
            string fileName,
            string jsonPath,
            int fileId,
            List<FileLog> importLog)
        {
            try
            {
                _logger.Info($"Processing file {fileName}...");
                importLog.Add(new FileLog { ImportFileId = fileId, LogType = "Info", LogMessage = $"Processing file {fileName}..." });

                var mapping = _mapper.LoadMapping(jsonPath);

                using var stream = File.OpenRead(fileDto.ImportFilePath);

                List<ExcelReadResult> readResults;
                if (Path.GetExtension(fileDto.ImportFilePath).ToLowerInvariant() == ".csv")
                {
                    readResults = await _fileCSVReader.ReadAsync(stream, mapping, fileId);
                }
                else
                {
                    readResults = await _reader.ReadAsync(stream, mapping, fileId);
                }

                // Reader already logs detailed header mismatch / missing required columns.
                if (readResults == null || readResults.Any(r => r.IsFailedRead))
                {
                    var msg = $"File skipped (template/header mismatch or missing required columns): {fileName}";
                    _logger.Error(msg);
                    importLog.Add(new FileLog { ImportFileId = fileId, LogType = "Error", LogMessage = msg });

                    fileDto.ExcelRowCount = 0;
                    fileDto.ImportedRowCount = 0;
                    fileDto.FileStatus = (int)FileStatusEnum.ImportFailed;
                    await _importRepo.UpdateFileAsync(fileDto);
                    return;
                }

                foreach (var result in readResults)
                {
                    // Validate (MappingValidator no longer logs to DB, avoids duplicates)
                    var validation = await _validator.Validate(result.Data, mapping, fileId);

                    if (!validation.IsValid)
                    {
                        foreach (var error in validation.Errors)
                        {
                            var msg = $"Validation error in {fileName}: {error}";
                            importLog.Add(new FileLog { ImportFileId = fileId, LogType = "Error", LogMessage = msg });
                            _logger.Error(msg);
                        }

                        fileDto.ExcelRowCount = 0;
                        fileDto.ImportedRowCount = 0;
                        fileDto.FileStatus = (int)FileStatusEnum.ImportFailed;
                        await _importRepo.UpdateFileAsync(fileDto);
                        return; // Skip import
                    }

                    // Fill staging column if needed
                    if (result.Data.Columns.Contains("ImportedFileID"))
                    {
                        foreach (DataRow row in result.Data.Rows)
                        {
                            row["ImportedFileID"] = fileDto.ImportedFileId;
                        }
                    }

                    LogPotentialProblemColumns(result.Data, fileId, importLog);

                    await _importer.ImportAsync(result.Data, mapping.TargetTable, fileId);

                    fileDto.ExcelRowCount = result.TotalRows;
                    fileDto.ImportedRowCount = result.ImportedRows;
                    fileDto.FileStatus = (int)FileStatusEnum.ImportInProgresss;

                    await _importRepo.UpdateFileAsync(fileDto);
                    await _importRepo.ProcessImportFilesAsync(fileDto);

                    var okMsg = $"Imported {result.ImportedRows} rows to {mapping.TargetTable}.";
                    _logger.Info(okMsg);
                    importLog.Add(new FileLog { ImportFileId = fileId, LogType = "Info", LogMessage = okMsg });
                }
            }
            catch (Exception ex)
            {
                var msg = $"Error processing file {fileName}: {ex.Message} {(ex.InnerException != null ? " INNER: " + ex.InnerException.Message : string.Empty)}";
                _logger.Error(msg);
                importLog.Add(new FileLog { ImportFileId = fileId, LogType = "Error", LogMessage = msg });

                fileDto.FileStatus = (int)FileStatusEnum.ImportFailed;
                await _importRepo.UpdateFileAsync(fileDto);
            }
        }

        /// <summary>
        /// Optimization: scan only a limited number of rows, and only log columns that exceed 255 chars.
        /// </summary>
        private void LogPotentialProblemColumns(DataTable data, int fileId, List<FileLog> importLog, int rowScanLimit = 500)
        {
            if (data.Rows.Count == 0)
                return;

            int rowsToScan = Math.Min(rowScanLimit, data.Rows.Count);

            foreach (DataColumn column in data.Columns)
            {
                int maxLength = 0;
                int longValueCount = 0;

                for (int i = 0; i < rowsToScan; i++)
                {
                    var row = data.Rows[i];
                    if (row.IsNull(column))
                        continue;

                    var value = row[column]?.ToString() ?? string.Empty;
                    int len = value.Length;

                    if (len > maxLength)
                        maxLength = len;

                    if (len > 255)
                        longValueCount++;
                }

                if (maxLength > 255)
                {
                    var msg = $"Potential column length issue: '{column.ColumnName}' - Max length (sampled): {maxLength}, Count>255 (sampled): {longValueCount}";
                    _logger.Warn(msg);
                    importLog.Add(new FileLog { ImportFileId = fileId, LogType = "Warning", LogMessage = msg });
                }
            }
        }

        private async Task ProcessFilesAsync(List<ImportFileDto> files)
        {
            foreach (var file in files)
            {
                var fileId = (int)file.ImportedFileId;
                var importLog = new List<FileLog>();

                string fileName = Path.GetFileName(file.ImportFileName);
                _logger.Info($"File Processing Start for: {fileName}");

                var mappingDtl = _validator.FileMapping(
                    JsonConvert.DeserializeObject<MappingConfigRoot>(File.ReadAllText(MappingJSONPath)),
                    fileName,
                    file.FileType.ToString());

                var jsonPath = Path.Combine(JSONPath, mappingDtl.JsonMappingPath);

                if (!File.Exists(jsonPath))
                {
                    var msg = $"Mapping file not found: {jsonPath}";
                    _logger.Error(msg);

                    importLog.Add(new FileLog { ImportFileId = fileId, LogType = "Error", LogMessage = msg });

                    file.FileStatus = (int)FileStatusEnum.ImportFailed;
                    await _importRepo.UpdateFileAsync(file);

                    await _importRepo.InsertFileLog(importLog);
                    continue;
                }

                // Update file status to InProgress
                file.FileStatus = (int)FileStatusEnum.ImportInProgresss;
                await _importRepo.UpdateFileAsync(file);

                await HandleFileProcessingAsync(file, fileName, jsonPath, fileId, importLog);

                await _importRepo.InsertFileLog(importLog);
                _logger.Info($"File Processing completed for: {fileName}");
            }
        }

        public async Task ProcessImportFileAsync(int fileId)
        {
            var importLog = new List<FileLog>();

            _logger.Info("-----------Bulk Copy Process Initiated--------------");
            importLog.Add(new FileLog { ImportFileId = fileId, LogType = "Info", LogMessage = "Import Process Started" });

            var file = await _importRepo.GetImportFileById(fileId);
            if (file == null)
            {
                var msg = $"File with ID {fileId} not found.";
                _logger.Error(msg);
                importLog.Add(new FileLog { ImportFileId = fileId, LogType = "Error", LogMessage = msg });
                await _importRepo.InsertFileLog(importLog);
                return;
            }

            try
            {
                string configPath = MappingJSONPath;

                if (!File.Exists(configPath))
                {
                    var msg = $"Mapping config file not found: {configPath}";
                    _logger.Error(msg);
                    importLog.Add(new FileLog { ImportFileId = fileId, LogType = "Error", LogMessage = msg });
                    await _importRepo.InsertFileLog(importLog);
                    return;
                }

                var masterConfig = JsonConvert.DeserializeObject<MappingConfigRoot>(File.ReadAllText(configPath));
                file.FileStatus = (int)FileStatusEnum.ImportInProgresss;
                await _importRepo.UpdateFileAsync(file);

                var mappingDtl = _validator.FileMapping(masterConfig, file.ImportFileName, file.FileType.ToString());
                var jsonPath = Path.Combine(JSONPath, mappingDtl.JsonMappingPath);

                if (!File.Exists(jsonPath))
                {
                    var msg = $"Mapping file not found: {jsonPath}";
                    _logger.Error(msg);
                    importLog.Add(new FileLog { ImportFileId = fileId, LogType = "Error", LogMessage = msg });
                    await _importRepo.InsertFileLog(importLog);
                    return;
                }

                await HandleFileProcessingAsync(file, file.ImportFileName, jsonPath, fileId, importLog);

                await _importRepo.InsertFileLog(importLog);
            }
            catch (Exception ex)
            {
                var msg = $"Error processing file {file.ImportFileName}: {ex.Message} {(ex.InnerException != null ? " INNER: " + ex.InnerException.Message : string.Empty)}";
                _logger.Error(msg);

                importLog.Add(new FileLog
                {
                    ImportFileId = fileId,
                    LogType = "Error",
                    LogMessage = msg
                });

                file.FileStatus = (int)FileStatusEnum.ImportFailed;
                await _importRepo.UpdateFileAsync(file);
                await _importRepo.InsertFileLog(importLog);
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
