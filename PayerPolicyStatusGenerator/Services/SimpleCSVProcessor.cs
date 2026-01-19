// Create a new file: Services/SimpleCSVProcessor.cs
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
    public class SimpleCSVProcessor
    {
        private readonly IConfiguration _configuration;
        private readonly PaymentStatusCalculator _calculator;

        public SimpleCSVProcessor(IConfiguration configuration)
        {
            _configuration = configuration;
            _calculator = new PaymentStatusCalculator(configuration);
        }

        public void ProcessAllCSVFilesInFolder()
        {
            string inputFolderPath = _configuration["AppSettings:InputFolderPath"];
            string outputFolderPath = _configuration["AppSettings:OutputFolderPath"];
            string filePattern = _configuration["AppSettings:FilePattern"] ?? "*.csv";
            bool processSubfolders = _configuration.GetValue<bool>("AppSettings:ProcessSubfolders");
            string logFilePath = _configuration["AppSettings:LogFilePath"];

            Console.WriteLine($"\nStarting CSV processing...");
            Console.WriteLine($"Input folder: {inputFolderPath}");
            Console.WriteLine($"Output folder: {outputFolderPath}");

            // Validate input folder
            if (!Directory.Exists(inputFolderPath))
            {
                throw new DirectoryNotFoundException($"Input folder not found: {inputFolderPath}");
            }

            // Create output folder
            if (!Directory.Exists(outputFolderPath))
            {
                Directory.CreateDirectory(outputFolderPath);
                Console.WriteLine($"Created output folder: {outputFolderPath}");
            }

            // Get CSV files
            var searchOption = processSubfolders ? SearchOption.AllDirectories : SearchOption.TopDirectoryOnly;
            var csvFiles = Directory.GetFiles(inputFolderPath, filePattern, searchOption);

            Console.WriteLine($"Found {csvFiles.Length} CSV file(s)");

            if (csvFiles.Length == 0)
            {
                Console.WriteLine("No CSV files to process.");
                return;
            }

            int totalProcessed = 0;
            foreach (var inputFile in csvFiles)
            {
                try
                {
                    Console.WriteLine($"\nProcessing: {Path.GetFileName(inputFile)}");
                    ProcessSingleFile(inputFile, outputFolderPath);
                    totalProcessed++;
                }
                catch (Exception ex)
                {
                    Console.WriteLine($"Error processing {Path.GetFileName(inputFile)}: {ex.Message}");
                    LogError(logFilePath, inputFile, ex);
                }
            }

            Console.WriteLine($"\nProcessing complete! Processed {totalProcessed}/{csvFiles.Length} files.");
        }

        private void ProcessSingleFile(string inputPath, string outputFolder)
        {
            var lines = File.ReadAllLines(inputPath);
            if (lines.Length == 0)
            {
                Console.WriteLine("  File is empty.");
                return;
            }

            // Parse headers
            var headers = ParseCSVLine(lines[0]);
            Console.WriteLine($"  Found {headers.Length} columns");

            // Create output file path
            string outputFile = Path.Combine(outputFolder,
                Path.GetFileNameWithoutExtension(inputPath) + "_processed" + Path.GetExtension(inputPath));

            // Process and write file
            using (var writer = new StreamWriter(outputFile, false, Encoding.UTF8))
            {
                // Write headers with new columns
                var outputHeaders = headers.ToList();
                outputHeaders.Add("Payment Status");
                outputHeaders.Add("Payment Remark");
                writer.WriteLine(ToCSVLine(outputHeaders));

                // Process each data row
                int rowCount = 0;
                for (int i = 1; i < lines.Length; i++)
                {
                    var values = ParseCSVLine(lines[i]);
                    if (values.Length == 0) continue;

                    var record = CreateClaimRecord(headers, values);
                    var (status, remark) = _calculator.CalculatePaymentStatusAndRemark(record);

                    // Create output row
                    var outputValues = values.ToList();
                    outputValues.Add(status);
                    outputValues.Add(remark);
                    writer.WriteLine(ToCSVLine(outputValues));

                    rowCount++;
                    if (rowCount % 1000 == 0)
                    {
                        Console.WriteLine($"  Processed {rowCount} rows...");
                    }
                }

                Console.WriteLine($"  Processed {rowCount} total rows");
                Console.WriteLine($"  Output saved to: {Path.GetFileName(outputFile)}");
            }
        }

        private ClaimRecord CreateClaimRecord(string[] headers, string[] values)
        {
            var record = new ClaimRecord();

            // Map values to properties based on position
            for (int i = 0; i < Math.Min(headers.Length, values.Length); i++)
            {
                string value = values[i];
                string header = headers[i];

                switch (header.ToLower())
                {
                    case "sno":
                        record.SNo = value;
                        break;
                    case "payername":
                        record.PayerName = value;
                        break;
                    case "globalpayerid":
                        record.GlobalPayerID = value;
                        break;
                    case "accession":
                        record.Accession = value;
                        break;
                    case "visitnumber":
                        record.VisitNumber = value;
                        break;
                    case "denialcode":
                        record.DenialCode = value;
                        break;
                    case "cptcode":
                        record.CPTCode = value;
                        break;
                    case "icd10code":
                        record.ICD10Code = value;
                        break;
                    case "ccwicdcode":
                        record.CCWICDCode = value;
                        break;
                    case "coveragestatus":
                        record.CoverageStatus = value;
                        break;
                    case "icdvalidation":
                        record.ICDValidation = value;
                        break;
                    case "validationremarks":
                        record.ValidationRemarks = value;
                        break;
                    case "coveredicdcodes":
                        record.CoveredICDCodes = value;
                        break;
                    case "noncoveredicdcodes":
                        record.NonCoveredICDCodes = value;
                        break;
                    case "icdnotavailableinpayerpolicy":
                        record.ICDNOTAvailableinPayerPolicy = value;
                        break;
                }
            }

            return record;
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
                    // Handle escaped quotes
                    if (i + 1 < line.Length && line[i + 1] == '"')
                    {
                        current.Append('"');
                        i++; // Skip next quote
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

        private string ToCSVLine(IEnumerable<string> values)
        {
            var result = new StringBuilder();
            bool first = true;

            foreach (var value in values)
            {
                if (!first) result.Append(',');
                first = false;

                if (value == null)
                {
                    result.Append("\"\"");
                }
                else if (value.Contains(',') || value.Contains('"') || value.Contains('\n') || value.Contains('\r'))
                {
                    result.Append('"');
                    result.Append(value.Replace("\"", "\"\""));
                    result.Append('"');
                }
                else
                {
                    result.Append(value);
                }
            }

            return result.ToString();
        }

        private void LogError(string logFilePath, string filePath, Exception ex)
        {
            if (string.IsNullOrEmpty(logFilePath)) return;

            try
            {
                Directory.CreateDirectory(Path.GetDirectoryName(logFilePath));
                File.AppendAllText(logFilePath,
                    $"{DateTime.Now:yyyy-MM-dd HH:mm:ss} - ERROR: {filePath} - {ex.Message}{Environment.NewLine}");
            }
            catch
            {
                // Ignore log errors
            }
        }
    }
}