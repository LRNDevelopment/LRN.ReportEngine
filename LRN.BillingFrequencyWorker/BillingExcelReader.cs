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
	public static List<BillingLineRow> ReadLineLevelRows(string filePath, string? sheetName, int headerRow)
	{
		using var wb = new XLWorkbook(filePath);
		var ws = !string.IsNullOrWhiteSpace(sheetName)
			? wb.Worksheet(sheetName)
			: wb.Worksheets.First();

		var hdr = ws.Row(headerRow);

		int cChart = FindCol(hdr, "ChartNumber", "PatientId", "Patient ID");
		int cPay = FindCol(hdr, "PanelCarrier", "Payer", "Carrier", "PayerName");
		int cCpt = FindCol(hdr, "CPTCode", "CPT", "Panel");
		int cVisit = FindCol(hdr, "VisitNumber", "BillingNumber", "Billing #", "Visit #");
		int cDos = FindCol(hdr, "BeginDOS", "DateOfService", "DOS", "Date Of Service");

		if (cChart == 0 || cVisit == 0 || cDos == 0)
			throw new InvalidOperationException($"Missing required headers in {filePath}");

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
