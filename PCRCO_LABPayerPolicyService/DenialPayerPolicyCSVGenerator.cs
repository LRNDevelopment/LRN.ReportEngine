using ClosedXML.Excel;
using DocumentFormat.OpenXml.Bibliography;
using Microsoft.Extensions.Configuration;
using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Text;

namespace PCRCO_LABPayerPolicyService
{
    public class DenialPayerPolicyCSVGenerator
    {
        private readonly DatabaseService _databaseService;
        private readonly OutputSettings _outputSettings;
        private readonly string _logFolder;
        private readonly string _payerPolicyFolder;
        private string _logFilePath;
        private string _labName;
        private readonly StringBuilder _sessionLog;

        public DenialPayerPolicyCSVGenerator(IConfiguration configuration)
        {
            var appSettings = configuration.Get<AppSettings>();
            _databaseService = new DatabaseService(appSettings.ConnectionStrings.DefaultConnection);
            _outputSettings = appSettings.OutputSettings;

            // Get folder paths
            _logFolder = _outputSettings.LogFolder ?? Path.Combine(AppContext.BaseDirectory, "Logs");
            _payerPolicyFolder = _outputSettings.PayerPolicyFolder ?? Path.Combine(AppContext.BaseDirectory, "PayerPolicyInput");
            _labName = _outputSettings.LABName ?? "Lab";
            // Initialize session log
            _sessionLog = new StringBuilder();

            // Initialize logging
            InitializeLogging();

            LogMessage("INFO", "DenialPayerPolicyCSVGenerator initialized", true);
            LogMessage("INFO", $"Lab Name: {_labName}", true);
            LogMessage("INFO", $"Log Folder: {_logFolder}", false);
            LogMessage("INFO", $"PayerPolicyFolder: {_payerPolicyFolder}", false);
            LogMessage("INFO", $"Output Folder: {_outputSettings.OutputFolder}", false);
        }

        private void InitializeLogging()
        {
            try
            {
                // Create log folder if it doesn't exist
                if (!Directory.Exists(_logFolder))
                {
                    Directory.CreateDirectory(_logFolder);
                    LogToConsole($"Created log folder: {_logFolder}", ConsoleColor.Green);
                }

                // Create daily log file
                string dateStamp = DateTime.Now.ToString("yyyyMMdd");
                string logFileName = $"DenialPayerPolicy_Generator_{dateStamp}.log";
                _logFilePath = Path.Combine(_logFolder, logFileName);

                // Write log header
                string logHeader = $@"╔══════════════════════════════════════════════════════════════╗
                                        ║   Denial Payer Policy CSV Generator                         ║
                                        ║   Log File: {logFileName,-37} ║
                                        ║   Created: {DateTime.Now:yyyy-MM-dd HH:mm:ss,-30} ║
                                        ╚══════════════════════════════════════════════════════════════╝

                                        ";

                // Write header only if file doesn't exist
                if (!File.Exists(_logFilePath))
                {
                    File.AppendAllText(_logFilePath, logHeader);
                }
                else
                {
                    // Add separator for new session
                    File.AppendAllText(_logFilePath, $"\n{new string('=', 80)}\n");
                    File.AppendAllText(_logFilePath, $"NEW SESSION STARTED: {DateTime.Now:yyyy-MM-dd HH:mm:ss}\n");
                    File.AppendAllText(_logFilePath, $"{new string('=', 80)}\n\n");
                }
            }
            catch (Exception ex)
            {
                Console.WriteLine($"Warning: Could not initialize log file: {ex.Message}");
            }
        }

        private void LogMessage(string level, string message, bool echoToConsole = true)
        {
            string timestamp = DateTime.Now.ToString("yyyy-MM-dd HH:mm:ss.fff");
            string logEntry = $"[{timestamp}] [{level}] {message}";

            // Add to session log
            _sessionLog.AppendLine(logEntry);

            // Write to log file
            try
            {
                File.AppendAllText(_logFilePath, logEntry + Environment.NewLine);
            }
            catch (Exception ex)
            {
                // If log file write fails, just write to console
                Console.WriteLine($"[ERROR] Failed to write to log file: {ex.Message}");
            }

            // Echo to console if requested
            if (echoToConsole)
            {
                switch (level)
                {
                    case "ERROR":
                        Console.ForegroundColor = ConsoleColor.Red;
                        break;
                    case "WARNING":
                        Console.ForegroundColor = ConsoleColor.Yellow;
                        break;
                    case "SUCCESS":
                        Console.ForegroundColor = ConsoleColor.Green;
                        break;
                    case "INFO":
                        Console.ForegroundColor = ConsoleColor.Cyan;
                        break;
                    default:
                        Console.ForegroundColor = ConsoleColor.White;
                        break;
                }

                Console.WriteLine(logEntry);
                Console.ResetColor();
            }
        }

        private void LogToConsole(string message, ConsoleColor color = ConsoleColor.White)
        {
            Console.ForegroundColor = color;
            Console.WriteLine(message);
            Console.ResetColor();
        }

