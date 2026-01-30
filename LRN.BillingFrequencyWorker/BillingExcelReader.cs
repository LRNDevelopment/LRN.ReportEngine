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

	public static List<BillingLineRow> ReadLineLevelRows(string filePath, string? sheetNamesCsv, int headerRow)
	{
		using var wb = new XLWorkbook(filePath);

		// ✅ pick the first sheet that exists from the comma-separated list
		var ws = ResolveWorksheet(wb, sheetNamesCsv);

		// --- existing code continues ---
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

	private static IXLWorksheet ResolveWorksheet(XLWorkbook wb, string? sheetNamesCsv)
	{
		// If nothing provided, fall back to first sheet
		if (string.IsNullOrWhiteSpace(sheetNamesCsv))
			return wb.Worksheets.First();

		var candidates = sheetNamesCsv
			.Split(',', StringSplitOptions.RemoveEmptyEntries | StringSplitOptions.TrimEntries);

		// Case-insensitive match
		foreach (var name in candidates)
		{
			var match = wb.Worksheets.FirstOrDefault(w =>
				string.Equals(w.Name, name, StringComparison.OrdinalIgnoreCase));

			if (match != null)
				return match;
		}

		// If none matched, throw a helpful error
		var available = string.Join(", ", wb.Worksheets.Select(w => w.Name));
		throw new InvalidOperationException(
			$"None of the configured sheet names exist. Configured: [{string.Join(", ", candidates)}]. Available: [{available}].");
	}

	private static int FindCol(IXLRow headerRow, params string[] names)
	{
		int lastCol = headerRow.Worksheet.LastColumnUsed()?.ColumnNumber() ?? 0;

		for (int c = 1; c <= lastCol; c++)
		{
			var h = headerRow.Cell(c).GetString().Trim();
			foreach (var n in names)
				if (h.Equals(n, StringComparison.OrdinalIgnoreCase))
					return c;
		}
		return 0;
	}

	private static DateTime ParseExcelDate(IXLCell cell)
	{
		if (cell.DataType == XLDataType.DateTime) return cell.GetDateTime();
		if (cell.DataType == XLDataType.Number) return DateTime.FromOADate(cell.GetDouble());

		var s = cell.GetString().Trim();
		if (string.IsNullOrWhiteSpace(s))
			throw new InvalidOperationException("DOS is blank.");

		var formats = new[]
		{
			"yyyy-MM-dd","yyyy/MM/dd",
			"dd/MM/yyyy","d/M/yyyy",
			"MM/dd/yyyy","M/d/yyyy",
			"dd-MM-yyyy","d-M-yyyy",
			"MM-dd-yyyy","M-d-yyyy"
		};

		if (DateTime.TryParseExact(s, formats, CultureInfo.InvariantCulture, DateTimeStyles.None, out var dt))
			return dt;

		if (DateTime.TryParse(s, new CultureInfo("en-SG"), DateTimeStyles.None, out dt))
			return dt;

		if (DateTime.TryParse(s, CultureInfo.InvariantCulture, DateTimeStyles.None, out dt))
			return dt;

		throw new InvalidOperationException($"Invalid DOS: '{s}'");
	}


}
