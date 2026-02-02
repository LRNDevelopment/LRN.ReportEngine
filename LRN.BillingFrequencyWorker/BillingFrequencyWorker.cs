using Microsoft.Extensions.Hosting;
using Microsoft.Extensions.Logging;
using Microsoft.Extensions.Options;
using Microsoft.Extensions.Configuration;
using System.Data;
using System.Text.RegularExpressions;
using System.Diagnostics;
using Microsoft.VisualBasic.FileIO;
using System.Globalization;

public sealed class BillingFrequencyWorker : BackgroundService
{
	private readonly ILogger<BillingFrequencyWorker> _logger;
	private readonly ImportOptions _opt;
	private readonly string _connStr;
	private readonly SharePointDownloader _sp;
	private readonly BillingFrequencyFileStatusStore _status;

	public BillingFrequencyWorker(
		ILogger<BillingFrequencyWorker> logger,
		IOptions<ImportOptions> options,
		IConfiguration config,
		SharePointDownloader sp,
		BillingFrequencyFileStatusStore status)
	{
		_logger = logger;
		_opt = options.Value;
		_connStr = config.GetConnectionString("DefaultConnection") ?? "";
		_sp = sp;
		_status = status;
	}

	protected override async Task ExecuteAsync(CancellationToken stoppingToken)
	{
		EnsureFolders();

		_logger.LogInformation("Worker started. SharePoint.Enabled={Enabled}. EnableBillingFrequency={BillingFreq}",
			_opt.SharePoint.Enabled, _opt.EnableBillingFrequency);

		while (!stoppingToken.IsCancellationRequested)
		{
			try
			{
				if (_opt.SharePoint.Enabled)
					await ProcessSharePointOnceAsync(stoppingToken);
				else
					_logger.LogWarning("SharePoint is disabled. Nothing to do.");
			}
			catch (OperationCanceledException) when (stoppingToken.IsCancellationRequested)
			{
				// graceful shutdown
			}
			catch (Exception ex)
			{
				_logger.LogError(ex, "Top-level worker loop error.");
			}

			try
			{
				await Task.Delay(TimeSpan.FromSeconds(Math.Max(10, _opt.PollSeconds)), stoppingToken);
			}
			catch (OperationCanceledException) { }
		}
	}

	private void EnsureFolders()
	{
		if (string.IsNullOrWhiteSpace(_opt.WatchFolder))
			_opt.WatchFolder = Path.Combine(AppContext.BaseDirectory, "input");

		if (string.IsNullOrWhiteSpace(_opt.ErrorFolder))
			_opt.ErrorFolder = Path.Combine(AppContext.BaseDirectory, "error");

		if (string.IsNullOrWhiteSpace(_opt.ReportOutputsRoot))
			_opt.ReportOutputsRoot = Path.Combine(AppContext.BaseDirectory, "LabReportOutputs");

		Directory.CreateDirectory(_opt.WatchFolder);
		Directory.CreateDirectory(_opt.ErrorFolder);
		Directory.CreateDirectory(_opt.ReportOutputsRoot);
	}

