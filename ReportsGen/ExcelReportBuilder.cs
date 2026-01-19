using ClosedXML.Excel;
using System.Data;
using System.Data.SqlClient;
using System.Globalization;

namespace ReportsGen
{
    public class ExcelReportBuilder
    {

        // ---------------- COLORS ----------------
        private static readonly XLColor DarkGreen = XLColor.FromHtml("#375623");
        private static readonly XLColor HeaderGrey = XLColor.FromHtml("#D0CECE");
        private static readonly XLColor ChildGrey = XLColor.FromHtml("#E7E6E6");
        private static readonly XLColor BorderGrey = XLColor.FromHtml("#B7B7B7");

        private static readonly XLColor TabRed = XLColor.FromHtml("#C00000");
        private static readonly XLColor TabOrange = XLColor.FromHtml("#ED7D31");
        private static readonly XLColor TabYellow = XLColor.FromHtml("#FFC000");

        private const string MONEY_FMT =
            "_($* #,##0.00_);_($* (#,##0.00);_($* \"-\"??_);_(@_)";

        // ==========================================================
        // BUILD
        // ==========================================================
        public void Build(
            string outputPath,
            DataTable claimData,
            DataTable lineData,
            DataTable monthly,
            DataTable weekly,
            DataTable top5,
            DataTable avgPayments,
            DataTable aging,
            string templatePath,
            string referenceLayoutPath)
        {
            using var wb = new XLWorkbook();

            BuildMonthlyInsightsSheet(wb, monthly);
            BuildWeeklyInsightsSheet(wb, weekly);
            BuildTop5InsightsSheet(wb, top5);
            BuildAveragePaymentsSheet(wb, avgPayments);
            BuildAgingInsightsSheet(wb, aging);

            BuildMasterSheet(wb, "Master Claim level", claimData);
            BuildMasterSheet(wb, "Master Line Level", lineData);

            CopyInsightsTemplate(wb, templatePath);
            ApplyReferenceColumnWidths(wb, referenceLayoutPath);

            string directory = Path.GetDirectoryName(outputPath);
            if (!string.IsNullOrEmpty(directory) && !Directory.Exists(directory))
            {
                Directory.CreateDirectory(directory);
            }

            wb.SaveAs(outputPath);
        }

        // ==========================================================
        // MASTER SHEETS
        // ==========================================================
        private void BuildMasterSheet(XLWorkbook wb, string name, DataTable dt)
        {
            var ws = wb.Worksheets.Add(name);
            ws.TabColor = TabOrange;

            if (dt.Rows.Count > 0)
            {
                var table = ws.Cell(1, 1).InsertTable(dt, true);
                FormatTableHeaders(table);
                ApplyBorders(table.AsRange());
                table.ShowAutoFilter = true;
            }
            else
            {
                for (int i = 0; i < dt.Columns.Count; i++)
                {
                    ws.Cell(1, i + 1).Value = dt.Columns[i].ColumnName;
                }
                FormatTableHeaders(ws.Row(1));
            }

            ws.SheetView.FreezeRows(1);
            ws.ShowGridLines = false;
            ws.Columns().AdjustToContents();
        }

        // ==========================================================
        // MONTHLY
        // ==========================================================
        private void BuildMonthlyInsightsSheet(XLWorkbook wb, DataTable dt)
        {
            var ws = wb.Worksheets.Add("Monthly Insights");
            ws.TabColor = TabYellow;
            ws.ShowGridLines = false;

            if (dt.Rows.Count > 0)
            {
                int lastCol = 1 + dt.Columns.Count;
                var title = ws.Range(2, 2, 2, lastCol);
                title.Merge().Value = "Panel & Top 3 Insurances | Payment Deposited Date";
                StyleTitle(title);

                var table = ws.Cell(4, 2).InsertTable(dt, true);
                FormatTableHeaders(table);
                ApplyMoneyFormat(ws, dt, 4, 2);
                ApplyOutlineGrouping(ws, 4, 2);
                ApplyBorders(table.AsRange());
                ws.SheetView.FreezeRows(4);
            }
        }

