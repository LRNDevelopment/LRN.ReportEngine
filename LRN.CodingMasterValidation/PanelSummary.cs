using System;
using System.Collections.Generic;
using System.Globalization;
using System.IO;
using System.Linq;

namespace LRN.CodingMasterValidation
{
    public class PanelSummary
    {
        public void Generate(string enhancedCsvPath, string outputPath)
        {
            var lines = File.ReadAllLines(enhancedCsvPath);
            if (lines.Length <= 1)
                return;

            var headers = ParseCsvLine(lines[0]);

            // Debug: Print all headers to see what's available
            Console.WriteLine("Available headers in CSV:");
            for (int i = 0; i < headers.Count; i++)
            {
                Console.WriteLine($"{i}: '{headers[i]}'");
            }

            int panelIdx = GetIndex(headers, "PanelName", "Panel", "Panel Name");

            int expectedIdx = GetIndex(
                headers,
                "ExpectedCPTCodes",
                "Expected CPT Codes",
                "Expected CPT Combo",
                "ExpectedCPTCombo",
                "ExpectedCodes",
                "Expected CPT",
                "ExpectedCPT"
            );

            int actualIdx = GetIndex(
                headers,
                "ActualCPTCode",
                "Actual CPT Code",
                "Actual CPT Combo",
                "ActualCPTCombo",
                "ActualCodes",
                "Actual CPT",
                "ActualCPT"
            );

            int missingIdx = GetIndex(
                headers,
                "MissingCPTCodes",
                "Missing CPT Codes",
                "Missing CPT Combo",
                "MissingCPTCombo",
                "MissingCodes",
                "Missing CPT",
                "MissingCPT"
            );

            int additionalIdx = GetIndex(
                headers,
                "AdditionalCPTCodes",
                "Additional CPT Codes",
                "Additional CPT Combo",
                "AdditionalCPTCombo",
                "AdditionalCodes",
                "Additional CPT",
                "AdditionalCPT"
            );

            int missingAmtIdx = GetIndex(
                headers,
                "Missing Amount",
                "MissingCPTCharge",
                "Missing Charge",
                "MissingAmount",
                "Missing_Amount",
                "Missing Cost",
                "MissingCost",
                "Missing_Charge"
            );

            int additionalAmtIdx = GetIndex(
                headers,
                "Additional Amount",
                "AdditionalCPTCharge",
                "Additional Charge",
                "AdditionalAmount",
                "Additional_Amount",
                "Additional Cost",
                "AdditionalCost",
                "Additional_Charge"
            );

            // Check if we found the columns
            var foundIndexes = new Dictionary<string, int>
            {
                { "PanelName", panelIdx },
                { "ExpectedCPTCodes", expectedIdx },
                { "ActualCPTCode", actualIdx },
                { "MissingCPTCodes", missingIdx },
                { "AdditionalCPTCodes", additionalIdx },
                { "Missing Amount", missingAmtIdx },
                { "Additional Amount", additionalAmtIdx }
            };

            // Debug: Print what we found
            Console.WriteLine("\nFound columns:");
            foreach (var kvp in foundIndexes)
            {
                Console.WriteLine($"{kvp.Key}: Index {kvp.Value} ({(kvp.Value >= 0 ? "FOUND" : "NOT FOUND")})");
            }

            var missingHeaders = foundIndexes
                .Where(kvp => kvp.Value < 0)
                .Select(kvp => kvp.Key)
                .ToList();

            if (missingHeaders.Any())
            {
                throw new Exception(
                    "Panel Summary failed. Missing columns in Enhanced CSV: " +
                    string.Join(", ", missingHeaders) +
                    "\nAvailable columns: " + string.Join(", ", headers)
                );
            }

            var records = new List<Row>();

            for (int i = 1; i < lines.Length; i++)
            {
                var v = ParseCsvLine(lines[i]);

                records.Add(new Row
                {
                    Panel = GetValue(v, panelIdx),
                    Expected = NormalizeCombo(GetValue(v, expectedIdx)),
                    Actual = NormalizeCombo(GetValue(v, actualIdx)),
                    Missing = NormalizeCombo(GetValue(v, missingIdx)),
                    Additional = NormalizeCombo(GetValue(v, additionalIdx)),
                    MissingAmount = SafeDecimal(GetValue(v, missingAmtIdx)),
                    AdditionalAmount = SafeDecimal(GetValue(v, additionalAmtIdx))
                });
            }

            // Group by Panel, Expected CPT Combo, and Actual CPT Combo
            var groups = records
                .Where(r => !string.IsNullOrEmpty(r.Panel)) // Filter out empty panels
                .GroupBy(r => new
                {
                    r.Panel,
                    r.Expected,
                    r.Actual
                })
                .OrderBy(g => g.Key.Panel)
                .ThenBy(g => g.Key.Expected)
                .ThenBy(g => g.Key.Actual);

            using var writer = new StreamWriter(outputPath);

            writer.WriteLine(
                "Panel,Expected CPT Combo,Actual CPT Combo,Missing CPT Combo,Additional CPT Combo," +
                "Count of Missing Amount,Sum of Missing Amount ($)," +
                "Count of Additional Amount,Sum of Additional Amount ($)"
            );

            foreach (var g in groups)
            {
                // Calculate missing and additional CPT units (counts)
                var missingUnits = g.Sum(x => CountUnits(x.Missing));
                var additionalUnits = g.Sum(x => CountUnits(x.Additional));

                // Get DISTINCT Missing and Additional CPT combos for this group
                var missingCombo = GetDistinctCombos(g.Select(x => x.Missing));
                var additionalCombo = GetDistinctCombos(g.Select(x => x.Additional));

                // Calculate sums of amounts
                var missingAmountSum = g.Sum(x => x.MissingAmount);
                var additionalAmountSum = g.Sum(x => x.AdditionalAmount);

                writer.WriteLine(
                    $"\"{g.Key.Panel}\"," +
                    $"\"{g.Key.Expected}\"," +
                    $"\"{g.Key.Actual}\"," +
                    $"\"{missingCombo}\"," +
                    $"\"{additionalCombo}\"," +
                    $"{missingUnits}," +
                    $"${missingAmountSum:F2}," +
                    $"{additionalUnits}," +
                    $"${additionalAmountSum:F2}"
                );
            }
        }

