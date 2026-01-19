using ClosedXML.Excel;
using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Threading.Tasks;
using Common.Logging;
using LRN.DataLibrary.Repository.Interfaces;
using LRN.ExcelToSqlETL.Core.Interface;
using LRN.ExcelToSqlETL.Core.Models;
using System.Data;
using System.Globalization;

public class ExcelFileReader : IFileReader
{
	private static readonly ILoggerService _logger = new LogManagerService();

	private readonly IImportFilesRepository _importRepo;
	private readonly List<FileLog> _importLog = new();

	private int _importFileId;

	public ExcelFileReader(IImportFilesRepository importRepo)
	{
		_importRepo = importRepo;
	}

	public async Task<List<ExcelReadResult>> ReadAsync(Stream stream, ExcelSheetMapping mapping, int importFileId)
	{
		_importFileId = importFileId;
		_importLog.Clear();

		var result = mapping.UseDynamicSchema
			? await ReadDynamicAsync(stream, mapping)
			: await ReadMappedAsync(stream, mapping);

		if (_importLog.Count > 0)
			await _importRepo.InsertFileLog(_importLog);

		return result;
	}

	private async Task<List<ExcelReadResult>> ReadMappedAsync(Stream stream, ExcelSheetMapping mapping)
	{
		using var workbook = new XLWorkbook(stream);
		var resultTable = CreateMappedTableSchema(mapping);

		int totalRows = 0;
		int importedRows = 0;
		int errorRows = 0;

		var worksheets = GetWorksheets(workbook, mapping);

		bool isFailed = false;
		bool anySheetImported = false;

		foreach (var worksheet in worksheets)
		{
			try
			{
				int headerRowIndex = 1;

				// If UseSheetName is false, we auto-detect header row (top 20 rows search).
				// This is what throws "Wrong Template uploaded..." on non-data sheets like "Notes".
				if (!mapping.UseSheetName)
					headerRowIndex = FindHeaderRow(worksheet, mapping);

				var headerMap = BuildHeaderMap(worksheet.Row(headerRowIndex));

				// If required columns are missing, treat it as a non-matching sheet and skip.
				var missingRequired = GetMissingRequiredExcelColumns(headerMap, mapping);
				if (missingRequired.Count > 0)
					throw new InvalidDataException($"Missing required column(s): {string.Join(", ", missingRequired)}");

				// Log extra columns (do NOT fail)
				var extra = GetExtraExcelColumns(headerMap, mapping);
				if (extra.Count > 0)
				{
					var msg = $"Sheet '{worksheet.Name}' contains extra column(s) not in mapping JSON: {string.Join(", ", extra)}";
					_logger.Warn(msg);
					_importLog.Add(new FileLog { ImportFileId = _importFileId, LogType = "Warning", LogMessage = msg });
				}

				// Import rows
				PopulateTableRows(
					worksheet,
					headerRowIndex,
					headerMap,
					mapping,
					resultTable,
					worksheet.Name,
					ref totalRows,
					ref importedRows,
					ref errorRows
				);

				anySheetImported = true;
			}
			catch (InvalidDataException ex) when (
				ex.Message.StartsWith("Wrong Template uploaded", StringComparison.OrdinalIgnoreCase) ||
				ex.Message.StartsWith("Missing required column(s):", StringComparison.OrdinalIgnoreCase))
			{
				// ✅ Non-matching sheet (ex: "Notes") -> skip, don't fail workbook
				var msg = $"Skipping non-data sheet '{worksheet.Name}': {ex.Message}";
				_logger.Warn(msg);
				_importLog.Add(new FileLog { ImportFileId = _importFileId, LogType = "Warning", LogMessage = msg });
				continue;
			}
			catch (Exception ex)
			{
				// ❌ Real fatal error -> fail the file
				var msg = $"Fatal error while reading sheet '{worksheet.Name}': {ex.Message}";
				_logger.Error(msg);
				_importLog.Add(new FileLog { ImportFileId = _importFileId, LogType = "Error", LogMessage = msg });

				isFailed = true;
				break;
			}
		}

		// If we skipped all sheets (none matched mapping), fail the file
		if (!anySheetImported)
		{
			isFailed = true;
			var msg = "No worksheets matched the expected template/mapping. File skipped.";
			_logger.Error(msg);
			_importLog.Add(new FileLog { ImportFileId = _importFileId, LogType = "Error", LogMessage = msg });
		}

		var summary = isFailed
			? $"Excel read FAILED (mapped). Total Rows scanned: {totalRows}, Imported: {importedRows}, Errors: {errorRows}"
			: $"Finished reading mapped Excel. Total Rows: {totalRows}, Imported: {importedRows}, Errors: {errorRows}";

		_logger.Info(summary);
		_importLog.Add(new FileLog { ImportFileId = _importFileId, LogType = "Info", LogMessage = summary });

		return new List<ExcelReadResult>
	{
		new ExcelReadResult
		{
			Data = resultTable,
			TotalRows = totalRows,
			ImportedRows = importedRows,
			ErrorRows = errorRows,
			IsFailedRead = isFailed
		}
	};
	}

