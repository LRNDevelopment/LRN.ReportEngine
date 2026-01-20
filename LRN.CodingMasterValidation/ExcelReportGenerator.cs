using ClosedXML.Excel;
using DocumentFormat.OpenXml.Spreadsheet;
using System;
using System.Collections.Generic;
using System.Globalization;
using System.IO;
using System.Linq;

namespace LRN.CodingMasterValidation
{
    public class ExcelReportGenerator
    {
        private readonly string _outputDirectory;
        // ===== Corporate Theme =====
        private static readonly XLColor PrimaryBlue = XLColor.FromHtml("#1F4E79"); // Deep Navy
        private static readonly XLColor AccentBlue = XLColor.FromHtml("#2E75B6");
        private static readonly XLColor AccentOrange = XLColor.FromHtml("#ED7D31");
        private static readonly XLColor AccentGreen = XLColor.FromHtml("#70AD47");
        private static readonly XLColor AccentRed = XLColor.FromHtml("#C00000");
        private static readonly XLColor LightGray = XLColor.FromHtml("#F4F6F8");
        private static readonly XLColor SoftYellow = XLColor.FromHtml("#FFF2CC");




        // ===== Section Bars (Dark) =====
        private static readonly XLColor TotalsBar = XLColor.FromHtml("#BF9000"); // Gold
        private static readonly XLColor RevenueImpactBar = XLColor.FromHtml("#2E75B6"); // Dark Blue
        private static readonly XLColor RevenueLossBar = XLColor.FromHtml("#C00000"); // Dark Red
        private static readonly XLColor RevenueRiskBar = XLColor.FromHtml("#ED7D31"); // Dark Orange
        private static readonly XLColor ComplianceBar = XLColor.FromHtml("#1F4E79"); // Navy

        // ===== Column Header (Light) =====
        private static readonly XLColor TotalsHeader = XLColor.FromHtml("#FFF2CC");
        private static readonly XLColor RevenueImpactHeader = XLColor.FromHtml("#D9E1F2");
        private static readonly XLColor RevenueLossHeader = XLColor.FromHtml("#F4CCCC");
        private static readonly XLColor RevenueRiskHeader = XLColor.FromHtml("#FCE4D6");
        private static readonly XLColor ComplianceHeader = XLColor.FromHtml("#DEEAF6");

       


        //  private const string HeaderFont = "Segoe UI";
        private const string HeaderFont = "Calibri";
        private const string BodyFont = "Calibri";

        private readonly string _sourceFileName;
        private readonly LabContext _lab;


        public ExcelReportGenerator(string outputDirectory, string sourceFileName, LabContext lab)
        {
            _outputDirectory = outputDirectory
                ?? throw new ArgumentNullException(nameof(outputDirectory));

            _sourceFileName = sourceFileName
        ?? throw new ArgumentNullException(nameof(sourceFileName));
            _lab = lab;
        }


        /// <summary>
        /// Generates a formatted Excel workbook from Enhanced and Panel Summary CSV files
        /// </summary>
        /// <param name="enhancedCsvPath">Path to Enhanced_Validation_Report_xxxxx.csv</param>
        /// <param name="panelSummaryCsvPath">Path to Panel_Summary_Report_xxxx.csv</param>
        //public void GenerateFormattedExcelReport(string enhancedCsvPath, string panelSummaryCsvPath)
        public string GenerateFormattedExcelReport(string enhancedCsvPath, string panelSummaryCsvPath)
        {
            try
            {
                Console.WriteLine("\n" + "=".PadRight(60, '='));
                Console.WriteLine("GENERATING FORMATTED EXCEL REPORT");
                Console.WriteLine("=".PadRight(60, '='));

                //if (!File.Exists(enhancedCsvPath) || !File.Exists(panelSummaryCsvPath))
                //{
                //    Console.WriteLine("❌ One or both CSV files not found!");
                //    return ;
                //}

                if (!File.Exists(enhancedCsvPath) || !File.Exists(panelSummaryCsvPath))
                {
                    Console.WriteLine("❌ One or both CSV files not found!");
                    return null;
                }

                // 🔹 Create date-based folder (yyyy-MM-dd)
                string dateFolder = DateTime.Now.ToString("yyyy-MM-dd");
                string datedOutputDirectory = Path.Combine(_outputDirectory, dateFolder);

                // Ensure directory exists
                Directory.CreateDirectory(datedOutputDirectory);


                // 🔹 Create output file inside date folder
              //  string sourceFileName =Path.GetFileNameWithoutExtension(enhancedCsvPath);

                

                string timestamp = DateTime.Now.ToString("yyyyMMdd_HHmmss");

                string outputFile = outputFile = Path.Combine(datedOutputDirectory, $"CodingValidated_ProdMaster_{timestamp}.xlsx");
                //if (string.IsNullOrEmpty(_sourceFileName))
                //{
                //    outputFile = Path.Combine(datedOutputDirectory, $"CodingValidated_{timestamp}.xlsx");

                //}
                //else
                //{
                //    outputFile = Path.Combine(datedOutputDirectory, $"{_sourceFileName}_CodingValidated.xlsx");
                //}

                  




                //using (var workbook = new XLWorkbook(XLEventTracking.Disabled))
                using (var workbook = new XLWorkbook())
                {
                    Console.WriteLine("📊 Creating Financial Summary Dashboard...");
                    AddFinancialSummaryDashboard(workbook, enhancedCsvPath, panelSummaryCsvPath);

                  //  AddPivotSummaryWorksheet(workbook, enhancedCsvPath);


                    Console.WriteLine("📊 Processing Panel Summary Report...");
                    AddPanelSummaryWorksheet(workbook, panelSummaryCsvPath);

                    Console.WriteLine("📊 Processing Enhanced Validation Report...");
                    AddEnhancedValidationWorksheet(workbook, enhancedCsvPath);
                    workbook.Worksheet("Enhanced Validation").Name = "CodingValidated";





                    // Format workbook tabs
                    FormatWorkbookTabs(workbook);

                    // Auto-adjust column widths
                    AutoAdjustColumns(workbook);
                    if (File.Exists(outputFile))
                    {
                        File.Delete(outputFile);
                    }

                    workbook.SaveAs(outputFile);
                  
                    Console.WriteLine($"\n✅ Formatted Excel report saved: {outputFile}");
                    Console.WriteLine($"📁 File size: {new FileInfo(outputFile).Length / 1024} KB");
                    return outputFile;
                }
            }
            catch (Exception ex)
            {
                Console.WriteLine($"❌ Error generating Excel report: {ex.Message}");
                return null;
            }
           

        }

        private void AddEnhancedValidationWorksheet(XLWorkbook workbook, string csvPath)
        {
            var worksheet = workbook.AddWorksheet("Enhanced Validation");
           

            // Read CSV data
            var lines = File.ReadAllLines(csvPath);
            if (lines.Length == 0) return;

            var headers = ParseCsvLine(lines[0]);

            //bool isPCRAL = IsPCRALLab();

            //if (isPCRAL && !headers.Contains("Panel1", StringComparer.OrdinalIgnoreCase))
            //{
            //    int panelIndex = headers.IndexOf("PanelName") + 1;
            //    headers.Insert(panelIndex, "Panel1");
            //}

            

            bool isPCRAL = IsPCRALLab();

            // 🔥 REMOVE Panel1 for non-PCRAL labs
            if (!isPCRAL)
            {
                headers.RemoveAll(h =>
                    h.Equals("Panel1", StringComparison.OrdinalIgnoreCase));
            }




            // Write headers with formatting[citation:7]
            for (int col = 0; col < headers.Count; col++)
            {
                var cell = worksheet.Cell(1, col + 1);
                cell.Value = headers[col];

                // Format header row
                //cell.Style.Font.Bold = true;
                //cell.Style.Font.FontColor = XLColor.White;
                //cell.Style.Fill.BackgroundColor = XLColor.FromHtml("#4472C4"); // Blue
                //cell.Style.Alignment.Horizontal = XLAlignmentHorizontalValues.Center;
                //cell.Style.Border.BottomBorder = XLBorderStyleValues.Thin;
                //cell.Style.Border.BottomBorderColor = XLColor.Black;

                cell.Style.Font.Bold = true;
                cell.Style.Font.FontName = HeaderFont;
                cell.Style.Font.FontSize = 10;
                cell.Style.Font.FontColor = XLColor.White;

                cell.Style.Fill.BackgroundColor = PrimaryBlue;
                cell.Style.Alignment.Horizontal = XLAlignmentHorizontalValues.Center;
                cell.Style.Alignment.Vertical = XLAlignmentVerticalValues.Center;

                cell.Style.Border.BottomBorder = XLBorderStyleValues.Medium;
                cell.Style.Border.BottomBorderColor = XLColor.Black;

            }
            int firstBillDateColIndex =
                       headers.FindIndex(h => h.Equals("FirstBillDate", StringComparison.OrdinalIgnoreCase));

            // Write data rows with conditional formatting
            for (int row = 1; row < lines.Length; row++)
            {
                var values = ParseCsvLine(lines[row]);
                //if (isPCRAL)
                //{
                //    int panelIndex = headers.IndexOf("PanelName");
                //    int panel1Index = panelIndex + 1;

                //    // Panel1 value comes from CSV column 6 (ProductionRecord.Panel1)
                //    string panel1Value = values.Count > 6 ? values[6] : values[panelIndex];

                //    values.Insert(panel1Index, panel1Value);
                //}

                for (int col = 0; col < values.Count; col++)
                {
                    var cell = worksheet.Cell(row + 1, col + 1);
                    cell.Value = values[col];
                    cell.Style.Font.FontName = BodyFont;
                    cell.Style.Font.FontSize = 10;
                    cell.Style.Alignment.Vertical = XLAlignmentVerticalValues.Center;
                  

                    if (col == firstBillDateColIndex && DateTime.TryParse(values[col], out DateTime billDate))
                    {
                        cell.Value = billDate;
                        cell.Style.DateFormat.Format = "yyyy-MM-dd";
                        cell.Style.Alignment.Horizontal = XLAlignmentHorizontalValues.Center;
                    }

                    // Format numeric columns
                    //if (col >= 8 && col <= 11) // Assuming charges columns are 8-11
                    //{
                    //    if (decimal.TryParse(values[col].Replace("$", "").Replace(",", ""), out decimal amount))
                    //    {
                    //        cell.Value = amount;
                    //        //cell.Style.NumberFormat.Format = "$#,##0.00";
                    //        cell.Style.NumberFormat.Format = "$#,##0.00;[Red]-$#,##0.00";
                    //        cell.Style.Font.Bold = true;
                    //        cell.Style.Font.FontColor = amount < 0 ? AccentRed : XLColor.Black;


                    //    }
                    //}
                    if (IsAmountColumn(headers[col]))
                    {
                        if (decimal.TryParse(values[col]
                            .Replace("$", "")
                            .Replace(",", ""), out decimal amount))
                        {
                            cell.Value = amount;
                            cell.Style.NumberFormat.Format = "$#,##0.00;[Red]-$#,##0.00";
                            cell.Style.Font.Bold = true;
                            cell.Style.Font.FontColor = amount < 0 ? AccentRed : XLColor.Black;
                            cell.Style.Alignment.Horizontal = XLAlignmentHorizontalValues.Right;
                        }
                    }
                    else
                    {
                        cell.Style.Alignment.Horizontal = XLAlignmentHorizontalValues.Left;
                    }

                }

                // Apply alternating row colors
                if (row % 2 == 0)
                {
                    var rowRange = worksheet.Range(row + 1, 1, row + 1, headers.Count);
                    // rowRange.Style.Fill.BackgroundColor = XLColor.FromHtml("#F2F2F2");
                    rowRange.Style.Fill.BackgroundColor = LightGray;

                }
            }

            // Add data validation summary at the bottom
            AddEnhancedValidationSummary(worksheet, lines);
            worksheet.SheetView.FreezeRows(1);
            Console.WriteLine($"   ✓ Added {lines.Length - 1} claim records");
        }

        //        private void AddPanelSummaryWorksheet(XLWorkbook workbook, string csvPath)
        //        {
        //            var worksheet = workbook.AddWorksheet("Panel Summary");

