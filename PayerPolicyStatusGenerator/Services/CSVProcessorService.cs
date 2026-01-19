using Microsoft.Extensions.Configuration;
using PayerPolicyStatusGenerator.Models;
using PayerPolicyStatusGenerator.Utilities;
using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Text;

namespace PayerPolicyStatusGenerator.Services
{
    public class CSVFileProcessor
    {
        private readonly IConfiguration _configuration;
        private readonly PaymentStatusCalculator _calculator;

        public CSVFileProcessor(IConfiguration configuration)
        {
            _configuration = configuration;
            _calculator = new PaymentStatusCalculator(configuration);
        }

        public void ProcessAllFiles()
        {
            Console.WriteLine("\n" + new string('=', 70));
            Console.WriteLine("PAYER POLICY STATUS GENERATOR");
            Console.WriteLine(new string('=', 70));

            // Get configuration
            string inputFolder = _configuration["AppSettings:InputFolderPath"] ?? "Input";
            string outputFolder = _configuration["AppSettings:OutputFolderPath"] ?? "Output";
            string filePattern = _configuration["AppSettings:FilePattern"] ?? "*.csv";
            string logFile = _configuration["AppSettings:LogFilePath"] ?? "processing.log";

            // Display settings
            Console.WriteLine($"\nSETTINGS:");
            Console.WriteLine($"  Input Folder: {inputFolder}");
            Console.WriteLine($"  Output Folder: {outputFolder}");
            Console.WriteLine($"  File Pattern: {filePattern}");

            // Validate input folder
            if (!Directory.Exists(inputFolder))
            {
                Console.WriteLine($"\nERROR: Input folder does not exist: {inputFolder}");
                Console.WriteLine("Please create the folder or update appsettings.json");
                return;
            }

            // Create output folder
            if (!Directory.Exists(outputFolder))
            {
                Directory.CreateDirectory(outputFolder);
                Console.WriteLine($"\nCreated output folder: {outputFolder}");
            }

            // Get files
            var files = Directory.GetFiles(inputFolder, filePattern);
            Console.WriteLine($"\nFound {files.Length} CSV file(s) in input folder");

            if (files.Length == 0)
            {
                Console.WriteLine("No files to process.");
                return;
            }

            // Display file list
            Console.WriteLine("\nFiles to process:");
            foreach (var file in files)
            {
                Console.WriteLine($"  • {Path.GetFileName(file)}");
            }

            Console.WriteLine("\n" + new string('-', 70));
            Console.WriteLine("STARTING PROCESSING...");
            Console.WriteLine(new string('-', 70));

            int totalFilesProcessed = 0;
            int totalRecordsProcessed = 0;

            // Process each file
            foreach (var inputFile in files)
            {
                try
                {
                    Console.WriteLine($"\nProcessing: {Path.GetFileName(inputFile)}");
                    var result = ProcessFile(inputFile, outputFolder);

                    totalFilesProcessed++;
                    totalRecordsProcessed += result.RecordsProcessed;

                    Console.WriteLine($"  ✓ Records processed: {result.RecordsProcessed}");
                    Console.WriteLine($"  ✓ Output file: {Path.GetFileName(result.OutputFile)}");

                    // Show summary
                    if (result.StatusSummary.Count > 0)
                    {
                        Console.WriteLine($"  Payment Status Summary:");
                        foreach (var status in result.StatusSummary)
                        {
                            Console.WriteLine($"    • {status.Key}: {status.Value}");
                        }
                    }
                }
                catch (Exception ex)
                {
                    Console.WriteLine($"  ✗ ERROR: {ex.Message}");
                    LogError(logFile, inputFile, ex);
                }
            }

            // Final summary
            Console.WriteLine("\n" + new string('=', 70));
            Console.WriteLine("PROCESSING COMPLETE!");
            Console.WriteLine(new string('=', 70));
            Console.WriteLine($"\nSUMMARY:");
            Console.WriteLine($"  Files processed: {totalFilesProcessed}/{files.Length}");
            Console.WriteLine($"  Total records: {totalRecordsProcessed}");
            Console.WriteLine($"\nOutput folder: {Path.GetFullPath(outputFolder)}");
            Console.WriteLine("\n" + new string('=', 70));
        }

