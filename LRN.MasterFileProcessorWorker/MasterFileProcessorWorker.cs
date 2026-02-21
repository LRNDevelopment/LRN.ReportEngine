using Common.Logging;
using LRN.ExcelValidator.Services;
using LRN.ExcelValidator.Models;
using Microsoft.Extensions.Hosting;
using Microsoft.Extensions.Logging;
using Microsoft.Extensions.Options;
using System.Collections.Generic;
using System.Diagnostics;
using System.Globalization;
using System.IO;
using System.Linq;
using System.Text.RegularExpressions;

public sealed class MasterFileProcessorWorker : BackgroundService
{
	private readonly ILogger<MasterFileProcessorWorker> _logger;   // console/eventlog
	private readonly ILoggerService _fileLog;                      // log4net file (only what we write)
	private readonly ImportOptions _opt;
	private readonly SharePointDownloader _sp;
	private readonly MasterFileProcessorFileStatusStore _status;
	private readonly IExcelSchemaValidator _schemaValidator;
	private readonly IColumnSchemaLoader _schemaLoader;

	private ColumnSchema? _commonLineSchema;
	private ColumnSchema? _commonClaimSchema;

	private Dictionary<string, StandardCsvExporter.InsuranceMasterEntry>? _insuranceMaster;

	public MasterFileProcessorWorker(
		ILogger<MasterFileProcessorWorker> logger,
		ILoggerService fileLog,
		IOptions<ImportOptions> options,
		SharePointDownloader sp,
		MasterFileProcessorFileStatusStore status,
		IExcelSchemaValidator schemaValidator,
		IColumnSchemaLoader schemaLoader)
	{
		_logger = logger;
		_fileLog = fileLog;
		_opt = options.Value;
		_sp = sp;
		_status = status;
		_schemaValidator = schemaValidator;
		_schemaLoader = schemaLoader;
	}

	protected override async Task ExecuteAsync(CancellationToken stoppingToken)
	{
		EnsureFolders();

		_logger.LogInformation("Worker started. SharePoint.Enabled={Enabled}", _opt.SharePoint.Enabled);
		_fileLog.Info($"Worker started. SharePoint.Enabled={_opt.SharePoint.Enabled}");

		while (!stoppingToken.IsCancellationRequested)
		{
			try
			{
				if (_opt.SharePoint.Enabled)
				{
					await ProcessSharePointOnceAsync(stoppingToken);
				}
				else
				{
					_logger.LogWarning("SharePoint is disabled. Nothing to do.");
					_fileLog.Warn("SharePoint is disabled. Nothing to do.");
				}
			}
			catch (OperationCanceledException) when (stoppingToken.IsCancellationRequested)
			{
				// graceful shutdown
			}
			catch (Exception ex)
			{
				_logger.LogError(ex, "Top-level worker loop error.");
				_fileLog.Error("Top-level worker loop error.", ex);
			}

			try
			{
				await Task.Delay(TimeSpan.FromMinutes(Math.Max(10, _opt.PollSeconds)), stoppingToken);
			}
			catch (OperationCanceledException) { }
		}
	}

	private void EnsureFolders()
	{
		if (string.IsNullOrWhiteSpace(_opt.WatchFolder))
			_opt.WatchFolder = Path.Combine(AppContext.BaseDirectory, "LRN-Input");

		if (string.IsNullOrWhiteSpace(_opt.ErrorFolder))
			_opt.ErrorFolder = Path.Combine(AppContext.BaseDirectory, "error");

		if (string.IsNullOrWhiteSpace(_opt.ReportOutputsRoot))
			_opt.ReportOutputsRoot = Path.Combine(AppContext.BaseDirectory, "LabReportOutputs");

		Directory.CreateDirectory(_opt.WatchFolder);
		Directory.CreateDirectory(_opt.ErrorFolder);
		Directory.CreateDirectory(_opt.ReportOutputsRoot);
		Directory.CreateDirectory(Path.Combine(AppContext.BaseDirectory, "logs"));
	}