        // ==========================================================
        // WEEKLY - Made public
        // ==========================================================
        public void BuildWeeklyInsightsSheet(XLWorkbook wb, DataTable dt)
        {
            var ws = wb.Worksheets.Add("Weekly Insights");
            ws.TabColor = TabYellow;
            ws.ShowGridLines = false;

            var titleRange = ws.Range("B2:H2");
            titleRange.Merge().Value = "Last 4 Weeks Collection | Weekly Breakdown | Payment Deposited Date";
            StyleTitle(titleRange);

            if (dt.Rows.Count > 0)
            {
                var table = ws.Cell(4, 2).InsertTable(dt, true);
                FormatTableHeaders(table);
                ApplyMoneyFormat(ws, dt, 4, 2);
                ApplyBorders(table.AsRange());
            }

            ws.SheetView.FreezeRows(4);
        }

        // ==========================================================
        // TOP 5 - Made public
        // ==========================================================
        public void BuildTop5InsightsSheet(XLWorkbook wb, DataTable dt)
        {
            var ws = wb.Worksheets.Add("Top 5 Insights");
            ws.TabColor = TabYellow;
            ws.ShowGridLines = false;

            var titleRange = ws.Range("B2:F2");
            titleRange.Merge().Value = "Top 5 Insurance | Reimbursement Percentage Vs Billed Charges";
            StyleTitle(titleRange);

            if (dt.Rows.Count > 0)
            {
                var table = ws.Cell(4, 2).InsertTable(dt, true);
                FormatTableHeaders(table);
                ApplyMoneyFormat(ws, dt, 4, 2);
                ApplyBorders(table.AsRange());
            }

            ws.SheetView.FreezeRows(4);
        }

        // ==========================================================
        // AVERAGE PAYMENTS - Made public
        // ==========================================================
        public void BuildAveragePaymentsSheet(XLWorkbook wb, DataTable dt)
        {
            var ws = wb.Worksheets.Add("Average Payments Insights");
            ws.TabColor = TabYellow;
            ws.ShowGridLines = false;

            var titleRange = ws.Range("B2:R2");
            titleRange.Merge().Value = "Average Payments - Per Panel | Last 6 Months | Based On Date of Service";
            StyleTitle(titleRange);

            if (dt.Rows.Count > 0)
            {
                var table = ws.Cell(4, 2).InsertTable(dt, true);
                FormatTableHeaders(table);
                ApplyMoneyFormat(ws, dt, 4, 2);
                ApplyBorders(table.AsRange());
            }

            ws.SheetView.FreezeRows(4);
        }

        // ==========================================================
        // AGING - Made public
        // ==========================================================
        public void BuildAgingInsightsSheet(XLWorkbook wb, DataTable dt)
        {
            var ws = wb.Worksheets.Add("Aging Insights");
            ws.TabColor = TabYellow;
            ws.ShowGridLines = false;

            var titleRange = ws.Range("B2:F2");
            titleRange.Merge().Value = "Insurance Aging Summary";
            StyleTitle(titleRange);

            if (dt.Rows.Count > 0)
            {
                var table = ws.Cell(4, 2).InsertTable(dt, true);
                FormatTableHeaders(table);
                ApplyMoneyFormat(ws, dt, 4, 2);
                ApplyBorders(table.AsRange());
            }

            ws.SheetView.FreezeRows(4);
        }

        // ==========================================================
        // TEMPLATE COPY
        // ==========================================================
        private void CopyInsightsTemplate(XLWorkbook wb, string templatePath)
        {
            if (!File.Exists(templatePath))
            {
                Console.WriteLine($"Template file not found: {templatePath}");
                return;
            }

            try
            {
                using var tpl = new XLWorkbook(templatePath);
                var sourceWorksheet = tpl.Worksheet(1);

                if (wb.Worksheets.Contains("Insights"))
                {
                    wb.Worksheets.Delete("Insights");
                }

                sourceWorksheet.CopyTo(wb, "Insights");
                var ws = wb.Worksheet("Insights");
                ws.TabColor = TabRed;

                // Check if cells exist in the range
                var range = ws.Range("A1:AF8");
                if (range.FirstCell().Address.RowNumber <= range.LastCell().Address.RowNumber)
                {
                    range.Style.Fill.BackgroundColor = ChildGrey;
                }

                ws.ShowGridLines = false;
            }
            catch (Exception ex)
            {
                Console.WriteLine($"Error copying template: {ex.Message}");
            }
        }

