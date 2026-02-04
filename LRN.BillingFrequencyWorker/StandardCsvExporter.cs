
using Microsoft.VisualBasic.FileIO;
using LRN.ExcelValidator.Models;
using System.Globalization;
using System.Text;

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
        DateTime ingestedOnLocal)
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

                extracted[col.Name] = ReadByAliases(col, row, headerExact, headerNorm);
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

                // Calculation columns
                else if (!string.IsNullOrWhiteSpace(col.Calculation))
                    val = EvaluateCalculation(col.Calculation!, extracted, schemaByName, row, headerExact, headerNorm);

                // Standard extracted columns
                else
                    val = extracted.TryGetValue(col.Name, out var raw) ? raw : ReadByAliases(col, row, headerExact, headerNorm);

                // Normalize date fields based on schema datatype
                if (IsDateType(col.DataType))
                    val = NormalizeDate(val);

                outFields.Add(Escape(val));
            }

            sw.WriteLine(string.Join(",", outFields));
        }
    }

    private static string ReadByAliases(ColumnSpec col, string[] row, Dictionary<string, int> headerExact, Dictionary<string, int> headerNorm)
    {
        var candidates = (col.Aliases ?? new List<string>())
            .Where(a => !string.IsNullOrWhiteSpace(a))
            .Concat(new[] { col.Name });

        foreach (var cand in candidates)
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
        Dictionary<string, int> headerNorm)
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
                    raw = ReadByAliases(refCol, row, headerExact, headerNorm);
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
        return s.Replace(" ", "").Replace("_", "").Replace("-", "").Replace("/", "").Replace("\\", "");
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
