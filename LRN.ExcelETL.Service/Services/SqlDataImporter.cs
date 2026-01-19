using Common.Logging;
using LRN.ExcelToSqlETL.Core.Constants;
using LRN.ExcelToSqlETL.Core.Interface;
using LRN.ExcelToSqlETL.Core.Models;
using Microsoft.Extensions.Configuration;
using System;
using System.Data;
using System.Data;
using System.Data.SqlClient;

namespace LRN.ExcelETL.Service.Services
{
    public class SqlDataImporter : IDataImporter
    {
        private readonly string _connectionString;
        private static readonly ILoggerService _logger = new LogManagerService();

        public SqlDataImporter(IConfiguration config)
        {
            _connectionString = config.GetConnectionString("DefaultConnection");
        }

        public async Task ImportAsync(DataTable data, string tableName, int fileId)
        {
            try
            {
                CleanCurrencyColumns(data);

                using var conn = new SqlConnection(_connectionString);
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

                await ProcessStagingData(fileId);
            }
            catch (Exception ex)
            {
                // Do NOT log here to avoid duplicate logging (processor will log once)
                throw new Exception($"SqlDataImporter.ImportAsync failed for fileId={fileId}, table={tableName}.", ex);
            }
        }

        //private async Task ProcessStagingData(int fileId)
        //{
        //    using var conn = new SqlConnection(_connectionString);
        //    await conn.OpenAsync();

        //    // Determine file type and name for correct stored proc routing
        //    const string fileInfoQuery = @"SELECT FileType, ImportFileName FROM ImportedFiles WHERE ImportedFileID = @FileId";

        //    string fileName = "";
        //    int fileTypeValue = -1;

        //    using (var checkCmd = new SqlCommand(fileInfoQuery, conn))
        //    {
        //        checkCmd.Parameters.AddWithValue("@FileId", fileId);

        //        using var reader = await checkCmd.ExecuteReaderAsync();
        //        if (await reader.ReadAsync())
        //        {
        //            fileTypeValue = reader.GetInt32(0);
        //            fileName = reader.GetString(1);
        //        }
        //        else
        //        {
        //            throw new Exception($"File ID {fileId} not found in ImportedFiles table");
        //        }
        //    }

