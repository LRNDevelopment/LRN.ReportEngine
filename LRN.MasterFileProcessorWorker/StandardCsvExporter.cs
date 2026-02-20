
using Microsoft.VisualBasic.FileIO;
using LRN.ExcelValidator.Models;
using System.IO;
using System.Globalization;
using System.Text;
using System.Text.RegularExpressions;
using System.Linq;

public static class StandardCsvExporter
{

	public sealed record InsuranceMasterEntry(string GlobalPayerId, string PayerNameNormalized, string payercode, string payercommoncode, string payerGroupCode);

	/// <summary>
	/// Loads the Consolidated Lab Insurance Master CSV into a lookup keyed by normalized Payer_Name_Raw.
	/// Expected columns include: Payer_Name_Raw, Payer_Name_Normalized, Global_Payer_ID (others ignored).
	/// </summary>
	public static Dictionary<string, InsuranceMasterEntry> LoadInsuranceMaster(string csvPath)
	{
		if (string.IsNullOrWhiteSpace(csvPath))
			throw new ArgumentException("Insurance master CSV path is required.", nameof(csvPath));

		if (!File.Exists(csvPath))
			throw new FileNotFoundException("Insurance master CSV not found.", csvPath);

		using var parser = new TextFieldParser(csvPath);
		parser.TextFieldType = FieldType.Delimited;

		// Detect delimiter: comma vs tab
		var firstLine = File.ReadLines(csvPath).FirstOrDefault() ?? "";
		var delim = firstLine.Contains('	') && !firstLine.Contains(",") ? "	" : ",";
		parser.SetDelimiters(delim);
		parser.HasFieldsEnclosedInQuotes = true;

		if (parser.EndOfData) return new Dictionary<string, InsuranceMasterEntry>(StringComparer.OrdinalIgnoreCase);

		var headers = parser.ReadFields() ?? Array.Empty<string>();
		var idxByNorm = new Dictionary<string, int>(StringComparer.OrdinalIgnoreCase);
		for (int i = 0; i < headers.Length; i++)
		{
			var hn = NormKey(headers[i] ?? "");
			if (!string.IsNullOrWhiteSpace(hn) && !idxByNorm.ContainsKey(hn))
				idxByNorm[hn] = i;
		}

		int idxRaw = idxByNorm.TryGetValue(NormKey("Payer_Name_Raw"), out var iRaw) ? iRaw : -1;
		int idxNorm = idxByNorm.TryGetValue(NormKey("Payer_Name_Normalized"), out var iNorm) ? iNorm : -1;
		int idxGpid = idxByNorm.TryGetValue(NormKey("Global_Payer_ID"), out var iG) ? iG : -1;
		int idxPc = idxByNorm.TryGetValue(NormKey("Payer_Code"), out var PC) ? PC : -1;
		int idxPCC = idxByNorm.TryGetValue(NormKey("Payer_Common_Code"), out var PCC) ? PCC : -1;
		int idPyGrCd = idxByNorm.TryGetValue(NormKey("Payer_Group_Code"), out var PyGrCode) ? PyGrCode : -1;

		if (idxRaw < 0)
			throw new InvalidOperationException("Insurance master CSV missing required column: Payer_Name_Raw");

		var map = new Dictionary<string, InsuranceMasterEntry>(StringComparer.OrdinalIgnoreCase);

		while (!parser.EndOfData)
		{
			var row = parser.ReadFields();
			if (row == null || row.All(x => string.IsNullOrWhiteSpace(x))) continue;

			var raw = idxRaw >= 0 && idxRaw < row.Length ? (row[idxRaw] ?? "").Trim() : "";
			if (string.IsNullOrWhiteSpace(raw)) continue;

			var key = NormKey(raw);
			if (string.IsNullOrWhiteSpace(key)) continue;

			var normalized = idxNorm >= 0 && idxNorm < row.Length ? (row[idxNorm] ?? "").Trim() : "";
			var gpid = idxGpid >= 0 && idxGpid < row.Length ? (row[idxGpid] ?? "").Trim() : "";
			var payCode = idxPc >= 0 && idxPc < row.Length ? (row[idxPc] ?? "").Trim() : "";
			var paycmcode = idxPCC >= 0 && idxPCC < row.Length ? (row[idxPCC] ?? "").Trim() : "";
			var pygrCode = idPyGrCd >= 0 && idPyGrCd < row.Length ? (row[idPyGrCd] ?? "").Trim() : "";

			// First win
			if (!map.ContainsKey(key))
				map[key] = new InsuranceMasterEntry(gpid, normalized, payCode, paycmcode, pygrCode);
		}

		return map;
	}


