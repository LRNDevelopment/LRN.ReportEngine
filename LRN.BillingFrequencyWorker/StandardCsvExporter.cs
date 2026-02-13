
using Microsoft.VisualBasic.FileIO;
using LRN.ExcelValidator.Models;
using System.Globalization;
using System.Text;
using System.Text.RegularExpressions;

public static class StandardCsvExporter
{
    /// <summary>
    /// Generates a standardized CSV from a raw CSV (exported from Excel sheet) using a COMMON schema JSON:
    /// - Uses Aliases to map source headers to each common column.
    /// - Normalizes all date/datetime columns to MM/dd/yyyy.
    /// - Fills metadata columns: LabID, LabName, SourceFileID (SharePoint file name), IngestedOn, RowHash.
    /// - Supports Calculation: "A + B" (A/B are COMMON schema column names).
    /// - Computes DaystoDOS/RollingDays/DaystoBill/DaystoPost using Today() and DateofService/FirstBilledDate/CheckDate.
    /// </summary>
    public static void Generate(
        string sourceCsvPath,
        int headerRow,
        string outputCsvPath,
        ColumnSchema commonSchema,
        int labId,
        string labName,
        string sourceFileName,
        DateTime ingestedOnLocal,
        ColumnSchema? labSchema = null)
    {
        if (!File.Exists(sourceCsvPath))
            throw new FileNotFoundException("Source CSV not found", sourceCsvPath);

        Directory.CreateDirectory(Path.GetDirectoryName(outputCsvPath)!);

        using var parser = new TextFieldParser(sourceCsvPath)
        {
            TextFieldType = FieldType.Delimited,
            HasFieldsEnclosedInQuotes = true,
            TrimWhiteSpace = false
        };
        parser.SetDelimiters(",");

        // Skip to header row (1-based)
        string[]? header = null;
        for (int i = 1; i <= headerRow; i++)
        {
            if (parser.EndOfData) break;
            header = parser.ReadFields();
        }
        if (header == null)
            throw new InvalidOperationException($"Header row {headerRow} not found in CSV: {sourceCsvPath}");

        // Build header lookups (exact + normalized)
        var headerExact = new Dictionary<string, int>(StringComparer.OrdinalIgnoreCase);
        var headerNorm = new Dictionary<string, int>(StringComparer.OrdinalIgnoreCase);

        for (int i = 0; i < header.Length; i++)
        {
            var h = (header[i] ?? "").Trim();
            if (string.IsNullOrWhiteSpace(h)) continue;

            if (!headerExact.ContainsKey(h))
                headerExact[h] = i;

            var hn = NormKey(h);
            if (!string.IsNullOrWhiteSpace(hn) && !headerNorm.ContainsKey(hn))
                headerNorm[hn] = i;
        }

        // Lab-level overrides: prefer lab schema headers when multiple aliases exist,
        // and support composite expressions like "[Last], [First] {Referral Name}".
        var labOv = BuildLabOverrides(labSchema);

        // For calculations: resolve by COMMON column name
        var schemaByName = commonSchema.Columns
            .Where(c => !string.IsNullOrWhiteSpace(c.Name))
            .ToDictionary(c => c.Name, c => c, StringComparer.OrdinalIgnoreCase);

        using var sw = new StreamWriter(outputCsvPath, false, new UTF8Encoding(encoderShouldEmitUTF8Identifier: true));
        sw.WriteLine(string.Join(",", commonSchema.Columns.Select(c => Escape(c.Name))));

        int rowNumber = 0;

        while (!parser.EndOfData)
        {
            var row = parser.ReadFields();
            if (row == null) continue;
            if (row.All(x => string.IsNullOrWhiteSpace(x))) continue;

            rowNumber++;

            // Cache extracted values for referenced columns (commonName -> raw string)
            var extracted = new Dictionary<string, string>(StringComparer.OrdinalIgnoreCase);

            foreach (var col in commonSchema.Columns)
            {
                if (IsMetadata(col.Name) || IsDays(col.Name))
                    continue;

                if (!string.IsNullOrWhiteSpace(col.Calculation))
                    continue;

                extracted[col.Name] = ReadValueForCommonColumn(col, row, headerExact, headerNorm, labOv);
            }

            // Dates for day calculations
            var dos = ParseDateMaybe(extracted.TryGetValue("DateofService", out var dosRaw) ? dosRaw : "");
            var firstBill = ParseDateMaybe(extracted.TryGetValue("FirstBilledDate", out var billRaw) ? billRaw : "");
            var check = ParseDateMaybe(extracted.TryGetValue("CheckDate", out var chkRaw) ? chkRaw : "");

            int? daysToDos = dos.HasValue ? (int?)(DateTime.Today - dos.Value.Date).TotalDays : null;
            int? daysToBill = firstBill.HasValue ? (int?)(DateTime.Today - firstBill.Value.Date).TotalDays : null;
            int? daysToPost = check.HasValue ? (int?)(DateTime.Today - check.Value.Date).TotalDays : null;

            string rolling = "";
            if (daysToDos.HasValue)
            {
                if (daysToDos.Value <= 90) rolling = "Rolling90";
                else if (daysToDos.Value >= 91 && daysToDos.Value <= 180) rolling = "Rolling180";
                else if (daysToDos.Value >= 181) rolling = "YTD";
            }


            // Derived pay status (uses your rule table). This is written into output column "Pay Status"
            // (or "Claim Status" if that column exists with a space).
            var insurancePayment = ParseDecimal(extracted.TryGetValue("InsurancePayment", out var ipRaw) ? ipRaw : "");
            var patientPayment = ParseDecimal(extracted.TryGetValue("PatientPayment", out var ppRaw) ? ppRaw : "");
            var totalPayments = insurancePayment + patientPayment;

            var insuranceAdjustments = ParseDecimal(extracted.TryGetValue("InsuranceAdjustments", out var iaRaw) ? iaRaw : "");
            var patientAdjustments = ParseDecimal(extracted.TryGetValue("PatientAdjustments", out var paRaw) ? paRaw : "");
            var totalAdjustments = insuranceAdjustments + patientAdjustments;

            var carrierBalance = ParseDecimal(extracted.TryGetValue("InsuranceBalance", out var cbRaw) ? cbRaw : "");
            var chargeAmount = ParseDecimal(extracted.TryGetValue("ChargeAmount", out var chRaw) ? chRaw : "");
            var denialCode = extracted.TryGetValue("DenialCode", out var dcRaw) ? dcRaw : "";

            var patientBalance = ParseDecimal(extracted.TryGetValue("PatientBalance", out var pbRaw) ? pbRaw : "");

            var payStatus = ComputePayStatus(
                totalPayments: totalPayments,
                carrierBalance: carrierBalance,
                totalAdjustments: totalAdjustments,
                chargeAmount: chargeAmount,
                denialCode: denialCode,
                carrierPayment: insurancePayment,
                patientBalance: patientBalance
            );

            var outFields = new List<string>(commonSchema.Columns.Count);

            foreach (var col in commonSchema.Columns)
            {
                string val;

                // Metadata columns
                if (col.Name.Equals("LabID", StringComparison.OrdinalIgnoreCase))
                    val = labId.ToString(CultureInfo.InvariantCulture);
                else if (col.Name.Equals("LabName", StringComparison.OrdinalIgnoreCase))
                    val = labName ?? "";
                else if (col.Name.Equals("SourceFileID", StringComparison.OrdinalIgnoreCase))
                    val = sourceFileName ?? "";
                else if (col.Name.Equals("IngestedOn", StringComparison.OrdinalIgnoreCase))
                    val = ingestedOnLocal.ToString("MM/dd/yyyy", CultureInfo.InvariantCulture);
                else if (col.Name.Equals("RowHash", StringComparison.OrdinalIgnoreCase))
                    // RowHash should be Excel-like row number: headerRow + rowNumber
                    val = (headerRow + rowNumber).ToString(CultureInfo.InvariantCulture);

                // Day-based computed columns
                else if (col.Name.Equals("DaystoDOS", StringComparison.OrdinalIgnoreCase))
                    val = daysToDos?.ToString(CultureInfo.InvariantCulture) ?? "";
                else if (col.Name.Equals("RollingDays", StringComparison.OrdinalIgnoreCase))
                    val = rolling;
                else if (col.Name.Equals("DaystoBill", StringComparison.OrdinalIgnoreCase))
                    val = daysToBill?.ToString(CultureInfo.InvariantCulture) ?? "";
                else if (col.Name.Equals("DaystoPost", StringComparison.OrdinalIgnoreCase))
                    val = daysToPost?.ToString(CultureInfo.InvariantCulture) ?? "";


                // Derived status
                else if (IsPayStatusColumn(col.Name))
                    val = payStatus;

                // Calculation columns
                else if (!string.IsNullOrWhiteSpace(col.Calculation))
                    val = EvaluateCalculation(col.Calculation!, extracted, schemaByName, row, headerExact, headerNorm, labOv);

                // Standard extracted columns
                else
                    val = extracted.TryGetValue(col.Name, out var raw) ? raw : ReadValueForCommonColumn(col, row, headerExact, headerNorm, labOv);

                // Normalize date fields based on schema datatype
                if (IsDateType(col.DataType))
                    val = NormalizeDate(val);

                outFields.Add(Escape(val));
            }

            sw.WriteLine(string.Join(",", outFields));
        }
    }

    
    // ---------------- Lab schema overrides ----------------
    // Lab schema is used to:
    // 1) Prefer certain source headers when multiple COMMON aliases exist (e.g., CPT vs Procedure).
    // 2) Support simple composite expressions in lab schema Name, like:
    //    "[Last Name], [First Name] {Referral Name}"
    //    -> Output COMMON column "Referral Name" = "Last Name, First Name"