	private async Task<List<ExcelReadResult>> ReadDynamicAsync(Stream stream, ExcelSheetMapping mapping)
	{
		try
		{
			using var workbook = new XLWorkbook(stream);
			var combinedTable = new DataTable();
			var columnSet = new HashSet<string>(StringComparer.OrdinalIgnoreCase);
			int totalRows = 0;

			var worksheets = GetWorksheets(workbook, mapping);

			foreach (var sheet in worksheets)
			{
				var headerRow = sheet.FirstRowUsed();
				if (headerRow == null) continue;

				foreach (var cell in headerRow.CellsUsed())
				{
					var header = cell.GetString().Trim();
					if (!string.IsNullOrWhiteSpace(header))
						columnSet.Add(header);
				}
			}

			foreach (var col in columnSet)
				combinedTable.Columns.Add(col);

			if (mapping.UseSheetName)
				combinedTable.Columns.Add("SheetName");

			foreach (var sheet in worksheets)
			{
				var headerRow = sheet.FirstRowUsed();
				if (headerRow == null) continue;

				var headerMap = new Dictionary<string, int>(StringComparer.OrdinalIgnoreCase);
				var lastCol = headerRow.LastCellUsed()?.Address.ColumnNumber ?? 0;

				for (int col = 1; col <= lastCol; col++)
				{
					var header = headerRow.Cell(col).GetString().Trim();
					if (!string.IsNullOrWhiteSpace(header))
						headerMap[header] = col;
				}

				var firstDataRow = headerRow.RowBelow().RowNumber();
				var lastRow = sheet.LastRowUsed()?.RowNumber() ?? firstDataRow - 1;

				for (int rowNum = firstDataRow; rowNum <= lastRow; rowNum++)
				{
					totalRows++;
					var row = sheet.Row(rowNum);
					var newRow = combinedTable.NewRow();

					foreach (var header in headerMap.Keys)
					{
						var colIndex = headerMap[header];
						newRow[header] = row.Cell(colIndex).GetValue<string>();
					}

					if (mapping.UseSheetName)
						newRow["SheetName"] = sheet.Name;

					combinedTable.Rows.Add(newRow);
				}
			}

			var msg = $"Finished reading dynamic Excel. Total Rows: {totalRows}";
			_logger.Info(msg);
			_importLog.Add(new FileLog { ImportFileId = _importFileId, LogType = "Info", LogMessage = msg });

			return new List<ExcelReadResult> {
				new ExcelReadResult {
					Data = combinedTable,
					TotalRows = totalRows,
					ImportedRows = totalRows,
					ErrorRows = 0
				}
			};
		}
		catch (Exception ex)
		{
			var msg = $"Error in ReadDynamicAsync: {ex}";
			_logger.Error(msg);
			_importLog.Add(new FileLog { ImportFileId = _importFileId, LogType = "Error", LogMessage = msg });
			return null;
		}
	}

