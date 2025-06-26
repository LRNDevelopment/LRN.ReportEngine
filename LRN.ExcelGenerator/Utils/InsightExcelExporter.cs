using ClosedXML.Excel;
using LRN.ExcelToSqlETL.Core.Models;
using System.Globalization;

public class InsightExcelExporter
{
    public static void ExportToExcel(List<InsightData> dataList, XLWorkbook wb)
    {
        var allMonths = dataList.SelectMany(x => x.MonthlyAmounts.Keys)
                                .Distinct()
                                .OrderBy(m => DateTime.ParseExact(m, "MMM yyyy", CultureInfo.InvariantCulture))
                                .ToList();

        var ws = wb.Worksheets.Add("Insight");

        int row = 1, col = 1;

        // Header
        ws.Cell(row, col++).Value = "Panel Name";
        ws.Cell(row, col++).Value = "Payer Name";
        foreach (var month in allMonths)
            ws.Cell(row, col++).Value = month;
        ws.Cell(row, col).Value = "Total";

        row++;

        // Data rows
        foreach (var data in dataList)
        {
            col = 1;
            ws.Cell(row, col++).Value = data.PanelName;
            ws.Cell(row, col++).Value = data.PayerName;

            decimal total = 0;
            foreach (var month in allMonths)
            {
                decimal value = data.MonthlyAmounts.TryGetValue(month, out var amt) ? amt : 0;
                ws.Cell(row, col++).Value = value;
                total += value;
            }

            ws.Cell(row, col).Value = total;
            row++;
        }

        ws.Columns().AdjustToContents();
    }
}