        // ==========================================================
        // COLUMN WIDTH COPY
        // ==========================================================
        private void ApplyReferenceColumnWidths(XLWorkbook wb, string refFile)
        {
            if (!File.Exists(refFile))
            {
                Console.WriteLine($"Reference layout file not found: {refFile}");
                return;
            }

            try
            {
                using var refWb = new XLWorkbook(refFile);

                foreach (var ws in wb.Worksheets)
                {
                    if (!refWb.Worksheets.Contains(ws.Name)) continue;

                    var refWs = refWb.Worksheet(ws.Name);
                    foreach (var col in refWs.ColumnsUsed())
                    {
                        ws.Column(col.ColumnNumber()).Width = col.Width;
                    }
                }
            }
            catch (Exception ex)
            {
                Console.WriteLine($"Error applying column widths: {ex.Message}");
            }
        }

        // ==========================================================
        // HELPERS
        // ==========================================================
        private void StyleTitle(IXLRange r)
        {
            r.Style.Fill.BackgroundColor = DarkGreen;
            r.Style.Font.Bold = true;
            r.Style.Font.FontColor = XLColor.White;
            r.Style.Alignment.Horizontal = XLAlignmentHorizontalValues.Center;
            r.Style.Alignment.Vertical = XLAlignmentVerticalValues.Center;
            r.Style.Border.OutsideBorder = XLBorderStyleValues.Thin;
            r.Style.Border.OutsideBorderColor = BorderGrey;
        }

        private void FormatTableHeaders(IXLTable table)
        {
            var headerRow = table.HeadersRow().WorksheetRow();
            FormatTableHeaders(headerRow);
        }

        private void FormatTableHeaders(IXLRow headerRow)
        {
            headerRow.Height = 18;
            headerRow.Style.Fill.BackgroundColor = HeaderGrey;
            headerRow.Style.Font.Bold = true;
            headerRow.Style.Alignment.Horizontal = XLAlignmentHorizontalValues.Center;
            headerRow.Style.Alignment.Vertical = XLAlignmentVerticalValues.Center;
        }

        private void ApplyBorders(IXLRange range)
        {
            range.Style.Border.OutsideBorder = XLBorderStyleValues.Medium;
            range.Style.Border.InsideBorder = XLBorderStyleValues.Thin;
            range.Style.Border.OutsideBorderColor = BorderGrey;
            range.Style.Border.InsideBorderColor = BorderGrey;
        }

        private void ApplyMoneyFormat(IXLWorksheet ws, DataTable dt, int sr, int sc)
        {
            for (int i = 0; i < dt.Columns.Count; i++)
            {
                string columnName = dt.Columns[i].ColumnName.ToUpper();
                if (columnName.Contains("PAID") || columnName.Contains("PAYMENT") ||
                    columnName.Contains("TOTAL") || columnName.Contains("AVG") ||
                    columnName.Contains("AMOUNT") || columnName.Contains("CHARGE") ||
                    columnName.Contains("BALANCE"))
                {
                    ws.Range(sr + 1, sc + i, sr + dt.Rows.Count, sc + i)
                        .Style.NumberFormat.Format = MONEY_FMT;
                }
                else if (dt.Columns[i].DataType == typeof(decimal) ||
                        dt.Columns[i].DataType == typeof(double) ||
                        dt.Columns[i].DataType == typeof(float))
                {
                    ws.Range(sr + 1, sc + i, sr + dt.Rows.Count, sc + i)
                        .Style.NumberFormat.Format = MONEY_FMT;
                }
            }
        }