        //            // Read CSV data[citation:1]
        //            var lines = File.ReadAllLines(csvPath);
        //            if (lines.Length == 0) return;

        //            var headers = ParseCsvLine(lines[0]);

        //            // Write headers with professional formatting
        //            for (int col = 0; col < headers.Count; col++)
        //            {
        //                var cell = worksheet.Cell(1, col + 1);
        //                cell.Value = headers[col];

        //                // cell.Style.Font.Bold = true;
        //                //cell.Style.Font.FontColor = XLColor.White;
        //                //cell.Style.Fill.BackgroundColor = XLColor.FromHtml("#ED7D31"); // Orange

        //                cell.Style.Font.Bold = true;
        //                cell.Style.Font.FontName = HeaderFont;
        //                cell.Style.Font.FontSize = 10;
        //                cell.Style.Font.FontColor = XLColor.White;

        //                cell.Style.Fill.BackgroundColor = AccentBlue;
        //                cell.Style.Alignment.Horizontal = XLAlignmentHorizontalValues.Center;
        //                cell.Style.Alignment.Vertical = XLAlignmentVerticalValues.Center;

        //                cell.Style.Border.BottomBorder = XLBorderStyleValues.Medium;
        //                cell.Style.Border.BottomBorderColor = XLColor.Black;

        //                worksheet.SheetView.FreezeRows(1);

        //            }


        //            int missingAmountIdx = headers.FindIndex(h =>
        //    h.Contains("Sum of Missing Amount", StringComparison.OrdinalIgnoreCase));

        //int additionalAmountIdx = headers.FindIndex(h =>
        //    h.Contains("Sum of Additional Amount", StringComparison.OrdinalIgnoreCase));


        //            // Write data with financial formatting
        //            decimal totalDifference = 0;

        //            for (int row = 1; row < lines.Length; row++)
        //            {
        //                var values = ParseCsvLine(lines[row]);
        //                for (int col = 0; col < values.Count; col++)
        //                {
        //                    var cell = worksheet.Cell(row + 1, col + 1);
        //                    cell.Value = values[col];
        //                    cell.Style.Font.FontName = BodyFont;
        //                    cell.Style.Font.FontSize = 10;

        //                    // Format financial columns (indices 6-10)
        //                    //if (col >= 6 && col <= 10)
        //                    //{
        //                    //    if (decimal.TryParse(values[col].Replace("$", "").Replace(",", ""), out decimal amount))
        //                    //    {
        //                    //        cell.Value = amount;
        //                    //        //cell.Style.NumberFormat.Format = "$#,##0.00";

        //                    //        cell.Style.NumberFormat.Format = "$#,##0.00;[Red]-$#,##0.00";
        //                    //        cell.Style.Font.Bold = true;


        //                    //        // Track total difference
        //                    //        //if (col == 10) // Difference column
        //                    //        //{
        //                    //        //    totalDifference += amount;
        //                    //        //    if (amount < 0)
        //                    //        //    {
        //                    //        //        cell.Style.Font.Bold = true;
        //                    //        //        cell.Style.Font.FontColor = amount < 0 ? XLColor.Red : XLColor.FromHtml("#70AD47"); // Green for positive
        //                    //        //    }
        //                    //        //}
        //                    //        if (col == 10)
        //                    //        {
        //                    //            totalDifference += amount;
        //                    //            cell.Style.Font.Bold = true;
        //                    //            cell.Style.Font.FontColor = amount < 0 ? AccentRed : AccentGreen;
        //                    //        }
        //                    //        else if (col == 6 || col == 7) // Missing/Additional charges
        //                    //        {
        //                    //            cell.Style.Font.FontColor = amount > 0 ? XLColor.Red : XLColor.Black;
        //                    //        }
        //                    //    }
        //                    //}

        //                    string header = headers[col];

        //                    if (decimal.TryParse(values[col].Replace("$", "").Replace(",", ""), out decimal amount))
        //                    {
        //                        cell.Value = amount;
        //                        cell.Style.Font.Bold = true;

        //                        // ✅ COUNT columns → INTEGER
        //                        if (header.Contains("Count", StringComparison.OrdinalIgnoreCase))
        //                        {
        //                            cell.Style.NumberFormat.Format = "0";
        //                            cell.Style.Alignment.Horizontal = XLAlignmentHorizontalValues.Center;
        //                            cell.Style.Font.FontColor = XLColor.Black;
        //                        }
        //                        // ✅ AMOUNT / SUM columns → CURRENCY
        //                        else if (header.Contains("Amount", StringComparison.OrdinalIgnoreCase)
        //                              || header.Contains("Charge", StringComparison.OrdinalIgnoreCase))
        //                        {
        //                            cell.Style.NumberFormat.Format = "$#,##0.00;[Red]-$#,##0.00";
        //                            cell.Style.Alignment.Horizontal = XLAlignmentHorizontalValues.Right;

        //                            if (header.Contains("Missing", StringComparison.OrdinalIgnoreCase)
        //                                || header.Contains("Additional", StringComparison.OrdinalIgnoreCase))
        //                            {
        //                                cell.Style.Font.FontColor = amount > 0 ? AccentRed : XLColor.Black;
        //                            }
        //                        }
        //                    }

        //                }

        //                // Add borders to each panel row
        //                var panelRow = worksheet.Range(row + 1, 1, row + 1, headers.Count);
        //                panelRow.Style.Border.BottomBorder = XLBorderStyleValues.Thin;
        //                panelRow.Style.Border.BottomBorderColor = XLColor.Gray;
        //            }

        //            // Add summary row at the bottom
        //            int lastRow = lines.Length;
        //            var totalRow = lastRow + 2;

        //            // Merge cells for total label
        //            worksheet.Cell(totalRow, 1).Value = "TOTAL IMPACT:";
        //            worksheet.Range(totalRow, 1, totalRow, 5).Merge();
        //            worksheet.Cell(totalRow, 1).Style.Font.Bold = true;
        //            worksheet.Cell(totalRow, 1).Style.Font.FontSize = 12;
        //            worksheet.Cell(totalRow, 1).Style.Alignment.Horizontal = XLAlignmentHorizontalValues.Right;

        //            // Add total difference
        //            worksheet.Cell(totalRow, 10).Value = totalDifference;
        //            worksheet.Cell(totalRow, 10).Style.NumberFormat.Format = "$#,##0.00";
        //            worksheet.Cell(totalRow, 10).Style.Font.Bold = true;
        //            worksheet.Cell(totalRow, 10).Style.Font.FontColor = totalDifference < 0 ? XLColor.Red : XLColor.FromHtml("#70AD47");
        //            worksheet.Cell(totalRow, 10).Style.Fill.BackgroundColor = XLColor.FromHtml("#FFF2CC");



        //            var totalRange = worksheet.Range(totalRow, 1, totalRow, headers.Count);
        //            totalRange.Style.Fill.BackgroundColor = SoftYellow;
        //            totalRange.Style.Border.TopBorder = XLBorderStyleValues.Thick;
        //            totalRange.Style.Font.Bold = true;


        //            Console.WriteLine($"   ✓ Added {lines.Length - 1} panel summaries");
        //        }
        private decimal SafeParseCurrency(string input)
        {
            if (string.IsNullOrWhiteSpace(input))
                return 0;

            input = input
                .Replace("$", "")
                .Replace(",", "")
                .Trim();

            if (input.Equals("(blank)", StringComparison.OrdinalIgnoreCase))
                return 0;

            return decimal.TryParse(input, out var value) ? value : 0;
        }


        //private void AddPanelSummaryWorksheet(XLWorkbook workbook, string panelSummaryCsvPath)
        //{
        //    var worksheet = workbook.AddWorksheet("Panel Summary");

        //    var lines = File.ReadAllLines(panelSummaryCsvPath);
        //    if (lines.Length == 0)
        //        return;

        //    // ---------- HEADER ----------
        //    var headers = ParseCsvLine(lines[0]);

        //    for (int col = 0; col < headers.Count; col++)
        //    {
        //        var cell = worksheet.Cell(1, col + 1);
        //        cell.Value = headers[col];
        //        cell.Style.Font.Bold = true;
        //        cell.Style.Fill.BackgroundColor = XLColor.LightGray;
        //        cell.Style.Alignment.Horizontal = XLAlignmentHorizontalValues.Center;
        //    }

        //    // ---------- COLUMN INDEX LOOKUP (HEADER-DRIVEN) ----------
        //    int missingAmountIdx = headers.FindIndex(h =>
        //        h.Contains("Sum of Missing Amount", StringComparison.OrdinalIgnoreCase));

        //    int additionalAmountIdx = headers.FindIndex(h =>
        //        h.Contains("Sum of Additional Amount", StringComparison.OrdinalIgnoreCase));

        //    //if (missingAmountIdx < 0 || additionalAmountIdx < 0)
        //    //    throw new Exception("Required amount columns not found in Panel Summary CSV.");

        //    if (missingAmountIdx < 0 || additionalAmountIdx < 0)
        //    {
        //        Console.WriteLine("⚠️ Required amount columns not found for summary calculation.");
        //        return;
        //    }


        //    decimal totalDifference = 0;
        //    int currentRow = 2;

        //    // ---------- DATA ROWS ----------
        //    for (int row = 1; row < lines.Length; row++)
        //    {
        //        var values = ParseCsvLine(lines[row]);

        //        decimal missingAmt = 0;
        //        decimal additionalAmt = 0;

        //        //if (missingAmountIdx < values.Count)
        //        //    decimal.TryParse(
        //        //        values[missingAmountIdx].Replace("$", "").Replace(",", ""),
        //        //        out missingAmt);

        //        //if (additionalAmountIdx < values.Count)
        //        //    decimal.TryParse(
        //        //        values[additionalAmountIdx].Replace("$", "").Replace(",", ""),
        //        //        out additionalAmt);

        //        missingAmt = SafeParseCurrency(values[missingAmountIdx]);
        //        additionalAmt = SafeParseCurrency(values[additionalAmountIdx]);


        //        // ✅ TOTAL IMPACT — calculated ONCE per row
        //        totalDifference += (additionalAmt - missingAmt);

        //        for (int col = 0; col < values.Count; col++)
        //        {
        //            var cell = worksheet.Cell(currentRow, col + 1);
        //            cell.Value = values[col];

        //            // Right-align numeric columns
        //            if (decimal.TryParse(values[col].Replace("$", "").Replace(",", ""), out _))
        //            {
        //                cell.Style.Alignment.Horizontal = XLAlignmentHorizontalValues.Right;
        //            }
        //        }

        //        currentRow++;
        //    }

        //    // ---------- TOTAL ROW ----------
        //    int totalRow = currentRow + 1;

        //    worksheet.Cell(totalRow, 1).Value = "TOTAL IMPACT";
        //    worksheet.Cell(totalRow, 1).Style.Font.Bold = true;

        //    // Place total impact under "Sum of Additional Amount ($)" column
        //    int impactColumnIndex = additionalAmountIdx + 1;

        //    var impactCell = worksheet.Cell(totalRow, impactColumnIndex);
        //    impactCell.Value = totalDifference;
        //    impactCell.Style.NumberFormat.Format = "$#,##0.00";
        //    impactCell.Style.Font.Bold = true;
        //    impactCell.Style.Font.FontColor =
        //        totalDifference < 0 ? XLColor.Red : XLColor.FromHtml("#70AD47");

        //    // ---------- FORMATTING ----------
        //    worksheet.Columns().AdjustToContents();
        //    worksheet.SheetView.FreezeRows(1);
        //}


        //private void AddFinancialSummaryDashboard(XLWorkbook workbook, string enhancedCsvPath, string panelSummaryCsvPath)
        //{
        //    var worksheet = workbook.AddWorksheet("Financial Dashboard");



        //    // Add dashboard title with formatting[citation:7]
        //    var titleCell = worksheet.Cell(1, 1);
        //    titleCell.Value = "CODING MASTER VALIDATION - FINANCIAL SUMMARY";
        //    titleCell.Style.Font.Bold = true;
        //    titleCell.Style.Font.FontSize = 16;
        //    titleCell.Style.Font.FontColor = XLColor.FromHtml("#2F5496");
        //    worksheet.Range(1, 1, 1, 8).Merge();
        //    worksheet.Row(1).Height = 30;

