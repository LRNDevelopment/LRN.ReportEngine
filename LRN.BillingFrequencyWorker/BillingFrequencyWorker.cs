using DocumentFormat.OpenXml.Wordprocessing;
using Microsoft.Extensions.Configuration;
using Microsoft.Extensions.Hosting;
using Microsoft.Extensions.Logging;
using Microsoft.Extensions.Options;
using System.Data;

public sealed class BillingFrequencyWorker : BackgroundService
{
	private readonly ILogger<BillingFrequencyWorker> _logger;
	private readonly ImportOptions _opt;
	private readonly string _connStr;
	private readonly SharePointDownloader _sp;
	private readonly BillingFrequencyFileStatusStore _statusStore;
	private static string _payerPolicyfile = "";
	public BillingFrequencyWorker(
		ILogger<BillingFrequencyWorker> logger,
		IOptions<ImportOptions> options,
		IConfiguration config,
		SharePointDownloader sp,
		BillingFrequencyFileStatusStore statusStore)
	{
		_logger = logger;
		_opt = options.Value;
		_connStr = config.GetConnectionString("DefaultConnection")!;
		_sp = sp;
		_statusStore = statusStore;

		// Quick visibility during local debugging
		_logger.LogInformation("Config: SharePoint.Enabled={Enabled}", _opt.SharePoint.Enabled);
	}

	protected override async Task ExecuteAsync(CancellationToken stoppingToken)
	{
		_payerPolicyfile = Path.Combine(_opt.PayerPolicyDataFile, DateTime.Now.ToString("MMddyyyy")); ;
		Directory.CreateDirectory(_opt.WatchFolder);
		Directory.CreateDirectory(_opt.ArchiveFolder);
		Directory.CreateDirectory(_opt.ErrorFolder);
		Directory.CreateDirectory(_payerPolicyfile);

		_logger.LogInformation("BillingFrequencyWorker started. WatchFolder={WatchFolder}", _opt.WatchFolder);

		// Resolve processed folder (optional SharePoint move) once, and refresh if it fails later.
		string? processedFolderId = null;

		while (!stoppingToken.IsCancellationRequested)
		{
			try
			{
				if (_opt.SharePoint.Enabled)
				{
					if (processedFolderId is null)
					{
						try
						{
							processedFolderId = await _sp.TryResolveProcessedFolderIdAsync(stoppingToken);
							if (!string.IsNullOrWhiteSpace(processedFolderId))
								_logger.LogInformation("Resolved SharePoint processed folder id.");
						}
						catch (Exception ex)
						{
							_logger.LogWarning(ex, "Failed to resolve processed folder id (will retry later). Moving on.");
						}
					}

					await ProcessSharePointLabsOnceAsync(processedFolderId, stoppingToken);
				}
				else
				{
					await ProcessLocalFolderOnceAsync(stoppingToken);
				}

				await Task.Delay(TimeSpan.FromSeconds(_opt.PollSeconds), stoppingToken);
			}
			catch (TaskCanceledException)
			{
				// normal shutdown
			}
			catch (Exception ex)
			{
				_logger.LogError(ex, "Worker loop error");
				await Task.Delay(TimeSpan.FromSeconds(_opt.PollSeconds), stoppingToken);
			}
		}

		_logger.LogInformation("BillingFrequencyWorker stopped.");
	}

