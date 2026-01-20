using DocumentFormat.OpenXml.Spreadsheet;
using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;

namespace LRN.CodingMasterValidation
{
    public class PanelSummaryGenerator
    {
        private readonly string _outputDirectory;

        public PanelSummaryGenerator(string outputDirectory = null)
        {
            _outputDirectory = outputDirectory ?? @"C:\LRN-Data\CodingMaster\Outputs";
        }

        // Keep original codes with their quantities, just format them consistently
        private string FormatOriginalCodes(string codeString)
        {
            if (string.IsNullOrWhiteSpace(codeString) ||
                codeString.Contains("(blank)") ||
                codeString.Trim() == "")
                return "";

            var codeList = new List<string>();

            var entries = codeString.Split(new[] { ',' }, StringSplitOptions.RemoveEmptyEntries);

            foreach (var entry in entries)
            {
                var trimmed = entry.Trim();

                // Check if it has quantity (*n)
                int starIndex = trimmed.LastIndexOf('*');
                if (starIndex > 0)
                {
                    // Has quantity, keep as-is
                    codeList.Add(trimmed);
                }
                else
                {
                    // No quantity, add *1
                    codeList.Add($"{trimmed}*1");
                }
            }

            // Return sorted and deduplicated
            return string.Join(", ", codeList
                .Distinct()
                .OrderBy(c => c));
        }

        // For Missing/Additional combos: show codes with their original quantities
        private string GetMissingAdditionalCombo(IEnumerable<CsvRecord> records, Func<CsvRecord, string> codeSelector)
        {
            var codeQuantities = new Dictionary<string, int>();
            var foundRecords = new List<CsvRecord>();

            // First, find all records that have codes
            foreach (var record in records)
            {
                var codeString = codeSelector(record);
                if (!string.IsNullOrWhiteSpace(codeString) &&
                    !codeString.Contains("(blank)") &&
                    codeString.Trim() != "")
                {
                    foundRecords.Add(record);
                }
            }

            // If we found records, use the first record's codes with their original quantities
            if (foundRecords.Count > 0)
            {
                var firstRecord = foundRecords[0];
                var codeString = codeSelector(firstRecord);
                return FormatOriginalCodes(codeString);
            }

            return "";
        }

        // Count total units from a CPT string
        private int CountTotalUnits(string codeString)
        {
            if (string.IsNullOrWhiteSpace(codeString) ||
                codeString.Contains("(blank)") ||
                codeString.Trim() == "")
                return 0;

            int totalUnits = 0;
            var entries = codeString.Split(new[] { ',' }, StringSplitOptions.RemoveEmptyEntries);

            foreach (var entry in entries)
            {
                var trimmed = entry.Trim();
                int starIndex = trimmed.LastIndexOf('*');

                if (starIndex > 0)
                {
                    // Has quantity, parse it
                    var countPart = trimmed.Substring(starIndex + 1).Trim();
                    if (int.TryParse(countPart, out int count))
                    {
                        totalUnits += count;
                    }
                }
                else
                {
                    // No quantity specified, assume 1
                    totalUnits++;
                }
            }

            return totalUnits;
        }

