using Common.Logging;
using LRN.DataAccess.Repository.Interfaces;
using LRN.ExcelToSqlETL.Core.Constants;
using LRN.ExcelToSqlETL.Core.DtoModels;
using LRN.ExcelToSqlETL.Core.Interface;
using LRN.ExcelToSqlETL.Core.Models;
using Microsoft.Extensions.Configuration;
using Newtonsoft.Json;
using System.Data;
using static LRN.ExcelToSqlETL.Core.Constants.CommonConst;

namespace LRN.ExcelETL.Service.Services;

public class ExcelEtlProcessor
{
    private readonly IExcelMapperLoader _mapper;
    private readonly IFileReader _reader;
    private readonly IDataValidator _validator;
    private readonly IDataImporter _importer;
    private readonly ILoggerService _logger;
    private readonly IConfiguration _config;
    private readonly IImportFilesRepository _importRepo;

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
    }

    public async Task RunAsync()
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

        foreach (var file in excelFiles)
        {
            string fileName = Path.GetFileName(file);
            _logger.Info($"File Processing Start for: {fileName}");

            try
            {
                var mappingDtl = _validator.FileMapping(masterConfig, fileName);
                var jsonPath = Path.Combine(JSONPath, mappingDtl.JsonMappingPath);

                if (!File.Exists(jsonPath))
                {
                    _logger.Error($"Mapping file not found: {jsonPath}");
                    continue;
                }

                var mapping = _mapper.LoadMapping(jsonPath);
                _logger.Info($"Loaded mapping from: {jsonPath}");

                using var stream = File.OpenRead(file);
                var readResults = await _reader.ReadAsync(stream, mapping);

                var currentFileDto = importFileDtos.FirstOrDefault(f => f.ImportFileName == fileName);
                if (currentFileDto == null)
                {
                    _logger.Error($"ImportFileDto not found for: {fileName}");
                    continue;
                }

                currentFileDto.FileType = int.Parse(mappingDtl.FileType);

                foreach (var result in readResults)
                {
                    var validation = _validator.Validate(result.Data, mapping);
                    if (!validation.IsValid)
                    {
                        foreach (var error in validation.Errors)
                        {
                            _logger.Error($"Validation error in {fileName}: {error}");
                        }
                        continue;
                    }

                    if (result.Data.Columns.Contains("ImportedFileID") && currentFileDto.ImportedFileId != null)
                    {
                        foreach (DataRow row in result.Data.Rows)
                        {
                            row["ImportedFileID"] = currentFileDto.ImportedFileId;
                        }
                    }

                    await _importer.ImportAsync(result.Data, mapping.TargetTable);

                    currentFileDto.ExcelRowCount = result.TotalRows;
                    currentFileDto.ImportedRowCount = result.ImportedRows;
                    currentFileDto.FileStatus = (int)FileStatusEnum.ImportSuccess;
                    currentFileDto.ImportedOn = DateTime.Now;

                    await _importRepo.UpdateFileAsync(currentFileDto);

                    _logger.Info($"Imported {result.ImportedRows} rows to {mapping.TargetTable} for file {fileName}");
                }
            }
            catch (Exception ex)
            {
                _logger.Error($"Error processing file {fileName}: {ex.Message}");
                var failedDto = importFileDtos.FirstOrDefault(f => f.ImportFileName == fileName);
                if (failedDto != null)
                {
                    failedDto.FileStatus = (int)FileStatusEnum.ImportFailed;
                    failedDto.ImportedOn = DateTime.Now;
                }
            }

            _logger.Info($"File Processing completed for: {fileName}");
        }

        await _importRepo.ProcessImportFilesAsync(importFileDtos);

        _logger.Info("-----------Bulk Copy Process Completed--------------");
    }
}
