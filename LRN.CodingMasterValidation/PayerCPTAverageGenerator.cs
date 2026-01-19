using Microsoft.VisualBasic.FileIO;
using System;
using System.Collections.Generic;
using System.Diagnostics;
using System.IO;
using System.Linq;
using System.Text;

namespace LRN.CodingMasterValidation
{
    public class PayerCPTAverageGenerator
    {
        private readonly Action<string, string, bool> _log;
        private readonly string _outputFolder;
        private readonly List<PayerMasterRecord> _payerMasterList;

        public PayerCPTAverageGenerator(
            string outputFolder,
            List<PayerMasterRecord> payerMasterList,
            Action<string, string, bool> log)
        {
            _outputFolder = outputFolder;
            _payerMasterList = payerMasterList;
            _log = log;
        }

        // ==========================================================
        // ENTRY POINT
        // ==========================================================
        public void GenerateFromCsv(
            string inputCsv,
            string avgCsv,
            string auditCsv,
            string errorLogPath)
        {
            HashSet<string> allowedStatuses = new HashSet<string>(StringComparer.OrdinalIgnoreCase)
            {
                "Paid",
                "Adjusted",
                "Denied",
                "Patient Responsibility"
            };

            List<AggregateRow> aggregates = new List<AggregateRow>();
            List<string> errorLog = new List<string>();

            int rowNum = 1;

            using (TextFieldParser parser = new TextFieldParser(inputCsv))
            {
                parser.TextFieldType = FieldType.Delimited;
                parser.SetDelimiters(",");
                parser.HasFieldsEnclosedInQuotes = true;

                // ================= HEADER =================
                string[] headerRow = parser.ReadFields();
                Dictionary<string, int> header = BuildHeaderIndex(headerRow);

                // ================= DATA =================
                while (!parser.EndOfData)
                {
                    rowNum++;
                    string[] c = parser.ReadFields();
                    for (int i = 0; i < c.Length; i++)
                        c[i] = GetTrimmedString(c[i]);

                    string status = Get(c, header, "FinalClaimStatus");
                    if (!allowedStatuses.Contains(status))
                        continue;

                    string payer = Get(c, header, "PayerName");
                    string cpt = Get(c, header, "CPTCode");

                    if (string.IsNullOrWhiteSpace(payer) || string.IsNullOrWhiteSpace(cpt))
                        continue;
                    if (payer == "UMR WAUSAU - UMR" && cpt== "87798")
                    {
                        
                        string chk = "";
                    }

                    string payerNormalized;
                 

                    string payerCommonCode = GetPayerCommonCode(payer,_payerMasterList,out payerNormalized);
                    //string payerCommonCode = GetPayerCommonCode(payer, _payerMasterList);
                    //string payerNormalized = GetPayerNormalizedName(payer, _payerMasterList);

                    if (string.IsNullOrWhiteSpace(payerCommonCode))
                        continue;

                    decimal billed = SafeParse(Get(c, header, "BilledAmountPerUnit"), rowNum, errorLog, "BilledAmountPerUnit");
                    decimal allowed = SafeParse(Get(c, header, "AllowedAmountPerUnit"), rowNum, errorLog, "AllowedAmountPerUnit");
                    decimal insurance = SafeParse(Get(c, header, "InsurancePaymentPerUnit"), rowNum, errorLog, "InsurancePaymentPerUnit");
                    decimal patientBal = SafeParse(Get(c, header, "PatientBalancePerUnit"), rowNum, errorLog, "PatientBalancePerUnit");
                    decimal patientPay = SafeParse(Get(c, header, "PatientPaymentPerUnit"), rowNum, errorLog, "PatientPaymentPerUnit");

                    Debug.Assert(!string.IsNullOrWhiteSpace(payerCommonCode));
                    Debug.Assert(!string.IsNullOrWhiteSpace(cpt));

                    //if( payerCommonCode== "AETNA" && cpt== "87491")
                    //{
                    //    errorLog.Add($"PAYER CONFLICT | {payerCommonCode}||{cpt} |   New='{payer}' | Row={rowNum}" );
                    //}

                    var agg = aggregates.FirstOrDefault(a =>
                    a.PayerCommonCode.Equals(payerCommonCode, StringComparison.OrdinalIgnoreCase) &&
                    a.PayerName.Equals(payer, StringComparison.OrdinalIgnoreCase) &&
                    a.CPTCode.Equals(cpt, StringComparison.OrdinalIgnoreCase));


                    if (agg == null)
                    {
                        agg = new AggregateRow
                        {
                            PayerCommonCode = payerCommonCode,
                            CPTCode = cpt,
                            PayerName = payer,               // 🔒 LOCK FIRST VALUE
                            PayerNameNormalized = payerNormalized
                        };
                        aggregates.Add(agg);
                    }
                    else
                    {
                        // 🚨 Detect payer overwrite attempts
                        if (!agg.PayerName.Equals(payer, StringComparison.OrdinalIgnoreCase))
                        {
                            errorLog.Add(
                                $"PAYER CONFLICT | {payerCommonCode}||{cpt} | " +
                                $"Existing='{agg.PayerName}' | New='{payer}' | Row={rowNum}"
                            );
                        }
                    }

                    // ================= AGGREGATE =================
                    agg.RowCount++;
                    agg.BilledSum += billed;
                    agg.AllowedSum += allowed;
                    agg.InsuranceSum += insurance;
                    agg.PatientBalanceSum += patientBal;
                    agg.PatientPaymentSum += patientPay;
                }
            }

            // ================= WRITE OUTPUT =================
            WriteAverageCsv(avgCsv, aggregates);
           // WriteAuditCsv(auditCsv, aggregates);

            //foreach (var a in aggregates.Where(x => x.CPTCode == "87491"))
            //{
            //    errorLog.Add(
            //        $"VERIFY | {a.PayerCommonCode}||{a.CPTCode} | PayerName='{a.PayerName}'"
            //    );
            //}

            File.WriteAllLines(errorLogPath, errorLog);

            _log("SUMMARY", $"Payer-CPT groups: {aggregates.Count}", true);
            _log("SUMMARY", $"Errors logged: {errorLog.Count}", true);
        }