        //    // Execute the appropriate stored procedure based on file type
        //    if (fileTypeValue == (int)LRN.ExcelToSqlETL.Core.Constants.CommonConst.ImportFileType.Custom_Collection)
        //    {
        //        using var cmd = new SqlCommand("sp_ProcessCustomCollectionData", conn);
        //        cmd.CommandType = CommandType.StoredProcedure;
        //        cmd.Parameters.AddWithValue("@ImportedFileID", fileId);
        //        await cmd.ExecuteNonQueryAsync();
        //        _logger.Info($"Processing Custom Collection file: {fileName} (ID: {fileId})");
        //    }
        //    else if (fileTypeValue == (int)LRN.ExcelToSqlETL.Core.Constants.CommonConst.ImportFileType.IATLISFile)
        //    {
        //        using var cmd = new SqlCommand("usp_SyncLISIATStagingData", conn);
        //        cmd.CommandType = CommandType.StoredProcedure;
        //        cmd.Parameters.AddWithValue("@FileId", fileId);
        //        await cmd.ExecuteNonQueryAsync();
        //        _logger.Info($"Processing standard file: {fileName} (ID: {fileId})");
        //    }
        //    else if (fileTypeValue == (int)LRN.ExcelToSqlETL.Core.Constants.CommonConst.ImportFileType.Transaction_Detail_Report)
        //    {
        //        using var cmd = new SqlCommand("sp_ProcessTransactionDetailData", conn);
        //        cmd.CommandType = CommandType.StoredProcedure;
        //        cmd.Parameters.AddWithValue("@ImportedFileID", fileId);
        //        await cmd.ExecuteNonQueryAsync();
        //        _logger.Info($"Processing Transaction file: {fileName} (ID: {fileId})");
        //    }
        //    else if (fileTypeValue == (int)LRN.ExcelToSqlETL.Core.Constants.CommonConst.ImportFileType.PCRCO_LIS)
        //    {
        //        using var cmd = new SqlCommand("sp_ProcessPCRCORawToStaging", conn);
        //        cmd.CommandType = CommandType.StoredProcedure;
        //        cmd.Parameters.AddWithValue("@ImportedFileID", fileId);
        //        await cmd.ExecuteNonQueryAsync();
        //        _logger.Info($"Processing PCRCO file: {fileName} (ID: {fileId})");
        //    }
        //    else
        //    {
        //        _logger.Info($"Skipped RAW→Staging step (no proc configured). File: {fileName} (ID: {fileId})");
        //    }
        //}
        private async Task ProcessStagingData(int fileId)
        {
            using (var conn = new SqlConnection(_connectionString))
            {
                await conn.OpenAsync();

                try
                {
                    // First, check the file type and name for better logging
                    string fileInfoQuery = @"SELECT FileType, ImportFileName FROM ImportedFiles WHERE ImportedFileID = @FileId";
                    string fileName = "";
                    int fileTypeValue = -1;

                    using (var checkCmd = new SqlCommand(fileInfoQuery, conn))
                    {
                        checkCmd.Parameters.AddWithValue("@FileId", fileId);

                        using (var reader = await checkCmd.ExecuteReaderAsync())
                        {
                            if (await reader.ReadAsync())
                            {
                                fileTypeValue = reader.GetInt32(0);
                                fileName = reader.GetString(1);
                            }
                            else
                            {
                                throw new Exception($"File ID {fileId} not found in ImportedFiles table");
                            }
                        }
                    }


                    if (fileTypeValue == (int)CommonConst.ImportFileType.Custom_Collection)
                    {
                        using var cmd = new SqlCommand("sp_ProcessCustomCollectionData", conn);
                        // using var cmd = new SqlCommand("sp_ProcessCustomCollectionData_test", conn);

                        cmd.CommandType = CommandType.StoredProcedure;
                        cmd.Parameters.AddWithValue("@ImportedFileID", fileId);
                        await cmd.ExecuteNonQueryAsync();
                        _logger.Info($"Processing Custom Collection file: {fileName} (ID: {fileId})");
                    }
                    else if (fileTypeValue == (int)CommonConst.ImportFileType.IATLISFile)
                    {

                        using var cmd = new SqlCommand("usp_SyncLISIATStagingData", conn);
                        cmd.CommandType = CommandType.StoredProcedure;
                        cmd.Parameters.AddWithValue("@FileId", fileId);
                        await cmd.ExecuteNonQueryAsync();

                        _logger.Info($"Processing standard file: {fileName} (ID: {fileId})");
                    }
                    else if (fileTypeValue == (int)CommonConst.ImportFileType.Transaction_Detail_Report)
                    {

                        using var cmd = new SqlCommand("sp_ProcessTransactionDetailData", conn);
                        cmd.CommandType = CommandType.StoredProcedure;
                        cmd.Parameters.AddWithValue("@ImportedFileID", fileId);
                        await cmd.ExecuteNonQueryAsync();

                        _logger.Info($"Processing Transaction file: {fileName} (ID: {fileId})");
                    }
                    else if (fileTypeValue == (int)CommonConst.ImportFileType.PCRCO_LIS)
                    {

                        using var cmd = new SqlCommand("sp_ProcessPCRCORawToStaging", conn);
                        cmd.CommandType = CommandType.StoredProcedure;
                        cmd.Parameters.AddWithValue("@ImportedFileID", fileId);
                        await cmd.ExecuteNonQueryAsync();

                        _logger.Info($"Processing Transaction file: {fileName} (ID: {fileId})");
                    }
                    else if (fileTypeValue == (int)CommonConst.ImportFileType.Supplement_LIS_Stagging)
                    {

                        using var cmd = new SqlCommand("sp_ProcessSupplimentLISStagingData", conn);
                        cmd.CommandType = CommandType.StoredProcedure;
                        cmd.Parameters.AddWithValue("@ImportedFileID", fileId);
                        await cmd.ExecuteNonQueryAsync();

                        _logger.Info($"Processing Transaction file: {fileName} (ID: {fileId})");
                    }
                    else
                    {
                        _logger.Info($"Skipped the RAW to Staging -- All data inserted to Staging: {fileName} (ID: {fileId})");
                    }

                    // Execute the appropriate stored procedure


                    //_logger.Info($"Successfully executed {storedProcedureName} for file ID: {fileId}");


                }
                catch (Exception ex)
                {
                    _logger.Info($"Error processing staging data for file ID {fileId}: {ex.Message}");
                    throw;
                }
            }
        }
        // Keep this lightweight: just strip $ and commas (do NOT log here)
        private static void CleanCurrencyColumns(DataTable data)
        {
            string[] currencyColumns = {
                "BilledAmount", "AllowedAmount", "InsurancePayments", "InsuranceAdjustments",
                "PatientPayments", "PatientAdjustments", "InsuranceBalance", "PatientBalance", "TotalBalance"
            };

            foreach (DataRow row in data.Rows)
            {
                foreach (string columnName in currencyColumns)
                {
                    if (!data.Columns.Contains(columnName) || row[columnName] == DBNull.Value)
                        continue;

                    var value = row[columnName]?.ToString();
                    if (string.IsNullOrWhiteSpace(value))
                    {
                        row[columnName] = DBNull.Value;
                        continue;
                    }

                    row[columnName] = value.Replace("$", "").Replace(",", "").Trim();
                }
            }
        }
    }
}
