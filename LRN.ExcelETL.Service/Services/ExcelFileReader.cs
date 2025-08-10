using ClosedXML.Excel;
using Common.Logging;
using LRN.DataLibrary.Repository.Interfaces;
using LRN.ExcelToSqlETL.Core.Interface;
using LRN.ExcelToSqlETL.Core.Models;
using System.Data;
using System.Globalization;

public class ExcelFileReader : IFileReader
{
    private static readonly ILoggerService _logger = new LogManagerService();
    private static List<FileLog> ImportLog;
    private static int _ImportFileId = 0;
    private readonly IImportFilesRepository _importRepo;

    public ExcelFileReader(
         IImportFilesRepository importRepo)
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
        try
        {
            using var workbook = new XLWorkbook(stream);
            var resultTable = CreateMappedTableSchema(mapping);

            int totalRows = 0;
            int importedRows = 0;
            int errorRows = 0;

            var worksheets = GetWorksheets(workbook, mapping);
            bool isFailed = false;
            foreach (var worksheet in worksheets)
            {
                try
                {
                    int headerRowIndex = 1;
                    if (!mapping.UseSheetName)
                        headerRowIndex = FindHeaderRow(worksheet, mapping);
                    var headerMap = BuildHeaderMap(worksheet.Row(headerRowIndex));

                    ValidateHeaders(headerMap, mapping);

                    PopulateTableRows(
                        worksheet,
                        headerRowIndex,
                        headerMap,
                        mapping,
                        resultTable,
                        worksheet.Name,
                        ref totalRows,
                        ref importedRows,
                        ref errorRows
                    );
                }
                catch (Exception ex)
                {
                    _logger.Warn($"Skipping sheet '{worksheet.Name}' due to mismatch: {ex.Message}");
                    ImportLog.Add(new FileLog { ImportFileId = _ImportFileId, LogType = "Warning", LogMessage = $"Skipping sheet '{worksheet.Name}' due to mismatch: {ex.Message}" });
                    isFailed = true;
                    break;
                }
            }


            _logger.Info($"Finished reading mapped Excel. Total Rows: {totalRows}, Imported: {importedRows}, Errors: {errorRows}");


            ImportLog.Add(new FileLog { ImportFileId = _ImportFileId, LogType = "Info", LogMessage = $"Finished reading mapped Excel. Total Rows: {totalRows}, Imported: {importedRows}, Errors: {errorRows}" });

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
        catch (Exception ex)
        {
            _logger.Error($"Error in ReadMappedAsync: {ex}");

            ImportLog.Add(new FileLog { ImportFileId = _ImportFileId, LogType = "Error", LogMessage = $"Error in ReadMappedAsync: {ex}" });

            return null;
        }
    }

    private async Task<List<ExcelReadResult>> ReadDynamicAsync(Stream stream, ExcelSheetMapping mapping)
    {
        try
        {
            using var workbook = new XLWorkbook(stream);
            var combinedTable = new DataTable();
            var columnSet = new HashSet<string>(StringComparer.OrdinalIgnoreCase);
            int totalRows = 0;

            var worksheets = GetWorksheets(workbook, mapping);

            foreach (var sheet in worksheets)
            {
                var headerRow = sheet.FirstRowUsed();
                if (headerRow == null) continue;

                foreach (var cell in headerRow.CellsUsed())
                {
                    var header = cell.GetString().Trim();
                    if (!string.IsNullOrWhiteSpace(header))
                        columnSet.Add(header);
                }
            }

            foreach (var col in columnSet)
                combinedTable.Columns.Add(col);

            if (mapping.UseSheetName)
                combinedTable.Columns.Add("SheetName");

            foreach (var sheet in worksheets)
            {
                var headerRow = sheet.FirstRowUsed();
                if (headerRow == null) continue;

                var headerMap = new Dictionary<string, int>(StringComparer.OrdinalIgnoreCase);
                for (int col = 1; col <= headerRow.LastCellUsed().Address.ColumnNumber; col++)
                {
                    var header = headerRow.Cell(col).GetString().Trim();
                    if (!string.IsNullOrWhiteSpace(header))
                        headerMap[header] = col;
                }

                for (int rowNum = headerRow.RowBelow().RowNumber(); rowNum <= sheet.LastRowUsed().RowNumber(); rowNum++)
                {
                    totalRows++;
                    var row = sheet.Row(rowNum);
                    var newRow = combinedTable.NewRow();

                    foreach (var header in headerMap.Keys)
                    {
                        var colIndex = headerMap[header];
                        newRow[header] = row.Cell(colIndex).GetValue<string>();
                    }

                    if (mapping.UseSheetName)
                        newRow["SheetName"] = sheet.Name;

                    combinedTable.Rows.Add(newRow);
                }
            }

            _logger.Info($"Finished reading dynamic Excel. Total Rows: {totalRows}");

            ImportLog.Add(new FileLog { ImportFileId = _ImportFileId, LogType = "Info", LogMessage = $"Finished reading dynamic Excel. Total Rows: {totalRows}" });


            return new List<ExcelReadResult> {
                new ExcelReadResult {
                    Data = combinedTable,
                    TotalRows = totalRows,
                    ImportedRows = totalRows,
                    ErrorRows = 0
                }
            };
        }
        catch (Exception ex)
        {
            _logger.Error($"Error in ReadDynamicAsync: {ex}");

            ImportLog.Add(new FileLog { ImportFileId = _ImportFileId, LogType = "Error", LogMessage = $"Error in ReadMappedAsync: {ex}" });

            return null;
        }
    }

