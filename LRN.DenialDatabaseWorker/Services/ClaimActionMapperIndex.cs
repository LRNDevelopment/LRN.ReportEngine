namespace DenialDatabaseProcessorWorker.Services;

public sealed class ClaimActionMapperIndex
{
    public sealed record MapperRow(
        string DenialCode,
        string DenialDescription,
        string DenialClassification,
        string IcdComplianceStatus,
        string DenialValidity,
        string ActionCode,
        string RecommendedAction,
        string ActionCategory,
        string Task,
        string ShortCategory,
        string Priority,
        string SlaDays,
        string NotesComments);

    private readonly Dictionary<string, List<MapperRow>> _byCode;

    public ClaimActionMapperIndex(List<Dictionary<string, string>> rows)
    {
        _byCode = Build(rows);
    }

    public IReadOnlyList<MapperRow> FindByCode(string denialCode)
        => _byCode.TryGetValue((denialCode ?? "").Trim().ToUpperInvariant(), out var list)
            ? list
            : Array.Empty<MapperRow>();

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
            var denialCode = Get(r,
                "Denial Code",
                "DenialCode",
                "Denial Code_Prefix",
                "DenialCodePrefix",
                "Denial code_prefix",
                "Denail code_prefix");

            denialCode = (denialCode ?? "").Trim().ToUpperInvariant();
            if (string.IsNullOrWhiteSpace(denialCode))
                continue;

            var row = new MapperRow(
                DenialCode: denialCode,
                DenialDescription: Get(r, "Denial Description"),
                DenialClassification: Get(r, "Denial Classification"),
                IcdComplianceStatus: Get(r, "ICD Compliance Status", "Icd Compliance Status"),
                DenialValidity: Get(r, "Denial Validity"),
                ActionCode: Get(r, "Action Code", "Status Action Code"),
                RecommendedAction: Get(r, "Recommended Action"),
                ActionCategory: Get(r, "Action Category"),
                Task: Get(r, "Task", "Task Guidance"),
                ShortCategory: Get(r, "Short Category"),
                Priority: Get(r, "Priority"),
                SlaDays: Get(r, "SLA (Days)", "SLA Days", "SlaDays"),
                NotesComments: Get(r, "Notes / Comments", "Notes/Comments", "Notes Comments")
            );

            if (!dict.TryGetValue(denialCode, out var list))
            {
                list = new List<MapperRow>();
                dict[denialCode] = list;
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