	private async Task ProcessSharePointOnceAsync(CancellationToken ct)
	{
		var runLocalNow = DateTime.Now;

		// Daily master processor log (local)
		var masterLogFolder = Path.Combine(_opt.ReportOutputsRoot, "Logs", "Master File Processor");

		// Load COMMON schemas once (used for standardized CSV output)
		_commonLineSchema ??= _schemaLoader.LoadFromFile(ResolvePath(_opt.CommonLineLevelSchemaJsonPath));
		_commonClaimSchema ??= _schemaLoader.LoadFromFile(ResolvePath(_opt.CommonClaimLevelSchemaJsonPath));

		// Load Insurance Master once (required for Global_Payer_ID and normalized PayerName)
		if (_insuranceMaster == null)
		{
			var insPath = ResolvePath(_opt.InsuranceMasterCsvPath);
			if (!string.IsNullOrWhiteSpace(insPath))
			{
				_insuranceMaster = StandardCsvExporter.LoadInsuranceMaster(insPath);
				_logger.LogInformation("Loaded Insurance Master: {Count} payer rows from {Path}", _insuranceMaster.Count, insPath);
				_fileLog.Info($"Loaded Insurance Master: {_insuranceMaster.Count} payer rows from {insPath}");
			}
			else
			{
				_logger.LogWarning("InsuranceMasterCsvPath not configured. Global_Payer_ID and PayerName normalization will be blank.");
				_fileLog.Warn("InsuranceMasterCsvPath not configured. Global_Payer_ID and PayerName normalization will be blank.");
				_insuranceMaster = new Dictionary<string, StandardCsvExporter.InsuranceMasterEntry>(StringComparer.OrdinalIgnoreCase);
			}
		}

		// Resolve driveId once (needed for status log upload even when selected is null)
		string? siteDriveId = null;
		try
		{
			siteDriveId = await _sp.TryGetDriveIdAsync(ct);
		}
		catch (Exception ex)
		{
			_fileLog.Error("Failed to resolve SharePoint driveId.", ex);
		}

		foreach (var lab in _opt.Labs)
		{
			ct.ThrowIfCancellationRequested();

			SharePointDownloader.SelectedFile? selected = null;

			try
			{
				// NOTE: your downloader already checks latest folder first and falls back to previous
				selected = await _sp.TryGetLatestFileForLabAsync(lab, runLocalNow.Year, ct);

				if (selected == null)
				{
					_logger.LogInformation("Lab {LabId}: no eligible SharePoint file found.", lab.LabId);
					_fileLog.Info($"Lab {lab.LabId}: no eligible SharePoint file found.");

					MasterProcessorLogCsv.Append(
						folder: masterLogFolder,
						localNow: runLocalNow,
						labId: lab.LabId,
						labName: lab.LabName,
						sourceFileName: "",
						sourceFileLocation: "",
						status: "Skipped",
						message: "no eligible SharePoint file found",
						claimOutput: "",
						lineOutput: "");

					// Also write status log locally + upload if enabled
					await TryWriteAndUploadFileStatusLogAsync(lab, selected, siteDriveId, status: "Skipped", outputLocation: "", logMessage: "no eligible SharePoint file found", ct: ct);
					continue;
				}

				// Skip if already processed
				if (await _status.IsProcessedAsync(selected.LabId, selected.DriveId, selected.ItemId, selected.ETagKey, ct))
				{
					_logger.LogInformation("Lab {LabId}: already processed, skipping: {File}", lab.LabId, selected.Name);
					_fileLog.Info($"Lab {lab.LabId}: already processed, skipping: {selected.Name}");

					MasterProcessorLogCsv.Append(
						folder: masterLogFolder,
						localNow: runLocalNow,
						labId: lab.LabId,
						labName: lab.LabName,
						sourceFileName: selected.Name,
						sourceFileLocation: selected.SharePointPath,
						status: "Skipped",
						message: "already processed (etag unchanged)",
						claimOutput: "",
						lineOutput: "");

					await TryWriteAndUploadFileStatusLogAsync(lab, selected, siteDriveId, status: "Skipped", outputLocation: "", logMessage: "already processed (etag unchanged)", ct: ct);
					continue;
				}

				await _status.UpsertStatusAsync(
					selected.LabId, selected.DriveId, selected.ItemId, selected.ETagKey,
					selected.Name, selected.SharePointPath, selected.LastModifiedUtc,
					status: "IN_PROGRESS",
					statusMessage: "Downloading from SharePoint",
					processedAtUtc: null,
					ct: ct);

				// --------------------------------------------------------------------
				// NEW PATH LOGIC (matches SharePoint input structure)
				// SharePoint input example:
				// Data Analysis/Beech Tree/2026/02.February/02.06.2026 - 02.12.2026/Beech Tree_Production Report.xlsx
				// We extract:
				//   monthFolder = "02.February"
				//   weekFolder  = "02.06.2026 - 02.12.2026"
				// --------------------------------------------------------------------
				var (monthFolder, weekFolder) = ParseMonthAndDateFolder(selected.SharePointPath);

				// Lab prefix (Beech_Tree style) used for local folder + file names
				var labPrefix = GetLabOutputPrefix(lab); // e.g. Beech_Tree

				// PROCESSED OUTPUTS (Claim/Line) go under WatchFolder (LRN-Input):
				// D:\LRN\Automation\LRN-Input\Beech_Tree\02.February\02.06.2026 - 02.12.2026\Beech_Tree_LineLevel.csv
				var processedOutFolder = Path.Combine(_opt.WatchFolder, labPrefix, monthFolder, weekFolder);
				Directory.CreateDirectory(processedOutFolder);

				var claimOutPath = Path.Combine(processedOutFolder, $"{labPrefix}_ClaimLevel.csv");
				var lineOutPath = Path.Combine(processedOutFolder, $"{labPrefix}_LineLevel.csv");

				// RAW ROOT (no lab folder):
				// D:\LRN\Automation\LRN-RAWFILE\02.February\02.06.2026 - 02.12.2026\
				var rawRoot = Path.Combine(_opt.ReportOutputsRoot, "LRN-RAWFILE", monthFolder, weekFolder);
				Directory.CreateDirectory(rawRoot);

				// Download XLSX into RAW ROOT
				var stagingFileName = $"{labPrefix}_{SanitizeFileName(selected.Name)}";
				var stagingPath = Path.Combine(rawRoot, stagingFileName);

				_logger.LogInformation("Lab {LabId}: downloading {SpPath} -> {Local}", lab.LabId, selected.SharePointPath, stagingPath);
				_fileLog.Info($"Lab {lab.LabId}: downloading {selected.SharePointPath} -> {stagingPath}");

				await _sp.DownloadFileAsync(selected.DriveId, selected.ItemId, stagingPath, ct);

				// Validate download looks like XLSX
				XlsxFileValidator.ValidateDownloadedXlsxOrThrow(stagingPath);

				// -------- Column validation --------
				var lineSchemaPath = ResolvePath(!string.IsNullOrWhiteSpace(lab.LineLevelSchemaJsonPath)
					? lab.LineLevelSchemaJsonPath!
					: _opt.LineLevelSchemaJsonPath);

				var claimSchemaPath = ResolvePath(!string.IsNullOrWhiteSpace(lab.ClaimLevelSchemaJsonPath)
					? lab.ClaimLevelSchemaJsonPath!
					: _opt.ClaimLevelSchemaJsonPath);

				var lineValidation = _schemaValidator.Validate(stagingPath, _opt.SheetName, lineSchemaPath);
				var claimValidation = _schemaValidator.Validate(stagingPath, _opt.ClaimSheetName, claimSchemaPath);

				if (!lineValidation.IsValid || !claimValidation.IsValid)
				{
					var msg = BuildSchemaErrorMessage(lineValidation, claimValidation, _opt.SheetName, _opt.ClaimSheetName);

					_logger.LogError("Lab {LabId}: schema validation failed for file {File}. {Msg}", lab.LabId, selected.Name, msg);
					_fileLog.Error($"Lab {lab.LabId}: schema validation failed for {selected.Name}. {msg}");

					await _status.UpsertStatusAsync(
						selected.LabId, selected.DriveId, selected.ItemId, selected.ETagKey,
						selected.Name, selected.SharePointPath, selected.LastModifiedUtc,
						status: "ERROR",
						statusMessage: msg,
						processedAtUtc: null,
						ct: ct,
						errorLogInfo: msg);

					await TryWriteAndUploadFileStatusLogAsync(lab, selected, siteDriveId, status: "Failed", outputLocation: _opt.ErrorFolder, logMessage: msg, ct: ct);

					MoveToErrorFolder(stagingPath, msg);
					continue;
				}

				// Load LAB schemas for preferred header mapping / composite expressions during standardization
				var labLineSchema = _schemaLoader.LoadFromFile(lineSchemaPath);
				var labClaimSchema = _schemaLoader.LoadFromFile(claimSchemaPath);

				// RAW intermediate exports (Excel -> CSV) stored under RAW ROOT (no lab folder)
				var baseName = SanitizeFileName(Path.GetFileNameWithoutExtension(selected.Name));
				var lineRawPath = Path.Combine(rawRoot, $"{labPrefix}_{baseName}_LineLevel_RAW.csv");
				var claimRawPath = Path.Combine(rawRoot, $"{labPrefix}_{baseName}_ClaimLevel_RAW.csv");

				await _status.UpsertStatusAsync(
					selected.LabId, selected.DriveId, selected.ItemId, selected.ETagKey,
					selected.Name, selected.SharePointPath, selected.LastModifiedUtc,
					status: "IN_PROGRESS",
					statusMessage: $"Exporting ClaimLevel + LineLevel to CSV. Output={processedOutFolder}",
					processedAtUtc: null,
					ct: ct);

				var sw = Stopwatch.StartNew();

				// LineLevel RAW export (from Excel)
				await ExcelCsvExporter.ExportSingleSheetToCsvAsync(stagingPath, _opt.SheetName, lineRawPath, ct);
				_logger.LogInformation("Lab {LabId}: LineLevel RAW CSV export done -> {Path}", lab.LabId, lineRawPath);
				_fileLog.Info($"Lab {lab.LabId}: LineLevel RAW CSV export -> {lineRawPath}");

				// Standardize LineLevel using COMMON schema -> processed output folder
				StandardCsvExporter.Generate(
					sourceCsvPath: lineRawPath,
					headerRow: _commonLineSchema!.HeaderRow,
					outputCsvPath: lineOutPath,
					commonSchema: _commonLineSchema!,
					labId: lab.LabId,
					labName: lab.LabName,
					sourceFileName: selected.Name,
					ingestedOnLocal: DateTime.Now,
					labSchema: labLineSchema,
					insuranceMaster: _insuranceMaster);

				_logger.LogInformation("Lab {LabId}: LineLevel STANDARD CSV generated -> {Path}", lab.LabId, lineOutPath);
				_fileLog.Info($"Lab {lab.LabId}: LineLevel STANDARD CSV -> {lineOutPath}");

				// ClaimLevel RAW export (from Excel)
				await ExcelCsvExporter.ExportSingleSheetToCsvAsync(stagingPath, _opt.ClaimSheetName, claimRawPath, ct);
				_logger.LogInformation("Lab {LabId}: ClaimLevel RAW CSV export done -> {Path}", lab.LabId, claimRawPath);
				_fileLog.Info($"Lab {lab.LabId}: ClaimLevel RAW CSV export -> {claimRawPath}");

				// Standardize ClaimLevel using COMMON schema -> processed output folder
				StandardCsvExporter.Generate(
					sourceCsvPath: claimRawPath,
					headerRow: _commonClaimSchema!.HeaderRow,
					outputCsvPath: claimOutPath,
					commonSchema: _commonClaimSchema!,
					labId: lab.LabId,
					labName: lab.LabName,
					sourceFileName: selected.Name,
					ingestedOnLocal: DateTime.Now,
					labSchema: labClaimSchema,
					insuranceMaster: _insuranceMaster);

				_logger.LogInformation("Lab {LabId}: ClaimLevel STANDARD CSV generated -> {Path}", lab.LabId, claimOutPath);
				_fileLog.Info($"Lab {lab.LabId}: ClaimLevel STANDARD CSV -> {claimOutPath}");

				sw.Stop();

				// Cleanup RAW CSVs unless configured to keep
				if (!_opt.KeepRawCsvExports)
				{
					TryDelete(lineRawPath);
					TryDelete(claimRawPath);
				}

				// Write + upload file status log (CSV)
				await TryWriteAndUploadFileStatusLogAsync(lab, selected, siteDriveId, status: "Completed", outputLocation: processedOutFolder, logMessage: "imported", ct: ct);

				// Upload standardized outputs to SharePoint output folder (client requirement)
				var outputUploadResult = await TryUploadOutputsAsync(lab, selected, runLocalNow, claimOutPath, lineOutPath, ct);

				// Mark PROCESSED
				await _status.UpsertStatusAsync(
					selected.LabId, selected.DriveId, selected.ItemId, selected.ETagKey,
					selected.Name, selected.SharePointPath, selected.LastModifiedUtc,
					status: "PROCESSED",
					statusMessage: $"Saved LineLevel='{lineOutPath}', ClaimLevel='{claimOutPath}'. OutputUpload={outputUploadResult}.",
					processedAtUtc: DateTimeOffset.UtcNow,
					ct: ct);

				// Daily master processor log row (client requirement)
				MasterProcessorLogCsv.Append(
					folder: masterLogFolder,
					localNow: runLocalNow,
					labId: lab.LabId,
					labName: lab.LabName,
					sourceFileName: selected.Name,
					sourceFileLocation: selected.SharePointPath,
					status: "Completed",
					message: $"imported; {outputUploadResult}",
					claimOutput: claimOutPath,
					lineOutput: lineOutPath);

				_fileLog.Info($"Lab {lab.LabId}: PROCESSED {selected.Name}.");

				// Archive RAW XLSX after success:
				// D:\LRN\Automation\LRN-RAWFILE\Archive\02.February\02.06.2026 - 02.12.2026\<file>.xlsx
				try
				{
					var archiveFolder = Path.Combine(_opt.ReportOutputsRoot, "LRN-RAWFILE", "Archive", monthFolder, weekFolder);
					Directory.CreateDirectory(archiveFolder);

					var dest = Path.Combine(archiveFolder, Path.GetFileName(stagingPath));

					if (File.Exists(stagingPath))
						File.Move(stagingPath, dest, overwrite: true);

					_fileLog.Info($"Archived raw XLSX: {dest}");
				}
				catch (Exception ex)
				{
					_fileLog.Error("Failed to archive raw XLSX.", ex);
				}

				// Optional SharePoint move (still supported by config)
				var processedFolderId = await _sp.TryResolveProcessedFolderIdAsync(ct);
				if (!string.IsNullOrWhiteSpace(processedFolderId))
				{
					await _sp.MoveItemAsync(selected.DriveId, selected.ItemId, processedFolderId!, ct);
					_fileLog.Info($"Lab {lab.LabId}: moved SharePoint file to processed folder.");
				}
			}
			catch (OperationCanceledException) when (ct.IsCancellationRequested)
			{
				throw;
			}
			catch (Exception ex)
			{
				_logger.LogError(ex, "Lab {LabId}: error processing SharePoint file.", lab.LabId);
				_fileLog.Error($"Lab {lab.LabId}: error processing SharePoint file.", ex);

				if (selected != null)
				{
					await _status.UpsertStatusAsync(
						selected.LabId, selected.DriveId, selected.ItemId, selected.ETagKey,
						selected.Name, selected.SharePointPath, selected.LastModifiedUtc,
						status: "ERROR",
						statusMessage: ex.Message,
						processedAtUtc: null,
						ct: ct,
						errorLogInfo: ex.ToString());
				}

				await TryWriteAndUploadFileStatusLogAsync(lab, selected, siteDriveId, status: "Failed", outputLocation: _opt.ErrorFolder, logMessage: ex.Message, ct: ct);

				MasterProcessorLogCsv.Append(
					folder: masterLogFolder,
					localNow: runLocalNow,
					labId: lab.LabId,
					labName: lab.LabName,
					sourceFileName: selected?.Name ?? "",
					sourceFileLocation: selected?.SharePointPath ?? "",
					status: "Failed",
					message: ex.Message,
					claimOutput: "",
					lineOutput: "");
			}
		}

		// Upload the daily master processor log once per run (client requirement)
		await TryUploadMasterProcessorLogAsync(runLocalNow, masterLogFolder, ct);
	}