    private sealed class LabOverrides
    {
        public HashSet<string> PreferredExact { get; } = new(StringComparer.OrdinalIgnoreCase);
        public HashSet<string> PreferredNorm { get; } = new(StringComparer.OrdinalIgnoreCase);
        public Dictionary<string, CompositeTemplate> CompositeByName { get; } = new(StringComparer.OrdinalIgnoreCase);
        public Dictionary<string, CompositeTemplate> CompositeByNorm { get; } = new(StringComparer.OrdinalIgnoreCase);
    }

    private readonly record struct CompositeSegment(bool IsColumn, string Text);

    private sealed class CompositeTemplate
    {
        public string TargetName { get; init; } = "";
        public List<CompositeSegment> Segments { get; init; } = new();
    }

    private static LabOverrides BuildLabOverrides(ColumnSchema? labSchema)
    {
        var ov = new LabOverrides();

        if (labSchema?.Columns == null)
            return ov;

        foreach (var c in labSchema.Columns)
        {
            if (c == null) continue;

            var rawName = (c.Name ?? "").Trim();
            if (string.IsNullOrWhiteSpace(rawName)) continue;

            // Composite mapping: "[A], [B] {Target}"
            if (TryParseComposite(rawName, out var tpl))
            {
                if (!string.IsNullOrWhiteSpace(tpl.TargetName))
                {
                    ov.CompositeByName[tpl.TargetName] = tpl;

                    var tn = NormKey(tpl.TargetName);
                    if (!string.IsNullOrWhiteSpace(tn))
                        ov.CompositeByNorm[tn] = tpl;
                }

                // Treat referenced headers as preferred too
                foreach (var seg in tpl.Segments.Where(s => s.IsColumn))
                {
                    var h = (seg.Text ?? "").Trim();
                    if (string.IsNullOrWhiteSpace(h)) continue;

                    ov.PreferredExact.Add(h);

                    var hn = NormKey(h);
                    if (!string.IsNullOrWhiteSpace(hn))
                        ov.PreferredNorm.Add(hn);
                }

                continue;
            }

            // Simple preferred header
            ov.PreferredExact.Add(rawName);
            var norm = NormKey(rawName);
            if (!string.IsNullOrWhiteSpace(norm))
                ov.PreferredNorm.Add(norm);

            // Some lab schemas may also include Aliases on their column specs
            if (c.Aliases != null)
            {
                foreach (var a in c.Aliases)
                {
                    var aa = (a ?? "").Trim();
                    if (string.IsNullOrWhiteSpace(aa)) continue;

                    ov.PreferredExact.Add(aa);

                    var an = NormKey(aa);
                    if (!string.IsNullOrWhiteSpace(an))
                        ov.PreferredNorm.Add(an);
                }
            }
        }

        return ov;
    }

