using Common.Logging;
using LRN.ExcelToSqlETL.Core.Interface;
using LRN.ExcelToSqlETL.Core.Models;
using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace LRN.ExcelETL.Service.Services
{
    public class MappingValidator : IDataValidator
    {
        private static ILoggerService _logger = new LogManagerService();
        public ValidationResult Validate(DataTable table, ExcelSheetMapping mapping)
        {
            try
            {
                var result = new ValidationResult();

                foreach (var col in mapping.Columns)
                {
                    if (col.Required && !table.Columns.Contains(col.SqlColumn))
                        result.Errors.Add($"Missing column: {col.SqlColumn}");
                }

                foreach (DataRow row in table.Rows)
                {
                    foreach (var col in mapping.Columns)
                    {
                        var value = row[col.SqlColumn]?.ToString();
                        if (!IsValid(value, col.DataType))
                            result.Errors.Add($"Invalid {col.DataType} in column {col.SqlColumn}: {value}");
                    }
                }

                return result;
            }
            catch (Exception ex)
            {
                _logger.Error("Error Occured on MappingValidator - Validate : " + ex.ToString());
                return null;
            }

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

        public MappingEntry FileMapping(MappingConfigRoot masterConfig, string filename)
        {
            var matchedMapping = masterConfig.Mappings.FirstOrDefault(m => filename.Contains(m.FileIdentifier, StringComparison.OrdinalIgnoreCase));

            if (matchedMapping == null)
                throw new Exception("No mapping found for this file name.");
            return matchedMapping;
        }
    }
}