	private async Task ProcessSharePointOnceAsync(CancellationToken ct)
	{
		var currentYear = DateTime.Now.Year;

		foreach (var lab in _opt.Labs)
		{
			ct.ThrowIfCancellationRequested();

			SharePointDownloader.SelectedFile? selected = null;

			try
			{
				selected = await _sp.TryGetLatestFileForLabAsync(lab, currentYear, ct);
				if (selected == null)
				{
					_logger.LogInformation("Lab {LabId}: no eligible SharePoint file found.", lab.LabId);
					continue;
				}

				// Skip if already processed
				if (await _status.IsProcessedAsync(selected.LabId, selected.DriveId, selected.ItemId, selected.ETagKey, ct))
				{
					_logger.LogInformation("Lab {LabId}: already processed, skipping: {File}", lab.LabId, selected.Name);
					continue;
				}

				await _status.UpsertStatusAsync(
					selected.LabId, selected.DriveId, selected.ItemId, selected.ETagKey,
					selected.Name, selected.SharePointPath, selected.LastModifiedUtc,
					status: "IN_PROGRESS",
					statusMessage: "Downloading from SharePoint",
					processedAtUtc: null,
					ct);

				// Download to staging
				var stagingFileName = $"{GetLabFolderName(lab)}_{selected.Name}";
				stagingFileName = SanitizeFileName(stagingFileName);
				var stagingPath = Path.Combine(_opt.WatchFolder, stagingFileName);

				_logger.LogInformation("Lab {LabId}: downloading {SpPath} -> {Local}", lab.LabId, selected.SharePointPath, stagingPath);
				await _sp.DownloadFileAsync(selected.DriveId, selected.ItemId, stagingPath, ct);

				// Validate download looks like XLSX
				BillingExcelReader.ValidateDownloadedXlsxOrThrow(stagingPath);

				// Determine output folders from SharePoint path
				var (monthFolder, dateFolder) = ParseMonthAndDateFolder(selected.SharePointPath);

				var baseOut = Path.Combine(
					_opt.ReportOutputsRoot,
					"Masters",
					GetLabFolderName(lab),
					"Master",
					DateTime.Now.ToString("MMMM"),
					DateTime.Now.ToString("dd"));

				var claimDir = Path.Combine(baseOut, "ClaimLevel");
				var lineDir = Path.Combine(baseOut, "LineLevel");

				Directory.CreateDirectory(claimDir);
				Directory.CreateDirectory(lineDir);

				var baseName = Path.GetFileNameWithoutExtension(selected.Name);
				baseName = SanitizeFileName(baseName);

				var claimOutPath = Path.Combine(claimDir, $"{selected.Name}_ClaimLevel.csv");
				var lineOutPath = Path.Combine(lineDir, $"{selected.Name}_LineLevel.csv");

				await _status.UpsertStatusAsync(
					selected.LabId, selected.DriveId, selected.ItemId, selected.ETagKey,
					selected.Name, selected.SharePointPath, selected.LastModifiedUtc,
					status: "IN_PROGRESS",
					statusMessage: $"Exporting ClaimLevel/LineLevel to CSV. Output={baseOut}",
					processedAtUtc: null,
					ct);

				// Sheet candidates
				var lineCandidates = string.IsNullOrWhiteSpace(_opt.SheetName)
					? "Master Line Level,Line Level,LineLevel,Master_Line_Level"
					: _opt.SheetName;

				var claimCandidates = string.IsNullOrWhiteSpace(_opt.ClaimSheetName)
					? "Claim Level,ClaimLevel,Master Claim Level,Master_Claim_Level,Claim_Level"
					: _opt.ClaimSheetName;

				// Export CSVs (fast + no formatting + avoids pivot-cache issues)
				var sw = Stopwatch.StartNew();
				var (usedClaimSheet, usedLineSheet) =
					await ExcelCsvExporter.ExportClaimAndLineCsvAsync(
						stagingPath,
						claimOutPath,
						lineOutPath,
						claimCandidates,
						lineCandidates,
						ct);

				_logger.LogInformation("Lab {LabId}: CSV export finished in {Ms} ms. ClaimSheet={ClaimSheet} LineSheet={LineSheet}",
					lab.LabId, sw.ElapsedMilliseconds, usedClaimSheet ?? "(not found)", usedLineSheet ?? "(not found)");

				if (usedLineSheet == null)
					_logger.LogWarning("Lab {LabId}: LineLevel CSV NOT written. None of these sheets exist: {Sheets}", lab.LabId, lineCandidates);

				if (usedClaimSheet == null)
					_logger.LogWarning("Lab {LabId}: ClaimLevel CSV NOT written. None of these sheets exist: {Sheets}", lab.LabId, claimCandidates);

				// Optional: Billing frequency processing (kept separate & toggleable)
				if (_opt.EnableBillingFrequency)
				{
					if (string.IsNullOrWhiteSpace(_connStr))
						throw new InvalidOperationException("EnableBillingFrequency=true but DefaultConnection is missing.");

					if (!File.Exists(lineOutPath))
						throw new InvalidOperationException($"EnableBillingFrequency=true but LineLevel CSV not found: {lineOutPath}");

					await _status.UpsertStatusAsync(
						selected.LabId, selected.DriveId, selected.ItemId, selected.ETagKey,
						selected.Name, selected.SharePointPath, selected.LastModifiedUtc,
						status: "IN_PROGRESS",
						statusMessage: "Calculating billing frequency from LineLevel CSV and loading into SQL.",
						processedAtUtc: null,
						ct);

					var rows = ReadLineLevelRowsFromCsv(lineOutPath);
					var countsDt = BillingGrouper.BuildBillingCounts(rows, lab.LabId);

					await BillingSqlLoader.ReplaceLabDataAsync(_connStr, _opt.DestinationTable, lab.LabId, countsDt, ct);
				}

				// Mark PROCESSED
				await _status.UpsertStatusAsync(
					selected.LabId, selected.DriveId, selected.ItemId, selected.ETagKey,
					selected.Name, selected.SharePointPath, selected.LastModifiedUtc,
					status: "PROCESSED",
					statusMessage: $"Saved LineLevel='{lineOutPath}', ClaimLevel='{claimOutPath}'. BillingFrequency={(_opt.EnableBillingFrequency ? "DONE" : "SKIPPED")}.",
					processedAtUtc: DateTimeOffset.UtcNow,
					ct);

				// Optional SharePoint move (still supported)
				var processedFolderId = await _sp.TryResolveProcessedFolderIdAsync(ct);
				if (!string.IsNullOrWhiteSpace(processedFolderId))
				{
					await _sp.MoveItemAsync(selected.DriveId, selected.ItemId, processedFolderId!, ct);
					_logger.LogInformation("Lab {LabId}: moved SharePoint file to processed folder.", lab.LabId);
				}

				// Cleanup staging file (no archive move)
				if (!_opt.KeepDownloadedFiles)
				{
					TryDelete(stagingPath);
				}
			}
			catch (OperationCanceledException) when (ct.IsCancellationRequested)
			{
				throw;
			}
			catch (Exception ex)
			{
				_logger.LogError(ex, "Lab {LabId}: error processing SharePoint file.", lab.LabId);

				if (selected != null)
				{
					await _status.UpsertStatusAsync(
						selected.LabId, selected.DriveId, selected.ItemId, selected.ETagKey,
						selected.Name, selected.SharePointPath, selected.LastModifiedUtc,
						status: "ERROR",
						statusMessage: ex.Message,
						processedAtUtc: null,
						ct);
				}

				// Move staging file to error folder if it exists (best-effort)
				try
				{
					var prefix = SanitizeFileName($"{GetLabFolderName(lab)}_");
					var candidates = Directory.Exists(_opt.WatchFolder)
						? Directory.GetFiles(_opt.WatchFolder, prefix + "*.xlsx")
						: Array.Empty<string>();

					foreach (var f in candidates)
					{
						var dest = Path.Combine(_opt.ErrorFolder, $"{Path.GetFileNameWithoutExtension(f)}_{DateTime.Now:yyyyMMdd_HHmmss}.xlsx");
						TryMove(f, dest);
					}
				}
				catch { /* ignore */ }
			}
		}
	}

