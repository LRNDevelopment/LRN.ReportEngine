using Microsoft.Extensions.Configuration;
using Microsoft.Extensions.Logging;
using Microsoft.Extensions.Options;

internal sealed class UploadJobOptions
{
	// If empty, defaults to <BillingFrequency.ReportOutputsRoot>\Output
	public string? LocalOutputRoot { get; set; }

	// If empty, defaults to <BillingFrequency.ReportOutputsRoot>\Logs\Master File Processor
	public string? LocalMasterLogFolder { get; set; }

	// Upload only files under the most recent N day-folders (based on folder name), if you want to limit scope.
	public int MaxDayFoldersToUpload { get; set; } = 0; // 0 = upload all discovered
}

internal static class Program
{
	public static async Task<int> Main(string[] args)
	{
		// NOTE:
		// Your build error happens because AddEnvironmentVariables() is an extension method from the
		// Microsoft.Extensions.Configuration.EnvironmentVariables package. Since you asked to fix only this file,
		// we remove that call so it compiles without adding packages.
		//
		// If you still want env var overrides later, add the NuGet package:
		//   Microsoft.Extensions.Configuration.EnvironmentVariables
		// and then you can re-add .AddEnvironmentVariables().

		var env = Environment.GetEnvironmentVariable("DOTNET_ENVIRONMENT")
				  ?? Environment.GetEnvironmentVariable("ASPNETCORE_ENVIRONMENT");

		var config = new ConfigurationBuilder()
			.SetBasePath(AppContext.BaseDirectory)
			.AddJsonFile("appsettings.json", optional: true, reloadOnChange: false)
			.AddJsonFile($"appsettings.{env}.json", optional: true)
			// .AddEnvironmentVariables() // removed to avoid CS1061 without the NuGet package
			//.AddCommandLine(args)
			.Build();

		using var loggerFactory = LoggerFactory.Create(b =>
		{
			b.AddSimpleConsole(o =>
			{
				o.SingleLine = true;
				o.TimestampFormat = "HH:mm:ss ";
			});
			b.SetMinimumLevel(LogLevel.Information);
		});

		var log = loggerFactory.CreateLogger("Uploader");

		var import = config.GetSection("BillingFrequency").Get<ImportOptions>() ?? new ImportOptions();
		var job = config.GetSection("UploadJob").Get<UploadJobOptions>() ?? new UploadJobOptions();

		var localOutputRoot = !string.IsNullOrWhiteSpace(job.LocalOutputRoot)
			? job.LocalOutputRoot!
			: Path.Combine(import.ReportOutputsRoot, "Output");

		var localMasterLogFolder = !string.IsNullOrWhiteSpace(job.LocalMasterLogFolder)
			? job.LocalMasterLogFolder!
			: Path.Combine(import.ReportOutputsRoot, "Logs", "Master File Processor");

		log.LogInformation("LocalOutputRoot: {Path}", localOutputRoot);
		log.LogInformation("LocalMasterLogFolder: {Path}", localMasterLogFolder);

		if (!import.SharePoint.Enabled)
		{
			log.LogWarning("SharePoint is disabled in config (BillingFrequency:SharePoint:Enabled=false). Nothing to do.");
			return 0;
		}

		using var http = new HttpClient();
		var sp = new SharePointDownloader(http, Options.Create(import), loggerFactory.CreateLogger<SharePointDownloader>());

		// Ensure drive
		var driveId = await sp.TryGetDriveIdAsync(CancellationToken.None);
		if (string.IsNullOrWhiteSpace(driveId))
		{
			log.LogError("Failed to resolve SharePoint drive. Check SharePoint config/credentials.");
			return 2;
		}

		// Upload outputs
		if (import.SharePoint.UploadOutputs && !string.IsNullOrWhiteSpace(import.SharePoint.OutputUploadFolderPath))
		{
			var count = await UploadCsvTreeAsync(
				log,
				sp,
				driveId!,
				localOutputRoot,
				import.SharePoint.OutputUploadFolderPath!,
				job.MaxDayFoldersToUpload,
				CancellationToken.None);

			log.LogInformation("Uploaded {Count} output CSV file(s).", count);
		}

		// Upload master processor logs
		if (import.SharePoint.UploadMasterProcessorLog && !string.IsNullOrWhiteSpace(import.SharePoint.MasterProcessorLogUploadFolderPath))
		{
			var count = await UploadMasterLogsAsync(
				log,
				sp,
				driveId!,
				localMasterLogFolder,
				import.SharePoint.MasterProcessorLogUploadFolderPath!,
				CancellationToken.None);

			log.LogInformation("Uploaded {Count} master log file(s).", count);
		}

		return 0;
	}

