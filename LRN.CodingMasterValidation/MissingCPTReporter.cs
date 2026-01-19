using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;

namespace LRN.CodingMasterValidation
{
    public class MissingCPTReporter
    {
        private readonly string _outputDirectory;

        public MissingCPTReporter(string outputDirectory)
        {
            _outputDirectory = outputDirectory;
        }


        public void Execute(List<ValidationResult> validationResults)
        {
            Console.WriteLine("\n" + "=".PadRight(60, '='));
            Console.WriteLine("STEP 3: GENERATE MISSING CPT REPORT");
            Console.WriteLine("=".PadRight(60, '='));

            try
            {
                string timestamp = DateTime.Now.ToString("yyyyMMdd_HHmmss");
                string outputFile = Path.Combine(_outputDirectory, $"Missing_CPT_Codes_Report_{timestamp}.csv");

                // Filter records with missing CPTs
                var recordsWithMissing = validationResults
                    .Where(r => r.HasMatch && r.MissingCPTCodes.Any())
                    .ToList();

                Console.WriteLine($"🔍 Found {recordsWithMissing.Count} records with missing CPT codes");

                GenerateReport(recordsWithMissing, outputFile);
            }
            catch (Exception ex)
            {
                Console.WriteLine($"❌ Error in Step 3: {ex.Message}");
                Console.WriteLine($"Stack Trace: {ex.StackTrace}");
            }
        }

        private void GenerateReport(List<ValidationResult> results, string outputPath)
        {
            // Ensure output directory exists
            var directory = Path.GetDirectoryName(outputPath);
            if (!Directory.Exists(directory))
            {
                Directory.CreateDirectory(directory);
                Console.WriteLine($"📁 Created directory: {directory}");
            }

            using (var writer = new StreamWriter(outputPath))
            {
                writer.WriteLine("VisitNumber,PanelName,Carrier,ActualCPTCodes,ExpectedCPTCodes,MissingCPTCodes,MissingCount");

                foreach (var result in results)
                {
                    //var missingCodes = result.MissingCPTCodes
                    //    .Select(kvp => $"{kvp.Key}*{kvp.Value}")
                    //    .ToList();

                    //var missingCodes = result.MissingCPTCodes
                    //     .Select(kvp => kvp.Key)
                    //    .ToList();

                    var missingCodes = result.MissingCPTCodes
                            .Where(kvp => !string.IsNullOrWhiteSpace(kvp.Key)) // 🔥 removes (blank)
                            .Select(kvp => kvp.Key)
                            .ToList();


                    int totalMissing = result.MissingCPTCodes.Sum(kvp => kvp.Value);

                    writer.WriteLine(
                        $"\"{EscapeCsvField(result.ProductionRecord.VisitNumber)}\"," +
                        $"\"{EscapeCsvField(result.ProductionRecord.PanelName)}\"," +
                        $"\"{EscapeCsvField(result.ProductionRecord.Carrier)}\"," +
                        $"\"{EscapeCsvField(result.ProductionRecord.ActualCPTCode)}\"," +
                        $"\"{EscapeCsvField(string.Join(", ", result.ExpectedCPTCodes))}\"," +
                        $"\"{EscapeCsvField(string.Join(", ", missingCodes))}\"," +
                        $"\"{totalMissing}\""
                    );
                }
            }

            Console.WriteLine($"📄 Missing CPT report saved: {outputPath}");
            Console.WriteLine($"   Total records with missing codes: {results.Count}");

            // Calculate summary
            int totalMissingCodes = results.Sum(r => r.MissingCPTCodes.Sum(kvp => kvp.Value));
            Console.WriteLine($"   Total missing code instances: {totalMissingCodes}");
        }

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
    }
}