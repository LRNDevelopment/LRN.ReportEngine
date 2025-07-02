using ClosedXML.Excel;
using Common.Logging;
using LRN.DataLibrary.Repository.Interfaces;
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
            string filename = Path.Combine(CommonConst.DownloadFilePath, $"LIS_Master_{DateTime.Now:ddMMyyyy}{Path.GetExtension(CommonConst.LISMaster_Template)}");
            WriteDataToTemplate(CommonConst.LISMaster_Template, filename, lisMaster);

            var prodMaster = _reportRepo.GetProductionDataAsync(null, null);
            var lineLevelReport = _reportRepo.GetProdLineLevelAsync(null, null);
            filename = Path.Combine(CommonConst.DownloadFilePath, $"Prod_Master_{DateTime.Now:ddMMyyyy}{Path.GetExtension(CommonConst.ProdMaster_Template)}");

            WriteDataToTemplate(
                templatePath: CommonConst.ProdMaster_Template,
                outputPath: filename,
                dataList: prodMaster,
                headerRow: 1,
                hasInsight: false,
                insightData: null,
                hasLineLevel: true,
                lineLevel: lineLevelReport
            );

            var collectData = _reportRepo.GetCollectionDateByDateAsync(null, null);
            filename = Path.Combine(CommonConst.DownloadFilePath, $"Collection_{DateTime.Now:ddMMyyyy}{Path.GetExtension(CommonConst.CollectionTemplate)}");
            WriteDataToTemplate(CommonConst.CollectionTemplate, filename, collectData);
        }


        public void WriteDataToTemplate<T>(
      string templatePath,
      string outputPath,
      List<T> dataList,
      int headerRow = 1,
      bool hasInsight = false,
      List<InsightData>? insightData = null,
      bool hasLineLevel = false,
      IEnumerable<object>? lineLevel = null)
        {
            if (!File.Exists(templatePath))
                throw new FileNotFoundException("Template file not found.", templatePath);

            using var workbook = new XLWorkbook(templatePath);

            if (hasLineLevel && lineLevel != null)
            {
                var lineLevelList = ((IEnumerable<object>)lineLevel).ToList();
                if (lineLevelList.Any())
                {
                    var lineType = lineLevelList.First().GetType();
                    var listType = typeof(List<>).MakeGenericType(lineType);
                    var typedList = Activator.CreateInstance(listType)!;

                    var addMethod = listType.GetMethod("Add")!;
                    foreach (var item in lineLevelList)
                    {
                        addMethod.Invoke(typedList, new[] { item });
                    }

                    var method = typeof(ExcelWriter)
                        .GetMethod(nameof(WriteDataToExcel))!
                        .MakeGenericMethod(lineType);

                    method.Invoke(this, new object[] { workbook, headerRow, typedList, "Prod Line Level Report" });
                }
            }


            WriteDataToExcel(workbook, headerRow, dataList);
            workbook.SaveAs(outputPath);
        }



        public void WriteDataToExcel<T>(XLWorkbook xlWorkbook, int headerRow, List<T> dataList, string? sheetName = null)
        {
            var worksheet = string.IsNullOrWhiteSpace(sheetName)
                ? xlWorkbook.Worksheets.First()
                : xlWorkbook.Worksheet(sheetName);

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
                    if (!propertyMap.TryGetValue(columnHeader, out var propInfoPair)) continue;

                    var (propInfo, propertyType) = propInfoPair;
                    var cell = worksheet.Cell(currentRow, i + 1);
                    var value = propInfo.GetValue(item);

                    switch (value)
                    {
                        case null:
                            cell.Value = string.Empty;
                            break;
                        case DateTime dtValue:
                            cell.Value = dtValue;
                            cell.Style.DateFormat.Format = "yyyy-mm-dd";
                            break;
                        case DateOnly dtoValue:
                            cell.Value = new DateTime(dtoValue.Year, dtoValue.Month, dtoValue.Day);
                            cell.Style.DateFormat.Format = "yyyy-mm-dd";
                            break;
                        case decimal decimalValue:
                            cell.Value = decimalValue;
                            if (string.Equals(propertyType, "Currency", StringComparison.OrdinalIgnoreCase))
                            {
                                cell.Style.NumberFormat.Format = "_($* #,##0.00_);_($* (#,##0.00);_($* \"-\"??_);_(@_)";
                            }
                            break;
                        default:
                            cell.Value = value.ToString();
                            break;
                    }

                    cell.Style.Font.FontName = "Aptos Narrow";
                    cell.Style.Font.FontSize = 9;
                }

                currentRow++;
            }

            worksheet.Columns().AdjustToContents();
        }
    }
}
