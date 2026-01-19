using System;
using System.Collections.Generic;
using System.Data;
using System.Diagnostics;
using System.Drawing;
using System.Globalization;
using System.IO;
using System.Linq;
using System.Runtime.InteropServices;
using System.Threading.Tasks;
using System.Data.SqlClient;
using NLog;
using Microsoft.Office.Interop.Excel;

namespace ReportsGen
{
    public class CollectionReportGenerator
    {
        private static readonly Logger Logger = LogManager.GetCurrentClassLogger();
        private const string ConnectionString = "Server=ASKS\\MYDEV;Database=PCRCO_LRN;User Id=sa;Password=qwerty;Encrypt=True;TrustServerCertificate=True;";
        private const string OutputDirectory = @"C:\LRN-Files\ApplicationFolder\ReportWebApp\ReportingFiles\OutputFiles\PCRCO";
        private const string LogDirectory = @"C:\LRN-Files\ApplicationFolder\ReportWebApp\ReportingFiles\ApplicationLog\PCRCO";
        private const string TemplatePath = @"C:\LRN-Files\ApplicationFolder\ReportWebApp\ReportingFiles\Templates\PCR CO Collection Template.xlsx";

        private Application _excelApp;
        private Workbook _workbook;

        public async Task GenerateReportAsync()
        {
            Directory.CreateDirectory(OutputDirectory);
            Directory.CreateDirectory(LogDirectory);

            Logger.Info("===== PCRCO Collection Report Script Started =====");

            int? reportId = null;
            string outputPath = null;

            try
            {
                // Check for pending reports
                var reportInfo = await GetPendingReportAsync();
                if (reportInfo == null)
                {
                    Logger.Info("⚠️ No 'Collection Report' pending (status = 4). Exiting.");
                    return;
                }

                reportId = reportInfo.ReportID;

                // Update status to InProgress
                await UpdateReportStatusAsync(reportId.Value, 3);

                // Generate output path
                outputPath = Path.Combine(OutputDirectory,
                    $"PCRCO_Collection_Report_{Guid.NewGuid():N.Substring(0, 8)}.xlsx");

                // Fetch data
                var claimData = await FetchClaimDataAsync();
                var lineData = await FetchLineDataAsync();

                Logger.Info($"🟢 Step 1: SP output rows (raw claim): {claimData.Rows.Count}");
                Logger.Info($"🟢 Step 1: SP output rows (raw line): {lineData.Rows.Count}");

                // Initialize Excel application
                InitializeExcel();

                // Create workbook and write raw data
                CreateWorkbook(outputPath);
                WriteDataTableToSheet(claimData, "Master Claim level");
                WriteDataTableToSheet(lineData, "Master Line Level");

                // Save initial workbook
                SaveWorkbook(outputPath);
                CloseWorkbook();

                // Transform data for pivots
                var claimPivot = claimData.Copy();
                var linePivot = lineData.Copy();

                TransformClaimData(claimPivot);
                TransformLineData(linePivot);

                // Reopen workbook for formatting and pivots
                OpenWorkbook(outputPath);

                // Create insight sheets
                AddCollectionSummarySheets(claimData);

                // Format master sheets
                FormatMasterSheet("Master Claim level");
                FormatMasterSheet("Master Line Level");

                // Create pivot tables
                CreatePivotTables(claimPivot, linePivot);

                // Reorder worksheets
                ReorderWorksheets();

                // Apply styling
                ApplySheetStyling();

                // Save final workbook
                SaveWorkbook(outputPath);

                // Update report as successful
                await UpdateReportSuccessAsync(reportId.Value, outputPath);

                Logger.Info($"✅ Report generated successfully: {outputPath}");
            }
            catch (Exception ex)
            {
                Logger.Error(ex, "❌ Error generating report");

                if (reportId.HasValue)
                {
                    await MarkReportFailedAsync(reportId.Value, ex.Message);
                }

                throw;
            }
            finally
            {
                CleanupExcel();
            }
        }

        #region Database Operations
        private async Task<ReportInfo> GetPendingReportAsync()
        {
            using (var conn = new SqlConnection(ConnectionString))
            {
                await conn.OpenAsync();
                var cmd = new SqlCommand(
                    @"c",
                    conn);

                using (var reader = await cmd.ExecuteReaderAsync())
                {
                    if (await reader.ReadAsync())
                    {
                        return new ReportInfo
                        {
                            ReportID = reader.GetInt32(0),
                            ReportName = reader.GetString(1),
                            ReportType = reader.GetString(2)
                        };
                    }
                }
                return null;
            }
        }

