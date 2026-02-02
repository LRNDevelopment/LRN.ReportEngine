using ExcelDataReader;
using System.Globalization;
using System.Text;

public static class ExcelCsvExporter
{
	static ExcelCsvExporter()
	{
		// Needed for ExcelDataReader on some systems
		Encoding.RegisterProvider(CodePagesEncodingProvider.Instance);
	}

	public static async Task<(string? claimSheetUsed, string? lineSheetUsed)> ExportClaimAndLineCsvAsync(
		string xlsxPath,
		string claimCsvPath,
		string lineCsvPath,
		string? claimSheetCandidatesCsv,
		string? lineSheetCandidatesCsv,
		CancellationToken ct)
	{
		var availableSheets = ListSheetNames(xlsxPath);

		string? claimSheet = PickFirstAvailable(availableSheets, claimSheetCandidatesCsv);
		string? lineSheet = PickFirstAvailable(availableSheets, lineSheetCandidatesCsv);

		if (claimSheet != null)
		{
			Directory.CreateDirectory(Path.GetDirectoryName(claimCsvPath)!);
			await ExportSheetToCsvAsync(xlsxPath, claimSheet, claimCsvPath, ct);
		}

		if (lineSheet != null)
		{
			Directory.CreateDirectory(Path.GetDirectoryName(lineCsvPath)!);
			await ExportSheetToCsvAsync(xlsxPath, lineSheet, lineCsvPath, ct);
		}

		return (claimSheet, lineSheet);
	}

	private static HashSet<string> ListSheetNames(string xlsxPath)
	{
		using var stream = File.Open(xlsxPath, FileMode.Open, FileAccess.Read, FileShare.ReadWrite);
		using var reader = ExcelReaderFactory.CreateReader(stream);

		var set = new HashSet<string>(StringComparer.OrdinalIgnoreCase);

		do
		{
			if (!string.IsNullOrWhiteSpace(reader.Name))
				set.Add(reader.Name);
		}
		while (reader.NextResult());

		return set;
	}

	private static string? PickFirstAvailable(HashSet<string> availableSheets, string? candidatesCsv)
	{
		var candidates = SplitCandidates(candidatesCsv);
		foreach (var c in candidates)
		{
			if (availableSheets.Contains(c))
				return c;
		}
		return null;
	}

	private static string[] SplitCandidates(string? csv)
	{
		if (string.IsNullOrWhiteSpace(csv)) return Array.Empty<string>();
		return csv.Split(',', StringSplitOptions.RemoveEmptyEntries | StringSplitOptions.TrimEntries);
	}

	private static async Task ExportSheetToCsvAsync(string xlsxPath, string sheetName, string csvPath, CancellationToken ct)
	{
		using var stream = File.Open(xlsxPath, FileMode.Open, FileAccess.Read, FileShare.ReadWrite);
		using var reader = ExcelReaderFactory.CreateReader(stream);

		// Move to the requested sheet
		bool found = false;
		do
		{
			if (string.Equals(reader.Name, sheetName, StringComparison.OrdinalIgnoreCase))
			{
				found = true;
				break;
			}
		}
		while (reader.NextResult());

		if (!found)
			throw new InvalidOperationException($"Sheet '{sheetName}' not found in '{xlsxPath}'.");

		await using var fs = new FileStream(csvPath, FileMode.Create, FileAccess.Write, FileShare.Read);
		await using var sw = new StreamWriter(fs, new UTF8Encoding(encoderShouldEmitUTF8Identifier: true));

		while (reader.Read())
		{
			ct.ThrowIfCancellationRequested();

			int cols = reader.FieldCount;
			for (int i = 0; i < cols; i++)
			{
				if (i > 0) await sw.WriteAsync(",");

				var val = reader.GetValue(i);
				var text = ConvertCellToString(val);
				await sw.WriteAsync(CsvEscape(text));
			}
			await sw.WriteLineAsync();
		}

		await sw.FlushAsync();
	}

	private static string ConvertCellToString(object? val)
	{
		if (val == null || val == DBNull.Value) return "";

		return val switch
		{
			DateTime dt => dt.ToString("yyyy-MM-dd HH:mm:ss", CultureInfo.InvariantCulture),
			double d => d.ToString(CultureInfo.InvariantCulture),
			float f => f.ToString(CultureInfo.InvariantCulture),
			decimal m => m.ToString(CultureInfo.InvariantCulture),
			bool b => b ? "true" : "false",
			_ => Convert.ToString(val, CultureInfo.InvariantCulture) ?? ""
		};
	}

	private static string CsvEscape(string s)
	{
		// Escape for CSV (RFC4180-ish)
		bool mustQuote = s.Contains(',') || s.Contains('"') || s.Contains('\n') || s.Contains('\r');
		if (s.Contains('"'))
			s = s.Replace("\"", "\"\"");
		return mustQuote ? $"\"{s}\"" : s;
	}
}