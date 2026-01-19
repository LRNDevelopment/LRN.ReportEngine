using Microsoft.Extensions.Configuration;
using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;

namespace LRN.CodingMasterValidation
{
    public class EnhancedValidationReporter
    {
        private readonly string _outputDirectory;
        private readonly ChargeCalculator _chargeCalculator;
        private readonly IConfiguration _configuration;
        private readonly LabContext _lab;

        public EnhancedValidationReporter(IConfiguration config, LabContext lab)
        {
            _lab = lab;
            _configuration = config;
            _outputDirectory = lab.OutputFolder;

            Console.WriteLine($"📁 Output Directory: {_outputDirectory}");

            // List available Payer-CPT average files
            var avgFiles = Directory.GetFiles(_outputDirectory, "Payer_CPT_Average_*.csv");
            Console.WriteLine($"📊 Found {avgFiles.Length} Payer-CPT Average CSV files:");
            foreach (var file in avgFiles.OrderByDescending(f => File.GetCreationTime(f)).Take(5))
            {
                Console.WriteLine($"   - {Path.GetFileName(file)} (Created: {File.GetCreationTime(file)})");
            }

            _chargeCalculator = new ChargeCalculator(lab, config);
            _chargeCalculator.LoadPayerCptAverages(lab.OutputFolder);
        }

        public void Execute(List<ValidationResult> validationResults)
        {
            Console.WriteLine("\n" + "=".PadRight(60, '='));
            Console.WriteLine("ENHANCED VALIDATION REPORT WITH CHARGES");
            Console.WriteLine("=".PadRight(60, '='));

            try
            {
                string timestamp = DateTime.Now.ToString("yyyyMMdd_HHmmss");
                string outputFile = Path.Combine(
                    _outputDirectory,
                    $"Enhanced_Validation_Report_{timestamp}.csv");

                GenerateReport(validationResults, outputFile);
            }
            catch (Exception ex)
            {
                Console.WriteLine($"❌ Error generating enhanced report: {ex.Message}");
                Console.WriteLine(ex.StackTrace);
            }
        }

