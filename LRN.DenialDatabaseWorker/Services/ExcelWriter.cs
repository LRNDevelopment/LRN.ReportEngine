using ClosedXML.Excel;
using Microsoft.Extensions.Logging;

namespace DenialDatabaseProcessorWorker.Services;

public sealed class ExcelWriter
{
    private readonly ILogger<ExcelWriter> _logger;

    public ExcelWriter(ILogger<ExcelWriter> logger)
    {
        _logger = logger;
    }

    public void Write(string outputPath, string sheetName, List<string> headers, List<Dictionary<string, string>> rows)
    {
        Directory.CreateDirectory(Path.GetDirectoryName(outputPath) ?? ".");

        using var wb = new XLWorkbook();
        var ws = wb.AddWorksheet(string.IsNullOrWhiteSpace(sheetName) ? "DenialDatabase" : sheetName);

        // Header
        for (int c = 0; c < headers.Count; c++)
        {
            ws.Cell(1, c + 1).Value = headers[c];
            ws.Cell(1, c + 1).Style.Font.Bold = true;
        }

        // Body
        for (int r = 0; r < rows.Count; r++)
        {
            var row = rows[r];
            for (int c = 0; c < headers.Count; c++)
            {
                var key = headers[c];
                row.TryGetValue(key, out var val);
                ws.Cell(r + 2, c + 1).Value = val ?? "";
            }
        }

        ws.Columns().AdjustToContents();

        wb.SaveAs(outputPath);
        _logger.LogInformation("Wrote Denial Database Excel: {OutputPath}", outputPath);
    }
}