        //    // Subtitle
        //    worksheet.Cell(2, 1).Value = $"Report Date: {DateTime.Now:yyyy-MM-dd HH:mm}";
        //    worksheet.Range(2, 1, 2, 8).Merge();

        //    // Analyze Enhanced Report data
        //    var enhancedLines = File.ReadAllLines(enhancedCsvPath);
        //    var panelLines = File.ReadAllLines(panelSummaryCsvPath);

        //    // Calculate KPIs
        //    decimal totalMissingCharges = 0;
        //    decimal totalAdditionalCharges = 0;
        //    decimal totalActualCharges = 0;
        //    decimal totalExpectedCharges = 0;
        //    int totalClaims = enhancedLines.Length - 1;
        //    int panelsWithIssues = panelLines.Length - 1;

        //    //for (int i = 1; i < enhancedLines.Length; i++)
        //    //{
        //    //    var values = ParseCsvLine(enhancedLines[i]);
        //    //    if (values.Count >= 12)
        //    //    {
        //    //        decimal.TryParse(values[8].Replace("$", ""), out decimal missing);
        //    //        decimal.TryParse(values[9].Replace("$", ""), out decimal additional);
        //    //        decimal.TryParse(values[10].Replace("$", ""), out decimal actual);
        //    //        decimal.TryParse(values[11].Replace("$", ""), out decimal expected);

        //    //        totalMissingCharges += missing;
        //    //        totalAdditionalCharges += additional;
        //    //        totalActualCharges += actual;
        //    //        totalExpectedCharges += expected;
        //    //    }



        //    //}

        //    var headers = ParseCsvLine(enhancedLines[0]);

        //    int missingIdx = GetColumnIndex(headers, "Missing Amount");
        //    int additionalIdx = GetColumnIndex(headers, "Additional Amount");
        //    int actualIdx = GetColumnIndex(headers, "Actual Charge");
        //    int expectedIdx = GetColumnIndex(headers, "Expected Charge");

        //    for (int i = 1; i < enhancedLines.Length; i++)
        //    {
        //        var values = ParseCsvLine(enhancedLines[i]);

        //        totalMissingCharges += ParseDecimal(values, missingIdx);
        //        totalAdditionalCharges += ParseDecimal(values, additionalIdx);
        //        totalActualCharges += ParseDecimal(values, actualIdx);
        //        totalExpectedCharges += ParseDecimal(values, expectedIdx);
        //    }

        //    // Create KPI boxes
        //    int startRow = 4;

        //    // KPI 1: Total Claims
        //    CreateKpiBox(worksheet, startRow, 1, "Total Claims", totalClaims.ToString("N0"), "#4472C4");

        //    // KPI 2: Panels with Issues
        //    CreateKpiBox(worksheet, startRow, 3, "Panels with Issues", panelsWithIssues.ToString("N0"), "#ED7D31");

        //    // KPI 3: Total Missing Charges
        //    CreateKpiBox(worksheet, startRow, 5, "Total Missing Charges", totalMissingCharges.ToString("$#,##0.00"), "#C00000");

        //    // KPI 4: Total Additional Charges
        //    CreateKpiBox(worksheet, startRow, 7, "Total Additional Charges", totalAdditionalCharges.ToString("$#,##0.00"), "#FFC000");

        //    // KPI 5: Revenue Impact
        //    decimal revenueImpact = totalExpectedCharges - totalActualCharges;
        //    string impactColor = revenueImpact < 0 ? "#C00000" : "#70AD47";
        //    CreateKpiBox(worksheet, startRow + 2, 1, "Revenue Impact", revenueImpact.ToString("C2"), impactColor);

        //    // KPI 6: Compliance Rate
        //    decimal complianceRate = totalClaims > 0 ? (totalMissingCharges == 0 ? 100 : 100 - (totalMissingCharges / totalExpectedCharges * 100)) : 0;
        //    CreateKpiBox(worksheet, startRow + 2, 3, "Compliance Rate", complianceRate.ToString("F1") + "%", "#2F75B5");

        //    // Add recommendations section
        //    int recoRow = startRow + 5;
        //    worksheet.Cell(recoRow, 1).Value = "RECOMMENDATIONS & NEXT STEPS";
        //    worksheet.Cell(recoRow, 1).Style.Font.Bold = true;
        //    worksheet.Cell(recoRow, 1).Style.Font.FontSize = 12;
        //    worksheet.Cell(recoRow, 1).Style.Font.FontColor = XLColor.FromHtml("#2F5496");
        //    worksheet.Range(recoRow, 1, recoRow, 8).Merge();

        //    recoRow++;
        //    worksheet.Cell(recoRow, 1).Value = "1. Review missing CPT codes causing $" + totalMissingCharges.ToString("N0") + " in lost revenue";
        //    recoRow++;
        //    worksheet.Cell(recoRow, 1).Value = "2. Validate additional CPT codes to ensure proper billing compliance";
        //    recoRow++;
        //    worksheet.Cell(recoRow, 1).Value = "3. Update Coding Master for panels with consistent discrepancies";
        //    recoRow++;
        //    worksheet.Cell(recoRow, 1).Value = "4. Schedule training for coders on problematic panels";

        //    Console.WriteLine($"   ✓ Created financial dashboard with {panelsWithIssues} panels analyzed");
        //}

        private void AddPanelSummaryWorksheet(XLWorkbook workbook, string panelSummaryCsvPath)
        {
            var worksheet = workbook.AddWorksheet("Panel Summary");

            var lines = File.ReadAllLines(panelSummaryCsvPath);
            if (lines.Length <= 1)
                return;

            // =========================
            // HEADER
            // =========================
            var headers = ParseCsvLine(lines[0]);

            for (int col = 0; col < headers.Count; col++)
            {
                var cell = worksheet.Cell(1, col + 1);
                cell.Value = headers[col];
                cell.Style.Font.Bold = true;
                cell.Style.Fill.BackgroundColor = XLColor.LightGray;
                cell.Style.Alignment.Horizontal = XLAlignmentHorizontalValues.Center;
            }
            int panelColIndex = headers.FindIndex(h => h.Equals("Panel", StringComparison.OrdinalIgnoreCase));
            // =========================
            // COLUMN INDEX LOOKUP
            // =========================
            int missingAmountIdx = headers.FindIndex(h =>
                h.Contains("Sum of Missing Amount", StringComparison.OrdinalIgnoreCase));

            int additionalAmountIdx = headers.FindIndex(h =>
                h.Contains("Sum of Additional Amount", StringComparison.OrdinalIgnoreCase));

            if (missingAmountIdx < 0 || additionalAmountIdx < 0)
            {
                Console.WriteLine("⚠️ Required amount columns not found in Panel Summary CSV.");
                return;
            }

            decimal totalImpact = 0m;
            int currentRow = 2;

            // =========================
            // DATA ROWS
            // =========================
            for (int row = 1; row < lines.Length; row++)
            {
                var values = ParseCsvLine(lines[row]);
                

                decimal missingAmt = SafeParseCurrency(values[missingAmountIdx]);
                decimal additionalAmt = SafeParseCurrency(values[additionalAmountIdx]);

                // 🚫 SKIP rows where both are zero
                if (missingAmt == 0 && additionalAmt == 0)
                    continue;

                totalImpact += (additionalAmt - missingAmt);
               
                for (int col = 0; col < headers.Count; col++)
                {
                   


                    var cell = worksheet.Cell(currentRow, col + 1);
                    string header = headers[col];
                    string rawValue = col < values.Count ? values[col] : string.Empty;

                    if (col == panelColIndex)
                    {
                        cell.Value = rawValue;
                        cell.Style.NumberFormat.Format = "@"; // TEXT
                        cell.Style.Alignment.Horizontal = XLAlignmentHorizontalValues.Left;
                        continue;
                    }

                    // COUNT columns → integer
                    if (header.Contains("Count", StringComparison.OrdinalIgnoreCase)
                        && int.TryParse(rawValue, out int countVal))
                    {
                        cell.Value = countVal;
                        cell.Style.NumberFormat.Format = "0";
                        cell.Style.Alignment.Horizontal = XLAlignmentHorizontalValues.Center;
                    }
                    // AMOUNT / CHARGE columns → decimal currency
                    else if ((header.Contains("Amount", StringComparison.OrdinalIgnoreCase)
                           || header.Contains("Charge", StringComparison.OrdinalIgnoreCase))
                           && decimal.TryParse(rawValue.Replace("$", "").Replace(",", ""), out decimal amt))
                    {
                        cell.Value = amt;
                        cell.Style.NumberFormat.Format = "$#,##0.00;[Red]-$#,##0.00";
                        cell.Style.Alignment.Horizontal = XLAlignmentHorizontalValues.Right;
                        cell.Style.Font.Bold = true;
                    }
                    // TEXT columns
                    else
                    {
                        cell.Value = rawValue;
                        cell.Style.Alignment.Horizontal = XLAlignmentHorizontalValues.Left;
                    }
                }

                currentRow++;
            }

            // =========================
            // TOTAL IMPACT ROW
            // =========================
            int totalRow = currentRow + 1;

            worksheet.Cell(totalRow, 1).Value = "TOTAL IMPACT";
            worksheet.Cell(totalRow, 1).Style.Font.Bold = true;

            var impactCell = worksheet.Cell(totalRow, additionalAmountIdx + 1);
            impactCell.Value = totalImpact;
            impactCell.Style.NumberFormat.Format = "$#,##0.00;[Red]-$#,##0.00";
            impactCell.Style.Font.Bold = true;
            impactCell.Style.Font.FontColor =
                totalImpact < 0 ? XLColor.Red : XLColor.FromHtml("#70AD47");

            // =========================
            // FINAL FORMATTING
            // =========================
            worksheet.Columns().AdjustToContents();
            worksheet.SheetView.FreezeRows(1);
        }

        private int GetColumnIndex(List<string> headers, string columnName)
        {
            return headers.FindIndex(h =>
                h.Equals(columnName, StringComparison.OrdinalIgnoreCase));
        }
        // Rename these methods in the AddFinancialSummaryDashboard code
        private int GetFinancialColumnIndex(List<string> headers, params string[] possibleNames)
        {
            for (int i = 0; i < headers.Count; i++)
            {
                foreach (var name in possibleNames)
                {
                    if (headers[i].Equals(name, StringComparison.OrdinalIgnoreCase))
                        return i;
                }
            }
            return -1;
        }

        private decimal ParseFinancialDecimal(List<string> values, int index)
        {
            if (index < 0 || index >= values.Count)
                return 0;

            var value = values[index];
            if (string.IsNullOrWhiteSpace(value))
                return 0;

            // Remove quotes, dollar signs, and commas
            value = value.Trim('"', ' ', '$', ',');

            if (decimal.TryParse(value, out decimal result))
                return result;

            return 0;
        }
        private int CalculatePanelsWithIssues(string panelSummaryCsvPath)
        {
            if (!File.Exists(panelSummaryCsvPath))
                return 0;

            var panelLines = File.ReadAllLines(panelSummaryCsvPath);
            if (panelLines.Length <= 1) // Only header or empty
                return 0;

            int panelsWithIssues = 0;
            var headers = ParseCsvLine(panelLines[0]);

            // Find the indices of the count columns
            int missingCountIdx = GetFinancialColumnIndex(headers, "Count of Missing Amount", "Missing Count");
            int additionalCountIdx = GetFinancialColumnIndex(headers, "Count of Additional Amount", "Additional Count");

            if (missingCountIdx < 0 || additionalCountIdx < 0)
            {
                Console.WriteLine("⚠️ Could not find count columns in Panel Summary, counting all panels as having issues");
                return panelLines.Length - 1; // Fallback: count all panels
            }

            // Process each panel summary row (skip header)
            for (int i = 1; i < panelLines.Length; i++)
            {
                var values = ParseCsvLine(panelLines[i]);

                // Ensure we have enough columns
                if (values.Count > Math.Max(missingCountIdx, additionalCountIdx))
                {
                    int missingCount = int.TryParse(values[missingCountIdx], out int mc) ? mc : 0;
                    int additionalCount = int.TryParse(values[additionalCountIdx], out int ac) ? ac : 0;

                    // Only count as panel with issues if either missing or additional count > 0
                    if (missingCount > 0 || additionalCount > 0)
                    {
                        panelsWithIssues++;
                    }
                }
            }

            return panelsWithIssues;
        }