        private void ApplyOutlineGrouping(IXLWorksheet ws, int startRow, int panelCol)
        {
            string prev = null;
            int groupStart = startRow + 1;

            for (int r = startRow + 1; r <= ws.LastRowUsed().RowNumber(); r++)
            {
                var val = ws.Cell(r, panelCol).GetString();
                if (val != prev && prev != null)
                {
                    if (r - groupStart > 0)
                    {
                        ws.Rows(groupStart, r - 1).Group();
                    }
                    groupStart = r;
                }
                prev = val;
            }

            if (ws.LastRowUsed().RowNumber() - groupStart > 0)
            {
                ws.Rows(groupStart, ws.LastRowUsed().RowNumber()).Group();
            }
        }

        // ================= UTILITY METHODS =================
        private static decimal GetDecimalValue(object value)
        {
            if (value == null || value == DBNull.Value)
                return 0m;

            if (value is decimal)
                return (decimal)value;

            if (value is int)
                return (decimal)(int)value;

            if (value is double)
                return (decimal)(double)value;

            if (value is float)
                return (decimal)(float)value;

            decimal result;
            if (decimal.TryParse(value.ToString(), NumberStyles.Any, CultureInfo.InvariantCulture, out result))
                return result;

            return 0m;
        }

        // ================= DATA LOADING METHODS =================
        public static DataTable LoadClaimData()
        {
            const string connectionString = "Server=ASKS\\MYDEV;Database=PCRCO_LRN;User Id=sa;Password=qwerty;Encrypt=True;TrustServerCertificate=True;Connect Timeout=120;";
            var dt = new DataTable();

            try
            {
                using (var conn = new SqlConnection(connectionString))
                {
                    conn.Open();
                    using (var cmd = new SqlCommand("EXEC dbo.sp_GetProductionReportMaster", conn))
                    {
                        cmd.CommandTimeout = 180;

                        using (var reader = cmd.ExecuteReader())
                        {
                            dt.Load(reader);
                        }
                    }
                }

                // Clean column names
                foreach (DataColumn column in dt.Columns)
                {
                    column.ColumnName = column.ColumnName?.Trim() ?? "";
                }

                // Ensure PanelName exists
                if (!dt.Columns.Contains("PanelName") && dt.Columns.Contains("PanelGroup"))
                {
                    dt.Columns.Add("PanelName", typeof(string));
                    foreach (DataRow row in dt.Rows)
                    {
                        row["PanelName"] = row["PanelGroup"]?.ToString()?.Trim() ?? "";
                    }
                }

                // Convert numeric columns safely
                ConvertColumnToDecimalSafe(dt, "CarrierPayment");
                ConvertColumnToDecimalSafe(dt, "TotalCharge");
                ConvertColumnToDecimalSafe(dt, "CarrierBalance");

                // Add Payment Percentage
                if (dt.Columns.Contains("CarrierPayment") && dt.Columns.Contains("TotalCharge"))
                {
                    dt.Columns.Add("PaymentPercent", typeof(decimal));
                    foreach (DataRow row in dt.Rows)
                    {
                        var payment = GetDecimalValue(row["CarrierPayment"]);
                        var charge = GetDecimalValue(row["TotalCharge"]);
                        row["PaymentPercent"] = charge != 0 ? payment / charge : 0;
                    }
                }
            }
            catch (Exception ex)
            {
                Console.WriteLine($"Error loading claim data: {ex.Message}");
                throw;
            }

            return dt;
        }

        public static DataTable LoadLineData()
        {
            const string connectionString = "Server=ASKS\\MYDEV;Database=PCRCO_LRN;User Id=sa;Password=qwerty;Encrypt=True;TrustServerCertificate=True;Connect Timeout=120;";
            var dt = new DataTable();

            try
            {
                using (var conn = new SqlConnection(connectionString))
                {
                    conn.Open();
                    using (var cmd = new SqlCommand("EXEC dbo.sp_GetProductionLineLevelReport", conn))
                    {
                        cmd.CommandTimeout = 180;

                        using (var reader = cmd.ExecuteReader())
                        {
                            dt.Load(reader);
                        }
                    }
                }

                // Clean column names
                foreach (DataColumn column in dt.Columns)
                {
                    column.ColumnName = column.ColumnName?.Trim() ?? "";
                }

                // Convert numeric columns safely
                ConvertColumnToDecimalSafe(dt, "InsurancePayment");
                ConvertColumnToDecimalSafe(dt, "BilledAmount");

                // Add Payment Percentage
                if (dt.Columns.Contains("InsurancePayment") && dt.Columns.Contains("BilledAmount"))
                {
                    dt.Columns.Add("PaymentPercent", typeof(decimal));
                    foreach (DataRow row in dt.Rows)
                    {
                        var payment = GetDecimalValue(row["InsurancePayment"]);
                        var billed = GetDecimalValue(row["BilledAmount"]);
                        row["PaymentPercent"] = billed != 0 ? payment / billed : 0;
                    }
                }
            }
            catch (Exception ex)
            {
                Console.WriteLine($"Error loading line data: {ex.Message}");
                throw;
            }

            return dt;
        }