	/// <summary>
	/// Generates a standardized CSV from a raw CSV (exported from Excel sheet) using a COMMON schema JSON:
	/// - Uses Aliases to map source headers to each common column.
	/// - Normalizes all date/datetime columns to MM/dd/yyyy.
	/// - Fills metadata columns: LabID, LabName, SourceFileID (SharePoint file name), IngestedOn, RowHash.
	/// - Supports Calculation: "A + B" (A/B are COMMON schema column names).
	/// - Computes DaystoDOS/RollingDays/DaystoBill/DaystoPost using Today() and DateofService/FirstBilledDate/CheckDate.
	/// </summary>
	public static void Generate(
		string sourceCsvPath,
		int headerRow,
		string outputCsvPath,
		ColumnSchema commonSchema,
		int labId,
		string labName,
		string sourceFileName,
		DateTime ingestedOnLocal,
		ColumnSchema? labSchema = null,
		Dictionary<string, InsuranceMasterEntry>? insuranceMaster = null)
	{
		if (!File.Exists(sourceCsvPath))
			throw new FileNotFoundException("Source CSV not found", sourceCsvPath);

		Directory.CreateDirectory(Path.GetDirectoryName(outputCsvPath)!);

		using var parser = new TextFieldParser(sourceCsvPath)
		{
			TextFieldType = FieldType.Delimited,
			HasFieldsEnclosedInQuotes = true,
			TrimWhiteSpace = false
		};
		parser.SetDelimiters(",");

		// Skip to header row (1-based)
		string[]? header = null;
		for (int i = 1; i <= headerRow; i++)
		{
			if (parser.EndOfData) break;
			header = parser.ReadFields();
		}
		if (header == null)
			throw new InvalidOperationException($"Header row {headerRow} not found in CSV: {sourceCsvPath}");

		// Build header lookups (exact + normalized)
		var headerExact = new Dictionary<string, int>(StringComparer.OrdinalIgnoreCase);
		var headerNorm = new Dictionary<string, int>(StringComparer.OrdinalIgnoreCase);

		for (int i = 0; i < header.Length; i++)
		{
			var h = (header[i] ?? "").Trim();
			if (string.IsNullOrWhiteSpace(h)) continue;

			if (!headerExact.ContainsKey(h))
				headerExact[h] = i;

			var hn = NormKey(h);
			if (!string.IsNullOrWhiteSpace(hn) && !headerNorm.ContainsKey(hn))
				headerNorm[hn] = i;
		}

		// Lab-level overrides: prefer lab schema headers when multiple aliases exist,
		// and support composite expressions like "[Last], [First] {Referral Name}".
		var labOv = BuildLabOverrides(labSchema);

		// For calculations: resolve by COMMON column name
		var schemaByName = commonSchema.Columns
			.Where(c => !string.IsNullOrWhiteSpace(c.Name))
			.ToDictionary(c => c.Name, c => c, StringComparer.OrdinalIgnoreCase);

		using var sw = new StreamWriter(outputCsvPath, false, new UTF8Encoding(encoderShouldEmitUTF8Identifier: true));
		sw.WriteLine(string.Join(",", commonSchema.Columns.Select(c => Escape(c.Name))));

		int rowNumber = 0;

		while (!parser.EndOfData)
		{
			var row = parser.ReadFields();
			if (row == null) continue;
			if (row.All(x => string.IsNullOrWhiteSpace(x))) continue;

			rowNumber++;

			// Cache extracted values for referenced columns (commonName -> raw string)
			var extracted = new Dictionary<string, string>(StringComparer.OrdinalIgnoreCase);

			foreach (var col in commonSchema.Columns)
			{
				if (IsMetadata(col.Name) || IsDays(col.Name))
					continue;

				if (!string.IsNullOrWhiteSpace(col.Calculation))
					continue;

				extracted[col.Name] = ReadValueForCommonColumn(col, row, headerExact, headerNorm, labOv);
			}

			// Dates for day calculations
			var dos = ParseDateMaybe(extracted.TryGetValue("DateofService", out var dosRaw) ? dosRaw : "");
			var firstBill = ParseDateMaybe(extracted.TryGetValue("FirstBilledDate", out var billRaw) ? billRaw : "");
			var check = ParseDateMaybe(extracted.TryGetValue("CheckDate", out var chkRaw) ? chkRaw : "");

			int? daysToDos = dos.HasValue ? (int?)(DateTime.Today - dos.Value.Date).TotalDays : null;
			int? daysToBill = firstBill.HasValue ? (int?)(DateTime.Today - firstBill.Value.Date).TotalDays : null;
			int? daysToPost = check.HasValue ? (int?)(DateTime.Today - check.Value.Date).TotalDays : null;

			// --- Insurance Master mapping: Global_Payer_ID + normalized PayerName ---
			if (insuranceMaster != null && insuranceMaster.Count > 0)
			{
				var payerRaw = GetFirstNonEmpty(extracted,
					"PayerName_Raw", "Payer Name", "PayerName", "Payer");

				if (!string.IsNullOrWhiteSpace(payerRaw))
				{
					var key = NormKey(payerRaw);
					if (!string.IsNullOrWhiteSpace(key) && insuranceMaster.TryGetValue(key, out var ins))
					{
						// Fill normalized payer name & global payer id if those columns exist in the COMMON schema
						extracted["PayerName"] = ins.PayerNameNormalized ?? "";
						extracted["Payer_Code"] = ins.payercode ?? "";
						extracted["Payer_Common_Code"] = ins.payercommoncode ?? "";
						extracted["Payer_Group_Code"] = ins.payerGroupCode ?? "";
						extracted["Global_Payer_ID"] = ins.GlobalPayerId ?? "";

					}
				}
			}

			// --- Per-unit columns (LineLevel) ---
			var unitsRaw = extracted.TryGetValue("Units", out var uRaw) ? uRaw : "";
			var unitsVal = ParseDecimal(unitsRaw);

			if (unitsVal > 0m)
			{
				extracted["ChargeAmountPerUnit"] = DividePerUnit(extracted, "ChargeAmount", unitsVal);
				extracted["AllowedAmountPerUnit"] = DividePerUnit(extracted, "AllowedAmount", unitsVal);
				extracted["InsurancePaymentPerUnit"] = DividePerUnit(extracted, "InsurancePayment", unitsVal);
				extracted["PatientBalancePerUnit"] = DividePerUnit(extracted, "PatientBalance", unitsVal);
				extracted["PatientPaymentPerUnit"] = DividePerUnit(extracted, "PatientPayment", unitsVal);
			}
			else
			{
				extracted["ChargeAmountPerUnit"] = "";
				extracted["AllowedAmountPerUnit"] = "";
				extracted["InsurancePaymentPerUnit"] = "";
				extracted["PatientBalancePerUnit"] = "";
				extracted["PatientPaymentPerUnit"] = "";
			}

			// --- Pay Status (derived) ---
			if (commonSchema.Columns.Any(c => c.Name.Equals("Pay Status", StringComparison.OrdinalIgnoreCase)))
			{
				extracted["Pay Status"] = ComputePayStatus(extracted);
			}



			string rolling = "";
			if (daysToDos.HasValue)
			{
				if (daysToDos.Value <= 90) rolling = "Rolling90";
				else if (daysToDos.Value >= 91 && daysToDos.Value <= 180) rolling = "Rolling180";
				else if (daysToDos.Value >= 181) rolling = "YTD";
			}

			var outFields = new List<string>(commonSchema.Columns.Count);

			foreach (var col in commonSchema.Columns)
			{
				string val;

				// Metadata columns
				if (col.Name.Equals("LabID", StringComparison.OrdinalIgnoreCase))
					val = labId.ToString(CultureInfo.InvariantCulture);
				else if (col.Name.Equals("LabName", StringComparison.OrdinalIgnoreCase))
					val = labName ?? "";
				else if (col.Name.Equals("SourceFileID", StringComparison.OrdinalIgnoreCase))
					val = sourceFileName ?? "";
				else if (col.Name.Equals("IngestedOn", StringComparison.OrdinalIgnoreCase))
					val = ingestedOnLocal.ToString("MM/dd/yyyy", CultureInfo.InvariantCulture);
				else if (col.Name.Equals("RowHash", StringComparison.OrdinalIgnoreCase))
					// RowHash should be Excel-like row number: headerRow + rowNumber
					val = (headerRow + rowNumber).ToString(CultureInfo.InvariantCulture);

				// Day-based computed columns
				else if (col.Name.Equals("DaystoDOS", StringComparison.OrdinalIgnoreCase))
					val = daysToDos?.ToString(CultureInfo.InvariantCulture) ?? "";
				else if (col.Name.Equals("RollingDays", StringComparison.OrdinalIgnoreCase))
					val = rolling;
				else if (col.Name.Equals("DaystoBill", StringComparison.OrdinalIgnoreCase))
					val = daysToBill?.ToString(CultureInfo.InvariantCulture) ?? "";
				else if (col.Name.Equals("DaystoPost", StringComparison.OrdinalIgnoreCase))
					val = daysToPost?.ToString(CultureInfo.InvariantCulture) ?? "";

				// Calculation columns
				else if (!string.IsNullOrWhiteSpace(col.Calculation))
					val = EvaluateCalculation(col.Calculation!, extracted, schemaByName, row, headerExact, headerNorm, labOv);

				// Standard extracted columns
				else
					val = extracted.TryGetValue(col.Name, out var raw) ? raw : ReadValueForCommonColumn(col, row, headerExact, headerNorm, labOv);

				// Normalize date fields based on schema datatype
				if (IsDateType(col.DataType))
					val = NormalizeDate(val);

				outFields.Add(Escape(val));
			}

			sw.WriteLine(string.Join(",", outFields));
		}
	}