        private ProcessingResult ProcessFile(string inputFile, string outputFolder)
        {
            var lines = File.ReadAllLines(inputFile);
            if (lines.Length == 0)
                throw new Exception("File is empty");

            // Parse headers
            var headers = ParseCSVLine(lines[0]).ToList();
            Console.WriteLine($"  Columns found: {headers.Count}");

            // Create output file name
            string outputFile = Path.Combine(outputFolder,
                Path.GetFileNameWithoutExtension(inputFile) + "_processed.csv");

            // Process data
            var records = new List<Dictionary<string, string>>();
            var statusSummary = new Dictionary<string, int>();
            int recordCount = 0;

            using (var writer = new StreamWriter(outputFile, false, Encoding.UTF8))
            {
                // Write headers (add new columns)
                var outputHeaders = headers.ToList();
                outputHeaders.Add("Payment Status");
                outputHeaders.Add("Payment Remark");
                writer.WriteLine(string.Join(",", outputHeaders.Select(EscapeCSV)));

                // Process each data row
                for (int i = 1; i < lines.Length; i++)
                {
                    if (string.IsNullOrWhiteSpace(lines[i]))
                        continue;

                    var values = ParseCSVLine(lines[i]);
                    var record = new Dictionary<string, string>();

                    // Map values to headers
                    for (int j = 0; j < Math.Min(headers.Count, values.Length); j++)
                    {
                        record[headers[j]] = values[j];
                    }

                    // Create ClaimRecord object
                    var claimRecord = new ClaimRecord
                    {
                        SNo = GetValue(record, "SNo"),
                        PayerName = GetValue(record, "PayerName"),
                        GlobalPayerID = GetValue(record, "GlobalPayerID"),
                        Accession = GetValue(record, "Accession"),
                        VisitNumber = GetValue(record, "VisitNumber"),
                        DenialCode = GetValue(record, "DenialCode"),
                        CPTCode = GetValue(record, "CPTCode"),
                        ICD10Code = GetValue(record, "ICD10Code"),
                        CCWICDCode = GetValue(record, "CCWICDCode"),
                        CoverageStatus = GetValue(record, "CoverageStatus"),
                        ICDValidation = GetValue(record, "ICDValidation"),
                        ValidationRemarks = GetValue(record, "ValidationRemarks"),
                        CoveredICDCodes = GetValue(record, "CoveredICDCodes"),
                        NonCoveredICDCodes = GetValue(record, "NonCoveredICDCodes"),
                        ICDNOTAvailableinPayerPolicy = GetValue(record, "ICDNOTAvailableinPayerPolicy")
                    };

                    // Calculate payment status and remark
                    var (paymentStatus, paymentRemark) = _calculator.CalculatePaymentStatusAndRemark(claimRecord);

                    // Add to record
                    record["Payment Status"] = paymentStatus;
                    record["Payment Remark"] = paymentRemark;

                    // Update summary
                    if (statusSummary.ContainsKey(paymentStatus))
                        statusSummary[paymentStatus]++;
                    else
                        statusSummary[paymentStatus] = 1;

                    // Write output row
                    var outputValues = new List<string>();
                    foreach (var header in outputHeaders)
                    {
                        outputValues.Add(record.ContainsKey(header) ? record[header] : "");
                    }
                    writer.WriteLine(string.Join(",", outputValues.Select(EscapeCSV)));

                    recordCount++;

                    // Show progress every 1000 records
                    if (recordCount % 1000 == 0)
                    {
                        Console.WriteLine($"    Processed {recordCount} records...");
                    }
                }
            }

            return new ProcessingResult
            {
                InputFile = inputFile,
                OutputFile = outputFile,
                RecordsProcessed = recordCount,
                StatusSummary = statusSummary
            };
        }

        private string[] ParseCSVLine(string line)
        {
            var result = new List<string>();
            var current = new StringBuilder();
            bool inQuotes = false;

            for (int i = 0; i < line.Length; i++)
            {
                char c = line[i];

                if (c == '"')
                {
                    if (inQuotes && i + 1 < line.Length && line[i + 1] == '"')
                    {
                        // Escaped quote
                        current.Append('"');
                        i++;
                    }
                    else
                    {
                        inQuotes = !inQuotes;
                    }
                }
                else if (c == ',' && !inQuotes)
                {
                    result.Add(current.ToString());
                    current.Clear();
                }
                else
                {
                    current.Append(c);
                }
            }

            result.Add(current.ToString());
            return result.ToArray();
        }

        private string EscapeCSV(string value)
        {
            if (value == null)
                return "";

            if (value.Contains(",") || value.Contains("\"") || value.Contains("\n") || value.Contains("\r"))
            {
                return $"\"{value.Replace("\"", "\"\"")}\"";
            }

            return value;
        }

        private string GetValue(Dictionary<string, string> record, string key)
        {
            if (record.ContainsKey(key))
                return record[key];
            return "";
        }

        private void LogError(string logFile, string inputFile, Exception ex)
        {
            try
            {
                var logDir = Path.GetDirectoryName(logFile);
                if (!string.IsNullOrEmpty(logDir) && !Directory.Exists(logDir))
                {
                    Directory.CreateDirectory(logDir);
                }

                File.AppendAllText(logFile,
                    $"{DateTime.Now:yyyy-MM-dd HH:mm:ss} - ERROR: {inputFile}\n" +
                    $"Message: {ex.Message}\n" +
                    $"Stack Trace: {ex.StackTrace}\n\n");
            }
            catch
            {
                // Ignore log errors
            }
        }
    }

    public class ProcessingResult
    {
        public string InputFile { get; set; }
        public string OutputFile { get; set; }
        public int RecordsProcessed { get; set; }
        public Dictionary<string, int> StatusSummary { get; set; }
    }
}