        // ==========================================================
        // HELPERS
        // ==========================================================
        //private static Dictionary<string, int> BuildHeaderIndex(string[] headerRow)
        //{
        //    var dict = new Dictionary<string, int>(StringComparer.OrdinalIgnoreCase);
        //    for (int i = 0; i < headerRow.Length; i++)
        //        dict[headerRow[i].Trim()] = i;
        //    return dict;
        //}

        //private static string Get(string[] c, Dictionary<string, int> h, string col)
        //    => h.ContainsKey(col) ? c[h[col]] : "";


        private static Dictionary<string, int> BuildHeaderIndex(string[] headerRow)
        {
            var dict = new Dictionary<string, int>(StringComparer.OrdinalIgnoreCase);

            for (int i = 0; i < headerRow.Length; i++)
            {
                var key = NormalizeHeader(headerRow[i]);
                if (!dict.ContainsKey(key))
                    dict[key] = i;
            }

            return dict;
        }

        private static string NormalizeHeader(string header)
        {
            if (string.IsNullOrWhiteSpace(header))
                return "";

            return header
                .Trim()
                .Trim('"')
                .Replace(" ", "")
                .Replace("_", "")
                .Replace("\ufeff", "")   // 🔥 BOM killer
                .ToUpperInvariant();
        }

        private static string Get(string[] c, Dictionary<string, int> h, string col)
        {
            string key = NormalizeHeader(col);

            if (!h.TryGetValue(key, out int index))
                throw new InvalidOperationException(
                    $"CSV column '{col}' not found. Available columns: {string.Join(", ", h.Keys)}");

            if (index < 0 || index >= c.Length)
                return "";

            return c[index];
        }


        private static string GetTrimmedString(string c)
            => string.IsNullOrWhiteSpace(c) ? "" : c.Trim().Trim('"');

        private static decimal SafeParse(string raw, int rowNum, List<string> log, string col)
        {
            if (string.IsNullOrWhiteSpace(raw))
                return 0m;

            if (decimal.TryParse(raw, out var v))
                return v;

            log.Add($"PARSE ERROR | Row {rowNum} | {col} | Raw='{raw}'");
            return 0m;
        }

        private static void WriteAverageCsv(string path, List<AggregateRow> data)
        {
            using var sw = new StreamWriter(path, false, Encoding.UTF8);

            sw.WriteLine(
                "PayerCommonCode,Payer_Name_Normalized,PayerName,CPTCode," +
                "AvgBilledAmountPerUnit,AvgAllowedAmountPerUnit," +
                "AvgInsurancePaymentPerUnit,AvgPatientBalancePerUnit,AvgPatientPaymentPerUnit"
            );

            foreach (var a in data)
            {
                decimal d = a.RowCount == 0 ? 1 : a.RowCount;

                sw.WriteLine(
                    $"\"{a.PayerCommonCode}\"," +
                    $"\"{a.PayerNameNormalized}\"," +
                    $"\"{a.PayerName}\"," +
                    $"\"{a.CPTCode}\"," +
                    $"{(a.BilledSum / d):0.00}," +
                    $"{(a.AllowedSum / d):0.00}," +
                    $"{(a.InsuranceSum / d):0.00}," +
                    $"{(a.PatientBalanceSum / d):0.00}," +
                    $"{(a.PatientPaymentSum / d):0.00}"
                );
            }
        }

        private static void WriteAuditCsv(string path, List<AggregateRow> data)
        {
            using var sw = new StreamWriter(path, false, Encoding.UTF8);

            sw.WriteLine(
                "PayerCommonCode,Payer_Name_Normalized,PayerName,CPTCode," +
                "Original_Row_Count,BilledAmountPerUnit_Sum,AllowedAmountPerUnit_Sum," +
                "InsurancePaymentPerUnit_Sum,PatientBalancePerUnit_Sum,PatientPaymentPerUnit_Sum"
            );

            foreach (var a in data)
            {
                sw.WriteLine(
                    $"\"{a.PayerCommonCode}\"," +
                    $"\"{a.PayerNameNormalized}\"," +
                    $"\"{a.PayerName}\"," +
                    $"\"{a.CPTCode}\"," +
                    $"{a.RowCount}," +
                    $"{a.BilledSum:0.00}," +
                    $"{a.AllowedSum:0.00}," +
                    $"{a.InsuranceSum:0.00}," +
                    $"{a.PatientBalanceSum:0.00}," +
                    $"{a.PatientPaymentSum:0.00}"
                );
            }
        }