    private void PopulateTableRows(
        IXLWorksheet worksheet,
        int headerRowIndex,
        Dictionary<string, int> headerMap,
        ExcelSheetMapping mapping,
        DataTable table,
        string sheetName,
        ref int totalRows,
        ref int importedRows,
        ref int errorRows)
    {
        for (int rowNum = headerRowIndex + 1; rowNum <= worksheet.LastRowUsed().RowNumber(); rowNum++)
        {
            totalRows++;
            var row = worksheet.Row(rowNum);
            var newRow = table.NewRow();
            bool hasError = false;

            foreach (var colMap in mapping.Columns)
            {
                if (!headerMap.TryGetValue(colMap.ExcelColumn, out int colIndex)) continue;

                try
                {
                    var cellValue = row.Cell(colIndex).GetValue<string>();
                    newRow[colMap.SqlColumn] = GetCellValue(cellValue, colMap.DataType);
                }
                catch (Exception ex)
                {
                    hasError = true;
                    _logger.Warn($"Row {rowNum} in sheet '{sheetName}' has error in column '{colMap.ExcelColumn}': {ex.Message}");

                    ImportLog.Add(new FileLog { ImportFileId = _ImportFileId, LogType = "Error", LogMessage = $"Row {rowNum} in sheet '{sheetName}' has error in column '{colMap.ExcelColumn}': {ex.Message}" });

                }
            }

            if (mapping.UseSheetName)
                newRow["SheetName"] = sheetName;

            if (hasError)
            {
                errorRows++;
                continue;
            }

            table.Rows.Add(newRow);
            importedRows++;
        }
    }

    private List<IXLWorksheet> GetWorksheets(XLWorkbook workbook, ExcelSheetMapping mapping)
    {
        if (mapping == null || !mapping.UseSheetName)
            return workbook.Worksheets.ToList();

        if (string.IsNullOrWhiteSpace(mapping.SheetName))
            throw new Exception("UseSheetName is true, but SheetName is empty or missing.");

        var names = mapping.SheetName
            .Split(',', StringSplitOptions.RemoveEmptyEntries | StringSplitOptions.TrimEntries)
            .ToHashSet(StringComparer.OrdinalIgnoreCase);

        return workbook.Worksheets.Where(ws => names.Contains(ws.Name)).ToList();
    }

    private DataTable CreateMappedTableSchema(ExcelSheetMapping mapping)
    {
        var table = new DataTable();
        foreach (var col in mapping.Columns)
        {
            if (!table.Columns.Contains(col.SqlColumn))
                table.Columns.Add(col.SqlColumn);
        }
        if (mapping.UseSheetName)
            table.Columns.Add("SheetName");

        return table;
    }

    private Dictionary<string, int> BuildHeaderMap(IXLRow headerRow)
    {
        var headerMap = new Dictionary<string, int>(StringComparer.OrdinalIgnoreCase);
        var duplicates = new HashSet<string>();

        for (int col = 1; col <= headerRow.Worksheet.LastColumnUsed().ColumnNumber(); col++)
        {
            var header = headerRow.Cell(col).GetString().Trim();
            if (string.IsNullOrWhiteSpace(header)) continue;

            if (!headerMap.TryAdd(header, col))
                duplicates.Add(header);
        }

        if (duplicates.Any())
        {
            var msg = $"Duplicate header(s) found: {string.Join(", ", duplicates)}";
            ImportLog.Add(new FileLog { ImportFileId = _ImportFileId, LogType = "Error", LogMessage = msg });
            _logger.Error(msg);
            throw new Exception(msg);
        }

        return headerMap;
    }

    private void ValidateHeaders(Dictionary<string, int> headerMap, ExcelSheetMapping mapping)
    {
        var missing = mapping.Columns
            .Where(c => c.Required && !headerMap.ContainsKey(c.ExcelColumn))
            .Select(c => c.ExcelColumn)
            .ToList();

        if (missing.Any())
        {
            ImportLog.Add(new FileLog { ImportFileId = _ImportFileId, LogType = "Error", LogMessage = $"Missing required column(s): {string.Join(", ", missing)}" });

            throw new Exception($"Missing required column(s): {string.Join(", ", missing)}");
        }
    }