	private void PopulateTableRows(
		IXLWorksheet worksheet,
		int headerRowIndex,
		Dictionary<string, int> headerMap,
		ExcelSheetMapping mapping,
		DataTable table,
		string sheetName,
		ref int totalRows,
		ref int importedRows,
		ref int errorRows)
	{
		// Precompute column lookups once (optimization)
		var activeMappings = mapping.Columns
			.Where(c => !string.IsNullOrWhiteSpace(c.ExcelColumn) && headerMap.ContainsKey(c.ExcelColumn))
			.Select(c => new
			{
				ExcelColumn = c.ExcelColumn,
				SqlColumn = c.SqlColumn,
				DataType = c.DataType,
				ColIndex = headerMap[c.ExcelColumn]
			})
			.ToList();

		var lastRow = worksheet.LastRowUsed()?.RowNumber() ?? headerRowIndex;

		for (int rowNum = headerRowIndex + 1; rowNum <= lastRow; rowNum++)
		{
			totalRows++;
			var row = worksheet.Row(rowNum);
			var newRow = table.NewRow();
			bool hasError = false;

			foreach (var col in activeMappings)
			{
				try
				{
					var cellValue = row.Cell(col.ColIndex).GetValue<string>();
					newRow[col.SqlColumn] = GetCellValue(cellValue, col.DataType);
				}
				catch (Exception ex)
				{
					hasError = true;

					var msg = $"Row {rowNum} in sheet '{sheetName}' has error in column '{col.ExcelColumn}': {ex.Message}";
					_logger.Warn(msg);
					_importLog.Add(new FileLog { ImportFileId = _importFileId, LogType = "Error", LogMessage = msg });
				}
			}

			if (mapping.UseSheetName)
				newRow["SheetName"] = sheetName;

			if (hasError)
			{
				errorRows++;
				continue;
			}

			table.Rows.Add(newRow);
			importedRows++;
		}
	}

	private List<IXLWorksheet> GetWorksheets(XLWorkbook workbook, ExcelSheetMapping mapping)
	{
		if (mapping == null || !mapping.UseSheetName)
			return workbook.Worksheets.ToList();

		if (string.IsNullOrWhiteSpace(mapping.SheetName))
			throw new Exception("UseSheetName is true, but SheetName is empty or missing.");

		var names = mapping.SheetName
			.Split(',', StringSplitOptions.RemoveEmptyEntries | StringSplitOptions.TrimEntries)
			.ToHashSet(StringComparer.OrdinalIgnoreCase);

		return workbook.Worksheets.Where(ws => names.Contains(ws.Name)).ToList();
	}

	private DataTable CreateMappedTableSchema(ExcelSheetMapping mapping)
	{
		var table = new DataTable();
		foreach (var col in mapping.Columns)
		{
			if (!table.Columns.Contains(col.SqlColumn))
				table.Columns.Add(col.SqlColumn);
		}
		if (mapping.UseSheetName)
			table.Columns.Add("SheetName");

		return table;
	}

	private Dictionary<string, int> BuildHeaderMap(IXLRow headerRow)
	{
		var headerMap = new Dictionary<string, int>(StringComparer.OrdinalIgnoreCase);
		var duplicates = new HashSet<string>(StringComparer.OrdinalIgnoreCase);

		var lastCol = headerRow.LastCellUsed()?.Address.ColumnNumber
					  ?? headerRow.Worksheet.LastColumnUsed()?.ColumnNumber() ?? 0;

		for (int col = 1; col <= lastCol; col++)
		{
			var header = headerRow.Cell(col).GetString().Trim();
			if (string.IsNullOrWhiteSpace(header)) continue;

			if (!headerMap.TryAdd(header, col))
				duplicates.Add(header);
		}

		if (duplicates.Count > 0)
			throw new InvalidDataException($"Duplicate header(s) found: {string.Join(", ", duplicates)}");

		return headerMap;
	}

