using Common.Logging;
using LRN.ExcelToSqlETL.Core.Interface;
using LRN.ExcelToSqlETL.Core.Models;
using Microsoft.Extensions.Configuration;
using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace LRN.ExcelETL.Service.Services
{
    public class SqlDataImporter : IDataImporter
    {
        private readonly string _connectionString;
        private static ILoggerService _logger = new LogManagerService();
        private static List<FileLog> ImportLog = new List<FileLog>();
        public SqlDataImporter(IConfiguration config)
        {
            _connectionString = config.GetConnectionString("DefaultConnection");
        }

        public async Task ImportAsync(DataTable data, string tableName, int fileId)
        {
            try
            {
                using (var conn = new SqlConnection(_connectionString))
                {
                    await conn.OpenAsync();

                    using var bulkCopy = new SqlBulkCopy(conn)
                    {
                        DestinationTableName = tableName
                    };

                    foreach (DataColumn column in data.Columns)
                    {
                        bulkCopy.ColumnMappings.Add(column.ColumnName, column.ColumnName);
                    }

                    await bulkCopy.WriteToServerAsync(data);
                }
            }
            catch (Exception ex)
            {
                ImportLog.Add(new FileLog { FileId = fileId, LogType = "Error", LogMessage = "Error Occured on SqlDataImporter - ImportAsync : " + ex.ToString() });

                _logger.Error("Error Occured on SqlDataImporter - ImportAsync : " + ex.ToString());
                throw;
            }

        }
    }
}