    private static bool TryParseComposite(string raw, out CompositeTemplate template)
    {
        template = new CompositeTemplate();

        // Expect trailing "{Target}" (but allow whitespace after)
        var m = Regex.Match(raw, @"\{([^{}]+)\}\s*$");
        if (!m.Success)
            return false;

        var target = (m.Groups[1].Value ?? "").Trim();
        if (string.IsNullOrWhiteSpace(target))
            return false;

        var expr = raw.Substring(0, m.Index).TrimEnd();
        if (string.IsNullOrWhiteSpace(expr))
            return false;

        var segs = new List<CompositeSegment>();
        int pos = 0;

        foreach (Match bm in Regex.Matches(expr, @"\[(?<col>[^\]]+)\]"))
        {
            if (bm.Index > pos)
            {
                segs.Add(new CompositeSegment(false, expr.Substring(pos, bm.Index - pos)));
            }

            var col = (bm.Groups["col"].Value ?? "").Trim();
            segs.Add(new CompositeSegment(true, col));

            pos = bm.Index + bm.Length;
        }

        if (pos < expr.Length)
            segs.Add(new CompositeSegment(false, expr.Substring(pos)));

        // Must contain at least one [col]
        if (!segs.Any(s => s.IsColumn))
            return false;

        template = new CompositeTemplate
        {
            TargetName = target,
            Segments = segs
        };

        return true;
    }