        #region "finacialsummarymethods"

        // ===============================
        // SINGLE-PASS FINANCIAL AGGREGATION
        // ===============================
        //private FinancialAggregates CalculateFinancialAggregates(string enhancedCsvPath)
        //{
        //    var lines = File.ReadAllLines(enhancedCsvPath);
        //    var headers = ParseCsvLine(lines[0]);

        //    int missingIdx = GetFinancialColumnIndex(headers, "Missing Amount", "Missing CPT (Charge)");
        //    int additionalIdx = GetFinancialColumnIndex(headers, "Additional Amount", "Additional CPT (Charges)");
        //    int actualIdx = GetFinancialColumnIndex(headers, "TotalCharge");
        //    int expectedIdx = GetFinancialColumnIndex(headers, "Expected Charges");

        //    int validationStatusIdx =GetFinancialColumnIndex(headers, "Validation Status");

        //    int missingAvgPaidIdx =GetFinancialColumnIndex(headers, "MissingCPT_AvgPaidAmount");

        //    int additionalAvgPaidIdx =GetFinancialColumnIndex(headers, "AdditionalCPT_AvgPaidAmount");



        //    var agg = new FinancialAggregates();

        //    for (int i = 1; i < lines.Length; i++)
        //    {
        //        var v = ParseCsvLine(lines[i]);

        //        decimal missing = ParseFinancialDecimal(v, missingIdx);
        //        decimal additional = ParseFinancialDecimal(v, additionalIdx);
        //        decimal actual = ParseFinancialDecimal(v, actualIdx);
        //        decimal expected = ParseFinancialDecimal(v, expectedIdx);

        //        agg.TotalClaims++;
        //        agg.TotalActual += actual;
        //        agg.TotalExpected += expected;

        //        bool hasMissing = missing > 0;
        //        bool hasAdditional = additional > 0;

        //        if (hasMissing || hasAdditional)
        //            agg.ClaimsWithIssues++;

        //        if (hasMissing && !hasAdditional)
        //        {
        //            agg.MissingOnlyCount++;
        //            agg.MissingOnlyActual += actual;
        //            agg.MissingOnlyExpected += expected;
        //        }
        //        else if (!hasMissing && hasAdditional)
        //        {
        //            agg.AdditionalOnlyCount++;
        //            agg.AdditionalOnlyActual += actual;
        //            agg.AdditionalOnlyExpected += expected;
        //        }
        //        else if (hasMissing && hasAdditional)
        //        {
        //            agg.MissingAndAdditionalCount++;
        //            agg.MissingAndAdditionalActual += actual;
        //            agg.MissingAndAdditionalExpected += expected;
        //        }

        //        string validationStatus =validationStatusIdx >= 0 && validationStatusIdx < v.Count
        //            ? v[validationStatusIdx]
        //            : string.Empty;

        //        // ===============================
        //        // REVENUE LOSS (Missing CPTs)
        //        // ===============================
        //        if (validationStatus.Equals("Missing CPTs", StringComparison.OrdinalIgnoreCase)
        //         || validationStatus.Equals("Both Missing and Additional CPTs identified", StringComparison.OrdinalIgnoreCase))
        //        {
        //            agg.RevenueLossPotential +=
        //                ParseFinancialDecimal(v, missingAvgPaidIdx);
        //        }

        //        // ===============================
        //        // REVENUE AT RISK (Additional CPTs)
        //        // ===============================
        //        if (validationStatus.Equals("Additional CPTs coded", StringComparison.OrdinalIgnoreCase)
        //         || validationStatus.Equals("Both Missing and Additional CPTs identified", StringComparison.OrdinalIgnoreCase))
        //        {
        //            agg.RevenueAtRiskPotential +=
        //                ParseFinancialDecimal(v, additionalAvgPaidIdx);
        //        }


        //    }

        //    return agg;
        //}


        private FinancialAggregates CalculateFinancialAggregates(string enhancedCsvPath)
        {
            var lines = File.ReadAllLines(enhancedCsvPath);
            if (lines.Length <= 1)
                return new FinancialAggregates();

            var headers = ParseCsvLine(lines[0]);

            int missingIdx = GetFinancialColumnIndex(headers, "Missing CPT (Charge)");
            int additionalIdx = GetFinancialColumnIndex(headers, "Additional CPT (Charges)");
            int actualIdx = GetFinancialColumnIndex(headers, "TotalCharge");
            int expectedIdx = GetFinancialColumnIndex(headers, "Expected Charges");
            int validationStatusIdx = GetFinancialColumnIndex(headers, "Validation Status");

            int missingAvgPaidIdx = GetFinancialColumnIndex(headers, "MissingCPT_AvgPaidAmount");
            int additionalAvgPaidIdx = GetFinancialColumnIndex(headers, "AdditionalCPT_AvgPaidAmount");

            var agg = new FinancialAggregates();

            for (int i = 1; i < lines.Length; i++)
            {
                var v = ParseCsvLine(lines[i]);

                // 🚫 SKIP DISPLAY-ONLY TOTAL ROW
                if (v.Count > 0 &&
                    v[0].Equals("TOTAL", StringComparison.OrdinalIgnoreCase))
                {
                    continue;
                }

                decimal missing = ParseFinancialDecimal(v, missingIdx);
                decimal additional = ParseFinancialDecimal(v, additionalIdx);
                decimal actual = ParseFinancialDecimal(v, actualIdx);
                decimal expected = ParseFinancialDecimal(v, expectedIdx);

                agg.TotalClaims++;
                agg.TotalActual += actual;
                agg.TotalExpected += expected;

                bool hasMissing = missing > 0;
                bool hasAdditional = additional > 0;

                if (hasMissing || hasAdditional)
                    agg.ClaimsWithIssues++;

                if (hasMissing && !hasAdditional)
                {
                    agg.MissingOnlyCount++;
                    agg.MissingOnlyActual += actual;
                    agg.MissingOnlyExpected += expected;
                }
                else if (!hasMissing && hasAdditional)
                {
                    agg.AdditionalOnlyCount++;
                    agg.AdditionalOnlyActual += actual;
                    agg.AdditionalOnlyExpected += expected;
                }
                else if (hasMissing && hasAdditional)
                {
                    agg.MissingAndAdditionalCount++;
                    agg.MissingAndAdditionalActual += actual;
                    agg.MissingAndAdditionalExpected += expected;
                }

                string validationStatus =
                    validationStatusIdx >= 0 && validationStatusIdx < v.Count
                        ? v[validationStatusIdx]
                        : string.Empty;

                // ===============================
                // REVENUE LOSS (Missing CPTs)
                // ===============================
                if (validationStatus.Equals("Missing CPTs", StringComparison.OrdinalIgnoreCase)
                 || validationStatus.Equals("Both Missing and Additional CPTs identified", StringComparison.OrdinalIgnoreCase))
                {
                    agg.RevenueLossPotential +=
                        ParseFinancialDecimal(v, missingAvgPaidIdx);
                }

                // ===============================
                // REVENUE AT RISK (Additional CPTs)
                // ===============================
                if (validationStatus.Equals("Additional CPTs coded", StringComparison.OrdinalIgnoreCase)
                 || validationStatus.Equals("Both Missing and Additional CPTs identified", StringComparison.OrdinalIgnoreCase))
                {
                    agg.RevenueAtRiskPotential +=
                        ParseFinancialDecimal(v, additionalAvgPaidIdx);
                }
            }

            return agg;
        }




