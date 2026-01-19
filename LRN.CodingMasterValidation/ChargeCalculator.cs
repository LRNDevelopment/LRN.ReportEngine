using Microsoft.Extensions.Configuration;
using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Text;

namespace LRN.CodingMasterValidation
{
    public class ChargeCalculator
    {
        private readonly FeeScheduleLoader _feeScheduleLoader;
        private Dictionary<(string PayerCommonCode, string PayerName, string CPT), PayerCptAvg> _payerCptAvgMap;
        private readonly DateTime _cutoffDate = new DateTime(2025, 1, 1);

        public ChargeCalculator(LabContext lab, IConfiguration configuration = null)
        {
            _feeScheduleLoader = new FeeScheduleLoader(lab.FeeSchedulePath);
        }

        public class CPTDetail
        {
            public string Code { get; set; }
            public string Modifier { get; set; }
            public int Units { get; set; }
            public decimal BilledCharge { get; set; }
            public decimal MedicareAllowable { get; set; }
            public decimal TotalCharge => BilledCharge * Units;
            public decimal TotalMedicare => MedicareAllowable * Units;
        }

        // ============ DATE-AWARE CHARGE METHODS ============

        private bool UseBilledCharges(DateTime? serviceDate)
        {
            if (!serviceDate.HasValue)
                return true; // Default to billed charges if no date

            //return serviceDate.Value > _cutoffDate;

            return serviceDate.Value > _cutoffDate;
        }

        private decimal GetDateAwareCharge(string cptCode, DateTime? serviceDate)
        {
            if (UseBilledCharges(serviceDate))
                return _feeScheduleLoader.GetBilledCharge(cptCode);
            else
                return _feeScheduleLoader.GetMedicareAllowable(cptCode);
        }

        private string GetChargeSourceType(DateTime? serviceDate)
        {
            return !UseBilledCharges(serviceDate) ? "Billed" : "Medicare";
           // return UseBilledCharges(serviceDate) ?  "Medicare": "Billed";
        }

        // ============ GET CHARGE SOURCE SUMMARY ============

        public string GetChargeSourceSummary(Dictionary<string, int> cptCodes, DateTime? serviceDate)
        {
            if (cptCodes == null || cptCodes.Count == 0)
                return "No CPT codes";

            string chargeType = GetChargeSourceType(serviceDate);
            return $"{chargeType} Charges";
        }

        // ============ DATE-AWARE CHARGE CALCULATIONS ============

        public decimal CalculateTotalChargeForMissingCPTs(Dictionary<string, int> missingCPTCodes, DateTime? serviceDate)
        {
            decimal total = 0;

            if (missingCPTCodes == null)
                return total;

            foreach (var kvp in missingCPTCodes)
            {
                string baseCpt = ExtractBaseCPTCode(kvp.Key);
                int units = kvp.Value;

                if (string.IsNullOrWhiteSpace(baseCpt) || units <= 0)
                    continue;

                decimal chargePerUnit = GetDateAwareCharge(baseCpt, serviceDate);
                total += chargePerUnit * units;
            }

            return total;
        }

        public decimal CalculateTotalChargeForAdditionalCPTs(Dictionary<string, int> additionalCPTCodes, DateTime? serviceDate)
        {
            decimal total = 0;

            if (additionalCPTCodes == null)
                return total;

            foreach (var kvp in additionalCPTCodes)
            {
                string baseCpt = ExtractBaseCPTCode(kvp.Key);
                int units = kvp.Value;

                if (string.IsNullOrWhiteSpace(baseCpt) || units <= 0)
                    continue;

                decimal chargePerUnit = GetDateAwareCharge(baseCpt, serviceDate);
                total += chargePerUnit * units;
            }

            return total;
        }

        public decimal CalculateExpectedCharges(string expectedCPTCode, DateTime? serviceDate)
        {
            decimal total = 0;

            if (string.IsNullOrWhiteSpace(expectedCPTCode))
                return total;

            var details = ParseCPTString(expectedCPTCode);
            foreach (var detail in details)
            {
                decimal chargePerUnit = GetDateAwareCharge(detail.Code, serviceDate);
                total += chargePerUnit * detail.Units;
            }

            return total;
        }

        // ============ ORIGINAL METHODS (for backward compatibility) ============

        public decimal CalculateTotalChargeForMissingCPTs(Dictionary<string, int> missingCPTCodes)
        {
            return CalculateTotalChargeForMissingCPTs(missingCPTCodes, null);
        }

        public decimal CalculateTotalChargeForAdditionalCPTs(Dictionary<string, int> additionalCPTCodes)
        {
            return CalculateTotalChargeForAdditionalCPTs(additionalCPTCodes, null);
        }

        public decimal CalculateExpectedCharges(string expectedCPTCode)
        {
            return CalculateExpectedCharges(expectedCPTCode, null);
        }

        // ============ HELPER METHODS ============

