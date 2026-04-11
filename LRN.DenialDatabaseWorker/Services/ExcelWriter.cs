using ClosedXML.Excel;
using Microsoft.Extensions.Logging;

public sealed class ExcelWriter
{
	private readonly BreakdownBuilder _breakdownBuilder = new();
	private readonly ILogger<ExcelWriter> _logger;

	public ExcelWriter(ILogger<ExcelWriter> logger)
	{
		_logger = logger;
	}

	public void Write(
	string outputPath,
	List<string> insightHeaders,
	List<Dictionary<string, string>> insightRows,
	List<Dictionary<string, string>> finalLineItems,
	List<Dictionary<string, string>> taskBoardRows)
	{
		try
		{
			_logger.LogInformation("ExcelWriter: Starting workbook generation → {Path}", outputPath);

			// Filter line items: only those with non-null DenialCode
			var filteredLineItems = finalLineItems
				.Where(r => !string.IsNullOrWhiteSpace(Get(r, "DenialCode")))
				.ToList();

			LogRowCounts(insightRows.Count, filteredLineItems.Count, taskBoardRows.Count);

			// Build breakdowns
			var weekly = _breakdownBuilder.BuildWeekly(filteredLineItems);
			var monthly = _breakdownBuilder.BuildMonthly(filteredLineItems);

			if (File.Exists(outputPath))
				File.Delete(outputPath);

			using var wb = new XLWorkbook();

			// -------------------- SHEET ORDER --------------------
			// 1. Insight (old formatting)
			AddInsightSheet(wb, insightHeaders, insightRows);

			// 2. Weekly Breakdown (new pivot)
			AddWeeklyBreakdownSheet(wb, weekly);

			// 3. Monthly Breakdown (new pivot)
			AddMonthlyBreakdownSheet(wb, monthly);

			// 4. TaskBoard (old formatting)
			AddTaskBoardSheet(wb, taskBoardRows, "TaskBoard");

			// 5. LineItems (minimal formatting)
			AddLineItemSheet(wb, filteredLineItems, "LineItems");

			// -------------------- SAVE WORKBOOK --------------------
			wb.SaveAs(outputPath);

			_logger.LogInformation("ExcelWriter: Workbook saved successfully → {Path}", outputPath);
		}
		catch (Exception ex)
		{
			_logger.LogError(ex, "ExcelWriter: Failed to generate workbook");
			throw;
		}
	}

	private static string Get(Dictionary<string, string> row, string key)
		=> row.TryGetValue(key, out var v) ? v ?? "" : "";

	// ---------- Logging row counts (used later for warnings) ----------

	private void LogRowCounts(int insightCount, int lineItemCount, int taskCount)
	{
		_logger.LogInformation("ExcelWriter: Insight rows = {Count}", insightCount);
		_logger.LogInformation("ExcelWriter: TaskBoard rows = {Count}", taskCount);
		_logger.LogInformation("ExcelWriter: LineItem rows (DenialCode not null) = {Count}", lineItemCount);

		if (lineItemCount > 400_000)
			_logger.LogCritical("ExcelWriter: LineItems exceed 400k rows — consider switching to CSV streaming.");
		else if (lineItemCount > 250_000)
			_logger.LogWarning("ExcelWriter: LineItems exceed 250k rows — workbook may be slow.");
		else if (lineItemCount > 150_000)
			_logger.LogInformation("ExcelWriter: Large dataset detected (150k+ rows).");
	}

	// -------------------- INSIGHT (keep old formatting style) --------------------

	private void AddInsightSheet(
		XLWorkbook wb,
		List<string> headers,
		List<Dictionary<string, string>> rows)
	{
		var ws = wb.Worksheets.Add("Insight");
		_logger.LogInformation("ExcelWriter: Writing Insight sheet ({Count} rows)", rows.Count);

		// Header
		for (int i = 0; i < headers.Count; i++)
		{
			ws.Cell(1, i + 1).Value = headers[i];
			ws.Cell(1, i + 1).Style.Font.Bold = true;
			ws.Cell(1, i + 1).Style.Fill.BackgroundColor = XLColor.LightGray;
		}

		// Rows
		int r = 2;
		foreach (var row in rows)
		{
			int c = 1;
			foreach (var h in headers)
			{
				row.TryGetValue(h, out var val);
				ws.Cell(r, c).Value = val ?? "";
				c++;
			}
			r++;
		}

		ws.SheetView.FreezeRows(1);
		ws.Columns().AdjustToContents();
	}