	// ---------------- Lab schema overrides ----------------
	// Lab schema is used to:
	// 1) Prefer certain source headers when multiple COMMON aliases exist (e.g., CPT vs Procedure).
	// 2) Support simple composite expressions in lab schema Name, like:
	//    "[Last Name], [First Name] {Referral Name}"
	//    -> Output COMMON column "Referral Name" = "Last Name, First Name"

	private sealed class LabOverrides
	{
		public HashSet<string> PreferredExact { get; } = new(StringComparer.OrdinalIgnoreCase);
		public HashSet<string> PreferredNorm { get; } = new(StringComparer.OrdinalIgnoreCase);
		public Dictionary<string, CompositeTemplate> CompositeByName { get; } = new(StringComparer.OrdinalIgnoreCase);
		public Dictionary<string, CompositeTemplate> CompositeByNorm { get; } = new(StringComparer.OrdinalIgnoreCase);
	}

	private readonly record struct CompositeSegment(bool IsColumn, string Text);

	private sealed class CompositeTemplate
	{
		public string TargetName { get; init; } = "";
		public List<CompositeSegment> Segments { get; init; } = new();
	}

	private static LabOverrides BuildLabOverrides(ColumnSchema? labSchema)
	{
		var ov = new LabOverrides();

		if (labSchema?.Columns == null)
			return ov;

		foreach (var c in labSchema.Columns)
		{
			if (c == null) continue;

			var rawName = (c.Name ?? "").Trim();
			if (string.IsNullOrWhiteSpace(rawName)) continue;

			// Composite mapping: "[A], [B] {Target}"
			if (TryParseComposite(rawName, out var tpl))
			{
				if (!string.IsNullOrWhiteSpace(tpl.TargetName))
				{
					ov.CompositeByName[tpl.TargetName] = tpl;

					var tn = NormKey(tpl.TargetName);
					if (!string.IsNullOrWhiteSpace(tn))
						ov.CompositeByNorm[tn] = tpl;
				}

				// Treat referenced headers as preferred too
				foreach (var seg in tpl.Segments.Where(s => s.IsColumn))
				{
					var h = (seg.Text ?? "").Trim();
					if (string.IsNullOrWhiteSpace(h)) continue;

					ov.PreferredExact.Add(h);

					var hn = NormKey(h);
					if (!string.IsNullOrWhiteSpace(hn))
						ov.PreferredNorm.Add(hn);
				}

				continue;
			}

			// Simple preferred header
			ov.PreferredExact.Add(rawName);
			var norm = NormKey(rawName);
			if (!string.IsNullOrWhiteSpace(norm))
				ov.PreferredNorm.Add(norm);

			// Some lab schemas may also include Aliases on their column specs
			if (c.Aliases != null)
			{
				foreach (var a in c.Aliases)
				{
					var aa = (a ?? "").Trim();
					if (string.IsNullOrWhiteSpace(aa)) continue;

					ov.PreferredExact.Add(aa);

					var an = NormKey(aa);
					if (!string.IsNullOrWhiteSpace(an))
						ov.PreferredNorm.Add(an);
				}
			}
		}

		return ov;
	}