        private string GetOutputPath(int reportId = 0, string reportType = "Production")
        {
            var outputFolder = _outputSettings.OutputFolder ?? "Output";

            // Get lab name
            var labName = _labName ?? "LAB";

            // Determine filename based on reportId
            string baseFileName;
            if (reportId > 0)
            {
                // Format: LabName_ReportID_ReportType
                baseFileName = $"{labName}_{reportId}_{reportType}";
                LogMessage("INFO", $"Using ReportID based filename: {baseFileName}", true);
            }
            else
            {
                // Fallback to timestamp if no reportId
                var timestamp = DateTime.Now.ToString("ddMMyy_HHmmss");
                baseFileName = $"{labName}_{timestamp}_{reportType}";
                LogMessage("INFO", $"Using timestamp based filename: {baseFileName}", true);
            }

            var outputPath = Path.Combine(outputFolder, $"{baseFileName}.csv");

            var outputDir = Path.GetDirectoryName(outputPath);
            if (!Directory.Exists(outputDir))
            {
                Directory.CreateDirectory(outputDir);
            }

            LogMessage("INFO", $"Output will be generated at: {outputPath}", true);
            LogMessage("DEBUG", $"Lab name: {labName}, ReportID: {reportId}, Type: {reportType}", false);

            return outputPath;
        }
        public class DenialRecord
        {
            public string PayerName { get; set; }
            public string GlobalPayerID { get; set; }
            public string PayerShortCode { get; set; }
            public string AccessionNo { get; set; }
            public string VisitNumber { get; set; }
            public string DenialCode { get; set; }
            public string CPTCode { get; set; }
            public string ICD10Code { get; set; }
            public string CCWICDCODE { get; set; }  // Add this new property

            // Add LabName field
            public string LabName { get; set; }
            // New fields
            public string PatientDOB { get; set; }
            public string PayerType { get; set; }
            public string BeginDOS { get; set; }
            public string FirstBillDate { get; set; }
            public string PanelName { get; set; }
            public string Units { get; set; }
            public string Modifier { get; set; }
            public string DenialDescription { get; set; }
            public string BilledAmount { get; set; }
            public string AllowedAmount { get; set; }
            public string InsurancePayment { get; set; }
            public string InsuranceAdjustment { get; set; }
            public string PatientPaidAmount { get; set; }
            public string PatientAdjustment { get; set; }
            public string InsuranceBalance { get; set; }
            public string PatientBalance { get; set; }
            public string TotalBalance { get; set; }
            public string FinalClaimStatus { get; set; }
            public string ClaimSubStatus { get; set; }

        }