        private async Task UpdateReportStatusAsync(int reportId, int status)
        {
            using (var conn = new SqlConnection(ConnectionString))
            {
                await conn.OpenAsync();
                var cmd = new SqlCommand(
                    "UPDATE ReportDownloadSts SET ReportStatus = @status WHERE ReportID = @reportId",
                    conn);
                cmd.Parameters.AddWithValue("@status", status);
                cmd.Parameters.AddWithValue("@reportId", reportId);
                await cmd.ExecuteNonQueryAsync();
            }
        }

        private async Task UpdateReportSuccessAsync(int reportId, string outputPath)
        {
            using (var conn = new SqlConnection(ConnectionString))
            {
                await conn.OpenAsync();
                var cmd = new SqlCommand(
                    @"UPDATE ReportDownloadSts 
                    SET ReportStatus = 1, ReportServerPath = @outputPath
                    WHERE ReportID = @reportId",
                    conn);
                cmd.Parameters.AddWithValue("@reportId", reportId);
                cmd.Parameters.AddWithValue("@outputPath", outputPath);
                await cmd.ExecuteNonQueryAsync();
            }
        }

        private async Task MarkReportFailedAsync(int reportId, string errorMessage)
        {
            using (var conn = new SqlConnection(ConnectionString))
            {
                await conn.OpenAsync();

                // Update status to failed
                var cmd1 = new SqlCommand(
                    "UPDATE ReportDownloadSts SET ReportStatus = 2 WHERE ReportID = @reportId",
                    conn);
                cmd1.Parameters.AddWithValue("@reportId", reportId);
                await cmd1.ExecuteNonQueryAsync();

                // Insert log
                var cmd2 = new SqlCommand(
                    "EXEC SP_InsertReportDownloadLog @ReportId = @reportId, @LogString = @errorMessage",
                    conn);
                cmd2.Parameters.AddWithValue("@reportId", reportId);
                cmd2.Parameters.AddWithValue("@errorMessage", errorMessage);
                await cmd2.ExecuteNonQueryAsync();
            }
        }

        private async Task<System.Data.DataTable> FetchClaimDataAsync()
        {
            using (var conn = new SqlConnection(ConnectionString))
            {
                await conn.OpenAsync();
                using (var cmd = new SqlCommand("EXEC dbo.sp_GetProductionReportMaster", conn))
                {
                    using (var reader = await cmd.ExecuteReaderAsync())
                    {
                        var table = new System.Data.DataTable();
                        table.Load(reader);
                        return table;
                    }
                }
            }
        }

        private async Task<System.Data.DataTable> FetchLineDataAsync()
        {
            using (var conn = new SqlConnection(ConnectionString))
            {
                await conn.OpenAsync();
                using (var cmd = new SqlCommand("EXEC dbo.sp_GetProductionLineLevelReport", conn))
                {
                    using (var reader = await cmd.ExecuteReaderAsync())
                    {
                        var table = new System.Data.DataTable();
                        table.Load(reader);
                        return table;
                    }
                }
            }
        }
        #endregion

        #region Excel Operations
        private void InitializeExcel()
        {
            try
            {
                // Clean up existing Excel instances
                SafeExcelCleanup();

                _excelApp = new Application
                {
                    Visible = false,
                    DisplayAlerts = false,
                    ScreenUpdating = false,
                    EnableEvents = false,
                    Calculation = XlCalculation.xlCalculationManual
                };
            }
            catch (Exception ex)
            {
                Logger.Error(ex, "Failed to initialize Excel application");
                throw;
            }
        }

        private void CreateWorkbook(string outputPath)
        {
            _workbook = _excelApp.Workbooks.Add();
        }

        private void OpenWorkbook(string filePath)
        {
            _workbook = _excelApp.Workbooks.Open(filePath);
        }

        private void SaveWorkbook(string filePath)
        {
            _workbook.SaveCopyAs(filePath);
        }

        private void CloseWorkbook()
        {
            if (_workbook != null)
            {
                _workbook.Close(false);
                Marshal.ReleaseComObject(_workbook);
                _workbook = null;
            }
        }

        private void CleanupExcel()
        {
            try
            {
                if (_workbook != null)
                {
                    _workbook.Close(false);
                    Marshal.ReleaseComObject(_workbook);
                    _workbook = null;
                }

                if (_excelApp != null)
                {
                    _excelApp.Quit();
                    Marshal.ReleaseComObject(_excelApp);
                    _excelApp = null;
                }

                // Force garbage collection
                GC.Collect();
                GC.WaitForPendingFinalizers();
            }
            catch (Exception ex)
            {
                Logger.Warn(ex, "Error during Excel cleanup");
            }
        }

