namespace DenialDatabaseProcessorWorker.Services;

public sealed class DenialInsightBuilder
{
	public sealed record InsightTable(List<string> Headers, List<Dictionary<string, string>> Rows);

	public InsightTable Build(List<Dictionary<string, string>> lineRows)
	{
		if (lineRows == null || lineRows.Count == 0)
			return new InsightTable(new List<string>(), new List<Dictionary<string, string>>());

		var validRows = lineRows
		.Where(r => !string.IsNullOrWhiteSpace(r.GetValueOrDefault("DenialCode_Normalized")))
		.ToList();

		var groups = validRows.GroupBy(r => new
		{
			Code = r.GetValueOrDefault("DenialCode_Normalized") ?? "",
			Desc = r.GetValueOrDefault("Denial Description") ?? "",
			Type = r.GetValueOrDefault("Denial Type") ?? "",
			ActionCode = r.GetValueOrDefault("Action Code") ?? "",
			Action = r.GetValueOrDefault("Recommended Action") ?? "",
			Task = r.GetValueOrDefault("Task Guidance") ?? ""
		});

		var insightRows = new List<Dictionary<string, string>>();

		foreach (var g in groups)
		{
			var row = new Dictionary<string, string>();

			row["Denial Codes"] = g.Key.Code;
			row["Descriptions"] = g.Key.Desc;
			row["# of Denial"] = g.Count().ToString();

			decimal totalBalance = g.Sum(r => ParseDecimal(r, "Total Balance"));
			decimal insBalance = g.Sum(r => ParseDecimal(r, "Insurance Balance"));

			row["Total Balance ($)"] = totalBalance.ToString("0.00");
			row["Ins. Balance ($)"] = insBalance.ToString("0.00");
			row["$ Impact (%)"] = totalBalance == 0
				? "0%"
				: ((insBalance / totalBalance) * 100).ToString("0.00") + "%";

			// Highest impact payer
			row["Highest $ Impact - Insurance"] = g
				.GroupBy(r => r.GetValueOrDefault("PayerName Normalized") ?? "")
				.OrderByDescending(x => x.Sum(r => ParseDecimal(r, "Total Balance")))
				.First().Key;

			// Observation (panel detection)
			row["Observation"] = ExtractObservation(g);

			row["Data"] = "Link";
			row["Category"] = g.Key.Type;
			row["Action Code"] = g.Key.ActionCode;
			row["Action"] = g.Key.Action;
			row["Task"] = g.Key.Task;

			row["Feedback / Response"] = "";
			row["Responsibility"] = "";
			row["Discussion Date"] = "";
			row["ETA"] = "";

			insightRows.Add(row);
		}

		var headers = insightRows.First().Keys.ToList();
		return new InsightTable(headers, insightRows);
	}

	private static decimal ParseDecimal(Dictionary<string, string> row, string key)
	{
		if (row.TryGetValue(key, out var v) && decimal.TryParse(v, out var d))
			return d;
		return 0;
	}

	private static string ExtractObservation(IEnumerable<Dictionary<string, string>> rows)
	{
		var notes = string.Join(" ", rows.Select(r => r.GetValueOrDefault("Notes / Comments") ?? ""));

		if (notes.Contains("UTI", StringComparison.OrdinalIgnoreCase)) return "UTI Panel";
		if (notes.Contains("Wound", StringComparison.OrdinalIgnoreCase)) return "Wound Panel";
		if (notes.Contains("RPP", StringComparison.OrdinalIgnoreCase)) return "RPP Panel";

		return "General";
	}
}