	private static bool TryParseComposite(string raw, out CompositeTemplate template)
	{
		template = new CompositeTemplate();

		// Expect trailing "{Target}" (but allow whitespace after)
		var m = Regex.Match(raw, @"\{([^{}]+)\}\s*$");
		if (!m.Success)
			return false;

		var target = (m.Groups[1].Value ?? "").Trim();
		if (string.IsNullOrWhiteSpace(target))
			return false;

		var expr = raw.Substring(0, m.Index).TrimEnd();
		if (string.IsNullOrWhiteSpace(expr))
			return false;

		var segs = new List<CompositeSegment>();
		int pos = 0;

		foreach (Match bm in Regex.Matches(expr, @"\[(?<col>[^\]]+)\]"))
		{
			if (bm.Index > pos)
			{
				segs.Add(new CompositeSegment(false, expr.Substring(pos, bm.Index - pos)));
			}

			var col = (bm.Groups["col"].Value ?? "").Trim();
			segs.Add(new CompositeSegment(true, col));

			pos = bm.Index + bm.Length;
		}

		if (pos < expr.Length)
			segs.Add(new CompositeSegment(false, expr.Substring(pos)));

		// Must contain at least one [col]
		if (!segs.Any(s => s.IsColumn))
			return false;

		template = new CompositeTemplate
		{
			TargetName = target,
			Segments = segs
		};

		return true;
	}


