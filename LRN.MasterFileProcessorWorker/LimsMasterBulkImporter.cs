using DocumentFormat.OpenXml;
using DocumentFormat.OpenXml.Packaging;
using DocumentFormat.OpenXml.Spreadsheet;
using Microsoft.Data.SqlClient;
using System.Data;
using System.Globalization;
using System.Text.Json;
using System.Text.RegularExpressions;

public static class LimsMasterBulkImporter
{
    public sealed record ImportResult(string TableName, int InsertedRows, int SkippedRows);

    private sealed class LimsSchema
    {
        public string SchemaName { get; set; } = "LIMSMaster";
        public int HeaderRow { get; set; } = 1;
        public string? SheetName { get; set; }
        public List<LimsColumn> Columns { get; set; } = new();
    }

    private sealed class LimsColumn
    {
        public string? ExcelColName { get; set; }
        public string? ExcelCoName { get; set; } // supports typo in current schema JSON
        public bool Required { get; set; }
        public string DataType { get; set; } = "string";
        public string SQLColName { get; set; } = "";
        public string SourceName => !string.IsNullOrWhiteSpace(ExcelColName) ? ExcelColName! : (ExcelCoName ?? "");
    }

    public static async Task<ImportResult> ImportAsync(
        string limsExcelPath,
        string schemaJsonPath,
        string connectionString,
        CancellationToken ct)
    {
        if (!File.Exists(limsExcelPath))
            throw new FileNotFoundException("LIMS Excel file not found.", limsExcelPath);

        if (!File.Exists(schemaJsonPath))
            throw new FileNotFoundException("LIMS schema JSON file not found.", schemaJsonPath);

        var schema = JsonSerializer.Deserialize<LimsSchema>(
            File.ReadAllText(schemaJsonPath),
            new JsonSerializerOptions { PropertyNameCaseInsensitive = true })
            ?? throw new InvalidOperationException($"Invalid LIMS schema JSON: {schemaJsonPath}");

        if (schema.Columns.Count == 0)
            throw new InvalidOperationException($"LIMS schema has no columns: {schemaJsonPath}");

        var tableName = NormalizeDestinationTable(schema.SchemaName);

        await using var conn = new SqlConnection(connectionString);
        await conn.OpenAsync(ct);

        return await StreamExcelAndBulkCopyAsync(
            limsExcelPath,
            schema,
            tableName,
            conn,
            ct);
    }

    private static DataTable BuildDataTable(LimsSchema schema)
    {
        var table = new DataTable(schema.SchemaName);

        foreach (var col in schema.Columns)
        {
            if (string.IsNullOrWhiteSpace(col.SQLColName))
                throw new InvalidOperationException("LIMS schema column missing SQLColName.");

            table.Columns.Add(col.SQLColName.Trim(), GetNetType(col.DataType));
        }

        return table;
    }

