using DenialDatabaseProcessorWorker.Normalizers;
using static DenialDatabaseProcessorWorker.Services.DenialTaskBoardRepository;

namespace DenialDatabaseProcessorWorker.Builders;

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
		var today = DateTime.Today;
		int newTaskCounter = 1;

		var currentKeys = new HashSet<string>(StringComparer.OrdinalIgnoreCase);

		foreach (var line in lineRows)
		{
			var denialCodeNorm = line.GetValueOrDefault("DenialCode_Normalized") ?? "";
			if (string.IsNullOrWhiteSpace(denialCodeNorm))
				continue;

			var visitNumber = line.GetValueOrDefault("Visit Number") ?? "";
			var cptCode = line.GetValueOrDefault("CPTCode") ?? "";
			var payStatus = line.GetValueOrDefault("Pay Status") ?? "";

			var rawDesc = line.GetValueOrDefault("Denial Description") ?? "";
			var rawClass = line.GetValueOrDefault("Denial Classification") ?? "";
			var rawActionCode = line.GetValueOrDefault("Action Code") ?? "";
			var rawRecAction = line.GetValueOrDefault("Recommended Action") ?? "";
			var rawTask = line.GetValueOrDefault("Task Guidance") ?? "";
			var rawActionCategory = line.GetValueOrDefault("Action Category") ?? "";
			var rawPriority = line.GetValueOrDefault("Priority") ?? "";
			var rawSla = line.GetValueOrDefault("SLA (Days)") ?? "";

			// Insurance Balance
			var rawInsBalance = line.GetValueOrDefault("Insurance Balance");
			decimal insBalanceVal = 0;
			if (!string.IsNullOrWhiteSpace(rawInsBalance))
				decimal.TryParse(rawInsBalance, out insBalanceVal);

			var insuranceBalance = insBalanceVal.ToString("0.##");

			int slaDays = int.TryParse(StripPrefix(rawSla), out var s) ? s : 0;

			DateTime? firstBilled = TryParseDate(line.GetValueOrDefault("First Billed Date"));
			DateTime? postedDate = TryParseDate(line.GetValueOrDefault("Posted Date"));

			var denialCodes = denialCodeNorm
				.Split(new[] { ';' }, StringSplitOptions.RemoveEmptyEntries)
				.Select(x => x.Trim())
				.ToList();

			var taskSegments = ParseTaskSegments(rawTask, denialCodes);

			for (int i = 0; i < taskSegments.Count; i++)
			{
				var seg = taskSegments[i];
				var denialCode = seg.DenialCode;

				// Key = VisitNumber + CPT + DenialCode
				var key = $"{visitNumber}|{cptCode}|{denialCode}";
				currentKeys.Add(key);

				// Try to get existing task
				_existingTasks.TryGetValue(key, out var existing);

				string taskId;
				DateTime dateOpened;

				if (existing != null)
				{
					taskId = existing.TaskId;
					dateOpened = existing.DateOpened ?? today;
				}
				else
				{
					taskId = $"TSK-{newTaskCounter:D5}";
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

				// New fields from DenialLineItem. DenialValidity must be aligned per denial code
				// and the denial-code prefix must be removed before loading to Task Board.
				string icdCodes = line.GetValueOrDefault("BilledICDCodesNotAvailableInPayerPolicy") ?? "";
				string coverageStatus = line.GetValueOrDefault("CoverageStatus") ?? "";
				string icdComplianceStatus = line.GetValueOrDefault("ICDComplianceStatus") ?? "";
				string denialValidity = GetValueForDenialCode(line.GetValueOrDefault("DenialValidity"), denialCode, denialCodes, i);

				// Normalize task text
				taskText = TaskGuidanceNormalizer.Normalize(taskText, denialCode);

				// Fallback: if still empty, use Recommended Action
				if (string.IsNullOrWhiteSpace(taskText) && !string.IsNullOrWhiteSpace(recAct))
					taskText = recAct;

				// ------------------------------
				// STATUS + DATE COMPLETED LOGIC
				// ------------------------------

				string status = "Open";
				DateTime? dateCompleted = null;

				bool isRebill = taskText.Contains("rebill", StringComparison.OrdinalIgnoreCase);
				bool isWriteOff = taskText.Contains("write off", StringComparison.OrdinalIgnoreCase);

				// 1. Preserve existing Closed/Review tasks
				if (existing != null &&
						existing.Row.TryGetValue("Status", out var oldStatusRaw))
				{
					var oldStatus = oldStatusRaw?.Trim()
						.Replace("\u00A0", "")   // non-breaking space
						.Replace("\u200B", "")   // zero-width space
						.Replace("\r", "")
						.Replace("\n", "")
						.Trim();

					if (!string.IsNullOrWhiteSpace(oldStatus) &&
						(oldStatus.Equals("Closed", StringComparison.OrdinalIgnoreCase) ||
						 oldStatus.Equals("Review", StringComparison.OrdinalIgnoreCase)))
					{
						status = oldStatus;

						if (existing.Row.TryGetValue("Date Completed", out var oldCompleted) &&
							DateTime.TryParse(oldCompleted, out var parsed))
						{
							dateCompleted = parsed;
						}
					}
				}
				else
				{
					// 2. Rebill auto-close
					if (isRebill && firstBilled.HasValue && firstBilled.Value > dateOpened)
					{
						status = "Closed";
						dateCompleted = firstBilled;
					}
					// 3. Write-off auto-close
					else if (isWriteOff && insBalanceVal == 0 && postedDate.HasValue && postedDate.Value > dateOpened)
					{
						status = "Closed";
						dateCompleted = postedDate;
					}
					// 4. Write-off but not yet posted
					else if (isWriteOff)
					{
						if (!string.Equals(payStatus, "Write Off", StringComparison.OrdinalIgnoreCase))
						{
							status = "Review";
						}
						else
						{
							status = "Closed";
							dateCompleted = postedDate;
						}
					}
				}

				// ------------------------------
				// SLA STATUS LOGIC
				// ------------------------------

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

				// ------------------------------
				// BUILD ROW
				// ------------------------------

				var row = new Dictionary<string, string>
				{
					["Task ID"] = taskId,
					["Claim ID"] = string.IsNullOrWhiteSpace(visitNumber) ? "" : $"CLM-{visitNumber}",
					["Patient / Acct #"] = line.GetValueOrDefault("PatientID") ?? "",
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
					["Status"] = status,
					["Insurance Balance"] = insuranceBalance,
					["IsCurrentDenial"] = "true",
					["Assigned To"] = "",
					["Date Opened"] = dateOpened.ToString("yyyy-MM-dd"),
					["Due Date"] = dueDate?.ToString("yyyy-MM-dd") ?? "",
					["Date Completed"] = dateCompleted?.ToString("yyyy-MM-dd") ?? "",
					["Days Remaining"] = dueDate.HasValue ? daysRemaining.ToString() : "",
					["SLA Status"] = slaStatus,
					["LabId"] = _labId.ToString(),
					["LabName"] = _labName,
					["RunId"] = _runId,
					["CreatedOn"] = DateTime.UtcNow.ToString("O"),
					["UniqueTrackId"] = key,

					// Additional fields from Denial Line Item
					["SalesRepname"] = line.GetValueOrDefault("SalesRepname") ?? "",
					["ClinicName"] = line.GetValueOrDefault("ClinicName") ?? "",
					["ReferringProvider"] = line.GetValueOrDefault("ReferringProvider") ?? "",
					["PayerName Normalized"] = line.GetValueOrDefault("PayerName Normalized") ?? "",
					["Payer Name"] = line.GetValueOrDefault("Payer Name") ?? "",
					["Payer Code"] = line.GetValueOrDefault("Payer Code") ?? "",
					["Payer Type"] = line.GetValueOrDefault("Payer Type") ?? "",
					["First Billed Date"] = line.GetValueOrDefault("First Billed Date") ?? "",
					["ChargeEnteredDate"] = line.GetValueOrDefault("ChargeEnteredDate") ?? "",
					["BillingProvider"] = line.GetValueOrDefault("BillingProvider") ?? "",
					["Panel Name"] = line.GetValueOrDefault("Panel Name") ?? "",
					["Date of Service"] = line.GetValueOrDefault("Date of Service") ?? "",
					["ICDCodes"] = icdCodes,
					["CoverageStatus"] = coverageStatus,
					["ICDComplianceStatus"] = icdComplianceStatus,
					["DenialValidity"] = denialValidity
				};

				result.Add(row);
			}
		}

		// -----------------------------------------
		// OLD TASKS NOT PRESENT IN CURRENT RUN
		// -----------------------------------------

		var todayStr = DateTime.Today.ToString("yyyy-MM-dd");

		foreach (var kvp in _existingTasks)
		{
			var key = kvp.Key;
			var info = kvp.Value;

			if (currentKeys.Contains(key))
				continue;

			var row = new Dictionary<string, string>(info.Row, StringComparer.OrdinalIgnoreCase)
			{
				["IsCurrentDenial"] = "false",
				["Status"] = "Closed",
				["Date Completed"] = todayStr
			};

			if (DateTime.TryParse(row.GetValueOrDefault("Due Date"), out var dueDt))
			{
				int daysRemaining = (dueDt - DateTime.Today).Days;
				row["Days Remaining"] = daysRemaining.ToString();

				if (DateTime.TryParse(row.GetValueOrDefault("Date Completed"), out var dc))
				{
					row["SLA Status"] = dc <= dueDt ? "Met" : "Overdue";
				}
			}

			result.Add(row);
		}

		return result;
	}

	// ------------------------------
	// HELPERS
	// ------------------------------

	private static string GetAlignedValue(string raw, int index, List<string> denialCodes)
	{
		if (string.IsNullOrWhiteSpace(raw))
			return "";

		var parts = raw.Split(',', StringSplitOptions.TrimEntries | StringSplitOptions.RemoveEmptyEntries);
		var stripped = parts.Select(StripPrefix).ToList();

		var nonCodeValues = stripped
			.Where(v => !denialCodes.Contains(v, StringComparer.OrdinalIgnoreCase))
			.ToList();

		if (nonCodeValues.Count == 1 &&
			stripped.All(v =>
				v.Equals(nonCodeValues[0], StringComparison.OrdinalIgnoreCase) ||
				denialCodes.Contains(v, StringComparer.OrdinalIgnoreCase)))
		{
			return nonCodeValues[0];
		}

		var codeToValue = new Dictionary<string, string>(StringComparer.OrdinalIgnoreCase);
		string? commonText = null;

		for (int i = 0; i < parts.Length; i++)
		{
			var original = parts[i];
			var value = StripPrefix(original);

			foreach (var code in denialCodes)
			{
				var prefix = code + ":";
				if (original.TrimStart().StartsWith(prefix, StringComparison.OrdinalIgnoreCase))
					codeToValue[code] = value;
			}

			if (!denialCodes.Contains(value, StringComparer.OrdinalIgnoreCase) &&
				string.IsNullOrWhiteSpace(commonText))
			{
				commonText = value;
			}
		}

		var currentCode = denialCodes[index];
		if (codeToValue.TryGetValue(currentCode, out var mapped))
			return mapped;

		if (!string.IsNullOrWhiteSpace(commonText))
			return commonText;

		if (parts.Length == denialCodes.Count)
			return stripped[index];

		return stripped[0];
	}

	private static string StripPrefix(string? value)
	{
		if (string.IsNullOrWhiteSpace(value)) return "";
		var idx = value.IndexOf(':');
		return idx > 0 ? value[(idx + 1)..].Trim() : value.Trim();
	}

	private static string GetValueForDenialCode(string? raw, string denialCode, List<string> denialCodes, int index)
	{
		if (string.IsNullOrWhiteSpace(raw))
			return "";

		var text = raw.Trim();

		// Best case: DenialValidity is stored like "CO16: Valid, CO197: Invalid".
		// Split by denial-code markers, not only comma, because the validity text itself may contain commas.
		var markers = denialCodes
			.Where(c => !string.IsNullOrWhiteSpace(c))
			.Select(c => new { Code = c, Index = text.IndexOf(c + ":", StringComparison.OrdinalIgnoreCase) })
			.Where(x => x.Index >= 0)
			.OrderBy(x => x.Index)
			.ToList();

		if (markers.Count > 0)
		{
			for (int i = 0; i < markers.Count; i++)
			{
				var current = markers[i];
				var valueStart = current.Index + current.Code.Length + 1;
				var valueEnd = i + 1 < markers.Count ? markers[i + 1].Index : text.Length;
				var value = text[valueStart..valueEnd].Trim().Trim(',', ';', '|').Trim();

				if (current.Code.Equals(denialCode, StringComparison.OrdinalIgnoreCase))
					return value;
			}
		}

		// Fallback for simple comma/semicolon aligned values.
		return GetAlignedValue(text, index, denialCodes);
	}

	private static DateTime? TryParseDate(string? v)
		=> DateTime.TryParse(v, out var dt) ? dt : null;

	private sealed class TaskSegment
	{
		public TaskSegment(string denialCode, string taskText)
		{
			DenialCode = denialCode;
			TaskText = taskText;
		}

		public string DenialCode { get; }
		public string TaskText { get; }
	}

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