	private static List<BillingLineRow> ReadLineLevelRowsFromCsv(string csvPath)
	{
		// Uses TextFieldParser for correct CSV parsing (quotes/commas)
		using var parser = new TextFieldParser(csvPath);
		parser.TextFieldType = FieldType.Delimited;
		parser.SetDelimiters(",");
		parser.HasFieldsEnclosedInQuotes = true;

		if (parser.EndOfData)
			return new List<BillingLineRow>();

		// Header
		var header = parser.ReadFields() ?? Array.Empty<string>();
		int cChart = FindCol(header, "ChartNumber", "PatientId", "Patient ID");
		int cPay = FindCol(header, "PanelCarrier", "Payer", "Carrier");
		int cCpt = FindCol(header, "CPTCode", "CPT", "Panel");
		int cVisit = FindCol(header, "VisitNumber", "BillingNumber", "Billing #", "Visit #");
		int cDos = FindCol(header, "BeginDOS", "DateOfService", "DOS", "Date Of Service");

		if (cChart < 0 || cVisit < 0 || cDos < 0)
			throw new InvalidOperationException($"CSV missing required columns. Found headers: {string.Join(", ", header)}");

		var list = new List<BillingLineRow>();

		while (!parser.EndOfData)
		{
			var fields = parser.ReadFields();
			if (fields == null || fields.Length == 0) continue;

			string chart = SafeGet(fields, cChart).Trim();
			string visit = SafeGet(fields, cVisit).Trim();
			if (string.IsNullOrWhiteSpace(chart) || string.IsNullOrWhiteSpace(visit))
				continue;

			string payer = cPay >= 0 ? SafeGet(fields, cPay).Trim() : "";
			string cpt = cCpt >= 0 ? SafeGet(fields, cCpt).Trim() : "";
			string dosRaw = SafeGet(fields, cDos).Trim();

			if (!TryParseDate(dosRaw, out var dos))
				continue;

			list.Add(new BillingLineRow
			{
				ChartNumber = chart,
				VisitNumber = visit,
				PanelCarrier = payer,
				CPTCode = cpt,
				BeginDOS = dos.Date
			});
		}

		return list;
	}