    // Do not use ClosedXML here. Some LIMS workbooks throw:
    // XLWorkbook.LoadSpreadsheetDocument -> NotImplementedException.
    // This streams OpenXML rows and bulk copies in batches, so 350k+ rows are not kept in memory.
    private static async Task<ImportResult> StreamExcelAndBulkCopyAsync(
        string path,
        LimsSchema schema,
        string tableName,
        SqlConnection conn,
        CancellationToken ct)
    {
        const int batchSize = 25000;

        using var document = SpreadsheetDocument.Open(path, false);
        var workbookPart = document.WorkbookPart
            ?? throw new InvalidOperationException($"Invalid LIMS workbook: {path}");

        var sheets = workbookPart.Workbook.Sheets?.Elements<Sheet>().ToList() ?? new List<Sheet>();
        if (sheets.Count == 0)
            throw new InvalidOperationException($"LIMS workbook has no worksheet: {path}");

        var sharedStrings = workbookPart.SharedStringTablePart?.SharedStringTable;
        var selected = FindLimsWorksheet(workbookPart, sheets, schema, sharedStrings, path);

        foreach (var col in schema.Columns)
        {
            if (col.Required && !selected.HeaderLookup.ContainsKey(NormKey(col.SourceName)))
                throw new InvalidOperationException($"LIMS sheet '{selected.Sheet.Name}' missing required column: {col.SourceName}");
        }

        var worksheetPart = (WorksheetPart)workbookPart.GetPartById(selected.Sheet.Id!);
        var table = BuildDataTable(schema);

        var insertedRows = 0;
        var skippedRows = 0;

        using var reader = OpenXmlReader.Create(worksheetPart);

        while (reader.Read())
        {
            if (reader.ElementType != typeof(Row) || !reader.IsStartElement)
                continue;

            ct.ThrowIfCancellationRequested();

            var row = (Row)reader.LoadCurrentElement();
            var rowNumber = (int)(row.RowIndex?.Value ?? 0);

            if (rowNumber <= selected.HeaderRowNumber)
                continue;

            var cellsByIndex = row.Elements<Cell>()
                .Where(c => c.CellReference != null)
                .ToDictionary(c => GetColumnIndex(c.CellReference!.Value!), c => c);

            var dataRow = table.NewRow();
            var hasAnyValue = false;
            var missingRequiredValue = false;

            foreach (var col in schema.Columns)
            {
                object? value = null;

                if (selected.HeaderLookup.TryGetValue(NormKey(col.SourceName), out var excelColumnIndex) &&
                    cellsByIndex.TryGetValue(excelColumnIndex, out var cell))
                {
                    value = ConvertCellValue(cell, sharedStrings, col.DataType);

                    if (value != null && value != DBNull.Value && !string.IsNullOrWhiteSpace(value.ToString()))
                        hasAnyValue = true;
                }

                if (col.Required && (value == null || value == DBNull.Value || string.IsNullOrWhiteSpace(value.ToString())))
                    missingRequiredValue = true;

                dataRow[col.SQLColName.Trim()] = value ?? DBNull.Value;
            }

            if (!hasAnyValue)
                continue;

            if (missingRequiredValue)
            {
                skippedRows++;
                continue;
            }

            table.Rows.Add(dataRow);

            if (table.Rows.Count >= batchSize)
            {
                var currentBatchRows = table.Rows.Count;
                await BulkCopyAsync(conn, tableName, table, ct);
                insertedRows += currentBatchRows;
                table.Clear();
            }
        }

        if (table.Rows.Count > 0)
        {
            var currentBatchRows = table.Rows.Count;
            await BulkCopyAsync(conn, tableName, table, ct);
            insertedRows += currentBatchRows;
            table.Clear();
        }

        return new ImportResult(tableName, insertedRows, skippedRows);
    }

    private static async Task BulkCopyAsync(
        SqlConnection conn,
        string tableName,
        DataTable table,
        CancellationToken ct)
    {
        using var bulkCopy = new SqlBulkCopy(conn, SqlBulkCopyOptions.TableLock, null)
        {
            DestinationTableName = tableName,
            BatchSize = table.Rows.Count,
            BulkCopyTimeout = 0,
            EnableStreaming = true
        };

        foreach (DataColumn col in table.Columns)
            bulkCopy.ColumnMappings.Add(col.ColumnName, col.ColumnName);

        await bulkCopy.WriteToServerAsync(table, ct);
    }

    private sealed record LimsWorksheetMatch(
        Sheet Sheet,
        int HeaderRowNumber,
        Dictionary<string, int> HeaderLookup);