        #endregion
        private void AddFinancialSummaryDashboard(
      XLWorkbook workbook,
      string enhancedCsvPath,
      string panelSummaryCsvPath)
        {
            var ws = workbook.AddWorksheet("Financial Dashboard");
            ws.ShowGridLines = false; 
            ws.PageSetup.PaperSize = XLPaperSize.A4Paper;
            ws.PageSetup.PageOrientation = XLPageOrientation.Portrait;

            ws.PageSetup.Margins.Top = 0.5;
            ws.PageSetup.Margins.Bottom = 0.5;
            ws.PageSetup.Margins.Left = 0.5;
            ws.PageSetup.Margins.Right = 0.5;

            ws.PageSetup.CenterHorizontally = true;
            ws.PageSetup.CenterVertically = false;

            ws.Style.Font.FontName = "Calibri";  // Font family
            ws.Style.Font.FontSize = 11;         // Font size



            // =====================================================
            // SOURCE OF TRUTH
            // =====================================================
            var agg = CalculateFinancialAggregates(enhancedCsvPath);

            int totalClaims = agg.TotalClaims;
            int claimsWithIssues = agg.ClaimsWithIssues;

            decimal totalActual = agg.TotalActual;
            decimal totalExpected = agg.TotalExpected;

            decimal complianceRate =
                totalClaims == 0 ? 0 :
                Math.Round(((decimal)(totalClaims - claimsWithIssues) / totalClaims) * 100, 8);

            //decimal complianceRate =
            //  totalClaims == 0 ? 0 :
            //  Math.Round(((decimal)claimsWithIssues/ totalClaims) * 100, 8);

            // =====================================================
            // HEADER
            // =====================================================
            ws.Cell(1, 2).Value = "CODING MASTER VALIDATION - FINANCIAL DASHBOARD";
            ws.Range(1, 2, 1, 6).Merge();
            ws.Range(1, 2, 1, 6).Cells().Style.Font.Bold=true;
            ws.Cell(1, 2).Style.Font.Bold = true;
            //ws.Cell(1, 2).Style.Font.FontSize = 16;
           // ws.Cell(1, 2).Style.Font.FontColor = PrimaryBlue;

            ws.Cell(2, 2).Value = $"Report Date: {DateTime.Now:yyyy-MM-dd HH:mm}";
            ws.Range(2, 2, 2, 6).Merge();


            int row = 4;

            // =====================================================
            // TOTALS (COLUMN FORMAT)
            // =====================================================
            //  WriteSectionHeader(ws, row++, "Totals");

            WriteSectionHeader(ws, row++, "Totals");

            ws.Cell(row, 2).Value = "Total No. of Claims";
            ws.Cell(row, 3).Value = "Total Billed Charges";
            ws.Cell(row, 4).Value = "Expected Billed Charges";

            ws.Range(row, 2, row, 4).Style.Font.Bold = true;
            ws.Range(row, 2, row, 4).Style.Alignment.Horizontal = XLAlignmentHorizontalValues.Center;
            ws.Range(row, 2, row, 4).Style.Border.OutsideBorder = XLBorderStyleValues.Thin;
            ws.Range(row, 2, row, 4).Style.Border.InsideBorder = XLBorderStyleValues.Thin;

            row++;

            ws.Cell(row, 2).Value = totalClaims;
            ws.Cell(row, 3).Value = totalActual;
            ws.Cell(row, 4).Value = totalExpected;

            ws.Cell(row, 3).Style.NumberFormat.Format = "$#,##0.00";
            ws.Cell(row, 4).Style.NumberFormat.Format = "$#,##0.00";

            ws.Range(row, 2, row, 4).Style.Border.OutsideBorder = XLBorderStyleValues.Thin;
            ws.Range(row, 2, row, 4).Style.Border.InsideBorder = XLBorderStyleValues.Thin;

            row += 2;

            // =====================================================
            // REVENUE IMPACT
            // =====================================================
            WriteRevenueSectionHeader   (ws, row++, "Revenue Impact");

            ws.Cell(row, 2).Value = "Total No. of Claims";
            ws.Cell(row, 3).Value = "Total Actual Billed Charges";
            ws.Cell(row, 4).Value = "Potential Loss in Revenue";
            ws.Cell(row, 5).Value = "Expected Potential Recoupements";

            ws.Range(row, 2, row, 5).Style.Font.Bold = true;
            ws.Range(row, 2, row, 5).Style.Alignment.Horizontal = XLAlignmentHorizontalValues.Center;
            ws.Range(row, 2, row, 5).Style.Border.OutsideBorder = XLBorderStyleValues.Thin;
            ws.Range(row, 2, row, 5).Style.Border.InsideBorder = XLBorderStyleValues.Thin;

            row++;

            ws.Cell(row, 2).Value = claimsWithIssues;
            ws.Cell(row, 3).Value =
                agg.MissingOnlyActual + agg.AdditionalOnlyActual + agg.MissingAndAdditionalActual;
            ws.Cell(row, 4).Value = agg.RevenueLossPotential;
            ws.Cell(row, 5).Value = agg.RevenueAtRiskPotential;

            ws.Cell(row, 4).Style.NumberFormat.Format = "$#,##0.00";
            ws.Cell(row, 5).Style.NumberFormat.Format = "$#,##0.00";

            //ws.Cell(row, 4).Value = "-";
            //ws.Cell(row, 5).Value = "-";

            ws.Cell(row, 3).Style.NumberFormat.Format = "$#,##0.00";

            ws.Range(row, 2, row, 5).Style.Border.OutsideBorder = XLBorderStyleValues.Thin;
            ws.Range(row, 2, row, 5).Style.Border.InsideBorder = XLBorderStyleValues.Thin;

            row += 2;

            // =====================================================
            // REVENUE LOSS
            // =====================================================
            WriteSectionHeader(ws, row++, "Revenue Loss");

            ws.Cell(row, 2).Value = "Total No. of Claims";
            ws.Cell(row, 3).Value = "Total Actual Billed Charges";
            ws.Cell(row, 4).Value = "Potential Loss in Revenue";

            ws.Range(row, 2, row, 4).Style.Font.Bold = true;
            ws.Range(row, 2, row, 4).Style.Alignment.Horizontal = XLAlignmentHorizontalValues.Center;
            ws.Range(row, 2, row, 4).Style.Border.OutsideBorder = XLBorderStyleValues.Thin;
            ws.Range(row, 2, row, 4).Style.Border.InsideBorder = XLBorderStyleValues.Thin;

            row++;

            ws.Cell(row, 2).Value = agg.MissingOnlyCount  +agg.MissingAndAdditionalCount;
            ws.Cell(row, 3).Value = agg.MissingOnlyActual +agg.MissingAndAdditionalActual;
            //ws.Cell(row, 4).Value = "-";
            ws.Cell(row, 4).Value = agg.RevenueLossPotential;
            ws.Cell(row, 4).Style.NumberFormat.Format = "$#,##0.00";



            ws.Cell(row, 3).Style.NumberFormat.Format = "$#,##0.00";

            ws.Range(row, 2, row, 4).Style.Border.OutsideBorder = XLBorderStyleValues.Thin;
            ws.Range(row, 2, row, 4).Style.Border.InsideBorder = XLBorderStyleValues.Thin;

            row += 2;

            // =====================================================
            // REVENUE AT RISK
            // =====================================================
            WriteSectionHeader(ws, row++, "Revenue at Risk");

            ws.Cell(row, 2).Value = "Total No. of Claims";
            ws.Cell(row, 3).Value = "Total Actual Billed Charges";
            ws.Cell(row, 4).Value = "Potential Recoupement";

            ws.Range(row, 2, row, 4).Style.Font.Bold = true;
            ws.Range(row, 2, row, 4).Style.Alignment.Horizontal = XLAlignmentHorizontalValues.Center;
            ws.Range(row, 2, row, 4).Style.Border.OutsideBorder = XLBorderStyleValues.Thin;
            ws.Range(row, 2, row, 4).Style.Border.InsideBorder = XLBorderStyleValues.Thin;

            row++;

            ws.Cell(row, 2).Value = agg.AdditionalOnlyCount + agg.MissingAndAdditionalCount;
            ws.Cell(row, 3).Value = agg.AdditionalOnlyActual + agg.MissingAndAdditionalActual;
            ws.Cell(row, 3).Style.NumberFormat.Format = "$#,##0.00";
            //ws.Cell(row, 4).Value = "-";
            ws.Cell(row, 4).Value = agg.RevenueAtRiskPotential;
            ws.Cell(row, 4).Style.NumberFormat.Format = "$#,##0.00";


          

            ws.Range(row, 2, row, 4).Style.Border.OutsideBorder = XLBorderStyleValues.Thin;
            ws.Range(row, 2, row, 4).Style.Border.InsideBorder = XLBorderStyleValues.Thin;

            row += 2;

            // =====================================================
            // COMPLIANCE RATE
            // =====================================================
            WriteSectionHeader(ws, row++, "Compliance Rate");

            ws.Cell(row, 2).Value = "Total No. of Claims";
            ws.Cell(row + 1, 2).Value = totalClaims;

            ws.Cell(row, 3).Value = "Claims with Issues";
            ws.Cell(row + 1, 3).Value = claimsWithIssues;

            ws.Cell(row, 4).Value = "Compliance Rate";
            ws.Cell(row + 1, 4).Value = $"{Math.Round(complianceRate, 0)}%";

            ws.Range(row, 2, row + 1, 4).Style.Border.OutsideBorder = XLBorderStyleValues.Thin;
            ws.Range(row, 2, row + 1, 4).Style.Border.InsideBorder = XLBorderStyleValues.Thin;
            ws.Range(row, 2, row, 4).Style.Font.Bold = true;
            ws.Range(row, 2, row, 4).Style.Alignment.Horizontal = XLAlignmentHorizontalValues.Center;

            row += 3;

            // =====================================================
            // REPORT SUMMARY TABLE (BOTTOM – UNCHANGED LOGIC)
            // =====================================================
            row = WriteReportSummaryTable(ws, row, agg);

            ws.Columns().AdjustToContents();

            Console.WriteLine("✓ Financial Dashboard generated with final formatting");
        }




        private void WriteDashRow(IXLWorksheet ws, int row, string label)
        {
            ws.Cell(row, 1).Value = label;
            ws.Cell(row, 2).Value = "-";
        }


        private void WriteMetricRow(
    IXLWorksheet ws,
    int row,
    string label,
    string value)
        {
            ws.Cell(row, 1).Value = label;
            ws.Cell(row, 2).Value = value;
        }


        private void WriteMetricRow(
    IXLWorksheet ws,
    int row,
    string label,
    decimal value,
    bool isCurrency)
        {
            ws.Cell(row, 1).Value = label;
            ws.Cell(row, 2).Value = value;

            if (isCurrency)
                ws.Cell(row, 2).Style.NumberFormat.Format = "$#,##0.00";
        }

        private void WriteMetricRow(
    IXLWorksheet ws,
    int row,
    string label,
    int value)
        {
            ws.Cell(row, 1).Value = label;
            ws.Cell(row, 2).Value = value;
        }

        private void WriteSectionHeader(IXLWorksheet ws, int row, string title)
        {
            XLColor bg = title switch
            {
                "Totals" => TotalsBar,
                "Revenue Impact" => RevenueImpactBar,
                "Revenue Loss" => RevenueLossBar,
                "Revenue at Risk" => RevenueRiskBar,
                "Compliance Rate" => ComplianceBar,
                _ => ComplianceBar
            };

            ws.Cell(row, 2).Value = title;
            ws.Range(row, 2, row, 4).Merge();

            ws.Row(row).Height = 14;

            ws.Cell(row, 2).Style.Font.Bold = true;
            ws.Cell(row, 2).Style.Font.FontSize = 10;
            ws.Cell(row, 2).Style.Font.FontColor = XLColor.White;
            ws.Cell(row, 2).Style.Font.FontName = BodyFont;

            ws.Cell(row, 2).Style.Alignment.Vertical = XLAlignmentVerticalValues.Center;
            ws.Cell(row, 2).Style.Alignment.Horizontal = XLAlignmentHorizontalValues.Left;

            ws.Range(row, 2, row, 4).Style.Fill.BackgroundColor = bg;
        }

        //private void WriteSectionHeader(IXLWorksheet ws,int row,string title)
        //{
        //    XLColor bg = title switch
        //    {
        //        "Totals" => AccentBlue,
        //        "Revenue Impact" => AccentOrange,
        //        "Revenue Loss" => AccentRed,
        //        "Revenue at Risk" => AccentGreen,
        //        "Compliance Rate" => PrimaryBlue,
        //        _ => PrimaryBlue
        //    };

        //    ws.Cell(row, 2).Value = title;
        //    ws.Range(row, 2, row, 4).Merge();

        //    ws.Row(row).Height = 14;


        //    ws.Cell(row, 2).Style.Font.Bold = true;
        //    ws.Cell(row, 2).Style.Font.FontSize = 10;   // 🔥 as requested
        //    ws.Cell(row, 2).Style.Font.FontColor = XLColor.White;
        //    ws.Cell(row, 2).Style.Font.FontName = HeaderFont;

        //    ws.Cell(row, 2).Style.Alignment.Horizontal = XLAlignmentHorizontalValues.Left;
        //    ws.Cell(row, 2).Style.Alignment.Vertical = XLAlignmentVerticalValues.Center;

        //    ws.Range(row, 2, row, 4).Style.Fill.BackgroundColor = bg;
        //}

        //private void WriteRevenueSectionHeader(IXLWorksheet ws, int row, string title)
        //{
        //    XLColor bg = title switch
        //    {
        //        "Totals" => AccentBlue,
        //        "Revenue Impact" => AccentOrange,
        //        "Revenue Loss" => AccentRed,
        //        "Revenue at Risk" => AccentGreen,
        //        "Compliance Rate" => PrimaryBlue,
        //        _ => PrimaryBlue
        //    };

        //    ws.Cell(row, 2).Value = title;
        //    ws.Range(row, 2, row, 5).Merge();

        //    ws.Row(row).Height = 14;

        //    ws.Cell(row, 2).Style.Font.Bold = true;
        //    ws.Cell(row, 2).Style.Font.FontSize = 10;   // 🔥 as requested
        //    ws.Cell(row, 2).Style.Font.FontColor = XLColor.White;
        //    ws.Cell(row, 2).Style.Font.FontName = HeaderFont;

        //    ws.Cell(row, 2).Style.Alignment.Horizontal = XLAlignmentHorizontalValues.Left;
        //    ws.Cell(row, 2).Style.Alignment.Vertical = XLAlignmentVerticalValues.Center;

        //    ws.Range(row, 2, row, 4).Style.Fill.BackgroundColor = bg;
        //}

        private void WriteRevenueSectionHeader(IXLWorksheet ws, int row, string title)
        {
            XLColor bg = title switch
            {
                "Totals" => TotalsBar,
                "Revenue Impact" => RevenueImpactBar,
                "Revenue Loss" => RevenueLossBar,
                "Revenue at Risk" => RevenueRiskBar,
                "Compliance Rate" => ComplianceBar,
                _ => ComplianceBar
            };

            ws.Cell(row, 2).Value = title;
            ws.Range(row, 2, row, 5).Merge();

            ws.Row(row).Height = 14;

            ws.Cell(row, 2).Style.Font.Bold = true;
            ws.Cell(row, 2).Style.Font.FontSize = 10;
            ws.Cell(row, 2).Style.Font.FontColor = XLColor.White;
            ws.Cell(row, 2).Style.Font.FontName = BodyFont;

            ws.Cell(row, 2).Style.Alignment.Vertical = XLAlignmentVerticalValues.Center;
            ws.Cell(row, 2).Style.Alignment.Horizontal = XLAlignmentHorizontalValues.Left;

            ws.Range(row, 2, row, 5).Style.Fill.BackgroundColor = bg;
        }