        // Add this private class inside your DenialPayerPolicyCSVGenerator class
        private class PayerLookupInfo
        {
            public string GlobalPayerID { get; set; }
            public string PayerShortCode { get; set; }
        }
        public void Generate_CSV_DenialPayerPolicy()
        {
            string generatedCsvPath = null;
            DateTime startTime = DateTime.Now;

            try
            {
                LogMessage("INFO", "Starting Denial Payer Policy CSV Generation Process", true);
                LogMessage("INFO", $"Start Time: {startTime:yyyy-MM-dd HH:mm:ss}", true);
                LogMessage("SEPARATOR", new string('=', 80), true);

                // Get output path from configuration
                //string outputCsvPath = GetOutputPath();
                //generatedCsvPath = outputCsvPath;

                // Step 1: Check ReportType=7 and ReportStatus=4 using DatabaseService
                LogMessage("INFO", "Checking ReportType 7 with Status 4...", true);
                if (!_databaseService.CheckReportStatus(7, 4))
                {
                    LogMessage("ERROR", "ReportType 7 with Status 4 not found. Process cannot continue.", true);
                    _databaseService.LogProcessStatus("DenialPayerPolicy", "Failed", "ReportType 7 with Status 4 not found");
                    return;
                }
                LogMessage("SUCCESS", "ReportType 7 with Status 4 found.", true);

                // Step 2: Get ReportServerPath for ReportType=2 and ReportStatus=1
                LogMessage("INFO", "Getting ReportServerPath for ReportType 2 with Status 1...", true);
                var reportInfo = _databaseService.GetReportInfo(2, 1);

                //string reportServerPath = _databaseService.GetReportServerPath(2, 1);

                if (string.IsNullOrEmpty(reportInfo.ReportServerPath))
                {
                    LogMessage("ERROR", "ReportServerPath not found for ReportType 2 with Status 1.", true);
                    _databaseService.LogProcessStatus("ProductionPayerPolicy", "Failed", "ReportServerPath not found for ReportType 2 with Status 1");
                    return;
                }

                int reportId = reportInfo.ReportID;
                string reportServerPath = reportInfo.ReportServerPath;
                LogMessage("SUCCESS", $"ReportID found: {reportId}", true);
                LogMessage("SUCCESS", $"ReportServerPath found: {reportServerPath}", true);

                // Step 3: Get output path using ReportID and LABName
                LogMessage("INFO", $"Getting output path using ReportID: {reportId} and LAB: {_labName}", true);
                string outputCsvPath = GetOutputPath(reportId, "Production");  // Pass reportId and type
                generatedCsvPath = outputCsvPath;

                // Step 4: Read data from Excel "Master Line Level" sheet with column mapping
                LogMessage("INFO", $"Reading Excel file from: {reportServerPath}", true);
                var denialRecords = ReadDenialDataFromExcel(reportServerPath);

                // Step 5: Fill GlobalPayerID and PayerShortCode from database
                LogMessage("INFO", "Filtering records based on COInsuranceMaster...", true);
                var filteredRecords = FillPayerInfoFromDatabase(denialRecords);

                if (filteredRecords.Count == 0)
                {
                    LogMessage("ERROR", "No records found with matching payers in COInsuranceMaster.", true);
                    _databaseService.LogProcessStatus("DenialPayerPolicy", "Failed", "No matching payers found in COInsuranceMaster");
                    return;
                }

                // Step 6: Write to CSV
                LogMessage("INFO", $"Writing {filteredRecords.Count} records to CSV...", true);
                WriteToCSV(filteredRecords, outputCsvPath);
                LogMessage("SUCCESS", $"CSV file generated successfully: {outputCsvPath}", true);


                LogMessage("INFO", "Waiting for file system to complete write operations...", true);
                System.Threading.Thread.Sleep(1000); // 1 second delay


                // Step 6: Move CSV to PayerPolicyFolder
                LogMessage("INFO", "Moving CSV file to PayerPolicyFolder...", true);
                bool moveSuccess = MoveToPayerPolicyFolder(outputCsvPath,reportId);

                if (moveSuccess)
                {
                    LogMessage("SUCCESS", "CSV file moved to PayerPolicyFolder successfully", true);
                }

                // Step 7: Generate summary
                DateTime endTime = DateTime.Now;
                TimeSpan duration = endTime - startTime;

                LogMessage("SEPARATOR", new string('=', 80), true);
                LogMessage("SUMMARY", "PROCESS COMPLETED SUCCESSFULLY", true);
                LogMessage("SUMMARY", $"Start Time: {startTime:yyyy-MM-dd HH:mm:ss}", true);
                LogMessage("SUMMARY", $"End Time: {endTime:yyyy-MM-dd HH:mm:ss}", true);
                LogMessage("SUMMARY", $"Total Duration: {duration:hh\\:mm\\:ss}", true);
                LogMessage("SUMMARY", $"Total records from Excel: {denialRecords.Count}", true);
                LogMessage("SUMMARY", $"Records matched in COInsuranceMaster: {filteredRecords.Count}", true);
                LogMessage("SUMMARY", $"Records filtered out: {denialRecords.Count - filteredRecords.Count}", true);
                LogMessage("SEPARATOR", new string('=', 80), true);

                // Log successful completion to database
                _databaseService.LogProcessStatus("DenialPayerPolicy", "Completed",
                    $"Generated CSV with {filteredRecords.Count} records. " +
                    $"Filtered out {denialRecords.Count - filteredRecords.Count} records not in COInsuranceMaster. " +
                    $"Duration: {duration:hh\\:mm\\:ss}");

                // Write summary report
                WriteSummaryReport(startTime, endTime, duration, denialRecords.Count, filteredRecords.Count);
            }
            catch (Exception ex)
            {
                LogMessage("ERROR", $"Error generating CSV: {ex.Message}", true);
                LogMessage("ERROR", $"Stack Trace: {ex.StackTrace}", false);
                _databaseService.LogProcessStatus("DenialPayerPolicy", "Error", ex.Message);
                throw;
            }
            finally
            {
                // Clean up original output file if it exists and was moved
                if (generatedCsvPath != null && File.Exists(generatedCsvPath))
                {
                    try
                    {
                        File.Delete(generatedCsvPath);
                        LogMessage("INFO", $"Cleaned up temporary file: {generatedCsvPath}", false);
                    }
                    catch (Exception ex)
                    {
                        LogMessage("WARNING", $"Could not clean up temporary file: {ex.Message}", false);
                    }
                }
            }
        }


        private bool MoveToPayerPolicyFolder(string sourceFilePath, int reportId = 0)
        {
            try
            {
                // Ensure PayerPolicyFolder exists
                if (!Directory.Exists(_payerPolicyFolder))
                {
                    Directory.CreateDirectory(_payerPolicyFolder);
                    LogMessage("INFO", $"Created PayerPolicyFolder: {_payerPolicyFolder}", true);
                }

                string fileName = Path.GetFileName(sourceFilePath);
                string destinationPath = Path.Combine(_payerPolicyFolder, fileName);

                // Optional: If reportId is provided, rename the file with reportId
                if (reportId > 0)
                {
                    string extension = Path.GetExtension(fileName);
                    string fileNameWithoutExtension = Path.GetFileNameWithoutExtension(fileName);

                    // Check if filename already contains reportId
                    if (!fileNameWithoutExtension.Contains($"_{reportId}_"))
                    {
                        fileName = $"{fileNameWithoutExtension}_{reportId}{extension}";
                        destinationPath = Path.Combine(_payerPolicyFolder, fileName);
                    }
                }

                // Check if file already exists in destination
                if (File.Exists(destinationPath))
                {
                    // Append timestamp to make it unique
                    string timestamp = DateTime.Now.ToString("yyyyMMdd_HHmmss_fff");
                    string fileNameWithoutExtension = Path.GetFileNameWithoutExtension(fileName);
                    string extension = Path.GetExtension(fileName);
                    string uniqueFileName = $"{fileNameWithoutExtension}_{timestamp}{extension}";
                    destinationPath = Path.Combine(_payerPolicyFolder, uniqueFileName);
                    LogMessage("WARNING", $"File already exists in destination. Using unique name: {uniqueFileName}", true);
                }

                // Move the file
                File.Move(sourceFilePath, destinationPath);
                LogMessage("SUCCESS", $"File moved to: {destinationPath}", true);

                // Log file details
                FileInfo fileInfo = new FileInfo(destinationPath);
                LogMessage("INFO", $"File Size: {GetFileSize(fileInfo.Length)}", true);
                LogMessage("INFO", $"File Created: {fileInfo.CreationTime:yyyy-MM-dd HH:mm:ss}", false);

                return true;
            }
            catch (Exception ex)
            {
                LogMessage("ERROR", $"Failed to move file to PayerPolicyFolder: {ex.Message}", true);
                return false;
            }
        }