        private void WriteDataTableToSheet(System.Data.DataTable dataTable, string sheetName)
        {
            Worksheet worksheet = null;
            try
            {
                // Delete if exists
                foreach (Worksheet ws in _workbook.Worksheets)
                {
                    if (ws.Name == sheetName)
                    {
                        ws.Delete();
                        break;
                    }
                }

                worksheet = (Worksheet)_workbook.Worksheets.Add();
                worksheet.Name = sheetName;

                // Write headers
                for (int col = 0; col < dataTable.Columns.Count; col++)
                {
                    ((Microsoft.Office.Interop.Excel.Range)worksheet.Cells[1, col + 1]).Value = dataTable.Columns[col].ColumnName;
                }

                // Write data
                for (int row = 0; row < dataTable.Rows.Count; row++)
                {
                    for (int col = 0; col < dataTable.Columns.Count; col++)
                    {
                        ((Microsoft.Office.Interop.Excel.Range)worksheet.Cells[row + 2, col + 1]).Value = dataTable.Rows[row][col];
                    }
                }

                // Auto-fit columns
                ((Microsoft.Office.Interop.Excel.Range)worksheet.Columns).AutoFit();
            }
            finally
            {
                if (worksheet != null)
                    Marshal.ReleaseComObject(worksheet);
            }
        }

        private void FormatMasterSheet(string sheetName)
        {
            Worksheet worksheet = null;
            try
            {
                worksheet = (Worksheet)_workbook.Worksheets[sheetName];
                var usedRange = worksheet.UsedRange;

                // Format headers
                var headerRange = worksheet.Range[worksheet.Cells[1, 1],
                    worksheet.Cells[1, usedRange.Columns.Count]];
                headerRange.Interior.Color = RGB(0x37, 0x56, 0x23); // Dark green
                headerRange.Font.Color = RGB(255, 255, 255);
                headerRange.Font.Bold = true;
                headerRange.HorizontalAlignment = XlHAlign.xlHAlignCenter;
                headerRange.VerticalAlignment = XlVAlign.xlVAlignCenter;
                headerRange.WrapText = false;

                // Format all cells
                var allRange = worksheet.Range[worksheet.Cells[1, 1],
                    worksheet.Cells[usedRange.Rows.Count, usedRange.Columns.Count]];
                allRange.Font.Name = "Calibri";
                allRange.Font.Size = 10;
                allRange.HorizontalAlignment = XlHAlign.xlHAlignCenter;
                allRange.VerticalAlignment = XlVAlign.xlVAlignCenter;

                // Apply borders
                allRange.Borders.LineStyle = XlLineStyle.xlContinuous;
                allRange.Borders.Weight = XlBorderWeight.xlThin;
                allRange.Borders.Color = RGB(0xA6, 0xA6, 0xA6);

                // Disable gridlines
                worksheet.Activate();
                _excelApp.ActiveWindow.DisplayGridlines = false;

                // Set row height for header
                ((Microsoft.Office.Interop.Excel.Range)worksheet.Rows[1]).RowHeight = 15;
            }
            finally
            {
                if (worksheet != null)
                    Marshal.ReleaseComObject(worksheet);
            }
        }

        private int RGB(int red, int green, int blue)
        {
            return (red) | (green << 8) | (blue << 16);
        }

        private void AddCollectionSummarySheets(System.Data.DataTable claimData)
        {
            // Implementation for creating summary sheets
            // This is a complex function - here's a simplified version
            CreateMonthlyInsightsSheet(claimData);
            CreateWeeklyInsightsSheet(claimData);
            CreateTop5InsightsSheet(claimData);
            CreateAveragePaymentsInsightsSheet(claimData);
        }

        private void CreateMonthlyInsightsSheet(System.Data.DataTable claimData)
        {
            Worksheet worksheet = null;
            try
            {
                // Delete if exists
                DeleteSheetIfExists("Monthly Insights");

                worksheet = (Worksheet)_workbook.Worksheets.Add();
                worksheet.Name = "Monthly Insights";

                // Add your monthly insights logic here
                // This would include creating headers, aggregating data, formatting, etc.

                FormatInsightsSheet(worksheet);
            }
            finally
            {
                if (worksheet != null)
                    Marshal.ReleaseComObject(worksheet);
            }
        }