	// SQL columns that are NOT expected to exist in the Excel header row
	// (because you fill them in code before bulk copy)
	private static readonly HashSet<string> HeaderIgnoreSqlColumns =
		new HashSet<string>(StringComparer.OrdinalIgnoreCase)
		{
			"ImportedFileID"
            // add more if needed: "CreatedOn", "CreatedBy", "UpdatedOn", etc.
        };

	private List<string> GetMissingRequiredExcelColumns(Dictionary<string, int> headerMap, ExcelSheetMapping mapping)
	{
		return mapping.Columns
			.Where(c =>
				c.Required &&
				!string.IsNullOrWhiteSpace(c.ExcelColumn) &&
				(string.IsNullOrWhiteSpace(c.SqlColumn) || !HeaderIgnoreSqlColumns.Contains(c.SqlColumn)) &&
				!headerMap.ContainsKey(c.ExcelColumn))
			.Select(c => c.ExcelColumn.Trim())
			.Distinct(StringComparer.OrdinalIgnoreCase)
			.OrderBy(s => s)
			.ToList();
	}

	private List<string> GetExtraExcelColumns(Dictionary<string, int> headerMap, ExcelSheetMapping mapping)
	{
		var expected = mapping.Columns
			.Where(c =>
				!string.IsNullOrWhiteSpace(c.ExcelColumn) &&
				(string.IsNullOrWhiteSpace(c.SqlColumn) || !HeaderIgnoreSqlColumns.Contains(c.SqlColumn)))
			.Select(c => c.ExcelColumn.Trim())
			.Distinct(StringComparer.OrdinalIgnoreCase)
			.ToHashSet(StringComparer.OrdinalIgnoreCase);

		return headerMap.Keys
			.Where(h => !expected.Contains(h))
			.OrderBy(s => s)
			.ToList();
	}

	private int FindHeaderRow(IXLWorksheet worksheet, ExcelSheetMapping mapping, int scanLimit = 20)
	{
		// Only columns we expect to appear in Excel header
		var expectedCols = mapping.Columns
			.Where(c =>
				!string.IsNullOrWhiteSpace(c.ExcelColumn) &&
				(string.IsNullOrWhiteSpace(c.SqlColumn) || !HeaderIgnoreSqlColumns.Contains(c.SqlColumn)))
			.Select(c => c.ExcelColumn.Trim())
			.Distinct(StringComparer.OrdinalIgnoreCase)
			.ToList();

		// If there’s nothing to detect, default to first row
		if (expectedCols.Count == 0)
			return 1;

		var rowHeaders = new Dictionary<int, List<string>>();
		var allFoundHeaders = new List<string>();

		// collect potential header values from each row
		for (int i = 1; i <= scanLimit; i++)
		{
			var row = worksheet.Row(i);
			var cellValues = row.CellsUsed()
				.Select(c => c.GetString().Trim())
				.Where(v => !string.IsNullOrWhiteSpace(v))
				.ToList();

			rowHeaders[i] = cellValues;
			allFoundHeaders.AddRange(cellValues);
		}

		// find the row that contains the most expected headers
		int bestMatchRow = -1;
		int bestMatchCount = 0;

		for (int i = 1; i <= scanLimit; i++)
		{
			var cellValues = rowHeaders[i];

			int matches = expectedCols.Count(col =>
				cellValues.Contains(col, StringComparer.OrdinalIgnoreCase));

			if (matches > bestMatchCount)
			{
				bestMatchCount = matches;
				bestMatchRow = i;
			}
		}

		// Require at least 70% of EXPECTED headers (ignoring ImportedFileID)
		int threshold = (int)Math.Ceiling(expectedCols.Count * 0.7);

		if (bestMatchCount >= threshold)
			return bestMatchRow;

		// If no single row has enough matches, try combining consecutive rows (up to 3 rows)
		for (int startRow = 1; startRow <= scanLimit - 1; startRow++)
		{
			var combinedHeaders = new List<string>();

			for (int i = startRow; i <= Math.Min(startRow + 2, scanLimit); i++)
				combinedHeaders.AddRange(rowHeaders[i]);

			int combinedMatches = expectedCols.Count(col =>
				combinedHeaders.Contains(col, StringComparer.OrdinalIgnoreCase));

			if (combinedMatches >= threshold)
				return startRow; // starting row of header block
		}

		// Identify missing fields (only from expectedCols)
		var missingFields = expectedCols
			.Where(col => !allFoundHeaders.Contains(col, StringComparer.OrdinalIgnoreCase))
			.ToList();

		var foundFields = expectedCols
			.Where(col => allFoundHeaders.Contains(col, StringComparer.OrdinalIgnoreCase))
			.ToList();

		var errorMessage =
			$"Wrong Template uploaded - Template Headings not found in the top {scanLimit} rows. " +
			$"Missing Fields:\n{string.Join("\n", missingFields.Select(f => $"• {f}"))}" +
			$"\nAvailable fields: [{string.Join(", ", foundFields)}]\n" +
			$"\nPlease ensure the Excel file has the correct column headers.";

		throw new InvalidDataException(errorMessage);
	}

