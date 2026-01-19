using Microsoft.Extensions.Configuration;
using PayerPolicyStatusGenerator.Models;
using System;
using System.Collections.Generic;
using System.Linq;

namespace PayerPolicyStatusGenerator.Utilities
{
    public class PaymentStatusCalculator
    {
        private readonly List<string> _coveredKeywords;
        private readonly string _validationPassKeyword;

        public PaymentStatusCalculator(IConfiguration configuration)
        {
            _coveredKeywords = configuration.GetSection("PaymentStatusSettings:CoveredKeywords")
                .Get<List<string>>() ?? new List<string> { "Covered", "Conditional - Dx" };

            _validationPassKeyword = configuration["PaymentStatusSettings:ValidationPassKeyword"] ?? "Pass";
        }

        public (string PaymentStatus, string PaymentRemark) CalculatePaymentStatusAndRemark(ClaimRecord record)
        {
            try
            {
                // Step 1: Check if CoverageStatus contains any of the covered keywords
                var coverageStatuses = record.CoverageStatus?
                    .Split(new[] { ',' }, StringSplitOptions.RemoveEmptyEntries)
                    .Select(s => s.Trim())
                    .ToList() ?? new List<string>();

                bool hasCoverage = false;
                foreach (var status in coverageStatuses)
                {
                    foreach (var keyword in _coveredKeywords)
                    {
                        if (status.Contains(keyword, StringComparison.OrdinalIgnoreCase))
                        {
                            hasCoverage = true;
                            break;
                        }
                    }
                    if (hasCoverage) break;
                }

                if (!hasCoverage)
                {
                    return ("Payment Status Not Applicable - No Coverage",
                            "No coverage status found for claim");
                }

                // Step 2: Check if ICDValidation is "Pass" (configurable)
                if (!string.Equals(record.ICDValidation?.Trim(), _validationPassKeyword, StringComparison.OrdinalIgnoreCase))
                {
                    return ("Payment Status Not Applicable - ICD Validation Failed",
                            $"ICD Validation failed: {record.ICDValidation}");
                }

                // Step 3: Process ICD codes
                var icd10Codes = SplitAndClean(record.ICD10Code);
                var ccwICDCodes = SplitAndClean(record.CCWICDCode);
                var coveredCodes = SplitAndClean(record.CoveredICDCodes);
                var nonCoveredCodes = SplitAndClean(record.NonCoveredICDCodes);
                var notAvailableCodes = SplitAndClean(record.ICDNOTAvailableinPayerPolicy);

                // Combine all diagnosis codes
                var allDiagnosisCodes = new List<string>();
                allDiagnosisCodes.AddRange(icd10Codes);
                allDiagnosisCodes.AddRange(ccwICDCodes);

                if (allDiagnosisCodes.Count == 0)
                {
                    return ("Payment Status Unknown - No ICD Codes Provided",
                            "No ICD-10 or CCW ICD codes provided");
                }

                // Remove duplicates
                allDiagnosisCodes = allDiagnosisCodes.Distinct().ToList();

                // Calculate Payment Status
                string paymentStatus = CalculatePaymentStatus(allDiagnosisCodes, coveredCodes, nonCoveredCodes, notAvailableCodes);

                // Calculate Payment Remark
                string paymentRemark = CalculatePaymentRemark(icd10Codes, ccwICDCodes, coveredCodes);

                return (paymentStatus, paymentRemark);
            }
            catch (Exception ex)
            {
                return ($"Error Calculating Payment Status: {ex.Message}",
                        $"Error in calculation: {ex.Message}");
            }
        }

        private List<string> SplitAndClean(string input)
        {
            if (string.IsNullOrWhiteSpace(input))
                return new List<string>();

            return input.Split(new[] { ',' }, StringSplitOptions.RemoveEmptyEntries)
                        .Select(s => s.Trim())
                        .Where(s => !string.IsNullOrWhiteSpace(s))
                        .ToList();
        }

        private string CalculatePaymentStatus(
            List<string> diagnosisCodes,
            List<string> coveredCodes,
            List<string> nonCoveredCodes,
            List<string> notAvailableCodes)
        {
            bool anyNonCovered = false;
            bool allCovered = true;
            bool anyNotAvailable = false;

            foreach (var code in diagnosisCodes)
            {
                if (nonCoveredCodes.Contains(code))
                {
                    anyNonCovered = true;
                    allCovered = false;
                }
                else if (coveredCodes.Contains(code))
                {
                    // Code is covered
                }
                else if (notAvailableCodes.Contains(code))
                {
                    anyNotAvailable = true;
                    allCovered = false;
                }
                else
                {
                    // Code not found in any list
                    allCovered = false;
                }
            }

            // Determine payment status based on priority rules
            if (anyNonCovered)
            {
                return "PaymentNotExpected";
            }
            else if (allCovered && !anyNonCovered)
            {
                return "PaymentExpected";
            }
            else if (anyNotAvailable && !anyNonCovered)
            {
                return "Payment May Expected";
            }
            else
            {
                return "Payment Status Unknown - ICD Code Classification Missing";
            }
        }

        private string CalculatePaymentRemark(
            List<string> icd10Codes,
            List<string> ccwICDCodes,
            List<string> coveredCodes)
        {
            // Rule 1: If CCW ICD codes exist and are all covered, no remark needed
            if (ccwICDCodes.Any() && ccwICDCodes.All(code => coveredCodes.Contains(code)))
            {
                return string.Empty; // No remark
            }

            // Rule 2: Check for ICD-10 codes that are covered but not in CCW codes
            var icd10CoveredNotInCCW = icd10Codes
                .Where(code => coveredCodes.Contains(code) && !ccwICDCodes.Contains(code))
                .ToList();

            if (icd10CoveredNotInCCW.Any())
            {
                if (icd10CoveredNotInCCW.Count == 1)
                {
                    return $"{icd10CoveredNotInCCW[0]} - should be in Primary diagnosis";
                }
                else
                {
                    var codes = string.Join(", ", icd10CoveredNotInCCW);
                    return $"{codes} - should be in Primary diagnosis";
                }
            }

            // Rule 3: If CCW codes exist but are not covered
            if (ccwICDCodes.Any() && ccwICDCodes.Any(code => !coveredCodes.Contains(code)))
            {
                var nonCoveredCCW = ccwICDCodes.Where(code => !coveredCodes.Contains(code)).ToList();
                if (nonCoveredCCW.Any())
                {
                    return $"CCW ICD codes {string.Join(", ", nonCoveredCCW)} not in covered list";
                }
            }

            // Default remark
            return "Review diagnosis code coverage";
        }
    }
}