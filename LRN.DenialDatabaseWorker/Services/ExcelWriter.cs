using ClosedXML.Excel;
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
		List<Dictionary<string, string>> insightRows)
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

		// Filter headers for line-level sheet
		var effectiveLineHeaders = lineHeaders
			.Where(h => !string.IsNullOrWhiteSpace(h) && !excludedHeaders.Contains(h.Trim()))
			.ToList();

		using var wb = new XLWorkbook();

		//
		// ───────────────────────────────────────────────
		//  SHEET 1: DENIAL DATABASE (LINE LEVEL)
		// ───────────────────────────────────────────────
		//
		var ws1 = wb.AddWorksheet("Denial Database");

		// Header row
		for (int c = 0; c < effectiveLineHeaders.Count; c++)
		{
			ws1.Cell(1, c + 1).Value = effectiveLineHeaders[c];
			ws1.Cell(1, c + 1).Style.Font.Bold = true;
		}

		// Body rows
		for (int r = 0; r < lineRows.Count; r++)
		{
			var row = lineRows[r];
			for (int c = 0; c < effectiveLineHeaders.Count; c++)
			{
				var key = effectiveLineHeaders[c];
				row.TryGetValue(key, out var val);
				ws1.Cell(r + 2, c + 1).Value = val ?? "";
			}
		}

		// Hide selected columns
		for (int c = 0; c < effectiveLineHeaders.Count; c++)
		{
			var header = effectiveLineHeaders[c];
			if (hiddenHeaders.Contains(header.Trim()))
				ws1.Column(c + 1).Hide();
		}

		ws1.Columns().AdjustToContents();

		//
		// ───────────────────────────────────────────────
		//  SHEET 2: DENIAL INSIGHTS (Styled + Title + Spacing)
		// ───────────────────────────────────────────────
		//
		var ws2 = wb.AddWorksheet("Denial Insights");

		// Leave 2 rows + 2 columns empty
		int rowOffset = 3;
		int colOffset = 3;

		// ───────────────────────────────────────────────
		//  TITLE ROW (Merged + Centered)
		// ───────────────────────────────────────────────
		var titleCell = ws2.Cell(rowOffset, colOffset);
		titleCell.Value = "Key Observations & Highlights";

		int titleEndCol = colOffset + insightHeaders.Count - 1;

		// Merge title across all insight columns
		ws2.Range(rowOffset, colOffset, rowOffset, titleEndCol).Merge();

		// Style title
		titleCell.Style.Font.Bold = true;
		titleCell.Style.Font.FontColor = XLColor.White;
		titleCell.Style.Font.FontSize = 16;
		titleCell.Style.Alignment.Horizontal = XLAlignmentHorizontalValues.Center;
		titleCell.Style.Alignment.Vertical = XLAlignmentVerticalValues.Center;
		titleCell.Style.Fill.BackgroundColor = XLColor.FromHtml("#275317"); // Light blue header
		titleCell.Style.Border.OutsideBorder = XLBorderStyleValues.Thick;

		// Move to header row (2 rows below title)
		int headerRow = rowOffset + 1;

		// ───────────────────────────────────────────────
		//  HEADER ROW
		// ───────────────────────────────────────────────
		for (int c = 0; c < insightHeaders.Count; c++)
		{
			var cell = ws2.Cell(headerRow, colOffset + c);
			cell.Value = insightHeaders[c];

			// Header styling
			cell.Style.Font.Bold = true;
			cell.Style.Font.FontColor = XLColor.White;
			cell.Style.Fill.BackgroundColor = XLColor.FromHtml("#275317"); // Light gray
			cell.Style.Alignment.Horizontal = XLAlignmentHorizontalValues.Center;
			cell.Style.Border.BottomBorder = XLBorderStyleValues.Thin;
			cell.Style.Border.TopBorder = XLBorderStyleValues.Thin;
			cell.Style.Border.LeftBorder = XLBorderStyleValues.Thin;
			cell.Style.Border.RightBorder = XLBorderStyleValues.Thin;
		}

		// ───────────────────────────────────────────────
		//  BODY ROWS
		// ───────────────────────────────────────────────
		for (int r = 0; r < insightRows.Count; r++)
		{
			var row = insightRows[r];

			for (int c = 0; c < insightHeaders.Count; c++)
			{
				var key = insightHeaders[c];
				row.TryGetValue(key, out var val);

				var cell = ws2.Cell(headerRow + 1 + r, colOffset + c);

				if (key.Equals("Data", StringComparison.OrdinalIgnoreCase))
				{
					cell.Value = "Link";
					cell.SetHyperlink(new XLHyperlink("'Denial Database'!A1"));
					cell.Style.Font.FontColor = XLColor.Blue;
					cell.Style.Font.Underline = XLFontUnderlineValues.Single;
				}
				else if (key.Equals("Total Balance ($)", StringComparison.OrdinalIgnoreCase) || key.Equals("Ins. Balance ($)", StringComparison.OrdinalIgnoreCase))
				{
					if (decimal.TryParse(val, out var d))
					{
						cell.Value = d;
						cell.Style.NumberFormat.Format = "$#,##0.00";
					}
					else
					{
						cell.Value = val ?? "";
					}
				}
				else
				{
					cell.Value = val ?? "";
				}


				// Wrap text for long fields
				if (key is "Descriptions" or "Observation" or "Action" or "Task")
					cell.Style.Alignment.WrapText = true;

				// Center numeric fields
				if (key is "# of Denial" or "Total Balance ($)" or "Ins. Balance ($)" or "$ Impact (%)")
					cell.Style.Alignment.Horizontal = XLAlignmentHorizontalValues.Center;

				// Borders
				cell.Style.Border.OutsideBorder = XLBorderStyleValues.Thin;
			}
		}

		// Freeze header row (after title + spacing)
		ws2.SheetView.FreezeRows(headerRow);

		// Auto-fit first
		ws2.Columns().AdjustToContents();

		// Minimum width for all columns
		foreach (var col in ws2.ColumnsUsed())
		{
			if (col.Width < 12)
				col.Width = 12;
		}

		// Wider columns for long text
		void SetWidth(string header, double width)
		{
			int index = insightHeaders.IndexOf(header);
			if (index >= 0)
				ws2.Column(colOffset + index).Width = width;
		}
		// Currency formatting for money columns
		void SetCurrency(string header)
		{
			int index = insightHeaders.IndexOf(header);
			if (index >= 0)
				ws2.Column(colOffset + index).Style.NumberFormat.Format = "$#,##0.00";
		}


		SetWidth("Descriptions", 50);
		SetWidth("Observation", 40);
		SetWidth("Action Code", 100);
		SetWidth("Action", 100);
		SetWidth("Task", 50);

		// Hyperlink column
		SetWidth("Data", 12);

		// Numeric columns
		SetWidth("# of Denial", 15);
		SetWidth("Total Balance ($)", 18);
		SetWidth("Ins. Balance ($)", 18);
		SetWidth("$ Impact (%)", 15);

		// ───────────────────────────────────────────────
		//  SAVE FILE
		// ───────────────────────────────────────────────
		//
		wb.SaveAs(outputPath);
		_logger.LogInformation("Wrote Denial Database Excel with Insights: {OutputPath}", outputPath);
	}
}