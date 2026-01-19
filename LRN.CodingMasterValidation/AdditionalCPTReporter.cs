using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;

namespace LRN.CodingMasterValidation
{
    public class AdditionalCPTReporter
    {
        private readonly string _outputDirectory;

        public AdditionalCPTReporter(string outputDirectory)
        {
            _outputDirectory = outputDirectory;
        }


        public void Execute(List<ValidationResult> validationResults)
        {
            Console.WriteLine("\n" + "=".PadRight(60, '='));
            Console.WriteLine("STEP 4: GENERATE ADDITIONAL CPT REPORT");
            Console.WriteLine("=".PadRight(60, '='));

            try
            {
                string timestamp = DateTime.Now.ToString("yyyyMMdd_HHmmss");
                string outputFile = Path.Combine(_outputDirectory, $"Additional_CPT_Codes_Report_{timestamp}.csv");

                // Filter records with additional CPTs
                var recordsWithAdditional = validationResults
                    .Where(r => r.HasMatch && r.AdditionalCPTCodes.Any())
                    .ToList();

                Console.WriteLine($"🔍 Found {recordsWithAdditional.Count} records with additional CPT codes");

                GenerateReport(recordsWithAdditional, outputFile);
            }
            catch (Exception ex)
            {
                Console.WriteLine($"❌ Error in Step 4: {ex.Message}");
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
                writer.WriteLine("VisitNumber,PanelName,Carrier,ActualCPTCodes,ExpectedCPTCodes,AdditionalCPTCodes,AdditionalCount");

                foreach (var result in results)
                {
                    //var additionalCodes = result.AdditionalCPTCodes
                    //    .Select(kvp => $"{kvp.Key}*{kvp.Value}")
                    //    .ToList();

                    var additionalCodes = result.AdditionalCPTCodes
                              .Where(kvp => !string.IsNullOrWhiteSpace(kvp.Key)) // 🔥 removes (blank)
                              .Select(kvp => kvp.Key)
                              .ToList();



                    int totalAdditional = result.AdditionalCPTCodes.Sum(kvp => kvp.Value);

                    writer.WriteLine(
                        $"\"{EscapeCsvField(result.ProductionRecord.VisitNumber)}\"," +
                        $"\"{EscapeCsvField(result.ProductionRecord.PanelName)}\"," +
                        $"\"{EscapeCsvField(result.ProductionRecord.Carrier)}\"," +
                        $"\"{EscapeCsvField(result.ProductionRecord.ActualCPTCode)}\"," +
                        $"\"{EscapeCsvField(string.Join(", ", result.ExpectedCPTCodes))}\"," +
                        $"\"{EscapeCsvField(string.Join(", ", additionalCodes))}\"," +
                        $"\"{totalAdditional}\""
                    );
                }
            }

            Console.WriteLine($"📄 Additional CPT report saved: {outputPath}");
            Console.WriteLine($"   Total records with additional codes: {results.Count}");

            // Calculate summary
            int totalAdditionalCodes = results.Sum(r => r.AdditionalCPTCodes.Sum(kvp => kvp.Value));
            Console.WriteLine($"   Total additional code instances: {totalAdditionalCodes}");
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