    private static string ReadValueForCommonColumn(
        ColumnSpec col,
        string[] row,
        Dictionary<string, int> headerExact,
        Dictionary<string, int> headerNorm,
        LabOverrides labOv)
    {
        // Composite overrides: match by COMMON column name OR by COMMON aliases.
        // Example:
        //  COMMON BillingProvider has alias "Referral Name"
        //  LAB schema: "[Last], [First] {Referral Name}"
        //  => populate BillingProvider using the composite.
        if (TryGetCompositeForCommonColumn(col, labOv, out var tpl))
            return EvaluateComposite(tpl, row, headerExact, headerNorm);

        return ReadByAliases(col, row, headerExact, headerNorm, labOv);
    }

    private static bool TryGetCompositeForCommonColumn(
        ColumnSpec col,
        LabOverrides labOv,
        out CompositeTemplate tpl)
    {
        // 1) exact match by COMMON name
        if (labOv.CompositeByName.TryGetValue(col.Name, out tpl))
            return true;

        // 2) exact match by COMMON aliases
        if (col.Aliases != null)
        {
            foreach (var a in col.Aliases)
            {
                var aa = (a ?? "").Trim();
                if (string.IsNullOrWhiteSpace(aa)) continue;

                if (labOv.CompositeByName.TryGetValue(aa, out tpl))
                    return true;
            }
        }

        // 3) normalized match by COMMON name
        var nn = NormKey(col.Name);
        if (!string.IsNullOrWhiteSpace(nn) && labOv.CompositeByNorm.TryGetValue(nn, out tpl))
            return true;

        // 4) normalized match by COMMON aliases
        if (col.Aliases != null)
        {
            foreach (var a in col.Aliases)
            {
                var aa = (a ?? "").Trim();
                if (string.IsNullOrWhiteSpace(aa)) continue;

                var an = NormKey(aa);
                if (!string.IsNullOrWhiteSpace(an) && labOv.CompositeByNorm.TryGetValue(an, out tpl))
                    return true;
            }
        }

        tpl = null!;
        return false;
    }

