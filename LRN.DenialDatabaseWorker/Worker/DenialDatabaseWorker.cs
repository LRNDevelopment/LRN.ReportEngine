using DenialDatabaseProcessorWorker.Models;
using DenialDatabaseProcessorWorker.Notifications;
using DenialDatabaseProcessorWorker.Services;
using DenialDatabaseProcessorWorker.Services.SharePoint;
using DenialDatabaseProcessorWorker.Utils;
using Microsoft.Extensions.Hosting;
using Microsoft.Extensions.Logging;
using Microsoft.Extensions.Options;
using System.Text;

namespace DenialDatabaseProcessorWorker.Worker;

public sealed class DenialDatabaseWorker : BackgroundService
{
	private readonly ILogger<DenialDatabaseWorker> _logger;
	private readonly ProcessorOptions _options;
	private readonly List<LabConfig> _labs;
	private readonly ITeamsNotifier _teamsNotifier;
	private readonly CsvStepLogger _stepLogger;
	private readonly ExcelTableReader _excelReader;
	private readonly DenialDatabaseBuilder _builder;
	private readonly ExcelWriter _excelWriter;
	private readonly ISharePointUploader _uploader;
	private readonly DenialInsightBuilder _insightBuilder;
	private readonly FileResolver _fileResolver;
	private readonly OutputPathBuilder _outputPathBuilder;
	private readonly TaskBoardBulkWriter _taskBoardBulkWriter;
	private readonly DenialAnalysisRunLogRepository _runLogRepo;
	private readonly DenialTaskBoardRepository _denialTaskBoardRepo;
	private readonly IErrorLogger _errorLogger;
	private readonly SharePointGraphOptions _spOpt;
	private static List<(string Key, string Value)> lstOutput = new List<(string Key, string Value)>();

	public DenialDatabaseWorker(
		ILogger<DenialDatabaseWorker> logger,
		IOptions<ProcessorOptions> options,
		IOptions<List<LabConfig>> labs,
		CsvStepLogger stepLogger,
		ExcelTableReader excelReader,
		DenialDatabaseBuilder builder,
		ExcelWriter excelWriter,
		ISharePointUploader uploader,
		DenialInsightBuilder insightBuilder,
		FileResolver fileResolver,
		OutputPathBuilder outputPathBuilder,
		TaskBoardBulkWriter taskBoardBulkWriter,
		DenialAnalysisRunLogRepository runLogRepo,
		DenialTaskBoardRepository denialTaskBoardRepo,
		IErrorLogger errorLogger, IOptions<SharePointGraphOptions> spOpt, ITeamsNotifier teamsNotifier)
	{
		_logger = logger;
		_options = options.Value;
		_labs = labs.Value ?? new();

		_stepLogger = stepLogger;
		_excelReader = excelReader;
		_builder = builder;
		_excelWriter = excelWriter;
		_uploader = uploader;
		_insightBuilder = insightBuilder;
		_fileResolver = fileResolver;
		_outputPathBuilder = outputPathBuilder;
		_taskBoardBulkWriter = taskBoardBulkWriter;
		_runLogRepo = runLogRepo;
		_denialTaskBoardRepo = denialTaskBoardRepo;
		_errorLogger = errorLogger;
		_spOpt = spOpt.Value;
		_teamsNotifier = teamsNotifier;
	}

	protected override async Task ExecuteAsync(CancellationToken stoppingToken)
	{
		if (_labs.Count == 0)
		{
			_logger.LogWarning("No labs configured. Nothing to do.");
			return;
		}

		try
		{
			foreach (var lab in _labs)
				await ProcessLabAsync(lab, stoppingToken);

		}
		catch (Exception ex)
		{
			_logger.LogError(ex, "Top-level worker failure.");
		}
		finally
		{
			if (_options.RunOnceOnStartup)
			{
				_logger.LogInformation("RunOnceOnStartup=true. Stopping host.");
				Environment.ExitCode = 0;
			}
		}

		if (!_options.RunOnceOnStartup)
		{
			while (!stoppingToken.IsCancellationRequested)
				await Task.Delay(TimeSpan.FromMinutes(120), stoppingToken);
		}
	}

