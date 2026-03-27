using System;
using System.Collections.Generic;
using System.Linq;
using static DenialDatabaseProcessorWorker.Services.DenialTaskBoardRepository;

namespace DenialDatabaseProcessorWorker.Services;

public sealed class TaskBoardBuilder
{
	private readonly int _labId;
	private readonly string _labName;
	private readonly string _runId;
	private readonly Dictionary<string, ExistingTaskInfo> _existingTasks;

	public TaskBoardBuilder(int labId, string labName, string runId, Dictionary<string, ExistingTaskInfo> existingTasks)
	{
		_labId = labId;
		_labName = labName;
		_runId = runId;
		_existingTasks = existingTasks ?? new();
	}

	public List<Dictionary<string, string>> Build(List<Dictionary<string, string>> lineRows)
	{
		var result = new List<Dictionary<string, string>>();
		int newTaskCounter = 1;
		var today = DateTime.Today;

		foreach (var line in lineRows)
		{
			var denialCodeNorm = line.GetValueOrDefault("DenialCode_Normalized") ?? "";
			if (string.IsNullOrWhiteSpace(denialCodeNorm))
				continue;

			var visitNumber = line.GetValueOrDefault("Visit Number") ?? "";
			var cptCode = line.GetValueOrDefault("CPTCode") ?? "";

			var rawDesc = line.GetValueOrDefault("Denial Description") ?? "";
			var rawClass = line.GetValueOrDefault("Denial Classification") ?? "";
			var rawActionCode = line.GetValueOrDefault("Action Code") ?? "";
			var rawRecAction = line.GetValueOrDefault("Recommended Action") ?? "";
			var rawTask = line.GetValueOrDefault("Task Guidance") ?? "";
			var rawActionCategory = line.GetValueOrDefault("Action Category") ?? "";
			var rawPriority = line.GetValueOrDefault("Priority") ?? "";
			var rawSla = line.GetValueOrDefault("SLA (Days)") ?? "";

			int slaDays = int.TryParse(StripPrefix(rawSla), out var s) ? s : 0;

			DateTime? firstBilled = TryParseDate(line.GetValueOrDefault("First Billed Date"));
			DateTime? postedDate = TryParseDate(line.GetValueOrDefault("Posted Date"));
			decimal insuranceBalance = TryParseDecimal(line.GetValueOrDefault("Insurance Balance"));

			var denialCodes = denialCodeNorm
				.Split(new[] { ';' }, StringSplitOptions.RemoveEmptyEntries)
				.Select(x => x.Trim())
				.ToList();

			int totalCodes = denialCodes.Count;

			var taskSegments = ParseTaskSegments(rawTask, denialCodes);

			for (int i = 0; i < taskSegments.Count; i++)
			{
				var seg = taskSegments[i];
				var denialCode = seg.DenialCode;
				var key = $"{visitNumber}|{cptCode}|{denialCode}";

				string taskId;
				DateTime dateOpened;

				if (_existingTasks.TryGetValue(key, out var existing))
				{
					taskId = existing.TaskId;
					dateOpened = existing.DateOpened ?? today;
				}
				else
				{
					taskId = $"TSK-{newTaskCounter.ToString("D5")}";
					newTaskCounter++;
					dateOpened = today;
				}

				var dueDate = slaDays > 0 ? dateOpened.AddDays(slaDays) : (DateTime?)null;

				string desc = GetAlignedValue(rawDesc, i, denialCodes);
				string cls = GetAlignedValue(rawClass, i, denialCodes);
				string actCode = GetAlignedValue(rawActionCode, i, denialCodes);
				string recAct = GetAlignedValue(rawRecAction, i, denialCodes);
				string taskText = GetAlignedValue(seg.TaskText, i, denialCodes);
				string actCategory = GetAlignedValue(rawActionCategory, i, denialCodes);
				string priority = GetAlignedValue(rawPriority, i, denialCodes);

				string status = "Open";
				DateTime? dateCompleted = null;

				bool isRebill = taskText.Contains("rebill", StringComparison.OrdinalIgnoreCase);
				bool isWriteOff = taskText.Contains("write off", StringComparison.OrdinalIgnoreCase);

				if (isRebill && firstBilled.HasValue && firstBilled.Value > dateOpened)
				{
					status = "Closed";
					dateCompleted = firstBilled;
				}
				else if (isWriteOff && insuranceBalance == 0 && postedDate.HasValue && postedDate.Value > dateOpened)
				{
					status = "Closed";
					dateCompleted = postedDate;
				}

				int daysRemaining = dueDate.HasValue ? (dueDate.Value - today).Days : 0;

				string slaStatus = "";
				if (dateCompleted.HasValue && dueDate.HasValue && dateCompleted.Value <= dueDate.Value)
					slaStatus = "Met";
				else if (status == "Open" && !dateCompleted.HasValue && dueDate.HasValue && today > dueDate.Value)
					slaStatus = "Overdue";
				else if (status == "Open" && !dateCompleted.HasValue && dueDate.HasValue && daysRemaining <= 3)
					slaStatus = "Due Soon";
				else if (status == "Open" && !dateCompleted.HasValue && dueDate.HasValue && daysRemaining > 3)
					slaStatus = "On Track";

				var row = new Dictionary<string, string>
				{
					["Task ID"] = taskId,
					["Claim ID"] = string.IsNullOrWhiteSpace(visitNumber) ? "" : $"CLM-{visitNumber}",
					["Patient / Acct #"] = "",
					["CPT Code"] = cptCode,
					["Denial Code"] = denialCode,
					["Denial Description"] = desc,
					["Denial Classification"] = cls,
					["Action Code"] = actCode,
					["Recommended Action"] = recAct,
					["Task"] = taskText,
					["Action Category"] = actCategory,
					["Priority"] = priority,
					["SLA (Days)"] = slaDays > 0 ? slaDays.ToString() : "",
					["Assigned To"] = "",
					["Status"] = status,
					["Date Opened"] = dateOpened.ToString("yyyy-MM-dd"),
					["Due Date"] = dueDate?.ToString("yyyy-MM-dd") ?? "",
					["Date Completed"] = dateCompleted?.ToString("yyyy-MM-dd") ?? "",
					["Days Remaining"] = dueDate.HasValue ? daysRemaining.ToString() : "",
					["SLA Status"] = slaStatus,

					["LabId"] = _labId.ToString(),
					["LabName"] = _labName,
					["RunId"] = _runId,
					["CreatedOn"] = DateTime.UtcNow.ToString("O"),
					["UniqueTrackId"] = key
				};

				result.Add(row);
			}
		}

		return result;
	}

