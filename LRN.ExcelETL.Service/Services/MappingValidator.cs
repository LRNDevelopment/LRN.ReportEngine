using Common.Logging;
using LRN.DataLibrary.Repository.Interfaces;
using LRN.ExcelToSqlETL.Core.Interface;
using LRN.ExcelToSqlETL.Core.Models;
using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Threading.Tasks;

namespace LRN.ExcelETL.Service.Services
{
    public class MappingValidator : IDataValidator
    {
        private static ILoggerService _logger = new LogManagerService();
        private static List<FileLog> ImportLog = new List<FileLog>();
        private readonly IImportFilesRepository _importRepo;

        public MappingValidator(IImportFilesRepository importRepo)
        {
            _importRepo = importRepo;
        }

        public async Task<ValidationResult> Validate(DataTable table, ExcelSheetMapping mapping, int fileId)
        {
            var result = new ValidationResult();

            try
            {
                foreach (var col in mapping.Columns)
                {
                    if (col.Required && !table.Columns.Contains(col.SqlColumn))
                    {
                        var msg = $"Missing column: {col.SqlColumn}";
                        ImportLog.Add(new FileLog { ImportFileId = fileId, LogType = "Error", LogMessage = msg });
                        result.Errors.Add(msg);
                    }
                }

                foreach (DataRow row in table.Rows)
                {
                    foreach (var col in mapping.Columns)
                    {
                        var value = row[col.SqlColumn]?.ToString();
                        if (!IsValid(value, col.DataType))
                        {
                            var msg = $"Invalid {col.DataType} in column {col.SqlColumn}: {value}";
                            ImportLog.Add(new FileLog { ImportFileId = fileId, LogType = "Error", LogMessage = msg });
                            result.Errors.Add(msg);
                        }
                    }
                }

                await _importRepo.InsertFileLog(ImportLog);
            }
            catch (Exception ex)
            {
                var err = "Error Occurred on MappingValidator - Validate : " + ex.ToString();
                ImportLog.Add(new FileLog { ImportFileId = fileId, LogType = "Error", LogMessage = err });
                await _importRepo.InsertFileLog(ImportLog);
                _logger.Error(err);
            }

            return result;
        }

        private bool IsValid(string? value, string dataType)
        {
            if (string.IsNullOrWhiteSpace(value)) return true;

            return dataType.ToLower() switch
            {
                "int" => int.TryParse(value, out _),
                "datetime" => DateTime.TryParse(value, out _),
                "decimal" => decimal.TryParse(value, out _),
                _ => true
            };
        }

        public MappingEntry FileMapping(MappingConfigRoot masterConfig, string filename, string fileType)
        {


            // First priority: fileType matches
            var fileTypeMappings = masterConfig.Mappings
                .Where(m => m.FileType.Trim().Equals(fileType, StringComparison.OrdinalIgnoreCase))
                .ToList();

            if (fileTypeMappings.Count == 0)
            {
                var errorMessage = $"No mapping found for file type: {fileType}. File: {filename}";
                throw new Exception(errorMessage);
            }

            // Second priority: filename pattern within fileType matches
            var exactMatch = fileTypeMappings.FirstOrDefault(m =>
                filename.Contains(m.FileIdentifier, StringComparison.OrdinalIgnoreCase));

            if (exactMatch != null)
            {
                return exactMatch;
            }

            // If only one mapping exists for this fileType, use it (even without filename match)
            if (fileTypeMappings.Count == 1)
            {
                var singleMapping = fileTypeMappings.First();
                return singleMapping;
            }

            // Multiple mappings for same fileType - ambiguous case
            var ambiguousIdentifiers = string.Join(", ", fileTypeMappings.Select(m => m.FileIdentifier));
            var errorMsg = $"Ambiguous mapping for file type '{fileType}'. " +
                          $"Multiple mappings found: {ambiguousIdentifiers}. " +
                          $"Filename '{filename}' doesn't contain any expected identifier.";

            throw new Exception(errorMsg);
        }
    }
}