	private async Task ProcessLabAsync(LabConfig lab, CancellationToken ct)
	{
		string payerPolicyFile = _fileResolver.GetLatestPayerPolicyFile(lab);
		string claimActionMapperFile = _fileResolver.GetLatestClaimActionMapper(lab);

		var runId = _fileResolver.ExtractRunId(payerPolicyFile);

		if (await _runLogRepo.ExistsAsync(runId))
		{
			_logger.LogInformation("RunId {RunId} already processed. Skipping lab {LabName}.", runId, lab.LabName);
			return;
		}

		var (yearFolder, monthFolder, weekFolder) = _fileResolver.ExtractFolderStructure(payerPolicyFile);
		var outFile = _outputPathBuilder.BuildOutputPath(_options.OutputRoot, lab.LabName, runId, yearFolder, monthFolder, weekFolder);

		await _stepLogger.LogAsync(lab, "Start", "InProgress", payerPolicyFile, claimActionMapperFile, outFile, null, ct);

		try
		{
			// Load existing tasks for this lab from DenialTaskBoard
			var existingTasks = await _denialTaskBoardRepo.GetExistingTasksAsync(lab.LabId);


			// Load Claim Action Mapper
			await _stepLogger.LogAsync(lab, "Load ClaimActionMapper excel", "InProgress", payerPolicyFile, claimActionMapperFile, outFile, null, ct);
			var claimRows = _excelReader.Read(claimActionMapperFile, "Denial Classifier");
			var claimMapperIndex = new ClaimActionMapperIndex(claimRows);
			await _stepLogger.LogAsync(lab, "Load ClaimActionMapper excel", "Completed", payerPolicyFile, claimActionMapperFile, outFile, null, ct);

			// Load Payer Policy
			await _stepLogger.LogAsync(lab, "Load PayerPolicy excel", "InProgress", payerPolicyFile, claimActionMapperFile, outFile, null, ct);
			var payerRows = _excelReader.Read(payerPolicyFile);
			await _stepLogger.LogAsync(lab, "Load PayerPolicy excel", "Completed", payerPolicyFile, claimActionMapperFile, outFile, null, ct);

			// Normalize + Map
			await _stepLogger.LogAsync(lab, "Normalize DenialCode + map fields", "InProgress", payerPolicyFile, claimActionMapperFile, outFile, null, ct);
			var (headers, finalRows) = _builder.Build(payerRows, claimMapperIndex);
			await _stepLogger.LogAsync(lab, "Normalize DenialCode + map fields", "Completed", payerPolicyFile, claimActionMapperFile, outFile, null, ct);

			// Build Insights
			var insight = _insightBuilder.Build(finalRows);


			// Build Task Board
			var taskBuilder = new TaskBoardBuilder(lab.LabId, lab.LabName, runId, existingTasks);
			var taskRows = taskBuilder.Build(finalRows);

			// Write Excel
			await _stepLogger.LogAsync(lab, "Write DenialDatabase excel", "InProgress", payerPolicyFile, claimActionMapperFile, outFile, null, ct);

			// Write Excel (taskRows already contain Insurance Balance; IsCurrentDenial is ignored by ExcelWriter)
			_excelWriter.Write(
				outFile,
				headers,
				finalRows,
				insight.Headers,
				insight.Rows,
				taskRows
			);

			await _stepLogger.LogAsync(lab, "Write DenialDatabase excel", "Completed", payerPolicyFile, claimActionMapperFile, outFile, null, ct);

			// Bulk Insert Task Board (delete by LabId then insert merged current + closed old tasks)
			await _taskBoardBulkWriter.BulkInsertAsync(taskRows, lab.LabId);


			// Insert RunLog
			await _runLogRepo.InsertAsync(runId, lab.LabId, outFile);

			// Upload to SharePoint
			await _stepLogger.LogAsync(lab, "Upload to SharePoint", "InProgress", payerPolicyFile, claimActionMapperFile, outFile, null, ct);
			await _uploader.UploadIfEnabledAsync(lab, outFile, DateTime.Now, ct);
			await _stepLogger.LogAsync(lab, "Upload to SharePoint", "Completed", payerPolicyFile, claimActionMapperFile, outFile, null, ct);

			await _stepLogger.LogAsync(lab, "Completed", "Completed", payerPolicyFile, claimActionMapperFile, outFile, null, ct);

		}
		catch (Exception ex)
		{
			_logger.LogError(ex, "Lab processing failed: {LabName}", lab.LabName);

			await _errorLogger.LogAsync(
				runId,
				lab.LabName,
				"ProcessLabAsync",
				Path.GetFileName(payerPolicyFile),
				payerPolicyFile,
				ex,
				ct);

			await _stepLogger.LogAsync(
				lab,
				"Failed",
				"ERROR",
				payerPolicyFile,
				claimActionMapperFile,
				outFile,
				ex.ToString(),
				ct);

			await NotifyFileUploadFailedAsync("Denial Analysis Report", lab.LabName, payerPolicyFile, ex, ct);

		}
	}

	private Task NotifyFileSynchronizedAsync(string fileType, string remotePath, string localPath, CancellationToken ct)
	{
		var fileName = Path.GetFileName(localPath);
		var remoteUrl = SharePointWebLinkBuilder.TryBuildFileUrl(_spOpt, remotePath);

		var message = new StringBuilder()
			.AppendLine("🟢 File synchronized successfully.\n")
			.AppendLine($"📁 Type: {fileType}  \n")
			.AppendLine(string.IsNullOrWhiteSpace(remoteUrl)
				? $"📁 Source: {remotePath}\n"
				: $"📄 Source: [{fileName}]({remoteUrl})\n")
			.Append($"Destination: {localPath}")
			.ToString();

		return _teamsNotifier.SendAsync("🤖 LRN : Denial Database Processor", message, ct);
	}

	private Task NotifyFileUploadFailedAsync(string fileType, string localFile, string remotePath, Exception ex, CancellationToken ct)
	{
		var fileName = Path.GetFileName(localFile);
		var remoteUrl = SharePointWebLinkBuilder.TryBuildFileUrl(_spOpt, remotePath);

		var message = new StringBuilder()
			.AppendLine("⚠️ File upload failed.\n")
			.AppendLine($"Type: {fileType} \n")
			.AppendLine(string.IsNullOrWhiteSpace(remoteUrl)
				? $"📁 SharePoint: {remotePath} \n	"
				: $"📄 SharePoint: [{fileName}]({remoteUrl}\n")
			.AppendLine($"Source: {localFile} \n")
			.Append($"Error: {ex.Message}")
			.ToString();

		return _teamsNotifier.SendAsync("🤖 LRN : Denial Database Processor", message, ct);
	}
}