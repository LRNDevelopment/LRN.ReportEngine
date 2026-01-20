using ClosedXML.Excel;
using DocumentFormat.OpenXml.InkML;
using DocumentFormat.OpenXml.Spreadsheet;
using DocumentFormat.OpenXml.Wordprocessing;
using Microsoft.Extensions.Configuration;
using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Reflection.Emit;
using System.Text;

namespace LRN.CodingMasterValidation
{
    public class CodingMasterCSVGenerator
    {
        private string _logFolder;
        private string _inputFolder;
        private string _outputFolder;
        private string _excelFileName;
        private string _logFilePath;
        private readonly StringBuilder _sessionLog;
        private readonly IConfiguration _configuration; // Store configuration

        // ============ UPDATED CONSTRUCTOR ============
        // Primary constructor that accepts IConfiguration
        //public CodingMasterCSVGenerator(IConfiguration configuration = null)
        //{
        //    _configuration = configuration;

        //    // Get folder paths from configuration
        //    _logFolder = GetConfigValue("LogFolder", @"E:\LRN-Data\CodingMaster\Logs");
        //    _inputFolder = GetConfigValue("InputFolder", @"E:\LRN-Data\CodingMaster\Inputs");
        //    _outputFolder = GetConfigValue("OutputFolder", @"E:\LRN-Data\CodingMaster\Outputs");
        //    _excelFileName = GetConfigValue("ExcelFileName", "PCRDx_-_CO_Production_Master.xlsx");

        //    _sessionLog = new StringBuilder();
        //    InitializeLogging();
        //}


        private readonly LabContext _lab;
       


        public CodingMasterCSVGenerator(IConfiguration configuration, LabContext lab)
        {
            _configuration = configuration;
            _lab = lab;

            _logFolder = lab.LogFolder;
            _inputFolder = lab.InputFolder;
            _outputFolder = lab.OutputFolder; // 🔥 processing only
            _excelFileName = Path.GetFileName(lab.SourceFile);

            _sessionLog = new StringBuilder();
            InitializeLogging();
        }