        private void CreateWeeklyInsightsSheet(System.Data.DataTable claimData)
        {
            // Similar structure as monthly insights
        }

        private void CreateTop5InsightsSheet(System.Data.DataTable claimData)
        {
            // Similar structure as monthly insights
        }

        private void CreateAveragePaymentsInsightsSheet(System.Data.DataTable claimData)
        {
            // Similar structure as monthly insights
        }

        private void FormatInsightsSheet(Worksheet worksheet)
        {
            // Apply consistent formatting for insight sheets
            var usedRange = worksheet.UsedRange;
            usedRange.Font.Name = "Calibri";
            usedRange.Font.Size = 10;

            // Disable gridlines
            worksheet.Activate();
            _excelApp.ActiveWindow.DisplayGridlines = false;
        }

        private void CreatePivotTables(System.Data.DataTable claimPivot, System.Data.DataTable linePivot)
        {
            try
            {
                // Create temporary data sheets for pivots
                var tempClaimSheet = CreateTempDataSheet("Temp_Claim_Pivot", claimPivot);
                var tempLineSheet = CreateTempDataSheet("Temp_Line_Pivot", linePivot);

                // Create various pivot tables
                CreateClinicCountByDOSMonthPivot(tempClaimSheet);
                CreateClinicDollarAnalysisPivot(tempClaimSheet);
                CreatePanelVsPaymentPivot(tempClaimSheet);
                CreateTotalInsurancePaymentPivot(tempClaimSheet);
                CreateInsuranceVsPaymentPercentPivot(tempClaimSheet);
                CreateInsuranceVsAgingPivot(tempClaimSheet);
                CreateCPTvsPaymentPivot(tempLineSheet);

                // Clean up temporary sheets
                DeleteSheetIfExists("Temp_Claim_Pivot");
                DeleteSheetIfExists("Temp_Line_Pivot");
            }
            catch (Exception ex)
            {
                Logger.Error(ex, "Error creating pivot tables");
            }
        }

        private Worksheet CreateTempDataSheet(string sheetName, System.Data.DataTable data)
        {
            Worksheet worksheet = null;
            try
            {
                DeleteSheetIfExists(sheetName);
                worksheet = (Worksheet)_workbook.Worksheets.Add();
                worksheet.Name = sheetName;
                worksheet.Visible = XlSheetVisibility.xlSheetHidden;

                // Write data to sheet
                WriteDataTableToSheet(data, sheetName);

                return worksheet;
            }
            catch
            {
                if (worksheet != null)
                    Marshal.ReleaseComObject(worksheet);
                throw;
            }
        }

        private void CreateClinicCountByDOSMonthPivot(Worksheet sourceSheet)
        {
            try
            {
                DeleteSheetIfExists("Clinic Count by DOS Month");

                var pivotSheet = (Worksheet)_workbook.Worksheets.Add();
                pivotSheet.Name = "Clinic Count by DOS Month";

                var pivotCache = _workbook.PivotCaches().Create(
                    XlPivotTableSourceType.xlDatabase,
                    sourceSheet.UsedRange);

                var pivotTable = (PivotTable)pivotCache.CreatePivotTable(
                    pivotSheet.Range["A3"],
                    "Clinic_Count_by_DOS_Month_Pivot");

                // Configure pivot table fields
                //pivotTable.PivotFields("ClinicName").Orientation = XlPivotFieldOrientation.xlRowField;
                //pivotTable.PivotFields("Clinic Year").Orientation = XlPivotFieldOrientation.xlColumnField;
                //pivotTable.PivotFields("Clinic Month").Orientation = XlPivotFieldOrientation.xlColumnField;

                ((PivotField)pivotTable.PivotFields("ClinicName")).Orientation = XlPivotFieldOrientation.xlRowField;
                ((PivotField)pivotTable.PivotFields("Clinic Year")).Orientation = XlPivotFieldOrientation.xlColumnField;
                ((PivotField)pivotTable.PivotFields("Clinic Month")).Orientation = XlPivotFieldOrientation.xlColumnField;

                pivotTable.AddDataField(pivotTable.PivotFields("VisitNumber"),
                    "Number of Claims", XlConsolidationFunction.xlCount);

                // Formatting
                pivotSheet.UsedRange.HorizontalAlignment = XlHAlign.xlHAlignCenter;
                pivotSheet.UsedRange.VerticalAlignment = XlVAlign.xlVAlignCenter;
                ((Microsoft.Office.Interop.Excel.Range)pivotSheet.Columns).AutoFit();

                Marshal.ReleaseComObject(pivotSheet);
            }
            catch (Exception ex)
            {
                Logger.Warn(ex, "Failed to create Clinic Count by DOS Month pivot");
            }
        }