    private static LimsWorksheetMatch FindLimsWorksheet(
        WorkbookPart workbookPart,
        List<Sheet> sheets,
        LimsSchema schema,
        SharedStringTable? sharedStrings,
        string path)
    {
        var configuredHeaderRow = schema.HeaderRow <= 0 ? 1 : schema.HeaderRow;

        // 1) Prefer exact configured sheet name, for example "Masterfile".
        if (!string.IsNullOrWhiteSpace(schema.SheetName))
        {
            var configuredSheet = sheets.FirstOrDefault(s =>
                string.Equals(s.Name?.Value?.Trim(), schema.SheetName.Trim(), StringComparison.OrdinalIgnoreCase));

            if (configuredSheet != null)
            {
                var match = TryBuildWorksheetMatch(workbookPart, configuredSheet, configuredHeaderRow, sharedStrings);
                if (match != null && HasEnoughSchemaHeaders(match.HeaderLookup, schema, requireRequiredColumns: true))
                    return match;
            }
        }

        // 2) Common LIMS sheet name fallback.
        var masterfileSheet = sheets.FirstOrDefault(s =>
            string.Equals(s.Name?.Value?.Trim(), "Masterfile", StringComparison.OrdinalIgnoreCase));

        if (masterfileSheet != null)
        {
            var match = TryBuildWorksheetMatch(workbookPart, masterfileSheet, configuredHeaderRow, sharedStrings);
            if (match != null && HasEnoughSchemaHeaders(match.HeaderLookup, schema, requireRequiredColumns: true))
                return match;
        }

        // 3) Scan all sheets and identify the valid sheet by schema header columns.
        // HeaderRow from JSON is still preferred, but this also checks the first 20 rows
        // because some LIMS files have a blank/title row before the real header.
        LimsWorksheetMatch? bestMatch = null;
        var bestScore = -1;

        foreach (var candidateSheet in sheets)
        {
            var worksheetPart = (WorksheetPart)workbookPart.GetPartById(candidateSheet.Id!);

            foreach (var headerRow in GetHeaderRowsToTry(worksheetPart, configuredHeaderRow))
            {
                var headerRowNo = (int)(headerRow.RowIndex?.Value ?? 0);
                if (headerRowNo <= 0) continue;

                var lookup = BuildHeaderLookup(headerRow, sharedStrings);
                var score = CountSchemaHeaderMatches(lookup, schema);

                if (score > bestScore)
                {
                    bestScore = score;
                    bestMatch = new LimsWorksheetMatch(candidateSheet, headerRowNo, lookup);
                }

                if (HasEnoughSchemaHeaders(lookup, schema, requireRequiredColumns: true))
                    return new LimsWorksheetMatch(candidateSheet, headerRowNo, lookup);
            }
        }

        if (bestMatch != null && HasEnoughSchemaHeaders(bestMatch.HeaderLookup, schema, requireRequiredColumns: false))
            return bestMatch;

        var expectedHeaders = string.Join(", ", schema.Columns.Select(c => c.SourceName).Where(x => !string.IsNullOrWhiteSpace(x)));
        throw new InvalidOperationException($"No valid LIMS worksheet found in '{path}'. Expected headers: {expectedHeaders}");
    }

    private static LimsWorksheetMatch? TryBuildWorksheetMatch(
        WorkbookPart workbookPart,
        Sheet sheet,
        int headerRowNumber,
        SharedStringTable? sharedStrings)
    {
        var worksheetPart = (WorksheetPart)workbookPart.GetPartById(sheet.Id!);
        var headerRow = FindRowByNumber(worksheetPart, headerRowNumber);
        if (headerRow == null) return null;

        var headerLookup = BuildHeaderLookup(headerRow, sharedStrings);
        return new LimsWorksheetMatch(sheet, headerRowNumber, headerLookup);
    }

    private static Row? FindRowByNumber(WorksheetPart worksheetPart, int rowNumber)
    {
        return worksheetPart.Worksheet
            .Elements<SheetData>()
            .FirstOrDefault()?
            .Elements<Row>()
            .FirstOrDefault(r => (int)(r.RowIndex?.Value ?? 0) == rowNumber);
    }

    private static IEnumerable<Row> GetHeaderRowsToTry(WorksheetPart worksheetPart, int configuredHeaderRow)
    {
        var emitted = new HashSet<int>();

        var configuredRow = FindRowByNumber(worksheetPart, configuredHeaderRow);
        if (configuredRow != null && emitted.Add(configuredHeaderRow))
            yield return configuredRow;

        var sheetData = worksheetPart.Worksheet.Elements<SheetData>().FirstOrDefault();
        if (sheetData == null)
            yield break;

        foreach (var row in sheetData.Elements<Row>().Take(20))
        {
            var rowNo = (int)(row.RowIndex?.Value ?? 0);
            if (rowNo > 0 && emitted.Add(rowNo))
                yield return row;
        }
    }