        private string GetFileSize(long bytes)
        {
            string[] sizes = { "B", "KB", "MB", "GB" };
            int order = 0;
            double len = bytes;
            while (len >= 1024 && order < sizes.Length - 1)
            {
                order++;
                len = len / 1024;
            }
            return $"{len:0.##} {sizes[order]}";
        }

        private void WriteSummaryReport(DateTime startTime, DateTime endTime, TimeSpan duration,
                                      int totalRecords, int filteredRecords)
        {
            try
            {
                string dateStamp = DateTime.Now.ToString("yyyyMMdd");
                string summaryFileName = $"ProcessingSummary_{dateStamp}_{DateTime.Now:HHmmss}.txt";
                string summaryFilePath = Path.Combine(_logFolder, summaryFileName);

                string summaryContent = $@"DENIAL PAYER POLICY CSV GENERATION SUMMARY REPORT
                ====================================================
                Report Generated: {DateTime.Now:yyyy-MM-dd HH:mm:ss}
                Process Start: {startTime:yyyy-MM-dd HH:mm:ss}
                Process End: {endTime:yyyy-MM-dd HH:mm:ss}
                Total Duration: {duration:hh\\:mm\\:ss}

                FOLDER PATHS
                ------------
                Output Folder: {_outputSettings.OutputFolder}
                Log Folder: {_logFolder}
                PayerPolicyFolder: {_payerPolicyFolder}

                PROCESSING RESULTS
                ------------------
                Total Records Read from Excel: {totalRecords}
                Records Matched in COInsuranceMaster: {filteredRecords}
                Records Filtered Out: {totalRecords - filteredRecords}
                Match Rate: {(totalRecords > 0 ? ((double)filteredRecords / totalRecords * 100).ToString("F1") : "0")}%

                FILE OPERATIONS
                ---------------
                CSV Generated: Yes
                CSV Moved to PayerPolicyFolder: Yes

                SESSION LOG
                -----------
                {_sessionLog}

                ================================================================================
                End of Summary Report
                ";

                File.WriteAllText(summaryFilePath, summaryContent);
                LogMessage("INFO", $"Summary report saved to: {summaryFilePath}", true);
            }
            catch (Exception ex)
            {
                LogMessage("WARNING", $"Could not write summary report: {ex.Message}", true);
            }
        }
        private List<DenialRecord> ReadDenialDataFromExcel(string excelFilePath)
        {
            var records = new List<DenialRecord>();

            if (!File.Exists(excelFilePath))
            {
                throw new FileNotFoundException($"Excel file not found: {excelFilePath}");
            }

            LogMessage("INFO", $"Reading Excel file: {excelFilePath}", true);

            using (var workbook = new XLWorkbook(excelFilePath))
            {
                var worksheet = workbook.Worksheet("Master Line Level");
                if (worksheet == null)
                {
                    throw new Exception("Worksheet 'Master Line Level' not found in the Excel file");
                }

                var usedRows = worksheet.RangeUsed().RowsUsed();
                if (!usedRows.Any())
                {
                    throw new Exception("No data found in 'Master Line Level' worksheet");
                }

                var headerRow = usedRows.First();
                var columnMapping = FindColumnIndices(worksheet, headerRow);
                ValidateColumnMapping(columnMapping);

                // Collect all records first with Excel ICD10Code and ICDCODE
                var tempRecords = new List<DenialRecord>();
                var accessionNumbers = new HashSet<string>();

                int rowCount = 0;
                foreach (var row in usedRows.Skip(1))
                {
                    rowCount++;

                    var record = new DenialRecord
                    {
                        LabName = _labName,
                        PayerName = GetCellValue(row, columnMapping["PayerName"]),
                        AccessionNo = GetCellValue(row, columnMapping["AccessionNo"]),
                        VisitNumber = GetCellValue(row, columnMapping["VisitNumber"]),
                        DenialCode = GetCellValue(row, columnMapping["DenialCode"]),
                        CPTCode = GetCellValue(row, columnMapping["CPTCode"]),
                        ICD10Code = string.Empty,
                        CCWICDCODE = GetCellValue(row, columnMapping["ICD10Code"]),

                        // New fields from Excel
                        PatientDOB = GetCellValue(row, columnMapping.GetValueOrDefault("PatientDOB", 0)),
                        PayerType = GetCellValue(row, columnMapping.GetValueOrDefault("PayerType", 0)),
                        BeginDOS = GetCellValue(row, columnMapping.GetValueOrDefault("BeginDOS", 0)),
                        FirstBillDate = GetCellValue(row, columnMapping.GetValueOrDefault("FirstBillDate", 0)),
                        PanelName = GetCellValue(row, columnMapping.GetValueOrDefault("PanelName", 0)),
                        Units = GetCellValue(row, columnMapping.GetValueOrDefault("Units", 0)),
                        Modifier = GetCellValue(row, columnMapping.GetValueOrDefault("Modifier", 0)),
                        DenialDescription = GetCellValue(row, columnMapping.GetValueOrDefault("DenialDescription", 0)),
                        BilledAmount = GetCellValue(row, columnMapping.GetValueOrDefault("BilledAmount", 0)),
                        AllowedAmount = GetCellValue(row, columnMapping.GetValueOrDefault("AllowedAmount", 0)),
                        InsurancePayment = GetCellValue(row, columnMapping.GetValueOrDefault("InsurancePayment", 0)),
                        InsuranceAdjustment = GetCellValue(row, columnMapping.GetValueOrDefault("InsuranceAdjustment", 0)),
                        PatientPaidAmount = GetCellValue(row, columnMapping.GetValueOrDefault("PatientPaidAmount", 0)),
                        PatientAdjustment = GetCellValue(row, columnMapping.GetValueOrDefault("PatientAdjustment", 0)),
                        InsuranceBalance = GetCellValue(row, columnMapping.GetValueOrDefault("InsuranceBalance", 0)),
                        PatientBalance = GetCellValue(row, columnMapping.GetValueOrDefault("PatientBalance", 0)),
                        TotalBalance = GetCellValue(row, columnMapping.GetValueOrDefault("TotalBalance", 0)),
                        FinalClaimStatus = GetCellValue(row, columnMapping.GetValueOrDefault("FinalClaimStatus", 0)),
                        ClaimSubStatus = GetCellValue(row, columnMapping.GetValueOrDefault("ClaimSubStatus", 0))
                    };

                    if (!string.IsNullOrEmpty(record.PayerName) && !string.IsNullOrEmpty(record.AccessionNo))
                    {
                        tempRecords.Add(record);
                        accessionNumbers.Add(record.AccessionNo);
                    }

                    if (rowCount % 1000 == 0)
                    {
                        LogMessage("INFO", $"Read {rowCount} rows...", false);
                    }
                }

                LogMessage("INFO", $"Total rows read: {rowCount}", true);
                LogMessage("INFO", $"Valid records found: {tempRecords.Count}", true);
                LogMessage("INFO", $"Unique accession numbers: {accessionNumbers.Count}", true);

                // Fetch ICD10 codes from LISMaster
                LogMessage("INFO", $"Fetching ICD10 codes from LISMaster...", true);
                var icd10CodeLookup = _databaseService.GetICD10CodesFromLISMaster(accessionNumbers.ToList());

                // Update records with LISMaster ICD10 or keep Excel ICD10
                int updatedFromLIS = 0;
                int keptFromExcel = 0;

                foreach (var record in tempRecords)
                {
                    // ICD10Code logic: Try to get from LISMaster first
                    if (icd10CodeLookup.TryGetValue(record.AccessionNo, out var lisICD10) &&
                        !string.IsNullOrEmpty(lisICD10))
                    {
                        record.ICD10Code = lisICD10;
                        updatedFromLIS++;
                    }

                    // CCWICDCODE logic: Always keep from Excel (already set above)
                    if (!string.IsNullOrEmpty(record.CCWICDCODE))
                    {
                        keptFromExcel++;
                    }

                    records.Add(record);
                }

                LogMessage("SUCCESS", $"Created {records.Count} records", true);
                LogMessage("INFO", $"ICD10Code updated from LISMaster: {updatedFromLIS}", true);
                LogMessage("INFO", $"CCWICDCODE kept from Excel: {keptFromExcel}", true);

                // Log new field statistics
                LogNewFieldStatistics(records);
            }

            return records;
        }