        private void CreateClinicDollarAnalysisPivot(Worksheet sourceSheet)
        {
            // Similar implementation for other pivots
        }

        private void CreatePanelVsPaymentPivot(Worksheet sourceSheet)
        {
            // Similar implementation
        }

        private void CreateTotalInsurancePaymentPivot(Worksheet sourceSheet)
        {
            // Similar implementation
        }

        private void CreateInsuranceVsPaymentPercentPivot(Worksheet sourceSheet)
        {
            // Similar implementation
        }

        private void CreateInsuranceVsAgingPivot(Worksheet sourceSheet)
        {
            // Similar implementation
        }

        private void CreateCPTvsPaymentPivot(Worksheet sourceSheet)
        {
            // Similar implementation
        }

        private void ReorderWorksheets()
        {
            try
            {
                // Move insight sheets to front
                var insightSheets = new List<string>
                {
                    "Average Payments Insights",
                    "Top 5 Insights",
                    "Weekly Insights",
                    "Monthly Insights"
                };

                // Move each insight sheet to the beginning
                foreach (var sheetName in insightSheets)
                {
                    if (SheetExists(sheetName))
                    {
                        var sheet = (Worksheet)_workbook.Worksheets[sheetName];
                        sheet.Move(_workbook.Worksheets[1]);
                        Marshal.ReleaseComObject(sheet);
                    }
                }

                // Move master sheets to end
                var masterSheets = new List<string>
                {
                    "Master Claim level",
                    "Master Line Level"
                };

                foreach (var sheetName in masterSheets)
                {
                    if (SheetExists(sheetName))
                    {
                        var sheet = (Worksheet)_workbook.Worksheets[sheetName];
                        sheet.Move(_workbook.Worksheets[_workbook.Worksheets.Count]);
                        Marshal.ReleaseComObject(sheet);
                    }
                }

                // Copy Insights sheet from template if exists
                if (File.Exists(TemplatePath))
                {
                    CopyInsightsFromTemplate();
                }
            }
            catch (Exception ex)
            {
                Logger.Warn(ex, "Error reordering worksheets");
            }
        }

        private void CopyInsightsFromTemplate()
        {
            try
            {
                DeleteSheetIfExists("Insights");

                var templateWorkbook = _excelApp.Workbooks.Open(TemplatePath);
                var templateSheet = (Worksheet)templateWorkbook.Worksheets[1];

                // Copy the sheet
                templateSheet.Copy(Before: _workbook.Worksheets[1]);

                // Rename the copied sheet
                var copiedSheet = (Worksheet)_workbook.Worksheets[1];
                copiedSheet.Name = "Insights";

                // Apply banner color
                var bannerRange = copiedSheet.Range["A1:AF8"];
                bannerRange.Interior.Color = RGB(0xE7, 0xE6, 0xE6);

                // Cleanup
                templateWorkbook.Close(false);
                Marshal.ReleaseComObject(templateSheet);
                Marshal.ReleaseComObject(templateWorkbook);
                Marshal.ReleaseComObject(copiedSheet);
            }
            catch (Exception ex)
            {
                Logger.Warn(ex, "Failed to copy Insights from template");
            }
        }

        private void ApplySheetStyling()
        {
            try
            {
                // Color sheet tabs
                foreach (Worksheet sheet in _workbook.Worksheets)
                {
                    var name = sheet.Name;

                    // Red for insights
                    if (name.Contains("Insights"))
                    {
                        sheet.Tab.Color = RGB(192, 0, 0);
                    }
                    // Orange for master sheets
                    else if (name == "Master Claim level" || name == "Master Line Level")
                    {
                        sheet.Tab.Color = RGB(237, 125, 49);
                    }
                    // Yellow for others
                    else
                    {
                        sheet.Tab.Color = RGB(255, 192, 0);
                    }

                    // Disable gridlines for non-master sheets
                    if (!(name == "Master Claim level" || name == "Master Line Level"))
                    {
                        sheet.Activate();
                        _excelApp.ActiveWindow.DisplayGridlines = false;
                    }

                    Marshal.ReleaseComObject(sheet);
                }

                // Move Insights sheet to end
                if (SheetExists("Insights"))
                {
                    var insightsSheet = (Worksheet)_workbook.Worksheets["Insights"];
                    insightsSheet.Move(_workbook.Worksheets[_workbook.Worksheets.Count]);
                    Marshal.ReleaseComObject(insightsSheet);
                }
            }
            catch (Exception ex)
            {
                Logger.Warn(ex, "Error applying sheet styling");
            }
        }