        // ---------- HELPERS ----------
        private static string GetValue(List<string> row, int index)
        {
            return index >= 0 && index < row.Count
                ? row[index]
                : string.Empty;
        }

        private class Row
        {
            public string Panel;
            public string Expected;
            public string Actual;
            public string Missing;
            public string Additional;
            public decimal MissingAmount;
            public decimal AdditionalAmount;
        }

        private static int GetIndex(List<string> headers, params string[] possibleNames)
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

        private static List<string> ParseCsvLine(string line)
        {
            var result = new List<string>();
            bool inQuotes = false;
            var current = "";

            foreach (char c in line)
            {
                if (c == '"')
                {
                    inQuotes = !inQuotes;
                }
                else if (c == ',' && !inQuotes)
                {
                    result.Add(current.Trim());
                    current = "";
                }
                else
                {
                    current += c;
                }
            }
            result.Add(current.Trim());
            return result;
        }

        private static string NormalizeCombo(string raw)
        {
            if (string.IsNullOrWhiteSpace(raw))
                return "";

            var set = new HashSet<string>(StringComparer.OrdinalIgnoreCase);

            foreach (var part in raw.Split(',', StringSplitOptions.RemoveEmptyEntries))
            {
                var p = part.Trim();
                int idx = p.LastIndexOf('*');
                if (idx > 0)
                {
                    // Has quantity, keep as-is
                    set.Add(p);
                }
                else
                {
                    // No quantity, add *1
                    set.Add($"{p}*1");
                }
            }

            return string.Join(", ", set.OrderBy(x => x));
        }

        private static string GetDistinctCombos(IEnumerable<string> combos)
        {
            var allCodes = new HashSet<string>(StringComparer.OrdinalIgnoreCase);

            foreach (var combo in combos)
            {
                if (!string.IsNullOrWhiteSpace(combo))
                {
                    foreach (var part in combo.Split(',', StringSplitOptions.RemoveEmptyEntries))
                    {
                        allCodes.Add(part.Trim());
                    }
                }
            }

            return string.Join(", ", allCodes.OrderBy(x => x));
        }

        private static int CountUnits(string raw)
        {
            if (string.IsNullOrWhiteSpace(raw))
                return 0;

            int total = 0;

            foreach (var part in raw.Split(',', StringSplitOptions.RemoveEmptyEntries))
            {
                var p = part.Trim();
                int idx = p.LastIndexOf('*');
                if (idx > 0 && int.TryParse(p[(idx + 1)..], out int u))
                    total += u;
            }
            return total;
        }

        private static decimal SafeDecimal(string input)
        {
            if (string.IsNullOrWhiteSpace(input))
                return 0;

            input = input.Replace("$", "").Replace(",", "").Trim();

            // Try parsing with invariant culture first
            if (decimal.TryParse(input, NumberStyles.Any, CultureInfo.InvariantCulture, out var v))
                return v;

            // Try with current culture
            if (decimal.TryParse(input, NumberStyles.Any, CultureInfo.CurrentCulture, out v))
                return v;

            return 0;
        }
    }
}