        private void LogNewFieldStatistics(List<DenialRecord> records)
        {
            LogMessage("INFO", "New Field Statistics:", true);
            LogMessage("INFO", $"Records with PatientDOB: {records.Count(r => !string.IsNullOrEmpty(r.PatientDOB))}", false);
            LogMessage("INFO", $"Records with PayerType: {records.Count(r => !string.IsNullOrEmpty(r.PayerType))}", false);
            LogMessage("INFO", $"Records with BeginDOS: {records.Count(r => !string.IsNullOrEmpty(r.BeginDOS))}", false);
            LogMessage("INFO", $"Records with Units: {records.Count(r => !string.IsNullOrEmpty(r.Units))}", false);
            LogMessage("INFO", $"Records with Modifier: {records.Count(r => !string.IsNullOrEmpty(r.Modifier))}", false);
            LogMessage("INFO", $"Records with DenialDescription: {records.Count(r => !string.IsNullOrEmpty(r.DenialDescription))}", false);
            LogMessage("INFO", $"Records with Financial data: {records.Count(r => !string.IsNullOrEmpty(r.BilledAmount) || !string.IsNullOrEmpty(r.AllowedAmount))}", false);
        }

        private Dictionary<string, int> FindColumnIndices(IXLWorksheet worksheet, IXLRangeRow headerRow)
        {
            var columnMapping = new Dictionary<string, int>();

            foreach (var cell in headerRow.Cells())
            {
                var headerValue = cell.Value.ToString().Trim();
                var columnNumber = cell.Address.ColumnNumber;

                // Map Excel column headers to our property names
                switch (headerValue.ToLower())
                {
                    case "payername":
                        columnMapping["PayerName"] = columnNumber;
                        break;
                    case "accessionno":
                        columnMapping["AccessionNo"] = columnNumber;
                        break;
                    case "visitnumber":
                        columnMapping["VisitNumber"] = columnNumber;
                        break;
                    case "denialcode":
                        columnMapping["DenialCode"] = columnNumber;
                        break;
                    case "cptcode":
                        columnMapping["CPTCode"] = columnNumber;
                        break;
                    case "icd10code":
                        columnMapping["ICD10Code"] = columnNumber;
                        break;
                    case "icdcode":
                        columnMapping["CCWICDCODE"] = columnNumber;
                        break;
                    // New field mappings
                    case "patientdob":
                    case "date of birth":
                    case "dob":
                        columnMapping["PatientDOB"] = columnNumber;
                        break;
                    case "payertype":
                    case "payer type":
                        columnMapping["PayerType"] = columnNumber;
                        break;
                    case "begindos":
                    case "begin dos":
                    case "date of service":
                        columnMapping["BeginDOS"] = columnNumber;
                        break;
                    case "firstbilldate":
                    case "first bill date":
                        columnMapping["FirstBillDate"] = columnNumber;
                        break;
                    case "panelname":
                    case "panel name":
                        columnMapping["PanelName"] = columnNumber;
                        break;
                    case "units":
                        columnMapping["Units"] = columnNumber;
                        break;
                    case "modifier":
                    case "modifiers":
                        columnMapping["Modifier"] = columnNumber;
                        break;
                    case "denialdescription":
                    case "denial description":
                    case "denial reason":
                        columnMapping["DenialDescription"] = columnNumber;
                        break;
                    case "billedamount":
                    case "billed amount":
                        columnMapping["BilledAmount"] = columnNumber;
                        break;
                    case "allowedamount":
                    case "allowed amount":
                        columnMapping["AllowedAmount"] = columnNumber;
                        break;
                    case "insurancepayment":
                    case "insurance payment":
                        columnMapping["InsurancePayment"] = columnNumber;
                        break;
                    case "insuranceadjustment":
                    case "insurance adjustment":
                        columnMapping["InsuranceAdjustment"] = columnNumber;
                        break;
                    case "patientpaidamount":
                    case "patient paid amount":
                        columnMapping["PatientPaidAmount"] = columnNumber;
                        break;
                    case "patientadjustment":
                    case "patient adjustment":
                        columnMapping["PatientAdjustment"] = columnNumber;
                        break;
                    case "insurancebalance":
                    case "insurance balance":
                        columnMapping["InsuranceBalance"] = columnNumber;
                        break;
                    case "patientbalance":
                    case "patient balance":
                        columnMapping["PatientBalance"] = columnNumber;
                        break;
                    case "totalbalance":
                    case "total balance":
                        columnMapping["TotalBalance"] = columnNumber;
                        break;
                    case "finalclaimstatus":
                    case "final claim status":
                    case "claim status":
                        columnMapping["FinalClaimStatus"] = columnNumber;
                        break;
                    case "claimsubstatus":
                    case "claim sub status":
                    case "sub status":
                        columnMapping["ClaimSubStatus"] = columnNumber;
                        break;
                }
            }

            return columnMapping;
        }