        private int WriteReportSummaryTable(
         IXLWorksheet ws,
         int startRow,
         FinancialAggregates agg)
        {
            int row = startRow;

            // ================= HEADER =================
            ws.Cell(row, 3).Value = "Claim Count";
            ws.Cell(row, 4).Value = "Total Billed Charges";
            ws.Cell(row, 5).Value = "Expected Billed Charges";

            ws.Range(row, 2, row, 5).Style.Font.Bold = true;
            ws.Range(row, 2, row, 5).Style.Alignment.Horizontal = XLAlignmentHorizontalValues.Center;
            ws.Range(row, 2, row, 5).Style.Fill.BackgroundColor = LightGray;
            ws.Range(row, 2, row, 5).Style.Border.OutsideBorder = XLBorderStyleValues.Thin;
            ws.Range(row, 2, row, 5).Style.Border.InsideBorder = XLBorderStyleValues.Thin;

            row++;

            void AddRow(string label, int count, decimal actual, decimal expected)
            {
                ws.Cell(row, 2).Value = label;
                ws.Cell(row, 3).Value = count;
                ws.Cell(row, 4).Value = actual;
                ws.Cell(row, 5).Value = expected;

                ws.Cell(row, 4).Style.NumberFormat.Format = "$#,##0.00";
                ws.Cell(row, 5).Style.NumberFormat.Format = "$#,##0.00";

                ws.Range(row, 2, row, 5).Style.Border.OutsideBorder = XLBorderStyleValues.Thin;
                ws.Range(row, 2, row, 5).Style.Border.InsideBorder = XLBorderStyleValues.Thin;

                row++;
            }

            AddRow("Total Claims",
                agg.TotalClaims,
                agg.TotalActual,
                agg.TotalExpected);

            AddRow("Claims with Issues",
                agg.ClaimsWithIssues,
                agg.MissingOnlyActual + agg.AdditionalOnlyActual + agg.MissingAndAdditionalActual,
                agg.MissingOnlyExpected + agg.AdditionalOnlyExpected + agg.MissingAndAdditionalExpected);

            AddRow("Claims with Missing CPTs",
                agg.MissingOnlyCount,
                agg.MissingOnlyActual,
                agg.MissingOnlyExpected);

            AddRow("Claims with Additional CPTs",
                agg.AdditionalOnlyCount,
                agg.AdditionalOnlyActual,
                agg.AdditionalOnlyExpected);

            AddRow("Claims with Missing and Additional CPTs",
                agg.MissingAndAdditionalCount,
                agg.MissingAndAdditionalActual,
                agg.MissingAndAdditionalExpected);

            AddRow("Total Error",
                agg.MissingOnlyCount + agg.MissingAndAdditionalCount,
                agg.MissingOnlyActual + agg.MissingAndAdditionalActual,
                agg.MissingOnlyExpected + agg.MissingAndAdditionalExpected);

            // ================= COMPLIANCE RATE =================
            decimal complianceRate =
                agg.TotalClaims == 0 ? 0 :
                Math.Round(((decimal)(agg.TotalClaims - agg.ClaimsWithIssues) / agg.TotalClaims) * 100, 8);

            //decimal complianceRate =
            //    agg.TotalClaims == 0 ? 0 :
            //    Math.Round(((decimal)( agg.ClaimsWithIssues) / agg.TotalClaims) * 100, 8);


            ws.Cell(row, 2).Value = "Compliance Rate";
            ws.Cell(row, 3).Value = $"{Math.Round(complianceRate, 2)}%";
            ws.Cell(row, 4).Value =
                (agg.MissingOnlyExpected + agg.MissingAndAdditionalExpected)
                - (agg.MissingOnlyActual + agg.MissingAndAdditionalActual);

            ws.Cell(row, 4).Style.NumberFormat.Format = "$#,##0.00";

            ws.Range(row, 2, row, 5).Style.Border.OutsideBorder = XLBorderStyleValues.Thin;
            ws.Range(row, 2, row,5).Style.Border.InsideBorder = XLBorderStyleValues.Thin;

            row++;

            ws.Cell(row, 2).Value = "Revenue Impact";
            ws.Range(row, 2, row, 5).Style.Border.OutsideBorder = XLBorderStyleValues.Thin;
            ws.Range(row, 2, row, 5).Style.Border.InsideBorder = XLBorderStyleValues.Thin;

            return row + 2;
        }



        //old finalcialdashboard

        //  private void AddFinancialSummaryDashboard(
        //XLWorkbook workbook,
        //string enhancedCsvPath,
        //string panelSummaryCsvPath) // kept for signature compatibility
        //  {
        //      var ws = workbook.AddWorksheet("Financial Dashboard");

        //      // =====================================================
        //      // 1️⃣ SINGLE-PASS CALCULATION (SOURCE OF TRUTH)
        //      // =====================================================
        //      var agg = CalculateFinancialAggregates(enhancedCsvPath);

        //      int totalErrorCount =
        //          agg.MissingOnlyCount +
        //         // agg.AdditionalOnlyCount +
        //          agg.MissingAndAdditionalCount;

        //      decimal totalErrorActual =
        //          agg.MissingOnlyActual +
        //        //  agg.AdditionalOnlyActual +
        //          agg.MissingAndAdditionalActual;

        //      decimal totalErrorExpected =
        //          agg.MissingOnlyExpected +
        //       //   agg.AdditionalOnlyExpected +
        //          agg.MissingAndAdditionalExpected;

        //      decimal complianceRate =
        //          agg.TotalClaims == 0
        //              ? 0
        //              : Math.Round(
        //                  ((decimal)(agg.TotalClaims - agg.ClaimsWithIssues) / agg.TotalClaims) * 100,
        //                  8);

        //      decimal revenueImpact =
        //          Math.Round(totalErrorExpected - totalErrorActual, 2);

        //      // =====================================================
        //      // 2️⃣ TITLE
        //      // =====================================================
        //      ws.Cell(1, 1).Value = "CODING MASTER VALIDATION - FINANCIAL SUMMARY";
        //      ws.Range(1, 1, 1, 8).Merge();
        //      ws.Row(1).Height = 30;

        //      ws.Cell(1, 1).Style.Font.Bold = true;
        //      ws.Cell(1, 1).Style.Font.FontSize = 16;
        //      ws.Cell(1, 1).Style.Font.FontColor = PrimaryBlue;

        //      ws.Cell(2, 1).Value = $"Report Date: {DateTime.Now:yyyy-MM-dd HH:mm}";
        //      ws.Range(2, 1, 2, 8).Merge();

        //      // =====================================================
        //      // 3️⃣ REPORT SUMMARY TABLE
        //      // =====================================================
        //      int row = 4;

        //      ws.Cell(row, 2).Value = "Claim Count";
        //      ws.Cell(row, 3).Value = "Total Billed Charges";
        //      ws.Cell(row, 4).Value = "Expected Billed Charges";
        //      ws.Range(row, 2, row, 4).Style.Font.Bold = true;
        //      row++;

        //      void AddRow(string label, int count, decimal actual, decimal expected)
        //      {
        //          ws.Cell(row, 1).Value = label;
        //          ws.Cell(row, 2).Value = count;
        //          ws.Cell(row, 3).Value = actual;
        //          ws.Cell(row, 4).Value = expected;

        //          ws.Cell(row, 3).Style.NumberFormat.Format = "$#,##0.00";
        //          ws.Cell(row, 4).Style.NumberFormat.Format = "$#,##0.00";
        //          row++;
        //      }

        //      AddRow("Total Claims",
        //          agg.TotalClaims,
        //          agg.TotalActual,
        //          agg.TotalExpected);

        //      AddRow("Claims with Issues",
        //          agg.ClaimsWithIssues,
        //          agg.TotalActual - totalErrorActual,
        //          agg.TotalExpected - totalErrorExpected);

        //      AddRow("Claims with Missing CPTs",
        //          agg.MissingOnlyCount,
        //          agg.MissingOnlyActual,
        //          agg.MissingOnlyExpected);

        //      AddRow("Claims with Additional CPTs",
        //          agg.AdditionalOnlyCount,
        //          agg.AdditionalOnlyActual,
        //          agg.AdditionalOnlyExpected);

        //      AddRow("Claims with Missing and Additional CPTs",
        //          agg.MissingAndAdditionalCount,
        //          agg.MissingAndAdditionalActual,
        //          agg.MissingAndAdditionalExpected);

        //      AddRow("Total Error",
        //          totalErrorCount,
        //          totalErrorActual,
        //          totalErrorExpected);

        //      ws.Cell(row, 1).Value = "Compliance Rate";
        //      ws.Cell(row, 2).Value = complianceRate;
        //      ws.Cell(row, 3).Value = revenueImpact;
        //      ws.Cell(row, 3).Style.NumberFormat.Format = "$#,##0.00";
        //      row++;

        //      ws.Cell(row, 1).Value = "Revenue Impact";

        //      // =====================================================
        //      // 4️⃣ KPI BOXES
        //      // =====================================================
        //      int kpiRow = row + 3;

        //      // Leave 2 blank rows after table
        //      int kpiStartRow = row + 2;
        //      // Freeze everything ABOVE the KPI section
        //    //  ws.SheetView.FreezeRows(kpiStartRow + 1);

        //      CreateKpiBox(ws, kpiStartRow, 1,
        //          "Total Claims",
        //          agg.TotalClaims.ToString("N0"),
        //          agg.TotalActual.ToString("C2"),
        //          "#4472C4");

        //      //CreateKpiBox(ws, kpiStartRow, 4,
        //      //    "Total Claims with Issue",
        //      //    agg.ClaimsWithIssues.ToString("N0"),
        //      //    (agg.TotalActual - totalErrorActual).ToString("C2"),
        //      //    "#ED7D31");

        //      string issueIcon = agg.ClaimsWithIssues > 0 ? "▼" : "●";

        //      CreateKpiBox(ws, kpiStartRow, 4,
        //          "Total Claims with Issue",
        //          $"{issueIcon} {agg.ClaimsWithIssues:N0}",
        //          (agg.TotalActual - totalErrorActual).ToString("C2"),
        //          "#ED7D31");




        //      //CreateKpiBox(ws, kpiStartRow, 7,
        //      //    "Claims with Revenue Impact",
        //      //    totalErrorCount.ToString("N0"),
        //      //    revenueImpact.ToString("C2"),
        //      //    "#C00000");

        //      string revenueIcon = GetKpiIcon(revenueImpact);
        //      string revenueText = $"{revenueIcon} {revenueImpact:C2}";

        //      CreateKpiBox(ws, kpiStartRow, 7,
        //          "Claims with Revenue Impact",
        //          totalErrorCount.ToString("N0"),
        //          revenueText,
        //          revenueImpact >= 0 ? "#70AD47" : "#C00000");




        //      //CreateKpiBox(ws, kpiStartRow, 10,
        //      //    "Compliance Rate",
        //      //    complianceRate.ToString("F8"),
        //      //    string.Empty,   // No amount for compliance
        //      //    "#2F75B5");
        //      string complianceIcon = complianceRate >= 95 ? "▲" : "▼";
        //      string complianceText = $"{complianceIcon} {complianceRate:F2}%";

        //      CreateSingleValueKpiBox(
        //          ws,
        //          kpiStartRow,
        //          10,
        //          "Compliance Rate",
        //          complianceText,
        //          complianceRate >= 95 ? "#70AD47" : "#ED7D31"
        //      );






        //      //CreateKpiBox(ws, kpiRow, 1,
        //      //    "Total Claims",
        //      //    agg.TotalClaims.ToString("N0"),
        //      //    "#4472C4");

        //      //CreateKpiBox(ws, kpiRow, 3,
        //      //    "Total Claims with Issue",
        //      //    agg.ClaimsWithIssues.ToString("N0"),
        //      //    "#ED7D31");

        //      //CreateKpiBox(ws, kpiRow, 5,
        //      //    "Claims with Revenue Impact",
        //      //    totalErrorCount.ToString("N0"),
        //      //    "#C00000");

        //      //CreateKpiBox(ws, kpiRow, 7,
        //      //    "Compliance Rate",
        //      //    complianceRate.ToString("F8"),
        //      //    "#2F75B5");

        //      // =====================================================
        //      // 5️⃣ RECOMMENDATIONS
        //      // =====================================================
        //      int recoRow = kpiRow + 4;

        //      ws.Cell(recoRow, 1).Value = "RECOMMENDATIONS & NEXT STEPS";
        //      ws.Range(recoRow, 1, recoRow, 8).Merge();
        //      ws.Cell(recoRow, 1).Style.Font.Bold = true;
        //      ws.Cell(recoRow, 1).Style.Font.FontSize = 12;
        //      ws.Cell(recoRow, 1).Style.Font.FontColor = PrimaryBlue;

