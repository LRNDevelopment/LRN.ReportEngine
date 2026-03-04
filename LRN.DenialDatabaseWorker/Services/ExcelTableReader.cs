using ClosedXML.Excel;
using Microsoft.Extensions.Logging;

namespace DenialDatabaseProcessorWorker.Services;

public sealed class ExcelTableReader
{
    private readonly ILogger<ExcelTableReader> _logger;

    public ExcelTableReader(ILogger<ExcelTableReader> logger)
    {
        _logger = logger;
    }

    public sealed record ExcelTable(List<string> Headers, List<Dictionary<string, string>> Rows);

    /// <summary>
    /// Reads the first worksheet by default, treating the first row as headers.
    /// Returns header order + one dictionary per row: Header -> string value.
    /// </summary>
    public ExcelTable ReadTable(string path, string? sheetName = null)
    {
        if (string.IsNullOrWhiteSpace(path))
            throw new ArgumentException("Excel path is required.", nameof(path));

        if (!File.Exists(path))
            throw new FileNotFoundException("Excel file not found.", path);

        using var wb = new XLWorkbook(path);
        var ws = !string.IsNullOrWhiteSpace(sheetName) ? wb.Worksheet(sheetName) : wb.Worksheets.First();

        var used = ws.RangeUsed();
        if (used == null)
            return new(new(), new());

        var firstRow = used.FirstRow();
        var lastRow = used.LastRow();
        var firstCol = used.FirstColumn().ColumnNumber();
        var lastCol = used.LastColumn().ColumnNumber();

        // headers in column order
        var headers = new List<string>();
        var cols = new List<(int Col, string Header)>();

        for (int c = firstCol; c <= lastCol; c++)
        {
            var h = ws.Cell(firstRow.RowNumber(), c).GetString()?.Trim() ?? "";
            if (string.IsNullOrWhiteSpace(h))
                continue;

            // Ensure uniqueness (Excel files sometimes have duplicates)
            var unique = h;
            int i = 2;
            while (headers.Contains(unique, StringComparer.OrdinalIgnoreCase))
                unique = $"{h}_{i++}";

            headers.Add(unique);
            cols.Add((c, unique));
        }

        var rows = new List<Dictionary<string, string>>(capacity: Math.Max(0, lastRow.RowNumber() - firstRow.RowNumber()));

        for (int r = firstRow.RowNumber() + 1; r <= lastRow.RowNumber(); r++)
        {
            var dict = new Dictionary<string, string>(StringComparer.OrdinalIgnoreCase);
            bool any = false;

            foreach (var (col, header) in cols)
            {
                var cell = ws.Cell(r, col);
                var val = cell.GetString()?.Trim() ?? "";
                if (!string.IsNullOrEmpty(val)) any = true;
                dict[header] = val;
            }

            if (!any)
                continue;

            rows.Add(dict);
        }

        _logger.LogInformation("Read {RowCount} rows from {Path} ({SheetName})", rows.Count, path, ws.Name);
        return new(headers, rows);
    }

    /// <summary>
    /// Backward compatible helper returning only rows.
    /// </summary>
    public List<Dictionary<string, string>> Read(string path, string? sheetName = null)
        => ReadTable(path, sheetName).Rows;
}
