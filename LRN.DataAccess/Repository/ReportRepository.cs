using AutoMapper;
using LRN.DataAccess.Context;
using LRN.DataAccess.Models;
using LRN.DataAccess.Repository.InterFaces;
using LRN.ExcelToSqlETL.Core.Constants;
using LRN.ExcelToSqlETL.Core.Models;
using Microsoft.Data.SqlClient;
using Microsoft.EntityFrameworkCore;
using Microsoft.EntityFrameworkCore.Metadata.Internal;
using Microsoft.Extensions.Logging;
using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Reflection;
using System.Text;
using System.Threading.Tasks;

namespace LRN.DataAccess.Repository
{
    public class ReportRepository : IReportRepository
    {
        private readonly LRNDbContext _dbContext;
        private readonly ILogger<ImportFilesRepository> _logger;
        private readonly IMapper _mapper;

        public ReportRepository(LRNDbContext dbContext, ILogger<ImportFilesRepository> logger, IMapper mapper)
        {
            _dbContext = dbContext;
            _logger = logger;
            _mapper = mapper;
        }

        public List<LISMasterData> GetLISMasterReport(DateTime? startDate, DateTime? endDate)
        {
            try
            {
                var fromParam = new SqlParameter("@StartDate", (object?)startDate ?? DBNull.Value);
                var toParam = new SqlParameter("@EndDate", (object?)endDate ?? DBNull.Value);

                var result = _dbContext.LabResults
                    .FromSqlRaw("EXEC [sp_GetLISMasterReportByDateRange]", fromParam, toParam)
                    .ToList();

                return result.ToList();
            }
            catch (Exception ex)
            {
                throw;
            }
        }

        public static async Task<DataTable> GetDataTableFromStoredProcedureAsync(string procName, string connStr, Dictionary<string, object?> parameters)
        {
            DataTable dt = new DataTable();

            try
            {
                using (SqlConnection conn = new SqlConnection(connStr))
                using (SqlCommand command = new SqlCommand(procName, conn))
                {
                    command.CommandType = CommandType.StoredProcedure;

                    foreach (var param in parameters)
                    {
                        command.Parameters.AddWithValue(param.Key, param.Value ?? DBNull.Value);
                    }

                    await conn.OpenAsync();

                    using (SqlDataReader reader = await command.ExecuteReaderAsync())
                    {
                        dt.Load(reader);
                    }
                }
            }
            catch (Exception ex)
            {
                throw new Exception($"Error executing stored procedure '{procName}': {ex.Message}", ex);
            }

            return dt;
        }

        public List<ProdBillingData> GetProductionDataAsync(DateTime? startDate, DateTime? endDate)
        {
            try
            {
                var fromParam = new SqlParameter("@FromDate", (object?)startDate ?? DBNull.Value);
                var toParam = new SqlParameter("@ToDate", (object?)endDate ?? DBNull.Value);

                var result = _dbContext.ProdData
                    .FromSqlRaw("EXEC [sp_GetProductionReportMaster] @FromDate, @ToDate", fromParam, toParam)
                    .ToList();

                return result.ToList();
            }
            catch (Exception ex)
            {
                throw;
            }
        }
        public List<InsightData> GetInsightData()
        {
            var query = @"
            DROP TABLE IF EXISTS #tmp1;

            SELECT LISMasterId, VisitNumber, PayerName,
                FORMAT(FirstBillDate, 'MMM yyyy') AS ProductionMonth,
                SUM(BilledAmount) AS BilledAmount
            INTO #tmp1
            FROM BillingMaster b
            JOIN InsurancePayerMaster i ON b.PrimaryPayerID = i.InsurancePayerId
            WHERE FirstBillDate IS NOT NULL
            GROUP BY LISMasterId, VisitNumber, FORMAT(FirstBillDate, 'MMM yyyy'), PayerName;

            SELECT pg.PanelName, PayerName, ProductionMonth, SUM(BilledAmount) AS BilledAmount
            FROM #tmp1 t
            JOIN LISMaster l ON t.LISMasterId = l.LISMasterId
            JOIN PanelGroup pg ON l.PanelId = pg.PanelGroupId
            GROUP BY pg.PanelName, PayerName, ProductionMonth;
        ";

            var dt = new DataTable();
            using (var conn = new SqlConnection(CommonConst.DefaultConnection))
            using (var cmd = new SqlCommand(query, conn))
            using (var adapter = new SqlDataAdapter(cmd))
            {
                conn.Open();
                adapter.Fill(dt);
            }

            // Group and convert to model
            var grouped = dt.AsEnumerable()
                .GroupBy(r => new
                {
                    PanelName = r["PanelName"].ToString(),
                    PayerName = r["PayerName"].ToString()
                });

            var result = new List<InsightData>();

            foreach (var grp in grouped)
            {
                var data = new InsightData
                {
                    PanelName = grp.Key.PanelName,
                    PayerName = grp.Key.PayerName,
                    MonthlyAmounts = grp.ToDictionary(
                        r => r["ProductionMonth"].ToString(),
                        r => Convert.ToDecimal(r["BilledAmount"]))
                };

                result.Add(data);
            }

            return result;
        }

        public static List<T> ConvertDataTable<T>(DataTable dt) where T : new()
        {
            List<T> data = new List<T>();
            var properties = typeof(T).GetProperties(BindingFlags.Public | BindingFlags.Instance);

            foreach (DataRow row in dt.Rows)
            {
                T item = new T();

                foreach (var property in properties)
                {
                    if (!dt.Columns.Contains(property.Name))
                        continue;

                    object value = row[property.Name];

                    if (value == DBNull.Value)
                        continue;

                    try
                    {
                        var targetType = Nullable.GetUnderlyingType(property.PropertyType) ?? property.PropertyType;
                        var safeValue = Convert.ChangeType(value, targetType);
                        property.SetValue(item, safeValue);
                    }
                    catch (Exception ex)
                    {
                        // You can plug in a logger here
                        Console.WriteLine($"Property: {property.Name}, Value: {value}, Error: {ex.Message}");
                    }
                }

                data.Add(item);
            }

            return data;
        }


    }
}
