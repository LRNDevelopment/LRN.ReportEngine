
using System.Globalization;
using System.Text;

public static class FileStatusLogCsv
{
    // Matches the sample header exactly (including spaces/typos)
    private const string Header = "Lab Id ,labname ,importede date,imported time,Filename,Status ,Output location,Log";

    public static string Write(
        string folder,
        int labId,
        string labName,
        DateTime importedLocal,
        string fileName,
        string status,
        string outputLocation,
        string logMessage)
    {
        Directory.CreateDirectory(folder);

        var safeFile = SanitizeFileName(Path.GetFileNameWithoutExtension(fileName));
        var path = Path.Combine(folder, $"filestatus_{labId}_{safeFile}_{importedLocal:yyyyMMdd_HHmmss}.csv");

        using var sw = new StreamWriter(path, false, new UTF8Encoding(encoderShouldEmitUTF8Identifier: true));
        sw.WriteLine(Header);

        var date = importedLocal.ToString("MM/dd/yyyy", CultureInfo.InvariantCulture);
        var time = importedLocal.ToString("HH:mm", CultureInfo.InvariantCulture);

        sw.WriteLine(string.Join(",",
            labId.ToString(CultureInfo.InvariantCulture),
            Escape(labName),
            date,
            time,
            Escape(fileName),
            Escape(status),
            Escape(outputLocation),
            Escape(logMessage)));

        return path;
    }

    private static string Escape(string? s)
    {
        if (string.IsNullOrEmpty(s)) return "";
        bool mustQuote = s.Contains(',') || s.Contains('"') || s.Contains('\n') || s.Contains('\r');
        if (!mustQuote) return s;
        return $"\"{s.Replace("\"", "\"\"")}\"";
    }

    private static string SanitizeFileName(string s)
    {
        foreach (var c in Path.GetInvalidFileNameChars())
            s = s.Replace(c, '_');
        return s;
    }
}