	private async Task ProcessSharePointLabsOnceAsync(string? processedFolderId, CancellationToken ct)
	{
		int currentYear = DateTime.Now.Year;

		foreach (var lab in _opt.Labs)
		{
			ct.ThrowIfCancellationRequested();

			if (string.IsNullOrWhiteSpace(lab.SharePointRootPath))
			{
				_logger.LogWarning("Lab {LabId}: SharePointRootPath is empty; skipping.", lab.LabId);
				continue;
			}

			if (string.IsNullOrWhiteSpace(lab.SharePointFilePattern))
				lab.SharePointFilePattern = "*.xlsx";

			SharePointDownloader.SelectedFile? selected = null;
			string? localPath = null;

			try
			{
				selected = await _sp.TryGetLatestFileForLabAsync(lab, currentYear, ct);
				if (selected == null)
					continue;

				// Skip if already processed
				//if (await _statusStore.IsProcessedAsync(selected.LabId, selected.DriveId, selected.ItemId, selected.ETagKey, ct))
				//{
				//	_logger.LogInformation("Lab {LabId}: already PROCESSED -> {Path}", selected.LabId, selected.SharePointPath);
				//	continue;
				//}

				// Mark attempt
				await _statusStore.UpsertStatusAsync(
					labId: selected.LabId,
					driveId: selected.DriveId,
					itemId: selected.ItemId,
					eTagKey: selected.ETagKey,
					fileName: selected.Name,
					sharePointPath: selected.SharePointPath,
					lastModifiedUtc: selected.LastModifiedUtc,
					status: "IN_PROGRESS",
					statusMessage: "Downloading + processing",
					processedAtUtc: null,
					ct: ct);

				var localName = $"{selected.LabId}_{SanitizeFileName(selected.Name)}";
				localPath = Path.Combine(_opt.WatchFolder, localName);
				var PayerPolicyDataFileLocalName = Path.Combine(_payerPolicyfile, selected.Name);
				_logger.LogInformation("Lab {LabId}: downloading '{File}' -> '{Local}'", selected.LabId, selected.Name, localPath);
				////await _sp.DownloadFileAsync(selected.DriveId, selected.ItemId, localPath!, ct);
				if (!File.Exists(PayerPolicyDataFileLocalName))
				{
					await _sp.DownloadFileAsync(selected.DriveId, selected.ItemId, PayerPolicyDataFileLocalName!, ct);
				}
				//await ValidateOrThrowAsync(localPath, ct);

				// Extract process with grouping and SQL load commented for now

				////_logger.LogInformation("Lab {LabId}: reading Excel '{Local}'", selected.LabId, localPath);
				////            var rows = BillingExcelReader.ReadLineLevelRows(localPath!, _opt.SheetName, _opt.HeaderRow);

				////            if (rows.Count == 0)
				////                throw new InvalidOperationException("No line-level rows found in the Excel file.");

				////            // Group
				////            DataTable countsDt = BillingGrouper.BuildBillingCounts(rows, selected.LabId);

				////            // Replace lab data
				////            _logger.LogInformation("Lab {LabId}: deleting + bulk inserting {Count} grouped rows", selected.LabId, countsDt.Rows.Count);
				////            await BillingSqlLoader.ReplaceLabDataAsync(_connStr, _opt.DestinationTable, selected.LabId, countsDt, ct);

				////            // Archive local file
				////            SafeMoveToArchive(localPath!);

				////            // Optional: move file on SharePoint to processed folder
				////            if (!string.IsNullOrWhiteSpace(processedFolderId))
				////            {
				////                try
				////                {
				////                    await _sp.MoveItemAsync(selected.DriveId, selected.ItemId, processedFolderId!, ct);
				////                    _logger.LogInformation("Lab {LabId}: moved SharePoint file to processed folder.", selected.LabId);
				////                }
				////                catch (Exception ex)
				////                {
				////                    _logger.LogWarning(ex, "Lab {LabId}: failed to move SharePoint file to processed folder (non-fatal).", selected.LabId);
				////                }
				////            }

				// Mark success
				await _statusStore.UpsertStatusAsync(
					labId: selected.LabId,
					driveId: selected.DriveId,
					itemId: selected.ItemId,
					eTagKey: selected.ETagKey,
					fileName: selected.Name,
					sharePointPath: selected.SharePointPath,
					lastModifiedUtc: selected.LastModifiedUtc,
					status: "PROCESSED",
					statusMessage: null,
					processedAtUtc: DateTimeOffset.UtcNow,
					ct: ct);

				_logger.LogInformation("Lab {LabId}: PROCESSED -> {Path}", selected.LabId, selected.SharePointPath);
			}
			catch (Exception ex)
			{
				_logger.LogError(ex, "Lab {LabId}: ERROR processing SharePoint file", lab.LabId);
				//if (!string.IsNullOrWhiteSpace(localPath)) SafeMoveToError(localPath!);

				// Best-effort: record error status
				if (selected != null)
				{
					await _statusStore.UpsertStatusAsync(
						labId: selected.LabId,
						driveId: selected.DriveId,
						itemId: selected.ItemId,
						eTagKey: selected.ETagKey,
						fileName: selected.Name,
						sharePointPath: selected.SharePointPath,
						lastModifiedUtc: selected.LastModifiedUtc,
						status: "ERROR",
						statusMessage: ex.Message,
						processedAtUtc: null,
						ct: ct);
				}
			}
		}
	}

