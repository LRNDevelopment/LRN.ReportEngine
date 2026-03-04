namespace DenialDatabaseProcessorWorker.Services;

public sealed class DenialDatabaseBuilder
{
    private readonly DenialCodeNormalizer _normalizer;

    public DenialDatabaseBuilder(DenialCodeNormalizer normalizer)
    {
        _normalizer = normalizer;
    }

    public (List<string> Headers, List<Dictionary<string, string>> Rows) Build(
        List<Dictionary<string, string>> payerPolicyRows,
        ClaimActionMapperIndex claimMapperIndex,
        PolicyActionMapperIndex? policyActionMapperIndex,
        string denialCodeHeader = "DenialCode")
    {
        // Extract headers from first row
        var payerPolicyHeaders = payerPolicyRows.Count > 0
            ? payerPolicyRows[0].Keys.ToList()
            : new List<string>();

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

            "Status Action Code",
            "Task Guidance"
        };

        // Headers that should be overwritten or created
        var upsertHeaders = new List<string>
        {
            "Denial Description",
            "Denial Classification",
            "Denial Type",
            "Payability",
            "Action Code",
            "Recommended Action"
        };

        // Build final headers preserving original order
        var finalHeaders = new List<string>(payerPolicyHeaders);

        // Insert normalized columns after DenialCode
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

        // Ensure upsert headers exist
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

            // Normalize the DenialCode column itself
            row[headerKey] = normalized;

            // Claim-level mapping
            var mapped = claimMapperIndex.MapForCodes(codes);

            row["Denial Description"] = mapped.DenialDescription;
            row["Denial Classification"] = mapped.DenialClassification;
            row["Denial Type"] = mapped.DenialType;

            row["Payer Policy Validation Required"] = mapped.PayerPolicyValidationRequired;
            row["CPT Validation Required"] = mapped.CptValidationRequired;
            row["ICD Validation Required"] = mapped.IcdValidationRequired;
            row["Frequency Validation Required"] = mapped.FrequencyValidationRequired;
            row["Gender Validation Required"] = mapped.GenderValidationRequired;
            row["MUE Validation Required"] = mapped.MueValidationRequired;

            row["Payability"] = mapped.Payability;

            row["Action Code"] = mapped.StatusActionCode;
            row["Status Action Code"] = mapped.StatusActionCode;

            row["Recommended Action"] = mapped.RecommendedAction;
            row["Task Guidance"] = mapped.TaskGuidance;

            // Policy-level mapping
            if (policyActionMapperIndex != null)
            {
                row.TryGetValue("Coverage Status", out var coverageStatus);
                row.TryGetValue("ICD Compliance Status", out var icdComplianceStatus);

                row.TryGetValue("Denial Type", out var denialTypeField);
                denialTypeField ??= "";

                var denialTypes = denialTypeField
                    .Split(',', StringSplitOptions.RemoveEmptyEntries | StringSplitOptions.TrimEntries)
                    .Where(t => !string.IsNullOrWhiteSpace(t))
                    .ToList();

                var denialValidityVals = new List<string>();
                var policyActionCodes = new List<string>();
                var policyRecommended = new List<string>();
                var policyTasks = new List<string>();

                foreach (var dt in denialTypes)
                {
                    var matches = policyActionMapperIndex.FindMatches(dt, coverageStatus ?? "", icdComplianceStatus ?? "");
                    foreach (var m in matches)
                    {
                        AddPlain(denialValidityVals, m.DenialValidity);
                        AddPlain(policyActionCodes, m.ActionCode);
                        AddPlain(policyRecommended, m.RecommendedAction);
                        AddPlain(policyTasks, m.Task);
                    }
                }

                if (denialValidityVals.Count > 0)
                    row["Denial Validity"] = string.Join(", ", denialValidityVals);

                MergeInto(row, "Action Code", policyActionCodes);
                MergeInto(row, "Status Action Code", policyActionCodes);
                MergeInto(row, "Recommended Action", policyRecommended);
                MergeInto(row, "Task Guidance", policyTasks);
            }
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

    private static void AddPlain(List<string> list, string? value)
    {
        value = (value ?? "").Trim();
        if (string.IsNullOrWhiteSpace(value))
            return;

        if (!list.Any(x => string.Equals(x, value, StringComparison.OrdinalIgnoreCase)))
            list.Add(value);
    }

    private static void MergeInto(Dictionary<string, string> row, string key, List<string> addValues)
    {
        if (addValues == null || addValues.Count == 0)
            return;

        row.TryGetValue(key, out var existing);
        existing ??= "";

        var existingParts = existing
            .Split(',', StringSplitOptions.RemoveEmptyEntries | StringSplitOptions.TrimEntries)
            .Where(x => !string.IsNullOrWhiteSpace(x))
            .ToList();

        foreach (var v in addValues)
        {
            if (!existingParts.Any(x => string.Equals(x, v, StringComparison.OrdinalIgnoreCase)))
                existingParts.Add(v);
        }

        row[key] = string.Join(", ", existingParts);
    }
}