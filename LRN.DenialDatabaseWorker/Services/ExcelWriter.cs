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

        // REMOVE from output (do not include in the Excel at all)
        var excludedHeaders = new HashSet<string>(StringComparer.OrdinalIgnoreCase)
        {
            "DenialCode",
            "Denial Code",
            "Status Action Code"
        };

        // HIDE in output (keep the column, but hide it in Excel UI)
        var hiddenHeaders = new HashSet<string>(StringComparer.OrdinalIgnoreCase)
        {
            "Resolution",
            "Payer Policy Validation Required",
            "CPT Validation Required",
            "ICD Validation Required",
            "Frequency Validation Required",
            "Gender Validation Required",
            "MUE Validation Required"
        };

        var effectiveHeaders = headers
            .Where(h => !string.IsNullOrWhiteSpace(h) && !excludedHeaders.Contains(h.Trim()))
            .ToList();

        using var wb = new XLWorkbook();
        var ws = wb.AddWorksheet(string.IsNullOrWhiteSpace(sheetName) ? "DenialDatabase" : sheetName);

        // Header row
        for (int c = 0; c < effectiveHeaders.Count; c++)
        {
            ws.Cell(1, c + 1).Value = effectiveHeaders[c];
            ws.Cell(1, c + 1).Style.Font.Bold = true;
        }

        // Body rows
        for (int r = 0; r < rows.Count; r++)
        {
            var row = rows[r];
            for (int c = 0; c < effectiveHeaders.Count; c++)
            {
                var key = effectiveHeaders[c];
                row.TryGetValue(key, out var val);
                ws.Cell(r + 2, c + 1).Value = val ?? "";
            }
        }

        // Hide selected columns (but keep them in the file)
        for (int c = 0; c < effectiveHeaders.Count; c++)
        {
            var header = effectiveHeaders[c];
            if (hiddenHeaders.Contains(header.Trim()))
            {
                ws.Column(c + 1).Hide();
            }
        }

        ws.Columns().AdjustToContents();

        wb.SaveAs(outputPath);
        _logger.LogInformation("Wrote Denial Database Excel: {OutputPath}", outputPath);
    }
}