	private static bool TryParseDate(string input, out DateTime dt)
	{
		dt = default;

		if (string.IsNullOrWhiteSpace(input))
			return false;

		// ExcelCsvExporter writes DateTime as "yyyy-MM-dd HH:mm:ss"
		if (DateTime.TryParseExact(input,
				new[] { "yyyy-MM-dd HH:mm:ss", "yyyy-MM-dd", "MM/dd/yyyy", "M/d/yyyy", "dd/MM/yyyy", "d/M/yyyy" },
				CultureInfo.InvariantCulture,
				DateTimeStyles.AssumeLocal,
				out dt))
		{
			return true;
		}

		// fallback: normal parse
		return DateTime.TryParse(input, CultureInfo.InvariantCulture, DateTimeStyles.AssumeLocal, out dt);
	}

	private static int FindCol(string[] header, params string[] names)
	{
		for (int i = 0; i < header.Length; i++)
		{
			var h = (header[i] ?? "").Trim();
			foreach (var n in names)
			{
				if (h.Equals(n, StringComparison.OrdinalIgnoreCase))
					return i;
			}
		}
		return -1;
	}

	private static string SafeGet(string[] fields, int index)
	{
		if (index < 0 || index >= fields.Length) return "";
		return fields[index] ?? "";
	}

	private static (string MonthFolder, string DateFolder) ParseMonthAndDateFolder(string sharePointPath)
	{
		// Expected: .../<Year>/<Month>/<DateRange>/<File>
		var parts = sharePointPath.Split('/', StringSplitOptions.RemoveEmptyEntries | StringSplitOptions.TrimEntries);

		int yearIndex = -1;
		for (int i = 0; i < parts.Length; i++)
		{
			if (Regex.IsMatch(parts[i], @"^\d{4}$"))
			{
				yearIndex = i;
				break;
			}
		}

		if (yearIndex >= 0 && yearIndex + 2 < parts.Length)
			return (parts[yearIndex + 1], parts[yearIndex + 2]);

		if (parts.Length >= 3)
			return (parts[^3], parts[^2]);

		return ("UnknownMonth", "UnknownDate");
	}

	private static string GetLabFolderName(LabFileMap lab)
	{
		if (!string.IsNullOrWhiteSpace(lab.LabName))
			return SanitizePathSegment(lab.LabName);

		var p = lab.FilePattern ?? "";
		var prefix = p.Split('*', '?').FirstOrDefault() ?? p;
		prefix = Path.GetFileNameWithoutExtension(prefix);
		prefix = prefix.Trim().TrimEnd('_', '-', ' ');
		if (string.IsNullOrWhiteSpace(prefix))
			prefix = lab.LabId.ToString();

		return SanitizePathSegment(prefix);
	}

	private static string SanitizePathSegment(string input)
	{
		foreach (var c in Path.GetInvalidFileNameChars())
			input = input.Replace(c, '_');
		return input.Trim();
	}

	private static string SanitizeFileName(string input)
	{
		foreach (var c in Path.GetInvalidFileNameChars())
			input = input.Replace(c, '_');
		return input.Trim();
	}

	private static void TryDelete(string path)
	{
		try
		{
			if (File.Exists(path))
				File.Delete(path);
		}
		catch { }
	}

	private static void TryMove(string src, string dest)
	{
		try
		{
			Directory.CreateDirectory(Path.GetDirectoryName(dest)!);
			if (File.Exists(dest))
				File.Delete(dest);
			File.Move(src, dest);
		}
		catch { }
	}
}