        private string ExtractBaseCPTCode(string cptWithModifier)
        {
            if (string.IsNullOrWhiteSpace(cptWithModifier))
                return cptWithModifier;

            // Remove modifier if present (e.g., "81408-XU" → "81408")
            int dashIndex = cptWithModifier.IndexOf('-');
            if (dashIndex > 0)
                return cptWithModifier.Substring(0, dashIndex);

            return cptWithModifier;
        }

        public List<CPTDetail> ParseCPTString(string cptString)
        {
            var details = new List<CPTDetail>();

            if (string.IsNullOrWhiteSpace(cptString))
                return details;

            var items = cptString.Split(',', StringSplitOptions.RemoveEmptyEntries);

            foreach (var item in items)
            {
                try
                {
                    var detail = ParseCPTItem(item.Trim());
                    if (detail != null)
                        details.Add(detail);
                }
                catch (Exception ex)
                {
                    Console.WriteLine($"⚠️ Error parsing CPT item '{item}': {ex.Message}");
                }
            }

            return details;
        }

        private CPTDetail ParseCPTItem(string cptItem)
        {
            string code = cptItem;
            string modifier = "";
            int units = 1;

            // Check for units (*)
            int unitIndex = code.IndexOf('*');
            if (unitIndex > 0)
            {
                string unitStr = code.Substring(unitIndex + 1);
                if (int.TryParse(unitStr, out int parsedUnits))
                    units = parsedUnits;
                code = code.Substring(0, unitIndex);
            }

            // Check for modifier (-)
            int modifierIndex = code.IndexOf('-');
            if (modifierIndex > 0)
            {
                modifier = code.Substring(modifierIndex + 1);
                code = code.Substring(0, modifierIndex);
            }

            return new CPTDetail
            {
                Code = code,
                Modifier = modifier,
                Units = units,
                BilledCharge = _feeScheduleLoader.GetBilledCharge(code),
                MedicareAllowable = _feeScheduleLoader.GetMedicareAllowable(code)
            };
        }

        // ============ DETAILED INFO METHODS ============

        public string GetMissingCPTDetails(Dictionary<string, int> missingCPTCodes)
        {
            return GetCPTDetailsString(missingCPTCodes, null);
        }

        public string GetAdditionalCPTDetails(Dictionary<string, int> additionalCPTCodes)
        {
            return GetCPTDetailsString(additionalCPTCodes, null);
        }

        private string GetCPTDetailsString(Dictionary<string, int> cptCodes, DateTime? serviceDate)
        {
            if (cptCodes == null || cptCodes.Count == 0)
                return "";

            var details = new List<string>();
            string chargeType = GetChargeSourceType(serviceDate);

            foreach (var kvp in cptCodes)
            {
                string baseCpt = ExtractBaseCPTCode(kvp.Key);
                decimal charge = GetDateAwareCharge(baseCpt, serviceDate);
                decimal total = charge * kvp.Value;

                details.Add($"{kvp.Key}*{kvp.Value}={total:0.00} ({chargeType})");
            }

            return string.Join("; ", details);
        }

        public decimal CalculateChargeForCode(string cptCode, int units = 1)
        {
            var detail = ParseCPTItem($"{cptCode}*{units}");
            return detail?.TotalCharge ?? 0;
        }

        public decimal GetBilledChargeForCode(string cptCode)
        {
            return _feeScheduleLoader.GetBilledCharge(cptCode);
        }

        // ============ PAYER-CPT AVERAGE METHODS ============

        public void LoadPayerCptAverages(string outputFolder)
        {
            string avgCsv = Directory
                .GetFiles(outputFolder, "Payer_CPT_Average_*.csv")
                .OrderByDescending(File.GetCreationTime)
                .FirstOrDefault();

            if (avgCsv == null)
                throw new Exception("Payer CPT Average CSV not found");

            _payerCptAvgMap = File.ReadLines(avgCsv)
                                .Skip(1)
                                .Select(ParseAvgRow)
                                .Where(x => x != null)
                                .ToDictionary(
                                    x => (x.PayerCommonCode, x.PayerName, x.CPTCode),
                                    x => x
                                );
        }

        private PayerCptAvg ParseAvgRow(string line)
        {
            var fields = ParseCsvLine(line);

            if (fields == null || fields.Length < 8)
                return null;

            return new PayerCptAvg
            {
                PayerCommonCode = fields[0].Trim().ToUpperInvariant(),
                PayerName = fields[2].Trim().ToUpperInvariant(),
                CPTCode = fields[3].Trim().ToUpperInvariant(),
                AvgBilled = TryDec(fields[4]),
                AvgAllowed = TryDec(fields[5]),
                AvgInsurance = TryDec(fields[6]),
                AvgPatientBalance = TryDec(fields[7])
            };
        }

