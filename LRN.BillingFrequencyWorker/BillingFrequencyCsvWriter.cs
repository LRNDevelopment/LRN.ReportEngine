using System.Data;
using System.Globalization;
using System.Text;

public static class BillingFrequencyCsvWriter
{
    /// <summary>
    /// Writes the Billing Frequency DataTable produced by BillingGrouper.BuildBillingCounts to CSV.
    /// </summary>
    public static void Write(DataTable dt, string csvPath)
    {
        Directory.CreateDirectory(Path.GetDirectoryName(csvPath)!);

        using var fs = new FileStream(csvPath, FileMode.Create, FileAccess.Write, FileShare.Read);
        using var sw = new StreamWriter(fs, new UTF8Encoding(encoderShouldEmitUTF8Identifier: true));

        // header
        for (int i = 0; i < dt.Columns.Count; i++)
        {
            if (i > 0) sw.Write(",");
            sw.Write(Escape(dt.Columns[i].ColumnName));
        }
        sw.WriteLine();

        foreach (DataRow row in dt.Rows)
        {
            for (int i = 0; i < dt.Columns.Count; i++)
            {
                if (i > 0) sw.Write(",");

                var val = row[i];
                var text = ToText(val);
                sw.Write(Escape(text));
            }
            sw.WriteLine();
        }
    }

    private static string ToText(object? val)
    {
        if (val == null || val == DBNull.Value) return "";

        if (val is DateTime dt)
            return dt.ToString("MM/dd/yyyy", CultureInfo.InvariantCulture);

        return Convert.ToString(val, CultureInfo.InvariantCulture) ?? "";
    }

    private static string Escape(string? value)
    {
        value ??= "";
        if (value.Contains('"')) value = value.Replace("\"", "\"\"");
        if (value.Contains(',') || value.Contains('\n') || value.Contains('\r') || value.Contains('"'))
            return "\"" + value + "\"";
        return value;
    }
}
