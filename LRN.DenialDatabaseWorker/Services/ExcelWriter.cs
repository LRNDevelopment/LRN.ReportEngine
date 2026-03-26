using ClosedXML.Excel;

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

		using var wb = new XLWorkbook();

		// SHEET 1: DENIAL DATABASE
		var ws1 = wb.AddWorksheet("Denial Database");

		for (int c = 0; c < effectiveLineHeaders.Count; c++)
		{
			var cell = ws1.Cell(1, c + 1);
			cell.Value = effectiveLineHeaders[c];

			cell.Style.Font.Bold = true;
			cell.Style.Font.FontColor = XLColor.White;
			cell.Style.Fill.BackgroundColor = XLColor.FromHtml("#1F4E78");
			cell.Style.Alignment.Horizontal = XLAlignmentHorizontalValues.Center;
			cell.Style.Alignment.Vertical = XLAlignmentVerticalValues.Center;
			cell.Style.Border.OutsideBorder = XLBorderStyleValues.Thin;
		}

		ws1.SheetView.FreezeRows(1);

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

		var dataRange = ws1.Range(2, 1, lineRows.Count + 1, effectiveLineHeaders.Count);

		for (int r = 0; r < lineRows.Count; r++)
		{
			bool isEven = ((r + 1) % 2 == 0);
			var rowRange = dataRange.Row(r + 1);
			rowRange.Style.Fill.BackgroundColor = isEven
				? XLColor.FromHtml("#D9E1F2")
				: XLColor.White;
		}

		string[] wrapColumns =
		{
			"Denial Description","Coverage Status",
			"Covered ICD 10 codes as per Payer Policy",
			"Non Covered ICD 10 Codes as per Payer Policy",
			"Action Comment","Coding Validation Sub-Status",
			"Recommended Action","Notes / Comments"
		};

		string[] dateColumns =
		{
			"First Billed Date",
			"Expected Payment Date",
			"Date of Service",
			"Claim Received Date",
			"Last Payment Date"
		};

		string[] moneyColumns =
		{
			"Billed Amount","Allowed Amount","Insurance Payment","Insurance Adjustment",
			"Patient Paid Amount","Patient Adjustment","Insurance Balance","Patient Balance",
			"Total Balance","Medicare Fee","Expected Average Allowed Amount",
			"Expected Average Insurance Payment","Expected Allowed Amount - Same Lab",
			"Expected Insurance Payment - Same Lab","Mode Allowed Amount - Same Lab",
			"Mode Insurance Paid - Same Lab","Mode Allowed Amount- Peer",
			"Mode Insurance Paid- Peer","Median Allowed Amount- Same Lab",
			"Median Insurance Paid - Same Lab","Median Allowed Amount- Peer",
			"Median, Insurance Paid - Peer","Mode Allowed Amount Difference",
			"Mode Insurance Paid Difference","Median Allowed Amount Difference",
			"Median Insurance Paid Difference"
		};

		for (int c = 0; c < effectiveLineHeaders.Count; c++)
		{
			var header = effectiveLineHeaders[c];
			var col = ws1.Column(c + 1);

			if (wrapColumns.Contains(header))
				col.Style.Alignment.WrapText = true;

			if (dateColumns.Contains(header))
				col.Style.NumberFormat.Format = "yyyy-mm-dd";

			if (moneyColumns.Contains(header))
				col.Style.NumberFormat.Format = "$#,##0.00";
		}

		dataRange.Style.Border.OutsideBorder = XLBorderStyleValues.Thin;
		dataRange.Style.Border.InsideBorder = XLBorderStyleValues.Thin;

		for (int c = 0; c < effectiveLineHeaders.Count; c++)
		{
			var header = effectiveLineHeaders[c];
			if (hiddenHeaders.Contains(header.Trim()))
				ws1.Column(c + 1).Hide();
		}

		ws1.Columns().AdjustToContents();

		void SetWidth(string header, double width)
		{
			int index = effectiveLineHeaders.IndexOf(header);
			if (index >= 0)
				ws1.Column(index + 1).Width = width;
		}

		SetWidth("Denial Description", 40);
		SetWidth("Coverage Status", 25);
		SetWidth("Covered ICD 10 codes as per Payer Policy", 45);
		SetWidth("Non Covered ICD 10 Codes as per Payer Policy", 45);
		SetWidth("Action Comment", 40);
		SetWidth("Coding Validation Sub-Status", 30);
		SetWidth("Recommended Action", 45);
		SetWidth("Notes / Comments", 45);

		var tableRange = ws1.Range(1, 1, lineRows.Count + 1, effectiveLineHeaders.Count);
		var table = tableRange.CreateTable();
		table.Theme = XLTableTheme.TableStyleMedium2;

		foreach (var colName in effectiveLineHeaders)
		{
			int colIndex = effectiveLineHeaders.IndexOf(colName);
			if (colIndex < 0) continue;

			if (colName.Contains("Amount", StringComparison.OrdinalIgnoreCase) ||
				colName.Contains("Balance", StringComparison.OrdinalIgnoreCase) ||
				colName.Contains("Payment", StringComparison.OrdinalIgnoreCase) ||
				colName.Contains("Fee", StringComparison.OrdinalIgnoreCase))
			{
				var col = ws1.Column(colIndex + 1);
				col.AddConditionalFormat()
					.WhenLessThan(0)
					.Fill.SetBackgroundColor(XLColor.LightPink);
			}
		}

		int priorityIndex = effectiveLineHeaders.IndexOf("Priority");
		if (priorityIndex >= 0)
		{
			var col = ws1.Column(priorityIndex + 1);

			col.AddConditionalFormat()
				.WhenContains("High")
				.Fill.SetBackgroundColor(XLColor.FromHtml("#FF9999"));

			col.AddConditionalFormat()
				.WhenContains("Medium")
				.Fill.SetBackgroundColor(XLColor.FromHtml("#FFD580"));

			col.AddConditionalFormat()
				.WhenContains("Low")
				.Fill.SetBackgroundColor(XLColor.FromHtml("#C6EFCE"));
		}

		// SHEET 2: DENIAL INSIGHTS
		var ws2 = wb.AddWorksheet("Denial Insights");

		int rowOffset = 3;
		int colOffset = 2;

		var titleCell = ws2.Cell(rowOffset, colOffset);
		titleCell.Value = "Denial Insights Summary";

		ws2.Range(rowOffset, colOffset, rowOffset, colOffset + insightHeaders.Count - 1).Merge();

		titleCell.Style.Font.Bold = true;
		titleCell.Style.Font.FontColor = XLColor.White;
		titleCell.Style.Font.FontSize = 18;
		titleCell.Style.Alignment.Horizontal = XLAlignmentHorizontalValues.Center;
		titleCell.Style.Fill.BackgroundColor = XLColor.FromHtml("#1E3D2F");
		titleCell.Style.Border.BottomBorder = XLBorderStyleValues.Thick;

		int headerRow = rowOffset + 2;

		for (int c = 0; c < insightHeaders.Count; c++)
		{
			var cell = ws2.Cell(headerRow, colOffset + c);
			cell.Value = insightHeaders[c];

			cell.Style.Font.Bold = true;
			cell.Style.Font.FontColor = XLColor.White;
			cell.Style.Fill.BackgroundColor = XLColor.FromHtml("#6B8E23");
			cell.Style.Alignment.Horizontal = XLAlignmentHorizontalValues.Center;
			cell.Style.Border.OutsideBorder = XLBorderStyleValues.Thin;
		}

		for (int r = 0; r < insightRows.Count; r++)
		{
			var row = insightRows[r];
			bool isEven = (r % 2 == 0);

			for (int c = 0; c < insightHeaders.Count; c++)
			{
				var key = insightHeaders[c];
				row.TryGetValue(key, out var val);

				var cell = ws2.Cell(headerRow + 1 + r, colOffset + c);

				cell.Style.Fill.BackgroundColor = isEven
					? XLColor.FromHtml("#E8F5E9")
					: XLColor.White;

				if (key.Equals("Data", StringComparison.OrdinalIgnoreCase))
				{
					cell.Value = "Link";
					cell.SetHyperlink(new XLHyperlink("'Denial Database'!A1"));
					cell.Style.Font.FontColor = XLColor.Blue;
					cell.Style.Font.Underline = XLFontUnderlineValues.Single;
				}
				else if (key.Contains("Balance") && decimal.TryParse(val, out var d))
				{
					cell.Value = d;
					cell.Style.NumberFormat.Format = "$#,##0.00";
				}
				else
				{
					cell.Value = val ?? "";
				}

				if (key is "Descriptions" or "Observation" or "Action" or "Task")
					cell.Style.Alignment.WrapText = true;

				cell.Style.Border.OutsideBorder = XLBorderStyleValues.Thin;
			}
		}

		var insightsTableRange = ws2.Range(
			headerRow,
			colOffset,
			headerRow + insightRows.Count,
			colOffset + insightHeaders.Count - 1);

		var insightsTable = insightsTableRange.CreateTable();
		insightsTable.Theme = XLTableTheme.TableStyleMedium9;

		void SetInsightWidth(string header, double width)
		{
			int index = insightHeaders.IndexOf(header);
			if (index >= 0)
				ws2.Column(colOffset + index).Width = width;
		}

		SetInsightWidth("Descriptions", 45);
		SetInsightWidth("Observation", 35);
		SetInsightWidth("Action Code", 25);
		SetInsightWidth("Action", 40);
		SetInsightWidth("Task", 30);
		SetInsightWidth("Data", 12);
		SetInsightWidth("# of Denial", 15);
		SetInsightWidth("# of Claims", 15);
		SetInsightWidth("Total Balance ($)", 18);
		SetInsightWidth("Ins. Balance ($)", 18);
		SetInsightWidth("$ Impact (%)", 15);

		ws2.SheetView.FreezeRows(headerRow);

		// SHEET 3: TASK BOARD
		var ws3 = wb.AddWorksheet("Task Board");

		var taskHeaders = new List<string>
		{
			"Task ID","Claim ID","Patient / Acct #","CPT Code","Denial Code",
			"Denial Description","Denial Classification","Action Code",
			"Recommended Action","Task","Action Category","Priority",
			"SLA (Days)","Assigned To","Status","Date Opened","Due Date",
			"Date Completed","Days Remaining","SLA Status",
			"LabId","LabName","RunId","CreatedOn","UniqueTrackId"
		};

		for (int c = 0; c < taskHeaders.Count; c++)
		{
			var cell = ws3.Cell(1, c + 1);
			cell.Value = taskHeaders[c];

			cell.Style.Font.Bold = true;
			cell.Style.Font.FontColor = XLColor.White;
			cell.Style.Fill.BackgroundColor = XLColor.FromHtml("#34495E");
			cell.Style.Alignment.Horizontal = XLAlignmentHorizontalValues.Center;
			cell.Style.Border.OutsideBorder = XLBorderStyleValues.Thin;
		}

		for (int r = 0; r < taskRows.Count; r++)
		{
			var row = taskRows[r];
			bool isEven = (r % 2 == 0);

			for (int c = 0; c < taskHeaders.Count; c++)
			{
				var key = taskHeaders[c];
				row.TryGetValue(key, out var val);

				var cell = ws3.Cell(r + 2, c + 1);
				cell.Value = val ?? "";

				cell.Style.Fill.BackgroundColor = isEven
					? XLColor.FromHtml("#ECF0F1")
					: XLColor.White;

				if (key is "Recommended Action" or "Task")
					cell.Style.Alignment.WrapText = true;

				if (key is "Date Opened" or "Due Date" or "Date Completed" or "CreatedOn")
				{
					if (DateTime.TryParse(val, out var dt))
					{
						cell.Value = dt;
						cell.Style.NumberFormat.Format = "yyyy-MM-dd";
					}
				}

				cell.Style.Border.OutsideBorder = XLBorderStyleValues.Thin;
			}
		}

		var taskTableRange = ws3.Range(1, 1, taskRows.Count + 1, taskHeaders.Count);
		var taskTable = taskTableRange.CreateTable();
		taskTable.Theme = XLTableTheme.TableStyleMedium4;

		ws3.SheetView.FreezeRows(1);
		ws3.Columns().AdjustToContents();

		wb.SaveAs(outputPath);
		_logger.LogInformation("Wrote Denial Database Excel with Insights and Task Board: {OutputPath}", outputPath);
	}
}