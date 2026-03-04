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

    public static MappedValues MapForCodes(this ClaimActionMapperIndex index, IReadOnlyList<string> codes)
    {
        if (codes == null || codes.Count == 0)
            return new("", "", "", "", "", "", "", "", "", "", "", "", "");

        const string claimLevel = "Claim Level Denial";

        // CODE-prefixed columns (only where it helps readability)
        var denialDescription = new List<string>();
        var denialClassification = new List<string>();

        var actionCode = new List<string>();
        var recommended = new List<string>();
        var statusAction = new List<string>();
        var guidance = new List<string>();

        // Plain columns (no CODE prefix)
        var denialType = new List<string>();

        var ppv = new List<string>();
        var cpt = new List<string>();
        var icd = new List<string>();
        var freq = new List<string>();
        var gender = new List<string>();
        var mue = new List<string>();

        var payability = new List<string>();

        foreach (var code in codes)
        {
            var rowsAll = index.FindByPrefix(code);
            if (rowsAll.Count == 0)
                continue;

            // Always load these irrespective of Denial Type
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

            // Only these columns must come from Claim Level Denial rows
            foreach (var r in rowsAll.Where(r => string.Equals((r.DenialType ?? "").Trim(), claimLevel, StringComparison.OrdinalIgnoreCase)))
            {
                AddPair(actionCode, code, r.StatusActionCode);
                AddPair(recommended, code, r.RecommendedAction);
                AddPair(statusAction, code, r.StatusActionCode);
                AddPair(guidance, code, r.TaskGuidance);
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
            StatusActionCode: Join(statusAction),
            RecommendedAction: Join(recommended),
            TaskGuidance: Join(guidance)
        );

        static void AddPair(List<string> list, string code, string? value)
        {
            value = (value ?? "").Trim();
            if (string.IsNullOrWhiteSpace(value))
                return;

            var item = $"{code} - {value}";
            if (!list.Contains(item, StringComparer.OrdinalIgnoreCase))
                list.Add(item);
        }

        static void AddPlain(List<string> list, string? value)
        {
            value = (value ?? "").Trim();
            if (string.IsNullOrWhiteSpace(value))
                return;

            if (!list.Contains(value, StringComparer.OrdinalIgnoreCase))
                list.Add(value);
        }

        static string Join(List<string> list)
            => string.Join(", ", list.Where(s => !string.IsNullOrWhiteSpace(s)));

        static string JoinPlain(List<string> list)
            => string.Join(", ", list.Where(s => !string.IsNullOrWhiteSpace(s)));
    }

}