        public void GeneratePanelSummaryFromCsv(string csvFilePath)
        {
            Console.WriteLine("\n" + "=".PadRight(60, '='));
            Console.WriteLine("PANEL-LEVEL SUMMARY REPORT FROM CSV");
            Console.WriteLine("=".PadRight(60, '='));

            try
            {
                var records = ParseCsvFile(csvFilePath);

                bool isPCRAL = csvFilePath.Contains(@"\PCRAL\", StringComparison.OrdinalIgnoreCase);



                // Group by PanelName, ExpectedCPTCode, AND ActualCPTCode
                //var panelCombinationGroups = records
                //    .Where(r => !string.IsNullOrEmpty(r.ExpectedCPTCode) &&
                //                !string.IsNullOrEmpty(r.PanelName))
                //    .GroupBy(r => new PanelExpectedActualComboKey
                //    {
                //        PanelName = r.PanelName,
                //        ExpectedCPTCode = FormatOriginalCodes(r.ExpectedCPTCode),
                //        ActualCPTCode = FormatOriginalCodes(r.ActualCPTCode)
                //    })
                //    .ToList();

                var panelCombinationGroups = records
                  .Where(r => !string.IsNullOrEmpty(r.ExpectedCPTCode) &&
                              !string.IsNullOrEmpty(r.PanelName))
                  .GroupBy(r => new PanelExpectedActualComboKey
                  {
                      // PanelName =isPCRAL && !string.IsNullOrWhiteSpace(r.Panel1)
                      //? r.Panel1: r.PanelName,
                      PanelName = r.PanelName,
                      ExpectedCPTCode = FormatOriginalCodes(r.ExpectedCPTCode),
                      ActualCPTCode = FormatOriginalCodes(r.ActualCPTCode)
                  })
                  .ToList();

                Console.WriteLine($"✅ Found {panelCombinationGroups.Count} unique panel combinations");

                string timestamp = DateTime.Now.ToString("yyyyMMdd_HHmmss");
                string outputFile = Path.Combine(_outputDirectory, $"Panel_Summary_Report_{timestamp}.csv");

                GeneratePanelSummaryReport(panelCombinationGroups, outputFile);
            }
            catch (Exception ex)
            {
                Console.WriteLine($"❌ Error generating panel summary: {ex.Message}");
                Console.WriteLine($"Stack Trace: {ex.StackTrace}");
            }
        }

        private List<CsvRecord> ParseCsvFile(string filePath)
        {
            var records = new List<CsvRecord>();

            using (var reader = new StreamReader(filePath))
            {
                // Skip header
                reader.ReadLine();

                while (!reader.EndOfStream)
                {
                    var line = reader.ReadLine();
                    if (string.IsNullOrWhiteSpace(line))
                        continue;

                    var record = ParseCsvLine(line);
                    if (record != null)
                        records.Add(record);
                }
            }

            return records;
        }

        private CsvRecord ParseCsvLine(string line)
        {
            var fields = ParseCsvFields(line);

            // Your CSV has 13 columns including Remarks
            if (fields.Count < 9) // Need at least up to Additional Charge
                return null;

            return new CsvRecord
            {
                VisitNumber = fields[0].Trim('"'),
                AccessionNo = fields[1].Trim('"'),
                PanelName = fields[2].Trim('"'),
                Carrier = fields[3].Trim('"'),
                ActualCPTCode = fields[4].Trim('"'),
                ExpectedCPTCode = fields[5].Trim('"'),
                MissingCPTCodes = fields[6].Trim('"'),
                AdditionalCPTCodes = fields[7].Trim('"'),
                MissingCharge = SafeParseDecimal(fields[8]),
                AdditionalCharge = SafeParseDecimal(fields.Count > 9 ? fields[9] : "0"),
                TotalCharge = fields.Count > 10 ? SafeParseDecimal(fields[10]) : 0,
                ExpectedCharges = fields.Count > 11 ? SafeParseDecimal(fields[11]) : 0,
                Panel1 = fields.Last().Trim('"')   // ✅ NEW (last column)
            };
        }

        private decimal SafeParseDecimal(string value)
        {
            if (string.IsNullOrWhiteSpace(value))
                return 0;

            value = value.Trim('"', ' ', '$', ',');
            return decimal.TryParse(value, out decimal result) ? result : 0;
        }

        private List<string> ParseCsvFields(string line)
        {
            var fields = new List<string>();
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
                    fields.Add(currentField);
                    currentField = "";
                }
                else
                {
                    currentField += currentChar;
                }
            }

            // Add the last field
            fields.Add(currentField);

            return fields;
        }

        //private void GeneratePanelSummaryReport(
        //    List<IGrouping<PanelExpectedActualComboKey, CsvRecord>> panelGroups,
        //    string outputPath)
        //{
        //    var directory = Path.GetDirectoryName(outputPath);
        //    if (!Directory.Exists(directory))
        //        Directory.CreateDirectory(directory);

        //    using (var writer = new StreamWriter(outputPath))
        //    {
        //        // Header
        //        writer.WriteLine(
        //            "Panel,Expected CPT Combo,Actual CPT Combo,Missing CPT Combo,Additional CPT Combo," +
        //            "Count of Missing Amount,Sum of Missing Amount ($),Count of Additional Amount,Sum of Additional Amount ($)");

        //        int totalCombinations = 0;

