using LRN.DataAccess.Models;
using LRN.ExcelToSqlETL.Core.Models;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace LRN.DataAccess.Repository.InterFaces
{
    public interface IReportRepository
    {
        List<LISMasterData> GetLISMasterReport(DateTime? startDate, DateTime? endDate);

        List<ProdBillingData> GetProductionDataAsync(DateTime? startDate, DateTime? endDate);
        List<InsightData> GetInsightData();
    }
}
