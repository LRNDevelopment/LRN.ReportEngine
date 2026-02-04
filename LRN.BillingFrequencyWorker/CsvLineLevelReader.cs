using Microsoft.VisualBasic.FileIO;
using System.Globalization;

public static class CsvLineLevelReader
{
    // Reads the CSV exported from the LineLevel sheet and returns BillingLineRow list.
    public static List<BillingLineRow> ReadLineLevelRows(string csvPath, int headerRow)
    {
        if (!File.Exists(csvPath))
            throw new FileNotFoundException("CSV not found", csvPath);

        using var parser = new TextFieldParser(csvPath)
        {
            TextFieldType = FieldType.Delimited,
            HasFieldsEnclosedInQuotes = true,
            TrimWhiteSpace = false
        };
        parser.SetDelimiters(",");

        // Skip to header row
        string[]? header = null;
        for (int i = 1; i <= headerRow; i++)
        {
            if (parser.EndOfData) break;
            header = parser.ReadFields();
        }

        if (header == null || header.Length == 0)
            throw new InvalidOperationException($"Header row not found in CSV: {csvPath}");

        int cChart = FindCol(header, "ChartNumber", "PatientId", "Patient ID", "Chart #", "Chart Number");
        int cPay = FindCol(header, "PanelCarrier", "Payer", "Carrier", "PayerName", "PayerName_Raw", "Insurance Name", "Panel Carrier");
        int cCpt = FindCol(header, "CPTCode", "CPT", "Panel", "CPT Code");
        int cVisit = FindCol(header, "VisitNumber", "BillingNumber", "Billing #", "Visit #", "VisitNumber", "ClaimID", "VisitNum");
        int cDos = FindCol(header, "BeginDOS", "DateOfService", "DateofService", "DOS", "Date Of Service", "Begin DOS", "Service From Date");

        if (cChart < 0 || cVisit < 0 || cDos < 0)
            throw new InvalidOperationException($"Missing required columns in CSV header. Chart={cChart}, Visit={cVisit}, DOS={cDos}");

        var rows = new List<BillingLineRow>();

        while (!parser.EndOfData)
        {
            var fields = parser.ReadFields();
            if (fields == null || fields.Length == 0) continue;

            string chart = Get(fields, cChart);
            string visit = Get(fields, cVisit);

            if (string.IsNullOrWhiteSpace(chart) || string.IsNullOrWhiteSpace(visit))
                continue;

            string payer = cPay >= 0 ? Get(fields, cPay) : "";
            string cpt = cCpt >= 0 ? Get(fields, cCpt) : "";
            string dosText = Get(fields, cDos);

            var dos = ParseDate(dosText);

            rows.Add(new BillingLineRow
            {
                ChartNumber = chart.Trim(),
                VisitNumber = visit.Trim(),
                PanelCarrier = payer.Trim(),
                CPTCode = cpt.Trim(),
                BeginDOS = dos.Date
            });
        }

        return rows;
    }

    private static int FindCol(string[] header, params string[] names)
    {
        for (int i = 0; i < header.Length; i++)
        {
            var h = (header[i] ?? "").Trim();
            foreach (var n in names)
                if (h.Equals(n, StringComparison.OrdinalIgnoreCase))
                    return i;
        }
        return -1;
    }

    private static string Get(string[] fields, int index)
        => index >= 0 && index < fields.Length ? (fields[index] ?? "") : "";

    private static DateTime ParseDate(string s)
    {
        s = (s ?? "").Trim();
        if (string.IsNullOrWhiteSpace(s))
            throw new InvalidOperationException("DOS is blank.");

        // ExcelCsvExporter emits yyyy-MM-dd HH:mm:ss for DateTime; allow that too.
        var formats = new[]
        {
            "yyyy-MM-dd HH:mm:ss",
            "yyyy-MM-dd","yyyy/MM/dd",
            "dd/MM/yyyy","d/M/yyyy",
            "MM/dd/yyyy","M/d/yyyy",
            "dd-MM-yyyy","d-M-yyyy",
            "MM-dd-yyyy","M-d-yyyy"
        };

        if (DateTime.TryParseExact(s, formats, CultureInfo.InvariantCulture, DateTimeStyles.None, out var dt))
            return dt;

        if (DateTime.TryParse(s, new CultureInfo("en-SG"), DateTimeStyles.None, out dt))
            return dt;

        if (DateTime.TryParse(s, CultureInfo.InvariantCulture, DateTimeStyles.None, out dt))
            return dt;

        throw new InvalidOperationException($"Invalid DOS: '{s}'");
    }
}