        // ================= PAYER MASTER =================
        //private string GetPayerCommonCode(string carrier,List<PayerMasterRecord> list)
        //{
        //    if (string.IsNullOrWhiteSpace(carrier))
        //        return "Other Commercial";

        //    if (list == null || list.Count == 0)
        //        return "Other Commercial";

        //    string c = carrier.Trim();

        //    // 🔒 EXACT MATCH ONLY
        //    var exact = list.FirstOrDefault(p =>
        //        !string.IsNullOrWhiteSpace(p.Payer_Name_Raw) &&
        //        string.Equals(
        //            p.Payer_Name_Raw.Trim(),
        //            c,
        //            StringComparison.OrdinalIgnoreCase));

        //    if (exact != null && !string.IsNullOrWhiteSpace(exact.Payer_Common_Code))
        //        return exact.Payer_Common_Code.Trim();

        //    // ❌ No match → fallback
        //    return "Other Commercial";
        //}


        //private string GetPayerCommonCode(string carrier,List<PayerMasterRecord> list)
        //{
        //    if (string.IsNullOrWhiteSpace(carrier) || list == null || list.Count == 0)
        //        return "Other Commercial";

        //    string carrierNorm = carrier.Trim();

        //    // 1️⃣ EXACT match on raw payer name
        //    var exact = list.FirstOrDefault(p =>
        //        p.Payer_Name_Raw.Equals(carrierNorm, StringComparison.OrdinalIgnoreCase));

        //    if (exact != null && !string.IsNullOrWhiteSpace(exact.Payer_Common_Code))
        //        return exact.Payer_Common_Code.Trim();

        //    // 2️⃣ EXACT match on normalized payer name
        //    var normalized = list.FirstOrDefault(p =>
        //        p.Payer_Name_Normalized.Equals(carrierNorm, StringComparison.OrdinalIgnoreCase));

        //    if (normalized != null && !string.IsNullOrWhiteSpace(normalized.Payer_Common_Code))
        //        return normalized.Payer_Common_Code.Trim();

        //    // 3️⃣ CONTAINS match (safe fallback)
        //    var contains = list.FirstOrDefault(p =>
        //        carrierNorm.Contains(p.Payer_Name_Raw, StringComparison.OrdinalIgnoreCase) ||
        //        carrierNorm.Contains(p.Payer_Name_Normalized, StringComparison.OrdinalIgnoreCase));

        //    if (contains != null && !string.IsNullOrWhiteSpace(contains.Payer_Common_Code))
        //        return contains.Payer_Common_Code.Trim();

        //    // 4️⃣ TRUE fallback (only when NOTHING matched)
        //    return "Other Commercial";
        //}

        private string GetPayerCommonCode(
    string carrier,
    List<PayerMasterRecord> list,
    out string payerNameNormalized)
        {
            payerNameNormalized = null;

            if (string.IsNullOrWhiteSpace(carrier) || list == null || list.Count == 0)
                return "Other Commercial";

            string carrierNorm = carrier.Trim().ToUpperInvariant();

            // ✅ EXACT match on Payer_Name_Raw ONLY
            var match = list.FirstOrDefault(p =>
                !string.IsNullOrWhiteSpace(p.Payer_Name_Raw) &&
                p.Payer_Name_Raw.Trim().ToUpperInvariant() == carrierNorm);

            if (match != null &&
                !string.IsNullOrWhiteSpace(match.Payer_Common_Code))
            {
                payerNameNormalized = match.Payer_Name_Normalized?.Trim();
                return match.Payer_Common_Code.Trim();
            }

            // ❌ No fuzzy / contains / fallback matching
            return "Other Commercial";
        }

        private string GetPayerNormalizedName(
    string carrier,
    List<PayerMasterRecord> list)
        {
            if (string.IsNullOrWhiteSpace(carrier) || list == null)
                return null;

            string c = carrier.Trim();

            // 🔒 EXACT MATCH ONLY — NO FALLBACK
            var exact = list.FirstOrDefault(p =>
                !string.IsNullOrWhiteSpace(p.Payer_Name_Raw) &&
                string.Equals(
                    p.Payer_Name_Raw.Trim(),
                    c,
                    StringComparison.OrdinalIgnoreCase));

            return exact?.Payer_Name_Normalized;
        }


        // ================= MODEL =================
        private class AggregateRow
        {
            public string PayerCommonCode;
            public string PayerName;
            public string PayerNameNormalized;
            public string CPTCode;
            public int RowCount;
            public decimal BilledSum;
            public decimal AllowedSum;
            public decimal InsuranceSum;
            public decimal PatientBalanceSum;
            public decimal PatientPaymentSum;
        }
    }
}