        //      recoRow++;
        //      ws.Cell(recoRow, 1).Value =
        //          $"1. Review missing CPT codes causing {agg.MissingOnlyActual:C2} in lost revenue";
        //      recoRow++;
        //      ws.Cell(recoRow, 1).Value =
        //          "2. Validate additional CPT codes to ensure proper billing compliance";
        //      recoRow++;
        //      ws.Cell(recoRow, 1).Value =
        //          "3. Update Coding Master for panels with consistent discrepancies";
        //      recoRow++;
        //      ws.Cell(recoRow, 1).Value =
        //          "4. Schedule training for coders on problematic panels";

        //      Console.WriteLine("✓ Financial Dashboard generated using SINGLE-PASS Enhanced CSV");
        //  }




        //    private void CreateKpiBox(
        //IXLWorksheet worksheet,
        //int row,
        //int col,
        //string title,   
        //string countValue,
        //string amountValue,
        //string color)
        //    {
        //        // Title cell
        //        var titleCell = worksheet.Cell(row, col);
        //        titleCell.Value = title;
        //        titleCell.Style.Font.Bold = true;
        //        titleCell.Style.Font.FontSize = 11;
        //        titleCell.Style.Font.FontColor = XLColor.White;
        //        titleCell.Style.Fill.BackgroundColor = XLColor.FromHtml(color);
        //        titleCell.Style.Alignment.Horizontal = XLAlignmentHorizontalValues.Center;
        //        titleCell.Style.Border.OutsideBorder = XLBorderStyleValues.Medium;

        //        // Count cell
        //        var countCell = worksheet.Cell(row + 1, col);
        //        countCell.Value = countValue;
        //        countCell.Style.Font.FontName = HeaderFont;
        //        countCell.Style.Font.FontSize = 15;
        //        countCell.Style.Font.Bold = true;
        //        countCell.Style.Font.FontColor = PrimaryBlue;
        //        countCell.Style.Alignment.Horizontal = XLAlignmentHorizontalValues.Center;
        //        countCell.Style.Fill.BackgroundColor = LightGray;
        //        countCell.Style.Border.OutsideBorder = XLBorderStyleValues.Medium;

        //        // Amount cell
        //        var amountCell = worksheet.Cell(row + 1, col + 1);
        //        amountCell.Value = amountValue;
        //        amountCell.Style.Font.FontName = HeaderFont;
        //        amountCell.Style.Font.FontSize = 15;
        //        amountCell.Style.Font.Bold = true;
        //        amountCell.Style.Font.FontColor = PrimaryBlue;
        //        amountCell.Style.Alignment.Horizontal = XLAlignmentHorizontalValues.Center;
        //        amountCell.Style.Fill.BackgroundColor = LightGray;
        //        amountCell.Style.Border.OutsideBorder = XLBorderStyleValues.Medium;

        //        worksheet.Column(col).Width = 18;
        //        worksheet.Column(col + 1).Width = 22;
        //        worksheet.Row(row).Height = 25;
        //        worksheet.Row(row + 1).Height = 35;
        //    }

        private void CreateKpiBox(IXLWorksheet ws, int row,int col,string title,
                    string countValue,
                    string amountValue,
                    string color)
        {
            // TITLE (merged across 2 columns)
            var titleRange = ws.Range(row, col, row, col + 1);
            titleRange.Merge();
            titleRange.Value = title;

            titleRange.Style.Font.Bold = true;
            titleRange.Style.Font.FontSize = 11;
            titleRange.Style.Font.FontColor = XLColor.White;
            titleRange.Style.Fill.BackgroundColor = XLColor.FromHtml(color);
            titleRange.Style.Alignment.Horizontal = XLAlignmentHorizontalValues.Center;
            titleRange.Style.Alignment.Vertical = XLAlignmentVerticalValues.Center;
            titleRange.Style.Border.OutsideBorder = XLBorderStyleValues.Medium;

            // COUNT
            var countCell = ws.Cell(row + 1, col);
            countCell.Value = countValue;
            countCell.Style.Font.Bold = true;
            countCell.Style.Font.FontSize = 15;
            countCell.Style.Font.FontColor = PrimaryBlue;
            countCell.Style.Alignment.Horizontal = XLAlignmentHorizontalValues.Center;
            countCell.Style.Fill.BackgroundColor = LightGray;
            countCell.Style.Border.OutsideBorder = XLBorderStyleValues.Medium;

            // AMOUNT (optional)
            var amountCell = ws.Cell(row + 1, col + 1);
            amountCell.Value = amountValue;
            amountCell.Style.Font.Bold = true;
            amountCell.Style.Font.FontSize = 15;
            amountCell.Style.Font.FontColor = PrimaryBlue;
            amountCell.Style.Alignment.Horizontal = XLAlignmentHorizontalValues.Center;
            amountCell.Style.Fill.BackgroundColor = LightGray;
            amountCell.Style.Border.OutsideBorder = XLBorderStyleValues.Medium;

            ws.Column(col).Width = 18;
            ws.Column(col + 1).Width = 22;
            ws.Row(row).Height = 24;
            ws.Row(row + 1).Height = 34;
        }

        private string GetKpiIcon(decimal value, decimal threshold = 0)
        {
            if (value > threshold) return "▲";
            if (value < threshold) return "▼";
            return "●";
        }
        private void CreateSingleValueKpiBox(
    IXLWorksheet ws,
    int row,
    int col,
    string title,
    string valueWithIcon,
    string headerColor)
        {
            // TITLE (merged across 2 columns)
            var titleRange = ws.Range(row, col, row, col + 1);
            titleRange.Merge();
            titleRange.Value = title;

            titleRange.Style.Font.Bold = true;
            titleRange.Style.Font.FontSize = 11;
            titleRange.Style.Font.FontColor = XLColor.White;
            titleRange.Style.Fill.BackgroundColor = XLColor.FromHtml(headerColor);
            titleRange.Style.Alignment.Horizontal = XLAlignmentHorizontalValues.Center;
            titleRange.Style.Alignment.Vertical = XLAlignmentVerticalValues.Center;
            titleRange.Style.Border.OutsideBorder = XLBorderStyleValues.Medium;

            // VALUE (merged across 2 columns)
            var valueRange = ws.Range(row + 1, col, row + 1, col + 1);
            valueRange.Merge();
            valueRange.Value = valueWithIcon;

            valueRange.Style.Font.Bold = true;
            valueRange.Style.Font.FontSize = 16;
            valueRange.Style.Font.FontColor = PrimaryBlue;
            valueRange.Style.Alignment.Horizontal = XLAlignmentHorizontalValues.Center;
            valueRange.Style.Alignment.Vertical = XLAlignmentVerticalValues.Center;
            valueRange.Style.Fill.BackgroundColor = LightGray;
            valueRange.Style.Border.OutsideBorder = XLBorderStyleValues.Medium;

            ws.Column(col).Width = 20;
            ws.Column(col + 1).Width = 20;
            ws.Row(row).Height = 24;
            ws.Row(row + 1).Height = 36;
        }


        private void CreateKpiBox(IXLWorksheet worksheet, int row, int col, string title, string value, string color)
        {
            var cell = worksheet.Cell(row, col);
            cell.Value = title;
            cell.Style.Font.Bold = true;
            cell.Style.Font.FontSize = 11;
            cell.Style.Font.FontColor = XLColor.White;
            cell.Style.Fill.BackgroundColor = XLColor.FromHtml(color);
            cell.Style.Alignment.Horizontal = XLAlignmentHorizontalValues.Center;
            cell.Style.Border.OutsideBorder = XLBorderStyleValues.Medium;
            cell.Style.Border.OutsideBorderColor = XLColor.FromHtml(color);

            var valueCell = worksheet.Cell(row + 1, col);
            valueCell.Value = value;
            //valueCell.Style.Font.Bold = true;
            //valueCell.Style.Font.FontSize = 14;
            //valueCell.Style.Alignment.Horizontal = XLAlignmentHorizontalValues.Center;
            //valueCell.Style.Fill.BackgroundColor = XLColor.FromHtml("#F2F2F2");
            //valueCell.Style.Border.OutsideBorder = XLBorderStyleValues.Thin;


            valueCell.Style.Font.FontName = HeaderFont;
            valueCell.Style.Font.FontSize = 15;
            valueCell.Style.Font.Bold = true;
            valueCell.Style.Font.FontColor = PrimaryBlue;
            valueCell.Style.Alignment.Horizontal = XLAlignmentHorizontalValues.Center;

            valueCell.Style.Fill.BackgroundColor = LightGray;
            valueCell.Style.Border.OutsideBorder = XLBorderStyleValues.Medium;



            worksheet.Column(col).Width = 20;
            worksheet.Row(row).Height = 25;
            worksheet.Row(row + 1).Height = 35;
        }

        private void AddEnhancedValidationSummary(IXLWorksheet worksheet, string[] lines)
        {
            int lastRow = lines.Length;
            int summaryRow = lastRow + 3;

            worksheet.Cell(summaryRow, 1).Value = "REPORT SUMMARY";
            worksheet.Cell(summaryRow, 1).Style.Font.Bold = true;
            worksheet.Cell(summaryRow, 1).Style.Font.FontSize = 12;
            worksheet.Range(summaryRow, 1, summaryRow, 3).Merge();

            summaryRow++;
            worksheet.Cell(summaryRow, 1).Value = $"• Total Records: {lines.Length - 1}";
            summaryRow++;
            worksheet.Cell(summaryRow, 1).Value = $"• Generated: {DateTime.Now:yyyy-MM-dd HH:mm}";
            summaryRow++;
            worksheet.Cell(summaryRow, 1).Value = "• Data Source: Enhanced Validation Report";
        }

        private void FormatWorkbookTabs(XLWorkbook workbook)
        {
            // Format tab colors for better visual organization[citation:3]
            //if (workbook.Worksheets.Count >= 1)
            //    workbook.Worksheet("Enhanced Validation").TabColor = XLColor.FromHtml("#4472C4"); // Blue

            //if (workbook.Worksheets.Count >= 2)
            //    workbook.Worksheet("Panel Summary").TabColor = XLColor.FromHtml("#ED7D31"); // Orange

            //if (workbook.Worksheets.Count >= 3)
            //    workbook.Worksheet("Financial Dashboard").TabColor = XLColor.FromHtml("#70AD47"); // Green


            workbook.Worksheet("Financial Dashboard").TabColor = AccentGreen;
            workbook.Worksheet("Panel Summary").TabColor = AccentBlue;
            workbook.Worksheet("CodingValidated").TabColor = PrimaryBlue;



        }

        private void AutoAdjustColumns(XLWorkbook workbook)
        {
            foreach (var worksheet in workbook.Worksheets)
            {
                worksheet.Columns().AdjustToContents();
            }
        }
        private bool IsAmountColumn(string header)
        {
            return header.Contains("Amount", StringComparison.OrdinalIgnoreCase)
                || header.Contains("Charge", StringComparison.OrdinalIgnoreCase)
                || header.Contains("Payment", StringComparison.OrdinalIgnoreCase)
                || header.Contains("Balance", StringComparison.OrdinalIgnoreCase);
        }

        private List<string> ParseCsvLine(string line)
        {
            var result = new List<string>();
            bool inQuotes = false;
            string currentField = "";

            for (int i = 0; i < line.Length; i++)
            {
                char currentChar = line[i];

                if (currentChar == '"')
                {
                    inQuotes = !inQuotes;
                }
                else if (currentChar == ',' && !inQuotes)
                {
                    result.Add(currentField.Trim());
                    currentField = "";
                }
                else
                {
                    currentField += currentChar;
                }
            }

            result.Add(currentField.Trim());
            return result;
        }

        //private bool IsPCRALLab()
        //{
        //    return _sourceFileName
        //        .Contains("PCRAL", StringComparison.OrdinalIgnoreCase);
        //}