	private static bool TryGetCompositeTemplate(ColumnSpec col, LabOverrides labOv, out CompositeTemplate tpl)
	{
		// 1) by common column name
		if (labOv.CompositeByName.TryGetValue(col.Name, out tpl))
			return true;

		var nn = NormKey(col.Name);
		if (!string.IsNullOrWhiteSpace(nn) && labOv.CompositeByNorm.TryGetValue(nn, out tpl))
			return true;

		// 2) by any alias (this is what makes "{Referral Name}" target work for BillingProvider, etc.)
		if (col.Aliases != null)
		{
			foreach (var a in col.Aliases.Where(x => !string.IsNullOrWhiteSpace(x)))
			{
				var key = (a ?? "").Trim();
				if (labOv.CompositeByName.TryGetValue(key, out tpl))
					return true;

				var an = NormKey(key);
				if (!string.IsNullOrWhiteSpace(an) && labOv.CompositeByNorm.TryGetValue(an, out tpl))
					return true;
			}
		}

		tpl = null!;
		return false;
	}

	private static string ReadValueForCommonColumn(
			ColumnSpec col,
			string[] row,
			Dictionary<string, int> headerExact,
			Dictionary<string, int> headerNorm,
			LabOverrides labOv)
	{
		// Composite overrides by column name OR by any alias (exact or normalized)
		if (TryGetCompositeTemplate(col, labOv, out var tpl))
			return EvaluateComposite(tpl, row, headerExact, headerNorm);

		return ReadByAliases(col, row, headerExact, headerNorm, labOv);
	}

