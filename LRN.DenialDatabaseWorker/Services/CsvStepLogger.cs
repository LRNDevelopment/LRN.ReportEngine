using DenialDatabaseProcessorWorker.Models;
using Microsoft.Extensions.Logging;
using Microsoft.Extensions.Options;
using System.Globalization;
using System.Text;

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
        CancellationToken ct = default,
        string policyActionMapperFilePath = "")
    {
        var path = _options.LogCsvPath;
        var now = DateTime.Now;

        try
        {
            await _gate.WaitAsync(ct);

            Directory.CreateDirectory(Path.GetDirectoryName(path) ?? ".");

            bool writeHeader = !File.Exists(path) || new FileInfo(path).Length == 0;

            // If file exists with OLD header (no PolicyActionMapperFilePath), keep old format appends.
            bool useNewFormat = true;
            if (!writeHeader)
            {
                try
                {
                    var header = File.ReadLines(path).FirstOrDefault() ?? "";
                    useNewFormat = header.Contains("PolicyActionMapperFilePath", StringComparison.OrdinalIgnoreCase);
                }
                catch
                {
                    useNewFormat = true;
                }
            }

            var line = useNewFormat
                ? BuildCsvLineNew(lab, stepDescription, logType, payerPolicyFilePath, claimActionMapperFilePath, policyActionMapperFilePath, errorInfo, now, outputPath)
                : BuildCsvLineOld(lab, stepDescription, logType, payerPolicyFilePath, claimActionMapperFilePath, errorInfo, now, outputPath);

            await using var fs = new FileStream(path, FileMode.Append, FileAccess.Write, FileShare.Read);
            await using var sw = new StreamWriter(fs, new UTF8Encoding(encoderShouldEmitUTF8Identifier: false));

            if (writeHeader)
            {
                await sw.WriteLineAsync("LabName,LabId,StepDescription,LogType,PayerPolicyFilePath,ClaimActionMapperFilePath,PolicyActionMapperFilePath,ErrorInfo,LogDateTime,OutputPath");
            }

            await sw.WriteLineAsync(line);
        }
        catch (Exception ex)
        {
            _logger.LogError(ex, "Failed to write CSV log to {LogCsvPath}", _options.LogCsvPath);
        }
        finally
        {
            _gate.Release();
        }
    }

    private static string BuildCsvLineOld(
      LabConfig lab,
      string stepDescription,
      string logType,
      string payerPolicyFilePath,
      string claimActionMapperFilePath,
      string? errorInfo,
      DateTime now,
      string outputPath)
    {
        static string E(string? s)
        {
            s ??= "";
            if (s.Contains(',') || s.Contains('"') || s.Contains('\n') || s.Contains('\r'))
            {
                // Fix: Use standard string replace for quotes
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

    // Apply the same fix to BuildCsvLineNew...
    private static string BuildCsvLineNew(
        LabConfig lab,
        string stepDescription,
        string logType,
        string payerPolicyFilePath,
        string claimActionMapperFilePath,
        string policyActionMapperFilePath,
        string? errorInfo,
        DateTime now,
        string outputPath)
    {
        static string E(string? s)
        {
            s ??= "";
            if (s.Contains(',') || s.Contains('"') || s.Contains('\n') || s.Contains('\r'))
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
            E(policyActionMapperFilePath),
            E(errorInfo),
            E(now.ToString("yyyy-MM-dd HH:mm:ss", CultureInfo.InvariantCulture)),
            E(outputPath)
        );
    }
}