    private static string EvaluateComposite(
        CompositeTemplate tpl,
        string[] row,
        Dictionary<string, int> headerExact,
        Dictionary<string, int> headerNorm)
    {
        // Pre-evaluate all column segments
        var segVals = new List<(CompositeSegment Seg, string Val)>(tpl.Segments.Count);
        foreach (var seg in tpl.Segments)
        {
            if (!seg.IsColumn)
            {
                segVals.Add((seg, seg.Text ?? ""));
                continue;
            }

            var v = ReadHeaderValue(seg.Text, row, headerExact, headerNorm);
            segVals.Add((seg, v));
        }

        var nonEmptyRefIdx = segVals
            .Select((x, i) => (x, i))
            .Where(t => t.x.Seg.IsColumn && !string.IsNullOrWhiteSpace(t.x.Val))
            .Select(t => t.i)
            .ToList();

        if (nonEmptyRefIdx.Count == 0)
            return "";

        int first = nonEmptyRefIdx.First();
        int last = nonEmptyRefIdx.Last();

        var sb = new StringBuilder();
        bool hasAny = false;

        for (int i = 0; i < segVals.Count; i++)
        {
            var (seg, val) = segVals[i];

            if (seg.IsColumn)
            {
                if (string.IsNullOrWhiteSpace(val))
                    continue;

                sb.Append(val);
                hasAny = true;
                continue;
            }

            // literal segment
            var lit = val ?? "";
            if (string.IsNullOrEmpty(lit))
                continue;

            // Keep prefix/suffix literals only if they contain letters/digits (e.g., "Dr ")
            bool hasAlphaNum = lit.Any(ch => char.IsLetterOrDigit(ch));

            if (i < first)
            {
                if (hasAlphaNum)
                    sb.Append(lit);
                continue;
            }

            if (i > last)
            {
                if (hasAlphaNum)
                    sb.Append(lit);
                continue;
            }

            // Between two non-empty values -> keep separators exactly
            if (hasAny)
                sb.Append(lit);
        }

        return sb.ToString().Trim();
    }

    private static string ReadHeaderValue(
        string headerName,
        string[] row,
        Dictionary<string, int> headerExact,
        Dictionary<string, int> headerNorm)
    {
        var key = (headerName ?? "").Trim();
        if (string.IsNullOrWhiteSpace(key)) return "";

        if (headerExact.TryGetValue(key, out int idx))
            return Get(row, idx);

        var kn = NormKey(key);
        if (!string.IsNullOrWhiteSpace(kn) && headerNorm.TryGetValue(kn, out idx))
            return Get(row, idx);

        return "";
    }

private static string ReadByAliases(ColumnSpec col, string[] row, Dictionary<string, int> headerExact, Dictionary<string, int> headerNorm,
        LabOverrides labOv)
    {
        var candidates = (col.Aliases ?? new List<string>())
            .Where(a => !string.IsNullOrWhiteSpace(a))
            .Concat(new[] { col.Name })
            .Select(a => (a ?? "").Trim())
            .Where(a => !string.IsNullOrWhiteSpace(a))
            .ToList();

        // Prefer headers explicitly present in the LAB schema when multiple COMMON aliases exist.
        var ordered = new List<string>(candidates.Count);
        var seen = new HashSet<string>(StringComparer.OrdinalIgnoreCase);

        // Preferred first (stable order)
        foreach (var c in candidates)
        {
            var cn = NormKey(c);
            var isPref = labOv.PreferredExact.Contains(c) || (!string.IsNullOrWhiteSpace(cn) && labOv.PreferredNorm.Contains(cn));
            if (!isPref) continue;

            if (seen.Add(c))
                ordered.Add(c);
        }

        // Then the remaining candidates
        foreach (var c in candidates)
        {
            var cn = NormKey(c);
            var isPref = labOv.PreferredExact.Contains(c) || (!string.IsNullOrWhiteSpace(cn) && labOv.PreferredNorm.Contains(cn));
            if (isPref) continue;

            if (seen.Add(c))
                ordered.Add(c);
        }

        foreach (var cand in ordered)
        {
            var c = (cand ?? "").Trim();
            if (string.IsNullOrWhiteSpace(c)) continue;

            if (headerExact.TryGetValue(c, out int idx))
                return Get(row, idx);

            var cn = NormKey(c);
            if (!string.IsNullOrWhiteSpace(cn) && headerNorm.TryGetValue(cn, out idx))
                return Get(row, idx);
        }

        return "";
    }