	private static string BuildSchemaErrorMessage(
		LRN.ExcelValidator.Models.SchemaValidationResult lineValidation,
		LRN.ExcelValidator.Models.SchemaValidationResult claimValidation,
		string lineCandidates,
		string claimCandidates)
	{
		var parts = new List<string>();

		if (lineValidation.SheetUsed == null)
			parts.Add($"LineLevel sheet not found. Candidates: {lineCandidates}");
		else if (lineValidation.MissingRequiredColumns.Count > 0)
			parts.Add($"LineLevel missing columns: {string.Join(", ", lineValidation.MissingRequiredColumns)} (sheet='{lineValidation.SheetUsed}')");

		if (claimValidation.SheetUsed == null)
			parts.Add($"ClaimLevel sheet not found. Candidates: {claimCandidates}");
		else if (claimValidation.MissingRequiredColumns.Count > 0)
			parts.Add($"ClaimLevel missing columns: {string.Join(", ", claimValidation.MissingRequiredColumns)} (sheet='{claimValidation.SheetUsed}')");

		return string.Join(" | ", parts);
	}

	private void MoveToErrorFolder(string stagingPath, string msg)
	{
		try
		{
			Directory.CreateDirectory(_opt.ErrorFolder);

			var name = Path.GetFileNameWithoutExtension(stagingPath);
			var ext = Path.GetExtension(stagingPath);
			var ts = DateTime.Now.ToString("yyyyMMdd_HHmmss", CultureInfo.InvariantCulture);

			var destXlsx = Path.Combine(_opt.ErrorFolder, $"{name}_{ts}{ext}");
			if (File.Exists(destXlsx)) File.Delete(destXlsx);
			File.Move(stagingPath, destXlsx);

			var destTxt = Path.Combine(_opt.ErrorFolder, $"{name}_{ts}.error.txt");
			File.WriteAllText(destTxt, msg);

			_fileLog.Warn($"Moved file to error folder: {destXlsx}");
		}
		catch (Exception ex)
		{
			_fileLog.Error("Failed to move file to error folder.", ex);
		}
	}