	private static string EvaluateComposite(
		CompositeTemplate tpl,
		string[] row,
		Dictionary<string, int> headerExact,
		Dictionary<string, int> headerNorm)
	{
		// Pre-evaluate all column segments
		var segVals = new List<(CompositeSegment Seg, string Val)>(tpl.Segments.Count);
		foreach (var seg in tpl.Segments)
		{
			if (!seg.IsColumn)
			{
				segVals.Add((seg, seg.Text ?? ""));
				continue;
			}

			var v = ReadHeaderValue(seg.Text, row, headerExact, headerNorm);
			segVals.Add((seg, v));
		}

		var nonEmptyRefIdx = segVals
			.Select((x, i) => (x, i))
			.Where(t => t.x.Seg.IsColumn && !string.IsNullOrWhiteSpace(t.x.Val))
			.Select(t => t.i)
			.ToList();

		if (nonEmptyRefIdx.Count == 0)
			return "";

		int first = nonEmptyRefIdx.First();
		int last = nonEmptyRefIdx.Last();

		var sb = new StringBuilder();
		bool hasAny = false;

		for (int i = 0; i < segVals.Count; i++)
		{
			var (seg, val) = segVals[i];

			if (seg.IsColumn)
			{
				if (string.IsNullOrWhiteSpace(val))
					continue;

				sb.Append(val);
				hasAny = true;
				continue;
			}

			// literal segment
			var lit = val ?? "";
			if (string.IsNullOrEmpty(lit))
				continue;

			// Keep prefix/suffix literals only if they contain letters/digits (e.g., "Dr ")
			bool hasAlphaNum = lit.Any(ch => char.IsLetterOrDigit(ch));

			if (i < first)
			{
				if (hasAlphaNum)
					sb.Append(lit);
				continue;
			}

			if (i > last)
			{
				if (hasAlphaNum)
					sb.Append(lit);
				continue;
			}

			// Between two non-empty values -> keep separators exactly
			if (hasAny)
				sb.Append(lit);
		}

		return sb.ToString().Trim();
	}

	private static string ReadHeaderValue(
		string headerName,
		string[] row,
		Dictionary<string, int> headerExact,
		Dictionary<string, int> headerNorm)
	{
		var key = (headerName ?? "").Trim();
		if (string.IsNullOrWhiteSpace(key)) return "";

		if (headerExact.TryGetValue(key, out int idx))
			return Get(row, idx);

		var kn = NormKey(key);
		if (!string.IsNullOrWhiteSpace(kn) && headerNorm.TryGetValue(kn, out idx))
			return Get(row, idx);

		return "";
	}

	private static string ReadByAliases(ColumnSpec col, string[] row, Dictionary<string, int> headerExact, Dictionary<string, int> headerNorm,
			LabOverrides labOv)
	{
		var candidates = (col.Aliases ?? new List<string>())
			.Where(a => !string.IsNullOrWhiteSpace(a))
			.Concat(new[] { col.Name })
			.Select(a => (a ?? "").Trim())
			.Where(a => !string.IsNullOrWhiteSpace(a))
			.ToList();

		// Prefer headers explicitly present in the LAB schema when multiple COMMON aliases exist.
		var ordered = new List<string>(candidates.Count);
		var seen = new HashSet<string>(StringComparer.OrdinalIgnoreCase);

		// Preferred first (stable order)
		foreach (var c in candidates)
		{
			var cn = NormKey(c);
			var isPref = labOv.PreferredExact.Contains(c) || (!string.IsNullOrWhiteSpace(cn) && labOv.PreferredNorm.Contains(cn));
			if (!isPref) continue;

			if (seen.Add(c))
				ordered.Add(c);
		}

		// Then the remaining candidates
		foreach (var c in candidates)
		{
			var cn = NormKey(c);
			var isPref = labOv.PreferredExact.Contains(c) || (!string.IsNullOrWhiteSpace(cn) && labOv.PreferredNorm.Contains(cn));
			if (isPref) continue;

			if (seen.Add(c))
				ordered.Add(c);
		}

		foreach (var cand in ordered)
		{
			var c = (cand ?? "").Trim();
			if (string.IsNullOrWhiteSpace(c)) continue;

			if (headerExact.TryGetValue(c, out int idx))
				return Get(row, idx);

			var cn = NormKey(c);
			if (!string.IsNullOrWhiteSpace(cn) && headerNorm.TryGetValue(cn, out idx))
				return Get(row, idx);
		}

		return "";
	}

	private static string EvaluateCalculation(
		string expr,
		Dictionary<string, string> extracted,
		Dictionary<string, ColumnSpec> schemaByName,
		string[] row,
		Dictionary<string, int> headerExact,
		Dictionary<string, int> headerNorm,
		LabOverrides labOv)
	{
		decimal sum = 0m;
		bool hadAny = false;

		foreach (var token in expr.Split('+', StringSplitOptions.RemoveEmptyEntries))
		{
			var key = token.Trim();
			if (string.IsNullOrWhiteSpace(key)) continue;

			string raw = "";

			if (schemaByName.TryGetValue(key, out var refCol))
			{
				if (!extracted.TryGetValue(refCol.Name, out raw))
					raw = ReadValueForCommonColumn(refCol, row, headerExact, headerNorm, labOv);
			}
			else
			{
				if (headerExact.TryGetValue(key, out int idx))
					raw = Get(row, idx);
				else
				{
					var kn = NormKey(key);
					if (!string.IsNullOrWhiteSpace(kn) && headerNorm.TryGetValue(kn, out idx))
						raw = Get(row, idx);
				}
			}

			if (!string.IsNullOrWhiteSpace(raw))
				hadAny = true;

			sum += ParseDecimal(raw);
		}

		return hadAny ? sum.ToString(CultureInfo.InvariantCulture) : "";
	}

