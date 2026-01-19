using Common.Logging;
using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Threading.Tasks;
using CsvHelper;
using CsvHelper.Configuration;
using LRN.DataLibrary.Repository.Interfaces;
using LRN.ExcelToSqlETL.Core.Interface;
using LRN.ExcelToSqlETL.Core.Models;
using System.Data;
using System.Globalization;
using System.Text;

namespace LRN.ExcelETL.Service.Services;

public class CSVFileReader : IFileCSVReader
{
    private static readonly ILoggerService _logger = new LogManagerService();

    private readonly IImportFilesRepository _importRepo;
    private readonly List<FileLog> _importLog = new();

    private int _importFileId;

    // SQL columns that are NOT expected to exist in the CSV header row
    private static readonly HashSet<string> HeaderIgnoreSqlColumns =
        new HashSet<string>(StringComparer.OrdinalIgnoreCase)
        {
            "ImportedFileID"
        };

    public CSVFileReader(IImportFilesRepository importRepo)
    {
        _importRepo = importRepo;
    }

    public async Task<List<ExcelReadResult>> ReadAsync(Stream stream, ExcelSheetMapping mapping, int importFileId)
    {
        _importFileId = importFileId;
        _importLog.Clear();

        var result = mapping.UseDynamicSchema
            ? await ReadDynamicAsync(stream, mapping)
            : await ReadMappedAsync(stream, mapping);

        if (_importLog.Count > 0)
            await _importRepo.InsertFileLog(_importLog);

        return result;
    }