        //        foreach (var group in panelGroups
        //            .OrderBy(g => g.Key.PanelName)
        //            .ThenBy(g => g.Key.ExpectedCPTCode)
        //            .ThenBy(g => g.Key.ActualCPTCode))
        //        {
        //            var panelName = group.Key.PanelName;
        //            var expectedCombo = group.Key.ExpectedCPTCode;  // Keep original quantities
        //            var actualCombo = group.Key.ActualCPTCode;      // Keep original quantities

        //            var records = group.ToList();

        //            // Get Missing and Additional combos - use first record's values
        //            string missingCombo = GetMissingAdditionalCombo(records, r => r.MissingCPTCodes);
        //            string additionalCombo = GetMissingAdditionalCombo(records, r => r.AdditionalCPTCodes);

        //            // Calculate counts and sums - these are aggregates
        //            int countMissingAmount = records.Sum(r => CountTotalUnits(r.MissingCPTCodes));
        //            int countAdditionalAmount = records.Sum(r => CountTotalUnits(r.AdditionalCPTCodes));

        //            decimal sumMissingAmount = records.Sum(r => r.MissingCharge);
        //            decimal sumAdditionalAmount = records.Sum(r => r.AdditionalCharge);

        //            // Format currency with comma separators
        //            string formattedSumMissing = sumMissingAmount.ToString("C2");
        //            string formattedSumAdditional = sumAdditionalAmount.ToString("C2");

        //            writer.WriteLine(
        //                $"{EscapeCsvField(panelName)}," +
        //                $"{EscapeCsvField(expectedCombo)}," +
        //                $"{EscapeCsvField(actualCombo)}," +
        //                $"{EscapeCsvField(missingCombo)}," +
        //                $"{EscapeCsvField(additionalCombo)}," +
        //                $"{countMissingAmount}," +
        //                $"{formattedSumMissing}," +
        //                $"{countAdditionalAmount}," +
        //                $"{formattedSumAdditional}"
        //            );

        //            totalCombinations++;

        //            if (totalCombinations % 10 == 0)
        //                Console.Write(".");
        //        }

        //        Console.WriteLine();
        //        Console.WriteLine($"📄 Panel summary report saved: {outputPath}");
        //        Console.WriteLine($"📊 Total panel combinations analyzed: {totalCombinations}");
        //    }
        //}