	private static bool IsDateType(string? dt)
		=> (dt ?? "").Trim().Equals("date", StringComparison.OrdinalIgnoreCase)
		|| (dt ?? "").Trim().Equals("datetime", StringComparison.OrdinalIgnoreCase);

	private static bool IsMetadata(string name)
		=> name.Equals("LabID", StringComparison.OrdinalIgnoreCase)
		|| name.Equals("LabName", StringComparison.OrdinalIgnoreCase)
		|| name.Equals("SourceFileID", StringComparison.OrdinalIgnoreCase)
		|| name.Equals("IngestedOn", StringComparison.OrdinalIgnoreCase)
		|| name.Equals("RowHash", StringComparison.OrdinalIgnoreCase);

	private static bool IsDays(string name)
		=> name.Equals("DaystoDOS", StringComparison.OrdinalIgnoreCase)
		|| name.Equals("RollingDays", StringComparison.OrdinalIgnoreCase)
		|| name.Equals("DaystoBill", StringComparison.OrdinalIgnoreCase)
		|| name.Equals("DaystoPost", StringComparison.OrdinalIgnoreCase);

	private static string NormalizeDate(string raw)
	{
		var dt = ParseDateMaybe(raw);
		return dt.HasValue ? dt.Value.ToString("MM/dd/yyyy", CultureInfo.InvariantCulture) : "";
	}


	private static string GetFirstNonEmpty(Dictionary<string, string> extracted, params string[] keys)
	{
		foreach (var k in keys)
		{
			if (extracted.TryGetValue(k, out var v) && !string.IsNullOrWhiteSpace(v))
				return v;
		}
		return "";
	}

	private static string DividePerUnit(Dictionary<string, string> extracted, string amountKey, decimal unitsVal)
	{
		if (!extracted.TryGetValue(amountKey, out var raw) || string.IsNullOrWhiteSpace(raw))
			return "";

		var amt = ParseDecimal(raw);
		var per = amt / unitsVal;
		return per.ToString("0.00");
	}

	private static string ComputePayStatus(Dictionary<string, string> extracted)
	{
		// Map rule terms:
		// Total Payment -> TotalPayments
		// Carrier Balance -> InsuranceBalance
		// Total Adjustment -> TotalAdjustments
		// Charge Amount -> ChargeAmount
		// Denial Code -> DenialCode
		// Carrier Payment -> InsurancePayment
		// Patient Balance -> PatientBalance

		decimal carrierPay = ParseDecimal(extracted.TryGetValue("InsurancePayment", out var ip) ? ip : "");
		decimal PatPayemnt = ParseDecimal(extracted.TryGetValue("PatientPayment", out var tp) ? tp : "");
		decimal totalPayment = carrierPay + PatPayemnt;
		decimal carrierBal = ParseDecimal(extracted.TryGetValue("InsuranceBalance", out var cb) ? cb : "");

		decimal PatAdj = ParseDecimal(extracted.TryGetValue("PatientAdjustments", out var pa) ? pa : "");
		decimal InsAdj = ParseDecimal(extracted.TryGetValue("InsuranceAdjustments", out var ia) ? ia : "");

		decimal totalAdj = PatAdj+ InsAdj;
		decimal chargeAmt = ParseDecimal(extracted.TryGetValue("ChargeAmount", out var ca) ? ca : "");

		decimal patientBal = ParseDecimal(extracted.TryGetValue("PatientBalance", out var pb) ? pb : "");

		var denial = (extracted.TryGetValue("DenialCode", out var dc) ? dc : "") ?? "";
		bool hasDenial = !string.IsNullOrWhiteSpace(denial);

		const decimal EPS = 0.00m;

		// Paid
		if (totalPayment > EPS)
			return "Paid";

		// Patient Responsibility
		if (Math.Abs(carrierPay) <= EPS && patientBal > EPS)
			return "Patient Responsibility";

		// Denied
		if (Math.Abs(totalPayment) <= EPS && carrierBal > EPS && hasDenial)
			return "Denied";

		if (Math.Abs(totalPayment) <= EPS && Math.Abs(totalAdj) <= EPS && Math.Abs(carrierBal) <= EPS && hasDenial)
			return "Denied";

		// Adjusted
		if (Math.Abs(totalPayment) <= EPS && carrierBal <= EPS && totalAdj >= chargeAmt)
			return "Adjusted";

		// Partially Adjusted
		if (Math.Abs(totalPayment) == EPS && carrierBal > EPS && totalAdj > EPS && !hasDenial)
			return "Partially Adjusted";

		// No Response
		if (Math.Abs(chargeAmt - carrierBal) <= EPS && !hasDenial)
			return "No Response";

		if (Math.Abs(totalPayment) <= EPS && Math.Abs(totalAdj) <= EPS && Math.Abs(carrierBal) <= EPS && !hasDenial)
			return "No Response";

		return "";
	}

