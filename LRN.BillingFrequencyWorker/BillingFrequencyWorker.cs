using Common.Logging;
using DocumentFormat.OpenXml.Drawing.Charts;
using Microsoft.Extensions.Configuration;
using Microsoft.Extensions.Hosting;
using Microsoft.Extensions.Logging;
using Microsoft.Extensions.Options;
using System.Data;
using System.Text.RegularExpressions;

public sealed class BillingFrequencyWorker : BackgroundService
{
	private readonly ImportOptions _opt;
	private readonly string _connStr;
	private readonly SharePointDownloader _sp;
	private readonly BillingFrequencyFileStatusStore _status;
	private readonly ILoggerService _logger;
	public BillingFrequencyWorker(
		ILoggerService logger,
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

		_logger.Info($"Worker started. SharePoint.Enabled={_opt.SharePoint.Enabled}. EnableBillingFrequency={_opt.EnableBillingFrequency}");

		while (!stoppingToken.IsCancellationRequested)
		{
			try
			{
				if (_opt.SharePoint.Enabled)
					await ProcessSharePointOnceAsync(stoppingToken);
				else
					_logger.Warn("SharePoint is disabled. Nothing to do.");
			}
			catch (OperationCanceledException) when (stoppingToken.IsCancellationRequested)
			{
				// graceful shutdown
			}
			catch (Exception ex)
			{
				_logger.Error($"ERROR : {ex} -Top - level worker loop error.");
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
					_logger.Info($"Lab {lab.LabId}: no eligible SharePoint file found.");
					continue;
				}

				// Skip if already processed
				if (await _status.IsProcessedAsync(selected.LabId, selected.DriveId, selected.ItemId, selected.ETagKey, ct))
				{
					_logger.Info($"Lab {lab.LabId}: already processed, skipping: {selected.Name}");
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

				_logger.Info($"Lab {lab.LabId}: downloading {selected.SharePointPath} -> {stagingPath}");
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

				var baseName = Path.GetFileNameWithoutExtension(selected.Name);
				baseName = SanitizeFileName(baseName);

				var claimOutPath = Path.Combine(claimDir, $"{baseName}_ClaimLevel_{dateFolder}.xlsx");
				var lineOutPath = Path.Combine(lineDir, $"{baseName}_LineLevel_{dateFolder}.xlsx");

				await _status.UpsertStatusAsync(
					selected.LabId, selected.DriveId, selected.ItemId, selected.ETagKey,
					selected.Name, selected.SharePointPath, selected.LastModifiedUtc,
					status: "IN_PROGRESS",
					statusMessage: $"Splitting workbook into ClaimLevel and LineLevel reports. Output={baseOut}",
					processedAtUtc: null,
					ct);

				// Export sheets (choose first matching sheet name from candidates)
				var usedLineSheet = BillingExcelReader.ExportSingleSheetToFile(stagingPath, _opt.SheetName, lineOutPath);
				var claimCandidates = string.IsNullOrWhiteSpace(_opt.ClaimSheetName)
					? "Claim Level,ClaimLevel,Master Claim Level,Master_Claim_Level,Claim_Level"
					: _opt.ClaimSheetName;

				var usedClaimSheet = BillingExcelReader.ExportSingleSheetToFile(stagingPath, claimCandidates, claimOutPath);

				_logger.Info($"Lab {lab.LabId}: exported LineLevel sheet '{usedLineSheet}' -> {lineOutPath}");
				_logger.Info($"Lab {lab.LabId}: exported ClaimLevel sheet '{usedClaimSheet}' -> {claimOutPath}");

				// Optional: Billing frequency processing (kept separate & toggleable)
				if (_opt.EnableBillingFrequency)
				{
					if (string.IsNullOrWhiteSpace(_connStr))
						throw new InvalidOperationException("EnableBillingFrequency=true but DefaultConnection is missing.");

					await _status.UpsertStatusAsync(
						selected.LabId, selected.DriveId, selected.ItemId, selected.ETagKey,
						selected.Name, selected.SharePointPath, selected.LastModifiedUtc,
						status: "IN_PROGRESS",
						statusMessage: "Calculating billing frequency and loading into SQL.",
						processedAtUtc: null,
						ct);

					var rows = BillingExcelReader.ReadLineLevelRows(lineOutPath, null, _opt.HeaderRow); // only sheet exists now
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
					_logger.Info($"Lab {lab.LabId}: moved SharePoint file to processed folder.");
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
				_logger.Error($"ERROR : {ex} - Lab {lab.LabId}: error processing SharePoint file.");

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

				// Move staging file to error folder if it exists
				try
				{
					// best-effort: find last downloaded file for this lab name prefix
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

	private static (string MonthFolder, string DateFolder) ParseMonthAndDateFolder(string sharePointPath)
	{
		// Expected: .../<Year>/<Month>/<DateRange>/<File>
		var parts = sharePointPath.Split('/', StringSplitOptions.RemoveEmptyEntries | StringSplitOptions.TrimEntries);

		// try to locate a 4-digit year segment
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
		{
			return (parts[yearIndex + 1], parts[yearIndex + 2]);
		}

		// fallback: assume last segments
		if (parts.Length >= 3)
			return (parts[^3], parts[^2]);

		return ("UnknownMonth", "UnknownDate");
	}

	private static string GetLabFolderName(LabFileMap lab)
	{
		if (!string.IsNullOrWhiteSpace(lab.LabName))
			return SanitizePathSegment(lab.LabName);

		// Derive from file pattern prefix (e.g. "Cove_*.xlsx" -> "Cove")
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
