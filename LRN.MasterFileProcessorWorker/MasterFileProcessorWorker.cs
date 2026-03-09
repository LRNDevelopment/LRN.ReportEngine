using Common.Logging;
using LRN.ExcelValidator.Services;
using LRN.ExcelValidator.Models;
using LRN.Notifications.Abstractions;
using LRN.Notifications.Models;
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
	private readonly IProcessLogService _processLog;
	private readonly ITeamsNotifier _teamsNotifier;

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
		IColumnSchemaLoader schemaLoader,
		IProcessLogService processLog,
		ITeamsNotifier teamsNotifier)
	{
		_logger = logger;
		_fileLog = fileLog;
		_opt = options.Value;
		_sp = sp;
		_status = status;
		_schemaValidator = schemaValidator;
		_schemaLoader = schemaLoader;
		_processLog = processLog;
		_teamsNotifier = teamsNotifier;
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
				await Task.Delay(TimeSpan.FromSeconds(Math.Max(10, _opt.PollSeconds)), stoppingToken);
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

			// One unique RunID per lab-run
			var runCtx = await _processLog.StartRunAsync(
				labName: lab.LabName,
				pipelineName: "LRN.MasterFileProcessor",
				triggerType: "Schedule",
				triggeredBy: Environment.UserName,
				ct: ct);

			var runRow = new RunLogRow
			{
				RunID = runCtx.RunId,
				LabName = lab.LabName,
				PipelineName = "LRN.MasterFileProcessor",
				TriggerType = "Schedule",
				TriggeredBy = Environment.UserName,
				StartTimeIST = runCtx.StartTimeIST,
				OverallStatus = "IN_PROGRESS",
				LatestMasterFileFound = "NO",
				MandatoryColumnCheck = "SKIPPED",
				SplitOutputWrittenToSharePoint = "SKIPPED",
				PayerPolicyValidationStatus = "PENDING",
				CodingValidationStatus = "PENDING",
				AveragesProcessStatus = "PENDING",
				OutputsCopiedToSharePoint = "PENDING",
				MasterSyncPerformed = "PENDING",
				TotalErrors = 0,
				TotalWarnings = 0
			};

			SharePointDownloader.SelectedFile? selected = null;
			int stepSeq = 0;
			StepLogRow? activeStep = null;

			try
			{
				// STEP 10: Find latest eligible SharePoint file
				stepSeq = 10;
				var step10 = new StepLogRow
				{
					StepSeq = stepSeq,
					StepName = "Find Latest Master File",
					StepCategory = "Ingestion",
					SourceSystem = "SharePoint",
					StartTimeIST = _processLog.NowIST(),
					Status = "IN_PROGRESS"
				};
				activeStep = step10;
				await _processLog.StepStartAsync(runCtx, step10, ct);

				// NOTE: downloader checks latest folder first and falls back to previous
				selected = await _sp.TryGetLatestFileForLabAsync(lab, runLocalNow.Year, ct);

				step10.EndTimeIST = _processLog.NowIST();
				step10.Status = selected == null ? "SKIPPED" : "SUCCESS";
				step10.PathOut = selected?.SharePointPath;
				step10.FileNameOut = selected?.Name;
				step10.ErrorMessage = selected == null ? "no eligible SharePoint file found" : null;
				await _processLog.StepEndAsync(runCtx, step10, ct);
				activeStep = null;

				if (selected == null)
				{
					_logger.LogInformation("Lab {LabId}: no eligible SharePoint file found.", lab.LabId);
					_fileLog.Info($"Lab {lab.LabId}: no eligible SharePoint file found.");

					runRow.OverallStatus = "SKIPPED";
					runRow.LatestMasterFileFound = "NO";
					runRow.Notes = "no eligible SharePoint file found";
					await _processLog.CompleteRunAsync(runCtx, runRow, ct);

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
					await NotifyNoLatestFileFoundAsync(lab, ct);
					continue;
				}

				runRow.LatestMasterFileFound = "YES";
				runRow.InputMasterSharePointPath = selected.SharePointPath;
				runRow.InputMasterFileName = selected.Name;
				runRow.InputMasterFileModifiedTime = selected.LastModifiedUtc?.ToLocalTime().DateTime;

				// STEP 15: Check already processed
				stepSeq = 15;
				var step15 = new StepLogRow
				{
					StepSeq = stepSeq,
					StepName = "Check Already Processed",
					StepCategory = "Validation",
					SourceSystem = "SQL",
					StartTimeIST = _processLog.NowIST(),
					Status = "IN_PROGRESS",
					FileNameIn = selected.Name,
					PathIn = selected.SharePointPath
				};
				activeStep = step15;
				await _processLog.StepStartAsync(runCtx, step15, ct);

				var alreadyProcessed = await _status.IsProcessedAsync(selected.LabId, selected.DriveId, selected.ItemId, selected.ETagKey, ct);
				step15.EndTimeIST = _processLog.NowIST();
				step15.Status = alreadyProcessed ? "SKIPPED" : "SUCCESS";
				step15.ErrorMessage = alreadyProcessed ? "already processed (etag unchanged)" : null;
				await _processLog.StepEndAsync(runCtx, step15, ct);
				activeStep = null;

				if (alreadyProcessed)
				{
					_logger.LogInformation("Lab {LabId}: already processed, skipping: {File}", lab.LabId, selected.Name);
					_fileLog.Info($"Lab {lab.LabId}: already processed, skipping: {selected.Name}");

					runRow.OverallStatus = "SKIPPED";
					runRow.LatestMasterFileFound = "YES";
					runRow.Notes = "already processed (etag unchanged)";
					await _processLog.CompleteRunAsync(runCtx, runRow, ct);

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

				// STEP 20: Download XLSX
				stepSeq = 20;
				var step20 = new StepLogRow
				{
					StepSeq = stepSeq,
					StepName = "Download Master File",
					StepCategory = "Ingestion",
					SourceSystem = "SharePoint",
					StartTimeIST = _processLog.NowIST(),
					Status = "IN_PROGRESS",
					FileNameIn = selected.Name,
					PathIn = selected.SharePointPath
				};
				activeStep = step20;
				await _processLog.StepStartAsync(runCtx, step20, ct);

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

				var sourceDateLabel = NormalizeWeekFolderForFileName(weekFolder);
				var claimOutFileName = BuildProcessedOutputFileName(runCtx.RunId, lab.LabName, "Claim Level", sourceDateLabel);
				var lineOutFileName = BuildProcessedOutputFileName(runCtx.RunId, lab.LabName, "Line Level", sourceDateLabel);

				var claimOutPath = Path.Combine(processedOutFolder, claimOutFileName);
				var lineOutPath = Path.Combine(processedOutFolder, lineOutFileName);
				var modeMedianOutFileName = BuildModeMedianOutputFileName(runCtx.RunId, runLocalNow);
				var modeMedianOutPath = Path.Combine(processedOutFolder, modeMedianOutFileName);

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

				// Update file size after download
				try
				{
					var fi = new FileInfo(stagingPath);
					runRow.InputMasterFileSizeMB = Math.Round((decimal)fi.Length / (1024m * 1024m), 2);
				}
				catch { }

				step20.EndTimeIST = _processLog.NowIST();
				step20.Status = "SUCCESS";
				step20.FileNameOut = Path.GetFileName(stagingPath);
				step20.PathOut = stagingPath;
				await _processLog.StepEndAsync(runCtx, step20, ct);
				activeStep = null;

				// STEP 30: Validate XLSX
				stepSeq = 30;
				var step30 = new StepLogRow
				{
					StepSeq = stepSeq,
					StepName = "Validate Downloaded XLSX",
					StepCategory = "Validation",
					SourceSystem = "Local",
					StartTimeIST = _processLog.NowIST(),
					Status = "IN_PROGRESS",
					FileNameIn = Path.GetFileName(stagingPath),
					PathIn = stagingPath
				};
				activeStep = step30;
				await _processLog.StepStartAsync(runCtx, step30, ct);
				XlsxFileValidator.ValidateDownloadedXlsxOrThrow(stagingPath);
				step30.EndTimeIST = _processLog.NowIST();
				step30.Status = "SUCCESS";
				await _processLog.StepEndAsync(runCtx, step30, ct);
				activeStep = null;

				// -------- Column validation --------
				var lineSchemaPath = ResolvePath(!string.IsNullOrWhiteSpace(lab.LineLevelSchemaJsonPath)
					? lab.LineLevelSchemaJsonPath!
					: _opt.LineLevelSchemaJsonPath);

				var claimSchemaPath = ResolvePath(!string.IsNullOrWhiteSpace(lab.ClaimLevelSchemaJsonPath)
					? lab.ClaimLevelSchemaJsonPath!
					: _opt.ClaimLevelSchemaJsonPath);

				// STEP 40: Schema validation
				stepSeq = 40;
				var step40 = new StepLogRow
				{
					StepSeq = stepSeq,
					StepName = "Validate Mandatory Columns",
					StepCategory = "Validation",
					SourceSystem = "Local",
					StartTimeIST = _processLog.NowIST(),
					Status = "IN_PROGRESS",
					FileNameIn = Path.GetFileName(stagingPath),
					PathIn = stagingPath
				};
				activeStep = step40;
				await _processLog.StepStartAsync(runCtx, step40, ct);

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

					step40.EndTimeIST = _processLog.NowIST();
					step40.Status = "FAILED";
					step40.ErrorCode = "SCHEMA_VALIDATION_FAILED";
					step40.ErrorMessage = msg;
					await _processLog.StepEndAsync(runCtx, step40, ct);
					activeStep = null;

					// Error_Log entry
					await _processLog.LogErrorAsync(runCtx, new ErrorLogRow
					{
						Severity = "ERROR",
						StepName = step40.StepName,
						ErrorCode = "SCHEMA_VALIDATION_FAILED",
						ErrorSummary = msg,
						MissingColumns = string.Join(" | ",
							new[]
							{
								lineValidation.MissingRequiredColumns.Count > 0 ? $"LineLevel: {string.Join(", ", lineValidation.MissingRequiredColumns)}" : "",
								claimValidation.MissingRequiredColumns.Count > 0 ? $"ClaimLevel: {string.Join(", ", claimValidation.MissingRequiredColumns)}" : ""
							}.Where(x => !string.IsNullOrWhiteSpace(x))),
						SheetName = string.Join(" | ",
							new[]
							{
								lineValidation.SheetUsed != null ? $"LineLevel={lineValidation.SheetUsed}" : "",
								claimValidation.SheetUsed != null ? $"ClaimLevel={claimValidation.SheetUsed}" : ""
							}.Where(x => !string.IsNullOrWhiteSpace(x))),
						FileName = selected.Name,
						FilePath = selected.SharePointPath,
						RecommendedAction = "Fix missing columns in the master file or update lab schema aliases.",
						OwnerTeam = "LRN",
						Status = "OPEN"
					}, ct);
					runRow.TotalErrors += 1;
					runRow.OverallStatus = "FAILED";
					runRow.MandatoryColumnCheck = "FAIL";
					runRow.Notes = msg;
					await _processLog.CompleteRunAsync(runCtx, runRow, ct);

					MoveToErrorFolder(stagingPath, msg);
					await NotifyProcessingErrorAsync(lab, msg, selected.Name, selected.SharePointPath, ct);
					continue;
				}

				step40.EndTimeIST = _processLog.NowIST();
				step40.Status = "SUCCESS";
				await _processLog.StepEndAsync(runCtx, step40, ct);
				activeStep = null;
				runRow.MandatoryColumnCheck = "PASS";

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

				// STEP 50: LineLevel RAW export
				stepSeq = 50;
				var step50 = new StepLogRow
				{
					StepSeq = stepSeq,
					StepName = "Export LineLevel RAW CSV",
					StepCategory = "Transform",
					SourceSystem = "Local",
					StartTimeIST = _processLog.NowIST(),
					Status = "IN_PROGRESS",
					FileNameIn = Path.GetFileName(stagingPath),
					PathIn = stagingPath,
					FileNameOut = Path.GetFileName(lineRawPath),
					PathOut = lineRawPath
				};
				activeStep = step50;
				await _processLog.StepStartAsync(runCtx, step50, ct);
				await ExcelCsvExporter.ExportSingleSheetToCsvAsync(stagingPath, _opt.SheetName, lineRawPath, ct);
				step50.EndTimeIST = _processLog.NowIST();
				step50.Status = "SUCCESS";
				await _processLog.StepEndAsync(runCtx, step50, ct);
				activeStep = null;
				_logger.LogInformation("Lab {LabId}: LineLevel RAW CSV export done -> {Path}", lab.LabId, lineRawPath);
				_fileLog.Info($"Lab {lab.LabId}: LineLevel RAW CSV export -> {lineRawPath}");

				// STEP 60: LineLevel STANDARD CSV
				stepSeq = 60;
				var step60 = new StepLogRow
				{
					StepSeq = stepSeq,
					StepName = "Generate LineLevel STANDARD CSV",
					StepCategory = "Transform",
					SourceSystem = "Local",
					StartTimeIST = _processLog.NowIST(),
					Status = "IN_PROGRESS",
					FileNameIn = Path.GetFileName(lineRawPath),
					PathIn = lineRawPath,
					FileNameOut = Path.GetFileName(lineOutPath),
					PathOut = lineOutPath
				};
				activeStep = step60;
				await _processLog.StepStartAsync(runCtx, step60, ct);
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
				step60.EndTimeIST = _processLog.NowIST();
				step60.Status = "SUCCESS";
				await _processLog.StepEndAsync(runCtx, step60, ct);
				activeStep = null;

				_logger.LogInformation("Lab {LabId}: LineLevel STANDARD CSV generated -> {Path}", lab.LabId, lineOutPath);
				_fileLog.Info($"Lab {lab.LabId}: LineLevel STANDARD CSV -> {lineOutPath}");

				// STEP 65: Mode/Median payment workbook
				stepSeq = 65;
				var step65 = new StepLogRow
				{
					StepSeq = stepSeq,
					StepName = "Generate Mode Median Payment Workbook",
					StepCategory = "Transform",
					SourceSystem = "Local",
					StartTimeIST = _processLog.NowIST(),
					Status = "IN_PROGRESS",
					FileNameIn = Path.GetFileName(lineOutPath),
					PathIn = lineOutPath,
					FileNameOut = Path.GetFileName(modeMedianOutPath),
					PathOut = modeMedianOutPath
				};
				activeStep = step65;
				await _processLog.StepStartAsync(runCtx, step65, ct);
				ModeMedianPaymentReportWriter.Generate(lineOutPath, modeMedianOutPath);
				step65.EndTimeIST = _processLog.NowIST();
				step65.Status = "SUCCESS";
				await _processLog.StepEndAsync(runCtx, step65, ct);
				activeStep = null;
				_logger.LogInformation("Lab {LabId}: Mode/Median payment workbook generated -> {Path}", lab.LabId, modeMedianOutPath);
				_fileLog.Info($"Lab {lab.LabId}: Mode/Median payment workbook -> {modeMedianOutPath}");

				// STEP 70: ClaimLevel RAW export
				stepSeq = 70;
				var step70 = new StepLogRow
				{
					StepSeq = stepSeq,
					StepName = "Export ClaimLevel RAW CSV",
					StepCategory = "Transform",
					SourceSystem = "Local",
					StartTimeIST = _processLog.NowIST(),
					Status = "IN_PROGRESS",
					FileNameIn = Path.GetFileName(stagingPath),
					PathIn = stagingPath,
					FileNameOut = Path.GetFileName(claimRawPath),
					PathOut = claimRawPath
				};
				activeStep = step70;
				await _processLog.StepStartAsync(runCtx, step70, ct);
				await ExcelCsvExporter.ExportSingleSheetToCsvAsync(stagingPath, _opt.ClaimSheetName, claimRawPath, ct);
				step70.EndTimeIST = _processLog.NowIST();
				step70.Status = "SUCCESS";
				await _processLog.StepEndAsync(runCtx, step70, ct);
				activeStep = null;
				_logger.LogInformation("Lab {LabId}: ClaimLevel RAW CSV export done -> {Path}", lab.LabId, claimRawPath);
				_fileLog.Info($"Lab {lab.LabId}: ClaimLevel RAW CSV export -> {claimRawPath}");

				// STEP 80: ClaimLevel STANDARD CSV
				stepSeq = 80;
				var step80 = new StepLogRow
				{
					StepSeq = stepSeq,
					StepName = "Generate ClaimLevel STANDARD CSV",
					StepCategory = "Transform",
					SourceSystem = "Local",
					StartTimeIST = _processLog.NowIST(),
					Status = "IN_PROGRESS",
					FileNameIn = Path.GetFileName(claimRawPath),
					PathIn = claimRawPath,
					FileNameOut = Path.GetFileName(claimOutPath),
					PathOut = claimOutPath
				};
				activeStep = step80;
				await _processLog.StepStartAsync(runCtx, step80, ct);
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
				step80.EndTimeIST = _processLog.NowIST();
				step80.Status = "SUCCESS";
				await _processLog.StepEndAsync(runCtx, step80, ct);
				activeStep = null;
				runRow.SplitOutputWrittenToSharePoint = "YES";

				_logger.LogInformation("Lab {LabId}: ClaimLevel STANDARD CSV generated -> {Path}", lab.LabId, claimOutPath);
				_fileLog.Info($"Lab {lab.LabId}: ClaimLevel STANDARD CSV -> {claimOutPath}");

				sw.Stop();

				// Cleanup RAW CSVs unless configured to keep
				if (!_opt.KeepRawCsvExports)
				{
					TryDelete(lineRawPath);
					TryDelete(claimRawPath);
				}

				// STEP 90: FileStatus CSV log (local + optional upload)
				stepSeq = 90;
				var step90 = new StepLogRow
				{
					StepSeq = stepSeq,
					StepName = "Write File Status Log",
					StepCategory = "Publish",
					SourceSystem = "SharePoint",
					StartTimeIST = _processLog.NowIST(),
					Status = "IN_PROGRESS"
				};
				activeStep = step90;
				await _processLog.StepStartAsync(runCtx, step90, ct);
				await TryWriteAndUploadFileStatusLogAsync(lab, selected, siteDriveId, status: "Completed", outputLocation: processedOutFolder, logMessage: "imported", ct: ct);
				step90.EndTimeIST = _processLog.NowIST();
				step90.Status = "SUCCESS";
				await _processLog.StepEndAsync(runCtx, step90, ct);
				activeStep = null;

				// STEP 100: Upload standardized outputs to SharePoint
				stepSeq = 100;
				var step100 = new StepLogRow
				{
					StepSeq = stepSeq,
					StepName = "Upload Outputs to SharePoint",
					StepCategory = "Publish",
					SourceSystem = "SharePoint",
					StartTimeIST = _processLog.NowIST(),
					Status = "IN_PROGRESS",
					FileNameIn = $"{Path.GetFileName(claimOutPath)} | {Path.GetFileName(lineOutPath)} | {Path.GetFileName(modeMedianOutPath)}",
					PathIn = processedOutFolder
				};
				activeStep = step100;
				await _processLog.StepStartAsync(runCtx, step100, ct);
				var outputUploadResult = await TryUploadOutputsAsync(lab, selected, runLocalNow, claimOutPath, lineOutPath, modeMedianOutPath, ct);
				step100.EndTimeIST = _processLog.NowIST();
				step100.Status = outputUploadResult.StartsWith("UPLOADED", StringComparison.OrdinalIgnoreCase) ? "SUCCESS" : "WARNING";
				step100.ErrorMessage = outputUploadResult;
				await _processLog.StepEndAsync(runCtx, step100, ct);
				activeStep = null;
				runRow.OutputsCopiedToSharePoint = outputUploadResult.StartsWith("UPLOADED", StringComparison.OrdinalIgnoreCase) ? "YES" : (outputUploadResult.StartsWith("SKIPPED", StringComparison.OrdinalIgnoreCase) ? "SKIPPED" : "NO");

				if (step100.Status == "WARNING" && !outputUploadResult.StartsWith("SKIPPED", StringComparison.OrdinalIgnoreCase))
				{
					await _processLog.LogErrorAsync(runCtx, new ErrorLogRow
					{
						Severity = "WARNING",
						StepName = step100.StepName,
						ErrorCode = "OUTPUT_UPLOAD_WARNING",
						ErrorSummary = outputUploadResult,
						FileName = selected.Name,
						FilePath = selected.SharePointPath,
						RecommendedAction = "Verify SharePoint output folder path/permissions and retry upload if needed.",
						OwnerTeam = "LRN",
						Status = "OPEN"
					}, ct);
					runRow.TotalWarnings += 1;
				}

				// STEP 110: Mark status PROCESSED (SQL)
				stepSeq = 110;
				var step110 = new StepLogRow
				{
					StepSeq = stepSeq,
					StepName = "Mark File PROCESSED",
					StepCategory = "Sync",
					SourceSystem = "SQL",
					StartTimeIST = _processLog.NowIST(),
					Status = "IN_PROGRESS",
					FileNameIn = selected.Name,
					PathIn = selected.SharePointPath
				};
				activeStep = step110;
				await _processLog.StepStartAsync(runCtx, step110, ct);

				// Mark PROCESSED
				await _status.UpsertStatusAsync(
					selected.LabId, selected.DriveId, selected.ItemId, selected.ETagKey,
					selected.Name, selected.SharePointPath, selected.LastModifiedUtc,
					status: "PROCESSED",
					statusMessage: $"Saved LineLevel='{lineOutPath}', ClaimLevel='{claimOutPath}', ModeMedian='{modeMedianOutPath}'. OutputUpload={outputUploadResult}.",
					processedAtUtc: DateTimeOffset.UtcNow,
					ct: ct);

				step110.EndTimeIST = _processLog.NowIST();
				step110.Status = "SUCCESS";
				await _processLog.StepEndAsync(runCtx, step110, ct);
				activeStep = null;

				// Daily master processor log row (client requirement)
				MasterProcessorLogCsv.Append(
					folder: masterLogFolder,
					localNow: runLocalNow,
					labId: lab.LabId,
					labName: lab.LabName,
					sourceFileName: selected.Name,
					sourceFileLocation: selected.SharePointPath,
					status: "Completed",
					message: $"imported; ModeMedian='{modeMedianOutPath}'; {outputUploadResult}",
					claimOutput: claimOutPath,
					lineOutput: lineOutPath);

				_fileLog.Info($"Lab {lab.LabId}: PROCESSED {selected.Name}.");

				// STEP 120: Archive RAW XLSX
				stepSeq = 120;
				var step120 = new StepLogRow
				{
					StepSeq = stepSeq,
					StepName = "Archive RAW XLSX",
					StepCategory = "Publish",
					SourceSystem = "Local",
					StartTimeIST = _processLog.NowIST(),
					Status = "IN_PROGRESS",
					FileNameIn = Path.GetFileName(stagingPath),
					PathIn = stagingPath
				};
				activeStep = step120;
				await _processLog.StepStartAsync(runCtx, step120, ct);

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
					step120.FileNameOut = Path.GetFileName(dest);
					step120.PathOut = dest;
					step120.Status = "SUCCESS";
				}
				catch (Exception ex)
				{
					_fileLog.Error("Failed to archive raw XLSX.", ex);
					step120.Status = "WARNING";
					step120.ErrorCode = "ARCHIVE_FAILED";
					step120.ErrorMessage = ex.Message;

					try
					{
						await _processLog.LogErrorAsync(runCtx, new ErrorLogRow
						{
							Severity = "WARNING",
							StepName = step120.StepName,
							ErrorCode = "ARCHIVE_FAILED",
							ErrorSummary = ex.Message,
							FileName = Path.GetFileName(stagingPath),
							FilePath = stagingPath,
							RecommendedAction = "Check disk permissions/locks for archive folder and retry.",
							OwnerTeam = "LRN",
							Status = "OPEN"
						}, ct);
						runRow.TotalWarnings += 1;
					}
					catch { }
				}
				finally
				{
					step120.EndTimeIST = _processLog.NowIST();
					await _processLog.StepEndAsync(runCtx, step120, ct);
					activeStep = null;
				}

				// STEP 130: Optional SharePoint move
				stepSeq = 130;
				var step130 = new StepLogRow
				{
					StepSeq = stepSeq,
					StepName = "Move Source File to Processed Folder",
					StepCategory = "Publish",
					SourceSystem = "SharePoint",
					StartTimeIST = _processLog.NowIST(),
					Status = "IN_PROGRESS",
					FileNameIn = selected.Name,
					PathIn = selected.SharePointPath
				};
				activeStep = step130;
				await _processLog.StepStartAsync(runCtx, step130, ct);

				var processedFolderId = await _sp.TryResolveProcessedFolderIdAsync(ct);
				if (!string.IsNullOrWhiteSpace(processedFolderId))
				{
					await _sp.MoveItemAsync(selected.DriveId, selected.ItemId, processedFolderId!, ct);
					_fileLog.Info($"Lab {lab.LabId}: moved SharePoint file to processed folder.");
					step130.Status = "SUCCESS";
				}
				else
				{
					step130.Status = "SKIPPED";
					step130.ErrorMessage = "Processed folder not configured or not resolved.";
				}
				step130.EndTimeIST = _processLog.NowIST();
				await _processLog.StepEndAsync(runCtx, step130, ct);
				activeStep = null;

				runRow.OverallStatus = "SUCCESS";
				runRow.Notes = $"Saved LineLevel='{lineOutPath}', ClaimLevel='{claimOutPath}', ModeMedian='{modeMedianOutPath}'. OutputUpload={outputUploadResult}.";
				await _processLog.CompleteRunAsync(runCtx, runRow, ct);
				await NotifyCompletedAsync(lab, ResolveNotificationOutputLocation(outputUploadResult, processedOutFolder), ct);
			}
			catch (OperationCanceledException) when (ct.IsCancellationRequested)
			{
				throw;
			}
			catch (Exception ex)
			{
				// If a step was started but not ended, mark it as FAILED
				try
				{
					if (activeStep != null && string.Equals(activeStep.Status, "IN_PROGRESS", StringComparison.OrdinalIgnoreCase))
					{
						activeStep.EndTimeIST = _processLog.NowIST();
						activeStep.Status = "FAILED";
						activeStep.ErrorCode ??= "STEP_FAILED";
						activeStep.ErrorMessage ??= ex.Message;
						activeStep.ErrorDetail ??= ex.ToString();
						await _processLog.StepEndAsync(runCtx, activeStep, ct);
					}
				}
				catch { }

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

				// Error_Log entry for unexpected exceptions
				try
				{
					await _processLog.LogErrorAsync(runCtx, new ErrorLogRow
					{
						Severity = "ERROR",
						StepName = stepSeq > 0 ? $"Step {stepSeq}" : "Unhandled",
						ErrorCode = "UNHANDLED_EXCEPTION",
						ErrorSummary = ex.Message,
						FileName = selected?.Name,
						FilePath = selected?.SharePointPath,
						RecommendedAction = "Check ErrorDetail and fix the underlying failure, then rerun.",
						OwnerTeam = "LRN",
						Status = "OPEN"
					}, ct);
					runRow.TotalErrors += 1;
				}
				catch { }

				try
				{
					runRow.OverallStatus = "FAILED";
					runRow.Notes = ex.Message;
					await _processLog.CompleteRunAsync(runCtx, runRow, ct);
				}
				catch { }

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

				await NotifyProcessingErrorAsync(lab, ex.Message, selected?.Name, selected?.SharePointPath, ct);
			}
		}

		// Upload the daily master processor log once per run (client requirement)
		await TryUploadMasterProcessorLogAsync(runLocalNow, masterLogFolder, ct);
	}

	private async Task NotifyNoLatestFileFoundAsync(LabFileMap lab, CancellationToken ct)
	{
		var title = $"Master File Processor - No Latest File Found For Lab {lab.LabName}";
		var message = string.IsNullOrWhiteSpace(lab.SharePointRootPath)
			? "No latest eligible master file was found for processing."
			: $"No latest eligible master file was found under {lab.SharePointRootPath}.";

		await TrySendTeamNotificationAsync(title, message, ct);
	}

	private async Task NotifyProcessingErrorAsync(LabFileMap lab, string errorMessage, string? fileName, string? filePath, CancellationToken ct)
	{
		var title = $"Master File Processor - Error On File Processing For Lab {lab.LabName}";

		var parts = new List<string>();
		if (!string.IsNullOrWhiteSpace(fileName))
			parts.Add($"File: {fileName}");
		if (!string.IsNullOrWhiteSpace(filePath))
			parts.Add($"Path: {filePath}");
		parts.Add($"Error: {errorMessage}");

		await TrySendTeamNotificationAsync(title, string.Join(Environment.NewLine, parts), ct);
	}

	private async Task NotifyCompletedAsync(LabFileMap lab, string outputLocation, CancellationToken ct)
	{
		var title = $"Master File Processor - Completed Process For Lab {lab.LabName}";
		var message = $"Copied the Line level and claim level files under {outputLocation}.";

		await TrySendTeamNotificationAsync(title, message, ct);
	}

	private async Task TrySendTeamNotificationAsync(string title, string message, CancellationToken ct)
	{
		try
		{
			await _teamsNotifier.SendAsync(new TeamsNotification
			{
				Title = title,
				Message = message
			}, ct);

			_fileLog.Info($"Teams notification sent. Title='{title}'");
		}
		catch (Exception ex)
		{
			_logger.LogWarning(ex, "Failed to send Teams notification. Title={Title}", title);
			_fileLog.Warn($"Failed to send Teams notification. Title='{title}'. Error='{ex.Message}'");
		}
	}

	private static string ResolveNotificationOutputLocation(string outputUploadResult, string processedOutFolder)
	{
		const string uploadedPrefix = "UPLOADED -> ";

		if (!string.IsNullOrWhiteSpace(outputUploadResult) &&
			outputUploadResult.StartsWith(uploadedPrefix, StringComparison.OrdinalIgnoreCase))
		{
			return outputUploadResult.Substring(uploadedPrefix.Length).Trim();
		}

		return processedOutFolder;
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
		string modeMedianOutPath,
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

			if (File.Exists(modeMedianOutPath))
			{
				await _sp.UploadFileToFolderPathAsync(
					driveId: selected.DriveId,
					folderPath: destFolder,
					localFilePath: modeMedianOutPath,
					uploadFileName: Path.GetFileName(modeMedianOutPath),
					ct: ct);
			}

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


	private static string BuildProcessedOutputFileName(string runId, string? labName, string levelLabel, string sourceDateLabel)
	{
		var labPart = string.IsNullOrWhiteSpace(labName) ? "UnknownLab" : labName.Trim();
		var levelPart = string.IsNullOrWhiteSpace(levelLabel) ? "Output" : levelLabel.Trim();
		var datePart = string.IsNullOrWhiteSpace(sourceDateLabel) ? "UnknownDate" : sourceDateLabel.Trim();

		var fileName = $"{runId}_{labPart}_{levelPart}_{datePart}.csv";
		return SanitizeFileNameKeepSpaces(fileName);
	}

	private static string BuildModeMedianOutputFileName(string runId, DateTime runLocalNow)
	{
		var datePart = runLocalNow.ToString("yyyyMMdd", CultureInfo.InvariantCulture);
		var fileName = $"{runId}_Mode_Median_{datePart}.xlsx";
		return SanitizeFileNameKeepSpaces(fileName);
	}

	private static string NormalizeWeekFolderForFileName(string? weekFolder)
	{
		if (string.IsNullOrWhiteSpace(weekFolder)) return "UnknownDate";

		var value = weekFolder.Trim();
		value = Regex.Replace(value, @"\s*-\s*", " to ");
		return value;
	}

	private static string SanitizeFileNameKeepSpaces(string input)
	{
		foreach (var c in Path.GetInvalidFileNameChars())
			input = input.Replace(c, '_');
		return input.Trim();
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