	private async Task TryWriteAndUploadFileStatusLogAsync(
		LabFileMap lab,
		SharePointDownloader.SelectedFile? selected,
		string? siteDriveId,
		string status,
		string outputLocation,
		string logMessage,
		CancellationToken ct)
	{
		try
		{
			var localFolder = string.IsNullOrWhiteSpace(_opt.FileStatusLogLocalFolder)
				? Path.Combine(_opt.ReportOutputsRoot, "FileStatusLogs")
				: _opt.FileStatusLogLocalFolder;

			localFolder = ResolvePath(localFolder);

			var importedLocal = DateTime.Now;
			var fileName = selected?.Name ?? "";

			var localLogPath = FileStatusLogCsv.Write(
				folder: localFolder,
				labId: lab.LabId,
				labName: lab.LabName,
				importedLocal: importedLocal,
				fileName: fileName,
				status: status,
				outputLocation: outputLocation,
				logMessage: logMessage);

			_fileLog.Info($"Lab {lab.LabId}: file status log written: {localLogPath}");

			// FIX: Upload even if selected == null; use site driveId (resolved once)
			if (_opt.SharePoint.Enabled && !string.IsNullOrWhiteSpace(_opt.SharePoint.FileStatusLogUploadFolderPath))
			{
				var driveId = siteDriveId;
				if (string.IsNullOrWhiteSpace(driveId))
				{
					driveId = await _sp.TryGetDriveIdAsync(ct);
				}

				if (string.IsNullOrWhiteSpace(driveId))
				{
					_fileLog.Warn("File status log upload skipped: unable to resolve SharePoint driveId.");
					return;
				}

				var spFolder = _opt.SharePoint.FileStatusLogUploadFolderPath.Trim().Trim('/');

				// If configured as ImportLogs root, expand to year/month folder path
				if (spFolder.EndsWith("ImportLogs", StringComparison.OrdinalIgnoreCase))
				{
					spFolder = FileStatusLogCsv.GetSharePointFolderPath(importedLocal);
				}

				await _sp.UploadFileToFolderPathAsync(
					driveId: driveId!,
					folderPath: spFolder,
					localFilePath: localLogPath,
					uploadFileName: Path.GetFileName(localLogPath),
					ct: ct);

				_fileLog.Info($"Lab {lab.LabId}: file status log uploaded to SharePoint folder '{spFolder}'.");
			}
		}
		catch (Exception ex)
		{
			_fileLog.Error("Failed to write/upload file status log.", ex);
		}
	}