        private void ValidateColumnMapping(Dictionary<string, int> columnMapping)
        {
            // Original required columns
            var requiredColumns = new[] { "PayerName", "AccessionNo", "VisitNumber", "DenialCode", "CPTCode", "ICD10Code" };
            var missingColumns = requiredColumns.Where(col => !columnMapping.ContainsKey(col)).ToList();

            if (missingColumns.Any())
            {
                throw new Exception($"Missing required columns in Excel file: {string.Join(", ", missingColumns)}");
            }

            // Log warnings for missing optional columns
            var optionalColumns = new[] {
        "PatientDOB", "PayerType", "BeginDOS", "FirstBillDate", "PanelName",
        "Units", "Modifier", "DenialDescription", "BilledAmount", "AllowedAmount",
        "InsurancePayment", "InsuranceAdjustment", "PatientPaidAmount", "PatientAdjustment",
        "InsuranceBalance", "PatientBalance", "TotalBalance", "FinalClaimStatus", "ClaimSubStatus"
    };

            foreach (var col in optionalColumns)
            {
                if (!columnMapping.ContainsKey(col))
                {
                    LogMessage("WARNING", $"{col} column not found in Excel. Will use empty value.", false);
                }
            }

            // Log warning if CCWICDCODE column not found
            if (!columnMapping.ContainsKey("CCWICDCODE"))
            {
                LogMessage("WARNING", "ICDCODE column not found in Excel. CCWICDCODE will be empty.", true);
            }
        }

