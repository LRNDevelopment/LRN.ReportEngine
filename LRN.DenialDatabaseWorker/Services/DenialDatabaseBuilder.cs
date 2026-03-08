namespace DenialDatabaseProcessorWorker.Services;

public sealed class DenialDatabaseBuilder
{
    private readonly DenialCodeNormalizer _normalizer;

    public DenialDatabaseBuilder(DenialCodeNormalizer normalizer)
    {
        _normalizer = normalizer;
    }

    /// <summary>
    /// Output includes ALL original PayerPolicy columns (same order), plus additional columns from mappings.
    /// </summary>
    public (List<string> Headers, List<Dictionary<string, string>> Rows) Build(
        List<Dictionary<string, string>> payerPolicyRows,
        ClaimActionMapperIndex claimMapperIndex,
        PolicyActionMapperIndex? policyActionMapperIndex,
        string denialCodeHeader = "DenialCode")
    {
        if (payerPolicyRows == null || payerPolicyRows.Count == 0)
            return (new List<string>(), payerPolicyRows ?? new List<Dictionary<string, string>>());

        // Preserve original PayerPolicy column order
        var baseHeaders = payerPolicyRows[0].Keys.ToList();

        var denialCodeKey = ResolveHeaderKey(baseHeaders, denialCodeHeader);

        // Build final headers: base + new ones
        var finalHeaders = new List<string>(baseHeaders);

        // Insert original/normalized fields after DenialCode
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

        // Columns that we fill/update
        AddIfMissing(finalHeaders, "Denial Description");
        AddIfMissing(finalHeaders, "Denial Classification");
        AddIfMissing(finalHeaders, "Denial Type");

        AddIfMissing(finalHeaders, "Payer Policy Validation Required");
        AddIfMissing(finalHeaders, "CPT Validation Required");
        AddIfMissing(finalHeaders, "ICD Validation Required");
        AddIfMissing(finalHeaders, "Frequency Validation Required");
        AddIfMissing(finalHeaders, "Gender Validation Required");
        AddIfMissing(finalHeaders, "MUE Validation Required");

        AddIfMissing(finalHeaders, "Payability");

        AddIfMissing(finalHeaders, "Action Code");
        AddIfMissing(finalHeaders, "Status Action Code");
        AddIfMissing(finalHeaders, "Recommended Action");
        AddIfMissing(finalHeaders, "Task Guidance");

        AddIfMissing(finalHeaders, "Denial Validity");

        foreach (var row in payerPolicyRows)
        {
            row.TryGetValue(denialCodeKey, out var rawDenialCode);
            rawDenialCode ??= "";

            // Normalize DenialCode
            var codes = _normalizer.SplitToCodes(rawDenialCode);
            var normalized = string.Join(",", codes);

            row["DenialCode_Original"] = rawDenialCode;
            row["DenialCode_Normalized"] = normalized;

            // Replace DenialCode cell with normalized value
            row[denialCodeKey] = normalized;

            // ClaimActionMapper mapping (split codes -> mapped values)
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

            // Action columns from ClaimActionMapper (Claim Level Denial only, grouped by value in mapper extension)
            row["Status Action Code"] = mapped.StatusActionCode;
            row["Action Code"] = mapped.StatusActionCode;
            row["Recommended Action"] = mapped.RecommendedAction;
            row["Task Guidance"] = mapped.TaskGuidance;

                        // PolicyActionMapper logic
            // Requirement:
            // - For each payer Denial Type, if ANY PolicyActionMapper rule for that Denial Type has Coverage Status = NA/N/A,
            //   then Action/Status/Recommended/Task must include "Manual Review Required".
            // - Otherwise, match by:
            //   PayerPolicy.Coverage Status == PolicyActionMapper.Coverage Status (supports "Blank" meaning payer empty)
            //   AND PayerPolicy.ICD Compliance Status == PolicyActionMapper.ICD Compliance Status (supports "Blank")
            //   then load PolicyActionMapper -> Denial Validity, Action Code, Recommended Action, Task
            if (policyActionMapperIndex != null)
            {
                var payerCoverageStatus = Get(row, "Coverage Status");
                var payerIcdComplianceStatus = Get(row, "ICD Compliance Status");

                // Payer Denial Type can contain multiple types
                var denialTypeField = Get(row, "Denial Type");

                var denialTypes = denialTypeField
                    .Split(',', StringSplitOptions.RemoveEmptyEntries | StringSplitOptions.TrimEntries)
                    .Where(t => !string.IsNullOrWhiteSpace(t))
                    .ToList();

                var denialValidityVals = new List<string>();
                var policyActionCodes = new List<string>();
                var policyRecommended = new List<string>();
                var policyTasks = new List<string>();

                bool manualReviewRequired = false;

                foreach (var dt in denialTypes)
                {
                    // Step 1: if PolicyActionMapper has NA/N/A coverage rule for this Denial Type => manual review required
                    var allRules = policyActionMapperIndex.GetRules(dt);
                    if (allRules.Any(r => PolicyActionMapperIndex.IsNaRule(r.CoverageStatus)))
                    {
                        manualReviewRequired = true;
                        continue; // do not perform exact matching for this denial type
                    }

                    // Step 2: exact matching (with "Blank" support handled inside FindMatches)
                    var matches = policyActionMapperIndex.FindMatches(dt, payerCoverageStatus, payerIcdComplianceStatus);
                    foreach (var m in matches)
                    {
                        AddDistinct(denialValidityVals, m.DenialValidity);
                        AddDistinct(policyActionCodes, m.ActionCode);
                        AddDistinct(policyRecommended, m.RecommendedAction);
                        AddDistinct(policyTasks, m.Task);
                    }
                }

                if (denialValidityVals.Count > 0)
                    row["Denial Validity"] = string.Join(", ", denialValidityVals);

                // Merge policy outputs into existing columns (preserve existing claim-level values too)
                MergeInto(row, "Action Code", policyActionCodes);
                MergeInto(row, "Status Action Code", policyActionCodes);
                MergeInto(row, "Recommended Action", policyRecommended);
                MergeInto(row, "Task Guidance", policyTasks);

                // Add Manual Review Required if requested by NA/N/A rule(s)
                if (manualReviewRequired)
                {
                    MergeInto(row, "Action Code", new List<string> { "Manual Review Required" });
                    MergeInto(row, "Status Action Code", new List<string> { "Manual Review Required" });
                    MergeInto(row, "Recommended Action", new List<string> { "Manual Review Required" });
                    MergeInto(row, "Task Guidance", new List<string> { "Manual Review Required" });
                }
            }

        }

        return (finalHeaders, payerPolicyRows);
    }

