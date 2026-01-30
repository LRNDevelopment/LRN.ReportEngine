using ClosedXML.Excel;
using System.Globalization;

public sealed class BillingLineRow
{
    public string ChartNumber { get; set; } = "";
    public string PanelCarrier { get; set; } = "";
    public string CPTCode { get; set; } = "";
    public string VisitNumber { get; set; } = "";
    public DateTime BeginDOS { get; set; }
}

public static class BillingExcelReader
{
    /// <summary>
    /// Reads line-level rows from the first worksheet that matches any name in the comma-separated candidates list.
    /// If sheetCandidatesCsv is null/empty, the first worksheet is used.
    /// </summary>
    public static List<BillingLineRow> ReadLineLevelRows(string filePath, string? sheetCandidatesCsv, int headerRow)
    {
        ValidateDownloadedXlsxOrThrow(filePath);

        using var wb = new XLWorkbook(filePath);
        var ws = ResolveWorksheet(wb, sheetCandidatesCsv);

        var hdr = ws.Row(headerRow);

		int cChart = FindCol(hdr, "ChartNumber", "PatientId", "Patient ID", "ChartNum", "Patient Ac No");
		int cPay = FindCol(hdr, "PanelCarrier", "Payer", "Carrier", "Insurance Name", "Primary Payer");
		int cCpt = FindCol(hdr, "CPTCode", "CPT", "Procedure");
		int cVisit = FindCol(hdr, "VisitNumber", "BillingNumber", "Billing #", "Visit #", "VisitNum", "UID", "Visit No");
		int cDos = FindCol(hdr, "BeginDOS", "DateOfService", "DOS", "Date Of Service", "Service From Date");

		if (cChart == 0 || cVisit == 0 || cDos == 0)
            throw new InvalidOperationException($"Missing required headers in {filePath} (Sheet: {ws.Name})");

        var lastRow = ws.LastRowUsed()?.RowNumber() ?? headerRow;
        var list = new List<BillingLineRow>();

        for (int r = headerRow + 1; r <= lastRow; r++)
        {
            var row = ws.Row(r);

            var chart = row.Cell(cChart).GetString().Trim();
            var visit = row.Cell(cVisit).GetString().Trim();
            if (string.IsNullOrWhiteSpace(chart) || string.IsNullOrWhiteSpace(visit))
                continue;

            var payer = cPay > 0 ? row.Cell(cPay).GetString().Trim() : "";
            var cpt = cCpt > 0 ? row.Cell(cCpt).GetString().Trim() : "";
            var dos = ParseExcelDate(row.Cell(cDos)).Date;

            list.Add(new BillingLineRow
            {
                ChartNumber = chart,
                VisitNumber = visit,
                PanelCarrier = payer,
                CPTCode = cpt,
                BeginDOS = dos
            });
        }

        return list;
    }

    /// <summary>
    /// Export exactly one worksheet from source workbook into a new workbook file.
    /// The worksheet is selected by matching any sheet name in candidatesCsv.
    /// </summary>
    public static string ExportSingleSheetToFile(
        string sourceXlsxPath,
        string? sheetCandidatesCsv,
        string destXlsxPath)
    {
        ValidateDownloadedXlsxOrThrow(sourceXlsxPath);

        Directory.CreateDirectory(Path.GetDirectoryName(destXlsxPath)!);

        using var src = new XLWorkbook(sourceXlsxPath);
        var ws = ResolveWorksheet(src, sheetCandidatesCsv);

        // Create new workbook containing only that sheet
        using var dest = new XLWorkbook();
        ws.CopyTo(dest, ws.Name);

        // Overwrite if exists
        if (File.Exists(destXlsxPath))
            File.Delete(destXlsxPath);

        dest.SaveAs(destXlsxPath);

        return ws.Name;
    }

    /// <summary>
    /// Returns the first worksheet that exists from comma-separated candidates. If empty, first worksheet.
    /// Throws if candidates are provided and none match.
    /// </summary>
    public static IXLWorksheet ResolveWorksheet(XLWorkbook wb, string? sheetCandidatesCsv)
    {
        if (string.IsNullOrWhiteSpace(sheetCandidatesCsv))
            return wb.Worksheets.First();

        var candidates = sheetCandidatesCsv
            .Split(',', StringSplitOptions.RemoveEmptyEntries | StringSplitOptions.TrimEntries);

        foreach (var name in candidates)
        {
            var match = wb.Worksheets.FirstOrDefault(w =>
                string.Equals(w.Name, name, StringComparison.OrdinalIgnoreCase));

            if (match != null)
                return match;
        }

        var available = string.Join(", ", wb.Worksheets.Select(w => w.Name));
        throw new InvalidOperationException(
            $"None of the configured sheet names exist. Configured: [{string.Join(", ", candidates)}]. Available: [{available}].");
    }

    /// <summary>
    /// Quick validation to catch truncated downloads / HTML error pages saved as .xlsx.
    /// XLSX is a ZIP; first two bytes must be 'PK'.
    /// </summary>
    public static void ValidateDownloadedXlsxOrThrow(string path)
    {
        var fi = new FileInfo(path);
        if (!fi.Exists)
            throw new FileNotFoundException("Excel file not found.", path);

        if (fi.Length < 1024)
            throw new InvalidDataException($"Excel file looks too small ({fi.Length} bytes): {path}");

        using var fs = File.OpenRead(path);
        int b1 = fs.ReadByte();
        int b2 = fs.ReadByte();
        if (b1 != 'P' || b2 != 'K')
            throw new InvalidDataException($"File is not a valid XLSX (zip signature missing): {path}");
    }

    private static int FindCol(IXLRow headerRow, params string[] names)
    {
        foreach (var cell in headerRow.CellsUsed())
        {
            var txt = cell.GetString().Trim();
            if (names.Any(n => string.Equals(txt, n, StringComparison.OrdinalIgnoreCase)))
                return cell.Address.ColumnNumber;
        }
        return 0;
    }

    private static DateTime ParseExcelDate(IXLCell cell)
    {
        // Date cell
        if (cell.DataType == XLDataType.DateTime)
            return cell.GetDateTime();

        // Numeric serial
        if (cell.DataType == XLDataType.Number)
            return DateTime.FromOADate(cell.GetDouble());

        // String
        var s = cell.GetString().Trim();
        if (DateTime.TryParse(s, CultureInfo.InvariantCulture, DateTimeStyles.AssumeLocal, out var dt))
            return dt;

        // try dd/MM vs MM/dd
        string[] fmts =
        {
            "MM/dd/yyyy","M/d/yyyy","dd/MM/yyyy","d/M/yyyy",
            "MM-dd-yyyy","M-d-yyyy","dd-MM-yyyy","d-M-yyyy",
            "yyyy-MM-dd","yyyy/M/d"
        };

        if (DateTime.TryParseExact(s, fmts, CultureInfo.InvariantCulture, DateTimeStyles.AssumeLocal, out dt))
            return dt;

        throw new FormatException($"Could not parse date '{s}'.");
    }
}
