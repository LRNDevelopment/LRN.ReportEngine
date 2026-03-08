using ClosedXML.Excel;
using Microsoft.VisualBasic.FileIO;
using System.Globalization;
using System.Text.RegularExpressions;

public static class ModeMedianPaymentReportWriter
{
	public static void Generate(string lineLevelStandardCsvPath, string outputWorkbookPath)
	{
		if (string.IsNullOrWhiteSpace(lineLevelStandardCsvPath))
			throw new ArgumentException("LineLevel standard CSV path is required.", nameof(lineLevelStandardCsvPath));

		if (!File.Exists(lineLevelStandardCsvPath))
			throw new FileNotFoundException("LineLevel standard CSV not found.", lineLevelStandardCsvPath);

		Directory.CreateDirectory(Path.GetDirectoryName(outputWorkbookPath)!);

		var rows = ReadRows(lineLevelStandardCsvPath);
		var reportRows = BuildReportRows(rows)
			.OrderBy(x => x.PayerName, StringComparer.OrdinalIgnoreCase)
			.ThenBy(x => x.Panel, StringComparer.OrdinalIgnoreCase)
			.ThenBy(x => x.CPTCode, StringComparer.OrdinalIgnoreCase)
			.ThenBy(x => x.AllowedAmount ?? decimal.MinValue)
			.ThenBy(x => x.InsurancePaymentAmount ?? decimal.MinValue)
			.ToList();

		using var workbook = new XLWorkbook();
		WriteMedianSheet(workbook, reportRows);
		WriteModeSheet(workbook, reportRows);
		workbook.SaveAs(outputWorkbookPath);
	}

	private static List<PaymentRow> ReadRows(string csvPath)
	{
		using var parser = new TextFieldParser(csvPath);
		parser.SetDelimiters(",");
		parser.HasFieldsEnclosedInQuotes = true;
		parser.TrimWhiteSpace = false;

		var header = parser.ReadFields() ?? Array.Empty<string>();
		if (header.Length == 0)
			return new List<PaymentRow>();

		int payerIdx = FindHeaderIndex(header, "PayerName");
		int panelIdx = FindHeaderIndex(header, "Panel", "Panelname", "PanelName", "Panel Name", "Panel Group");
		int cptIdx = FindHeaderIndex(header, "CPTCode", "CPT Code");
		int allowedIdx = FindHeaderIndex(header, "AllowedAmount", "Allowed Amount");
		int insuranceIdx = FindHeaderIndex(header, "InsurancePayment", "InsurancePaymentAmount", "Insurance Payment", "Insurance Payment Amount");

		if (payerIdx < 0 || panelIdx < 0 || cptIdx < 0 || allowedIdx < 0 || insuranceIdx < 0)
		{
			throw new InvalidOperationException(
				$"Required columns not found in LineLevel standard CSV. " +
				$"PayerName={payerIdx}, Panel={panelIdx}, CPTCode={cptIdx}, AllowedAmount={allowedIdx}, InsurancePayment={insuranceIdx}.");
		}

		var rows = new List<PaymentRow>();

		while (!parser.EndOfData)
		{
			var fields = parser.ReadFields();
			if (fields == null || fields.All(string.IsNullOrWhiteSpace))
				continue;

			var payerName = ReadField(fields, payerIdx).Trim();
			var panel = ReadField(fields, panelIdx).Trim();
			var cptCode = NormalizeCptCode(ReadField(fields, cptIdx));
			var allowedAmount = ParseNullableDecimal(ReadField(fields, allowedIdx));
			var insurancePaymentAmount = ParseNullableDecimal(ReadField(fields, insuranceIdx));

			rows.Add(new PaymentRow(
				payerName,
				panel,
				cptCode,
				allowedAmount,
				insurancePaymentAmount));
		}

		return rows;
	}