        public decimal CalculateAverageAmount(
            Dictionary<string, int> cptUnits,
            string payerCommonCode,
            string payerName,
            Func<PayerCptAvg, decimal?> selector,
            string visitNumber,
            string calculationName)
        {
            if (string.IsNullOrWhiteSpace(payerCommonCode))
            {
                LogAvgCalculation($"VisitNumber: {visitNumber}");
                LogAvgCalculation($"Calculation: {calculationName}");
                LogAvgCalculation("PayerCommonCode is NULL/EMPTY → returning 0");
                LogAvgCalculation(new string('=', 50));
                return 0m;
            }

            if (_payerCptAvgMap == null || cptUnits == null || cptUnits.Count == 0)
                return 0m;

            decimal total = 0m;
            string payerCode = payerCommonCode.ToUpperInvariant();
            string payerNm = payerName?.ToUpperInvariant() ?? string.Empty;

            LogAvgCalculation($"VisitNumber: {visitNumber}");
            LogAvgCalculation($"Calculation: {calculationName}");
            LogAvgCalculation($"PayerCommonCode: {payerCode}");
            LogAvgCalculation($"PayerName: {payerNm}");
            LogAvgCalculation(new string('-', 50));

            foreach (var kvp in cptUnits)
            {
                string cpt = kvp.Key?.ToUpperInvariant();
                int units = kvp.Value;

                if (string.IsNullOrWhiteSpace(cpt) || units <= 0)
                    continue;

                LogAvgCalculation($"CPT: {cpt}");
                LogAvgCalculation($"Units: {units}");
                LogAvgCalculation("Source: Payer_CPT_Average_*.csv");

                // OTHER COMMERCIAL handling
                if (string.Equals(payerCode, "OTHER COMMERCIAL", StringComparison.OrdinalIgnoreCase))
                {
                    var values = GetOtherCommercialMatches(payerCode, cpt)
                        .Select(selector)
                        .Where(v => v.HasValue)
                        .Select(v => v.Value)
                        .ToList();

                    if (values.Any())
                    {
                        decimal avg = values.Average();
                        decimal line = avg * units;
                        total += line;
                        LogAvgCalculation($"Other Commercial Avg = {avg:0.00}");
                        LogAvgCalculation($"Line = {avg:0.00} × {units} = {line:0.00}");
                    }
                    else
                    {
                        LogAvgCalculation("No rows found → 0.00");
                    }
                    LogAvgCalculation(new string('-', 50));
                    continue;
                }

                // Normal payer lookup
                var key = (payerCode, payerNm, cpt);
                if (_payerCptAvgMap.TryGetValue(key, out var avgRow))
                {
                    var perUnit = selector(avgRow);
                    if (perUnit.HasValue)
                    {
                        decimal line = perUnit.Value * units;
                        total += line;
                        LogAvgCalculation($"Found Avg = {perUnit.Value:0.00}");
                        LogAvgCalculation($"Line = {perUnit.Value:0.00} × {units} = {line:0.00}");
                    }
                    else
                    {
                        LogAvgCalculation("Avg value is NULL → 0.00");
                    }
                }
                else
                {
                    LogAvgCalculation("Exact payer+CPT not found → 0.00");
                }
                LogAvgCalculation(new string('-', 50));
            }

            LogAvgCalculation($"FINAL {calculationName} = {total:0.00}");
            LogAvgCalculation(new string('=', 50));

            return total;
        }

        // ============ UTILITY METHODS ============

        private string[] ParseCsvLine(string line)
        {
            var fields = new List<string>();
            var currentField = new StringBuilder();
            bool inQuotes = false;

            for (int i = 0; i < line.Length; i++)
            {
                char c = line[i];

                if (c == '"')
                {
                    inQuotes = !inQuotes;
                }
                else if (c == ',' && !inQuotes)
                {
                    fields.Add(currentField.ToString());
                    currentField.Clear();
                }
                else
                {
                    currentField.Append(c);
                }
            }

            fields.Add(currentField.ToString());
            return fields.ToArray();
        }

        private decimal? TryDec(string v)
        {
            if (string.IsNullOrWhiteSpace(v)) return null;
            return decimal.TryParse(v, out var d) ? d : null;
        }

        private IEnumerable<PayerCptAvg> GetOtherCommercialMatches(
            string payerCommonCode,
            string cpt)
        {
            return _payerCptAvgMap
                .Where(k =>
                    k.Key.PayerCommonCode.Equals(payerCommonCode, StringComparison.OrdinalIgnoreCase) &&
                    k.Key.CPT.Equals(cpt, StringComparison.OrdinalIgnoreCase))
                .Select(x => x.Value);
        }

        private void LogAvgCalculation(string message)
        {
            try
            {
                string logDir = Path.Combine(AppContext.BaseDirectory, "Logs");
                Directory.CreateDirectory(logDir);

                string logFile = Path.Combine(
                    logDir,
                    $"AvgCalculationTrace_{DateTime.Now:yyyy-MM-dd}.log");

                File.AppendAllText(logFile, message + Environment.NewLine);
            }
            catch { /* Ignore logging errors */ }
        }

        // ============ SUPPORTING CLASSES ============

        public class PayerCptAvg
        {
            public string PayerCommonCode { get; set; }
            public string PayerName { get; set; }
            public string CPTCode { get; set; }

            public decimal? AvgBilled { get; set; }
            public decimal? AvgAllowed { get; set; }
            public decimal? AvgInsurance { get; set; }
            public decimal? AvgPatientBalance { get; set; }
        }
    }
}