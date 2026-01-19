using ReportsGen;
using System.Data;

class Program
{
    static void Main()
    {
        string outputPath =
            @"C:\Reports\PCRCO_Collection_Report.xlsx";

        string templatePath =
            @"C:\Templates\PCR CO Collection Template.xlsx";

        string referenceLayoutPath =
            @"C:\Reports\PCRDx_Source_Template.xlsx";

        // Load raw data
        DataTable claimData = ExcelReportBuilder.LoadClaimData();
        DataTable lineData = ExcelReportBuilder.LoadLineData();

        // Build insights
        DataTable monthly = ExcelReportBuilder.BuildMonthlyInsights(claimData);
        DataTable weekly = ExcelReportBuilder.BuildWeeklyInsights(claimData);
        DataTable top5 = ExcelReportBuilder.BuildTop5Insights(claimData);
        DataTable avgPayments = ExcelReportBuilder.BuildAveragePayments(claimData);
        DataTable aging = ExcelReportBuilder.BuildAgingInsights(claimData);

        // Build Excel
        var builder = new ExcelReportBuilder();
        builder.Build(
            outputPath,
            claimData,
            lineData,
            monthly,
            weekly,
            top5,
            avgPayments,
            aging,
            templatePath,
            referenceLayoutPath
        );

        Console.WriteLine("✅ PCRCO Collection Report generated successfully");
    }
}
