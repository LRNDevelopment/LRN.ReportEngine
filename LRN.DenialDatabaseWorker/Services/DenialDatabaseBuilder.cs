using DenialDatabaseProcessorWorker.Models;

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
		string denialCodeHeader = "DenialCode")
	{
		if (payerPolicyRows == null || payerPolicyRows.Count == 0)
			return (new List<string>(), payerPolicyRows ?? new List<Dictionary<string, string>>());

		var baseHeaders = payerPolicyRows[0].Keys.ToList();
		var denialCodeKey = ResolveHeaderKey(baseHeaders, denialCodeHeader);

		var finalHeaders = new List<string>(baseHeaders);

		// Insert normalized code columns
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

		// Add mapped columns
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
			// Normalize denial code
			row.TryGetValue(denialCodeKey, out var rawDenialCode);
			rawDenialCode ??= "";

			var codes = _normalizer.SplitToCodes(rawDenialCode);
			var normalized = string.Join(",", codes);

			row["DenialCode_Original"] = rawDenialCode;
			row["DenialCode_Normalized"] = normalized;
			row[denialCodeKey] = normalized;

			// Get all mapper rows for these codes
			var mapperRows = codes
				.SelectMany(code => claimMapperIndex.FindByCode(code))
				.ToList();

			if (mapperRows.Count == 0)
			{
				ClearMappedFields(row);
				continue;
			}

			// Extract payer fields
			var payerCoverage = row.GetValueOrDefault("Coverage Status") ?? "";
			var payerICD = row.GetValueOrDefault("ICD Compliance Status") ?? "";

			// Always map these fields from ANY mapper row (first row)
			var first = mapperRows.First();
			row["Denial Description"] = first.DenialDescription;
			row["Denial Classification"] = first.DenialClassification;
			row["Denial Type"] = first.DenialClassification;

			// CASE 1 — Coverage=N/A & ICD=N/A
			var case1 = mapperRows.FirstOrDefault(m =>
				m.CoverageStatus.Equals("N/A", StringComparison.OrdinalIgnoreCase) &&
				m.IcdComplianceStatus.Equals("N/A", StringComparison.OrdinalIgnoreCase)
			);

			// CASE 2 — Coverage matches & ICD matches
			var case2 = mapperRows.FirstOrDefault(m =>
				m.CoverageStatus.Equals(payerCoverage, StringComparison.OrdinalIgnoreCase) &&
				m.IcdComplianceStatus.Equals(payerICD, StringComparison.OrdinalIgnoreCase)
			);

			// CASE 3 — Coverage=N/A & ICD matches
			var case3 = mapperRows.FirstOrDefault(m =>
				m.CoverageStatus.Equals("N/A", StringComparison.OrdinalIgnoreCase) &&
				m.IcdComplianceStatus.Equals(payerICD, StringComparison.OrdinalIgnoreCase)
			);

			var match = case2 ?? case1 ?? case3;

			if (match == null)
			{
				ClearMappedFields(row);
				continue;
			}

			// Apply matched action fields
			row["Denial Validity"] = match.DenialValidity;
			row["Action Code"] = match.ActionCode;
			row["Status Action Code"] = match.ActionCode;
			row["Recommended Action"] = match.RecommendedAction;
			row["Action Category"] = match.ActionCategory;
			row["Task Guidance"] = match.Task;
			row["Short Category"] = match.ShortCategory;
			row["Priority"] = match.Priority;
			row["SLA (Days)"] = match.SlaDays;
			row["Notes / Comments"] = match.NotesComments;
		}

		return (finalHeaders, payerPolicyRows);
	}

	private static void ClearMappedFields(Dictionary<string, string> row)
	{
		row["Denial Validity"] = "";
		row["Action Category"] = "";
		row["Status Action Code"] = "";
		row["Action Code"] = "";
		row["Recommended Action"] = "";
		row["Task Guidance"] = "";
		row["Short Category"] = "";
		row["Priority"] = "";
		row["SLA (Days)"] = "";
		row["Notes / Comments"] = "";
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