using System.Data;
using ExcelDataReader;
using Microsoft.Extensions.Logging;

namespace DenialDatabaseProcessorWorker.Services;

public sealed class ExcelTableReader
{
	private readonly ILogger<ExcelTableReader> _logger;

	public ExcelTableReader(ILogger<ExcelTableReader> logger)
	{
		_logger = logger;
		System.Text.Encoding.RegisterProvider(System.Text.CodePagesEncodingProvider.Instance);
	}

	public sealed record ExcelTable(List<string> Headers, List<Dictionary<string, string>> Rows);

	public ExcelTable ReadTable(string path, string? sheetName = null)
	{
		System.Text.Encoding.RegisterProvider(System.Text.CodePagesEncodingProvider.Instance);

		using var stream = File.Open(path, FileMode.Open, FileAccess.Read, FileShare.ReadWrite);
		using var reader = ExcelReaderFactory.CreateReader(stream);

		var result = reader.AsDataSet(new ExcelDataSetConfiguration
		{
			ConfigureDataTable = _ => new ExcelDataTableConfiguration
			{
				UseHeaderRow = false // IMPORTANT: do NOT treat first row as header
			}
		});

		DataTable table = string.IsNullOrWhiteSpace(sheetName)
			? result.Tables[0]
			: result.Tables.Cast<DataTable>().First(t => t.TableName == sheetName);

		// Detect header row (same logic as before)
		int headerRowIndex = DetectHeaderRow(table);

		// Build headers
		var headers = table.Rows[headerRowIndex].ItemArray
			.Select(x => x?.ToString()?.Trim() ?? "")
			.ToList();

		// Build rows
		var rows = new List<Dictionary<string, string>>();
		for (int r = headerRowIndex + 1; r < table.Rows.Count; r++)
		{
			var dr = table.Rows[r];
			var dict = new Dictionary<string, string>(StringComparer.OrdinalIgnoreCase);

			bool any = false;
			for (int c = 0; c < headers.Count; c++)
			{
				var header = headers[c];
				if (string.IsNullOrWhiteSpace(header)) continue;

				var val = dr[c]?.ToString()?.Trim() ?? "";
				if (!string.IsNullOrEmpty(val)) any = true;

				dict[header] = val;
			}

			if (any)
				rows.Add(dict);
		}

		return new ExcelTable(headers, rows);
	}

	private int DetectHeaderRow(DataTable table)
	{
		int bestRow = 0;
		int bestScore = -1;

		for (int r = 0; r < Math.Min(10, table.Rows.Count); r++)
		{
			int populated = table.Rows[r].ItemArray.Count(x => !string.IsNullOrWhiteSpace(x?.ToString()));
			if (populated > bestScore)
			{
				bestScore = populated;
				bestRow = r;
			}
		}

		return bestRow;
	}

	public List<Dictionary<string, string>> Read(string path, string? sheetName = null)
		=> ReadTable(path, sheetName).Rows;
}