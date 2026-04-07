using DocumentFormat.OpenXml;
using DocumentFormat.OpenXml.Packaging;
using DocumentFormat.OpenXml.Spreadsheet;
using Microsoft.Extensions.Logging;

namespace DenialDatabaseProcessorWorker.Services;

public sealed class ExcelWriter
{
	private readonly ILogger<ExcelWriter> _logger;

	public ExcelWriter(ILogger<ExcelWriter> logger)
	{
		_logger = logger;
	}

	public void Write(
		string outputPath,
		List<string> lineHeaders,
		List<Dictionary<string, string>> lineRows,
		List<string> insightHeaders,
		List<Dictionary<string, string>> insightRows,
		List<Dictionary<string, string>> taskRows)
	{
		Directory.CreateDirectory(Path.GetDirectoryName(outputPath) ?? ".");

		var excludedHeaders = new HashSet<string>(StringComparer.OrdinalIgnoreCase)
		{
			"DenialCode",
			"Denial Code",
			"Status Action Code"
		};

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

		var effectiveLineHeaders = lineHeaders
			.Where(h => !string.IsNullOrWhiteSpace(h) && !excludedHeaders.Contains(h.Trim()))
			.ToList();

		if (File.Exists(outputPath))
			File.Delete(outputPath);

		using var doc = SpreadsheetDocument.Create(outputPath, SpreadsheetDocumentType.Workbook);

		var wbPart = doc.AddWorkbookPart();
		wbPart.Workbook = new Workbook();

		var stylesPart = wbPart.AddNewPart<WorkbookStylesPart>();
		stylesPart.Stylesheet = BuildStylesheet();
		stylesPart.Stylesheet.Save();

		var sheets = wbPart.Workbook.AppendChild(new Sheets());

		// Sheet 1: Denial Database
		var wsDbPart = wbPart.AddNewPart<WorksheetPart>();
		var dbSheetData = new SheetData();
		wsDbPart.Worksheet = new Worksheet(dbSheetData);
		var sheetId = 1u;
		sheets.Append(new Sheet
		{
			Id = wbPart.GetIdOfPart(wsDbPart),
			SheetId = sheetId++,
			Name = "Denial Database"
		});

		WriteDenialDatabaseSheet(dbSheetData, effectiveLineHeaders, lineRows);

		// Sheet 2: Denial Insights
		var wsInsightPart = wbPart.AddNewPart<WorksheetPart>();
		var insightSheetData = new SheetData();
		var insightWorksheet = new Worksheet();
		insightWorksheet.Append(insightSheetData);
		wsInsightPart.Worksheet = insightWorksheet;

		sheets.Append(new Sheet
		{
			Id = wbPart.GetIdOfPart(wsInsightPart),
			SheetId = sheetId++,
			Name = "Denial Insights"
		});

		WriteInsightsSheet(wsInsightPart, insightSheetData, insightHeaders, insightRows);

		// Sheet 3: Task Board
		var wsTaskPart = wbPart.AddNewPart<WorksheetPart>();
		var taskSheetData = new SheetData();
		wsTaskPart.Worksheet = new Worksheet(taskSheetData);

		sheets.Append(new Sheet
		{
			Id = wbPart.GetIdOfPart(wsTaskPart),
			SheetId = sheetId++,
			Name = "Task Board"
		});

		WriteTaskBoardSheet(taskSheetData, taskRows);

		wbPart.Workbook.Save();
		_logger.LogInformation("Wrote Denial Database Excel with Insights and Task Board: {OutputPath}", outputPath);
	}