        private string GetCellValue(IXLRangeRow row, int column)
        {
            if (column == 0) return string.Empty; // Column 0 means column not found
            return row.Cell(column).Value.ToString().Trim();
        }
        private List<DenialRecord> FillPayerInfoFromDatabase(List<DenialRecord> records)
        {
            var filteredRecords = new List<DenialRecord>();

            if (records == null || !records.Any())
                return filteredRecords;

            // Get unique payer names from the records
            var uniquePayerNames = records
                .Select(r => r.PayerName?.Trim())
                .Where(name => !string.IsNullOrEmpty(name))
                .Distinct()
                .ToList();

            LogMessage("INFO", $"Found {uniquePayerNames.Count} unique payer names in Excel data", true);

            // Use DatabaseService to get payer mappings with Global_Payer_ID
            var payerMappings = _databaseService.GetPayerInfoFromCOInsuranceMaster(uniquePayerNames);

            if (payerMappings == null || !payerMappings.Any())
            {
                LogMessage("ERROR", "No payer mappings found in COInsuranceMaster", true);
                return filteredRecords;
            }

            LogMessage("SUCCESS", $"Found {payerMappings.Count} payer mappings in COInsuranceMaster", true);

            // Create a lookup dictionary for quick access - Using the PayerLookupInfo class
            var payerLookup = payerMappings.ToDictionary(
                pm => pm.PayerName?.Trim() ?? "",
                pm => new PayerLookupInfo
                {
                    GlobalPayerID = pm.GlobalPayerID,
                    PayerShortCode = pm.PayerShortCode
                },
                StringComparer.OrdinalIgnoreCase
            );

            int matchedCount = 0;
            int notMatchedCount = 0;

            foreach (var record in records)
            {
                if (string.IsNullOrEmpty(record.PayerName))
                {
                    notMatchedCount++;
                    continue;
                }

                var normalizedPayerName = record.PayerName.Trim();

                if (payerLookup.TryGetValue(normalizedPayerName, out var payerInfo))
                {
                    // Found in COInsuranceMaster - include this record
                    record.GlobalPayerID = payerInfo.GlobalPayerID;
                    record.PayerShortCode = payerInfo.PayerShortCode;
                    filteredRecords.Add(record);
                    matchedCount++;
                }
                else
                {
                    // Not found in COInsuranceMaster - skip this record
                    notMatchedCount++;
                }
            }

            // Log summary
            LogMessage("SUMMARY", $"Payer Matching Results:", true);
            LogMessage("SUMMARY", $"  Total records from Excel: {records.Count}", true);
            LogMessage("SUMMARY", $"  Matched in COInsuranceMaster: {matchedCount}", true);
            LogMessage("SUMMARY", $"  Not matched (filtered out): {notMatchedCount}", true);

            // Log unmatched payers (if any) to a separate file for reference
            if (notMatchedCount > 0)
            {
                LogUnmatchedPayers(records, payerLookup);
            }

            return filteredRecords;
        }

        private void LogUnmatchedPayers(List<DenialRecord> allRecords, Dictionary<string, PayerLookupInfo> payerLookup)
        {
            try
            {
                var unmatchedPayers = allRecords
                    .Where(r => !string.IsNullOrEmpty(r.PayerName) &&
                           !payerLookup.ContainsKey(r.PayerName.Trim()))
                    .Select(r => r.PayerName.Trim())
                    .Distinct()
                    .ToList();

                if (unmatchedPayers.Any())
                {
                    var logFilePath = Path.Combine(_logFolder, $"UnmatchedPayers_{DateTime.Now:yyyyMMdd_HHmmss}.txt");

                    var logContent = $"Unmatched Payers Log - {DateTime.Now:yyyy-MM-dd HH:mm:ss}\n";
                    logContent += "=".PadRight(50, '=') + "\n";
                    logContent += $"Total unmatched payers: {unmatchedPayers.Count}\n\n";

                    foreach (var payer in unmatchedPayers.OrderBy(p => p))
                    {
                        logContent += $"- {payer}\n";
                    }

                    File.WriteAllText(logFilePath, logContent);
                    LogMessage("INFO", $"Unmatched payers logged to: {logFilePath}", true);
                }
            }
            catch (Exception ex)
            {
                LogMessage("WARNING", $"Could not create unmatched payers log: {ex.Message}", true);
            }
        }

        //private void WriteToCSV(List<DenialRecord> records, string outputPath)
        //{
        //    var directory = Path.GetDirectoryName(outputPath);
        //    if (!Directory.Exists(directory))
        //    {
        //        Directory.CreateDirectory(directory);
        //    }

