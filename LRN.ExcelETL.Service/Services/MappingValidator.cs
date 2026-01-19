using Common.Logging;
using System.Linq;
using LRN.DataLibrary.Repository.Interfaces;
using LRN.ExcelToSqlETL.Core.Interface;
using LRN.ExcelToSqlETL.Core.Models;
using System;
using System.Data;
using System.Threading.Tasks;

namespace LRN.ExcelETL.Service.Services
{
    public class MappingValidator : IDataValidator
    {
        private static readonly ILoggerService _logger = new LogManagerService();

        // Keep DI signature unchanged (even if repo isn't used now)
        private readonly IImportFilesRepository _importRepo;

        public MappingValidator(IImportFilesRepository importRepo)
        {
            _importRepo = importRepo;
        }

        /// <summary>
        /// Validates the in-memory DataTable against mapping types.
        /// NOTE: This method no longer writes logs to DB to avoid duplicate logging.
        /// The caller (ExcelEtlProcessor) should log & persist errors once.
        /// </summary>
        public Task<ValidationResult> Validate(DataTable table, ExcelSheetMapping mapping, int fileId)
        {
            var result = new ValidationResult();

            try
            {
                // (Optional) Schema check – useful for dynamic schema scenarios.
                foreach (var col in mapping.Columns)
                {
                    if (col.Required && !table.Columns.Contains(col.SqlColumn))
                    {
                        result.Errors.Add($"Missing column: {col.SqlColumn}");
                    }
                }

                // Type validation (only validates cells with a value)
                foreach (DataRow row in table.Rows)
                {
                    foreach (var col in mapping.Columns)
                    {
                        if (!table.Columns.Contains(col.SqlColumn))
                            continue;

                        var value = row[col.SqlColumn]?.ToString();

                        if (!IsValid(value, col.DataType))
                            result.Errors.Add($"Invalid {col.DataType} in column {col.SqlColumn}: {value}");
                    }

                    // Optimization: don't collect infinite errors
                    if (result.Errors.Count > 200)
                    {
                        result.Errors.Add("Validation stopped after 200 errors.");
                        break;
                    }
                }
            }
            catch (Exception ex)
            {
                _logger.Error("Error occurred in MappingValidator.Validate: " + ex);
                result.Errors.Add("Error occurred during validation: " + ex.Message);
            }

            return Task.FromResult(result);
        }

        private static bool IsValid(string? value, string dataType)
        {
            if (string.IsNullOrWhiteSpace(value))
                return true;

            return (dataType ?? string.Empty).ToLowerInvariant() switch
            {
                "int" or "integer" => int.TryParse(value, out _),
                "datetime" or "date" => DateTime.TryParse(value, out _),
                "decimal" or "double" => decimal.TryParse(value, out _),
                "bool" or "boolean" => bool.TryParse(value, out _),
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
                throw new Exception($"No mapping found for file type: {fileType}. File: {filename}");
            }

            // Second priority: filename pattern within fileType matches
            var exactMatch = fileTypeMappings.FirstOrDefault(m =>
                filename.Contains(m.FileIdentifier, StringComparison.OrdinalIgnoreCase));

            if (exactMatch != null)
                return exactMatch;

            // If only one mapping exists for this fileType, use it (even without filename match)
            if (fileTypeMappings.Count == 1)
                return fileTypeMappings.First();

            // Multiple mappings for same fileType - ambiguous case
            var ambiguousIdentifiers = string.Join(", ", fileTypeMappings.Select(m => m.FileIdentifier));
            throw new Exception(
                $"Ambiguous mapping for file type '{fileType}'. Multiple mappings found: {ambiguousIdentifiers}. " +
                $"Filename '{filename}' doesn't contain any expected identifier.");
        }
    }
}
