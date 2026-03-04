namespace DenialDatabaseProcessorWorker.Services;

public sealed class DenialDatabaseBuilder
{
    private readonly DenialCodeNormalizer _normalizer;

    public DenialDatabaseBuilder(DenialCodeNormalizer normalizer)
    {
        _normalizer = normalizer;
    }

    /// <summary>
    /// Adds normalized + mapped columns to PayerPolicy rows (in-place) and returns the final header list.
    /// IMPORTANT: Output includes ALL original PayerPolicy columns (in the same order), plus new columns.
    /// </summary>
    public (List<string> Headers, List<Dictionary<string, string>> Rows) Build(
        List<string> payerPolicyHeaders,
        List<Dictionary<string, string>> payerPolicyRows,
        ClaimActionMapperIndex mapperIndex,
        string denialCodeHeader = "DenialCode")
    {
        if (payerPolicyRows.Count == 0)
            return (payerPolicyHeaders, payerPolicyRows);

        // Find the real DenialCode header (case-insensitive + normalized match)
        var headerKey =
            payerPolicyHeaders.FirstOrDefault(h => string.Equals(h, denialCodeHeader, StringComparison.OrdinalIgnoreCase))
            ?? payerPolicyHeaders.FirstOrDefault(h => NormalizeHeader(h) == NormalizeHeader(denialCodeHeader))
            ?? denialCodeHeader;

        // New / enrichment headers
        var extraHeaders = new List<string>
        {
            "DenialCode_Original",
            "DenialCode_Normalized",

            "Payer Policy Validation Required",
            "CPT Validation Required",
            "ICD Validation Required",
            "Frequency Validation Required",
            "Gender Validation Required",
            "MUE Validation Required",

            // keep both, because your input mapper uses "Action Code" but your requirement mentions "Status Action Code"
            "Status Action Code",
            "Task Guidance"
        };

        // We will also update these existing columns if present, otherwise create them:
        var upsertHeaders = new List<string>
        {
            "Denial Description",
            "Denial Classification",
            "Denial Type",
            "Payability",
            "Action Code",
            "Recommended Action"
        };

        // Build final headers preserving payerPolicyHeaders order
        var finalHeaders = new List<string>(payerPolicyHeaders);

        // Insert DenialCode_Original and DenialCode_Normalized right after DenialCode column if possible
        var denialIdx = finalHeaders.FindIndex(h => string.Equals(h, headerKey, StringComparison.OrdinalIgnoreCase));
        if (denialIdx >= 0)
        {
            InsertIfMissing(finalHeaders, denialIdx + 1, "DenialCode_Original");
            InsertIfMissing(finalHeaders, denialIdx + 2, "DenialCode_Normalized");
        }
        else
        {
            AddIfMissing(finalHeaders, "DenialCode_Original");
            AddIfMissing(finalHeaders, "DenialCode_Normalized");
        }

        // Ensure upsert headers exist (if not, add near the end)
        foreach (var h in upsertHeaders)
            AddIfMissing(finalHeaders, h);

        // Ensure extra headers exist
        foreach (var h in extraHeaders)
            AddIfMissing(finalHeaders, h);

        // Process rows
        foreach (var row in payerPolicyRows)
        {
            row.TryGetValue(headerKey, out var rawDenialCode);
            rawDenialCode ??= "";

            var codes = _normalizer.SplitToCodes(rawDenialCode);
            var normalized = string.Join(",", codes);

            row["DenialCode_Original"] = rawDenialCode;
            row["DenialCode_Normalized"] = normalized;

            // Normalize the DenialCode column itself (this matches your requirement)
            row[headerKey] = normalized;

            // Map fields (split code mapping -> comma join)
            var mapped = mapperIndex.MapForCodes(codes);

            // Upsert/overwrite
            row["Denial Description"] = mapped.DenialDescription;
            row["Denial Classification"] = mapped.DenialClassification;
            row["Denial Type"] = mapped.DenialType;

            row["Payer Policy Validation Required"] = mapped.PayerPolicyValidationRequired;
            row["CPT Validation Required"] = mapped.CptValidationRequired;
            row["ICD Validation Required"] = mapped.IcdValidationRequired;
            row["Frequency Validation Required"] = mapped.FrequencyValidationRequired;
            row["Gender Validation Required"] = mapped.GenderValidationRequired;
            row["MUE Validation Required"] = mapped.MueValidationRequired;

            // Payability
            row["Payability"] = mapped.Payability;

            // Action code fields
            row["Action Code"] = mapped.StatusActionCode;
            row["Status Action Code"] = mapped.StatusActionCode;

            row["Recommended Action"] = mapped.RecommendedAction;
            row["Task Guidance"] = mapped.TaskGuidance;
        }

        return (finalHeaders, payerPolicyRows);
    }

    private static void AddIfMissing(List<string> headers, string header)
    {
        if (!headers.Contains(header, StringComparer.OrdinalIgnoreCase))
            headers.Add(header);
    }

    private static void InsertIfMissing(List<string> headers, int index, string header)
    {
        if (headers.Contains(header, StringComparer.OrdinalIgnoreCase))
            return;

        index = Math.Clamp(index, 0, headers.Count);
        headers.Insert(index, header);
    }

    private static string NormalizeHeader(string s)
    {
        if (string.IsNullOrWhiteSpace(s)) return "";
        return new string(s
            .Where(ch => char.IsLetterOrDigit(ch))
            .Select(char.ToLowerInvariant)
            .ToArray());
    }
}