        private bool IsPCRALLab()
        {
            return _lab.InputFolder
                .Contains(@"\PCRAL\", StringComparison.OrdinalIgnoreCase);
        }

        //private void GenerateReport(List<ValidationResult> results, string outputPath)
        //{
        //    Directory.CreateDirectory(Path.GetDirectoryName(outputPath));

        //    using var writer = new StreamWriter(outputPath);

        //    // HEADER
        //    writer.WriteLine(
        //        "VisitNumber,AccessionNo,PanelName,Carrier,ActualCPTCode,ExpectedCPTCode," +
        //        "MissingCPTCodes,AdditionalCPTCodes,Missing CPT (Charge),MissingCPT_ChargeSource,Additional CPT (Charges),AdditionalCPT_ChargeSource," +
        //        "TotalCharge,Expected Charges,Validation Status,Remarks," +
        //        "MissingCPT_AvgAllowedAmount,MissingCPT_AvgPaidAmount,MissingCPT_AvgPatientResponsibilityAmount," +
        //        "AdditionalCPT_AvgAllowedAmount,AdditionalCPT_AvgPaidAmount,AdditionalCPT_AvgPatientResponsibilityAmount"
        //    );

        //    foreach (var result in results)
        //    {
        //        var record = result.ProductionRecord;
        //        string visit = record?.VisitNumber ?? "UNKNOWN";
        //        string payerName = record?.Carrier?.Trim().ToUpperInvariant();

        //        // ✅ Parse BeginDOS HERE
        //        DateTime? beginDOS = ParseBeginDOS(record?.BeginDOS);

        //        // ---- AVG CALCULATIONS (unchanged) ----
        //        var missingAvgAllowed = _chargeCalculator.CalculateAverageAmount(
        //            result.MissingCPTCodes,
        //            result.PayerCommonCode,
        //            payerName,
        //            x => x.AvgAllowed,
        //            visit,
        //            "MissingCPT_AvgAllowedAmount");

        //        var missingAvgPaid = _chargeCalculator.CalculateAverageAmount(
        //            result.MissingCPTCodes,
        //            result.PayerCommonCode,
        //            payerName,
        //            x => x.AvgInsurance,
        //            visit,
        //            "MissingCPT_AvgPaidAmount");

        //        var missingAvgPatient = _chargeCalculator.CalculateAverageAmount(
        //            result.MissingCPTCodes,
        //            result.PayerCommonCode,
        //            payerName,
        //            x => x.AvgPatientBalance,
        //            visit,
        //            "MissingCPT_AvgPatientResponsibilityAmount");

        //        var additionalAvgAllowed = _chargeCalculator.CalculateAverageAmount(
        //            result.AdditionalCPTCodes,
        //            result.PayerCommonCode,
        //            payerName,
        //            x => x.AvgAllowed,
        //            visit,
        //            "AdditionalCPT_AvgAllowedAmount");

        //        var additionalAvgPaid = _chargeCalculator.CalculateAverageAmount(
        //            result.AdditionalCPTCodes,
        //            result.PayerCommonCode,
        //            payerName,
        //            x => x.AvgInsurance,
        //            visit,
        //            "AdditionalCPT_AvgPaidAmount");

        //        var additionalAvgPatient = _chargeCalculator.CalculateAverageAmount(
        //            result.AdditionalCPTCodes,
        //            result.PayerCommonCode,
        //            payerName,
        //            x => x.AvgPatientBalance,
        //            visit,
        //            "AdditionalCPT_AvgPatientResponsibilityAmount");

        //        // ---- CHARGE CALCULATIONS (BeginDOS AWARE) ----
        //        decimal missingCharge =
        //            _chargeCalculator.CalculateTotalChargeForMissingCPTs(
        //                result.MissingCPTCodes, beginDOS);

        //        decimal additionalCharge =
        //            _chargeCalculator.CalculateTotalChargeForAdditionalCPTs(
        //                result.AdditionalCPTCodes, beginDOS);

        //        decimal expectedCharge =
        //            result.ExpectedCPTCodes.Any()
        //                ? _chargeCalculator.CalculateExpectedCharges(
        //                    string.Join(", ", result.ExpectedCPTCodes),
        //                    beginDOS)
        //                : 0m;

        //        string missingChargeSource =_chargeCalculator.GetChargeSourceSummary(
        //                                        result.MissingCPTCodes, beginDOS);

        //        string additionalChargeSource =_chargeCalculator.GetChargeSourceSummary(
        //                                        result.AdditionalCPTCodes, beginDOS);


        //        string validationStatus = GetValidationStatus(result);

        //        writer.WriteLine(
        //            $"\"{Escape(record?.VisitNumber)}\"," +
        //            $"\"{Escape(record?.AccessionNo)}\"," +
        //            $"\"{Escape(record?.PanelName)}\"," +
        //            $"\"{Escape(record?.Carrier)}\"," +
        //            $"\"{Escape(record?.ActualCPTCode)}\"," +
        //            $"\"{Escape(string.Join(", ", result.ExpectedCPTCodes))}\"," +
        //            $"\"{Escape(FormatCodes(result.MissingCPTCodes))}\"," +
        //            $"\"{Escape(FormatCodes(result.AdditionalCPTCodes))}\"," +
        //            $"\"{missingCharge:0.00}\"," +
        //            $"\"{missingChargeSource}\"," +
        //            $"\"{additionalCharge:0.00}\"," +
        //            $"\"{additionalChargeSource}\"," +
        //            $"\"{record?.TotalCharge:0.00}\"," +
        //            $"\"{expectedCharge:0.00}\"," +
        //            $"\"{validationStatus}\"," +
        //            $"\"{Escape(result.Remarks)}\"," +
        //            $"\"{missingAvgAllowed:0.00}\"," +
        //            $"\"{missingAvgPaid:0.00}\"," +
        //            $"\"{missingAvgPatient:0.00}\"," +
        //            $"\"{additionalAvgAllowed:0.00}\"," +
        //            $"\"{additionalAvgPaid:0.00}\"," +
        //            $"\"{additionalAvgPatient:0.00}\""
        //        );
        //    }

        //    Console.WriteLine($"📄 Enhanced validation report saved: {outputPath}");
        //}

        private void GenerateReport(List<ValidationResult> results, string outputPath)
        {
            Directory.CreateDirectory(Path.GetDirectoryName(outputPath));

            using var writer = new StreamWriter(outputPath);

            if (IsPCRALLab())
            {
                GeneratePCRALReport(results, writer);
            }
            else
            {
                GenerateNonPCRALReport(results, writer);
            }

            Console.WriteLine($"📄 Enhanced validation report saved: {outputPath}");
        }


        private void GeneratePCRALReport(List<ValidationResult> results,StreamWriter writer)
        {
            // 🔹 HEADER (Panel1 INCLUDED)
            writer.WriteLine(
                "VisitNumber,AccessionNo,PanelName,Panel1,Carrier,ActualCPTCode,ExpectedCPTCode," +
                "MissingCPTCodes,AdditionalCPTCodes," +
                "Missing CPT (Charge),MissingCPT_ChargeSource," +
                "Additional CPT (Charges),AdditionalCPT_ChargeSource," +
                "TotalCharge,Expected Charges,Validation Status,Remarks," +
                "MissingCPT_AvgAllowedAmount,MissingCPT_AvgPaidAmount,MissingCPT_AvgPatientResponsibilityAmount," +
                "AdditionalCPT_AvgAllowedAmount,AdditionalCPT_AvgPaidAmount,AdditionalCPT_AvgPatientResponsibilityAmount"
            );

            foreach (var result in results)
            {
                WriteCommonRow(result, writer, includePanel1: true);
            }
        }

        private void GenerateNonPCRALReport(List<ValidationResult> results,StreamWriter writer)
        {
            // 🔹 HEADER (Panel1 EXCLUDED)
            writer.WriteLine(
                "VisitNumber,AccessionNo,PanelName,Carrier,ActualCPTCode,ExpectedCPTCode," +
                "MissingCPTCodes,AdditionalCPTCodes," +
                "Missing CPT (Charge),MissingCPT_ChargeSource," +
                "Additional CPT (Charges),AdditionalCPT_ChargeSource," +
                "TotalCharge,Expected Charges,Validation Status,Remarks," +
                "MissingCPT_AvgAllowedAmount,MissingCPT_AvgPaidAmount,MissingCPT_AvgPatientResponsibilityAmount," +
                "AdditionalCPT_AvgAllowedAmount,AdditionalCPT_AvgPaidAmount,AdditionalCPT_AvgPatientResponsibilityAmount"
            );

            foreach (var result in results)
            {
                WriteCommonRow(result, writer, includePanel1: false);
            }
        }
        //private void WriteCommonRow(ValidationResult result,StreamWriter writer,bool includePanel1)
        //{
        //    var record = result.ProductionRecord;
        //    string visit = record?.VisitNumber ?? "UNKNOWN";
        //  //  string payerName = record?.Carrier?.Trim().ToUpperInvariant();

        //    string payerName = result.PayerName?.Trim().ToUpperInvariant();


        //    DateTime? beginDOS = ParseBeginDOS(record?.BeginDOS);

        //    // ---- AVG CALCULATIONS ----
        //    var missingAvgAllowed = _chargeCalculator.CalculateAverageAmount(
        //        result.MissingCPTCodes, result.PayerCommonCode, payerName,
        //        x => x.AvgAllowed, visit, "MissingCPT_AvgAllowedAmount");

        //    var missingAvgPaid = _chargeCalculator.CalculateAverageAmount(
        //        result.MissingCPTCodes, result.PayerCommonCode, payerName,
        //        x => x.AvgInsurance, visit, "MissingCPT_AvgPaidAmount");

        //    var missingAvgPatient = _chargeCalculator.CalculateAverageAmount(
        //        result.MissingCPTCodes, result.PayerCommonCode, payerName,
        //        x => x.AvgPatientBalance, visit, "MissingCPT_AvgPatientResponsibilityAmount");

        //    var additionalAvgAllowed = _chargeCalculator.CalculateAverageAmount(
        //        result.AdditionalCPTCodes, result.PayerCommonCode, payerName,
        //        x => x.AvgAllowed, visit, "AdditionalCPT_AvgAllowedAmount");

        //    var additionalAvgPaid = _chargeCalculator.CalculateAverageAmount(
        //        result.AdditionalCPTCodes, result.PayerCommonCode, payerName,
        //        x => x.AvgInsurance, visit, "AdditionalCPT_AvgPaidAmount");

        //    var additionalAvgPatient = _chargeCalculator.CalculateAverageAmount(
        //        result.AdditionalCPTCodes, result.PayerCommonCode, payerName,
        //        x => x.AvgPatientBalance, visit, "AdditionalCPT_AvgPatientResponsibilityAmount");

        //    // ---- CHARGES ----
        //    decimal missingCharge =
        //        _chargeCalculator.CalculateTotalChargeForMissingCPTs(
        //            result.MissingCPTCodes, beginDOS);

        //    decimal additionalCharge =
        //        _chargeCalculator.CalculateTotalChargeForAdditionalCPTs(
        //            result.AdditionalCPTCodes, beginDOS);

        //    decimal expectedCharge =
        //        result.ExpectedCPTCodes.Any()
        //            ? _chargeCalculator.CalculateExpectedCharges(
        //                string.Join(", ", result.ExpectedCPTCodes), beginDOS)
        //            : 0m;

        //    string missingChargeSource =
        //        _chargeCalculator.GetChargeSourceSummary(result.MissingCPTCodes, beginDOS);

        //    string additionalChargeSource =
        //        _chargeCalculator.GetChargeSourceSummary(result.AdditionalCPTCodes, beginDOS);

        //    string validationStatus = GetValidationStatus(result);

        //    // ---- WRITE ROW ----
        //    writer.Write(
        //        $"\"{Escape(record?.VisitNumber)}\"," +
        //        $"\"{Escape(record?.AccessionNo)}\"," +
        //        $"\"{Escape(record?.PanelName)}\",");

        //    if (includePanel1)
        //    {
        //        writer.Write($"\"{Escape(record?.Panel1)}\",");
        //    }

        //    writer.WriteLine(
        //        $"\"{Escape(record?.Carrier)}\"," +
        //        $"\"{Escape(record?.ActualCPTCode)}\"," +
        //        $"\"{Escape(string.Join(", ", result.ExpectedCPTCodes))}\"," +
        //        $"\"{Escape(FormatCodes(result.MissingCPTCodes))}\"," +
        //        $"\"{Escape(FormatCodes(result.AdditionalCPTCodes))}\"," +
        //        $"\"{missingCharge:0.00}\"," +
        //        $"\"{missingChargeSource}\"," +
        //        $"\"{additionalCharge:0.00}\"," +
        //        $"\"{additionalChargeSource}\"," +
        //        $"\"{record?.TotalCharge:0.00}\"," +
        //        $"\"{expectedCharge:0.00}\"," +
        //        $"\"{validationStatus}\"," +
        //        $"\"{Escape(result.Remarks)}\"," +
        //        $"\"{missingAvgAllowed:0.00}\"," +
        //        $"\"{missingAvgPaid:0.00}\"," +
        //        $"\"{missingAvgPatient:0.00}\"," +
        //        $"\"{additionalAvgAllowed:0.00}\"," +
        //        $"\"{additionalAvgPaid:0.00}\"," +
        //        $"\"{additionalAvgPatient:0.00}\""
        //    );
        //}

        private void WriteCommonRow(ValidationResult result, StreamWriter writer, bool includePanel1)
        {
            var record = result.ProductionRecord;
            string visit = record?.VisitNumber ?? "UNKNOWN";

            //  string payerName = result.PayerName?.Trim().ToUpperInvariant();

            // FIX 1: Use production record's Carrier as fallback if result.PayerName is null
            string payerName = !string.IsNullOrWhiteSpace(result.PayerName)
                ? result.PayerName.Trim().ToUpperInvariant()
                : record?.Carrier?.Trim().ToUpperInvariant() ?? "UNKNOWN";


            DateTime? beginDOS = ParseBeginDOS(record?.BeginDOS);

            //// DEBUG: Log payer information to identify the issue
            //Console.WriteLine($"Processing Visit {visit}:");
            //Console.WriteLine($"  PayerName from result: {result.PayerName}");
            //Console.WriteLine($"  Carrier from record: {record?.Carrier}");
            //Console.WriteLine($"  Using payerName: {payerName}");
            //Console.WriteLine($"  PayerCommonCode: {result.PayerCommonCode}");
            //Console.WriteLine($"  Missing CPTs: {result.MissingCPTCodes?.Count ?? 0}");
            //Console.WriteLine($"  Additional CPTs: {result.AdditionalCPTCodes?.Count ?? 0}");



            // ---- AVG CALCULATIONS WITH DEBUGGING ----
            var missingAvgAllowed = _chargeCalculator.CalculateAverageAmount(
                result.MissingCPTCodes,
                result.PayerCommonCode,
                payerName,
                x => x.AvgAllowed,
                visit,
                "MissingCPT_AvgAllowedAmount");

            // Add debugging for the calculation
          //  Console.WriteLine($"  Missing Avg Allowed: {missingAvgAllowed:0.00}");

            var missingAvgPaid = _chargeCalculator.CalculateAverageAmount(
                result.MissingCPTCodes,
                result.PayerCommonCode,
                payerName,
                x => x.AvgInsurance,
                visit,
                "MissingCPT_AvgPaidAmount");

            var missingAvgPatient = _chargeCalculator.CalculateAverageAmount(
                result.MissingCPTCodes,
                result.PayerCommonCode,
                payerName,
                x => x.AvgPatientBalance,
                visit,
                "MissingCPT_AvgPatientResponsibilityAmount");

            var additionalAvgAllowed = _chargeCalculator.CalculateAverageAmount(
                result.AdditionalCPTCodes,
                result.PayerCommonCode,
                payerName,
                x => x.AvgAllowed,
                visit,
                "AdditionalCPT_AvgAllowedAmount");

            var additionalAvgPaid = _chargeCalculator.CalculateAverageAmount(
                result.AdditionalCPTCodes,
                result.PayerCommonCode,
                payerName,
                x => x.AvgInsurance,
                visit,
                "AdditionalCPT_AvgPaidAmount");

            var additionalAvgPatient = _chargeCalculator.CalculateAverageAmount(
                result.AdditionalCPTCodes,
                result.PayerCommonCode,
                payerName,
                x => x.AvgPatientBalance,
                visit,
                "AdditionalCPT_AvgPatientResponsibilityAmount");

            // ---- CHARGES ----
            decimal missingCharge =
                _chargeCalculator.CalculateTotalChargeForMissingCPTs(
                    result.MissingCPTCodes, beginDOS);

            decimal additionalCharge =
                _chargeCalculator.CalculateTotalChargeForAdditionalCPTs(
                    result.AdditionalCPTCodes, beginDOS);

            decimal expectedCharge =
                result.ExpectedCPTCodes.Any()
                    ? _chargeCalculator.CalculateExpectedCharges(
                        string.Join(", ", result.ExpectedCPTCodes), beginDOS)
                    : 0m;

            string missingChargeSource =
                _chargeCalculator.GetChargeSourceSummary(result.MissingCPTCodes, beginDOS);

            string additionalChargeSource =
                _chargeCalculator.GetChargeSourceSummary(result.AdditionalCPTCodes, beginDOS);

            string validationStatus = GetValidationStatus(result);

            // ---- WRITE ROW ----
            writer.Write(
                $"\"{Escape(record?.VisitNumber)}\"," +
                $"\"{Escape(record?.AccessionNo)}\"," +
                $"\"{Escape(record?.PanelName)}\",");

            if (includePanel1)
            {
                writer.Write($"\"{Escape(record?.Panel1)}\",");
            }

            writer.WriteLine(
                $"\"{Escape(record?.Carrier)}\"," +
                $"\"{Escape(record?.ActualCPTCode)}\"," +
                $"\"{Escape(string.Join(", ", result.ExpectedCPTCodes))}\"," +
                $"\"{Escape(FormatCodes(result.MissingCPTCodes))}\"," +
                $"\"{Escape(FormatCodes(result.AdditionalCPTCodes))}\"," +
                $"\"{missingCharge:0.00}\"," +
                $"\"{missingChargeSource}\"," +
                $"\"{additionalCharge:0.00}\"," +
                $"\"{additionalChargeSource}\"," +
                $"\"{record?.TotalCharge:0.00}\"," +
                $"\"{expectedCharge:0.00}\"," +
                $"\"{validationStatus}\"," +
                $"\"{Escape(result.Remarks)}\"," +
                $"\"{missingAvgAllowed:0.00}\"," +
                $"\"{missingAvgPaid:0.00}\"," +
                $"\"{missingAvgPatient:0.00}\"," +
                $"\"{additionalAvgAllowed:0.00}\"," +
                $"\"{additionalAvgPaid:0.00}\"," +
                $"\"{additionalAvgPatient:0.00}\""
            );
        }
        // ---------------- HELPERS ----------------

        private static DateTime? ParseBeginDOS(string beginDos)
        {
            if (string.IsNullOrWhiteSpace(beginDos))
                return null;

            return DateTime.TryParse(beginDos, out var d) ? d : null;
        }

        private static string FormatCodes(Dictionary<string, int> codes)
        {
            if (codes == null || codes.Count == 0)
                return "";

            return string.Join(", ",
                codes.Where(k => !string.IsNullOrWhiteSpace(k.Key))
                     .Select(k => $"{k.Key}*{k.Value}"));
        }

        private static string Escape(string value)
        {
            if (string.IsNullOrEmpty(value))
                return "";

            return value.Replace("\"", "\"\"");
        }

        private static string GetValidationStatus(ValidationResult result)
        {
            bool hasMissing = result.MissingCPTCodes?.Any() == true;
            bool hasAdditional = result.AdditionalCPTCodes?.Any() == true;

            if (hasMissing && !hasAdditional) return "Missing CPTs";
            if (!hasMissing && hasAdditional) return "Additional CPTs coded";
            if (!hasMissing && !hasAdditional) return "No Deviation found";

            return "Both Missing and Additional CPTs identified";
        }
    }
}