    private int FindHeaderRow(IXLWorksheet worksheet, ExcelSheetMapping mapping, int scanLimit = 20)
    {
        for (int i = 1; i <= scanLimit; i++)
        {
            var row = worksheet.Row(i);
            var cellValues = row.Cells().Select(c => c.GetString().Trim())
                                        .Where(v => !string.IsNullOrWhiteSpace(v))
                                        .ToList();

            int matches = mapping.Columns
                .Count(col => cellValues.Contains(col.ExcelColumn, StringComparer.OrdinalIgnoreCase));

            if (matches >= mapping.Columns.Count * 0.7)
                return i;
        }
        ImportLog.Add(new FileLog { ImportFileId = _ImportFileId, LogType = "Error", LogMessage = $"Header row not found in the top {scanLimit} rows." });

        throw new Exception($"Header row not found in the top {scanLimit} rows.");
    }

    public static object GetCellValue(string? cellValue, string expectedType, int rowNum = -1, string columnName = null)
    {
        try
        {
            if (string.IsNullOrWhiteSpace(cellValue))
                return DBNull.Value;

            string value = cellValue.Trim();
            string type = expectedType.ToLowerInvariant();

            return type switch
            {
                "string" => value,

                "int" or "integer" =>
                    int.TryParse(value, NumberStyles.Any, CultureInfo.InvariantCulture, out var intResult)
                        ? intResult : DBNull.Value,

                "double" or "decimal" =>
                    double.TryParse(value, NumberStyles.Any, CultureInfo.InvariantCulture, out var doubleResult)
                        ? doubleResult : DBNull.Value,

                "datetime" or "date" =>
                    TryParseFlexibleDate(value, out var dateResult, rowNum, columnName)
                        ? dateResult : DBNull.Value,

                "bool" or "boolean" =>
                    bool.TryParse(value, out var boolResult)
                        ? boolResult : DBNull.Value,

                _ => value // return raw string for unknown type
            };
        }
        catch (Exception ex)
        {
            ImportLog.Add(new FileLog { ImportFileId = _ImportFileId, LogType = "Error", LogMessage = $"Error on importing row {rowNum}, column '{columnName}': {ex}" });
            throw;
        }
    }

    private static readonly string[] SupportedFormats = new[]
    {
    "MM/dd/yyyy", "MM/dd/yy",
    "MM/dd/yyyy h:mm tt", "MM/dd/yyyy h:mm:ss tt",
    "MM/dd/yyyy HH:mm:ss",
    "yyyy-MM-dd", "yyyy-MM-ddTHH:mm:ss", "yyyy-MM-ddTHH:mm:ssZ",
    "yyyy-MM-ddTHH:mm:ss.fff", "yyyy-MM-ddTHH:mm:ss.fffZ"
};

    public static bool TryParseFlexibleDate(string input, out DateTime date, int rowNum = -1, string columnName = null)
    {
        input = input.Trim();

        var usCulture = new CultureInfo("en-US"); // MM/dd/yyyy
        var ukCulture = new CultureInfo("en-GB"); // dd/MM/yyyy

        if (double.TryParse(input, NumberStyles.Any, CultureInfo.InvariantCulture, out var serialValue)
            && serialValue > 0 && serialValue < 60000)
        {
            date = DateTime.FromOADate(serialValue);
            return true;
        }

        if (DateTime.TryParseExact(input, SupportedFormats, usCulture, DateTimeStyles.AssumeUniversal | DateTimeStyles.AdjustToUniversal, out date)
            || DateTime.TryParse(input, usCulture, DateTimeStyles.AssumeUniversal | DateTimeStyles.AdjustToUniversal, out date))
        {
            return true;
        }

        if (DateTimeOffset.TryParse(input, usCulture, DateTimeStyles.AssumeUniversal, out var dtoUs))
        {
            date = dtoUs.UtcDateTime;
            return true;
        }

        var ukFormats = new[]
        {
        "dd/MM/yyyy", "d/M/yyyy", "dd/MM/yy", "d/M/yy",
        "dd/MM/yyyy h:mm tt", "dd/MM/yyyy h:mm:ss tt",
        "dd/MM/yyyy HH:mm:ss"
    };

        if (DateTime.TryParseExact(input, ukFormats, ukCulture, DateTimeStyles.AssumeUniversal | DateTimeStyles.AdjustToUniversal, out date)
            || DateTime.TryParse(input, ukCulture, DateTimeStyles.AssumeUniversal | DateTimeStyles.AdjustToUniversal, out date))
        {
            return true;
        }

        if (DateTimeOffset.TryParse(input, ukCulture, DateTimeStyles.AssumeUniversal, out var dtoUk))
        {
            date = dtoUk.UtcDateTime;
            return true;
        }

        date = default;
        if (rowNum != -1 && !string.IsNullOrWhiteSpace(columnName))
        {
            ImportLog.Add(new FileLog
            {
                ImportFileId = _ImportFileId,
                LogType = "Error",
                LogMessage = $"Date conversion failed at Row {rowNum}, Column '{columnName}' for value '{input}'"
            });
        }

        return false;
    }

}