        // ================= INSIGHTS BUILDING METHODS =================
        public static DataTable BuildMonthlyInsights(DataTable dt)
        {
            var result = new DataTable();
            result.Columns.Add("PanelName", typeof(string));
            result.Columns.Add("Month", typeof(string));
            result.Columns.Add("NoOfClaims", typeof(int));
            result.Columns.Add("TotalPaid", typeof(decimal));

            try
            {
                // Filter for paid claims
                var paidClaims = dt.AsEnumerable()
                    .Where(r =>
                    {
                        var status = r.Field<string>("FinalStatus") ?? "";
                        return status.Trim().Equals("Fully Paid", StringComparison.OrdinalIgnoreCase) ||
                               status.Trim().Equals("Partially Paid", StringComparison.OrdinalIgnoreCase);
                    });

                var rows = paidClaims
                    .Where(r => !r.IsNull("PanelName"))
                    .Select(r => new
                    {
                        Panel = r.Field<string>("PanelName")?.Trim() ?? "Unknown",
                        CheckDateStr = r["CheckDate"]?.ToString()?.Trim() ?? "",
                        VisitNumber = r.Field<string>("VisitNumber") ?? "",
                        CarrierPayment = GetDecimalValue(r["CarrierPayment"])
                    })
                    .Where(r => !string.IsNullOrEmpty(r.CheckDateStr))
                    .Select(r => new
                    {
                        r.Panel,
                        Date = ParseDate(r.CheckDateStr),
                        r.VisitNumber,
                        r.CarrierPayment
                    })
                    .Where(r => r.Date.HasValue)
                    .GroupBy(r => new
                    {
                        Panel = r.Panel,
                        Month = r.Date.Value.ToString("MMM-yyyy", CultureInfo.InvariantCulture)
                    })
                    .Select(g => new
                    {
                        g.Key.Panel,
                        g.Key.Month,
                        Claims = g.Select(x => x.VisitNumber).Distinct().Count(),
                        Paid = g.Sum(x => x.CarrierPayment)
                    });

                foreach (var r in rows)
                    result.Rows.Add(r.Panel, r.Month, r.Claims, r.Paid);
            }
            catch (Exception ex)
            {
                Console.WriteLine($"Error in BuildMonthlyInsights: {ex.Message}");
            }

            return result;
        }