    private static string EvaluateCalculation(
        string expr,
        Dictionary<string, string> extracted,
        Dictionary<string, ColumnSpec> schemaByName,
        string[] row,
        Dictionary<string, int> headerExact,
        Dictionary<string, int> headerNorm,
        LabOverrides labOv)
    {
        decimal sum = 0m;
        bool hadAny = false;

        foreach (var token in expr.Split('+', StringSplitOptions.RemoveEmptyEntries))
        {
            var key = token.Trim();
            if (string.IsNullOrWhiteSpace(key)) continue;

            string raw = "";

            if (schemaByName.TryGetValue(key, out var refCol))
            {
                if (!extracted.TryGetValue(refCol.Name, out raw))
                    raw = ReadValueForCommonColumn(refCol, row, headerExact, headerNorm, labOv);
            }
            else
            {
                if (headerExact.TryGetValue(key, out int idx))
                    raw = Get(row, idx);
                else
                {
                    var kn = NormKey(key);
                    if (!string.IsNullOrWhiteSpace(kn) && headerNorm.TryGetValue(kn, out idx))
                        raw = Get(row, idx);
                }
            }

            if (!string.IsNullOrWhiteSpace(raw))
                hadAny = true;

            sum += ParseDecimal(raw);
        }

        return hadAny ? sum.ToString(CultureInfo.InvariantCulture) : "";
    }

    private static bool IsDateType(string? dt)
        => (dt ?? "").Trim().Equals("date", StringComparison.OrdinalIgnoreCase)
        || (dt ?? "").Trim().Equals("datetime", StringComparison.OrdinalIgnoreCase);

    private static bool IsMetadata(string name)
        => name.Equals("LabID", StringComparison.OrdinalIgnoreCase)
        || name.Equals("LabName", StringComparison.OrdinalIgnoreCase)
        || name.Equals("SourceFileID", StringComparison.OrdinalIgnoreCase)
        || name.Equals("IngestedOn", StringComparison.OrdinalIgnoreCase)
        || name.Equals("RowHash", StringComparison.OrdinalIgnoreCase);

    private static bool IsDays(string name)
        => name.Equals("DaystoDOS", StringComparison.OrdinalIgnoreCase)
        || name.Equals("RollingDays", StringComparison.OrdinalIgnoreCase)
        || name.Equals("DaystoBill", StringComparison.OrdinalIgnoreCase)
        || name.Equals("DaystoPost", StringComparison.OrdinalIgnoreCase);


    private static bool IsPayStatusColumn(string name)
    {
        // Only treat columns explicitly named with a SPACE as derived status columns,
        // so we do NOT override the existing raw "ClaimStatus" field.
        var n = Regex.Replace((name ?? "").Trim(), @"\s+", " ");
        return n.Equals("Pay Status", StringComparison.OrdinalIgnoreCase)
            || n.Equals("Claim Status", StringComparison.OrdinalIgnoreCase);
    }

    private static string ComputePayStatus(
        decimal totalPayments,
        decimal carrierBalance,
        decimal totalAdjustments,
        decimal chargeAmount,
        string denialCode,
        decimal carrierPayment,
        decimal patientBalance)
    {
        static bool IsBlank(string s) => string.IsNullOrWhiteSpace(s);
        static bool IsZero(decimal d) => Math.Abs(d) < 0.01m; // currency tolerance
        static bool Eq(decimal a, decimal b) => Math.Abs(a - b) < 0.01m;
        static bool Gt(decimal a, decimal b) => a - b > 0.01m;
        static bool Ge(decimal a, decimal b) => a - b > -0.01m;

        var hasDenialCode = !IsBlank(denialCode);

        // Paid: Total Payment > 0
        if (Gt(totalPayments, 0m))
            return "Paid";

        // Adjusted: Total Payment = 0 AND Carrier Balance <= 0 AND Total Adjustment >= Charge Amount AND Denial Code = Code or Blank
        if (IsZero(totalPayments) && carrierBalance <= 0.01m && Ge(totalAdjustments, chargeAmount))
            return "Adjusted";

        // Partially Adjusted: Total Payment = 0 AND Carrier Balance > 0 AND Total Adjustment > 0 AND Denial Code = Blank
        if (IsZero(totalPayments) && Gt(carrierBalance, 0m) && Gt(totalAdjustments, 0m) && !hasDenialCode)
            return "Partially Adjusted";

        // No Response: Charge Amount = Carrier Balance AND Denial Code = Blank
        if (Eq(chargeAmount, carrierBalance) && !hasDenialCode)
            return "No Response";

        // No Response: Total Payment = 0 AND Total Adjustments = 0 AND Carrier Balance = 0 AND Denial Code = Blank
        if (IsZero(totalPayments) && IsZero(totalAdjustments) && IsZero(carrierBalance) && !hasDenialCode)
            return "No Response";

        // Denied: Total Payment = 0 AND Carrier Balance > 0 AND Denial Code = Code
        if (IsZero(totalPayments) && Gt(carrierBalance, 0m) && hasDenialCode)
            return "Denied";

        // Denied: Total Payment = 0 AND Total Adjustments = 0 AND Carrier Balance = 0 AND Denial Code = Code
        if (IsZero(totalPayments) && IsZero(totalAdjustments) && IsZero(carrierBalance) && hasDenialCode)
            return "Denied";

        // Patient Responsibility: Carrier Payment = 0 AND Patient Balance > 0
        if (IsZero(carrierPayment) && Gt(patientBalance, 0m))
            return "Patient Responsibility";

        return "";
    }