	private async Task<string> TryUploadOutputsAsync(
		LabFileMap lab,
		SharePointDownloader.SelectedFile selected,
		DateTime runLocalNow,
		string claimOutPath,
		string lineOutPath,
		CancellationToken ct)
	{
		try
		{
			var sp = _opt.SharePoint;
			if (!sp.Enabled || !sp.UploadOutputs)
				return "SKIPPED";

			if (string.IsNullOrWhiteSpace(sp.OutputUploadFolderPath))
				return "SKIPPED (OutputUploadFolderPath empty)";

			// Prefer year from SharePoint path; fallback to run year
			var year = TryParseYearFromSharePointPath(selected.SharePointPath)
				?? runLocalNow.ToString("yyyy", CultureInfo.InvariantCulture);

			// Parse from SharePoint FULL path:
			// Data Analysis/Beech Tree/2026/02.February/02.06.2026 - 02.12.2026/<file>.xlsx
			var (monthFolder, weekFolder) = ParseMonthAndDateFolder(selected.SharePointPath);

			// Use extracted weekFolder as requested
			var destFolder = CombineSpPath(sp.OutputUploadFolderPath, lab.LabName, year, monthFolder, weekFolder);

			await _sp.UploadFileToFolderPathAsync(
				driveId: selected.DriveId,
				folderPath: destFolder,
				localFilePath: claimOutPath,
				uploadFileName: Path.GetFileName(claimOutPath),
				ct: ct);

			await _sp.UploadFileToFolderPathAsync(
				driveId: selected.DriveId,
				folderPath: destFolder,
				localFilePath: lineOutPath,
				uploadFileName: Path.GetFileName(lineOutPath),
				ct: ct);

			_fileLog.Info($"Lab {lab.LabId}: output files uploaded to SharePoint folder '{destFolder}'.");
			return $"UPLOADED -> {destFolder}";
		}
		catch (Exception ex)
		{
			_fileLog.Error($"Lab {lab.LabId}: failed to upload output files to SharePoint.", ex);
			return "UPLOAD_FAILED";
		}
	}