        public static DataTable BuildWeeklyInsights(DataTable dt)
        {
            var result = new DataTable();
            result.Columns.Add("PanelName", typeof(string));
            result.Columns.Add("Week", typeof(string));
            result.Columns.Add("NoOfClaims", typeof(int));
            result.Columns.Add("TotalPaid", typeof(decimal));

            try
            {
                // Filter for paid claims
                var paidClaims = dt.AsEnumerable()
                    .Where(r =>
                    {
                        var status = r.Field<string>("FinalStatus") ?? "";
                        return status.Trim().Equals("Fully Paid", StringComparison.OrdinalIgnoreCase) ||
                               status.Trim().Equals("Partially Paid", StringComparison.OrdinalIgnoreCase);
                    });

                // Parse dates and find max date
                var claimsWithDates = paidClaims
                    .Select(r => new
                    {
                        Panel = r.Field<string>("PanelName")?.Trim() ?? "Unknown",
                        Date = ParseDate(r["CheckDate"]?.ToString()?.Trim() ?? ""),
                        VisitNumber = r.Field<string>("VisitNumber") ?? "",
                        CarrierPayment = GetDecimalValue(r["CarrierPayment"])
                    })
                    .Where(r => r.Date.HasValue)
                    .ToList();

                if (!claimsWithDates.Any())
                    return result;

                DateTime maxDate = claimsWithDates.Max(r => r.Date.Value);
                DateTime start = maxDate.AddDays(-28);

                var rows = claimsWithDates
                    .Where(r => r.Date >= start)
                    .GroupBy(r => new
                    {
                        Panel = r.Panel,
                        WeekNumber = CultureInfo.InvariantCulture.Calendar.GetWeekOfYear(
                            r.Date.Value,
                            CalendarWeekRule.FirstFourDayWeek,
                            DayOfWeek.Monday)
                    })
                    .Select(g => new
                    {
                        g.Key.Panel,
                        Week = $"Week {g.Key.WeekNumber}",
                        Claims = g.Select(x => x.VisitNumber).Distinct().Count(),
                        Paid = g.Sum(x => x.CarrierPayment)
                    });

                foreach (var r in rows)
                    result.Rows.Add(r.Panel, r.Week, r.Claims, r.Paid);
            }
            catch (Exception ex)
            {
                Console.WriteLine($"Error in BuildWeeklyInsights: {ex.Message}");
            }

            return result;
        }

        public static DataTable BuildTop5Insights(DataTable dt)
        {
            var result = new DataTable();
            result.Columns.Add("Insurance", typeof(string));
            result.Columns.Add("ClaimCount", typeof(int));
            result.Columns.Add("TotalPaid", typeof(decimal));

            try
            {
                var rows = dt.AsEnumerable()
                    .Where(r => !r.IsNull("Carrier") && !string.IsNullOrEmpty(r.Field<string>("Carrier")?.Trim()))
                    .GroupBy(r => r.Field<string>("Carrier")?.Trim() ?? "Unknown")
                    .Select(g => new
                    {
                        Carrier = g.Key,
                        Claims = g.Select(x => x.Field<string>("VisitNumber")).Distinct().Count(),
                        Paid = g.Sum(x => GetDecimalValue(x["CarrierPayment"]))
                    })
                    .OrderByDescending(x => x.Claims)
                    .Take(5);

                foreach (var r in rows)
                    result.Rows.Add(r.Carrier, r.Claims, r.Paid);
            }
            catch (Exception ex)
            {
                Console.WriteLine($"Error in BuildTop5Insights: {ex.Message}");
            }

            return result;
        }

        public static DataTable BuildAveragePayments(DataTable dt)
        {
            var result = new DataTable();
            result.Columns.Add("PanelName", typeof(string));
            result.Columns.Add("NoOfClaims", typeof(int));
            result.Columns.Add("AvgPayment", typeof(decimal));

            try
            {
                var rows = dt.AsEnumerable()
                    .Where(r => !r.IsNull("PanelName"))
                    .GroupBy(r => r.Field<string>("PanelName")?.Trim() ?? "Unknown")
                    .Select(g => new
                    {
                        Panel = g.Key,
                        Claims = g.Select(x => x.Field<string>("VisitNumber")).Distinct().Count(),
                        Avg = g.Average(x => GetDecimalValue(x["CarrierPayment"]))
                    });

                foreach (var r in rows)
                    result.Rows.Add(r.Panel, r.Claims, r.Avg);
            }
            catch (Exception ex)
            {
                Console.WriteLine($"Error in BuildAveragePayments: {ex.Message}");
            }

            return result;
        }