	private static IEnumerable<PaymentReportRow> BuildReportRows(IEnumerable<PaymentRow> rows)
	{
		var distinctRows = rows
			.Where(r => (!string.IsNullOrWhiteSpace(r.PayerName)
					  || !string.IsNullOrWhiteSpace(r.Panel)
					  || !string.IsNullOrWhiteSpace(r.CPTCode))
					 && r.InsurancePaymentAmount.HasValue
					 && r.InsurancePaymentAmount.Value > 0)
			.GroupBy(BuildDistinctRowKey)
			.Select(g => g.First())
			.ToList();

		return distinctRows
			.GroupBy(r => BuildGroupKey(r))
			.SelectMany(g =>
			{
				var groupRows = g.ToList();
				var paymentValues = groupRows
					.Where(x => x.InsurancePaymentAmount.HasValue)
					.Select(x => x.InsurancePaymentAmount!.Value)
					.ToList();

				var median = CalculateMedian(paymentValues);
				var mode = CalculateMode(paymentValues);
				var distinctAllowedPaymentCount = groupRows.Count;

				return groupRows.Select(r => new PaymentReportRow(
					PayerName: r.PayerName,
					Panel: r.Panel,
					CPTCode: r.CPTCode,
					AllowedAmount: r.AllowedAmount,
					InsurancePaymentAmount: r.InsurancePaymentAmount,
					DistinctAllowedPaymentCount: distinctAllowedPaymentCount,
					MedianPayment: median,
					ModePayment: mode));
			});
	}

	private static void WriteMedianSheet(XLWorkbook workbook, IReadOnlyList<PaymentReportRow> rows)
	{
		var ws = workbook.Worksheets.Add("Median Payment");
		WriteHeaderRow(ws, "MedianPayment");

		var rowNo = 2;
		foreach (var row in rows)
		{
			WriteCommonRow(ws, rowNo, row);
			if (row.MedianPayment.HasValue)
			{
				ws.Cell(rowNo, 7).Value = row.MedianPayment.Value;
				ws.Cell(rowNo, 7).Style.NumberFormat.Format = "0.00";
			}
			rowNo++;
		}

		FormatWorksheet(ws, rowNo - 1);
	}

	private static void WriteModeSheet(XLWorkbook workbook, IReadOnlyList<PaymentReportRow> rows)
	{
		var ws = workbook.Worksheets.Add("Mode Payment");
		WriteHeaderRow(ws, "ModePayment");

		var rowNo = 2;
		foreach (var row in rows)
		{
			WriteCommonRow(ws, rowNo, row);
			if (row.ModePayment.HasValue)
			{
				ws.Cell(rowNo, 7).Value = row.ModePayment.Value;
				ws.Cell(rowNo, 7).Style.NumberFormat.Format = "0.00";
			}
			rowNo++;
		}

		FormatWorksheet(ws, rowNo - 1);
	}

	private static void WriteCommonRow(IXLWorksheet ws, int rowNo, PaymentReportRow row)
	{
		ws.Cell(rowNo, 1).Value = row.PayerName ?? string.Empty;
		ws.Cell(rowNo, 2).Value = row.Panel ?? string.Empty;

		// Write CPT as string/text
		ws.Cell(rowNo, 3).Value = NormalizeCptCode(row.CPTCode);

		if (row.AllowedAmount.HasValue)
		{
			ws.Cell(rowNo, 4).Value = row.AllowedAmount.Value;
			ws.Cell(rowNo, 4).Style.NumberFormat.Format = "0.00";
		}

		if (row.InsurancePaymentAmount.HasValue)
		{
			ws.Cell(rowNo, 5).Value = row.InsurancePaymentAmount.Value;
			ws.Cell(rowNo, 5).Style.NumberFormat.Format = "0.00";
		}

		ws.Cell(rowNo, 6).Value = row.DistinctAllowedPaymentCount;
	}

	private static string NormalizeCptCode(string? cptCode)
	{
		if (string.IsNullOrWhiteSpace(cptCode))
			return string.Empty;

		var value = cptCode.Trim();

		// If CPT comes like 99213.00 -> write as 99213
		if (decimal.TryParse(value, NumberStyles.Any, CultureInfo.InvariantCulture, out var d))
		{
			if (d == decimal.Truncate(d))
				return d.ToString("0", CultureInfo.InvariantCulture);
		}

		return value;
	}