	private static string GetAlignedValue(string raw, int index, List<string> denialCodes)
	{
		if (string.IsNullOrWhiteSpace(raw))
			return "";

		var parts = raw.Split(',', StringSplitOptions.TrimEntries | StringSplitOptions.RemoveEmptyEntries);

		// Strip prefixes for inspection
		var stripped = parts.Select(StripPrefix).ToList();

		// If all stripped values are identical and not just codes → same for all
		var nonCodeValues = stripped
			.Where(v => !denialCodes.Contains(v, StringComparer.OrdinalIgnoreCase))
			.ToList();

		if (nonCodeValues.Count == 1 && stripped.All(v =>
				v.Equals(nonCodeValues[0], StringComparison.OrdinalIgnoreCase) ||
				denialCodes.Contains(v, StringComparer.OrdinalIgnoreCase)))
		{
			return nonCodeValues[0];
		}

		// Build explicit map: code -> value from segments like "CO16: Text"
		var codeToValue = new Dictionary<string, string>(StringComparer.OrdinalIgnoreCase);
		string? commonText = null;

		for (int i = 0; i < parts.Length; i++)
		{
			var original = parts[i];
			var value = StripPrefix(original);

			// If this segment starts with "<code>:" assign it to that code
			foreach (var code in denialCodes)
			{
				var prefix = code + ":";
				if (original.TrimStart().StartsWith(prefix, StringComparison.OrdinalIgnoreCase))
				{
					codeToValue[code] = value;
				}
			}

			// First non‑code value becomes common text
			if (!denialCodes.Contains(value, StringComparer.OrdinalIgnoreCase) &&
				string.IsNullOrWhiteSpace(commonText))
			{
				commonText = value;
			}
		}

		var currentCode = denialCodes[index];

		// 1) If we have explicit mapping for this code → use it
		if (codeToValue.TryGetValue(currentCode, out var mapped))
			return mapped;

		// 2) If we have a common text (e.g. "Billing Related Denial") → use it
		if (!string.IsNullOrWhiteSpace(commonText))
			return commonText;

		// 3) If parts count == codes count → align by index (after stripping)
		if (parts.Length == denialCodes.Count)
			return stripped[index];

		// 4) Fallback: use first stripped part
		return stripped[0];
	}

	private static string StripPrefix(string? value)
	{
		if (string.IsNullOrWhiteSpace(value)) return "";
		var idx = value.IndexOf(':');
		return idx > 0 ? value[(idx + 1)..].Trim() : value.Trim();
	}

	private static string GetSplitValue(string raw, int index, int totalCodes)
	{
		if (string.IsNullOrWhiteSpace(raw))
			return "";

		var parts = raw.Split(',', StringSplitOptions.TrimEntries | StringSplitOptions.RemoveEmptyEntries);

		if (parts.Length == totalCodes)
			return parts[index];

		return raw.Trim();
	}

	private static DateTime? TryParseDate(string? v)
		=> DateTime.TryParse(v, out var dt) ? dt : null;

	private static decimal TryParseDecimal(string? v)
		=> decimal.TryParse(v, out var d) ? d : 0;

	private sealed record TaskSegment(string DenialCode, string TaskText);

	private static List<TaskSegment> ParseTaskSegments(string taskGuidance, List<string> denialCodes)
	{
		var segments = new List<TaskSegment>();

		if (!string.IsNullOrWhiteSpace(taskGuidance))
		{
			var parts = taskGuidance.Split(',', StringSplitOptions.TrimEntries | StringSplitOptions.RemoveEmptyEntries);

			if (parts.Length == denialCodes.Count)
			{
				for (int i = 0; i < denialCodes.Count; i++)
					segments.Add(new TaskSegment(denialCodes[i], parts[i]));

				return segments;
			}
		}

		foreach (var code in denialCodes)
			segments.Add(new TaskSegment(code, taskGuidance));

		return segments;
	}
}