	// -------------------- TASK BOARD (keep old formatting style) --------------------

	private void AddTaskBoardSheet(
		XLWorkbook wb,
		List<Dictionary<string, string>> rows,
		string sheetName)
	{
		var ws = wb.Worksheets.Add(sheetName);
		_logger.LogInformation("ExcelWriter: Writing TaskBoard sheet ({Count} rows)", rows.Count);

		if (!rows.Any())
			return;

		var headers = rows.First().Keys.ToList();

		// Header
		for (int i = 0; i < headers.Count; i++)
		{
			ws.Cell(1, i + 1).Value = headers[i];
			ws.Cell(1, i + 1).Style.Font.Bold = true;
			ws.Cell(1, i + 1).Style.Fill.BackgroundColor = XLColor.LightGray;
		}

		// Rows
		int r = 2;
		foreach (var row in rows)
		{
			int c = 1;
			foreach (var h in headers)
			{
				row.TryGetValue(h, out var val);
				ws.Cell(r, c).Value = val ?? "";
				c++;
			}
			r++;
		}

		ws.SheetView.FreezeRows(1);
		ws.Columns().AdjustToContents();
	}
	// -------------------- WEEKLY BREAKDOWN --------------------

	private void AddWeeklyBreakdownSheet(XLWorkbook wb, BreakdownPivotViewModel model)
	{
		AddBreakdownSheetCore(wb, model, "WeeklyBreakdown");
	}

	// -------------------- MONTHLY BREAKDOWN --------------------

	private void AddMonthlyBreakdownSheet(XLWorkbook wb, BreakdownPivotViewModel model)
	{
		AddBreakdownSheetCore(wb, model, "MonthlyBreakdown");
	}

	// -------------------- CORE BREAKDOWN SHEET RENDERER --------------------