	private static void WriteHeaderRow(IXLWorksheet ws, string metricHeader)
	{
		ws.Cell(1, 1).Value = "PayerName";
		ws.Cell(1, 2).Value = "Panel";
		ws.Cell(1, 3).Value = "CPTCode";
		ws.Cell(1, 4).Value = "AllowedAmount";
		ws.Cell(1, 5).Value = "InsurancePaymentAmount";
		ws.Cell(1, 6).Value = "DistinctAllowedPaymentCount";
		ws.Cell(1, 7).Value = metricHeader;
		ws.Row(1).Style.Font.Bold = true;
	}

	private static void FormatWorksheet(IXLWorksheet ws, int lastRow)
	{
		if (lastRow >= 1)
		{
			var range = ws.Range(1, 1, Math.Max(lastRow, 1), 7);
			range.Style.Alignment.Vertical = XLAlignmentVerticalValues.Center;
			range.Style.Alignment.WrapText = false;
			range.SetAutoFilter();
		}

		ws.Column(3).Style.NumberFormat.Format = "@";
		ws.Columns().AdjustToContents();
	}

	private static string BuildGroupKey(PaymentRow row)
		=> string.Join("|", NormalizeKey(row.PayerName), NormalizeKey(row.Panel), NormalizeKey(row.CPTCode));

	private static string BuildDistinctRowKey(PaymentRow row)
		=> string.Join("|",
			NormalizeKey(row.PayerName),
			NormalizeKey(row.Panel),
			NormalizeKey(row.CPTCode),
			row.AllowedAmount?.ToString("0.##############", CultureInfo.InvariantCulture) ?? string.Empty,
			row.InsurancePaymentAmount?.ToString("0.##############", CultureInfo.InvariantCulture) ?? string.Empty);

	private static string NormalizeKey(string? value)
		=> (value ?? string.Empty).Trim().ToUpperInvariant();

	private static int FindHeaderIndex(string[] header, params string[] aliases)
	{
		for (int i = 0; i < header.Length; i++)
		{
			var current = NormalizeHeader(header[i]);
			foreach (var alias in aliases)
			{
				if (current == NormalizeHeader(alias))
					return i;
			}
		}

		return -1;
	}

	private static string NormalizeHeader(string? value)
	{
		if (string.IsNullOrWhiteSpace(value)) return string.Empty;
		return new string(value.Where(c => !char.IsWhiteSpace(c) && c != '_' && c != '-').ToArray())
			.Trim()
			.ToUpperInvariant();
	}

	private static string ReadField(string[] fields, int index)
		=> index >= 0 && index < fields.Length ? fields[index] ?? string.Empty : string.Empty;

	private static decimal? ParseNullableDecimal(string? value)
	{
		if (string.IsNullOrWhiteSpace(value)) return null;

		var cleaned = value.Trim()
			.Replace("$", string.Empty)
			.Replace(",", string.Empty)
			.Replace("(", "-")
			.Replace(")", string.Empty);

		if (decimal.TryParse(cleaned, NumberStyles.Any, CultureInfo.InvariantCulture, out var parsed))
			return parsed;

		if (decimal.TryParse(cleaned, NumberStyles.Any, CultureInfo.CurrentCulture, out parsed))
			return parsed;

		return null;
	}

	private static decimal? CalculateMedian(IReadOnlyList<decimal> values)
	{
		if (values.Count == 0) return null;

		var ordered = values.OrderBy(x => x).ToList();
		var mid = ordered.Count / 2;

		if (ordered.Count % 2 == 1)
			return ordered[mid];

		return (ordered[mid - 1] + ordered[mid]) / 2m;
	}

	private static decimal? CalculateMode(IReadOnlyList<decimal> values)
	{
		if (values.Count == 0) return null;

		return values
			.GroupBy(x => x)
			.Select(g => new { Value = g.Key, Count = g.Count() })
			.OrderByDescending(x => x.Count)
			.ThenByDescending(x => x.Value)
			.Select(x => (decimal?)x.Value)
			.FirstOrDefault();
	}

	private sealed record PaymentRow(
		string PayerName,
		string Panel,
		string CPTCode,
		decimal? AllowedAmount,
		decimal? InsurancePaymentAmount);

	private sealed record PaymentReportRow(
		string PayerName,
		string Panel,
		string CPTCode,
		decimal? AllowedAmount,
		decimal? InsurancePaymentAmount,
		int DistinctAllowedPaymentCount,
		decimal? MedianPayment,
		decimal? ModePayment);
}
