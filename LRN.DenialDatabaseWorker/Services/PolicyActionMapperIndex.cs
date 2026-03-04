namespace DenialDatabaseProcessorWorker.Services;

public sealed class PolicyActionMapperIndex
{
    public sealed record PolicyRule(
        string DenialType,
        string CoverageStatus,
        string IcdComplianceStatus,
        string DenialValidity,
        string ActionCode,
        string RecommendedAction,
        string Task);

    private readonly Dictionary<string, List<PolicyRule>> _byDenialType;

    public PolicyActionMapperIndex(List<Dictionary<string, string>> rows)
    {
        _byDenialType = Build(rows);
    }

    public IReadOnlyList<PolicyRule> FindMatches(string denialType, string coverageStatus, string icdComplianceStatus)
    {
        denialType = (denialType ?? "").Trim();
        coverageStatus = (coverageStatus ?? "").Trim();
        icdComplianceStatus = (icdComplianceStatus ?? "").Trim();

        if (string.IsNullOrWhiteSpace(denialType))
            return Array.Empty<PolicyRule>();

        if (!_byDenialType.TryGetValue(denialType, out var rules))
            return Array.Empty<PolicyRule>();

        // match with optional wildcards (blank in rule means "any")
        return rules
            .Where(r =>
                (string.IsNullOrWhiteSpace(r.CoverageStatus) || string.Equals(r.CoverageStatus.Trim(), coverageStatus, StringComparison.OrdinalIgnoreCase)) &&
                (string.IsNullOrWhiteSpace(r.IcdComplianceStatus) || string.Equals(r.IcdComplianceStatus.Trim(), icdComplianceStatus, StringComparison.OrdinalIgnoreCase))
            )
            .ToList();
    }

    private static Dictionary<string, List<PolicyRule>> Build(List<Dictionary<string, string>> rows)
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

        var dict = new Dictionary<string, List<PolicyRule>>(StringComparer.OrdinalIgnoreCase);

        foreach (var r in rows)
        {
            var denialType = Get(r, "Denial Type").Trim();
            if (string.IsNullOrWhiteSpace(denialType))
                continue;

            var rule = new PolicyRule(
                DenialType: denialType,
                CoverageStatus: Get(r, "Coverage Status"),
                IcdComplianceStatus: Get(r, "ICD Compliance Status"),
                DenialValidity: Get(r, "Denial Validity"),
                ActionCode: Get(r, "Action Code"),
                RecommendedAction: Get(r, "Recommended Action"),
                Task: Get(r, "Task")
            );

            if (!dict.TryGetValue(denialType, out var list))
            {
                list = new List<PolicyRule>();
                dict[denialType] = list;
            }

            list.Add(rule);
        }

        return dict;
    }

    private static string NormalizeHeader(string s)
    {
        if (string.IsNullOrWhiteSpace(s)) return "";
        return new string(s.Where(char.IsLetterOrDigit).Select(char.ToLowerInvariant).ToArray());
    }
}