        private bool IsPCRALLab()
        {
            return _lab.InputFolder
                .Contains(@"\PCRAL\", StringComparison.OrdinalIgnoreCase);
        }

        private class FinancialAggregates
        {
            public int TotalClaims;
            public int ClaimsWithIssues;

            public int MissingOnlyCount;
            public int AdditionalOnlyCount;
            public int MissingAndAdditionalCount;

            public decimal TotalActual;
            public decimal TotalExpected;

            public decimal MissingOnlyActual;
            public decimal MissingOnlyExpected;

            public decimal AdditionalOnlyActual;
            public decimal AdditionalOnlyExpected;

            public decimal MissingAndAdditionalActual;
            public decimal MissingAndAdditionalExpected;

            public decimal RevenueLossPotential;
            public decimal RevenueAtRiskPotential;

        }



        public class FinancialSummary
        {
            public int ClaimCount { get; set; }
            public decimal TotalBilledCharges { get; set; }
            public decimal ExpectedBilledCharges { get; set; }
        }



        private void AddPivotSummaryWorksheet(XLWorkbook workbook, string enhancedCsvPath)
        {
            var worksheet = workbook.AddWorksheet("Pivot Summary");

            var lines = File.ReadAllLines(enhancedCsvPath);
            if (lines.Length <= 1) return;

            var headers = ParseCsvLine(lines[0]);

            Console.WriteLine("Pivot headers found:");
            headers.ForEach(h => Console.WriteLine($" - {h}"));


            int panelIdx = headers.FindIndex(h => h.Equals("PanelName", StringComparison.OrdinalIgnoreCase));
            //int payerIdx = headers.FindIndex(h => h.Equals("Payer", StringComparison.OrdinalIgnoreCase));

            int payerIdx = headers.FindIndex(h =>
                h.Equals("Payer", StringComparison.OrdinalIgnoreCase) ||
                h.Equals("Carrier", StringComparison.OrdinalIgnoreCase) ||
                h.Equals("PayerName", StringComparison.OrdinalIgnoreCase) ||
                h.Equals("Payer Short Code", StringComparison.OrdinalIgnoreCase) ||
                h.Equals("PayerShortCode", StringComparison.OrdinalIgnoreCase)
            );

            int missingIdx = headers.FindIndex(h => h.Contains("Missing", StringComparison.OrdinalIgnoreCase));
            int additionalIdx = headers.FindIndex(h => h.Contains("Additional", StringComparison.OrdinalIgnoreCase));
            if (panelIdx == -1 || payerIdx == -1)
            {
                throw new InvalidOperationException(
                    $"Pivot failed: Required columns not found. " +
                    $"PanelIdx={panelIdx}, PayerIdx={payerIdx}");
            }
            var data = lines.Skip(1)
                .Select(ParseCsvLine)
                .Where(v => v.Count > Math.Max(panelIdx, payerIdx))
                .GroupBy(v => new
                {
                    Panel = panelIdx < v.Count ? v[panelIdx] : "UNKNOWN",
                    Payer = payerIdx < v.Count ? v[payerIdx] : "UNKNOWN"
                })
                .Select(g => new
                {
                    g.Key.Panel,
                    g.Key.Payer,
                    Claims = g.Count(),
                    Missing = g.Sum(v => missingIdx < v.Count ? ParseDecimal(v, missingIdx) : 0),
                    Additional = g.Sum(v => additionalIdx < v.Count ? ParseDecimal(v, additionalIdx) : 0)
                })
                .ToList();


            // Headers
            string[] pivotHeaders =
            {
        "Panel Name", "Payer", "Total Claims",
        "Missing Charges", "Additional Charges", "Net Impact"
    };

            for (int c = 0; c < pivotHeaders.Length; c++)
            {
                var cell = worksheet.Cell(1, c + 1);
                cell.Value = pivotHeaders[c];
                cell.Style.Font.Bold = true;
                cell.Style.Fill.BackgroundColor = AccentBlue;
                cell.Style.Font.FontColor = XLColor.White;
                cell.Style.Alignment.Horizontal = XLAlignmentHorizontalValues.Center;
            }

            // Data
            int row = 2;
            foreach (var item in data)
            {
                worksheet.Cell(row, 1).Value = item.Panel;
                worksheet.Cell(row, 2).Value = item.Payer;
                worksheet.Cell(row, 3).Value = item.Claims;
                worksheet.Cell(row, 4).Value = item.Missing;
                worksheet.Cell(row, 5).Value = item.Additional;
                worksheet.Cell(row, 6).Value = item.Additional - item.Missing;

                worksheet.Range(row, 4, row, 6)
                    .Style.NumberFormat.Format = "$#,##0.00;[Red]-$#,##0.00";

                row++;
            }

            worksheet.SheetView.FreezeRows(1);
            worksheet.Columns().AdjustToContents();
        }

        //private decimal ParseDecimal(List<string> values, int index)
        //{
        //    if (index < 0 || index >= values.Count) return 0;
        //    decimal.TryParse(values[index].Replace("$", "").Replace(",", ""), out decimal val);
        //    return val;
        //}

     
        // Helper method to get column index with multiple possible names
        private int GetColumnIndex(List<string> headers, params string[] possibleNames)
        {
            for (int i = 0; i < headers.Count; i++)
            {
                foreach (var name in possibleNames)
                {
                    if (headers[i].Equals(name, StringComparison.OrdinalIgnoreCase))
                        return i;
                }
            }
            return -1;
        }

        // Helper method to parse decimal safely
        private decimal ParseDecimal(List<string> values, int index)
        {
            if (index < 0 || index >= values.Count)
                return 0;

            var value = values[index];
            if (string.IsNullOrWhiteSpace(value))
                return 0;

            // Remove quotes, dollar signs, and commas
            value = value.Trim('"', ' ', '$', ',');

            if (decimal.TryParse(value, out decimal result))
                return result;

            return 0;
        }


        #region notinuse

        private decimal CalculateRevenueImpact(decimal actualBilled, decimal expectedBilled)
        {
            return expectedBilled - actualBilled;
          //  return Math.Round(expectedBilled - actualBilled, 2);
        }


        private decimal CalculateComplianceRate(int totalClaims, int claimsWithIssues)
        {
            if (totalClaims == 0) return 0;
            return Math.Round(
                ((decimal)(totalClaims - claimsWithIssues) / totalClaims) * 100,
                8
            );
        }


        private FinancialSummary CalculateTotalError(
    FinancialSummary missing,
    FinancialSummary additional,
    FinancialSummary both)
        {
            return new FinancialSummary
            {
                ClaimCount = missing.ClaimCount + additional.ClaimCount + both.ClaimCount,
                TotalBilledCharges = missing.TotalBilledCharges
                                    + additional.TotalBilledCharges
                                    + both.TotalBilledCharges,
                ExpectedBilledCharges = missing.ExpectedBilledCharges
                                       + additional.ExpectedBilledCharges
                                       + both.ExpectedBilledCharges
            };
        }

        private FinancialSummary CalculateMissingAndAdditional(string enhancedCsvPath)
        {
            var lines = File.ReadAllLines(enhancedCsvPath);
            var headers = ParseCsvLine(lines[0]);

            int missingIdx = GetFinancialColumnIndex(headers, "Missing Amount");
            int additionalIdx = GetFinancialColumnIndex(headers, "Additional Amount");
            int actualIdx = GetFinancialColumnIndex(headers, "TotalCharge");
            int expectedIdx = GetFinancialColumnIndex(headers, "Expected Charges");

            int count = 0;
            decimal actual = 0, expected = 0;

            for (int i = 1; i < lines.Length; i++)
            {
                var v = ParseCsvLine(lines[i]);

                if (ParseFinancialDecimal(v, missingIdx) > 0 &&
                    ParseFinancialDecimal(v, additionalIdx) > 0)
                {
                    count++;
                    actual += ParseFinancialDecimal(v, actualIdx);
                    expected += ParseFinancialDecimal(v, expectedIdx);
                }
            }

            return new FinancialSummary
            {
                ClaimCount = count,
                TotalBilledCharges = actual,
                ExpectedBilledCharges = expected
            };
        }




        private FinancialSummary CalculateAdditionalOnly(string enhancedCsvPath)
        {
            var lines = File.ReadAllLines(enhancedCsvPath);
            var headers = ParseCsvLine(lines[0]);

            int missingIdx = GetFinancialColumnIndex(headers, "Missing Amount");
            int additionalIdx = GetFinancialColumnIndex(headers, "Additional Amount");
            int actualIdx = GetFinancialColumnIndex(headers, "TotalCharge");
            int expectedIdx = GetFinancialColumnIndex(headers, "Expected Charges");

            int count = 0;
            decimal actual = 0, expected = 0;

            for (int i = 1; i < lines.Length; i++)
            {
                var v = ParseCsvLine(lines[i]);

                if (ParseFinancialDecimal(v, missingIdx) == 0 &&
                    ParseFinancialDecimal(v, additionalIdx) > 0)
                {
                    count++;
                    actual += ParseFinancialDecimal(v, actualIdx);
                    expected += ParseFinancialDecimal(v, expectedIdx);
                }
            }

            return new FinancialSummary
            {
                ClaimCount = count,
                TotalBilledCharges = actual,
                ExpectedBilledCharges = expected
            };
        }


        private FinancialSummary CalculateMissingOnly(string enhancedCsvPath)
        {
            var lines = File.ReadAllLines(enhancedCsvPath);
            var headers = ParseCsvLine(lines[0]);

            int missingIdx = GetFinancialColumnIndex(headers, "Missing Amount");
            int additionalIdx = GetFinancialColumnIndex(headers, "Additional Amount");
            int actualIdx = GetFinancialColumnIndex(headers, "TotalCharge");
            int expectedIdx = GetFinancialColumnIndex(headers, "Expected Charges");

            int count = 0;
            decimal actual = 0, expected = 0;

            for (int i = 1; i < lines.Length; i++)
            {
                var v = ParseCsvLine(lines[i]);

                if (ParseFinancialDecimal(v, missingIdx) > 0 &&
                    ParseFinancialDecimal(v, additionalIdx) == 0)
                {
                    count++;
                    actual += ParseFinancialDecimal(v, actualIdx);
                    expected += ParseFinancialDecimal(v, expectedIdx);
                }
            }

            return new FinancialSummary
            {
                ClaimCount = count,
                TotalBilledCharges = actual,
                ExpectedBilledCharges = expected
            };
        }



        private FinancialSummary CalculateClaimsWithIssues(string enhancedCsvPath)
        {
            var lines = File.ReadAllLines(enhancedCsvPath);
            var headers = ParseCsvLine(lines[0]);

            int missingIdx = GetFinancialColumnIndex(headers, "Missing Amount");
            int additionalIdx = GetFinancialColumnIndex(headers, "Additional Amount");
            int actualIdx = GetFinancialColumnIndex(headers, "TotalCharge");
            int expectedIdx = GetFinancialColumnIndex(headers, "Expected Charges");

            int count = 0;
            decimal actual = 0, expected = 0;

            for (int i = 1; i < lines.Length; i++)
            {
                var v = ParseCsvLine(lines[i]);

                decimal missing = ParseFinancialDecimal(v, missingIdx);
                decimal additional = ParseFinancialDecimal(v, additionalIdx);

                if (missing > 0 || additional > 0)
                {
                    count++;
                    actual += ParseFinancialDecimal(v, actualIdx);
                    expected += ParseFinancialDecimal(v, expectedIdx);
                }
            }

            return new FinancialSummary
            {
                ClaimCount = count,
                TotalBilledCharges = actual,
                ExpectedBilledCharges = expected
            };
        }



        private FinancialSummary CalculateTotalClaims(string enhancedCsvPath)
        {
            var lines = File.ReadAllLines(enhancedCsvPath);
            var headers = ParseCsvLine(lines[0]);

            int actualIdx = GetFinancialColumnIndex(headers, "TotalCharge", "Actual Charge");
            int expectedIdx = GetFinancialColumnIndex(headers, "Expected Charges", "ExpectedCharges");

            decimal actual = 0, expected = 0;

            for (int i = 1; i < lines.Length; i++)
            {
                var values = ParseCsvLine(lines[i]);
                actual += ParseFinancialDecimal(values, actualIdx);
                expected += ParseFinancialDecimal(values, expectedIdx);
            }

            return new FinancialSummary
            {
                ClaimCount = lines.Length - 1,
                TotalBilledCharges = actual,
                ExpectedBilledCharges = expected
            };
        }
        #endregion

    }
}