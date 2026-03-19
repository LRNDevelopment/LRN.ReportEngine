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
    /// Reads a worksheet and auto-detects the header row.
    /// Header row detection prefers the row with the highest number of populated cells
    /// near the top of the used range, which supports files such as the new
    /// "Denial Classifier" sheet that contain a title row above the actual headers.
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

        var firstRowNo = used.FirstRow().RowNumber();
        var lastRowNo = used.LastRow().RowNumber();
        var firstColNo = used.FirstColumn().ColumnNumber();
        var lastColNo = used.LastColumn().ColumnNumber();

        var headerRowNo = DetectHeaderRow(ws, firstRowNo, lastRowNo, firstColNo, lastColNo);

        var headers = new List<string>();
        var cols = new List<(int Col, string Header)>();

        for (int c = firstColNo; c <= lastColNo; c++)
        {
            var h = ws.Cell(headerRowNo, c).GetString()?.Trim() ?? "";
            if (string.IsNullOrWhiteSpace(h))
                continue;

            var unique = h;
            int i = 2;
            while (headers.Contains(unique, StringComparer.OrdinalIgnoreCase))
                unique = $"{h}_{i++}";

            headers.Add(unique);
            cols.Add((c, unique));
        }

        var rows = new List<Dictionary<string, string>>(capacity: Math.Max(0, lastRowNo - headerRowNo));

        for (int r = headerRowNo + 1; r <= lastRowNo; r++)
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

        _logger.LogInformation(
            "Read {RowCount} rows from {Path} ({SheetName}) using header row {HeaderRowNo}",
            rows.Count, path, ws.Name, headerRowNo);

        return new(headers, rows);
    }

    /// <summary>
    /// Backward compatible helper returning only rows.
    /// </summary>
    public List<Dictionary<string, string>> Read(string path, string? sheetName = null)
        => ReadTable(path, sheetName).Rows;

    private static int DetectHeaderRow(IXLWorksheet ws, int firstRowNo, int lastRowNo, int firstColNo, int lastColNo)
    {
        var scanEndRow = Math.Min(lastRowNo, firstRowNo + 9);

        int bestRow = firstRowNo;
        int bestScore = -1;

        for (int r = firstRowNo; r <= scanEndRow; r++)
        {
            int populated = 0;

            for (int c = firstColNo; c <= lastColNo; c++)
            {
                var text = ws.Cell(r, c).GetString()?.Trim() ?? "";
                if (!string.IsNullOrWhiteSpace(text))
                    populated++;
            }

            if (populated > bestScore)
            {
                bestScore = populated;
                bestRow = r;
            }
        }

        return bestRow;
    }
}