        private bool SheetExists(string sheetName)
        {
            foreach (Worksheet sheet in _workbook.Worksheets)
            {
                if (sheet.Name == sheetName)
                {
                    Marshal.ReleaseComObject(sheet);
                    return true;
                }
                Marshal.ReleaseComObject(sheet);
            }
            return false;
        }

        private void DeleteSheetIfExists(string sheetName)
        {
            try
            {
                if (SheetExists(sheetName))
                {
                    var sheet = (Worksheet)_workbook.Worksheets[sheetName];
                    sheet.Delete();
                    Marshal.ReleaseComObject(sheet);
                }
            }
            catch (Exception ex)
            {
                Logger.Warn(ex, $"Error deleting sheet {sheetName}");
            }
        }
        #endregion

        #region Data Transformation
        private void TransformClaimData(System.Data.DataTable claimData)
        {
            // Normalize column names
            foreach (System.Data.DataColumn column in claimData.Columns)
            {
                column.ColumnName = column.ColumnName.Trim();
            }

            // Add PanelName if missing
            if (!claimData.Columns.Contains("PanelName") && claimData.Columns.Contains("PanelName"))
            {
                claimData.Columns.Add("PanelName", typeof(string));
                foreach (System.Data.DataRow row in claimData.Rows)
                {
                    row["PanelName"] = row["PanelName"];
                }
            }

            // Parse dates
            if (claimData.Columns.Contains("CheckDate"))
            {
                foreach (System.Data.DataRow row in claimData.Rows)
                {
                    if (DateTime.TryParse(row["CheckDate"]?.ToString(), out var checkDate))
                    {
                        row["CheckDate"] = checkDate;

                        // Add Year and Month columns if they don't exist
                        if (!claimData.Columns.Contains("Year"))
                            claimData.Columns.Add("Year", typeof(int));
                        if (!claimData.Columns.Contains("Month"))
                            claimData.Columns.Add("Month", typeof(string));

                        row["Year"] = checkDate.Year;
                        row["Month"] = checkDate.ToString("MMM");
                    }
                }
            }

            // Calculate payment percentage
            if (claimData.Columns.Contains("CarrierPayment") && claimData.Columns.Contains("TotalCharge"))
            {
                claimData.Columns.Add("Payment %", typeof(decimal));
                foreach (System.Data.DataRow row in claimData.Rows)
                {
                    var payment = Convert.ToDecimal(row["CarrierPayment"] ?? 0);
                    var charge = Convert.ToDecimal(row["TotalCharge"] ?? 0);
                    row["Payment %"] = charge != 0 ? payment / charge : 0;
                }
            }
        }

        private void TransformLineData(System.Data.DataTable lineData)
        {
            // Similar transformations for line data
            foreach (System.Data.DataColumn column in lineData.Columns)
            {
                column.ColumnName = column.ColumnName.Trim();
            }

            // Calculate payment percentage for line items
            if (lineData.Columns.Contains("InsurancePayment") && lineData.Columns.Contains("BilledAmount"))
            {
                lineData.Columns.Add("Payment %", typeof(decimal));
                foreach (System.Data.DataRow row in lineData.Rows)
                {
                    var payment = Convert.ToDecimal(row["InsurancePayment"] ?? 0);
                    var billed = Convert.ToDecimal(row["BilledAmount"] ?? 0);
                    row["Payment %"] = billed != 0 ? payment / billed : 0;
                }
            }
        }
        #endregion

        #region Helper Methods
        private void SafeExcelCleanup()
        {
            try
            {
                // Kill existing Excel processes
                foreach (var process in Process.GetProcessesByName("EXCEL"))
                {
                    try
                    {
                        process.Kill();
                        process.WaitForExit(5000);
                    }
                    catch
                    {
                        // Ignore cleanup errors
                    }
                }

                // Small delay to ensure processes are terminated
                System.Threading.Thread.Sleep(2000);
            }
            catch (Exception ex)
            {
                Logger.Warn(ex, "Error during Excel cleanup");
            }
        }
        #endregion
    }

    #region Supporting Classes
    public class ReportInfo
    {
        public int ReportID { get; set; }
        public string ReportName { get; set; }
        public string ReportType { get; set; }
    }
    #endregion
}