    private static string Get(Dictionary<string, string> row, string key)
        => row.TryGetValue(key, out var v) ? (v ?? "").Trim() : "";

    private static bool IsNaCoverage(string value)
        => string.Equals((value ?? "").Trim(), "NA", StringComparison.OrdinalIgnoreCase)
           || string.Equals((value ?? "").Trim(), "N/A", StringComparison.OrdinalIgnoreCase);

    private static void EnsureManual(Dictionary<string, string> row, string key)
    {
        row.TryGetValue(key, out var existing);
        existing ??= "";
        if (string.IsNullOrWhiteSpace(existing))
            row[key] = "Manual Review Required";
    }

    private static void AddDistinct(List<string> list, string? value)
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
        // Try case-insensitive exact match first
        var exact = headers.FirstOrDefault(h => string.Equals(h, desired, StringComparison.OrdinalIgnoreCase));
        if (!string.IsNullOrWhiteSpace(exact))
            return exact;

        // Try normalized match (remove non-alnum)
        var desiredNorm = NormalizeHeader(desired);
        var norm = headers.FirstOrDefault(h => NormalizeHeader(h) == desiredNorm);
        if (!string.IsNullOrWhiteSpace(norm))
            return norm;

        // Fallback (if payerpolicy file truly doesn't have it)
        return desired;
    }

    private static string NormalizeHeader(string s)
    {
        if (string.IsNullOrWhiteSpace(s)) return "";
        return new string(s.Where(char.IsLetterOrDigit).Select(char.ToLowerInvariant).ToArray());
    }
}