	private Stylesheet BuildStylesheet()
	{
		var fonts = new Fonts(
			new Font(), // 0 default
			new Font(new Bold(), new Color { Rgb = "FFFFFFFF" }), // 1 header white bold
			new Font(new Bold(), new Color { Rgb = "FFFFFFFF" }, new FontSize { Val = 18 }), // 2 title
			new Font(new Color { Rgb = "FF0000FF" }, new Underline()) // 3 hyperlink
		);

		var fills = new Fills(
			new Fill(new PatternFill { PatternType = PatternValues.None }), // 0
			new Fill(new PatternFill { PatternType = PatternValues.Gray125 }), // 1
			new Fill(new PatternFill(new ForegroundColor { Rgb = "FF1F4E78" }) { PatternType = PatternValues.Solid }), // 2 DB header
			new Fill(new PatternFill(new ForegroundColor { Rgb = "FF6B8E23" }) { PatternType = PatternValues.Solid }), // 3 Insight header
			new Fill(new PatternFill(new ForegroundColor { Rgb = "FF34495E" }) { PatternType = PatternValues.Solid }), // 4 Task header
			new Fill(new PatternFill(new ForegroundColor { Rgb = "FFE8F5E9" }) { PatternType = PatternValues.Solid }), // 5 light green
			new Fill(new PatternFill(new ForegroundColor { Rgb = "FFD9E1F2" }) { PatternType = PatternValues.Solid }), // 6 light blue
			new Fill(new PatternFill(new ForegroundColor { Rgb = "FFECF0F1" }) { PatternType = PatternValues.Solid })  // 7 light gray
		);

		var borders = new Borders(
			new Border(), // 0 default
			new Border(
				new LeftBorder { Style = BorderStyleValues.Thin },
				new RightBorder { Style = BorderStyleValues.Thin },
				new TopBorder { Style = BorderStyleValues.Thin },
				new BottomBorder { Style = BorderStyleValues.Thin },
				new DiagonalBorder())
		);

		var cellFormats = new CellFormats(
			new CellFormat(), // 0 default
			new CellFormat { FontId = 1, FillId = 2, BorderId = 1, ApplyFont = true, ApplyFill = true, ApplyBorder = true }, // 1 DB header
			new CellFormat { FontId = 2, FillId = 2, BorderId = 1, ApplyFont = true, ApplyFill = true, ApplyBorder = true }, // 2 title
			new CellFormat { FontId = 1, FillId = 3, BorderId = 1, ApplyFont = true, ApplyFill = true, ApplyBorder = true }, // 3 Insight header
			new CellFormat { FontId = 1, FillId = 4, BorderId = 1, ApplyFont = true, ApplyFill = true, ApplyBorder = true }, // 4 Task header
			new CellFormat { FontId = 0, FillId = 0, BorderId = 1, ApplyBorder = true }, // 5 data with border
			new CellFormat { NumberFormatId = 14, ApplyNumberFormat = true }, // 6 date
			new CellFormat { NumberFormatId = 4, ApplyNumberFormat = true }, // 7 money
			new CellFormat { FontId = 3, ApplyFont = true } // 8 hyperlink
		);

		return new Stylesheet(fonts, fills, borders, cellFormats);
	}

	private void WriteDenialDatabaseSheet(
		SheetData sheetData,
		List<string> headers,
		List<Dictionary<string, string>> rows)
	{
		// Header row
		var headerRow = new Row { RowIndex = 1u };
		for (int c = 0; c < headers.Count; c++)
		{
			headerRow.Append(CreateTextCell(c, 1, headers[c], 1u));
		}
		sheetData.Append(headerRow);

		// Data rows
		for (int r = 0; r < rows.Count; r++)
		{
			var dict = rows[r];
			var row = new Row { RowIndex = (uint)(r + 2) };

			for (int c = 0; c < headers.Count; c++)
			{
				var key = headers[c];
				dict.TryGetValue(key, out var val);
				row.Append(CreateTextCell(c, r + 2, val ?? "", 5u));
			}

			sheetData.Append(row);
		}
	}

	private void WriteInsightsSheet(
		WorksheetPart wsPart,
		SheetData sheetData,
		List<string> headers,
		List<Dictionary<string, string>> rows)
	{
		var ws = wsPart.Worksheet;

		// Title row at (3,2), merged across headers
		var titleRowIndex = 3u;
		var titleRow = new Row { RowIndex = titleRowIndex };
		titleRow.Append(CreateTextCell(1, (int)titleRowIndex, "Denial Insights Summary", 2u));
		sheetData.Append(new Row()); // row 1
		sheetData.Append(new Row()); // row 2
		sheetData.Append(titleRow);  // row 3

		// Merge title across columns B..(B+headers.Count-1)
		var mergeCells = new MergeCells();
		string startRef = GetCellReference(1, (int)titleRowIndex);
		string endRef = GetCellReference(headers.Count, (int)titleRowIndex);
		mergeCells.Append(new MergeCell { Reference = $"{startRef}:{endRef}" });
		ws.InsertAfter(mergeCells, ws.Elements<SheetData>().First());

		// Header row at (5,2)
		uint headerRowIndex = 5u;
		var headerRow = new Row { RowIndex = headerRowIndex };

		for (int c = 0; c < headers.Count; c++)
		{
			headerRow.Append(CreateTextCell(c + 1, (int)headerRowIndex, headers[c], 3u));
		}

		sheetData.Append(new Row()); // row 4
		sheetData.Append(headerRow); // row 5

		// Data rows start at row 6
		for (int r = 0; r < rows.Count; r++)
		{
			uint rowIndex = (uint)(6 + r);
			var dict = rows[r];
			var row = new Row { RowIndex = rowIndex };

			for (int c = 0; c < headers.Count; c++)
			{
				var key = headers[c];
				dict.TryGetValue(key, out var val);

				if (key.Equals("Data", StringComparison.OrdinalIgnoreCase))
				{
					row.Append(CreateTextCell(c + 1, (int)rowIndex, "Link", 8u));
				}
				else if (key.Contains("Balance") && decimal.TryParse(val, out var d))
				{
					row.Append(CreateNumberCell(c + 1, (int)rowIndex, d, 7u));
				}
				else
				{
					row.Append(CreateTextCell(c + 1, (int)rowIndex, val ?? "", 5u));
				}
			}

			sheetData.Append(row);
		}

		// Column widths for Insights
		var cols = new Columns();
		void AddCol(int index, double width)
		{
			cols.Append(new Column
			{
				Min = (uint)index,
				Max = (uint)index,
				Width = width,
				CustomWidth = true
			});
		}

		// B is 2
		AddCol(2, 45); // Descriptions
		AddCol(3, 35); // Observation
		AddCol(4, 25); // Action Code
		AddCol(5, 40); // Action
		AddCol(6, 30); // Task
		AddCol(7, 12); // Data
		AddCol(8, 15); // # of Denial
		AddCol(9, 15); // # of Claims
		AddCol(10, 18); // Total Balance
		AddCol(11, 18); // Ins. Balance
		AddCol(12, 15); // $ Impact

		ws.InsertAt(cols, 0);

		// Freeze panes at header row
		var sheetViews = new SheetViews(
			new SheetView(
				new Pane
				{
					VerticalSplit = 5,
					TopLeftCell = "B6",
					ActivePane = PaneValues.BottomLeft,
					State = PaneStateValues.Frozen
				})
			{ WorkbookViewId = 0 });

		ws.InsertAt(sheetViews, 0);

		// Excel table styling (Medium9)
		var tablePart = wsPart.AddNewPart<TableDefinitionPart>();
		var table = new Table
		{
			Id = 1,
			Name = "InsightsTable",
			DisplayName = "InsightsTable",
			Reference = $"B5:{GetCellReference(headers.Count, 5 + rows.Count)}",
			HeaderRowCount = 1
		};

		var tableColumns = new TableColumns { Count = (uint)headers.Count };
		for (int i = 0; i < headers.Count; i++)
		{
			tableColumns.Append(new TableColumn
			{
				Id = (uint)(i + 1),
				Name = headers[i]
			});
		}

		table.Append(tableColumns);
		table.Append(new TableStyleInfo
		{
			Name = "TableStyleMedium9",
			ShowFirstColumn = false,
			ShowLastColumn = false,
			ShowRowStripes = true,
			ShowColumnStripes = false
		});

		tablePart.Table = table;

		var tableParts = new TableParts { Count = 1 };
		tableParts.Append(new TablePart { Id = wsPart.GetIdOfPart(tablePart) });
		ws.Append(tableParts);
	}

