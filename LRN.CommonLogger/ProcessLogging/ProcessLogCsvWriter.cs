using System.Text;

namespace Common.Logging.ProcessLogging;

public sealed class ProcessLogCsvWriter
{
    public static void EnsureHeaders(string path, IReadOnlyList<string> headers)
    {
        Directory.CreateDirectory(Path.GetDirectoryName(path) ?? AppContext.BaseDirectory);
        if (File.Exists(path)) return;

        using var sw = new StreamWriter(path, false, new UTF8Encoding(false));
        sw.WriteLine(string.Join(',', headers.Select(Escape)));
    }

    public static void AppendRow(string path, IReadOnlyList<string> headers, IReadOnlyDictionary<string, string?> row)
    {
        EnsureHeaders(path, headers);

        using var sw = new StreamWriter(path, append: true, new UTF8Encoding(false));
        var line = string.Join(',', headers.Select(h => Escape(row.TryGetValue(h, out var v) ? v : null)));
        sw.WriteLine(line);
    }

    private static string Escape(string? value)
    {
        value ??= string.Empty;
        var mustQuote = value.Contains(',') || value.Contains('"') || value.Contains('\n') || value.Contains('\r');
        if (!mustQuote) return value;
        return "\"" + value.Replace("\"", "\"\"") + "\"";
    }
}