	private async Task TryUploadMasterProcessorLogAsync(DateTime runLocalNow, string masterLogFolder, CancellationToken ct)
	{
		try
		{
			var sp = _opt.SharePoint;
			if (!sp.Enabled || !sp.UploadMasterProcessorLog)
				return;

			if (string.IsNullOrWhiteSpace(sp.MasterProcessorLogUploadFolderPath))
				return;

			var logFileName = MasterProcessorLogCsv.GetDailyFileName(runLocalNow);
			var localPath = Path.Combine(masterLogFolder, logFileName);

			if (!File.Exists(localPath))
				return;

			var driveId = await _sp.TryGetDriveIdAsync(ct);
			if (string.IsNullOrWhiteSpace(driveId))
				return;

			await _sp.UploadFileToFolderPathAsync(
				driveId: driveId!,
				folderPath: sp.MasterProcessorLogUploadFolderPath,
				localFilePath: localPath,
				uploadFileName: logFileName,
				ct: ct);

			_fileLog.Info($"Master processor log uploaded to SharePoint folder '{sp.MasterProcessorLogUploadFolderPath}' as '{logFileName}'.");
		}
		catch (Exception ex)
		{
			_fileLog.Error("Failed to upload master processor log to SharePoint.", ex);
		}
	}

	private static string CombineSpPath(params string[] parts)
	{
		var clean = parts
			.Where(p => !string.IsNullOrWhiteSpace(p))
			.Select(p => p.Trim().Trim('/').Trim('\\'))
			.Where(p => p.Length > 0);
		return string.Join("/", clean);
	}