    private async Task<List<ExcelReadResult>> ReadMappedAsync(Stream stream, ExcelSheetMapping mapping)
    {
        var resultTable = CreateMappedTableSchema(mapping);
        int totalRows = 0, importedRows = 0, errorRows = 0;

        bool isFailed = false;

        try
        {
            using var reader = new StreamReader(stream, Encoding.UTF8, detectEncodingFromByteOrderMarks: true, leaveOpen: true);
            using var csv = new CsvReader(reader, new CsvConfiguration(CultureInfo.InvariantCulture)
            {
                PrepareHeaderForMatch = args => args.Header.Trim(),
                MissingFieldFound = null,
                BadDataFound = null
            });

            await csv.ReadAsync();
            csv.ReadHeader();

            var headerRecord = csv.HeaderRecord ?? Array.Empty<string>();
            var headerSet = headerRecord
                .Where(h => !string.IsNullOrWhiteSpace(h))
                .Select(h => h.Trim())
                .ToHashSet(StringComparer.OrdinalIgnoreCase);

            var missingRequired = GetMissingRequiredHeaders(headerSet, mapping);
            if (missingRequired.Count > 0)
                throw new InvalidDataException($"Missing required column(s): {string.Join(", ", missingRequired)}");

            var extra = GetExtraHeaders(headerSet, mapping);
            if (extra.Count > 0)
            {
                var msg = $"CSV contains extra column(s) not in mapping JSON: {string.Join(", ", extra)}";
                _logger.Warn(msg);
                _importLog.Add(new FileLog { ImportFileId = _importFileId, LogType = "Warning", LogMessage = msg });
            }

            while (await csv.ReadAsync())
            {
                totalRows++;
                var row = resultTable.NewRow();
                bool hasError = false;

                foreach (var colMap in mapping.Columns)
                {
                    if (string.IsNullOrWhiteSpace(colMap.ExcelColumn))
                        continue;

                    try
                    {
                        var value = csv.GetField(colMap.ExcelColumn);
                        row[colMap.SqlColumn] = ExcelFileReader.GetCellValue(value, colMap.DataType);
                    }
                    catch (Exception ex)
                    {
                        hasError = true;
                        var msg = $"Row {totalRows} column '{colMap.ExcelColumn}': {ex.Message}";
                        _logger.Warn(msg);
                        _importLog.Add(new FileLog
                        {
                            ImportFileId = _importFileId,
                            LogType = "Error",
                            LogMessage = msg
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
        }
        catch (Exception ex)
        {
            isFailed = true;

            var msg = $"Skipping file due to CSV template/header mismatch: {ex.Message}";
            _logger.Error(msg);
            _importLog.Add(new FileLog { ImportFileId = _importFileId, LogType = "Error", LogMessage = msg });
        }

        var summary = isFailed
            ? $"CSV read FAILED (mapped). Total Rows scanned: {totalRows}, Imported: {importedRows}, Errors: {errorRows}"
            : $"CSV parsed. Total: {totalRows}, Imported: {importedRows}, Errors: {errorRows}";

        _logger.Info(summary);
        _importLog.Add(new FileLog { ImportFileId = _importFileId, LogType = "Info", LogMessage = summary });

        return new List<ExcelReadResult> {
            new ExcelReadResult {
                Data = resultTable,
                TotalRows = totalRows,
                ImportedRows = importedRows,
                ErrorRows = errorRows,
                IsFailedRead = isFailed
            }
        };
    }

    private async Task<List<ExcelReadResult>> ReadDynamicAsync(Stream stream, ExcelSheetMapping mapping)
    {
        var dataTable = new DataTable();
        int totalRows = 0;

        try
        {
            using var reader = new StreamReader(stream, Encoding.UTF8, detectEncodingFromByteOrderMarks: true, leaveOpen: true);
            using var csv = new CsvReader(reader, CultureInfo.InvariantCulture);

            await csv.ReadAsync();
            csv.ReadHeader();

            foreach (var header in csv.HeaderRecord ?? Array.Empty<string>())
            {
                if (!string.IsNullOrWhiteSpace(header) && !dataTable.Columns.Contains(header))
                    dataTable.Columns.Add(header.Trim());
            }

            while (await csv.ReadAsync())
            {
                var row = dataTable.NewRow();
                foreach (var header in csv.HeaderRecord ?? Array.Empty<string>())
                {
                    if (string.IsNullOrWhiteSpace(header)) continue;
                    row[header.Trim()] = csv.GetField(header);
                }

                dataTable.Rows.Add(row);
                totalRows++;
            }

            var msg = $"Finished dynamic CSV read. Rows: {totalRows}";
            _logger.Info(msg);
            _importLog.Add(new FileLog { ImportFileId = _importFileId, LogType = "Info", LogMessage = msg });

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
            var msg = $"Error in ReadDynamicAsync CSV: {ex}";
            _logger.Error(msg);
            _importLog.Add(new FileLog { ImportFileId = _importFileId, LogType = "Error", LogMessage = msg });
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

    private List<string> GetMissingRequiredHeaders(HashSet<string> headerSet, ExcelSheetMapping mapping)
    {
        return mapping.Columns
            .Where(c =>
                c.Required &&
                !string.IsNullOrWhiteSpace(c.ExcelColumn) &&
                (string.IsNullOrWhiteSpace(c.SqlColumn) || !HeaderIgnoreSqlColumns.Contains(c.SqlColumn)) &&
                !headerSet.Contains(c.ExcelColumn.Trim()))
            .Select(c => c.ExcelColumn.Trim())
            .Distinct(StringComparer.OrdinalIgnoreCase)
            .OrderBy(s => s)
            .ToList();
    }

    private List<string> GetExtraHeaders(HashSet<string> headerSet, ExcelSheetMapping mapping)
    {
        var expected = mapping.Columns
            .Where(c =>
                !string.IsNullOrWhiteSpace(c.ExcelColumn) &&
                (string.IsNullOrWhiteSpace(c.SqlColumn) || !HeaderIgnoreSqlColumns.Contains(c.SqlColumn)))
            .Select(c => c.ExcelColumn.Trim())
            .Distinct(StringComparer.OrdinalIgnoreCase)
            .ToHashSet(StringComparer.OrdinalIgnoreCase);

        return headerSet
            .Where(h => !expected.Contains(h))
            .OrderBy(s => s)
            .ToList();
    }
}
