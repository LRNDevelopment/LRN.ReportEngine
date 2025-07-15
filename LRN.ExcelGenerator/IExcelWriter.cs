using ClosedXML.Excel;
using LRN.ExcelToSqlETL.Core.Models;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace LRN.ExcelGenerator
{
    public interface IExcelWriter
    {
        Task<XLWorkbook> GetReport<T>(string templatePath,
      string outputPath,
      List<T> dataList,
      int headerRow = 1,
      bool hasInsight = false,
      List<InsightData>? insightData = null,
      bool hasLineLevel = false,
      IEnumerable<object>? lineLevel = null);
    }
}
