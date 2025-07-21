using Common.Logging;
using CsvHelper;
using CsvHelper.Configuration;
using LRN.DataLibrary.Repository.Interfaces;
using LRN.ExcelToSqlETL.Core.Interface;
using LRN.ExcelToSqlETL.Core.Models;
using System.Data;
using System.Formats.Asn1;
using System.Globalization;
using System.Text;

namespace LRN.ExcelETL.Service.Services;
public class CSVFileReader : IFileCSVReader
{
    private static readonly ILoggerService _logger = new LogManagerService();
    private static List<FileLog> ImportLog;
    private static int _ImportFileId = 0;
    private readonly IImportFilesRepository _importRepo;

    public CSVFileReader(IImportFilesRepository importRepo)
    {
        _importRepo = importRepo;
        ImportLog = new List<FileLog>();
    }

    public async Task<List<ExcelReadResult>> ReadAsync(Stream stream, ExcelSheetMapping mapping, int ImportFileId)
    {
        _ImportFileId = ImportFileId;

        var result = mapping.UseDynamicSchema
            ? await ReadDynamicAsync(stream, mapping)
            : await ReadMappedAsync(stream, mapping);

        await _importRepo.InsertFileLog(ImportLog);
        return result;
    }

    private async Task<List<ExcelReadResult>> ReadMappedAsync(Stream stream, ExcelSheetMapping mapping)
    {
        var resultTable = CreateMappedTableSchema(mapping);
        int totalRows = 0, importedRows = 0, errorRows = 0;

        try
        {
            using var reader = new StreamReader(stream, Encoding.UTF8);
            using var csv = new CsvReader(reader, new CsvConfiguration(CultureInfo.InvariantCulture)
            {
                PrepareHeaderForMatch = args => args.Header.Trim(),
                MissingFieldFound = null,
                BadDataFound = null
            });

            csv.Read();
            csv.ReadHeader();
            var headerMap = csv.HeaderRecord.ToDictionary(h => h, h => h, StringComparer.OrdinalIgnoreCase);
            ValidateHeaders(headerMap, mapping);

            while (await csv.ReadAsync())
            {
                totalRows++;
                var row = resultTable.NewRow();
                bool hasError = false;

                foreach (var colMap in mapping.Columns)
                {
                    try
                    {
                        var value = csv.GetField(colMap.ExcelColumn);
                        row[colMap.SqlColumn] = ExcelFileReader.GetCellValue(value, colMap.DataType);
                    }
                    catch (Exception ex)
                    {
                        hasError = true;
                        _logger.Warn($"Row {totalRows} column '{colMap.ExcelColumn}': {ex.Message}");
                        ImportLog.Add(new FileLog
                        {
                            ImportFileId = _ImportFileId,
                            LogType = "Error",
                            LogMessage = $"Row {totalRows} column '{colMap.ExcelColumn}': {ex.Message}"
                        });
                    }
                }

                if (hasError)
                {
                    errorRows++;
                    continue;
                }

                resultTable.Rows.Add(row);
                importedRows++;
            }

            _logger.Info($"CSV parsed. Total: {totalRows}, Imported: {importedRows}, Errors: {errorRows}");
            ImportLog.Add(new FileLog
            {
                ImportFileId = _ImportFileId,
                LogType = "Info",
                LogMessage = $"CSV parsed. Total: {totalRows}, Imported: {importedRows}, Errors: {errorRows}"
            });

            return new List<ExcelReadResult> {
                new ExcelReadResult {
                    Data = resultTable,
                    TotalRows = totalRows,
                    ImportedRows = importedRows,
                    ErrorRows = errorRows
                }
            };
        }
        catch (Exception ex)
        {
            _logger.Error($"ReadMappedAsync CSV error: {ex}");
            ImportLog.Add(new FileLog { ImportFileId = _ImportFileId, LogType = "Error", LogMessage = $"ReadMappedAsync CSV error: {ex}" });
            return null;
        }
    }

    private async Task<List<ExcelReadResult>> ReadDynamicAsync(Stream stream, ExcelSheetMapping mapping)
    {
        var dataTable = new DataTable();
        int totalRows = 0;

        try
        {
            using var reader = new StreamReader(stream, Encoding.UTF8);
            using var csv = new CsvReader(reader, CultureInfo.InvariantCulture);

            await csv.ReadAsync();
            csv.ReadHeader();
            foreach (var header in csv.HeaderRecord)
            {
                if (!dataTable.Columns.Contains(header))
                    dataTable.Columns.Add(header);
            }

            while (await csv.ReadAsync())
            {
                var row = dataTable.NewRow();
                foreach (var header in csv.HeaderRecord)
                {
                    row[header] = csv.GetField(header);
                }

                dataTable.Rows.Add(row);
                totalRows++;
            }

            _logger.Info($"Finished dynamic CSV read. Rows: {totalRows}");
            ImportLog.Add(new FileLog
            {
                ImportFileId = _ImportFileId,
                LogType = "Info",
                LogMessage = $"Finished dynamic CSV read. Rows: {totalRows}"
            });

            return new List<ExcelReadResult> {
                new ExcelReadResult {
                    Data = dataTable,
                    TotalRows = totalRows,
                    ImportedRows = totalRows,
                    ErrorRows = 0
                }
            };
        }
        catch (Exception ex)
        {
            _logger.Error($"Error in ReadDynamicAsync CSV: {ex}");
            ImportLog.Add(new FileLog { ImportFileId = _ImportFileId, LogType = "Error", LogMessage = $"Error in ReadDynamicAsync CSV: {ex}" });
            return null;
        }
    }

    private DataTable CreateMappedTableSchema(ExcelSheetMapping mapping)
    {
        var table = new DataTable();
        foreach (var col in mapping.Columns)
        {
            if (!table.Columns.Contains(col.SqlColumn))
                table.Columns.Add(col.SqlColumn);
        }
        return table;
    }

    private void ValidateHeaders(Dictionary<string, string> headerMap, ExcelSheetMapping mapping)
    {
        var missing = mapping.Columns
            .Where(c => c.Required && !headerMap.ContainsKey(c.ExcelColumn))
            .Select(c => c.ExcelColumn)
            .ToList();

        if (missing.Any())
        {
            string msg = $"Missing required column(s): {string.Join(", ", missing)}";
            ImportLog.Add(new FileLog { ImportFileId = _ImportFileId, LogType = "Error", LogMessage = msg });
            throw new Exception(msg);
        }
    }
}