	private static DateTime? ParseDateMaybe(string raw)
	{
		raw = (raw ?? "").Trim();
		if (string.IsNullOrWhiteSpace(raw)) return null;

		// Excel serial number
		if (double.TryParse(raw, NumberStyles.Any, CultureInfo.InvariantCulture, out var oa))
		{
			if (oa > 20000 && oa < 60000)
			{
				try { return DateTime.FromOADate(oa); } catch { }
			}
		}

		var formats = new[]
		{
			"MM/dd/yyyy","M/d/yyyy",
			"dd/MM/yyyy","d/M/yyyy",
			"yyyy-MM-dd","yyyy/M/d","yyyy/MM/dd",
			"yyyy-MM-dd HH:mm:ss","yyyy/MM/dd HH:mm:ss","MM/dd/yyyy HH:mm:ss","M/d/yyyy H:mm:ss",
			"MM/dd/yyyy h:mm:ss tt","M/d/yyyy h:mm:ss tt",
			"dd-MMM-yyyy","d-MMM-yyyy","dd-MMM-yy","d-MMM-yy"
		};

		if (DateTime.TryParseExact(raw, formats, CultureInfo.InvariantCulture, DateTimeStyles.AllowWhiteSpaces, out var dtExact))
			return dtExact;

		if (DateTime.TryParse(raw, new CultureInfo("en-SG"), DateTimeStyles.AllowWhiteSpaces, out var dtSg))
			return dtSg;

		if (DateTime.TryParse(raw, CultureInfo.InvariantCulture, DateTimeStyles.AllowWhiteSpaces, out var dtAny))
			return dtAny;

		return null;
	}

	private static decimal ParseDecimal(string raw)
	{
		raw = (raw ?? "").Trim();
		if (string.IsNullOrWhiteSpace(raw)) return 0m;

		raw = raw.Replace("$", "").Replace(",", "");

		bool neg = raw.StartsWith("(") && raw.EndsWith(")");
		if (neg) raw = raw.Trim('(', ')');

		if (decimal.TryParse(raw, NumberStyles.Any, CultureInfo.InvariantCulture, out var d))
			return neg ? -d : d;

		if (decimal.TryParse(raw, NumberStyles.Any, new CultureInfo("en-US"), out d))
			return neg ? -d : d;

		if (decimal.TryParse(raw, NumberStyles.Any, new CultureInfo("en-SG"), out d))
			return neg ? -d : d;

		return 0m;
	}

	private static string Get(string[] row, int idx)
		=> idx >= 0 && idx < row.Length ? (row[idx] ?? "") : "";

	private static string NormKey(string s)
	{
		if (string.IsNullOrWhiteSpace(s)) return "";
		s = s.Trim().ToLowerInvariant();
		return Regex.Replace(s, @"[^a-z0-9]+", "");
	}

	private static string Escape(string? s)
	{
		if (string.IsNullOrEmpty(s))
			return "";

		bool mustQuote = s.Contains(',') || s.Contains('"') || s.Contains('\n') || s.Contains('\r');
		if (!mustQuote)
			return s;

		return $"\"{s.Replace("\"", "\"\"")}\"";
	}
}