	private void AddBreakdownSheetCore(
		XLWorkbook wb,
		BreakdownPivotViewModel model,
		string sheetName)
	{
		var ws = wb.Worksheets.Add(sheetName);
		_logger.LogInformation("ExcelWriter: Writing {Sheet} ({Count} rows)", sheetName, model.Rows.Count);

		int row = 1;

		// -------------------- ROW 1: MERGED HEADER --------------------
		int totalColumns = model.Periods.Count * 2 + 2; // 2 per period + Total Claims + Total Bal

		ws.Cell(row, 1).Value = model.HeaderTitle;
		ws.Range(row, 1, row, totalColumns).Merge();
		ws.Range(row, 1, row, totalColumns).Style.Font.Bold = true;
		ws.Range(row, 1, row, totalColumns).Style.Alignment.Horizontal = XLAlignmentHorizontalValues.Center;
		ws.Range(row, 1, row, totalColumns).Style.Fill.BackgroundColor = XLColor.LightGray;

		row += 2;

		// -------------------- ROW 2: PERIOD HEADERS --------------------
		int col = 2; // Column 1 is Insurance/Denial label

		foreach (var p in model.Periods)
		{
			ws.Cell(row, col).Value = p.Label;
			ws.Range(row, col, row, col + 1).Merge();
			ws.Range(row, col, row, col + 1).Style.Font.Bold = true;
			ws.Range(row, col, row, col + 1).Style.Alignment.Horizontal = XLAlignmentHorizontalValues.Center;
			ws.Range(row, col, row, col + 1).Style.Fill.BackgroundColor = XLColor.LightGray;

			col += 2;
		}

		// Total column header
		ws.Cell(row, col).Value = "Total";
		ws.Range(row, col, row, col + 1).Merge();
		ws.Range(row, col, row, col + 1).Style.Font.Bold = true;
		ws.Range(row, col, row, col + 1).Style.Alignment.Horizontal = XLAlignmentHorizontalValues.Center;
		ws.Range(row, col, row, col + 1).Style.Fill.BackgroundColor = XLColor.LightGray;

		row++;

		// -------------------- ROW 3: SUBHEADERS --------------------
		ws.Cell(row, 1).Value = "Insurance / Denial";
		ws.Cell(row, 1).Style.Font.Bold = true;
		ws.Cell(row, 1).Style.Fill.BackgroundColor = XLColor.LightGray;

		col = 2;

		foreach (var p in model.Periods)
		{
			ws.Cell(row, col).Value = "No. of Claims";
			ws.Cell(row, col + 1).Value = "Denial Bal";

			ws.Cell(row, col).Style.Font.Bold = true;
			ws.Cell(row, col + 1).Style.Font.Bold = true;

			ws.Cell(row, col).Style.Fill.BackgroundColor = XLColor.LightGray;
			ws.Cell(row, col + 1).Style.Fill.BackgroundColor = XLColor.LightGray;

			col += 2;
		}

		ws.Cell(row, col).Value = "Total Claims";
		ws.Cell(row, col + 1).Value = "Total Bal";

		ws.Cell(row, col).Style.Font.Bold = true;
		ws.Cell(row, col + 1).Style.Font.Bold = true;

		ws.Cell(row, col).Style.Fill.BackgroundColor = XLColor.LightGray;
		ws.Cell(row, col + 1).Style.Fill.BackgroundColor = XLColor.LightGray;

		row++;

		// -------------------- BODY ROWS --------------------
		foreach (var r in model.Rows)
		{
			col = 1;

			ws.Cell(row, col).Value = r.Label;
			if (r.IsInsuranceRow)
				ws.Cell(row, col).Style.Font.Bold = true;

			col++;

			foreach (var cell in r.Cells)
			{
				ws.Cell(row, col).Value = cell.ClaimCount;
				ws.Cell(row, col + 1).Value = cell.DenialBalance;
				ws.Cell(row, col + 1).Style.NumberFormat.Format = "$#,##0.00";

				col += 2;
			}

			ws.Cell(row, col).Value = r.TotalClaimCount;
			ws.Cell(row, col + 1).Value = r.TotalBalance;
			ws.Cell(row, col + 1).Style.NumberFormat.Format = "$#,##0.00";

			row++;
		}

		// -------------------- TOTALS ROW --------------------
		col = 1;
		ws.Cell(row, col).Value = "TOTAL";
		ws.Cell(row, col).Style.Font.Bold = true;

		col++;

		foreach (var t in model.TotalsByPeriod)
		{
			ws.Cell(row, col).Value = t.ClaimCount;
			ws.Cell(row, col + 1).Value = t.DenialBalance;
			ws.Cell(row, col + 1).Style.NumberFormat.Format = "$#,##0.00";

			col += 2;
		}

		ws.Cell(row, col).Value = model.GrandTotalClaimCount;
		ws.Cell(row, col + 1).Value = model.GrandTotalBalance;
		ws.Cell(row, col + 1).Style.NumberFormat.Format = "$#,##0.00";

		ws.Range(row, 1, row, col + 1).Style.Font.Bold = true;
		ws.Range(row, 1, row, col + 1).Style.Fill.BackgroundColor = XLColor.LightGray;

		// -------------------- FREEZE PANES --------------------
		ws.SheetView.FreezeRows(3);

		// -------------------- SHEET PROTECTION (Option A) --------------------
		//ws.Protect().
		//	.SelectLockedCells = true
		//	.SelectUnlockedCells = true
		//	.Sort = true
		//	.AutoFilter = true;

		// -------------------- AUTO-FIT (safe for small sheets) --------------------
		ws.Columns().AdjustToContents();
	}

	// -------------------- LINE ITEMS (minimal formatting for performance) --------------------

	private void AddLineItemSheet(
		XLWorkbook wb,
		List<Dictionary<string, string>> rows,
		string sheetName)
	{
		var ws = wb.Worksheets.Add(sheetName);
		_logger.LogInformation("ExcelWriter: Writing LineItems sheet ({Count} rows)", rows.Count);

		if (!rows.Any())
			return;

		var headers = rows.First().Keys.ToList();

		// Header row (minimal formatting)
		for (int i = 0; i < headers.Count; i++)
		{
			ws.Cell(1, i + 1).Value = headers[i];
			ws.Cell(1, i + 1).Style.Font.Bold = true;
		}

		// Data rows (no formatting for speed)
		int r = 2;
		foreach (var row in rows)
		{
			int c = 1;
			foreach (var h in headers)
			{
				row.TryGetValue(h, out var val);
				ws.Cell(r, c).Value = val ?? "";
				c++;
			}
			r++;
		}

		// Freeze header row
		ws.SheetView.FreezeRows(1);

		// DO NOT auto-fit columns — too slow for 200k rows
		// DO NOT apply borders — too slow
		// DO NOT apply background colors — too slow
		// DO NOT apply number formatting — too slow
	}
}