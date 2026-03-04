namespace DenialDatabaseProcessorWorker.Services;

public sealed class ClaimActionMapperIndex
{
    public sealed record MapperRow(
        string DenialCodePrefix,
        string DenialDescription,
        string DenialClassification,
        string DenialType,
        string PayerPolicyValidationRequired,
        string CptValidationRequired,
        string IcdValidationRequired,
        string FrequencyValidationRequired,
        string GenderValidationRequired,
        string MueValidationRequired,
        string Payability,
        string StatusActionCode,
        string RecommendedAction,
        string TaskGuidance);

    private readonly Dictionary<string, List<MapperRow>> _byPrefix;

    public ClaimActionMapperIndex(List<Dictionary<string, string>> rows)
    {
        _byPrefix = Build(rows);
    }

    public IReadOnlyList<MapperRow> FindByPrefix(string prefix)
        => _byPrefix.TryGetValue(prefix, out var list) ? list : Array.Empty<MapperRow>();

    private static Dictionary<string, List<MapperRow>> Build(List<Dictionary<string, string>> rows)
    {
        string Get(Dictionary<string, string> r, params string[] candidates)
        {
            foreach (var c in candidates)
            {
                var key = r.Keys.FirstOrDefault(k => NormalizeHeader(k) == NormalizeHeader(c));
                if (key != null && r.TryGetValue(key, out var v))
                    return v?.Trim() ?? "";
            }
            return "";
        }

        var dict = new Dictionary<string, List<MapperRow>>(StringComparer.OrdinalIgnoreCase);

        foreach (var r in rows)
        {
            var prefix = Get(r,
                "Denail code_prefix",
                "Denial code_prefix",
                "Denial Code_Prefix",
                "DenialCode_Prefix",
                "Denial Code Prefix",
                "DenialCodePrefix");

            prefix = (prefix ?? "").Trim().ToUpperInvariant();
            if (string.IsNullOrWhiteSpace(prefix))
                continue;

            var row = new MapperRow(
                DenialCodePrefix: prefix,
                DenialDescription: Get(r, "Denial Description"),
                DenialClassification: Get(r, "Denial Classification"),
                DenialType: Get(r, "Denial Type"),
                PayerPolicyValidationRequired: Get(r, "Payer Policy Validation Required"),
                CptValidationRequired: Get(r, "CPT Validation Required", "Cpt Validation Required"),
                IcdValidationRequired: Get(r, "ICD Validation Required", "Icd Validation Required"),
                FrequencyValidationRequired: Get(r, "Frequency Validation Required"),
                GenderValidationRequired: Get(r, "Gender Validation Required"),
                MueValidationRequired: Get(r, "MUE Validation Required", "MUE Validation", "Mue Validation", "MUE Validation Required?"),
                Payability: Get(r, "Payability", "Payability Status"),
                StatusActionCode: Get(r, "Status Action Code", "Action Code"),
                RecommendedAction: Get(r, "Recommended Action"),
                TaskGuidance: Get(r, "Task Guidance")
            );

            if (!dict.TryGetValue(prefix, out var list))
            {
                list = new List<MapperRow>();
                dict[prefix] = list;
            }

            list.Add(row);
        }

        return dict;
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