    private static string NormalizeDate(string raw)
    {
        var dt = ParseDateMaybe(raw);
        return dt.HasValue ? dt.Value.ToString("MM/dd/yyyy", CultureInfo.InvariantCulture) : "";
    }

    private static DateTime? ParseDateMaybe(string raw)
    {
        raw = (raw ?? "").Trim();
        if (string.IsNullOrWhiteSpace(raw)) return null;

        // Excel serial number
        if (double.TryParse(raw, NumberStyles.Any, CultureInfo.InvariantCulture, out var oa))
        {
            if (oa > 20000 && oa < 60000)
            {
                try { return DateTime.FromOADate(oa); } catch { }
            }
        }

        var formats = new[]
        {
            "MM/dd/yyyy","M/d/yyyy",
            "dd/MM/yyyy","d/M/yyyy",
            "yyyy-MM-dd","yyyy/M/d","yyyy/MM/dd",
            "yyyy-MM-dd HH:mm:ss","yyyy/MM/dd HH:mm:ss","MM/dd/yyyy HH:mm:ss","M/d/yyyy H:mm:ss",
            "MM/dd/yyyy h:mm:ss tt","M/d/yyyy h:mm:ss tt",
            "dd-MMM-yyyy","d-MMM-yyyy","dd-MMM-yy","d-MMM-yy"
        };

        if (DateTime.TryParseExact(raw, formats, CultureInfo.InvariantCulture, DateTimeStyles.AllowWhiteSpaces, out var dtExact))
            return dtExact;

        if (DateTime.TryParse(raw, new CultureInfo("en-SG"), DateTimeStyles.AllowWhiteSpaces, out var dtSg))
            return dtSg;

        if (DateTime.TryParse(raw, CultureInfo.InvariantCulture, DateTimeStyles.AllowWhiteSpaces, out var dtAny))
            return dtAny;

        return null;
    }

    private static decimal ParseDecimal(string raw)
    {
        raw = (raw ?? "").Trim();
        if (string.IsNullOrWhiteSpace(raw)) return 0m;

        raw = raw.Replace("$", "").Replace(",", "");

        bool neg = raw.StartsWith("(") && raw.EndsWith(")");
        if (neg) raw = raw.Trim('(', ')');

        if (decimal.TryParse(raw, NumberStyles.Any, CultureInfo.InvariantCulture, out var d))
            return neg ? -d : d;

        if (decimal.TryParse(raw, NumberStyles.Any, new CultureInfo("en-US"), out d))
            return neg ? -d : d;

        if (decimal.TryParse(raw, NumberStyles.Any, new CultureInfo("en-SG"), out d))
            return neg ? -d : d;

        return 0m;
    }

    private static string Get(string[] row, int idx)
        => idx >= 0 && idx < row.Length ? (row[idx] ?? "") : "";

    private static string NormKey(string s)
    {
        if (string.IsNullOrWhiteSpace(s)) return "";
        s = s.Trim().ToLowerInvariant();

        // Keep only letters/digits so headers match even with spaces/punctuation differences.
        var sb = new StringBuilder(s.Length);
        foreach (var ch in s)
        {
            if (char.IsLetterOrDigit(ch))
                sb.Append(ch);
        }
        return sb.ToString();
    }

    private static string Escape(string? s)
    {
        if (string.IsNullOrEmpty(s))
            return "";

        bool mustQuote = s.Contains(',') || s.Contains('"') || s.Contains('\n') || s.Contains('\r');
        if (!mustQuote)
            return s;

        return $"\"{s.Replace("\"", "\"\"")}\"";
    }
}
