using DenialDatabaseProcessorWorker.Models;
using DenialDatabaseProcessorWorker.Services;
using DenialDatabaseProcessorWorker.Services.SharePoint;
using Microsoft.Extensions.Hosting;
using Microsoft.Extensions.Logging;
using Microsoft.Extensions.Options;

namespace DenialDatabaseProcessorWorker.Worker;

public sealed class DenialDatabaseWorker : BackgroundService
{
	private readonly ILogger<DenialDatabaseWorker> _logger;
	private readonly ProcessorOptions _options;
	private readonly List<LabConfig> _labs;

	private readonly CsvStepLogger _stepLogger;
	private readonly ExcelTableReader _excelReader;
	private readonly DenialDatabaseBuilder _builder;
	private readonly ExcelWriter _excelWriter;
	private readonly ISharePointUploader _uploader;
	private readonly DenialInsightBuilder _insightBuilder;

	public DenialDatabaseWorker(
		ILogger<DenialDatabaseWorker> logger,
		IOptions<ProcessorOptions> options,
		IOptions<List<LabConfig>> labs,
		CsvStepLogger stepLogger,
		ExcelTableReader excelReader,
		DenialDatabaseBuilder builder,
		ExcelWriter excelWriter,
		ISharePointUploader uploader,
		DenialInsightBuilder insightBuilder)
	{
		_logger = logger;
		_options = options.Value;
		_labs = labs.Value ?? new();

		_stepLogger = stepLogger;
		_excelReader = excelReader;
		_builder = builder;
		_excelWriter = excelWriter;
		_uploader = uploader;
		_insightBuilder = insightBuilder;      // <-- ADD THIS
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
			{
				await ProcessLabAsync(lab, stoppingToken);
			}
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
				await Task.Delay(TimeSpan.FromMinutes(5), stoppingToken);
		}
	}

	private async Task ProcessLabAsync(LabConfig lab, CancellationToken ct)
	{
		var now = DateTime.Now;
		var monthFolder = now.ToString("MMMM-yyyy");
		var dateFolder = now.ToString("MMddyyyy");
		var outDir = Path.Combine(_options.OutputRoot, lab.LabName, monthFolder, dateFolder);
		var outFile = Path.Combine(outDir, $"{lab.LabName}_DenialDatabase_{dateFolder}.xlsx");

		await _stepLogger.LogAsync(lab, "Start", "InProgress", lab.PayerPolicyFile, lab.ClaimActionMapper, outFile, null, ct);

		try
		{
			await _stepLogger.LogAsync(lab, "Load ClaimActionMapper excel", "InProgress", lab.PayerPolicyFile, lab.ClaimActionMapper, outFile, null, ct);
			var claimRows = _excelReader.Read(lab.ClaimActionMapper, "Denial Classifier");
			var claimMapperIndex = new ClaimActionMapperIndex(claimRows);
			await _stepLogger.LogAsync(lab, "Load ClaimActionMapper excel", "Completed", lab.PayerPolicyFile, lab.ClaimActionMapper, outFile, null, ct);

			await _stepLogger.LogAsync(lab, "Load PayerPolicy excel", "InProgress", lab.PayerPolicyFile, lab.ClaimActionMapper, outFile, null, ct);
			var payerRows = _excelReader.Read(lab.PayerPolicyFile);
			await _stepLogger.LogAsync(lab, "Load PayerPolicy excel", "Completed", lab.PayerPolicyFile, lab.ClaimActionMapper, outFile, null, ct);

			await _stepLogger.LogAsync(lab, "Normalize DenialCode + map fields", "InProgress", lab.PayerPolicyFile, lab.ClaimActionMapper, outFile, null, ct);
			var (headers, finalRows) = _builder.Build(payerRows, claimMapperIndex);
			await _stepLogger.LogAsync(lab, "Normalize DenialCode + map fields", "Completed", lab.PayerPolicyFile, lab.ClaimActionMapper, outFile, null, ct);

			// Build Insight Sheet
			var insight = _insightBuilder.Build(finalRows);

			await _stepLogger.LogAsync(lab, "Write DenialDatabase excel", "InProgress", lab.PayerPolicyFile, lab.ClaimActionMapper, outFile, null, ct);
			_excelWriter.Write(
				outFile,
				headers,
				finalRows,
				insight.Headers,
				insight.Rows
			);
			await _stepLogger.LogAsync(lab, "Write DenialDatabase excel", "Completed", lab.PayerPolicyFile, lab.ClaimActionMapper, outFile, null, ct);
			await _stepLogger.LogAsync(lab, "Write DenialDatabase excel", "Completed", lab.PayerPolicyFile, lab.ClaimActionMapper, outFile, null, ct);

			await _stepLogger.LogAsync(lab, "Upload to SharePoint", "InProgress", lab.PayerPolicyFile, lab.ClaimActionMapper, outFile, null, ct);
			await _uploader.UploadIfEnabledAsync(lab, outFile, now, ct);
			await _stepLogger.LogAsync(lab, "Upload to SharePoint", "Completed", lab.PayerPolicyFile, lab.ClaimActionMapper, outFile, null, ct);

			await _stepLogger.LogAsync(lab, "Completed", "Completed", lab.PayerPolicyFile, lab.ClaimActionMapper, outFile, null, ct);
		}
		catch (Exception ex)
		{
			_logger.LogError(ex, "Lab processing failed: {LabName}", lab.LabName);
			await _stepLogger.LogAsync(lab, "Failed", "ERROR", lab.PayerPolicyFile, lab.ClaimActionMapper, outFile, ex.ToString(), ct);
		}
	}
}
