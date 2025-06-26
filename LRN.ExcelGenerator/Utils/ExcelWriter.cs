using ClosedXML.Excel;
using Common.Logging;
using LRN.DataAccess.Repository.InterFaces;
using LRN.ExcelToSqlETL.Core.Constants;
using LRN.ExcelToSqlETL.Core.Models;
using Microsoft.Extensions.Configuration;
using System.Reflection;

namespace LRN.ExcelGenerator.Utils
{
    public class ExcelWriter
    {
        private readonly ILoggerService _logger;
        private readonly IConfiguration _config;
        private readonly IReportRepository _reportRepo;

        public ExcelWriter(
            ILoggerService logger,
            IConfiguration config,
            IReportRepository reportRepo)
        {
            _logger = logger;
            _config = config;
            _reportRepo = reportRepo;
        }

        public async Task RunAsync()
        {
            var lisMaster = _reportRepo.GetLISMasterReport(null, null);
            string filename = Path.Combine(CommonConst.DownloadFilePath, "LIS_Master_" + DateTime.Now.ToString("ddMMyyyy") + Path.GetExtension(CommonConst.LISMaster_Template));
            WriteDataToTemplate(CommonConst.LISMaster_Template, filename, lisMaster, 1);

            filename = Path.Combine(CommonConst.DownloadFilePath, "Prod_Master_" + DateTime.Now.ToString("ddMMyyyy") + Path.GetExtension(CommonConst.ProdMaster_Template));
            var prodMaster = _reportRepo.GetProductionDataAsync(null, null);
            var insightData = _reportRepo.GetInsightData();

            WriteDataToTemplate(CommonConst.ProdMaster_Template, filename, prodMaster, 1, true, insightData);
        }

        public void WriteDataToTemplate<T>(
            string templatePath,
            string outputPath,
            List<T> dataList,
            int headerRow = 1,
            bool hasInsight = false,
            List<InsightData>? insightData = null)
        {
            if (!File.Exists(templatePath))
                throw new FileNotFoundException("Template file not found.", templatePath);

            using var workbook = new XLWorkbook(templatePath);

            //if (hasInsight && insightData != null)
            //{
            //    InsightExcelExporter.ExportToExcel(insightData, workbook);
            //}

            var worksheet = workbook.Worksheets.First();

            var headerColumns = worksheet.Row(headerRow)
                                         .Cells()
                                         .Where(c => !string.IsNullOrWhiteSpace(c.GetString()))
                                         .ToList();

            var propertyMap = typeof(T)
                .GetProperties(BindingFlags.Public | BindingFlags.Instance)
                .Select(p =>
                {
                    var attr = p.GetCustomAttribute<PropertyNameAttribute>();
                    return new
                    {
                        Property = p,
                        AttributeName = attr?.ColumnName?.Trim(),
                        PropertyType = attr?.PropertyType?.Trim()
                    };
                })
                .Where(x => !string.IsNullOrWhiteSpace(x.AttributeName))
                .ToDictionary(x => x.AttributeName!, x => (x.Property, x.PropertyType), StringComparer.OrdinalIgnoreCase);

            int currentRow = headerRow + 1;

            foreach (var item in dataList)
            {
                for (int i = 0; i < headerColumns.Count; i++)
                {
                    var columnHeader = headerColumns[i].GetString().Trim();
                    if (propertyMap.TryGetValue(columnHeader, out var propInfoPair))
                    {
                        var (propInfo, propertyType) = propInfoPair;
                        var cell = worksheet.Cell(currentRow, i + 1);
                        var value = propInfo.GetValue(item);

                        if (value == null)
                        {
                            cell.Value = string.Empty;
                        }
                        else if (value is DateTime dtValue)
                        {
                            cell.Value = dtValue;
                            cell.Style.DateFormat.Format = "yyyy-mm-dd";
                        }
                        else if (value is DateOnly dtoValue)
                        {
                            cell.Value = new DateTime(dtoValue.Year, dtoValue.Month, dtoValue.Day);
                            cell.Style.DateFormat.Format = "yyyy-mm-dd";
                        }
                        else if (value is decimal decimalValue)
                        {
                            cell.Value = decimalValue;

                            if (string.Equals(propertyType, "Currency", StringComparison.OrdinalIgnoreCase))
                            {
                                cell.Style.NumberFormat.Format = "_($* #,##0.00_);_($* (#,##0.00);_($* \"-\"??_);_(@_)";
                            }
                        }
                        else
                        {
                            cell.Value = value.ToString();
                        }

                        // Styling
                        cell.Style.Font.FontName = "Aptos Narrow";
                        cell.Style.Font.FontSize = 9;
                    }
                }

                currentRow++;
            }

            worksheet.Columns().AdjustToContents();
            workbook.SaveAs(outputPath);
        }
    }
}