	// Optional local fallback if you want to drop files manually into WatchFolder.
	private async Task ProcessLocalFolderOnceAsync(CancellationToken ct)
	{
		var files = Directory.GetFiles(_opt.WatchFolder, _opt.SearchPattern);

		var mapped = files
			.Select(f => new { File = f, LabId = ResolveLabId(Path.GetFileName(f)) })
			.Where(x => x.LabId != null)
			.GroupBy(x => x.LabId!.Value)
			.ToList();

		foreach (var labGroup in mapped)
		{
			var labId = labGroup.Key;
			var labFiles = labGroup.Select(x => x.File).ToList();

			var allLineRows = new List<BillingLineRow>();

			foreach (var file in labFiles)
			{
				if (!IsFileReady(file))
					continue;

				_logger.LogInformation("Reading local file {File}", file);

				var rows = BillingExcelReader.ReadLineLevelRows(file, _opt.SheetName, _opt.HeaderRow);
				allLineRows.AddRange(rows);
			}

			if (allLineRows.Count == 0)
				continue;

			DataTable countsDt = BillingGrouper.BuildBillingCounts(allLineRows, labId);

			await BillingSqlLoader.ReplaceLabDataAsync(_connStr, _opt.DestinationTable, labId, countsDt, ct);

			//foreach (var file in labFiles)
			//	SafeMoveToArchive(file);
		}
	}

	private int? ResolveLabId(string fileName)
	{
		foreach (var map in _opt.Labs)
		{
			if (!string.IsNullOrWhiteSpace(map.FilePattern) && WildcardMatch(fileName, map.FilePattern))
				return map.LabId;
		}
		return null;
	}

	private void SafeMoveToArchive(string file)
	{
		try
		{
			if (!File.Exists(file)) return;

			var stamp = DateTime.Now.ToString("yyyyMMdd_HHmmss");
			var dest = Path.Combine(_opt.ArchiveFolder, $"{Path.GetFileNameWithoutExtension(file)}_{stamp}{Path.GetExtension(file)}");
			File.Move(file, dest, overwrite: true);
			_logger.LogInformation("Archived {File} -> {Dest}", file, dest);
		}
		catch (Exception ex)
		{
			_logger.LogError(ex, "Failed to archive {File}", file);
		}
	}

	private void SafeMoveToError(string file)
	{
		try
		{
			if (!File.Exists(file)) return;

			var stamp = DateTime.Now.ToString("yyyyMMdd_HHmmss");
			var dest = Path.Combine(_opt.ErrorFolder, $"{Path.GetFileNameWithoutExtension(file)}_{stamp}{Path.GetExtension(file)}");
			File.Move(file, dest, overwrite: true);
			_logger.LogInformation("Moved to error {File} -> {Dest}", file, dest);
		}
		catch (Exception ex)
		{
			_logger.LogError(ex, "Failed to move to error {File}", file);
		}
	}

	private static string SanitizeFileName(string name)
	{
		foreach (var c in Path.GetInvalidFileNameChars())
			name = name.Replace(c, '_');
		return name;
	}

	private static bool WildcardMatch(string input, string pattern)
	{
		var regex = "^" + System.Text.RegularExpressions.Regex.Escape(pattern)
			.Replace("\\*", ".*")
			.Replace("\\?", ".") + "$";
		return System.Text.RegularExpressions.Regex.IsMatch(input, regex, System.Text.RegularExpressions.RegexOptions.IgnoreCase);
	}

	private static bool IsFileReady(string path)
	{
		try
		{
			using var stream = new FileStream(path, FileMode.Open, FileAccess.Read, FileShare.None);
			return stream.Length > 0;
		}
		catch { return false; }
	}

	static bool LooksLikeXlsxZip(string path)
	{
		using var fs = File.OpenRead(path);
		if (fs.Length < 4) return false;
		Span<byte> b = stackalloc byte[2];
		fs.Read(b);
		return b[0] == (byte)'P' && b[1] == (byte)'K'; // zip signature
	}

	static async Task ValidateOrThrowAsync(string path, CancellationToken ct)
	{
		var fi = new FileInfo(path);
		if (!fi.Exists || fi.Length < 10_000) // adjust threshold as you like
			throw new InvalidDataException($"Downloaded file too small: {fi.Length} bytes");

		if (!LooksLikeXlsxZip(path))
			throw new InvalidDataException("Downloaded file is not a valid XLSX (zip signature missing).");
	}

}