	private void WriteTaskBoardSheet(
		SheetData sheetData,
		List<Dictionary<string, string>> taskRows)
	{
		var taskHeaders = new List<string>
		{
			"Task ID",
			"Claim ID",
			"Patient / Acct #",
			"CPT Code",
			"Denial Code",
			"Denial Description",
			"Denial Classification",
			"Action Code",
			"Recommended Action",
			"Task",
			"Action Category",
			"Priority",
			"SLA (Days)",
			"Insurance Balance",
			"Assigned To",
			"Status",
			"Date Opened",
			"Due Date",
			"Date Completed",
			"Days Remaining",
			"SLA Status"
		};

		// Header row
		var headerRow = new Row { RowIndex = 1u };
		for (int c = 0; c < taskHeaders.Count; c++)
		{
			headerRow.Append(CreateTextCell(c, 1, taskHeaders[c], 4u));
		}
		sheetData.Append(headerRow);

		// Data rows
		for (int r = 0; r < taskRows.Count; r++)
		{
			uint rowIndex = (uint)(r + 2);
			var dict = taskRows[r];
			var row = new Row { RowIndex = rowIndex };

			for (int c = 0; c < taskHeaders.Count; c++)
			{
				var key = taskHeaders[c];
				dict.TryGetValue(key, out var val);

				if (key is "Date Opened" or "Due Date" or "Date Completed")
				{
					if (DateTime.TryParse(val, out var dt))
					{
						row.Append(CreateDateCell(c, (int)rowIndex, dt, 6u));
						continue;
					}
				}

				row.Append(CreateTextCell(c, (int)rowIndex, val ?? "", 5u));
			}

			sheetData.Append(row);
		}
	}

	private Cell CreateTextCell(int columnIndex, int rowIndex, string text, uint styleIndex)
	{
		return new Cell
		{
			CellReference = GetCellReference(columnIndex, rowIndex),
			DataType = CellValues.String,
			StyleIndex = styleIndex,
			CellValue = new CellValue(text)
		};
	}

	private Cell CreateNumberCell(int columnIndex, int rowIndex, decimal value, uint styleIndex)
	{
		return new Cell
		{
			CellReference = GetCellReference(columnIndex, rowIndex),
			DataType = null,
			StyleIndex = styleIndex,
			CellValue = new CellValue(value.ToString(System.Globalization.CultureInfo.InvariantCulture))
		};
	}

	private Cell CreateDateCell(int columnIndex, int rowIndex, DateTime value, uint styleIndex)
	{
		return new Cell
		{
			CellReference = GetCellReference(columnIndex, rowIndex),
			DataType = null,
			StyleIndex = styleIndex,
			CellValue = new CellValue(value.ToOADate().ToString(System.Globalization.CultureInfo.InvariantCulture))
		};
	}

	private static string GetCellReference(int columnIndex, int rowIndex)
	{
		int dividend = columnIndex + 1;
		string columnName = string.Empty;

		while (dividend > 0)
		{
			int modulo = (dividend - 1) % 26;
			columnName = Convert.ToChar('A' + modulo) + columnName;
			dividend = (dividend - modulo) / 26;
		}

		return $"{columnName}{rowIndex}";
	}
}