        //    using (var writer = new StreamWriter(outputPath))
        //    {
        //        // Write header including Global_Payer_ID
        //        writer.WriteLine("Global_Payer_ID,Payer_Name_Raw,PayerShortCode,Accession,VisitNumber,DenialCode,CPTCode,ICD10Code");

        //        int recordCount = 0;
        //        foreach (var record in records)
        //        {
        //            // Skip records without GlobalPayerID
        //            if (string.IsNullOrEmpty(record.GlobalPayerID))
        //                continue;

        //            var line = $"\"{EscapeCsvField(record.GlobalPayerID)}\"," +
        //                      $"\"{EscapeCsvField(record.PayerName)}\"," +
        //                      $"\"{EscapeCsvField(record.PayerShortCode)}\"," +
        //                      $"\"{EscapeCsvField(record.AccessionNo)}\"," +
        //                      $"\"{EscapeCsvField(record.VisitNumber)}\"," +
        //                      $"\"{EscapeCsvField(record.DenialCode)}\"," +
        //                      $"\"{EscapeCsvField(record.CPTCode)}\"," +
        //                      $"\"{EscapeCsvField(ExtractICDBeforeFirstHyphen(record.ICD10Code))}\"";

        //            writer.WriteLine(line);
        //            recordCount++;

        //            // Log progress for every 1000 records
        //            if (recordCount % 1000 == 0)
        //            {
        //                LogMessage("INFO", $"Written {recordCount} records to CSV...", false);
        //            }
        //        }

        //        LogMessage("SUCCESS", $"Total records written to CSV: {recordCount}", true);
        //    }



        //}

        // In DenialPayerPolicyCSVGenerator.WriteToCSV() method:
        private void WriteToCSV(List<DenialRecord> records, string outputPath)
        {
            // Create directory first
            var directory = Path.GetDirectoryName(outputPath);
            if (!Directory.Exists(directory))
            {
                Directory.CreateDirectory(outputPath);
                LogMessage("INFO", $"Created directory: {directory}", false);
            }

            // Write file
            using (var writer = new StreamWriter(outputPath, false, Encoding.UTF8)) // Explicit encoding
            {
                // Write header
                writer.WriteLine("LabName,PayerName,PayerShortCode,Accession,VisitNumber,DenialCode,CPTCode,LIS_ICD10Codes,CCW_ICD10Code," +
                                "PatientDOB,PayerType,DateOfService,FirstBillDate,PanelName,Units,Modifier,DenialDescription," +
                                "BilledAmount,AllowedAmount,InsurancePayment,InsuranceAdjustment,PatientPaidAmount," +
                                "PatientAdjustment,InsuranceBalance,PatientBalance,TotalBalance,FinalClaimStatus,ClaimSubStatus");

                // ... write records ...
            } // File is automatically closed here

            LogMessage("INFO", $"Force flushing file system...", false);
            System.IO.File.WriteAllText(outputPath + ".flush", ""); // Force flush
            System.IO.File.Delete(outputPath + ".flush");

            LogMessage("SUCCESS", $"CSV file created successfully and closed: {outputPath}", true);
        }

        private string FormatDateField(string dateValue)
        {
            if (string.IsNullOrEmpty(dateValue))
                return string.Empty;

            // Try to parse the date and format it consistently
            if (DateTime.TryParse(dateValue, out DateTime parsedDate))
            {
                return parsedDate.ToString("yyyy-MM-dd");
            }

            // If can't parse, return original value
            return dateValue;
        }

        private void LogSampleRecord(DenialRecord record)
        {
            LogMessage("DEBUG", "First record sample:", false);
            LogMessage("DEBUG", $"  PayerName: {record.PayerName}", false);
            LogMessage("DEBUG", $"  GlobalPayerID: {record.GlobalPayerID}", false);
            LogMessage("DEBUG", $"  PatientDOB: {record.PatientDOB}", false);
            LogMessage("DEBUG", $"  PayerType: {record.PayerType}", false);
            LogMessage("DEBUG", $"  BeginDOS: {record.BeginDOS}", false);
            LogMessage("DEBUG", $"  DenialDescription: {record.DenialDescription}", false);
            LogMessage("DEBUG", $"  BilledAmount: {record.BilledAmount}", false);
            LogMessage("DEBUG", $"  FinalClaimStatus: {record.FinalClaimStatus}", false);
        }
        private string ExtractICDBeforeFirstHyphen(string icd10Code)
        {
            if (string.IsNullOrEmpty(icd10Code))
                return icd10Code;

            // Trim any leading/trailing whitespace
            icd10Code = icd10Code.Trim();

            // Find the first occurrence of hyphen
            int firstHyphenIndex = icd10Code.IndexOf('-');

            if (firstHyphenIndex > 0)
            {
                // Extract substring before the first hyphen and trim
                return icd10Code.Substring(0, firstHyphenIndex).Trim();
            }

            // If no hyphen found or it's the first character, return the original name
            return icd10Code;
        }

        private string EscapeCsvField(string field)
        {
            if (string.IsNullOrEmpty(field))
                return string.Empty;

            if (field.Contains("\"") || field.Contains(",") || field.Contains("\n") || field.Contains("\r"))
            {
                return field.Replace("\"", "\"\"");
            }

            return field;
        }


    }
}