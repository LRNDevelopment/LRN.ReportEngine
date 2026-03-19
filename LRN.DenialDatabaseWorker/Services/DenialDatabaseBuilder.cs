namespace DenialDatabaseProcessorWorker.Services;

public sealed class DenialDatabaseBuilder
{
    private readonly DenialCodeNormalizer _normalizer;

    public DenialDatabaseBuilder(DenialCodeNormalizer normalizer)
    {
        _normalizer = normalizer;
    }

    /// <summary>
    /// Output includes all original PayerPolicy columns (same order), plus mapped columns from
    /// ClaimActionMapper -> "Denial Classifier" sheet.
    /// </summary>
    public (List<string> Headers, List<Dictionary<string, string>> Rows) Build(
        List<Dictionary<string, string>> payerPolicyRows,
        ClaimActionMapperIndex claimMapperIndex,
        string denialCodeHeader = "DenialCode")
    {
        if (payerPolicyRows == null || payerPolicyRows.Count == 0)
            return (new List<string>(), payerPolicyRows ?? new List<Dictionary<string, string>>());

        var baseHeaders = payerPolicyRows[0].Keys.ToList();
        var denialCodeKey = ResolveHeaderKey(baseHeaders, denialCodeHeader);

        var finalHeaders = new List<string>(baseHeaders);

        var denialIdx = finalHeaders.FindIndex(h => string.Equals(h, denialCodeKey, StringComparison.OrdinalIgnoreCase));
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

        AddIfMissing(finalHeaders, "Denial Description");
        AddIfMissing(finalHeaders, "Denial Classification");
        AddIfMissing(finalHeaders, "Denial Type");
        AddIfMissing(finalHeaders, "Denial Validity");
        AddIfMissing(finalHeaders, "Action Category");
        AddIfMissing(finalHeaders, "Action Code");
        AddIfMissing(finalHeaders, "Status Action Code");
        AddIfMissing(finalHeaders, "Recommended Action");
        AddIfMissing(finalHeaders, "Task Guidance");
        AddIfMissing(finalHeaders, "Short Category");
        AddIfMissing(finalHeaders, "Priority");
        AddIfMissing(finalHeaders, "SLA (Days)");
        AddIfMissing(finalHeaders, "Notes / Comments");

        foreach (var row in payerPolicyRows)
        {
            row.TryGetValue(denialCodeKey, out var rawDenialCode);
            rawDenialCode ??= "";

            var codes = _normalizer.SplitToCodes(rawDenialCode);
            var normalized = string.Join(",", codes);

            row["DenialCode_Original"] = rawDenialCode;
            row["DenialCode_Normalized"] = normalized;
            row[denialCodeKey] = normalized;

            var mapped = claimMapperIndex.MapForCodes(codes);

            row["Denial Description"] = mapped.DenialDescription;
            row["Denial Classification"] = mapped.DenialClassification;
            row["Denial Type"] = mapped.DenialType;
            row["Denial Validity"] = mapped.DenialValidity;
            row["Action Category"] = mapped.ActionCategory;
            row["Status Action Code"] = mapped.ActionCode;
            row["Action Code"] = mapped.ActionCode;
            row["Recommended Action"] = mapped.RecommendedAction;
            row["Task Guidance"] = mapped.TaskGuidance;
            row["Short Category"] = mapped.ShortCategory;
            row["Priority"] = mapped.Priority;
            row["SLA (Days)"] = mapped.SlaDays;
            row["Notes / Comments"] = mapped.NotesComments;
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

    private static string ResolveHeaderKey(List<string> headers, string desired)
    {
        var exact = headers.FirstOrDefault(h => string.Equals(h, desired, StringComparison.OrdinalIgnoreCase));
        if (!string.IsNullOrWhiteSpace(exact))
            return exact;

        var desiredNorm = NormalizeHeader(desired);
        var norm = headers.FirstOrDefault(h => NormalizeHeader(h) == desiredNorm);
        if (!string.IsNullOrWhiteSpace(norm))
            return norm;

        return desired;
    }

    private static string NormalizeHeader(string s)
    {
        if (string.IsNullOrWhiteSpace(s)) return "";
        return new string(s.Where(char.IsLetterOrDigit).Select(char.ToLowerInvariant).ToArray());
    }
}