        // ================= ADD THE MISSING METHOD =================
        public static DataTable BuildAgingInsights(DataTable dt)
        {
            var result = new DataTable();
            result.Columns.Add("Insurance", typeof(string));
            result.Columns.Add("0-30 Days", typeof(decimal));
            result.Columns.Add("31-60 Days", typeof(decimal));
            result.Columns.Add("61-90 Days", typeof(decimal));
            result.Columns.Add("90+ Days", typeof(decimal));

            try
            {
                // Get current date for aging calculation
                DateTime currentDate = DateTime.Now;

                // Group by insurance carrier
                var insuranceGroups = dt.AsEnumerable()
                    .Where(r => !r.IsNull("Carrier") && !string.IsNullOrEmpty(r.Field<string>("Carrier")?.Trim()))
                    .GroupBy(r => r.Field<string>("Carrier")?.Trim() ?? "Unknown");

                foreach (var insuranceGroup in insuranceGroups)
                {
                    decimal amount0_30 = 0;
                    decimal amount31_60 = 0;
                    decimal amount61_90 = 0;
                    decimal amount90Plus = 0;

                    foreach (var row in insuranceGroup)
                    {
                        // Get balance amount
                        decimal balance = GetDecimalValue(row["CarrierBalance"]);
                        if (balance <= 0) continue;

                        // Try to get service date or check date for aging calculation
                        DateTime? serviceDate = ParseDate(row["DateOfService"]?.ToString()?.Trim() ?? "");
                        DateTime? checkDate = ParseDate(row["CheckDate"]?.ToString()?.Trim() ?? "");

                        // Use whichever date is available
                        DateTime? referenceDate = serviceDate ?? checkDate;
                        if (!referenceDate.HasValue) continue;

                        // Calculate days difference
                        int daysDiff = (int)(currentDate - referenceDate.Value).TotalDays;

                        // Categorize based on days
                        if (daysDiff <= 30)
                        {
                            amount0_30 += balance;
                        }
                        else if (daysDiff <= 60)
                        {
                            amount31_60 += balance;
                        }
                        else if (daysDiff <= 90)
                        {
                            amount61_90 += balance;
                        }
                        else
                        {
                            amount90Plus += balance;
                        }
                    }

                    // Only add if there's any balance
                    if (amount0_30 > 0 || amount31_60 > 0 || amount61_90 > 0 || amount90Plus > 0)
                    {
                        result.Rows.Add(
                            insuranceGroup.Key,
                            amount0_30,
                            amount31_60,
                            amount61_90,
                            amount90Plus
                        );
                    }
                }

                // Sort by total aging amount descending
                var sortedRows = result.AsEnumerable()
                    .OrderByDescending(r =>
                        GetDecimalValue(r["0-30 Days"]) +
                        GetDecimalValue(r["31-60 Days"]) +
                        GetDecimalValue(r["61-90 Days"]) +
                        GetDecimalValue(r["90+ Days"]))
                    .ToList();

                // Clear and add sorted rows
                result.Clear();
                foreach (var row in sortedRows)
                {
                    result.ImportRow(row);
                }

                // Limit to top results if needed
                if (result.Rows.Count > 10)
                {
                    while (result.Rows.Count > 10)
                    {
                        result.Rows.RemoveAt(result.Rows.Count - 1);
                    }
                }
            }
            catch (Exception ex)
            {
                Console.WriteLine($"Error in BuildAgingInsights: {ex.Message}");
            }

            return result;
        }

        private static void ConvertColumnToDecimalSafe(DataTable dt, string columnName)
        {
            if (!dt.Columns.Contains(columnName))
                return;

            string tempColumn = columnName + "_Decimal";
            dt.Columns.Add(tempColumn, typeof(decimal));

            foreach (DataRow row in dt.Rows)
            {
                row[tempColumn] = GetDecimalValue(row[columnName]);
            }

            dt.Columns.Remove(columnName);
            dt.Columns[tempColumn].ColumnName = columnName;
        }

        private static DateTime? ParseDate(string dateStr)
        {
            if (string.IsNullOrWhiteSpace(dateStr))
                return null;

            string[] formats = {
                "yyyy-MM-dd", "MM/dd/yyyy", "dd/MM/yyyy",
                "yyyy-MM-dd HH:mm:ss", "MM/dd/yyyy HH:mm:ss",
                "dd-MMM-yyyy", "dd MMM yyyy", "MMM dd yyyy",
                "yyyy/MM/dd", "dd-MM-yyyy", "MM-dd-yyyy"
            };

            DateTime result;
            if (DateTime.TryParseExact(dateStr, formats, CultureInfo.InvariantCulture,
                DateTimeStyles.None, out result))
            {
                return result;
            }

            if (DateTime.TryParse(dateStr, out result))
            {
                return result;
            }

            return null;
        }
    }
}