        private void GeneratePanelSummaryReport(
     List<IGrouping<PanelExpectedActualComboKey, CsvRecord>> panelGroups,
     string outputPath)
        {
            var directory = Path.GetDirectoryName(outputPath);
            if (!Directory.Exists(directory))
                Directory.CreateDirectory(directory);

            using (var writer = new StreamWriter(outputPath))
            {
                // Header
                writer.WriteLine(
                    "Panel,Expected CPT Combo,Actual CPT Combo,Missing CPT Combo,Additional CPT Combo," +
                    "Count of Missing Amount,Sum of Missing Amount ($),Count of Additional Amount,Sum of Additional Amount ($)");

                int totalCombinations = 0;

                foreach (var group in panelGroups
                    .OrderBy(g => g.Key.PanelName)
                    .ThenBy(g => g.Key.ExpectedCPTCode)
                    .ThenBy(g => g.Key.ActualCPTCode))
                {
                    var panelName = group.Key.PanelName;
                    var expectedCombo = group.Key.ExpectedCPTCode;  // Keep original quantities
                    var actualCombo = group.Key.ActualCPTCode;      // Keep original quantities

                    var records = group.ToList();

                    // Get Missing and Additional combos - use first record's values
                    string missingCombo = GetMissingAdditionalCombo(records, r => r.MissingCPTCodes);
                    string additionalCombo = GetMissingAdditionalCombo(records, r => r.AdditionalCPTCodes);



                    // NEW: Count of claims with missing codes (not total units)
                    int countMissingAmount = records.Count(r =>
                        !string.IsNullOrWhiteSpace(r.MissingCPTCodes) &&
                        !r.MissingCPTCodes.Contains("(blank)") &&
                        r.MissingCPTCodes.Trim() != "");

                    // NEW: Count of claims with additional codes (not total units)
                    int countAdditionalAmount = records.Count(r =>
                        !string.IsNullOrWhiteSpace(r.AdditionalCPTCodes) &&
                        !r.AdditionalCPTCodes.Contains("(blank)") &&
                        r.AdditionalCPTCodes.Trim() != "");

                    decimal sumMissingAmount = records.Sum(r => r.MissingCharge);
                    decimal sumAdditionalAmount = records.Sum(r => r.AdditionalCharge);

                    bool hasMissing = countMissingAmount > 0 && !string.IsNullOrWhiteSpace(missingCombo);

                    bool hasAdditional = countAdditionalAmount > 0 && !string.IsNullOrWhiteSpace(additionalCombo);

                    // ❌ Skip rows where both Missing and Additional CPTs are zero
                    if (!hasMissing && !hasAdditional)
                    {
                        continue; //🚫 DO NOT ADD THIS ROW
                    }


                    // Format currency
                    string formattedSumMissing = sumMissingAmount == 0 ? "$0.00" : $"${sumMissingAmount:F2}";
                    string formattedSumAdditional = sumAdditionalAmount == 0 ? "$0.00" : $"${sumAdditionalAmount:F2}";

                    writer.WriteLine(
                        $"{EscapeCsvField(panelName)}," +
                        $"{EscapeCsvField(expectedCombo)}," +
                        $"{EscapeCsvField(actualCombo)}," +
                        $"{EscapeCsvField(missingCombo)}," +
                        $"{EscapeCsvField(additionalCombo)}," +
                        $"{countMissingAmount}," +
                        $"{formattedSumMissing}," +
                        $"{countAdditionalAmount}," +
                        $"{formattedSumAdditional}"
                    );

                    totalCombinations++;

                    if (totalCombinations % 10 == 0)
                        Console.Write(".");
                }

                Console.WriteLine();
                Console.WriteLine($"📄 Panel summary report saved: {outputPath}");
                Console.WriteLine($"📊 Total panel combinations analyzed: {totalCombinations}");
            }
        }
        private string EscapeCsvField(string field)
        {
            if (string.IsNullOrEmpty(field))
                return "";

            // Add quotes if field contains commas or is empty
            if (field.Contains(",") || field.Contains("\"") || string.IsNullOrWhiteSpace(field))
            {
                return $"\"{field.Replace("\"", "\"\"")}\"";
            }

            return field;
        }

        // Helper class for grouping
        private class PanelExpectedActualComboKey : IEquatable<PanelExpectedActualComboKey>
        {
            public string PanelName { get; set; }
            public string ExpectedCPTCode { get; set; }
            public string ActualCPTCode { get; set; }

            public bool Equals(PanelExpectedActualComboKey other)
            {
                if (other is null) return false;
                if (ReferenceEquals(this, other)) return true;
                return string.Equals(PanelName, other.PanelName, StringComparison.OrdinalIgnoreCase) &&
                       string.Equals(ExpectedCPTCode, other.ExpectedCPTCode, StringComparison.OrdinalIgnoreCase) &&
                       string.Equals(ActualCPTCode, other.ActualCPTCode, StringComparison.OrdinalIgnoreCase);
            }

            public override bool Equals(object obj) => Equals(obj as PanelExpectedActualComboKey);

            public override int GetHashCode()
            {
                unchecked
                {
                    int hash = 17;
                    hash = hash * 23 + (PanelName?.ToLowerInvariant()?.GetHashCode() ?? 0);
                    hash = hash * 23 + (ExpectedCPTCode?.ToLowerInvariant()?.GetHashCode() ?? 0);
                    hash = hash * 23 + (ActualCPTCode?.ToLowerInvariant()?.GetHashCode() ?? 0);
                    return hash;
                }
            }
        }

        // Record class
        private class CsvRecord
        {
            public string VisitNumber { get; set; }
            public string AccessionNo { get; set; }
            public string PanelName { get; set; }

            public string Panel1 { get; set; }
            public string Carrier { get; set; }
            public string ActualCPTCode { get; set; }
            public string ExpectedCPTCode { get; set; }
            public string MissingCPTCodes { get; set; }
            public string AdditionalCPTCodes { get; set; }
            public decimal MissingCharge { get; set; }
            public decimal AdditionalCharge { get; set; }
            public decimal TotalCharge { get; set; }
            public decimal ExpectedCharges { get; set; }
        }
    }
}