        private bool IsPCRALLab()
        {
            return _lab.InputFolder
                .Contains(@"\PCRAL\", StringComparison.OrdinalIgnoreCase);
        }

        // ============ KEEP OLD CONSTRUCTOR FOR BACKWARD COMPATIBILITY ============
        // Parameterized constructor (for backward compatibility)
        public CodingMasterCSVGenerator(string logFolder, string inputFolder, string outputFolder, string excelFileName)
        {
            _logFolder = logFolder;
            _inputFolder = inputFolder;
            _outputFolder = outputFolder;
            _excelFileName = excelFileName;
            _sessionLog = new StringBuilder();
            InitializeLogging();
        }

        // ============ UPDATED GetConfigValue METHOD ============
        private string GetConfigValue(string key, string defaultValue)
        {
            try
            {
                if (_configuration == null)
                {
                    LogMessage("WARNING", $"Configuration is null, using default for {key}: {defaultValue}", false);
                    return defaultValue;
                }

                // Try to get from CodingMaster section first
                var value = _configuration[$"CodingMaster:{key}"];

                if (!string.IsNullOrEmpty(value))
                {
                    LogMessage("INFO", $"Loaded {key} from config: {value}", false);
                    return value;
                }
                else
                {
                    LogMessage("WARNING", $"Configuration key 'CodingMaster:{key}' not found or empty", false);
                    LogMessage("INFO", $"Using default for {key}: {defaultValue}", false);
                    return defaultValue;
                }
            }
            catch (Exception ex)
            {
                LogMessage("ERROR", $"Error reading configuration for {key}: {ex.Message}", false);
                LogMessage("INFO", $"Using default for {key}: {defaultValue}", false);
                return defaultValue;
            }
        }

        // ============ REMOVE OLD LoadConfiguration METHOD ============
        // Delete this entire method:
        // private IConfiguration LoadConfiguration() { ... }

        private void InitializeLogging()
        {
            try
            {
                // Validate and create log folder
                if (string.IsNullOrEmpty(_logFolder))
                {
                    _logFolder = Path.Combine(Directory.GetCurrentDirectory(), "Logs");
                    Console.WriteLine($"Warning: Log folder not specified, using default: {_logFolder}");
                }

                if (!Directory.Exists(_logFolder))
                {
                    try
                    {
                        Directory.CreateDirectory(_logFolder);
                        Console.WriteLine($"Created log folder: {_logFolder}");
                    }
                    catch (Exception ex)
                    {
                        Console.WriteLine($"Failed to create log folder '{_logFolder}': {ex.Message}");
                        // Use current directory as fallback
                        _logFolder = Directory.GetCurrentDirectory();
                        Console.WriteLine($"Using current directory for logs: {_logFolder}");
                    }
                }

                // Set up log file path
                string dateStamp = DateTime.Now.ToString("yyyyMMdd");
                string logFileName = $"CodingMaster_CSVGenerator_{dateStamp}.log";
                _logFilePath = Path.Combine(_logFolder, logFileName);

                // Create initial log header
                string logHeader = $@"╔══════════════════════════════════════════════════════════════╗
║   Coding Master CSV Generator                              ║
║   Log File: {logFileName,-37} ║
║   Created: {DateTime.Now:yyyy-MM-dd HH:mm:ss,-30} ║
║   Config: Input={_inputFolder} ║
║           Output={_outputFolder} ║
╚══════════════════════════════════════════════════════════════╝

";

                try
                {
                    if (!File.Exists(_logFilePath))
                    {
                        File.AppendAllText(_logFilePath, logHeader);
                    }
                    else
                    {
                        File.AppendAllText(_logFilePath, $"\n{new string('=', 80)}\n");
                        File.AppendAllText(_logFilePath, $"NEW SESSION: {DateTime.Now:yyyy-MM-dd HH:mm:ss}\n");
                        File.AppendAllText(_logFilePath, $"{new string('=', 80)}\n\n");
                    }

                    // Log configuration details
                    Console.WriteLine("[CONFIG] Configuration loaded:");
                    Console.WriteLine($"[CONFIG]   Log Folder: {_logFolder}");
                    Console.WriteLine($"[CONFIG]   Input Folder: {_inputFolder}");
                    Console.WriteLine($"[CONFIG]   Output Folder: {_outputFolder}");
                    Console.WriteLine($"[CONFIG]   Excel File Name: {_excelFileName}");

                    // Also write to log file
                    File.AppendAllText(_logFilePath, $"[{DateTime.Now:yyyy-MM-dd HH:mm:ss.fff}] [CONFIG] Configuration loaded:\n");
                    File.AppendAllText(_logFilePath, $"[{DateTime.Now:yyyy-MM-dd HH:mm:ss.fff}] [CONFIG]   Log Folder: {_logFolder}\n");
                    File.AppendAllText(_logFilePath, $"[{DateTime.Now:yyyy-MM-dd HH:mm:ss.fff}] [CONFIG]   Input Folder: {_inputFolder}\n");
                    File.AppendAllText(_logFilePath, $"[{DateTime.Now:yyyy-MM-dd HH:mm:ss.fff}] [CONFIG]   Output Folder: {_outputFolder}\n");
                    File.AppendAllText(_logFilePath, $"[{DateTime.Now:yyyy-MM-dd HH:mm:ss.fff}] [CONFIG]   Excel File Name: {_excelFileName}\n");

                }
                catch (Exception ex)
                {
                    Console.WriteLine($"Warning: Could not write to log file '{_logFilePath}': {ex.Message}");
                    _logFilePath = null;
                }
            }
            catch (Exception ex)
            {
                Console.WriteLine($"Critical error in InitializeLogging: {ex.Message}");
                _logFilePath = null;
            }
        }


        private void LogMessage(string level, string message, bool echoToConsole = true)
        {
            try
            {
                string timestamp = DateTime.Now.ToString("yyyy-MM-dd HH:mm:ss.fff");
                string logEntry = $"[{timestamp}] [{level}] {message}";

                // Always append to session log
                if (_sessionLog != null)
                {
                    _sessionLog.AppendLine(logEntry);
                }

                // Write to log file if path is available
                if (!string.IsNullOrEmpty(_logFilePath))
                {
                    try
                    {
                        // Ensure directory exists before writing
                        string logDirectory = Path.GetDirectoryName(_logFilePath);
                        if (!string.IsNullOrEmpty(logDirectory) && !Directory.Exists(logDirectory))
                        {
                            Directory.CreateDirectory(logDirectory);
                        }

                        File.AppendAllText(_logFilePath, logEntry + Environment.NewLine);
                    }
                    catch (Exception ex)
                    {
                        // Don't throw, just write to console
                        Console.WriteLine($"[ERROR] Failed to write to log file '{_logFilePath}': {ex.Message}");
                    }
                }
                else
                {
                    // If log file path is not set, write warning to console
                    if (echoToConsole)
                    {
                        Console.WriteLine($"[WARNING] Log file path not initialized. Log entry: {logEntry}");
                    }
                }

                if (echoToConsole)
                {
                    switch (level.ToUpper())
                    {
                        case "ERROR": Console.ForegroundColor = ConsoleColor.Red; break;
                        case "WARNING": Console.ForegroundColor = ConsoleColor.Yellow; break;
                        case "SUCCESS": Console.ForegroundColor = ConsoleColor.Green; break;
                        case "INFO": Console.ForegroundColor = ConsoleColor.Cyan; break;
                        case "CONFIG": Console.ForegroundColor = ConsoleColor.Magenta; break;
                        case "SEPARATOR": Console.ForegroundColor = ConsoleColor.Gray; break;
                        case "SUMMARY": Console.ForegroundColor = ConsoleColor.Blue; break;
                        default: Console.ForegroundColor = ConsoleColor.White; break;
                    }

                    Console.WriteLine(logEntry);
                    Console.ResetColor();
                }
            }
            catch (Exception ex)
            {
                // Last resort error handling
                Console.WriteLine($"[CRITICAL ERROR] LogMessage failed: {ex.Message}");
            }
        }

        private void LogToConsole(string message, ConsoleColor color = ConsoleColor.White)
        {
            Console.ForegroundColor = color;
            Console.WriteLine(message);
            Console.ResetColor();
        }

        //public class ProductionRecord
        //{
        //    public string VisitNumber { get; set; } = "";
        //    public string AccessionNo { get; set; } = "";
        //    public string PanelName { get; set; } = "";
        //    public string Carrier { get; set; } = "";
        //    public string ActualCPTCode { get; set; } = "";
        //    public decimal TotalCharge { get; set; }
        //}

        public string LastGeneratedFilePath { get; private set; }

        private string ResolveInputExcelFile()
        {
            // If SourceFile is a file → use it directly
            if (File.Exists(_lab.SourceFile))
            {
                return _lab.SourceFile;
            }

            // If SourceFile is a directory → pick latest Excel file
            if (Directory.Exists(_lab.SourceFile))
            {
                var excelFile = Directory
                    .GetFiles(_lab.SourceFile, "*.xlsx")
                    .OrderByDescending(File.GetLastWriteTime)
                    .FirstOrDefault();

                if (excelFile != null)
                    return excelFile;
            }

            throw new FileNotFoundException(
                $"No Excel file found under SourceFile path: {_lab.SourceFile}");
        }


        public string GenerateProductionCSV()
        {
            DateTime startTime = DateTime.Now;
            string generatedCsvPath = null;

            try
            {
                LogMessage("INFO", "Starting Production Master CSV Generation", true);
                LogMessage("INFO", $"Start Time: {startTime:yyyy-MM-dd HH:mm:ss}", true);
                LogMessage("SEPARATOR", new string('=', 80), true);

                // Set file paths using configuration
                //string inputFile = Path.Combine(_inputFolder, _excelFileName);
                //string outputFile = Path.Combine(_outputFolder, $"ProductionMaster_Extracted_{DateTime.Now:yyyyMMdd_HHmmss}.csv");

                string inputFile = ResolveInputExcelFile();

                string outputFile = Path.Combine(
                    _outputFolder,
                    $"ProductionMaster_Extracted_{DateTime.Now:yyyyMMdd_HHmmss}.csv"
                );

                LogMessage("INFO", $"Resolved Source Excel file: {inputFile}", true);


               // LogMessage("INFO", $"Input file: {inputFile}", true);
                LogMessage("INFO", $"Output file: {outputFile}", true);

                // Validate that input file exists
                if (!File.Exists(inputFile))
                {
                    LogMessage("ERROR", $"Input Excel file not found: {inputFile}", true);
                    throw new FileNotFoundException($"Excel file not found: {inputFile}");
                }

                // Step 1: Extract data from Excel
                LogMessage("INFO", "Reading Excel file...", true);
                var stopwatch = System.Diagnostics.Stopwatch.StartNew();
                var records = ExtractDataFromExcel(inputFile);
                stopwatch.Stop();

                LogMessage("SUCCESS", $"Extracted {records.Count} records in {stopwatch.Elapsed.TotalSeconds:F2} seconds", true);

                if (records.Count == 0)
                {
                    LogMessage("ERROR", "No records found in Excel file. Process stopped.", true);
                    return null;
                }

                // Step 2: Write to CSV
                LogMessage("INFO", "Writing data to CSV...", true);
                stopwatch.Restart();
                var supplementMap = LoadSupplementForPCRAL();

                // ===================== PANEL1 LOGIC (PCRAL | CONFIG DRIVEN) =====================
                if (IsPCRALLab() && supplementMap.Any())
                {
                    var eligiblePanels = GetPanel1EligiblePanels();

                    if (eligiblePanels.Any())
                    {
                        foreach (var record in records)
                        {
                            if (!string.IsNullOrWhiteSpace(record.PanelName)
                                && eligiblePanels.Contains(record.PanelName)
                                && supplementMap.TryGetValue(record.AccessionNo, out var sup))
                            {
                                record.Panel1 = sup.Panel;
                            }
                            else
                            {
                                record.Panel1 = record.PanelName;
                            }
                        }
                    }
                }
                // ===============================================================================



                WriteToCSV(records, outputFile);

                LastGeneratedFilePath = outputFile;
                stopwatch.Stop();

                generatedCsvPath = outputFile;

                LogMessage("SUCCESS", $"CSV created in {stopwatch.Elapsed.TotalSeconds:F2} seconds", true);
                LogMessage("SUCCESS", $"CSV saved to: {outputFile}", true);

                // Step 3: Generate summary
                DateTime endTime = DateTime.Now;
                TimeSpan duration = endTime - startTime;

                LogMessage("SEPARATOR", new string('=', 80), true);
                LogMessage("SUMMARY", "PROCESS COMPLETED SUCCESSFULLY", true);
                LogMessage("SUMMARY", $"Start Time: {startTime:yyyy-MM-dd HH:mm:ss}", true);
                LogMessage("SUMMARY", $"End Time: {endTime:yyyy-MM-dd HH:mm:ss}", true);
                LogMessage("SUMMARY", $"Total Duration: {duration:hh\\:mm\\:ss}", true);
                LogMessage("SUMMARY", $"Total Records: {records.Count}", true);
                LogMessage("SUMMARY", $"CSV File Size: {GetFileSize(new FileInfo(outputFile).Length)}", true);
                LogMessage("SEPARATOR", new string('=', 80), true);

                // Write summary report
                WriteSummaryReport(startTime, endTime, duration, records.Count, outputFile);
                return outputFile;
            }
            catch (Exception ex)
            {
                LogMessage("ERROR", $"Error generating CSV: {ex.Message}", true);
                LogMessage("ERROR", $"Stack Trace: {ex.StackTrace}", false);
                throw;
            }
        }
        private HashSet<string> GetPanel1EligiblePanels()
        {
            var panels = _configuration
                .GetSection("PCRAL:Panel1EligiblePanels")
                .Get<List<string>>();

            if (panels == null || panels.Count == 0)
            {
                LogMessage(
                    "WARNING",
                    "PCRAL:Panel1EligiblePanels not configured. Panel1 logic will be skipped.",
                    true);
                return new HashSet<string>(StringComparer.OrdinalIgnoreCase);
            }

            return new HashSet<string>(panels, StringComparer.OrdinalIgnoreCase);
        }

        //private List<ProductionRecord> ExtractDataFromExcel(string filePath)
        //{
        //    var records = new List<ProductionRecord>();

        //    if (!File.Exists(filePath))
        //    {
        //        throw new FileNotFoundException($"Excel file not found: {filePath}");
        //    }

        //    LogMessage("INFO", $"Reading Excel file: {filePath}", true);

        //    using (var workbook = new XLWorkbook(filePath))
        //    {
        //        var worksheet = workbook.Worksheet("Master Claim level");
        //        if (worksheet == null)
        //        {
        //            throw new Exception("Worksheet 'Master Claim level' not found in the Excel file");
        //        }

        //        var usedRange = worksheet.RangeUsed();
        //        if (usedRange == null)
        //        {
        //            throw new Exception("No data found in 'Master Claim level' worksheet");
        //        }

        //        int rowCount = usedRange.RowCount();
        //        LogMessage("INFO", $"Found {rowCount} rows in worksheet (including header)", true);

        //        // Get column indices from header row
        //        var headerRow = worksheet.Row(1);
        //        var columnMapping = FindColumnIndices(headerRow);
        //        ValidateColumnMapping(columnMapping);

        //        // Pre-allocate list with estimated capacity
        //        records = new List<ProductionRecord>(rowCount - 1);

        //        int processedCount = 0;
        //        int skippedCount = 0;

        //        // Process rows in batches for better performance
        //        for (int rowNum = 2; rowNum <= rowCount; rowNum++)
        //        {
        //            try
        //            {
        //                var record = ProcessRow(worksheet, rowNum, columnMapping);

        //                if (!string.IsNullOrEmpty(record.VisitNumber))
        //                {
        //                    records.Add(record);
        //                    processedCount++;
        //                }
        //                else
        //                {
        //                    skippedCount++;
        //                }

        //                // Log progress every 1000 rows
        //                if (rowNum % 1000 == 0)
        //                {
        //                    LogMessage("INFO", $"Processed {rowNum} rows...", false);
        //                }
        //            }
        //            catch (Exception ex)
        //            {
        //                LogMessage("WARNING", $"Error processing row {rowNum}: {ex.Message}", false);
        //                skippedCount++;
        //            }
        //        }

        //        LogMessage("SUCCESS", $"Processing complete: {processedCount} records processed, {skippedCount} skipped", true);
        //    }

        //    return records;
        //}

        private List<ProductionRecord> ExtractDataFromExcel(string filePath)
        {
            var records = new List<ProductionRecord>();

            if (!File.Exists(filePath))
            {
                throw new FileNotFoundException($"Excel file not found: {filePath}");
            }

            LogMessage("INFO", $"Reading Excel file: {filePath}", true);

            using (var workbook = new XLWorkbook(filePath))
            {
                var worksheet = workbook.Worksheet("Master Claim level");
                if (worksheet == null)
                {
                    throw new Exception("Worksheet 'Master Claim level' not found in the Excel file");
                }

                var usedRange = worksheet.RangeUsed();
                if (usedRange == null)
                {
                    throw new Exception("No data found in 'Master Claim level' worksheet");
                }

                int rowCount = usedRange.RowCount();
                LogMessage("INFO", $"Found {rowCount} rows in worksheet (including header)", true);

                // Get column indices from header row
                var headerRow = worksheet.Row(1);
                var columnMapping = FindColumnIndices(headerRow);
                ValidateColumnMapping(columnMapping);

                // Pre-allocate list with estimated capacity
                records = new List<ProductionRecord>(rowCount - 1);

                int processedCount = 0;
                int skippedCount = 0;

                // Process rows in batches for better performance
                for (int rowNum = 2; rowNum <= rowCount; rowNum++)
                {
                    try
                    {
                        var record = ProcessRow(worksheet, rowNum, columnMapping);

                        if (!string.IsNullOrEmpty(record.VisitNumber))
                        {
                            records.Add(record);
                            processedCount++;
                        }
                        else
                        {
                            skippedCount++;
                        }

                        // Log progress every 1000 rows
                        if (rowNum % 1000 == 0)
                        {
                            LogMessage("INFO", $"Processed {rowNum} rows...", false);
                        }
                    }
                    catch (Exception ex)
                    {
                        LogMessage("WARNING", $"Error processing row {rowNum}: {ex.Message}", false);
                        skippedCount++;
                    }
                }

                LogMessage("SUCCESS", $"Processing complete: {processedCount} records processed, {skippedCount} skipped", true);
            }

            return records;
        }

        //private Dictionary<string, int> FindColumnIndices(IXLRow headerRow)
        //{
        //    var columnMapping = new Dictionary<string, int>();

        //    foreach (var cell in headerRow.Cells())
        //    {
        //        var headerValue = cell.Value.ToString().Trim();
        //        var columnNumber = cell.Address.ColumnNumber;

        //        // Map Excel column headers to our property names
        //        switch (headerValue.ToLower())
        //        {
        //            case "visitnumber":
        //            case "visit number":
        //                columnMapping["VisitNumber"] = columnNumber;
        //                break;
        //            case "accessionno":
        //            case "accession no":
        //            case "accession":
        //                columnMapping["AccessionNo"] = columnNumber;
        //                break;
        //            case "panelname":
        //            case "panel name":
        //                columnMapping["PanelName"] = columnNumber;
        //                break;
        //            case "carrier":
        //            case "payer":
        //            case "payer name":
        //                columnMapping["Carrier"] = columnNumber;
        //                break;
        //            case "cptcode":
        //            case "cpt code":
        //            case "actualcptcode":
        //                columnMapping["ActualCPTCode"] = columnNumber;
        //                break;
        //            case "totalcharge":
        //            case "total charge":
        //            case "charge":
        //            case "amount":
        //                columnMapping["TotalCharge"] = columnNumber;
        //                break;
        //        }
        //    }

        //    return columnMapping;
        //}

        private Dictionary<string, int> FindColumnIndices(IXLRow headerRow)
        {
            var columnMapping = new Dictionary<string, int>();

            foreach (var cell in headerRow.Cells())
            {
                var headerValue = cell.Value.ToString().Trim();
                var columnNumber = cell.Address.ColumnNumber;

                // Map Excel column headers to our property names
                switch (headerValue.ToLower())
                {
                    // Existing mappings
                    case "visitnumber":
                    case "visit number":
                        columnMapping["VisitNumber"] = columnNumber;
                        break;
                    case "accessionno":
                    case "accession no":
                    case "accession":
                        columnMapping["AccessionNo"] = columnNumber;
                        break;
                    case "panelname":
                    case "panel name":
                        columnMapping["PanelName"] = columnNumber;
                        break;
                    case "carrier":
                    case "payer":
                    case "payer name":
                        columnMapping["Carrier"] = columnNumber;
                        break;
                    case "cptcode":
                    case "cpt code":
                    case "actualcptcode":
                        columnMapping["ActualCPTCode"] = columnNumber;
                        break;
                    case "totalcharge":
                    case "total charge":
                    case "charge":
                    case "amount":
                        columnMapping["TotalCharge"] = columnNumber;
                        break;

                    // PaymentPercentage mapping
                   

                    // NEW MAPPINGS
                    case "financialclass":
                    case "financial class":
                        columnMapping["FinancialClass"] = columnNumber;
                        break;
                    case "billingprovider":
                    case "billing provider":
                        columnMapping["BillingProvider"] = columnNumber;
                        break;
                    case "referringprovidername":
                    case "referring provider name":
                        columnMapping["ReferringProviderName"] = columnNumber;
                        break;
                    case "chartnumber":
                    case "chart number":
                        columnMapping["ChartNumber"] = columnNumber;
                        break;
                    case "patientname":
                    case "patient name":
                        columnMapping["PatientName"] = columnNumber;
                        break;
                    case "patientdob":
                    case "patient dob":
                    case "date of birth":
                        columnMapping["PatientDOB"] = columnNumber;
                        break;
                    case "responsibleparty":
                    case "responsible party":
                        columnMapping["ResponsibleParty"] = columnNumber;
                        break;
                    case "testtype":
                    case "test type":
                        columnMapping["TestType"] = columnNumber;
                        break;
                    case "clinicname":
                    case "clinic name":
                        columnMapping["ClinicName"] = columnNumber;
                        break;
                    case "facility":
                        columnMapping["Facility"] = columnNumber;
                        break;
                    case "begindos":
                    case "begin dos":
                    case "date of service":
                        columnMapping["BeginDOS"] = columnNumber;
                        break;
                    case "aging":
                        columnMapping["Aging"] = columnNumber;
                        break;
                    case "agingbucket":
                    case "aging bucket":
                        columnMapping["AgingBucket"] = columnNumber;
                        break;
                    case "amddoe":
                    case "amd doe":
                        columnMapping["AMDDOE"] = columnNumber;
                        break;
                    case "firstbilldate":
                    case "first bill date":
                        columnMapping["FirstBillDate"] = columnNumber;
                        break;
                    case "chargeentrydate":
                    case "charge entry date":
                        columnMapping["ChargeEntryDate"] = columnNumber;
                        break;
                    case "denialposteddate":
                    case "denial posted date":
                        columnMapping["DenialPostedDate"] = columnNumber;
                        break;
                    case "checkdate":
                    case "check date":
                        columnMapping["CheckDate"] = columnNumber;
                        break;
                    case "paymentposteddate":
                    case "payment posted date":
                        columnMapping["PaymentPostedDate"] = columnNumber;
                        break;
                    case "checknumber":
                    case "check number":
                        columnMapping["CheckNumber"] = columnNumber;
                        break;
                    case "billednotbilled":
                    case "billed not billed":
                        columnMapping["BilledNotBilled"] = columnNumber;
                        break;
                    case "pos":
                    case "place of service":
                        columnMapping["POS"] = columnNumber;
                        break;
                    case "tos":
                    case "type of service":
                        columnMapping["TOS"] = columnNumber;
                        break;
                    case "primarydiagnosis":
                    case "primary diagnosis":
                    case "icd10":
                        columnMapping["PrimaryDiagnosis"] = columnNumber;
                        break;
                    case "actualdenialcode":
                    case "actual denial code":
                        columnMapping["ActualDenialCode"] = columnNumber;
                        break;
                    case "denialcode":
                    case "denial code":
                        columnMapping["DenialCode"] = columnNumber;
                        break;
                    case "denialdescription":
                    case "denial description":
                        columnMapping["DenialDescription"] = columnNumber;
                        break;
                    case "totalallowed":
                    case "total allowed":
                        columnMapping["TotalAllowed"] = columnNumber;
                        break;
                    case "carrierpayment":
                    case "carrier payment":
                        columnMapping["CarrierPayment"] = columnNumber;
                        break;
                    case "paymentpercentage":
                    case "payment percentage":
                        columnMapping["PaymentPercentage"] = columnNumber;
                        break;
                    case "carrierwo":
                    case "carrier wo":
                    case "carrier write-off":
                        columnMapping["CarrierWO"] = columnNumber;
                        break;
                    case "patientpaidamount":
                    case "patient paid amount":
                        columnMapping["PatientPaidAmount"] = columnNumber;
                        break;
                    case "patientwo":
                    case "patient wo":
                    case "patient write-off":
                        columnMapping["PatientWO"] = columnNumber;
                        break;
                    case "carrierbalance":
                    case "carrier balance":
                        columnMapping["CarrierBalance"] = columnNumber;
                        break;
                    case "patientbalance":
                    case "patient balance":
                        columnMapping["PatientBalance"] = columnNumber;
                        break;
                    case "totalbalance":
                    case "total balance":
                        columnMapping["TotalBalance"] = columnNumber;
                        break;
                    case "totalpayment":
                    case "total payment":
                        columnMapping["TotalPayment"] = columnNumber;
                        break;
                    case "totalwo":
                    case "total wo":
                    case "total write-off":
                        columnMapping["TotalWO"] = columnNumber;
                        break;
                    case "totaladjustment":
                    case "total adjustment":
                        columnMapping["TotalAdjustment"] = columnNumber;
                        break;
                    case "fullypaid":
                    case "fully paid":
                        // Handle both "FullyPaid" and "Fully Paid" (with space)
                        if (headerValue.ToLower() == "fully paid")
                            columnMapping["FullyPaidStatus"] = columnNumber;
                        else
                            columnMapping["FullyPaid"] = columnNumber;
                        break;
                    case "30 bucket #":
                    case "30 bucket":
                        columnMapping["Bucket30"] = columnNumber;
                        break;
                    case "t30amount":
                    case "30 amount":
                        columnMapping["T30Amount"] = columnNumber;
                        break;
                    case "60 bucket #":
                    case "60 bucket":
                        columnMapping["Bucket60"] = columnNumber;
                        break;
                    case "t60amount":
                    case "60 amount":
                        columnMapping["T60Amount"] = columnNumber;
                        break;
                    case "adjudicatedamount":
                    case "adjudicated amount":
                        columnMapping["AdjudicatedAmount"] = columnNumber;
                        break;
                    case "adjudicatedcount":
                    case "adjudicated count":
                        columnMapping["AdjudicatedCount"] = columnNumber;
                        break;
                    case "finalstatus":
                    case "final status":
                        columnMapping["FinalStatus"] = columnNumber;
                        break;
                }
            }

            return columnMapping;
        }

        //private void ValidateColumnMapping(Dictionary<string, int> columnMapping)
        //{
        //    var requiredColumns = new[] { "VisitNumber", "AccessionNo", "PanelName", "Carrier", "ActualCPTCode", "TotalCharge" };
        //    var missingColumns = requiredColumns.Where(col => !columnMapping.ContainsKey(col)).ToList();

        //    if (missingColumns.Any())
        //    {
        //        LogMessage("ERROR", $"Missing required columns: {string.Join(", ", missingColumns)}", true);
        //        throw new Exception($"Missing required columns: {string.Join(", ", missingColumns)}");
        //    }

        //    // Log found columns
        //    LogMessage("INFO", "Column mapping found:", true);
        //    foreach (var mapping in columnMapping)
        //    {
        //        LogMessage("INFO", $"  {mapping.Key}: Column {mapping.Value}", false);
        //    }
        //}

        private void ValidateColumnMapping(Dictionary<string, int> columnMapping)
        {
            // Core required columns
            var requiredColumns = new[] {
        "VisitNumber", "AccessionNo", "PanelName", "Carrier",
        "ActualCPTCode", "TotalCharge"
    };

            var missingColumns = requiredColumns.Where(col => !columnMapping.ContainsKey(col)).ToList();

            if (missingColumns.Any())
            {
                LogMessage("ERROR", $"Missing required columns: {string.Join(", ", missingColumns)}", true);
                throw new Exception($"Missing required columns: {string.Join(", ", missingColumns)}");
            }

            // Log found columns
            LogMessage("INFO", "Column mapping found:", true);
            foreach (var mapping in columnMapping)
            {
                LogMessage("INFO", $"  {mapping.Key}: Column {mapping.Value}", false);
            }
        }

        //private ProductionRecord ProcessRow(IXLWorksheet worksheet, int rowNum, Dictionary<string, int> columnMapping)
        //{
        //    var row = worksheet.Row(rowNum);

        //    return new ProductionRecord
        //    {
        //        VisitNumber = GetCellStringValue(row.Cell(columnMapping["VisitNumber"])),
        //        AccessionNo = GetCellStringValue(row.Cell(columnMapping["AccessionNo"])),
        //        PanelName = GetCellStringValue(row.Cell(columnMapping["PanelName"])),
        //        Carrier = GetCellStringValue(row.Cell(columnMapping["Carrier"])),
        //        ActualCPTCode = GetCellStringValue(row.Cell(columnMapping["ActualCPTCode"])),
        //        TotalCharge = GetCellDecimalValue(row.Cell(columnMapping["TotalCharge"]))
        //    };
        //}


        private ProductionRecord ProcessRow(IXLWorksheet worksheet, int rowNum, Dictionary<string, int> columnMapping)
        {
            var row = worksheet.Row(rowNum);

            return new ProductionRecord
            {
                // Existing fields
                VisitNumber = GetCellStringValue(row.Cell(columnMapping["VisitNumber"])),
                AccessionNo = GetCellStringValue(row.Cell(columnMapping["AccessionNo"])),
                PanelName = GetCellStringValue(row.Cell(columnMapping["PanelName"])),
                Carrier = GetCellStringValue(row.Cell(columnMapping["Carrier"])),
                ActualCPTCode = GetCellStringValue(row.Cell(columnMapping["ActualCPTCode"])),
                TotalCharge = GetCellDecimalValue(row.Cell(columnMapping["TotalCharge"])),

                // NEW fields - string values
                FirstBillDate = GetCellStringValueSafe(columnMapping, "FirstBillDate", row),
                FinancialClass = GetCellStringValueSafe(columnMapping, "FinancialClass", row),
                BillingProvider = GetCellStringValueSafe(columnMapping, "BillingProvider", row),
                ReferringProviderName = GetCellStringValueSafe(columnMapping, "ReferringProviderName", row),
                ChartNumber = GetCellStringValueSafe(columnMapping, "ChartNumber", row),
                PatientName = GetCellStringValueSafe(columnMapping, "PatientName", row),
                PatientDOB = GetCellStringValueSafe(columnMapping, "PatientDOB", row),
                ResponsibleParty = GetCellStringValueSafe(columnMapping, "ResponsibleParty", row),
                TestType = GetCellStringValueSafe(columnMapping, "TestType", row),
                ClinicName = GetCellStringValueSafe(columnMapping, "ClinicName", row),
                Facility = GetCellStringValueSafe(columnMapping, "Facility", row),
                BeginDOS = GetCellStringValueSafe(columnMapping, "BeginDOS", row),
                Aging = GetCellStringValueSafe(columnMapping, "Aging", row),
                AgingBucket = GetCellStringValueSafe(columnMapping, "AgingBucket", row),
                AMDDOE = GetCellStringValueSafe(columnMapping, "AMDDOE", row),
                ChargeEntryDate = GetCellStringValueSafe(columnMapping, "ChargeEntryDate", row),
                DenialPostedDate = GetCellStringValueSafe(columnMapping, "DenialPostedDate", row),
                CheckDate = GetCellStringValueSafe(columnMapping, "CheckDate", row),
                PaymentPostedDate = GetCellStringValueSafe(columnMapping, "PaymentPostedDate", row),
                CheckNumber = GetCellStringValueSafe(columnMapping, "CheckNumber", row),
                BilledNotBilled = GetCellStringValueSafe(columnMapping, "BilledNotBilled", row),
                POS = GetCellStringValueSafe(columnMapping, "POS", row),
                TOS = GetCellStringValueSafe(columnMapping, "TOS", row),
                PrimaryDiagnosis = GetCellStringValueSafe(columnMapping, "PrimaryDiagnosis", row),
                ActualDenialCode = GetCellStringValueSafe(columnMapping, "ActualDenialCode", row),
                DenialCode = GetCellStringValueSafe(columnMapping, "DenialCode", row),
                DenialDescription = GetCellStringValueSafe(columnMapping, "DenialDescription", row),
                FullyPaid = GetCellStringValueSafe(columnMapping, "FullyPaid", row),
                FullyPaidStatus = GetCellStringValueSafe(columnMapping, "FullyPaidStatus", row),
                Bucket30 = GetCellStringValueSafe(columnMapping, "Bucket30", row),
                Bucket60 = GetCellStringValueSafe(columnMapping, "Bucket60", row),
                FinalStatus = GetCellStringValueSafe(columnMapping, "FinalStatus", row),

                // NEW fields - decimal values
                TotalAllowed = GetCellDecimalValueSafe(columnMapping, "TotalAllowed", row),
                CarrierPayment = GetCellDecimalValueSafe(columnMapping, "CarrierPayment", row),
                PaymentPercentage = GetCellDecimalValueSafe(columnMapping, "PaymentPercentage", row),
                CarrierWO = GetCellDecimalValueSafe(columnMapping, "CarrierWO", row),
                PatientPaidAmount = GetCellDecimalValueSafe(columnMapping, "PatientPaidAmount", row),
                PatientWO = GetCellDecimalValueSafe(columnMapping, "PatientWO", row),
                CarrierBalance = GetCellDecimalValueSafe(columnMapping, "CarrierBalance", row),
                PatientBalance = GetCellDecimalValueSafe(columnMapping, "PatientBalance", row),
                TotalBalance = GetCellDecimalValueSafe(columnMapping, "TotalBalance", row),
                TotalPayment = GetCellDecimalValueSafe(columnMapping, "TotalPayment", row),
                TotalWO = GetCellDecimalValueSafe(columnMapping, "TotalWO", row),
                TotalAdjustment = GetCellDecimalValueSafe(columnMapping, "TotalAdjustment", row),
                T30Amount = GetCellDecimalValueSafe(columnMapping, "T30Amount", row),
                T60Amount = GetCellDecimalValueSafe(columnMapping, "T60Amount", row),
                AdjudicatedAmount = GetCellDecimalValueSafe(columnMapping, "AdjudicatedAmount", row),
                AdjudicatedCount = GetCellDecimalValueSafe(columnMapping, "AdjudicatedCount", row)
            };
        }

        private string GetCellStringValueSafe(Dictionary<string, int> columnMapping, string columnName, IXLRow row)
        {
            if (columnMapping.ContainsKey(columnName))
            {
                return GetCellStringValue(row.Cell(columnMapping[columnName]));
            }
            return "";
        }

        private decimal GetCellDecimalValueSafe(Dictionary<string, int> columnMapping, string columnName, IXLRow row)
        {
            if (columnMapping.ContainsKey(columnName))
            {
                return GetCellDecimalValue(row.Cell(columnMapping[columnName]));
            }
            return 0;
        }
        private string GetCellStringValue(IXLCell cell)
        {
            if (cell == null || IsCellEmpty(cell))
                return "";

            try
            {
                return cell.Value.ToString().Trim();
            }
            catch
            {
                return "";
            }
        }

        //private decimal GetCellDecimalValue(IXLCell cell)
        //{
        //    if (cell == null || IsCellEmpty(cell))
        //        return 0;

        //    try
        //    {
        //        return cell.GetValue<decimal>();
        //    }
        //    catch
        //    {
        //        try
        //        {
        //            string text = cell.Value.ToString().Trim();
        //            if (decimal.TryParse(text, out decimal result))
        //                return result;
        //        }
        //        catch
        //        {
        //            // Return 0 if parsing fails
        //        }
        //        return 0;
        //    }
        //}

        private decimal GetCellDecimalValue(IXLCell cell)
        {
            if (cell == null || IsCellEmpty(cell))
                return 0;

            try
            {
                // Check if cell contains a percentage
                if (cell.DataType == XLDataType.Text)
                {
                    string text = cell.Value.ToString().Trim();

                    // Remove percentage sign and convert
                    if (text.EndsWith("%"))
                    {
                        text = text.TrimEnd('%');
                        if (decimal.TryParse(text, out decimal percentage))
                        {
                            // Convert percentage to decimal (e.g., 85% -> 85.0)
                            return percentage;
                        }
                    }

                    // Try regular decimal parsing
                    if (decimal.TryParse(text, out decimal result))
                        return result;
                }
                else if (cell.DataType == XLDataType.Number)
                {
                    // Handle Excel percentage format (0.85 stored as 0.85 for 85%)
                    decimal value = cell.GetValue<decimal>();

                    // If it's a small decimal (likely a percentage), convert to actual percentage
                    if (value > 0 && value <= 1)
                    {
                        // Assuming it's stored as decimal (0.85 for 85%)
                        // Convert to actual percentage value (85.0)
                        //return value * 100;

                        return value;
                    }

                    return value;
                }
            }
            catch
            {
                try
                {
                    string text = cell.Value.ToString().Trim();
                    if (decimal.TryParse(text, out decimal result))
                        return result;
                }
                catch
                {
                    // Return 0 if parsing fails
                }
                return 0;
            }

            return 0;
        }

        private bool IsCellEmpty(IXLCell cell)
        {
            if (cell == null)
                return true;

            try
            {
                // Use .IsEmpty() method with parentheses
                return cell.IsEmpty();
            }
            catch
            {
                try
                {
                    // Fallback: check the cell value
                    var cellValue = cell.Value;

                    // Check if the value type indicates an empty cell
                    if (cellValue.Type == XLDataType.Blank || cellValue.IsBlank)
                        return true;

                    // Check if the string representation is empty
                    string stringValue = cellValue.ToString();
                    return string.IsNullOrWhiteSpace(stringValue);
                }
                catch
                {
                    // If any error occurs, treat as empty
                    return true;
                }
            }
        }

        //private void WriteToCSV(List<ProductionRecord> records, string outputPath)
        //{
        //    var directory = Path.GetDirectoryName(outputPath);
        //    if (!Directory.Exists(directory))
        //    {
        //        Directory.CreateDirectory(directory);
        //        LogMessage("INFO", $"Created directory: {directory}", false);
        //    }

        //    using (var writer = new StreamWriter(outputPath, false, Encoding.UTF8))
        //    {
        //        // Write header
        //        //writer.WriteLine("VisitNumber,AccessionNo,PanelName,Carrier,ActualCPTCode,TotalCharge");
        //        writer.WriteLine("VisitNumber,AccessionNo,PanelName,Carrier,ActualCPTCode,TotalCharge,Panel1");

        //        int recordCount = 0;

        //        // Write in batches
        //        const int batchSize = 1000;
        //        for (int i = 0; i < records.Count; i += batchSize)
        //        {
        //            var batch = records.Skip(i).Take(batchSize);

        //            foreach (var record in batch)
        //            {
        //                writer.WriteLine(
        //                                  $"\"{EscapeCsvField(record.VisitNumber)}\"," +
        //                                  $"\"{EscapeCsvField(record.AccessionNo)}\"," +
        //                                  $"\"{EscapeCsvField(record.PanelName)}\"," +
        //                                  $"\"{EscapeCsvField(record.Carrier)}\"," +
        //                                  $"\"{EscapeCsvField(record.ActualCPTCode)}\"," +
        //                                  $"{record.TotalCharge}," +                     // ✅ TotalCharge FIRST
        //                                  $"\"{EscapeCsvField(record.Panel1)}\""         // ✅ Panel1 LAST
        //                                 );

        //                         recordCount++;
        //            }

        //            // Log progress
        //            if (recordCount % 5000 == 0 && recordCount > 0)
        //            {
        //                LogMessage("INFO", $"Written {recordCount} records to CSV...", false);
        //            }
        //        }

        //        LogMessage("SUCCESS", $"Total records written to CSV: {recordCount}", true);
        //    }

        //    // Force file system flush
        //    System.Threading.Thread.Sleep(500);
        //    LogMessage("INFO", "File write completed and closed", false);
        //}

        private void WriteToCSV(List<ProductionRecord> records, string outputPath)
        {
            var directory = Path.GetDirectoryName(outputPath);
            if (!Directory.Exists(directory))
            {
                Directory.CreateDirectory(directory);
                LogMessage("INFO", $"Created directory: {directory}", false);
            }

            using (var writer = new StreamWriter(outputPath, false, Encoding.UTF8))
            {
                // Write header with ALL fields
                writer.WriteLine(
                    "VisitNumber,AccessionNo,PanelName,Carrier,ActualCPTCode,TotalCharge,Panel1," +
                    "FinancialClass,BillingProvider,ReferringProviderName,ChartNumber,PatientName," +
                    "PatientDOB,ResponsibleParty,TestType,ClinicName,Facility,BeginDOS,Aging," +
                    "AgingBucket,AMDDOE,FirstBillDate,ChargeEntryDate,DenialPostedDate,CheckDate," +
                    "PaymentPostedDate,CheckNumber,BilledNotBilled,POS,TOS,PrimaryDiagnosis," +
                    "ActualDenialCode,DenialCode,DenialDescription,TotalAllowed,CarrierPayment," +
                    "PaymentPercentage,CarrierWO,PatientPaidAmount,PatientWO,CarrierBalance," +
                    "PatientBalance,TotalBalance,TotalPayment,TotalWO,TotalAdjustment,FullyPaid," +
                    "FullyPaidStatus,Bucket30,T30Amount,Bucket60,T60Amount,AdjudicatedAmount," +
                    "AdjudicatedCount,FinalStatus"
                );

                int recordCount = 0;
                const int batchSize = 1000;

                for (int i = 0; i < records.Count; i += batchSize)
                {
                    var batch = records.Skip(i).Take(batchSize);

                    foreach (var record in batch)
                    {
                        writer.WriteLine(
                            $"\"{EscapeCsvField(record.VisitNumber)}\"," +
                            $"\"{EscapeCsvField(record.AccessionNo)}\"," +
                            $"\"{EscapeCsvField(record.PanelName)}\"," +
                            $"\"{EscapeCsvField(record.Carrier)}\"," +
                            $"\"{EscapeCsvField(record.ActualCPTCode)}\"," +
                            $"{record.TotalCharge}," +
                            $"\"{EscapeCsvField(record.Panel1)}\"," +

                            // New string fields
                            $"\"{EscapeCsvField(record.FinancialClass)}\"," +
                            $"\"{EscapeCsvField(record.BillingProvider)}\"," +
                            $"\"{EscapeCsvField(record.ReferringProviderName)}\"," +
                            $"\"{EscapeCsvField(record.ChartNumber)}\"," +
                            $"\"{EscapeCsvField(record.PatientName)}\"," +
                            $"\"{EscapeCsvField(record.PatientDOB)}\"," +
                            $"\"{EscapeCsvField(record.ResponsibleParty)}\"," +
                            $"\"{EscapeCsvField(record.TestType)}\"," +
                            $"\"{EscapeCsvField(record.ClinicName)}\"," +
                            $"\"{EscapeCsvField(record.Facility)}\"," +
                            $"\"{EscapeCsvField(record.BeginDOS)}\"," +
                            $"\"{EscapeCsvField(record.Aging)}\"," +
                            $"\"{EscapeCsvField(record.AgingBucket)}\"," +
                            $"\"{EscapeCsvField(record.AMDDOE)}\"," +
                            $"\"{EscapeCsvField(record.FirstBillDate)}\"," +
                            $"\"{EscapeCsvField(record.ChargeEntryDate)}\"," +
                            $"\"{EscapeCsvField(record.DenialPostedDate)}\"," +
                            $"\"{EscapeCsvField(record.CheckDate)}\"," +
                            $"\"{EscapeCsvField(record.PaymentPostedDate)}\"," +
                            $"\"{EscapeCsvField(record.CheckNumber)}\"," +
                            $"\"{EscapeCsvField(record.BilledNotBilled)}\"," +
                            $"\"{EscapeCsvField(record.POS)}\"," +
                            $"\"{EscapeCsvField(record.TOS)}\"," +
                            $"\"{EscapeCsvField(record.PrimaryDiagnosis)}\"," +
                            $"\"{EscapeCsvField(record.ActualDenialCode)}\"," +
                            $"\"{EscapeCsvField(record.DenialCode)}\"," +
                            $"\"{EscapeCsvField(record.DenialDescription)}\"," +

                            // New decimal fields
                            $"{record.TotalAllowed}," +
                            $"{record.CarrierPayment}," +
                            $"{record.PaymentPercentage}," +
                            $"{record.CarrierWO}," +
                            $"{record.PatientPaidAmount}," +
                            $"{record.PatientWO}," +
                            $"{record.CarrierBalance}," +
                            $"{record.PatientBalance}," +
                            $"{record.TotalBalance}," +
                            $"{record.TotalPayment}," +
                            $"{record.TotalWO}," +
                            $"{record.TotalAdjustment}," +

                            // Remaining string fields
                            $"\"{EscapeCsvField(record.FullyPaid)}\"," +
                            $"\"{EscapeCsvField(record.FullyPaidStatus)}\"," +
                            $"\"{EscapeCsvField(record.Bucket30)}\"," +
                            $"{record.T30Amount}," +
                            $"\"{EscapeCsvField(record.Bucket60)}\"," +
                            $"{record.T60Amount}," +
                            $"{record.AdjudicatedAmount}," +
                            $"{record.AdjudicatedCount}," +
                            $"\"{EscapeCsvField(record.FinalStatus)}\""
                        );

                        recordCount++;
                    }

                    // Log progress every 5000 rows
                    if (recordCount % 5000 == 0 && recordCount > 0)
                    {
                        LogMessage("INFO", $"Written {recordCount} records to CSV...", false);
                    }
                }

                LogMessage("SUCCESS", $"Total records written to CSV: {recordCount}", true);
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
                                      int totalRecords, string outputFile)
        {
            try
            {
                string dateStamp = DateTime.Now.ToString("yyyyMMdd");
                string summaryFileName = $"CodingMaster_Summary_{dateStamp}_{DateTime.Now:HHmmss}.txt";
                string summaryFilePath = Path.Combine(_logFolder, summaryFileName);

                var fileInfo = new FileInfo(outputFile);
                string fileSize = File.Exists(outputFile) ? GetFileSize(fileInfo.Length) : "N/A";

                string summaryContent = $@"CODING MASTER CSV GENERATION SUMMARY REPORT
                ====================================================
                Report Generated: {DateTime.Now:yyyy-MM-dd HH:mm:ss}
                Process Start: {startTime:yyyy-MM-dd HH:mm:ss}
                Process End: {endTime:yyyy-MM-dd HH:mm:ss}
                Total Duration: {duration:hh\\:mm\\:ss}

                CONFIGURATION SETTINGS
                ----------------------
                Input Folder: {_inputFolder}
                Output Folder: {_outputFolder}
                Log Folder: {_logFolder}
                Excel File Name: {_excelFileName}

                PROCESSING RESULTS
                ------------------
                Total Records Extracted: {totalRecords}
                Output File: {Path.GetFileName(outputFile)}
                File Size: {fileSize}
                File Location: {outputFile}

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

        public void Run()
        {
            LogMessage("INFO", "Starting Coding Master CSV Generator", true);
            LogMessage("SEPARATOR", new string('=', 80), true);

            try
            {
                GenerateProductionCSV();

                GenerateMasterLineLevelCSV();
            }
            catch (Exception ex)
            {
                LogMessage("ERROR", $"Process failed: {ex.Message}", true);
                LogMessage("ERROR", ex.StackTrace, false);
                throw;
            }
        }

        private Dictionary<string, SupplementAccession> LoadSupplementForPCRAL()
        {
            var dict = new Dictionary<string, SupplementAccession>(
                StringComparer.OrdinalIgnoreCase);

            if (!IsPCRALLab())
                return dict;

            string path = _configuration["CodingMaster:suppliment"];
            if (!File.Exists(path))
                return dict;

            using var wb = new XLWorkbook(path);
            var ws = wb.Worksheet(1);
            var range = ws.RangeUsed();
            if (range == null) return dict;

            var header = range.Row(1)
                .Cells()
                .Select((c, i) => new { Name = c.GetString().Trim(), Index = i + 1 })
                .ToDictionary(x => x.Name, x => x.Index, StringComparer.OrdinalIgnoreCase);

            var list = new List<SupplementAccession>();

            for (int r = 2; r <= range.RowCount(); r++)
            {
                var acc = ws.Row(r).Cell(header["Identifier"]).GetString().Trim();
                if (string.IsNullOrEmpty(acc)) continue;

                var item = new SupplementAccession
                {
                    AccessionNo = acc,
                    SampleID = ws.Row(r).Cell(header["Sample Identifier"]).GetString().Trim(),
                    Panel = ws.Row(r).Cell(header["Sample Group"]).GetString().Trim()
                };

                list.Add(item);
                dict[acc] = item;
            }

            // 🔹 Write supplementaccession.csv
            string outCsv = Path.Combine(_outputFolder, "supplementaccession.csv");
            using var sw = new StreamWriter(outCsv);
            sw.WriteLine("AccessionNo,SampleID,Panel");
            foreach (var i in list)
                sw.WriteLine($"\"{i.AccessionNo}\",\"{i.SampleID}\",\"{i.Panel}\"");

            return dict;
        }



        private class SupplementAccession
        {
            public string AccessionNo { get; set; }
            public string SampleID { get; set; }
            public string Panel { get; set; }
        }





        public string GenerateMasterLineLevelCSV()
        {
            LogMessage("INFO", "Starting Master Line Level CSV Generation", true);

            string inputFile = ResolveInputExcelFile();
            string outputFile = Path.Combine(
                _outputFolder,
                $"MasterLineLevel_Extracted_{DateTime.Now:yyyyMMdd_HHmmss}.csv"
            );

            
            var records = ExtractMasterLineLevelFromExcel(inputFile);

            if (!IsPCRALLab())
            {
                WriteMasterLineLevelCSV(records, outputFile);
            } 
            else
            {
                WritePCRALMasterLineLevelCSV(records, outputFile);
            }

            LogMessage("SUCCESS", $"Master Line Level CSV created: {outputFile}", true);

            return outputFile;
        }
        //private List<MasterLineLevelRecord> ExtractMasterLineLevelFromExcel(string filePath)
        //{
        //    var list = new List<MasterLineLevelRecord>();


        //    var supplementMap = LoadSupplementForPCRAL();
        //    var eligiblePanels = IsPCRALLab()
        //        ? GetPanel1EligiblePanels()
        //        : new HashSet<string>();

        //    using var wb = new XLWorkbook(filePath);
        //    var ws = wb.Worksheet("Master Line Level");
        //    if (ws == null)
        //        throw new Exception("Worksheet 'Master Line Level' not found");

        //    var range = ws.RangeUsed();
        //    var header = range.Row(1).Cells()
        //        .Select((c, i) => new { Name = c.GetString().Trim(), Index = i + 1 })
        //        .ToDictionary(x => x.Name, x => x.Index, StringComparer.OrdinalIgnoreCase);

        //    for (int r = 2; r <= range.RowCount(); r++)
        //    {
        //        var row = ws.Row(r);

        //        var rec = new MasterLineLevelRecord
        //        {
        //            AccessionNo = GetCellStringValueSafe(row.Cell(header["AccessionNo"])),
        //            VisitNumber = GetCellStringValueSafe(row.Cell(header["VisitNumber"])),
        //            CPTCode = GetCellStringValueSafe(row.Cell(header["CPTCode"])),
        //            PayerName = GetCellStringValueSafe(row.Cell(header["PayerName"])),
        //            PanelName = GetCellStringValueSafe(row.Cell(header["PanelName"])),

        //            Units = GetCellStringValueSafe(row.Cell(header["Units"])),
        //            PaymentPercentage = GetCellStringValueSafe(row.Cell(header["PaymentPercentage"])),
        //            BilledAmount = GetCellStringValueSafe(row.Cell(header["BilledAmount"])),
        //            AllowedAmount = GetCellStringValueSafe(row.Cell(header["AllowedAmount"])),
        //            InsurancePayment = GetCellStringValueSafe(row.Cell(header["InsurancePayment"])),
        //            InsuranceAdjustment = GetCellStringValueSafe(row.Cell(header["InsuranceAdjustment"])),
        //            PatientPaidAmount = GetCellStringValueSafe(row.Cell(header["PatientPaidAmount"])),
        //            PatientAdjustment = GetCellStringValueSafe(row.Cell(header["PatientAdjustment"])),
        //            InsuranceBalance = GetCellStringValueSafe(row.Cell(header["InsuranceBalance"])),
        //            PatientBalance = GetCellStringValueSafe(row.Cell(header["PatientBalance"])),
        //            TotalBalance = GetCellStringValueSafe(row.Cell(header["TotalBalance"])),
        //            FinalClaimStatus = GetCellStringValueSafe(row.Cell(header["FinalClaimStatus"]))
        //        };

        //        // ================= PANEL1 LOGIC (PCRAL) =================
        //        if (IsPCRALLab()
        //            && eligiblePanels.Contains(rec.PanelName)
        //            && supplementMap.TryGetValue(rec.AccessionNo, out var sup))
        //        {
        //            rec.Panel1 = sup.Panel;
        //        }
        //        else
        //        {
        //            rec.Panel1 = rec.PanelName;
        //        }
        //        // =======================================================

        //        CalculatePerUnitValues(rec);
        //        list.Add(rec);

        //    }

        //    return list;
        //}



        private List<MasterLineLevelRecord> ExtractMasterLineLevelFromExcel(string filePath)
        {
            var list = new List<MasterLineLevelRecord>();

            var supplementMap = LoadSupplementForPCRAL();
            var eligiblePanels = IsPCRALLab()
                ? GetPanel1EligiblePanels()
                : new HashSet<string>();

            using var wb = new XLWorkbook(filePath);
            var ws = wb.Worksheet("Master Line Level");
            if (ws == null)
                throw new Exception("Worksheet 'Master Line Level' not found");

            var range = ws.RangeUsed();
            var header = range.Row(1).Cells()
                .Select((c, i) => new { Name = c.GetString().Trim(), Index = i + 1 })
                .ToDictionary(x => x.Name, x => x.Index, StringComparer.OrdinalIgnoreCase);

            // Log found headers for debugging
            LogMessage("INFO", $"Found {header.Count} columns in Master Line Level", true);

            // Create a comprehensive mapping for all expected columns
            var columnMapping = new Dictionary<string, int>();

            // Map all possible column names
            foreach (var kvp in header)
            {
                var normalizedName = kvp.Key.ToLower().Replace(" ", "").Replace("_", "").Replace("#", "");

                // Map to our property names
                switch (normalizedName)
                {
                    case "accessionno":
                    case "accession":
                        columnMapping["AccessionNo"] = kvp.Value;
                        break;
                    case "visitnumber":
                    case "visit":
                        columnMapping["VisitNumber"] = kvp.Value;
                        break;
                    case "cptcode":
                    case "cpt":
                        columnMapping["CPTCode"] = kvp.Value;
                        break;
                    case "patientname":
                    case "patient":
                        columnMapping["PatientName"] = kvp.Value;
                        break;
                    case "chartnumber":
                    case "chart":
                        columnMapping["ChartNumber"] = kvp.Value;
                        break;
                    case "patientdob":
                    case "dob":
                        columnMapping["PatientDOB"] = kvp.Value;
                        break;
                    case "payername":
                    case "payer":
                        columnMapping["PayerName"] = kvp.Value;
                        break;
                    case "payertype":
                        columnMapping["PayerType"] = kvp.Value;
                        break;
                    case "billingprovider":
                    case "provider":
                        columnMapping["BillingProvider"] = kvp.Value;
                        break;
                    case "begindos":
                    case "startdate":
                        columnMapping["BeginDOS"] = kvp.Value;
                        break;
                    case "enddos":
                    case "enddate":
                        columnMapping["EndDOS"] = kvp.Value;
                        break;
                    case "chargeentrydate":
                    case "chargedate":
                        columnMapping["ChargeEntryDate"] = kvp.Value;
                        break;
                    case "firstbilldate":
                    case "firstbill":
                        columnMapping["FirstBillDate"] = kvp.Value;
                        break;
                    case "panelname":
                    case "panel":
                        columnMapping["PanelName"] = kvp.Value;
                        break;
                    case "orderinfo":
                    case "order":
                        columnMapping["OrderInfo"] = kvp.Value;
                        break;
                    case "icd10code":
                    case "icd10":
                    case "diagnosis":
                        columnMapping["ICD10Code"] = kvp.Value;
                        break;
                    case "units":
                        columnMapping["Units"] = kvp.Value;
                        break;
                    case "checkdate":
                        columnMapping["CheckDate"] = kvp.Value;
                        break;
                  
                    case "paymentpercentage":
                        columnMapping["PaymentPercentage"] = kvp.Value;
                        //LogMessage("INFO", $"Found PaymentPercentage column in Master Line Level as '{kvp.Key}'", false);
                        break;


                    case "paymentposteddate":
                    case "paymentdate":
                        columnMapping["PaymentPostedDate"] = kvp.Value;
                        break;
                    case "denialposteddate":
                    case "denialdate":
                        columnMapping["DenialPostedDate"] = kvp.Value;
                        break;
                    case "checknumber":
                    case "check":
                        columnMapping["CheckNumber"] = kvp.Value;
                        break;
                    case "modifier":
                        columnMapping["Modifier"] = kvp.Value;
                        break;
                    case "actualdenialcode":
                    case "actualdenial":
                        columnMapping["ActualDenialCode"] = kvp.Value;
                        break;
                    case "denialcode":
                    case "denial":
                        columnMapping["DenialCode"] = kvp.Value;
                        break;
                    case "denialdescription":
                    case "denialdesc":
                        columnMapping["DenialDescription"] = kvp.Value;
                        break;
                    case "billedamount":
                    case "billed":
                        columnMapping["BilledAmount"] = kvp.Value;
                        break;
                    case "allowedamount":
                    case "allowed":
                        columnMapping["AllowedAmount"] = kvp.Value;
                        break;
                    case "insurancepayment":
                    case "insurancepay":
                        columnMapping["InsurancePayment"] = kvp.Value;
                        break;
                    case "insuranceadjustment":
                    case "insadjust":
                        columnMapping["InsuranceAdjustment"] = kvp.Value;
                        break;
                    case "patientpaidamount":
                    case "patientpaid":
                        columnMapping["PatientPaidAmount"] = kvp.Value;
                        break;
                    case "patientadjustment":
                    case "ptadjust":
                        columnMapping["PatientAdjustment"] = kvp.Value;
                        break;
                    case "insurancebalance":
                    case "insbalance":
                        columnMapping["InsuranceBalance"] = kvp.Value;
                        break;
                    case "patientbalance":
                    case "ptbalance":
                        columnMapping["PatientBalance"] = kvp.Value;
                        break;
                    case "totalbalance":
                    case "totalbal":
                        columnMapping["TotalBalance"] = kvp.Value;
                        break;
                    case "finalclaimstatus":
                    case "finalstatus":
                        columnMapping["FinalClaimStatus"] = kvp.Value;
                        break;
                    case "labname":
                    case "lab":
                        columnMapping["LabName"] = kvp.Value;
                        break;
                    case "clinicname":
                    case "clinic":
                        columnMapping["ClinicName"] = kvp.Value;
                        break;
                    case "operationsgroup":
                    case "opsgroup":
                        columnMapping["OperationsGroup"] = kvp.Value;
                        break;
                    case "testtype":
                    case "test":
                        columnMapping["TestType"] = kvp.Value;
                        break;
                    case "referringprovidername":
                    case "referring":
                        columnMapping["ReferringProviderName"] = kvp.Value;
                        break;
                    case "panelgroup":
                        columnMapping["PanelGroup"] = kvp.Value;
                        break;
                    case "lismissingrecord":
                    case "lismissing":
                        columnMapping["LISMissingRecord"] = kvp.Value;
                        break;
                    case "claimsubstatus":
                    case "substatus":
                        columnMapping["ClaimSubStatus"] = kvp.Value;
                        break;
                }
            }

            for (int r = 2; r <= range.RowCount(); r++)
            {
                var row = ws.Row(r);

                var rec = new MasterLineLevelRecord
                {
                    // Extract all fields using the mapping
                    AccessionNo = GetCellValue(columnMapping, "AccessionNo", row),
                    VisitNumber = GetCellValue(columnMapping, "VisitNumber", row),
                    CPTCode = GetCellValue(columnMapping, "CPTCode", row),
                    PatientName = GetCellValue(columnMapping, "PatientName", row),
                    ChartNumber = GetCellValue(columnMapping, "ChartNumber", row),
                    PatientDOB = GetCellValue(columnMapping, "PatientDOB", row),
                    PayerName = GetCellValue(columnMapping, "PayerName", row),
                    PayerType = GetCellValue(columnMapping, "PayerType", row),
                    BillingProvider = GetCellValue(columnMapping, "BillingProvider", row),
                    BeginDOS = GetCellValue(columnMapping, "BeginDOS", row),
                    EndDOS = GetCellValue(columnMapping, "EndDOS", row),
                    ChargeEntryDate = GetCellValue(columnMapping, "ChargeEntryDate", row),
                    FirstBillDate = GetCellValue(columnMapping, "FirstBillDate", row),
                    PanelName = GetCellValue(columnMapping, "PanelName", row),
                    OrderInfo = GetCellValue(columnMapping, "OrderInfo", row),
                    ICD10Code = GetCellValue(columnMapping, "ICD10Code", row),
                    Units = GetCellValue(columnMapping, "Units", row),
                    CheckDate = GetCellValue(columnMapping, "CheckDate", row),
                    PaymentPercentage = GetCellValue(columnMapping, "PaymentPercentage", row),
                    PaymentPostedDate = GetCellValue(columnMapping, "PaymentPostedDate", row),
                    DenialPostedDate = GetCellValue(columnMapping, "DenialPostedDate", row),
                    CheckNumber = GetCellValue(columnMapping, "CheckNumber", row),
                    Modifier = GetCellValue(columnMapping, "Modifier", row),
                    ActualDenialCode = GetCellValue(columnMapping, "ActualDenialCode", row),
                    DenialCode = GetCellValue(columnMapping, "DenialCode", row),
                    DenialDescription = GetCellValue(columnMapping, "DenialDescription", row),
                    BilledAmount = GetCellValue(columnMapping, "BilledAmount", row),
                    AllowedAmount = GetCellValue(columnMapping, "AllowedAmount", row),
                    InsurancePayment = GetCellValue(columnMapping, "InsurancePayment", row),
                    InsuranceAdjustment = GetCellValue(columnMapping, "InsuranceAdjustment", row),
                    PatientPaidAmount = GetCellValue(columnMapping, "PatientPaidAmount", row),
                    PatientAdjustment = GetCellValue(columnMapping, "PatientAdjustment", row),
                    InsuranceBalance = GetCellValue(columnMapping, "InsuranceBalance", row),
                    PatientBalance = GetCellValue(columnMapping, "PatientBalance", row),
                    TotalBalance = GetCellValue(columnMapping, "TotalBalance", row),
                    FinalClaimStatus = GetCellValue(columnMapping, "FinalClaimStatus", row),
                    LabName = GetCellValue(columnMapping, "LabName", row),
                    ClinicName = GetCellValue(columnMapping, "ClinicName", row),
                    OperationsGroup = GetCellValue(columnMapping, "OperationsGroup", row),
                    TestType = GetCellValue(columnMapping, "TestType", row),
                    ReferringProviderName = GetCellValue(columnMapping, "ReferringProviderName", row),
                    PanelGroup = GetCellValue(columnMapping, "PanelGroup", row),
                    LISMissingRecord = GetCellValue(columnMapping, "LISMissingRecord", row),
                    ClaimSubStatus = GetCellValue(columnMapping, "ClaimSubStatus", row)
                };

                // ================= PANEL1 LOGIC (PCRAL) =================
                if (IsPCRALLab()
                    && eligiblePanels.Contains(rec.PanelName)
                    && supplementMap.TryGetValue(rec.AccessionNo, out var sup))
                {
                    rec.PanelName = sup.Panel;
                    rec.Panel1 = sup.Panel;
                }
                else
                {
                    rec.Panel1 = rec.PanelName;
                }
                // =======================================================

                CalculatePerUnitValues(rec);
                list.Add(rec);
            }

            LogMessage("SUCCESS", $"Extracted {list.Count} records from Master Line Level", true);
            return list;
        }

        private string GetCellValue(Dictionary<string, int> mapping, string fieldName, IXLRow row)
        {
            if (mapping.ContainsKey(fieldName))
            {
                return GetCellStringValueSafe(row.Cell(mapping[fieldName]));
            }
            return "";
        }


        //    private void WriteMasterLineLevelCSV(
        //List<MasterLineLevelRecord> records,
        //string outputPath)
        //    {
        //        using var sw = new StreamWriter(outputPath, false, Encoding.UTF8);

        //        sw.WriteLine(
        //            "AccessionNo,VisitNumber,CPTCode,PayerName,PanelName,Units,PaymentPercentage," +
        //            "BilledAmount,AllowedAmount,InsurancePayment,InsuranceAdjustment,PatientPaidAmount," +
        //            "PatientAdjustment,InsuranceBalance,PatientBalance,TotalBalance,FinalClaimStatus," +
        //            "BilledAmountPerUnit,AllowedAmountPerUnit,InsurancePaymentPerUnit," +
        //            "PatientPaymentPerUnit,PatientBalancePerUnit"
        //        );

        //        foreach (var r in records)
        //        {

        //            bool isAdjustedOrDenied = !string.IsNullOrWhiteSpace(r.FinalClaimStatus) &&
        //                (r.FinalClaimStatus.Equals("Adjusted", StringComparison.OrdinalIgnoreCase) ||
        //                 r.FinalClaimStatus.Equals("Denied", StringComparison.OrdinalIgnoreCase));


        //            string allowedAmountToWrite = isAdjustedOrDenied ? "0.00" : r.AllowedAmount;

        //            string allowedPerUnitToWrite = isAdjustedOrDenied ? "0.00" : r.AllowedAmountPerUnit;




        //            sw.WriteLine(
        //                     $"\"{r.AccessionNo}\",\"{r.VisitNumber}\",\"{r.CPTCode}\",\"{r.PayerName}\"," +
        //                     $"\"{r.PanelName}\",\"{r.Units}\",\"{r.PaymentPercentage}\"," +
        //                     $"\"{r.BilledAmount}\",\"{allowedAmountToWrite}\",\"{r.InsurancePayment}\"," +
        //                     $"\"{r.InsuranceAdjustment}\",\"{r.PatientPaidAmount}\",\"{r.PatientAdjustment}\"," +
        //                     $"\"{r.InsuranceBalance}\",\"{r.PatientBalance}\",\"{r.TotalBalance}\"," +
        //                     $"\"{r.FinalClaimStatus}\"," +
        //                     //$"\"{r.BilledAmountPerUnit}\",\"{r.AllowedAmountPerUnit}\"," +
        //                     $"\"{r.BilledAmountPerUnit}\",\"{allowedPerUnitToWrite}\","+
        //                     $"\"{r.InsurancePaymentPerUnit}\",\"{r.PatientPaymentPerUnit}\"," +
        //                     $"\"{r.PatientBalancePerUnit}\""
        //                 );

        //        }
        //    }

        //    private void WriteMasterLineLevelCSV(
        //List<MasterLineLevelRecord> records,
        //string outputPath)
        //    {
        //        using var sw = new StreamWriter(outputPath, false, Encoding.UTF8);

        //        // Write header with ALL fields
        //        sw.WriteLine(
        //            "AccessionNo,VisitNumber,CPTCode,PatientName,ChartNumber,PatientDOB," +
        //            "PayerName,PayerType,BillingProvider,BeginDOS,EndDOS,ChargeEntryDate," +
        //            "FirstBillDate,PanelName,OrderInfo,ICD10Code,Units,CheckDate,PaymentPostedDate," +
        //            "DenialPostedDate,CheckNumber,Modifier,ActualDenialCode,DenialCode,DenialDescription," +
        //            "BilledAmount,AllowedAmount,InsurancePayment,InsuranceAdjustment,PatientPaidAmount," +
        //            "PatientAdjustment,InsuranceBalance,PatientBalance,TotalBalance,FinalClaimStatus," +
        //            "LabName,ClinicName,OperationsGroup,TestType,ReferringProviderName,PanelGroup," +
        //            "LISMissingRecord,ClaimSubStatus," +
        //            "BilledAmountPerUnit,AllowedAmountPerUnit,InsurancePaymentPerUnit," +
        //            "PatientPaymentPerUnit,PatientBalancePerUnit"
        //        );

        //        foreach (var r in records)
        //        {
        //            bool isAdjustedOrDenied = !string.IsNullOrWhiteSpace(r.FinalClaimStatus) &&
        //                (r.FinalClaimStatus.Equals("Adjusted", StringComparison.OrdinalIgnoreCase) ||
        //                 r.FinalClaimStatus.Equals("Denied", StringComparison.OrdinalIgnoreCase));

        //            string allowedAmountToWrite = isAdjustedOrDenied ? "0.00" : r.AllowedAmount;
        //            string allowedPerUnitToWrite = isAdjustedOrDenied ? "0.00" : r.AllowedAmountPerUnit;

        //            sw.WriteLine(
        //                $"\"{EscapeCsvField(r.AccessionNo)}\"," +
        //                $"\"{EscapeCsvField(r.VisitNumber)}\"," +
        //                $"\"{EscapeCsvField(r.CPTCode)}\"," +
        //                $"\"{EscapeCsvField(r.PatientName)}\"," +
        //                $"\"{EscapeCsvField(r.ChartNumber)}\"," +
        //                $"\"{EscapeCsvField(r.PatientDOB)}\"," +
        //                $"\"{EscapeCsvField(r.PayerName)}\"," +
        //                $"\"{EscapeCsvField(r.PayerType)}\"," +
        //                $"\"{EscapeCsvField(r.BillingProvider)}\"," +
        //                $"\"{EscapeCsvField(r.BeginDOS)}\"," +
        //                $"\"{EscapeCsvField(r.EndDOS)}\"," +
        //                $"\"{EscapeCsvField(r.ChargeEntryDate)}\"," +
        //                $"\"{EscapeCsvField(r.FirstBillDate)}\"," +
        //                $"\"{EscapeCsvField(r.PanelName)}\"," +
        //                $"\"{EscapeCsvField(r.OrderInfo)}\"," +
        //                $"\"{EscapeCsvField(r.ICD10Code)}\"," +
        //                $"\"{EscapeCsvField(r.Units)}\"," +
        //                $"\"{EscapeCsvField(r.CheckDate)}\"," +
        //                $"\"{EscapeCsvField(r.PaymentPostedDate)}\"," +
        //                $"\"{EscapeCsvField(r.DenialPostedDate)}\"," +
        //                $"\"{EscapeCsvField(r.CheckNumber)}\"," +
        //                $"\"{EscapeCsvField(r.Modifier)}\"," +
        //                $"\"{EscapeCsvField(r.ActualDenialCode)}\"," +
        //                $"\"{EscapeCsvField(r.DenialCode)}\"," +
        //                $"\"{EscapeCsvField(r.DenialDescription)}\"," +
        //                $"\"{EscapeCsvField(r.BilledAmount)}\"," +
        //                $"\"{allowedAmountToWrite}\"," +
        //                $"\"{EscapeCsvField(r.InsurancePayment)}\"," +
        //                $"\"{EscapeCsvField(r.InsuranceAdjustment)}\"," +
        //                $"\"{EscapeCsvField(r.PatientPaidAmount)}\"," +
        //                $"\"{EscapeCsvField(r.PatientAdjustment)}\"," +
        //                $"\"{EscapeCsvField(r.InsuranceBalance)}\"," +
        //                $"\"{EscapeCsvField(r.PatientBalance)}\"," +
        //                $"\"{EscapeCsvField(r.TotalBalance)}\"," +
        //                $"\"{EscapeCsvField(r.FinalClaimStatus)}\"," +
        //                $"\"{EscapeCsvField(r.LabName)}\"," +
        //                $"\"{EscapeCsvField(r.ClinicName)}\"," +
        //                $"\"{EscapeCsvField(r.OperationsGroup)}\"," +
        //                $"\"{EscapeCsvField(r.TestType)}\"," +
        //                $"\"{EscapeCsvField(r.ReferringProviderName)}\"," +
        //                $"\"{EscapeCsvField(r.PanelGroup)}\"," +
        //                $"\"{EscapeCsvField(r.LISMissingRecord)}\"," +
        //                $"\"{EscapeCsvField(r.ClaimSubStatus)}\"," +
        //                $"\"{EscapeCsvField(r.BilledAmountPerUnit)}\"," +
        //                $"\"{allowedPerUnitToWrite}\"," +
        //                $"\"{EscapeCsvField(r.InsurancePaymentPerUnit)}\"," +
        //                $"\"{EscapeCsvField(r.PatientPaymentPerUnit)}\"," +
        //                $"\"{EscapeCsvField(r.PatientBalancePerUnit)}\""
        //            );
        //        }
        //    }


        private void WriteMasterLineLevelCSV(
    List<MasterLineLevelRecord> records,
    string outputPath)
        {
            using var sw = new StreamWriter(outputPath, false, Encoding.UTF8);

            // Write header with ALL fields - ADD PaymentPercentage
            sw.WriteLine(
                "AccessionNo,VisitNumber,CPTCode,PatientName,ChartNumber,PatientDOB," +
                "PayerName,PayerType,BillingProvider,BeginDOS,EndDOS,ChargeEntryDate," +
                "FirstBillDate,PanelName,OrderInfo,ICD10Code,Units,PaymentPercentage,CheckDate,PaymentPostedDate," +  // Added PaymentPercentage
                "DenialPostedDate,CheckNumber,Modifier,ActualDenialCode,DenialCode,DenialDescription," +
                "BilledAmount,AllowedAmount,InsurancePayment,InsuranceAdjustment,PatientPaidAmount," +
                "PatientAdjustment,InsuranceBalance,PatientBalance,TotalBalance,FinalClaimStatus," +
                "LabName,ClinicName,OperationsGroup,TestType,ReferringProviderName,PanelGroup," +
                "LISMissingRecord,ClaimSubStatus," +
                "BilledAmountPerUnit,AllowedAmountPerUnit,InsurancePaymentPerUnit," +
                "PatientPaymentPerUnit,PatientBalancePerUnit"
            );

            foreach (var r in records)
            {
                bool isAdjustedOrDenied = !string.IsNullOrWhiteSpace(r.FinalClaimStatus) &&
                    (r.FinalClaimStatus.Equals("Adjusted", StringComparison.OrdinalIgnoreCase) ||
                     r.FinalClaimStatus.Equals("Denied", StringComparison.OrdinalIgnoreCase));

                string allowedAmountToWrite = isAdjustedOrDenied ? "0.00" : r.AllowedAmount;
                string allowedPerUnitToWrite = isAdjustedOrDenied ? "0.00" : r.AllowedAmountPerUnit;

                sw.WriteLine(
                    $"\"{EscapeCsvField(r.AccessionNo)}\"," +
                    $"\"{EscapeCsvField(r.VisitNumber)}\"," +
                    $"\"{EscapeCsvField(r.CPTCode)}\"," +
                    $"\"{EscapeCsvField(r.PatientName)}\"," +
                    $"\"{EscapeCsvField(r.ChartNumber)}\"," +
                    $"\"{EscapeCsvField(r.PatientDOB)}\"," +
                    $"\"{EscapeCsvField(r.PayerName)}\"," +
                    $"\"{EscapeCsvField(r.PayerType)}\"," +
                    $"\"{EscapeCsvField(r.BillingProvider)}\"," +
                    $"\"{EscapeCsvField(r.BeginDOS)}\"," +
                    $"\"{EscapeCsvField(r.EndDOS)}\"," +
                    $"\"{EscapeCsvField(r.ChargeEntryDate)}\"," +
                    $"\"{EscapeCsvField(r.FirstBillDate)}\"," +
                    $"\"{EscapeCsvField(r.PanelName)}\"," +
                    $"\"{EscapeCsvField(r.OrderInfo)}\"," +
                    $"\"{EscapeCsvField(r.ICD10Code)}\"," +
                    $"\"{EscapeCsvField(r.Units)}\"," +
                    $"\"{EscapeCsvField(r.PaymentPercentage)}\"," +  // Added PaymentPercentage
                    $"\"{EscapeCsvField(r.CheckDate)}\"," +
                    $"\"{EscapeCsvField(r.PaymentPostedDate)}\"," +
                    $"\"{EscapeCsvField(r.DenialPostedDate)}\"," +
                    $"\"{EscapeCsvField(r.CheckNumber)}\"," +
                    $"\"{EscapeCsvField(r.Modifier)}\"," +
                    $"\"{EscapeCsvField(r.ActualDenialCode)}\"," +
                    $"\"{EscapeCsvField(r.DenialCode)}\"," +
                    $"\"{EscapeCsvField(r.DenialDescription)}\"," +
                    $"\"{EscapeCsvField(r.BilledAmount)}\"," +
                    $"\"{allowedAmountToWrite}\"," +
                    $"\"{EscapeCsvField(r.InsurancePayment)}\"," +
                    $"\"{EscapeCsvField(r.InsuranceAdjustment)}\"," +
                    $"\"{EscapeCsvField(r.PatientPaidAmount)}\"," +
                    $"\"{EscapeCsvField(r.PatientAdjustment)}\"," +
                    $"\"{EscapeCsvField(r.InsuranceBalance)}\"," +
                    $"\"{EscapeCsvField(r.PatientBalance)}\"," +
                    $"\"{EscapeCsvField(r.TotalBalance)}\"," +
                    $"\"{EscapeCsvField(r.FinalClaimStatus)}\"," +
                    $"\"{EscapeCsvField(r.LabName)}\"," +
                    $"\"{EscapeCsvField(r.ClinicName)}\"," +
                    $"\"{EscapeCsvField(r.OperationsGroup)}\"," +
                    $"\"{EscapeCsvField(r.TestType)}\"," +
                    $"\"{EscapeCsvField(r.ReferringProviderName)}\"," +
                    $"\"{EscapeCsvField(r.PanelGroup)}\"," +
                    $"\"{EscapeCsvField(r.LISMissingRecord)}\"," +
                    $"\"{EscapeCsvField(r.ClaimSubStatus)}\"," +
                    $"\"{EscapeCsvField(r.BilledAmountPerUnit)}\"," +
                    $"\"{allowedPerUnitToWrite}\"," +
                    $"\"{EscapeCsvField(r.InsurancePaymentPerUnit)}\"," +
                    $"\"{EscapeCsvField(r.PatientPaymentPerUnit)}\"," +
                    $"\"{EscapeCsvField(r.PatientBalancePerUnit)}\""
                );
            }
        }
        private void WritePCRALMasterLineLevelCSV(List<MasterLineLevelRecord> records, string outputPath)
        {
            using var sw = new StreamWriter(outputPath, false, Encoding.UTF8);

            // Same header but with Panel1 added - ADD PaymentPercentage
            sw.WriteLine(
                "AccessionNo,VisitNumber,CPTCode,PatientName,ChartNumber,PatientDOB," +
                "PayerName,PayerType,BillingProvider,BeginDOS,EndDOS,ChargeEntryDate," +
                "FirstBillDate,PanelName,Panel1,OrderInfo,ICD10Code,Units,PaymentPercentage,CheckDate,PaymentPostedDate," +  // Added PaymentPercentage
                "DenialPostedDate,CheckNumber,Modifier,ActualDenialCode,DenialCode,DenialDescription," +
                "BilledAmount,AllowedAmount,InsurancePayment,InsuranceAdjustment,PatientPaidAmount," +
                "PatientAdjustment,InsuranceBalance,PatientBalance,TotalBalance,FinalClaimStatus," +
                "LabName,ClinicName,OperationsGroup,TestType,ReferringProviderName,PanelGroup," +
                "LISMissingRecord,ClaimSubStatus," +
                "BilledAmountPerUnit,AllowedAmountPerUnit,InsurancePaymentPerUnit," +
                "PatientPaymentPerUnit,PatientBalancePerUnit"
            );

            foreach (var r in records)
            {
                bool isAdjustedOrDenied = !string.IsNullOrWhiteSpace(r.FinalClaimStatus) &&
                    (r.FinalClaimStatus.Equals("Adjusted", StringComparison.OrdinalIgnoreCase) ||
                     r.FinalClaimStatus.Equals("Denied", StringComparison.OrdinalIgnoreCase));

                string allowedAmountToWrite = isAdjustedOrDenied ? "0.00" : r.AllowedAmount;
                string allowedPerUnitToWrite = isAdjustedOrDenied ? "0.00" : r.AllowedAmountPerUnit;

                sw.WriteLine(
                    $"\"{EscapeCsvField(r.AccessionNo)}\"," +
                    $"\"{EscapeCsvField(r.VisitNumber)}\"," +
                    $"\"{EscapeCsvField(r.CPTCode)}\"," +
                    $"\"{EscapeCsvField(r.PatientName)}\"," +
                    $"\"{EscapeCsvField(r.ChartNumber)}\"," +
                    $"\"{EscapeCsvField(r.PatientDOB)}\"," +
                    $"\"{EscapeCsvField(r.PayerName)}\"," +
                    $"\"{EscapeCsvField(r.PayerType)}\"," +
                    $"\"{EscapeCsvField(r.BillingProvider)}\"," +
                    $"\"{EscapeCsvField(r.BeginDOS)}\"," +
                    $"\"{EscapeCsvField(r.EndDOS)}\"," +
                    $"\"{EscapeCsvField(r.ChargeEntryDate)}\"," +
                    $"\"{EscapeCsvField(r.FirstBillDate)}\"," +
                    $"\"{EscapeCsvField(r.PanelName)}\"," +
                    $"\"{EscapeCsvField(r.Panel1)}\"," +  // Panel1 added here
                    $"\"{EscapeCsvField(r.OrderInfo)}\"," +
                    $"\"{EscapeCsvField(r.ICD10Code)}\"," +
                    $"\"{EscapeCsvField(r.Units)}\"," +
                    $"\"{EscapeCsvField(r.PaymentPercentage)}\"," +  // Added PaymentPercentage
                    $"\"{EscapeCsvField(r.CheckDate)}\"," +
                    $"\"{EscapeCsvField(r.PaymentPostedDate)}\"," +
                    $"\"{EscapeCsvField(r.DenialPostedDate)}\"," +
                    $"\"{EscapeCsvField(r.CheckNumber)}\"," +
                    $"\"{EscapeCsvField(r.Modifier)}\"," +
                    $"\"{EscapeCsvField(r.ActualDenialCode)}\"," +
                    $"\"{EscapeCsvField(r.DenialCode)}\"," +
                    $"\"{EscapeCsvField(r.DenialDescription)}\"," +
                    $"\"{EscapeCsvField(r.BilledAmount)}\"," +
                    $"\"{allowedAmountToWrite}\"," +
                    $"\"{EscapeCsvField(r.InsurancePayment)}\"," +
                    $"\"{EscapeCsvField(r.InsuranceAdjustment)}\"," +
                    $"\"{EscapeCsvField(r.PatientPaidAmount)}\"," +
                    $"\"{EscapeCsvField(r.PatientAdjustment)}\"," +
                    $"\"{EscapeCsvField(r.InsuranceBalance)}\"," +
                    $"\"{EscapeCsvField(r.PatientBalance)}\"," +
                    $"\"{EscapeCsvField(r.TotalBalance)}\"," +
                    $"\"{EscapeCsvField(r.FinalClaimStatus)}\"," +
                    $"\"{EscapeCsvField(r.LabName)}\"," +
                    $"\"{EscapeCsvField(r.ClinicName)}\"," +
                    $"\"{EscapeCsvField(r.OperationsGroup)}\"," +
                    $"\"{EscapeCsvField(r.TestType)}\"," +
                    $"\"{EscapeCsvField(r.ReferringProviderName)}\"," +
                    $"\"{EscapeCsvField(r.PanelGroup)}\"," +
                    $"\"{EscapeCsvField(r.LISMissingRecord)}\"," +
                    $"\"{EscapeCsvField(r.ClaimSubStatus)}\"," +
                    $"\"{EscapeCsvField(r.BilledAmountPerUnit)}\"," +
                    $"\"{allowedPerUnitToWrite}\"," +
                    $"\"{EscapeCsvField(r.InsurancePaymentPerUnit)}\"," +
                    $"\"{EscapeCsvField(r.PatientPaymentPerUnit)}\"," +
                    $"\"{EscapeCsvField(r.PatientBalancePerUnit)}\""
                );
            }
        }
        //private void WritePCRALMasterLineLevelCSV(List<MasterLineLevelRecord> records, string outputPath)
        //{
        //    using var sw = new StreamWriter(outputPath, false, Encoding.UTF8);

        //    // Same header but with Panel1 added
        //    sw.WriteLine(
        //        "AccessionNo,VisitNumber,CPTCode,PatientName,ChartNumber,PatientDOB," +
        //        "PayerName,PayerType,BillingProvider,BeginDOS,EndDOS,ChargeEntryDate," +
        //        "FirstBillDate,PanelName,Panel1,OrderInfo,ICD10Code,Units,CheckDate,PaymentPostedDate," +
        //        "DenialPostedDate,CheckNumber,Modifier,ActualDenialCode,DenialCode,DenialDescription," +
        //        "BilledAmount,AllowedAmount,InsurancePayment,InsuranceAdjustment,PatientPaidAmount," +
        //        "PatientAdjustment,InsuranceBalance,PatientBalance,TotalBalance,FinalClaimStatus," +
        //        "LabName,ClinicName,OperationsGroup,TestType,ReferringProviderName,PanelGroup," +
        //        "LISMissingRecord,ClaimSubStatus," +
        //        "BilledAmountPerUnit,AllowedAmountPerUnit,InsurancePaymentPerUnit," +
        //        "PatientPaymentPerUnit,PatientBalancePerUnit"
        //    );

        //    foreach (var r in records)
        //    {
        //        bool isAdjustedOrDenied = !string.IsNullOrWhiteSpace(r.FinalClaimStatus) &&
        //            (r.FinalClaimStatus.Equals("Adjusted", StringComparison.OrdinalIgnoreCase) ||
        //             r.FinalClaimStatus.Equals("Denied", StringComparison.OrdinalIgnoreCase));

        //        string allowedAmountToWrite = isAdjustedOrDenied ? "0.00" : r.AllowedAmount;
        //        string allowedPerUnitToWrite = isAdjustedOrDenied ? "0.00" : r.AllowedAmountPerUnit;

        //        sw.WriteLine(
        //            $"\"{EscapeCsvField(r.AccessionNo)}\"," +
        //            $"\"{EscapeCsvField(r.VisitNumber)}\"," +
        //            $"\"{EscapeCsvField(r.CPTCode)}\"," +
        //            $"\"{EscapeCsvField(r.PatientName)}\"," +
        //            $"\"{EscapeCsvField(r.ChartNumber)}\"," +
        //            $"\"{EscapeCsvField(r.PatientDOB)}\"," +
        //            $"\"{EscapeCsvField(r.PayerName)}\"," +
        //            $"\"{EscapeCsvField(r.PayerType)}\"," +
        //            $"\"{EscapeCsvField(r.BillingProvider)}\"," +
        //            $"\"{EscapeCsvField(r.BeginDOS)}\"," +
        //            $"\"{EscapeCsvField(r.EndDOS)}\"," +
        //            $"\"{EscapeCsvField(r.ChargeEntryDate)}\"," +
        //            $"\"{EscapeCsvField(r.FirstBillDate)}\"," +
        //            $"\"{EscapeCsvField(r.PanelName)}\"," +
        //            $"\"{EscapeCsvField(r.Panel1)}\"," +  // Panel1 added here
        //            $"\"{EscapeCsvField(r.OrderInfo)}\"," +
        //            $"\"{EscapeCsvField(r.ICD10Code)}\"," +
        //            $"\"{EscapeCsvField(r.Units)}\"," +
        //            $"\"{EscapeCsvField(r.CheckDate)}\"," +
        //            $"\"{EscapeCsvField(r.PaymentPostedDate)}\"," +
        //            $"\"{EscapeCsvField(r.DenialPostedDate)}\"," +
        //            $"\"{EscapeCsvField(r.CheckNumber)}\"," +
        //            $"\"{EscapeCsvField(r.Modifier)}\"," +
        //            $"\"{EscapeCsvField(r.ActualDenialCode)}\"," +
        //            $"\"{EscapeCsvField(r.DenialCode)}\"," +
        //            $"\"{EscapeCsvField(r.DenialDescription)}\"," +
        //            $"\"{EscapeCsvField(r.BilledAmount)}\"," +
        //            $"\"{allowedAmountToWrite}\"," +
        //            $"\"{EscapeCsvField(r.InsurancePayment)}\"," +
        //            $"\"{EscapeCsvField(r.InsuranceAdjustment)}\"," +
        //            $"\"{EscapeCsvField(r.PatientPaidAmount)}\"," +
        //            $"\"{EscapeCsvField(r.PatientAdjustment)}\"," +
        //            $"\"{EscapeCsvField(r.InsuranceBalance)}\"," +
        //            $"\"{EscapeCsvField(r.PatientBalance)}\"," +
        //            $"\"{EscapeCsvField(r.TotalBalance)}\"," +
        //            $"\"{EscapeCsvField(r.FinalClaimStatus)}\"," +
        //            $"\"{EscapeCsvField(r.LabName)}\"," +
        //            $"\"{EscapeCsvField(r.ClinicName)}\"," +
        //            $"\"{EscapeCsvField(r.OperationsGroup)}\"," +
        //            $"\"{EscapeCsvField(r.TestType)}\"," +
        //            $"\"{EscapeCsvField(r.ReferringProviderName)}\"," +
        //            $"\"{EscapeCsvField(r.PanelGroup)}\"," +
        //            $"\"{EscapeCsvField(r.LISMissingRecord)}\"," +
        //            $"\"{EscapeCsvField(r.ClaimSubStatus)}\"," +
        //            $"\"{EscapeCsvField(r.BilledAmountPerUnit)}\"," +
        //            $"\"{allowedPerUnitToWrite}\"," +
        //            $"\"{EscapeCsvField(r.InsurancePaymentPerUnit)}\"," +
        //            $"\"{EscapeCsvField(r.PatientPaymentPerUnit)}\"," +
        //            $"\"{EscapeCsvField(r.PatientBalancePerUnit)}\""
        //        );
        //    }
        //}

        //private void WritePCRALMasterLineLevelCSV(List<MasterLineLevelRecord> records,string outputPath)
        //{
        //    using var sw = new StreamWriter(outputPath, false, Encoding.UTF8);

        //    sw.WriteLine(
        //        "AccessionNo,VisitNumber,CPTCode,PayerName,PanelName,Panel1,Units,PaymentPercentage," +
        //        "BilledAmount,AllowedAmount,InsurancePayment,InsuranceAdjustment,PatientPaidAmount," +
        //        "PatientAdjustment,InsuranceBalance,PatientBalance,TotalBalance,FinalClaimStatus," +
        //        "BilledAmountPerUnit,AllowedAmountPerUnit,InsurancePaymentPerUnit," +
        //        "PatientPaymentPerUnit,PatientBalancePerUnit"
        //    );

        //    foreach (var r in records)
        //    {
        //        bool isAdjustedOrDenied = !string.IsNullOrWhiteSpace(r.FinalClaimStatus) &&
        //            (r.FinalClaimStatus.Equals("Adjusted", StringComparison.OrdinalIgnoreCase) ||
        //             r.FinalClaimStatus.Equals("Denied", StringComparison.OrdinalIgnoreCase));


        //        string allowedAmountToWrite = isAdjustedOrDenied ? "0.00" : r.AllowedAmount;

        //        string allowedPerUnitToWrite = isAdjustedOrDenied ? "0.00" : r.AllowedAmountPerUnit;
        //        sw.WriteLine(
        //                 $"\"{r.AccessionNo}\",\"{r.VisitNumber}\",\"{r.CPTCode}\",\"{r.PayerName}\"," +
        //                 $"\"{r.PanelName}\",\"{r.Panel1}\",\"{r.Units}\",\"{r.PaymentPercentage}\"," +
        //                 $"\"{r.BilledAmount}\",\"{allowedAmountToWrite}\",\"{r.InsurancePayment}\"," +
        //                 $"\"{r.InsuranceAdjustment}\",\"{r.PatientPaidAmount}\",\"{r.PatientAdjustment}\"," +
        //                 $"\"{r.InsuranceBalance}\",\"{r.PatientBalance}\",\"{r.TotalBalance}\"," +
        //                 $"\"{r.FinalClaimStatus}\"," +
        //                 // $"\"{r.BilledAmountPerUnit}\",\"{r.AllowedAmountPerUnit}\"," +
        //                 $"\"{r.BilledAmountPerUnit}\",\"{allowedPerUnitToWrite}\","+
        //                $"\"{r.InsurancePaymentPerUnit}\",\"{r.PatientPaymentPerUnit}\"," +
        //                 $"\"{r.PatientBalancePerUnit}\""
        //             );

        //    }
        //}




        //private void CalculatePerUnitValues(MasterLineLevelRecord r)
        //{
        //    decimal? units = ToNullableDecimal(r.Units);
        //    if (units == null || units <= 0)
        //        return;

        //    decimal? billed = ToNullableDecimal(r.BilledAmount);
        //    decimal? allowed = ToNullableDecimal(r.AllowedAmount);
        //    decimal? insurancePay = ToNullableDecimal(r.InsurancePayment);
        //    decimal? patientPay = ToNullableDecimal(r.PatientPaidAmount);
        //    decimal? patientBal = ToNullableDecimal(r.PatientBalance);

        //    if (billed.HasValue)
        //        r.BilledAmountPerUnit = (billed.Value / units.Value).ToString("0.00");

        //            /* 🔥 BUSINESS RULE:
        //      If FinalClaimStatus = Adjusted or Denied
        //      → AllowedAmountPerUnit MUST be 0
        //   */
        //    if (!string.IsNullOrWhiteSpace(r.FinalClaimStatus) &&
        //        (r.FinalClaimStatus.Equals("Adjusted", StringComparison.OrdinalIgnoreCase) ||
        //         r.FinalClaimStatus.Equals("Denied", StringComparison.OrdinalIgnoreCase)))
        //    {
        //        r.AllowedAmountPerUnit = "0.00";
        //    }


        //    if (allowed.HasValue)
        //        r.AllowedAmountPerUnit = (allowed.Value / units.Value).ToString("0.00");

        //    if (insurancePay.HasValue)
        //        r.InsurancePaymentPerUnit = (insurancePay.Value / units.Value).ToString("0.00");

        //    if (patientPay.HasValue)
        //        r.PatientPaymentPerUnit = (patientPay.Value / units.Value).ToString("0.00");

        //    if (patientBal.HasValue)
        //        r.PatientBalancePerUnit = (patientBal.Value / units.Value).ToString("0.00");
        //}

        //private void CalculatePerUnitValues(MasterLineLevelRecord r)
        //{
        //    decimal? units = ToNullableDecimal(r.Units);
        //    if (units == null || units <= 0)
        //        return;

        //    decimal? billed = ToNullableDecimal(r.BilledAmount);
        //    decimal? allowed = null; // Initialize as null

        //    // 🔥 BUSINESS RULE: Adjusted/Denied → AllowedAmountPerUnit = 0
        //    bool isDeniedOrAdjusted =
        //        !string.IsNullOrWhiteSpace(r.FinalClaimStatus) &&
        //        (r.FinalClaimStatus.Equals("Adjusted", StringComparison.OrdinalIgnoreCase) ||
        //         r.FinalClaimStatus.Equals("Denied", StringComparison.OrdinalIgnoreCase));

        //    if (isDeniedOrAdjusted)
        //    {
        //        // Force to 0 regardless of what's in AllowedAmount
        //        //r.AllowedAmountPerUnit = "0.00";
        //        allowed = ToNullableDecimal(r.AllowedAmount);
        //        if (allowed.HasValue)
        //            r.AllowedAmountPerUnit = (allowed.Value / units.Value).ToString("0.00");
        //    }
        //    else
        //    {
        //        // Only parse allowed amount if not Adjusted/Denied
        //        allowed = ToNullableDecimal(r.AllowedAmount);
        //        if (allowed.HasValue)
        //            r.AllowedAmountPerUnit = (allowed.Value / units.Value).ToString("0.00");
        //    }

        //    // Rest of the calculations remain the same
        //    if (billed.HasValue)
        //        r.BilledAmountPerUnit = (billed.Value / units.Value).ToString("0.00");

        //    decimal? insurancePay = ToNullableDecimal(r.InsurancePayment);
        //    if (insurancePay.HasValue)
        //        r.InsurancePaymentPerUnit = (insurancePay.Value / units.Value).ToString("0.00");

        //    decimal? patientPay = ToNullableDecimal(r.PatientPaidAmount);
        //    if (patientPay.HasValue)
        //        r.PatientPaymentPerUnit = (patientPay.Value / units.Value).ToString("0.00");

        //    decimal? patientBal = ToNullableDecimal(r.PatientBalance);
        //    if (patientBal.HasValue)
        //        r.PatientBalancePerUnit = (patientBal.Value / units.Value).ToString("0.00");
        //}

        private void CalculatePerUnitValues(MasterLineLevelRecord r)
        {
            decimal? units = ToNullableDecimal(r.Units);
            if (units == null || units <= 0)
                return;

            decimal? billed = ToNullableDecimal(r.BilledAmount);
            decimal? allowed = ToNullableDecimal(r.AllowedAmount);
            decimal? insurancePay = ToNullableDecimal(r.InsurancePayment);
            decimal? patientPay = ToNullableDecimal(r.PatientPaidAmount);
            decimal? patientBal = ToNullableDecimal(r.PatientBalance);

            if (billed.HasValue)
                r.BilledAmountPerUnit = (billed.Value / units.Value).ToString("0.00");

            if (allowed.HasValue)
                r.AllowedAmountPerUnit = (allowed.Value / units.Value).ToString("0.00");

            if (insurancePay.HasValue)
                r.InsurancePaymentPerUnit = (insurancePay.Value / units.Value).ToString("0.00");

            if (patientPay.HasValue)
                r.PatientPaymentPerUnit = (patientPay.Value / units.Value).ToString("0.00");

            if (patientBal.HasValue)
                r.PatientBalancePerUnit = (patientBal.Value / units.Value).ToString("0.00");
        }

        private decimal? ToNullableDecimal(string value)
        {
            if (string.IsNullOrWhiteSpace(value))
                return null;

            value = value.Replace(",", "").Trim(); // handle 1,234.56

            if (decimal.TryParse(
                value,
                System.Globalization.NumberStyles.Any,
                System.Globalization.CultureInfo.InvariantCulture,
                out var result))
            {
                return result;
            }

            return null;
        }

        private string GetCellStringValueSafe(IXLCell cell)
        {
            if (cell == null)
                return "";

            try
            {
                if (cell.IsEmpty())
                    return "";

                // XLCellValue is a struct → no null-conditional operator
                return cell.Value.ToString().Trim();
            }
            catch
            {
                return "";
            }
        }


        public string GeneratePayerCPTAverageCSV()
        {
            LogMessage("INFO", "Starting Payer-CPT Average CSV generation", true);

            var masterLineCsv = Directory
                .GetFiles(_outputFolder, "MasterLineLevel_Extracted_*.csv")
                .OrderByDescending(File.GetCreationTime)
                .FirstOrDefault();

            if (masterLineCsv == null)
                throw new Exception("Master Line Level CSV not found.");

            string avgCsv = Path.Combine(
                _outputFolder,
                $"Payer_CPT_Average_{DateTime.Now:yyyyMMdd_HHmmss}.csv"
            );

            string auditCsv = Path.Combine(
                _outputFolder,
                $"Payer_CPT_AuditLog_{DateTime.Now:yyyyMMdd_HHmmss}.csv"
            );

            string errorLog = Path.Combine(
                _outputFolder,
                $"Payer_CPT_Errors_{DateTime.Now:yyyyMMdd_HHmmss}.log"
            );

            var payerMasterList = LoadPayerMaster(_lab.PayerMasterFile);

            // ✅ CORRECT OBJECT + METHOD
            var generator = new PayerCPTAverageGenerator(_outputFolder, payerMasterList, LogMessage);
            generator.GenerateFromCsv(masterLineCsv, avgCsv, auditCsv, errorLog);

            LogMessage("SUCCESS", $"Payer-CPT Average CSV created: {avgCsv}", true);

            return avgCsv;
        }

        private List<PayerMasterRecord> LoadPayerMaster(string payerMasterPath)
        {
            var list = new List<PayerMasterRecord>();

            if (!File.Exists(payerMasterPath))
                throw new FileNotFoundException($"PayerMaster file not found: {payerMasterPath}");

            using var workbook = new XLWorkbook(payerMasterPath);
            var ws = workbook.Worksheet(1);
            var range = ws.RangeUsed();

            if (range == null)
                return list;

            var header = range.Row(1)
                .Cells()
                .Select((c, i) => new { Name = c.GetString().Trim(), Index = i + 1 })
                .Where(x => !string.IsNullOrWhiteSpace(x.Name))
                .ToDictionary(x => x.Name, x => x.Index, StringComparer.OrdinalIgnoreCase);

            for (int r = 2; r <= range.RowCount(); r++)
            {
                var row = ws.Row(r);

                // 🔴 IMPORTANT: Skip fully empty rows
                string payerNameRaw = row.Cell(header["Payer_Name_Raw"]).GetString()?.Trim();

                if (string.IsNullOrWhiteSpace(payerNameRaw))
                    continue; // ⛔ skip empty row

                list.Add(new PayerMasterRecord
                {
                    Global_Payer_ID = row.Cell(header["Global_Payer_ID"]).GetString().Trim(),
                    Payer_Code = row.Cell(header["Payer_Code"]).GetString().Trim(),
                    Payer_Common_Code = row.Cell(header["Payer_Common_Code"]).GetString().Trim(),
                    Payer_Group_Code = row.Cell(header["Payer_Group_Code"]).GetString().Trim(),
                    Payer_Name_Raw = payerNameRaw,
                    Payer_Name_Normalized = row.Cell(header["Payer_Name_Normalized"]).GetString().Trim(),
                    Plan_Type = row.Cell(header["Plan_Type"]).GetString().Trim(),
                    Payer_State = row.Cell(header["Payer_State"]).GetString().Trim(),
                    Is_Active = row.Cell(header["Is_Active"]).GetString().Trim(),
                    Global_Payer_ID2 = row.Cell(header["Global_Payer_ID2"]).GetString().Trim()
                });
            }

            Console.WriteLine($"✅ Loaded {list.Count} valid PayerMaster records");
            return list;
        }


        //public string GeneratePayerCPTAverageCSV()
        //{
        //    LogMessage("INFO", "Starting Payer-CPT Average CSV generation", true);

        //    // 1️⃣ Locate latest Master Line Level CSV
        //    var masterLineCsv = Directory
        //        .GetFiles(_outputFolder, "MasterLineLevel_Extracted_*.csv")
        //        .OrderByDescending(File.GetCreationTime)
        //        .FirstOrDefault();

        //    if (masterLineCsv == null)
        //        throw new Exception("Master Line Level CSV not found.");

        //    string outputPath = Path.Combine(
        //        _outputFolder,
        //        $"Payer_CPT_Average_{DateTime.Now:yyyyMMdd_HHmmss}.csv"
        //    );

        //  //  var payerCptLogCsv = Path.Combine(_outputFolder, $"Payer_CPT_AuditLog_{DateTime.Now:yyyyMMdd_HHmmss}.csv");

        //    //GeneratePayerCPTAverageFromCsv(masterLineCsv, outputPath, payerCptLogCsv);

        //    var generator = new PayerCPTAverageGenerator(_outputFolder, LogMessage);
        //    return generator.GeneratePayerCPTAverageCSV();




        //    LogMessage("SUCCESS", $"Payer-CPT Average CSV created: {outputPath}", true);

        //    return outputPath;
        //}

        private string EscapeCsvField(string field)
        {
            if (string.IsNullOrEmpty(field))
                return "";

            if (field.Contains("\"") || field.Contains(",") || field.Contains("\n") || field.Contains("\r"))
            {
                return field.Replace("\"", "\"\"");
            }

            return field;
        }




        //private void GeneratePayerCPTAverageFromCsv(string inputCsv, string outputCsv)
        //{
        //    var allowedStatuses = new HashSet<string>(
        //        new[] { "Paid", "Adjusted", "Denied", "Patient Responsibility" },
        //        StringComparer.OrdinalIgnoreCase
        //    );

        //    var rows = File.ReadAllLines(inputCsv);

        //    var header = rows[0].Split(',')
        //        .Select((h, i) => new { Name = h.Trim('"'), Index = i })
        //        .ToDictionary(x => x.Name, x => x.Index, StringComparer.OrdinalIgnoreCase);

        //    decimal? ParseDecimal(string val)
        //    {
        //        if (string.IsNullOrWhiteSpace(val)) return null;
        //        val = val.Replace(",", "").Trim('"');
        //        return decimal.TryParse(val, out var d) ? d : null;
        //    }

        //    //var data = rows.Skip(1)
        //    //    .Select(r => r.Split(','))
        //    //    .Select(c =>
        //    //    {
        //    //        var status = c[header["FinalClaimStatus"]].Trim('"');
        //    //        var payer = c[header["PayerName"]].Trim('"');

        //    //        // ❌ Rule 1: Skip blank payer
        //    //        if (string.IsNullOrWhiteSpace(payer))
        //    //            return null;

        //    //        if (!allowedStatuses.Contains(status))
        //    //            return null;

        //    //        var billed = ParseDecimal(c[header["BilledAmountPerUnit"]]);
        //    //        var allowed = ParseDecimal(c[header["AllowedAmountPerUnit"]]);
        //    //        var insurance = ParseDecimal(c[header["InsurancePaymentPerUnit"]]);
        //    //        var patientBal = ParseDecimal(c[header["PatientBalancePerUnit"]]);

        //    //        // ❌ Rule 2: Zero allowed for Denied / Adjusted
        //    //        if (status.Equals("Denied", StringComparison.OrdinalIgnoreCase) ||
        //    //            status.Equals("Adjusted", StringComparison.OrdinalIgnoreCase))
        //    //        {
        //    //            allowed = 0m;
        //    //        }

        //    //        return new
        //    //        {
        //    //            PayerName = payer,
        //    //            CPTCode = c[header["CPTCode"]].Trim('"'),
        //    //            Billed = billed,
        //    //            Allowed = allowed,
        //    //            Insurance = insurance,
        //    //            PatientBal = patientBal
        //    //        };
        //    //    })
        //    //    .Where(x =>
        //    //        x != null &&
        //    //        x.Billed.HasValue &&
        //    //        x.Allowed.HasValue
        //    //    // &&x.Insurance.HasValue &&
        //    //    //x.PatientBal.HasValue
        //    //    );

        //    var data = rows.Skip(1)
        //        .Select(r => r.Split(','))
        //        .Select(c =>
        //        {
        //            var status = c[header["FinalClaimStatus"]].Trim('"');
        //            var payer = c[header["PayerName"]].Trim('"');

        //            if (string.IsNullOrWhiteSpace(payer))
        //                return null;

        //            if (!allowedStatuses.Contains(status))
        //                return null;

        //            var billed = ParseDecimal(c[header["BilledAmountPerUnit"]]);
        //            var allowed = ParseDecimal(c[header["AllowedAmountPerUnit"]]);

        //            // 🔥 Adjusted / Denied rule
        //            if (status.Equals("Denied", StringComparison.OrdinalIgnoreCase) ||
        //                status.Equals("Adjusted", StringComparison.OrdinalIgnoreCase))
        //            {
        //                allowed = 0m;
        //            }

        //            return new
        //            {
        //                PayerName = payer,
        //                CPTCode = c[header["CPTCode"]].Trim('"'),
        //                Billed = billed,
        //                Allowed = allowed
        //            };
        //        })
        //        .Where(x =>
        //            x != null &&
        //            x.Billed.HasValue &&
        //            x.Allowed.HasValue
        //        );



        //    //var result = data
        //    //    .GroupBy(x => new { x.PayerName, x.CPTCode })
        //    //    .Select(g => new
        //    //    {
        //    //        g.Key.PayerName,
        //    //        g.Key.CPTCode,
        //    //        AvgBilled = g.Average(x => x.Billed.Value),
        //    //        AvgAllowed = g.Average(x => x.Allowed.Value),
        //    //        AvgInsurance = g.Average(x => x.Insurance.Value),
        //    //        AvgPatientBalance = g.Average(x => x.PatientBal.Value)
        //    //    })
        //    //    .OrderBy(x => x.PayerName)
        //    //    .ThenBy(x => x.CPTCode)
        //    //    .ToList();


        //    var result = data
        //    .GroupBy(x => new { x.PayerName, x.CPTCode })
        //    .Select(g => new
        //    {
        //        g.Key.PayerName,
        //        g.Key.CPTCode,
        //        AvgBilled = g.Average(x => x.Billed.Value),
        //        AvgAllowed = g.Average(x => x.Allowed.Value)
        //    })
        //        .OrderBy(x => x.PayerName)
        //        .ThenBy(x => x.CPTCode)
        //    .ToList();

        //    using var sw = new StreamWriter(outputCsv, false, Encoding.UTF8);

        //    sw.WriteLine(
        //        "PayerName,CPTCode," +
        //        "AvgBilledAmountPerUnit," +
        //        "AvgAllowedAmountPerUnit," +
        //        "AvgInsurancePaymentPerUnit," +
        //        "AvgPatientBalancePerUnit"
        //    );

        //    foreach (var r in result)
        //    {
        //        sw.WriteLine(
        //            $"\"{r.PayerName}\",\"{r.CPTCode}\"," +
        //            $"{r.AvgBilled:0.00}," +
        //            $"{r.AvgAllowed:0.00}," +
        //            $"{r.AvgInsurance:0.00}," +
        //            $"{r.AvgPatientBalance:0.00}"
        //        );
        //    }
        //}

        //private void GeneratePayerCPTAverageFromCsv(string inputCsv, string outputCsv)
        //{
        //    var allowedStatuses = new HashSet<string>(
        //        new[] { "Paid", "Adjusted", "Denied", "Patient Responsibility" },
        //        StringComparer.OrdinalIgnoreCase
        //    );

        //    var rows = File.ReadAllLines(inputCsv);

        //    var header = rows[0].Split(',')
        //        .Select((h, i) => new { Name = h.Trim('"'), Index = i })
        //        .ToDictionary(x => x.Name, x => x.Index, StringComparer.OrdinalIgnoreCase);

        //    decimal? ParseDecimal(string val)
        //    {
        //        if (string.IsNullOrWhiteSpace(val)) return null;
        //        val = val.Replace(",", "").Trim('"');
        //        return decimal.TryParse(val, out var d) ? d : null;
        //    }

        //    var data = rows.Skip(1)
        //        .Select(r => r.Split(','))
        //        .Where(c =>
        //            header.ContainsKey("FinalClaimStatus") &&
        //            allowedStatuses.Contains(c[header["FinalClaimStatus"]].Trim('"'))
        //        )
        //        .Select(c => new
        //        {
        //            PayerName = c[header["PayerName"]].Trim('"'),
        //            CPTCode = c[header["CPTCode"]].Trim('"'),

        //            Billed = ParseDecimal(c[header["BilledAmountPerUnit"]]),
        //            Allowed = ParseDecimal(c[header["AllowedAmountPerUnit"]]),
        //            Insurance = ParseDecimal(c[header["InsurancePaymentPerUnit"]]),
        //            PatientBal = ParseDecimal(c[header["PatientBalancePerUnit"]])
        //        })
        //        .Where(x =>
        //            x.Billed.HasValue &&
        //            x.Allowed.HasValue &&
        //            x.Insurance.HasValue &&
        //            x.PatientBal.HasValue
        //        );

        //    var result = data
        //        .GroupBy(x => new { x.PayerName, x.CPTCode })
        //        .Select(g => new
        //        {
        //            g.Key.PayerName,
        //            g.Key.CPTCode,
        //            AvgBilled = g.Average(x => x.Billed.Value),
        //            AvgAllowed = g.Average(x => x.Allowed.Value),
        //            AvgInsurance = g.Average(x => x.Insurance.Value),
        //            AvgPatientBalance = g.Average(x => x.PatientBal.Value)
        //        })
        //        .OrderBy(x => x.PayerName)
        //        .ThenBy(x => x.CPTCode)
        //        .ToList();

        //    using var sw = new StreamWriter(outputCsv, false, Encoding.UTF8);

        //    sw.WriteLine(
        //        "PayerName,CPTCode," +
        //        "AvgBilledAmountPerUnit," +
        //        "AvgAllowedAmountPerUnit," +
        //        "AvgInsurancePaymentPerUnit," +
        //        "AvgPatientBalancePerUnit"
        //    );

        //    foreach (var r in result)
        //    {
        //        sw.WriteLine(
        //            $"\"{r.PayerName}\",\"{r.CPTCode}\"," +
        //            $"{r.AvgBilled:0.00}," +
        //            $"{r.AvgAllowed:0.00}," +
        //            $"{r.AvgInsurance:0.00}," +
        //            $"{r.AvgPatientBalance:0.00}"
        //        );
        //    }
        //}




    }



    #region "prevcodes"
    /// 
    /// 
    /// 
//    ///   private void GeneratePayerCPTAverageFromCsv(
//         string inputCsv,
//         string outputCsv,
//         string payerCptLogCsv
//     )
//        {
//            var allowedStatuses = new HashSet<string>(
//       new[] { "Paid", "Adjusted", "Denied", "Patient Responsibility" },
//       StringComparer.OrdinalIgnoreCase
//   );

//        var rows = File.ReadAllLines(inputCsv);
//            if (rows.Length <= 1) return;

//            var header = rows[0]
//                .Split(',')
//                .Select((h, i) => new { Name = h.Trim('"'), Index = i })
//                .ToDictionary(x => x.Name, x => x.Index, StringComparer.OrdinalIgnoreCase);

//    decimal? ParseDecimal(string val)
//    {
//        if (string.IsNullOrWhiteSpace(val)) return null;
//        val = val.Replace(",", "").Trim('"');
//        return decimal.TryParse(val, out var d) ? d : null;
//    }

//    /* ============================================================
//       STEP 1: Read and track ALL rows with exclusion reasons
//       ============================================================ */
//    var allRows = new List<object>();
//    var excludedRows = new List<ExcludedRowInfo>();
//    var includedRows = new List<IncludedRowData>();
//    int rowNumber = 1;

//            foreach (var row in rows.Skip(1))
//            {
//                rowNumber++;
//                var cells = row.Split(',');

//                try
//                {
//                    var status = cells[header["FinalClaimStatus"]].Trim('"');
//    var payer = cells[header["PayerName"]].Trim('"');
//    var cptCode = cells[header["CPTCode"]].Trim('"');

//    // Check for exclusions
//    var exclusionReason = GetExclusionReason(cells, header, payer, status, allowedStatuses);

//                    if (!string.IsNullOrEmpty(exclusionReason))
//                    {
//                        excludedRows.Add(new ExcludedRowInfo
//                        {
//                            RowNumber = rowNumber,
//                            PayerName = payer,
//                            CPTCode = cptCode,
//                            FinalClaimStatus = status,
//                            Reason = exclusionReason,
//                            AllowedAmountPerUnit = cells[header["AllowedAmountPerUnit"]].Trim('"'),
//                            BilledAmountPerUnit = cells[header["BilledAmountPerUnit"]].Trim('"'),
//                            InsurancePaymentPerUnit = cells[header["InsurancePaymentPerUnit"]].Trim('"'),
//                            PatientBalancePerUnit = cells[header["PatientBalancePerUnit"]].Trim('"')
//                        });
//continue;
//                    }

//                    // Parse values - CRITICAL FIX HERE
//                    var allowedRaw = cells[header["AllowedAmountPerUnit"]];
//var billedRaw = cells[header["BilledAmountPerUnit"]];
//var insuranceRaw = cells[header["InsurancePaymentPerUnit"]];
//var patientBalRaw = cells[header["PatientBalancePerUnit"]];

//// 🔥 CRITICAL BUSINESS RULE: 
//// For "Adjusted" or "Denied" status, AllowedAmountPerUnit should be 0
//decimal? allowed;
//if (status.Equals("Adjusted", StringComparison.OrdinalIgnoreCase) ||
//    status.Equals("Denied", StringComparison.OrdinalIgnoreCase))
//{
//    allowed = 0m;  // Force to 0 regardless of what's in the CSV
//}
//else
//{
//    allowed = ParseDecimal(allowedRaw);
//}

//decimal? billed = ParseDecimal(billedRaw);
//decimal? insurance = ParseDecimal(insuranceRaw);
//decimal? patientBalance = ParseDecimal(patientBalRaw);

//includedRows.Add(new IncludedRowData
//{
//    RowNumber = rowNumber,
//    PayerName = payer,
//    CPTCode = cptCode,
//    FinalClaimStatus = status,
//    Allowed = allowed,
//    Billed = billed,
//    Insurance = insurance,
//    PatientBalance = patientBalance,
//    HasAllowedValue = allowed.HasValue,
//    HasBilledValue = billed.HasValue,
//    HasInsuranceValue = insurance.HasValue,
//    HasPatientBalanceValue = patientBalance.HasValue,
//    RawAllowed = allowedRaw.Trim('"'),
//    RawBilled = billedRaw.Trim('"'),
//    RawInsurance = insuranceRaw.Trim('"'),
//    RawPatientBalance = patientBalRaw.Trim('"')
//});
//                }
//                catch (Exception ex)
//                {
//                    excludedRows.Add(new ExcludedRowInfo
//                                     {
//                                         RowNumber = rowNumber,
//                                         PayerName = "ERROR",
//                                         CPTCode = "ERROR",
//                                         FinalClaimStatus = "ERROR",
//                                         Reason = $"Error processing row: {ex.Message}",
//                                         AllowedAmountPerUnit = "ERROR",
//                                         BilledAmountPerUnit = "ERROR",
//                                         InsurancePaymentPerUnit = "ERROR",
//                                         PatientBalancePerUnit = "ERROR"
//                                     });
//                }
//            }

//            // Rest of the method remains the same...
//            /* ============================================================
//               STEP 2: Write excluded rows log
//               ============================================================ */
//            string excludedLogPath = Path.Combine(
//                Path.GetDirectoryName(payerCptLogCsv),
//                $"Excluded_Rows_{DateTime.Now:yyyyMMdd_HHmmss}.csv"
//            );

//WriteExcludedRowsLog(excludedRows, excludedLogPath);
//LogMessage("INFO", $"Total rows processed: {rows.Length - 1}", true);
//LogMessage("INFO", $"Rows included: {includedRows.Count}", true);
//LogMessage("INFO", $"Rows excluded: {excludedRows.Count}", true);
//LogMessage("INFO", $"Exclusion log saved to: {excludedLogPath}", true);

//// Group exclusions by reason for summary
//var exclusionSummary = excludedRows
//    .GroupBy(x => x.Reason)
//    .Select(g => new { Reason = g.Key, Count = g.Count() })
//    .ToList();

//LogMessage("INFO", "Exclusion summary:", true);
//foreach (var summary in exclusionSummary)
//{
//    LogMessage("INFO", $"  {summary.Reason}: {summary.Count} rows", false);
//}

///* ============================================================
//   STEP 3: Aggregation + RAW audit metrics
//   ============================================================ */
//var result = includedRows
//    .GroupBy(x => new { x.PayerName, x.CPTCode })
//    .Select(g =>
//    {
//        // Count ALL rows in this group (that passed initial filters)
//        var originalRowCount = g.Count();

//        // For Allowed - use only rows with numeric Allowed values
//        var allowedRows = g.Where(x => x.HasAllowedValue).ToList();
//        var allowedCount = allowedRows.Count;

//        if (allowedCount == 0)
//            return null;  // Skip groups with no numeric Allowed values

//        var allowedValues = allowedRows.Select(x => x.Allowed.Value).ToList();
//        var allowedSum = allowedValues.Sum();
//        var avgAllowed = allowedSum / allowedCount;

//        // For Billed - use only rows with numeric Billed values
//        var billedRows = g.Where(x => x.HasBilledValue).ToList();
//        var billedCount = billedRows.Count;
//        var billedSum = billedRows.Sum(x => x.Billed.Value);
//        var avgBilled = billedCount > 0 ? billedSum / billedCount : 0;

//        // For Insurance - use only rows with numeric Insurance values
//        var insuranceRows = g.Where(x => x.HasInsuranceValue).ToList();
//        var insuranceCount = insuranceRows.Count;
//        var insuranceSum = insuranceRows.Sum(x => x.Insurance.Value);
//        var avgInsurance = insuranceCount > 0 ? insuranceSum / insuranceCount : 0;

//        // For PatientBalance - use only rows with numeric PatientBalance values
//        var patientBalanceRows = g.Where(x => x.HasPatientBalanceValue).ToList();
//        var patientBalanceCount = patientBalanceRows.Count;
//        var patientBalanceSum = patientBalanceRows.Sum(x => x.PatientBalance.Value);
//        var avgPatientBalance = patientBalanceCount > 0 ? patientBalanceSum / patientBalanceCount : 0;

//        // Count rows with blank values for each field
//        var blankAllowedCount = g.Count(x => !x.HasAllowedValue);
//        var blankBilledCount = g.Count(x => !x.HasBilledValue);
//        var blankInsuranceCount = g.Count(x => !x.HasInsuranceValue);
//        var blankPatientBalanceCount = g.Count(x => !x.HasPatientBalanceValue);

//        return new
//        {
//            g.Key.PayerName,
//            g.Key.CPTCode,

//            // Counts
//            Original_Row_Count = originalRowCount,
//            Rows_With_Allowed_Values = allowedCount,
//            Rows_With_Billed_Values = billedCount,
//            Rows_With_Insurance_Values = insuranceCount,
//            Rows_With_PatientBalance_Values = patientBalanceCount,

//            // Blank counts
//            Rows_With_Blank_Allowed = blankAllowedCount,
//            Rows_With_Blank_Billed = blankBilledCount,
//            Rows_With_Blank_Insurance = blankInsuranceCount,
//            Rows_With_Blank_PatientBalance = blankPatientBalanceCount,

//            // Sums
//            Allowed_Sum = allowedSum,
//            Billed_Sum = billedSum,
//            Insurance_Sum = insuranceSum,
//            PatientBalance_Sum = patientBalanceSum,

//            // Averages (Excel-style - each field averaged separately)
//            AvgAllowed = avgAllowed,
//            AvgBilled = avgBilled,
//            AvgInsurance = avgInsurance,
//            AvgPatientBalance = avgPatientBalance,

//            // For detailed audit
//            IncludedRowNumbers = g.Select(x => x.RowNumber).ToList(),
//            SampleRawValues = g.Take(3).Select(x => new
//            {
//                x.RowNumber,
//                x.RawAllowed,
//                x.RawBilled,
//                x.RawInsurance,
//                x.RawPatientBalance
//            }).ToList()
//        };
//    })
//    .Where(x => x != null)
//    .OrderBy(x => x.PayerName)
//    .ThenBy(x => x.CPTCode)
//    .ToList();

///* ============================================================
//   STEP 4: Write detailed included rows log
//   ============================================================ */
//string includedLogPath = Path.Combine(
//    Path.GetDirectoryName(payerCptLogCsv),
//    $"Included_Rows_Detailed_{DateTime.Now:yyyyMMdd_HHmmss}.csv"
//);

//WriteIncludedRowsLog(includedRows, includedLogPath);
//LogMessage("INFO", $"Detailed included rows log saved to: {includedLogPath}", true);

///* ============================================================
//   STEP 5: MAIN OUTPUT CSV (Excel-compatible averages)
//   ============================================================ */
//using (var sw = new StreamWriter(outputCsv, false, Encoding.UTF8))
//{
//    sw.WriteLine(
//        "PayerName,CPTCode," +
//        "AvgBilledAmountPerUnit," +
//        "AvgAllowedAmountPerUnit," +
//        "AvgInsurancePaymentPerUnit," +
//        "AvgPatientBalancePerUnit"
//    );

//    foreach (var r in result)
//    {
//        sw.WriteLine(
//            $"\"{r.PayerName}\",\"{r.CPTCode}\"," +
//            $"{r.AvgBilled:0.00}," +
//            $"{r.AvgAllowed:0.00}," +
//            $"{r.AvgInsurance:0.00}," +
//            $"{r.AvgPatientBalance:0.00}"
//        );
//    }
//}

///* ============================================================
//   STEP 6: PAYER–CPT AUDIT LOG (For reconciliation)
//   ============================================================ */
//using (var log = new StreamWriter(payerCptLogCsv, false, Encoding.UTF8))
//{
//    log.WriteLine(
//        "PayerName,CPTCode," +
//        "Original_Row_Count,Rows_With_Allowed_Values,Rows_With_Billed_Values,Rows_With_Insurance_Values,Rows_With_PatientBalance_Values," +
//        "Rows_With_Blank_Allowed,Rows_With_Blank_Billed,Rows_With_Blank_Insurance,Rows_With_Blank_PatientBalance," +
//        "Allowed_Sum,Billed_Sum,Insurance_Sum,PatientBalance_Sum," +
//        "AvgAllowed_Excel,AvgBilled_Excel,AvgInsurance_Excel,AvgPatientBalance_Excel," +
//        "Included_Row_Count,Sample_Row_Numbers"
//    );

//    foreach (var r in result)
//    {
//        var sampleRows = string.Join(";", r.IncludedRowNumbers.Take(5));
//        log.WriteLine(
//            $"\"{r.PayerName}\",\"{r.CPTCode}\"," +
//            $"{r.Original_Row_Count}," +
//            $"{r.Rows_With_Allowed_Values},{r.Rows_With_Billed_Values},{r.Rows_With_Insurance_Values},{r.Rows_With_PatientBalance_Values}," +
//            $"{r.Rows_With_Blank_Allowed},{r.Rows_With_Blank_Billed},{r.Rows_With_Blank_Insurance},{r.Rows_With_Blank_PatientBalance}," +
//            $"{r.Allowed_Sum:0.00},{r.Billed_Sum:0.00},{r.Insurance_Sum:0.00},{r.PatientBalance_Sum:0.00}," +
//            $"{r.AvgAllowed:0.########},{r.AvgBilled:0.########},{r.AvgInsurance:0.########},{r.AvgPatientBalance:0.########}," +
//            $"{r.IncludedRowNumbers.Count},\"{sampleRows}\""
//        );
//    }
//}

//// Log a detailed summary
//LogMessage("SUMMARY", "=".PadRight(80, '='), true);
//LogMessage("SUMMARY", "PAYER-CPT AVERAGE GENERATION COMPLETE", true);
//LogMessage("SUMMARY", $"Total input rows: {rows.Length - 1}", true);
//LogMessage("SUMMARY", $"Rows included for processing: {includedRows.Count}", true);
//LogMessage("SUMMARY", $"Rows excluded: {excludedRows.Count}", true);
//LogMessage("SUMMARY", $"Payer-CPT combinations calculated: {result.Count}", true);
//LogMessage("SUMMARY", $"Main output file: {outputCsv}", true);
//LogMessage("SUMMARY", $"Audit log: {payerCptLogCsv}", true);
//LogMessage("SUMMARY", $"Exclusion log: {excludedLogPath}", true);
//LogMessage("SUMMARY", $"Included rows detail log: {includedLogPath}", true);
//LogMessage("SUMMARY", "=".PadRight(80, '='), true);
//        }

//        /* ============================================================
//           SUPPORTING CLASSES AND METHODS
//           ============================================================ */

//        private class ExcludedRowInfo
//{
//    public int RowNumber { get; set; }
//    public string PayerName { get; set; }
//    public string CPTCode { get; set; }
//    public string FinalClaimStatus { get; set; }
//    public string Reason { get; set; }
//    public string AllowedAmountPerUnit { get; set; }
//    public string BilledAmountPerUnit { get; set; }
//    public string InsurancePaymentPerUnit { get; set; }
//    public string PatientBalancePerUnit { get; set; }
//}

//private class IncludedRowData
//{
//    public int RowNumber { get; set; }
//    public string PayerName { get; set; }
//    public string CPTCode { get; set; }
//    public string FinalClaimStatus { get; set; }
//    public decimal? Allowed { get; set; }
//    public decimal? Billed { get; set; }
//    public decimal? Insurance { get; set; }
//    public decimal? PatientBalance { get; set; }
//    public bool HasAllowedValue { get; set; }
//    public bool HasBilledValue { get; set; }
//    public bool HasInsuranceValue { get; set; }
//    public bool HasPatientBalanceValue { get; set; }
//    public string RawAllowed { get; set; }
//    public string RawBilled { get; set; }
//    public string RawInsurance { get; set; }
//    public string RawPatientBalance { get; set; }
//}

//private string GetExclusionReason(string[] cells, Dictionary<string, int> header,
//    string payer, string status, HashSet<string> allowedStatuses)
//{
//    // Check for blank payer
//    if (string.IsNullOrWhiteSpace(payer))
//        return "Blank PayerName";

//    // Check if status is in allowed list
//    if (!allowedStatuses.Contains(status))
//        return $"Status not in allowed list: {status}";

//    // Check for missing required columns
//    var requiredColumns = new[] { "AllowedAmountPerUnit", "BilledAmountPerUnit",
//                                 "InsurancePaymentPerUnit", "PatientBalancePerUnit" };
//    foreach (var col in requiredColumns)
//    {
//        if (!header.ContainsKey(col))
//            return $"Missing column: {col}";
//    }

//    return null; // No exclusion reason
//}

//private void WriteExcludedRowsLog(List<ExcludedRowInfo> excludedRows, string outputPath)
//{
//    using (var writer = new StreamWriter(outputPath, false, Encoding.UTF8))
//    {
//        writer.WriteLine(
//            "RowNumber,PayerName,CPTCode,FinalClaimStatus,ExclusionReason," +
//            "AllowedAmountPerUnit,BilledAmountPerUnit,InsurancePaymentPerUnit,PatientBalancePerUnit"
//        );

//        foreach (var row in excludedRows)
//        {
//            writer.WriteLine(
//                $"{row.RowNumber}," +
//                $"\"{EscapeCsvField(row.PayerName)}\"," +
//                $"\"{EscapeCsvField(row.CPTCode)}\"," +
//                $"\"{EscapeCsvField(row.FinalClaimStatus)}\"," +
//                $"\"{EscapeCsvField(row.Reason)}\"," +
//                $"\"{EscapeCsvField(row.AllowedAmountPerUnit)}\"," +
//                $"\"{EscapeCsvField(row.BilledAmountPerUnit)}\"," +
//                $"\"{EscapeCsvField(row.InsurancePaymentPerUnit)}\"," +
//                $"\"{EscapeCsvField(row.PatientBalancePerUnit)}\""
//            );
//        }
//    }
//}

//private void WriteIncludedRowsLog(List<IncludedRowData> includedRows, string outputPath)
//{
//    using (var writer = new StreamWriter(outputPath, false, Encoding.UTF8))
//    {
//        writer.WriteLine(
//            "RowNumber,PayerName,CPTCode,FinalClaimStatus," +
//            "Raw_AllowedAmountPerUnit,IsNumeric_Allowed,Allowed_NumericValue," +
//            "Raw_BilledAmountPerUnit,IsNumeric_Billed,Billed_NumericValue," +
//            "Raw_InsurancePaymentPerUnit,IsNumeric_Insurance,Insurance_NumericValue," +
//            "Raw_PatientBalancePerUnit,IsNumeric_PatientBalance,PatientBalance_NumericValue," +
//            "Included_In_Allowed_Avg,Included_In_Billed_Avg,Included_In_Insurance_Avg,Included_In_PatientBalance_Avg"
//        );

//        foreach (var row in includedRows)
//        {
//            writer.WriteLine(
//                $"{row.RowNumber}," +
//                $"\"{EscapeCsvField(row.PayerName)}\"," +
//                $"\"{EscapeCsvField(row.CPTCode)}\"," +
//                $"\"{EscapeCsvField(row.FinalClaimStatus)}\"," +
//                $"\"{EscapeCsvField(row.RawAllowed)}\",{(row.HasAllowedValue ? "Yes" : "No")},{row.Allowed?.ToString("0.00") ?? ""}," +
//                $"\"{EscapeCsvField(row.RawBilled)}\",{(row.HasBilledValue ? "Yes" : "No")},{row.Billed?.ToString("0.00") ?? ""}," +
//                $"\"{EscapeCsvField(row.RawInsurance)}\",{(row.HasInsuranceValue ? "Yes" : "No")},{row.Insurance?.ToString("0.00") ?? ""}," +
//                $"\"{EscapeCsvField(row.RawPatientBalance)}\",{(row.HasPatientBalanceValue ? "Yes" : "No")},{row.PatientBalance?.ToString("0.00") ?? ""}," +
//                $"{(row.HasAllowedValue ? "Yes" : "No")}," +
//                $"{(row.HasBilledValue ? "Yes" : "No")}," +
//                $"{(row.HasInsuranceValue ? "Yes" : "No")}," +
//                $"{(row.HasPatientBalanceValue ? "Yes" : "No")}"
//            );
//        }
//    }
//}

    ////@@@
    #endregion


}



