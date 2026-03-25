using System;
using System.Collections.Generic;
using System.Linq;

namespace LRN.DenialDatabaseWorker.Services;

public sealed class TaskBoardBuilder
{
	private static string StripPrefix(string? value)
	{
		if (string.IsNullOrWhiteSpace(value)) return "";
		var idx = value.IndexOf(':');
		return idx > 0 ? value[(idx + 1)..].Trim() : value.Trim();
	}

	public List<Dictionary<string, string>> Build(List<Dictionary<string, string>> lineRows)
	{
		var result = new List<Dictionary<string, string>>();
		int taskCounter = 1;
		var today = DateTime.Today;

		foreach (var line in lineRows)
		{
			var denialCodeNorm = line.GetValueOrDefault("DenialCode_Normalized") ?? "";

			// ❗ Only build tasks when denial code exists
			if (string.IsNullOrWhiteSpace(denialCodeNorm))
				continue;

			var visitNumber = line.GetValueOrDefault("Visit Number") ?? "";
			var cptCode = line.GetValueOrDefault("CPTCode") ?? "";

			// Strip prefixes from all fields
			var denialDesc = StripPrefix(line.GetValueOrDefault("Denial Description"));
			var denialClass = StripPrefix(line.GetValueOrDefault("Denial Classification"));
			var actionCode = StripPrefix(line.GetValueOrDefault("Action Code"));
			var recAction = StripPrefix(line.GetValueOrDefault("Recommended Action"));
			var taskGuidance = StripPrefix(line.GetValueOrDefault("Task Guidance"));
			var actionCategory = StripPrefix(line.GetValueOrDefault("Action Category"));
			var priority = StripPrefix(line.GetValueOrDefault("Priority"));

			// SLA fix
			var rawSla = line.GetValueOrDefault("SLA (Days)") ?? "";
			var cleanSla = StripPrefix(rawSla);
			int slaDays = int.TryParse(cleanSla, out var s) ? s : 0;

			DateTime? firstBilled = TryParseDate(line.GetValueOrDefault("First Billed Date"));
			DateTime? postedDate = TryParseDate(line.GetValueOrDefault("Posted Date"));
			decimal insuranceBalance = TryParseDecimal(line.GetValueOrDefault("Insurance Balance"));

			var taskCreationDate = DateTime.Today;
			var dueDate = slaDays > 0 ? taskCreationDate.AddDays(slaDays) : (DateTime?)null;

			var segments = ParseTaskSegments(taskGuidance, denialCodeNorm);

			foreach (var seg in segments)
			{
				var row = new Dictionary<string, string>();

				row["Task ID"] = $"TSK-{taskCounter.ToString("D5")}";
				taskCounter++;

				row["Claim ID"] = string.IsNullOrWhiteSpace(visitNumber) ? "" : $"CLM-{visitNumber}";
				row["Patient / Acct #"] = "";
				row["CPT Code"] = cptCode;
				row["Denial Code"] = seg.DenialCode;
				row["Denial Description"] = denialDesc;
				row["Denial Classification"] = denialClass;
				row["Action Code"] = actionCode;
				row["Recommended Action"] = recAction;
				row["Task"] = StripPrefix(seg.TaskText);
				row["Action Category"] = actionCategory;
				row["Priority"] = priority;
				row["SLA (Days)"] = slaDays > 0 ? slaDays.ToString() : "";
				row["Assigned To"] = "";

				// Status logic
				string taskStatus = "Open";
				DateTime? dateCompleted = null;

				bool isRebill = seg.TaskText.Contains("rebill", StringComparison.OrdinalIgnoreCase);
				bool isWriteOff = seg.TaskText.Contains("write off", StringComparison.OrdinalIgnoreCase);

				if (isRebill && firstBilled.HasValue && firstBilled.Value > taskCreationDate)
				{
					taskStatus = "Closed";
					dateCompleted = firstBilled;
				}
				else if (isWriteOff && insuranceBalance == 0 && postedDate.HasValue && postedDate.Value > taskCreationDate)
				{
					taskStatus = "Closed";
					dateCompleted = postedDate;
				}

				row["Status"] = taskStatus;
				row["Date Opened"] = taskCreationDate.ToString("yyyy-MM-dd");
				row["Due Date"] = dueDate?.ToString("yyyy-MM-dd") ?? "";
				row["Date Completed"] = dateCompleted?.ToString("yyyy-MM-dd") ?? "";

				int daysRemaining = dueDate.HasValue ? (dueDate.Value - taskCreationDate).Days : 0;
				row["Days Remaining"] = dueDate.HasValue ? daysRemaining.ToString() : "";

				// SLA Status
				string slaStatus = "";
				if (dateCompleted.HasValue && dueDate.HasValue && dateCompleted.Value <= dueDate.Value)
					slaStatus = "Met";
				else if (taskStatus == "Open" && !dateCompleted.HasValue && dueDate.HasValue && DateTime.Today > dueDate.Value)
					slaStatus = "Overdue";
				else if (taskStatus == "Open" && !dateCompleted.HasValue && dueDate.HasValue && daysRemaining <= 3)
					slaStatus = "Due Soon";
				else if (taskStatus == "Open" && !dateCompleted.HasValue && dueDate.HasValue && daysRemaining > 3)
					slaStatus = "On Track";

				row["SLA Status"] = slaStatus;

				result.Add(row);
			}
		}

		return result;
	}

	private static DateTime? TryParseDate(string? v)
		=> DateTime.TryParse(v, out var dt) ? dt : null;

	private static decimal TryParseDecimal(string? v)
		=> decimal.TryParse(v, out var d) ? d : 0;

	private sealed record TaskSegment(string DenialCode, string TaskText);

	private static List<TaskSegment> ParseTaskSegments(string taskGuidance, string denialCodeNorm)
	{
		var segments = new List<TaskSegment>();

		if (!string.IsNullOrWhiteSpace(taskGuidance))
		{
			var parts = taskGuidance.Split(", ", StringSplitOptions.RemoveEmptyEntries);

			foreach (var p in parts)
			{
				var idx = p.IndexOf(':');
				if (idx > 0)
				{
					var codes = p.Substring(0, idx).Trim();
					var text = p.Substring(idx + 1).Trim();
					segments.Add(new TaskSegment(codes, text));
				}
			}

			if (segments.Count > 0)
				return segments;
		}

		var codesFallback = denialCodeNorm
			.Split(new[] { ',', ';' }, StringSplitOptions.RemoveEmptyEntries)
			.Select(c => c.Trim())
			.ToList();

		if (codesFallback.Count > 0)
		{
			foreach (var c in codesFallback)
				segments.Add(new TaskSegment(c, taskGuidance));
		}

		return segments;
	}
}