    private static bool HasEnoughSchemaHeaders(
        Dictionary<string, int> headerLookup,
        LimsSchema schema,
        bool requireRequiredColumns)
    {
        if (headerLookup.Count == 0) return false;

        var requiredColumns = schema.Columns.Where(c => c.Required).ToList();
        if (requireRequiredColumns && requiredColumns.Any(c => !headerLookup.ContainsKey(NormKey(c.SourceName))))
            return false;

        var matched = CountSchemaHeaderMatches(headerLookup, schema);
        var expected = schema.Columns.Count(c => !string.IsNullOrWhiteSpace(c.SourceName));

        // Accept when all required columns exist and at least 2 schema columns match,
        // or when 50% of configured schema headers match.
        return matched >= Math.Min(2, expected) || matched >= Math.Ceiling(expected * 0.50m);
    }

    private static int CountSchemaHeaderMatches(Dictionary<string, int> headerLookup, LimsSchema schema)
    {
        return schema.Columns.Count(c =>
            !string.IsNullOrWhiteSpace(c.SourceName) &&
            headerLookup.ContainsKey(NormKey(c.SourceName)));
    }

    private static Dictionary<string, int> BuildHeaderLookup(Row headerRow, SharedStringTable? sharedStrings)
    {
        var lookup = new Dictionary<string, int>(StringComparer.OrdinalIgnoreCase);

        foreach (var cell in headerRow.Elements<Cell>())
        {
            if (cell.CellReference == null) continue;

            var header = ReadCellText(cell, sharedStrings).Trim();
            var key = NormKey(header);
            var colIndex = GetColumnIndex(cell.CellReference.Value!);

            if (!string.IsNullOrWhiteSpace(key) && !lookup.ContainsKey(key))
                lookup[key] = colIndex;
        }

        return lookup;
    }

    private static object? ConvertCellValue(Cell cell, SharedStringTable? sharedStrings, string dataType)
    {
        var raw = ReadCellText(cell, sharedStrings).Trim();
        if (string.IsNullOrWhiteSpace(raw))
            return null;

        if (IsDateType(dataType))
        {
            // Excel often stores dates as OA serial numbers.
            if (double.TryParse(raw, NumberStyles.Any, CultureInfo.InvariantCulture, out var oaNumber))
            {
                try { return DateTime.FromOADate(oaNumber).Date; }
                catch { return null; }
            }

            if (DateTime.TryParse(raw, CultureInfo.InvariantCulture, DateTimeStyles.None, out var parsed) ||
                DateTime.TryParse(raw, CultureInfo.CurrentCulture, DateTimeStyles.None, out parsed))
                return parsed.Date;

            return null;
        }

        return raw;
    }

    private static string ReadCellText(Cell cell, SharedStringTable? sharedStrings)
    {
        if (cell.DataType?.Value == CellValues.SharedString)
        {
            var rawIndex = cell.CellValue?.Text;
            if (int.TryParse(rawIndex, out var sharedStringIndex) && sharedStrings != null)
                return sharedStrings.ElementAt(sharedStringIndex).InnerText ?? string.Empty;

            return string.Empty;
        }

        if (cell.DataType?.Value == CellValues.InlineString)
            return cell.InlineString?.Text?.Text ?? cell.InnerText ?? string.Empty;

        return cell.CellValue?.Text ?? cell.InnerText ?? string.Empty;
    }

    private static int GetColumnIndex(string cellReference)
    {
        var letters = Regex.Match(cellReference, "^[A-Za-z]+").Value.ToUpperInvariant();
        var sum = 0;

        foreach (var ch in letters)
            sum = (sum * 26) + (ch - 'A' + 1);

        return sum;
    }

    private static Type GetNetType(string dataType)
    {
        if (IsDateType(dataType)) return typeof(DateTime);
        return typeof(string);
    }

    private static bool IsDateType(string dataType) =>
        string.Equals(dataType, "date", StringComparison.OrdinalIgnoreCase) ||
        string.Equals(dataType, "datetime", StringComparison.OrdinalIgnoreCase);

    private static string NormKey(string? value)
    {
        if (string.IsNullOrWhiteSpace(value)) return string.Empty;
        return Regex.Replace(value.Trim(), @"[^A-Za-z0-9]", "").ToLowerInvariant();
    }

    private static string NormalizeDestinationTable(string? schemaName)
    {
        var name = string.IsNullOrWhiteSpace(schemaName) ? "LIMSMaster" : schemaName.Trim();
        if (name.Contains('.', StringComparison.Ordinal))
            return name;

        return $"dbo.{name}";
    }
}
