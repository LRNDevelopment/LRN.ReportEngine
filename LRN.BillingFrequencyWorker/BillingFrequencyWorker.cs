using Microsoft.Extensions.Hosting;
using Microsoft.Extensions.Logging;
using Microsoft.Extensions.Options;
using Microsoft.Extensions.Configuration;
using System.Data;

public sealed class BillingFrequencyWorker : BackgroundService
{
	private readonly ILogger<BillingFrequencyWorker> _logger;
	private readonly ImportOptions _opt;
	private readonly string _connStr;

	public BillingFrequencyWorker(
		ILogger<BillingFrequencyWorker> logger,
		IOptions<ImportOptions> options,
		IConfiguration config)
	{
		_logger = logger;
		_opt = options.Value;
		_connStr = config.GetConnectionString("DefaultConnection")!;
	}

	protected override async Task ExecuteAsync(CancellationToken stoppingToken)
	{
		_logger.LogInformation("Billing Frequency Worker starting. Watch={Watch} Archive={Archive} Error={Error} Sheet={Sheet}",
			_opt.WatchFolder, _opt.ArchiveFolder, _opt.ErrorFolder, _opt.SheetName);

		while (!stoppingToken.IsCancellationRequested)
		{
			try
			{
				// If config missing, don't crash the service—log and retry.
				if (string.IsNullOrWhiteSpace(_opt.WatchFolder) ||
					string.IsNullOrWhiteSpace(_opt.ArchiveFolder) ||
					string.IsNullOrWhiteSpace(_opt.ErrorFolder))
				{
					_logger.LogError("BillingFrequency config folders are empty. Ensure appsettings.json is deployed and has BillingFrequency section.");
					await Task.Delay(TimeSpan.FromSeconds(30), stoppingToken);
					continue;
				}

				Directory.CreateDirectory(_opt.WatchFolder);
				Directory.CreateDirectory(_opt.ArchiveFolder);
				Directory.CreateDirectory(_opt.ErrorFolder);

				// --- your existing processing logic here ---
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

					// Read + merge all files for this lab into one unified list,
					// then delete once + bulk insert once.
					var allLineRows = new List<BillingLineRow>();

					foreach (var file in labFiles)
					{
						if (!IsFileReady(file))
							continue;

						_logger.LogInformation("Reading file {File}", file);

						var rows = BillingExcelReader.ReadLineLevelRows(
							file,
							sheetName: _opt.SheetName,
							headerRow: _opt.HeaderRow);

						allLineRows.AddRange(rows);
					}

					if (allLineRows.Count == 0)
						continue;

					// Build grouped counts table (adds LabId column)
					DataTable countsDt = BillingGrouper.BuildBillingCounts(allLineRows, labId);

					// Delete existing for lab + bulk insert new
					await BillingSqlLoader.ReplaceLabDataAsync(
						_connStr,
						_opt.DestinationTable,
						labId,
						countsDt,
						stoppingToken);

					// Archive all successfully processed files for this lab
					foreach (var file in labFiles)
						SafeMoveToArchive(file);
				}

				await Task.Delay(TimeSpan.FromSeconds(_opt.PollSeconds), stoppingToken);
			}
			catch (TaskCanceledException) { }
			catch (Exception ex)
			{
				_logger.LogError(ex, "Worker loop error");
				await Task.Delay(TimeSpan.FromSeconds(30), stoppingToken);
			}
		}
	}

	private int? ResolveLabId(string fileName)
	{
		foreach (var map in _opt.Labs)
		{
			if (WildcardMatch(fileName, map.FilePattern))
				return map.LabId;
		}
		return null;
	}

	private void SafeMoveToArchive(string file)
	{
		try
		{
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

	private static bool WildcardMatch(string input, string pattern)
	{
		// Simple wildcard match (* and ?)
		var regex = "^" + System.Text.RegularExpressions.Regex.Escape(pattern)
			.Replace("\\*", ".*")
			.Replace("\\?", ".") + "$";
		return System.Text.RegularExpressions.Regex.IsMatch(input, regex, System.Text.RegularExpressions.RegexOptions.IgnoreCase);
	}

	private static bool IsFileReady(string path)
	{
		// avoid half-copied files
		try
		{
			using var stream = new FileStream(path, FileMode.Open, FileAccess.Read, FileShare.None);
			return stream.Length > 0;
		}
		catch { return false; }
	}
}
