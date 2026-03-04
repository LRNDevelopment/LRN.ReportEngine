namespace DenialDatabaseProcessorWorker.Services;

public static class ClaimActionMapperIndexMappingExtensions
{
    public sealed record MappedValues(
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

    /// <summary>
    /// Rules:
    /// - Denial Description, Denial Classification => CODE - Value (all denial types)
    /// - Denial Type and all Validation Required columns => plain values (no code prefix) (all denial types)
    /// - Action/Recommended/Task => ONLY from Denial Type == "Claim Level Denial"
    ///   Additionally: normalize repeated descriptions by grouping multiple codes with same value:
    ///   CO97, OA94 - CORRECT_AND_RESUBMIT (instead of two separate entries).
    /// </summary>
    public static MappedValues MapForCodes(this ClaimActionMapperIndex index, IReadOnlyList<string> codes)
    {
        if (codes == null || codes.Count == 0)
            return new("", "", "", "", "", "", "", "", "", "", "", "", "");

        const string claimLevel = "Claim Level Denial";

        // CODE-prefixed columns
        var denialDescription = new List<string>();
        var denialClassification = new List<string>();

        // Plain columns
        var denialType = new List<string>();
        var ppv = new List<string>();
        var cpt = new List<string>();
        var icd = new List<string>();
        var freq = new List<string>();
        var gender = new List<string>();
        var mue = new List<string>();
        var payability = new List<string>();

        // Claim-level only, grouped by value => [value] -> codes
        var statusActionByValue = new Dictionary<string, List<string>>(StringComparer.OrdinalIgnoreCase);
        var recommendedByValue = new Dictionary<string, List<string>>(StringComparer.OrdinalIgnoreCase);
        var guidanceByValue = new Dictionary<string, List<string>>(StringComparer.OrdinalIgnoreCase);

        foreach (var code in codes)
        {
            var rowsAll = index.FindByPrefix(code);
            if (rowsAll.Count == 0)
                continue;

            foreach (var r in rowsAll)
            {
                AddPair(denialDescription, code, r.DenialDescription);
                AddPair(denialClassification, code, r.DenialClassification);

                AddPlain(denialType, r.DenialType);

                AddPlain(ppv, r.PayerPolicyValidationRequired);
                AddPlain(cpt, r.CptValidationRequired);
                AddPlain(icd, r.IcdValidationRequired);
                AddPlain(freq, r.FrequencyValidationRequired);
                AddPlain(gender, r.GenderValidationRequired);
                AddPlain(mue, r.MueValidationRequired);

                AddPlain(payability, r.Payability);
            }

            // claim-level only for action columns
            foreach (var r in rowsAll.Where(r =>
                         string.Equals((r.DenialType ?? "").Trim(), claimLevel, StringComparison.OrdinalIgnoreCase)))
            {
                AddGrouped(statusActionByValue, r.StatusActionCode, code);
                AddGrouped(recommendedByValue, r.RecommendedAction, code);
                AddGrouped(guidanceByValue, r.TaskGuidance, code);
            }
        }

        return new MappedValues(
            DenialDescription: Join(denialDescription),
            DenialClassification: Join(denialClassification),
            DenialType: JoinPlain(denialType),

            PayerPolicyValidationRequired: JoinPlain(ppv),
            CptValidationRequired: JoinPlain(cpt),
            IcdValidationRequired: JoinPlain(icd),
            FrequencyValidationRequired: JoinPlain(freq),
            GenderValidationRequired: JoinPlain(gender),
            MueValidationRequired: JoinPlain(mue),

            Payability: JoinPlain(payability),

            StatusActionCode: JoinGrouped(statusActionByValue),
            RecommendedAction: JoinGrouped(recommendedByValue),
            TaskGuidance: JoinGrouped(guidanceByValue)
        );

        static void AddPair(List<string> list, string code, string? value)
        {
            value = (value ?? "").Trim();
            if (string.IsNullOrWhiteSpace(value))
                return;

            var item = $"{code} - {value}";
            if (!list.Any(x => string.Equals(x, item, StringComparison.OrdinalIgnoreCase)))
                list.Add(item);
        }

        static void AddPlain(List<string> list, string? value)
        {
            value = (value ?? "").Trim();
            if (string.IsNullOrWhiteSpace(value))
                return;

            if (!list.Any(x => string.Equals(x, value, StringComparison.OrdinalIgnoreCase)))
                list.Add(value);
        }

        static void AddGrouped(Dictionary<string, List<string>> byValue, string? value, string code)
        {
            value = (value ?? "").Trim();
            if (string.IsNullOrWhiteSpace(value))
                return;

            if (!byValue.TryGetValue(value, out var codes))
            {
                codes = new List<string>();
                byValue[value] = codes;
            }

            if (!codes.Any(c => string.Equals(c, code, StringComparison.OrdinalIgnoreCase)))
                codes.Add(code);
        }

        static string Join(List<string> list) =>
            string.Join(", ", list.Where(s => !string.IsNullOrWhiteSpace(s)));

        static string JoinPlain(List<string> list) =>
            string.Join(", ", list.Where(s => !string.IsNullOrWhiteSpace(s)));

        static string JoinGrouped(Dictionary<string, List<string>> byValue)
        {
            // preserve insertion order by iterating keys in dict insertion order
            var parts = new List<string>();
            foreach (var kv in byValue)
            {
                var value = kv.Key;
                var codes = kv.Value.Where(c => !string.IsNullOrWhiteSpace(c)).ToList();
                if (codes.Count == 0) continue;

                parts.Add($"{string.Join(", ", codes)} - {value}");
            }
            return string.Join(", ", parts);
        }
    }
}