	public static object GetCellValue(string? cellValue, string expectedType)
	{
		if (string.IsNullOrWhiteSpace(cellValue))
			return DBNull.Value;

		string value = cellValue.Trim();
		string type = expectedType?.ToLowerInvariant() ?? "string";

		return type switch
		{
			"string" => value,

			"int" or "integer" =>
				int.TryParse(value, NumberStyles.Any, CultureInfo.InvariantCulture, out var intResult)
					? intResult : DBNull.Value,

			"double" or "decimal" =>
				double.TryParse(value, NumberStyles.Any, CultureInfo.InvariantCulture, out var doubleResult)
					? doubleResult : DBNull.Value,

			"datetime" or "date" =>
				TryParseFlexibleDate_USOnly(value, out var dateResult)
					? dateResult : DBNull.Value,

			"bool" or "boolean" =>
				bool.TryParse(value, out var boolResult)
					? boolResult : DBNull.Value,

			_ => value // return raw string for unknown type
		};
	}

	private static readonly string[] UsOnlyFormats =
	{
		"MM/dd/yyyy", "M/d/yyyy",
		"MM/dd/yy",   "M/d/yy",
		"MM/dd/yyyy HH:mm:ss", "M/d/yyyy HH:mm:ss",
		"MM/dd/yyyy h:mm tt",  "M/d/yyyy h:mm tt",
		"MM/dd/yyyy h:mm:ss tt","M/d/yyyy h:mm:ss tt"
	};

	private static readonly string[] IsoFormats =
	{
		"yyyy-MM-dd",
		"yyyy-MM-ddTHH:mm:ss",
		"yyyy-MM-ddTHH:mm:ss.fff",
		"yyyy-MM-ddTHH:mm:ss'Z'",
		"yyyy-MM-ddTHH:mm:ss.fff'Z'"
	};

	public static bool TryParseFlexibleDate_USOnly(string input, out DateTime date)
	{
		date = default;
		if (string.IsNullOrWhiteSpace(input))
			return false;

		input = input.Trim();

		// 1) Excel serials (OADate)
		if (double.TryParse(input, NumberStyles.Float, CultureInfo.InvariantCulture, out var serial)
			&& serial > 0 && serial < 60000)
		{
			date = DateTime.FromOADate(serial);
			return true;
		}

		var us = new CultureInfo("en-US");

		// 2) Strict ISO (unambiguous, any culture)
		if (DateTime.TryParseExact(input, IsoFormats, CultureInfo.InvariantCulture,
								   DateTimeStyles.None, out date))
			return true;

		// 3) Strict US month-first ONLY
		if (DateTime.TryParseExact(input, UsOnlyFormats, us, DateTimeStyles.None, out date))
			return true;

		// 4) DO NOT fall back to general TryParse or en-GB.
		return false;
	}
}
