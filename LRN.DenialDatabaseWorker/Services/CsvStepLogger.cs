using DenialDatabaseProcessorWorker.Models;
using Microsoft.Extensions.Logging;
using Microsoft.Extensions.Options;
using System.Globalization;
using System.Text;
using System.Threading; // ensure SemaphoreSlim is available

namespace DenialDatabaseProcessorWorker.Services;

public sealed class CsvStepLogger
{
    private readonly ProcessorOptions _options;
    private readonly ILogger<CsvStepLogger> _logger;
    private static readonly SemaphoreSlim _gate = new(1, 1);

    public CsvStepLogger(IOptions<ProcessorOptions> options, ILogger<CsvStepLogger> logger)
    {
        _options = options.Value;
        _logger = logger;
    }

    public async Task LogAsync(
        LabConfig lab,
        string stepDescription,
        string logType, // ERROR / InProgress / Completed
        string payerPolicyFilePath,
        string claimActionMapperFilePath,
        string outputPath,
        string? errorInfo = null,
        CancellationToken ct = default)
    {
        var path = _options.LogCsvPath;
        var now = DateTime.Now; // local server time
        var line = BuildCsvLine(lab, stepDescription, logType, payerPolicyFilePath, claimActionMapperFilePath, errorInfo, now, outputPath);

        try
        {
            await _gate.WaitAsync(ct);

            Directory.CreateDirectory(Path.GetDirectoryName(path) ?? ".");

            var writeHeader = !File.Exists(path) || new FileInfo(path).Length == 0;

            await using var fs = new FileStream(path, FileMode.Append, FileAccess.Write, FileShare.Read);
            await using var sw = new StreamWriter(fs, new UTF8Encoding(encoderShouldEmitUTF8Identifier: false));

            if (writeHeader)
            {
                await sw.WriteLineAsync("LabName,LabId,StepDescription,LogType,PayerPolicyFilePath,ClaimActionMapperFilePath,ErrorInfo,LogDateTime,OutputPath");
            }

            await sw.WriteLineAsync(line);
        }
        catch (Exception ex)
        {
            _logger.LogError(ex, "Failed to write CSV log to {LogCsvPath}", path);
        }
        finally
        {
            _gate.Release();
        }
    }

    private static string BuildCsvLine(
        LabConfig lab,
        string stepDescription,
        string logType,
        string payerPolicyFilePath,
        string claimActionMapperFilePath,
        string? errorInfo,
        DateTime now,
        string outputPath)
    {
        // RFC4180-ish escaping
        static string E(string? s)
        {
            if (string.IsNullOrEmpty(s))
                return string.Empty;

            var mustQuote = s.IndexOfAny(new[] { ',', '"', '\n', '\r' }) >= 0;
            if (mustQuote)
            {
                s = s.Replace("\"", "\"\"");
                return $"\"{s}\"";
            }
            return s;
        }

        return string.Join(",",
            E(lab.LabName),
            lab.LabId.ToString(CultureInfo.InvariantCulture),
            E(stepDescription),
            E(logType),
            E(payerPolicyFilePath),
            E(claimActionMapperFilePath),
            E(errorInfo),
            E(now.ToString("yyyy-MM-dd HH:mm:ss", CultureInfo.InvariantCulture)),
            E(outputPath)
        );
    }
}