	private static (string MonthFolder, string DateFolder) ParseMonthAndDateFolder(string sharePointPath)
	{
		// Expected: .../<Year>/<Month>/<DateRange>/<File>
		var parts = sharePointPath.Split('/', StringSplitOptions.RemoveEmptyEntries | StringSplitOptions.TrimEntries);

		// Try to locate a 4-digit year segment
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

		// Fallback: assume last segments
		if (parts.Length >= 3)
			return (parts[^3], parts[^2]);

		return ("UnknownMonth", "UnknownDate");
	}

	private static string? TryParseYearFromSharePointPath(string sharePointPath)
	{
		var parts = sharePointPath.Split('/', StringSplitOptions.RemoveEmptyEntries | StringSplitOptions.TrimEntries);
		foreach (var p in parts)
		{
			if (Regex.IsMatch(p, @"^\d{4}$"))
				return p;
		}
		return null;
	}

	private static string GetLabFolderName(LabFileMap lab)
	{
		if (!string.IsNullOrWhiteSpace(lab.LabName))
			return SanitizePathSegment(lab.LabName);

		return SanitizePathSegment(lab.LabId.ToString(CultureInfo.InvariantCulture));
	}

	private static string GetLabOutputPrefix(LabFileMap lab)
	{
		// Required file name style: Beech_Tree_ClaimLevel.csv / Beech_Tree_LineLevel.csv
		var name = !string.IsNullOrWhiteSpace(lab.LabName)
			? lab.LabName.Trim()
			: lab.LabId.ToString(CultureInfo.InvariantCulture);

		name = name.Replace(' ', '_');
		return SanitizeFileName(name);
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

	private static string ResolvePath(string path)
	{
		if (string.IsNullOrWhiteSpace(path)) return path;
		if (Path.IsPathRooted(path)) return path;

		var normalized = path.Replace('/', Path.DirectorySeparatorChar).Replace('\\', Path.DirectorySeparatorChar);
		return Path.Combine(AppContext.BaseDirectory, normalized);
	}
}