	private static async Task<int> UploadCsvTreeAsync(
		ILogger log,
		SharePointDownloader sp,
		string driveId,
		string localOutputRoot,
		string spOutputRoot,
		int maxDayFoldersToUpload,
		CancellationToken ct)
	{
		if (!Directory.Exists(localOutputRoot))
		{
			log.LogWarning("Local output root does not exist: {Path}", localOutputRoot);
			return 0;
		}

		// Expected local path structure:
		//   <localOutputRoot>\YYYY\MM.MMM\MM.dd.yyyy\<Lab>_ClaimLevel.csv
		//   <localOutputRoot>\YYYY\MM.MMM\MM.dd.yyyy\<Lab>_LineLevel.csv
		// We'll upload preserving YYYY/MM.MMM/MM.dd.yyyy.

		var files = Directory.EnumerateFiles(localOutputRoot, "*.csv", SearchOption.AllDirectories)
			.Where(p => p.EndsWith("_ClaimLevel.csv", StringComparison.OrdinalIgnoreCase)
					 || p.EndsWith("_LineLevel.csv", StringComparison.OrdinalIgnoreCase))
			.ToList();

		// Optionally limit to the most recent day-folders
		if (maxDayFoldersToUpload > 0)
		{
			files = files
				.GroupBy(f => Path.GetDirectoryName(f) ?? "")
				.OrderByDescending(g => g.Key, StringComparer.OrdinalIgnoreCase)
				.Take(maxDayFoldersToUpload)
				.SelectMany(g => g)
				.ToList();
		}

		int uploaded = 0;
		foreach (var file in files)
		{
			var rel = Path.GetRelativePath(localOutputRoot, file);
			var parts = rel.Split(Path.DirectorySeparatorChar, Path.AltDirectorySeparatorChar)
						   .Where(x => !string.IsNullOrWhiteSpace(x))
						   .ToArray();

			if (parts.Length < 4)
			{
				log.LogWarning("Skipping (unexpected path structure): {Rel}", rel);
				continue;
			}

			var year = parts[0];
			var month = parts[1];
			var day = parts[2];
			var fileName = parts[^1];

			var destFolder = CombineSpPath(spOutputRoot, year, month, day);

			try
			{
				await sp.UploadFileToFolderPathAsync(driveId, destFolder, file, fileName, ct);
				uploaded++;
				log.LogInformation("Uploaded {File} -> {Folder}", fileName, destFolder);
			}
			catch (Exception ex)
			{
				log.LogError(ex, "Failed uploading {File} -> {Folder}", fileName, destFolder);
			}
		}

		return uploaded;
	}

	private static async Task<int> UploadMasterLogsAsync(
		ILogger log,
		SharePointDownloader sp,
		string driveId,
		string localMasterLogFolder,
		string spLogFolder,
		CancellationToken ct)
	{
		if (!Directory.Exists(localMasterLogFolder))
		{
			log.LogWarning("Local master log folder does not exist: {Path}", localMasterLogFolder);
			return 0;
		}

		var files = Directory.EnumerateFiles(localMasterLogFolder, "Master_File_Processor_Log_*.csv", SearchOption.TopDirectoryOnly)
			.OrderBy(f => f, StringComparer.OrdinalIgnoreCase)
			.ToList();

		int uploaded = 0;
		foreach (var file in files)
		{
			var fileName = Path.GetFileName(file);
			try
			{
				await sp.UploadFileToFolderPathAsync(driveId, spLogFolder, file, fileName, ct);
				uploaded++;
				log.LogInformation("Uploaded log {FileName} -> {Folder}", fileName, spLogFolder);
			}
			catch (Exception ex)
			{
				log.LogError(ex, "Failed uploading log {FileName} -> {Folder}", fileName, spLogFolder);
			}
		}

		return uploaded;
	}

	private static string CombineSpPath(params string[] parts)
	{
		var clean = parts
			.Where(p => !string.IsNullOrWhiteSpace(p))
			.Select(p => p.Trim().Trim('/').Trim('\\'))
			.Where(p => p.Length > 0);
		return string.Join("/", clean);
	}
}
