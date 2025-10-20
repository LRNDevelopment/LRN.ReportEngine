using Common.Logging;
using LRN.DataLibrary.Models;
using LRN.ExcelToSqlETL.Core.Constants;
using LRN.ExcelToSqlETL.Core.Interface;
using LRN.ExcelToSqlETL.Core.Models;
using Microsoft.Extensions.Configuration;
using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Globalization;
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
                CleanCurrencyColumns(data);
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
                
                await ProcessStagingData(fileId);
            }
            catch (Exception ex)
            {
                ImportLog.Add(new FileLog { ImportFileId = fileId, LogType = "Error", LogMessage = "Error Occured on SqlDataImporter - ImportAsync : " + ex.ToString() });

                _logger.Error("Error Occured on SqlDataImporter - ImportAsync : " + ex.ToString());
                throw;
            }

        }


        //private async Task ProcessStagingData(int fileId)
        //{
        //    using (var conn = new SqlConnection(_connectionString))
        //    {
        //        await conn.OpenAsync();

        //        //using var cmd = new SqlCommand("usp_ProcessDiagnoseLISStaging", conn);
        //        using var cmd = new SqlCommand("usp_SyncLISIATStagingData", conn);


        //        cmd.CommandType = CommandType.StoredProcedure;
        //        cmd.Parameters.AddWithValue("@FileId", fileId);

        //        await cmd.ExecuteNonQueryAsync();
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

                    

                    else
                    {
                        _logger.Info($"Skipped the RAW to Staging -- All data inserted to Staging: {fileName} (ID: {fileId})");
                    }

                    // Execute the appropriate stored procedure


                    //_logger.Info($"Successfully executed {storedProcedureName} for file ID: {fileId}");


                }
                catch (Exception ex)
                {
                    _logger.Error($"Error processing staging data for file ID {fileId}: {ex.Message}");
                    throw;
                }
            }
        }

        // The full, corrected and improved method
        private void CleanCurrencyColumns(DataTable data)
        {
            // List of columns that contain currency values
            string[] currencyColumns = {
                "BilledAmount", "AllowedAmount", "InsurancePayments", "InsuranceAdjustments",
                "PatientPayments", "PatientAdjustments", "InsuranceBalance", "PatientBalance", "TotalBalance"
            };

            // Use InvariantCulture to handle standard number formats regardless of system settings
            var invariantCulture = System.Globalization.CultureInfo.InvariantCulture;

            foreach (DataRow row in data.Rows)
            {
                foreach (string columnName in currencyColumns)
                {
                    // Check if column exists and the value is not null
                    if (data.Columns.Contains(columnName) && row[columnName] != DBNull.Value)
                    {
                        string value = row[columnName].ToString();

                        decimal decimalValue;
                        if (value != null)
                        {
                            string cleanedValue = value.Replace("$", "").Replace(",", "").Trim();
                            row[columnName] = cleanedValue;
                            //// Use a more robust TryParse with NumberStyles.Any to handle various formats
                            //if (decimal.TryParse(cleanedValue, System.Globalization.NumberStyles.Any, invariantCulture, out decimalValue))
                            //{
                            //    row[columnName] = decimalValue;
                            //}
                            //else
                            //{
                            //    // If parsing fails, set to DBNull and log the error.
                            //    string errorMessage = $"Failed to parse '{value}' in column '{columnName}'. Setting to NULL.";
                            //    // Assuming ImportLog is accessible and correctly implemented.
                            //    // Note: The original code's log had a hardcoded FileId of 1, adjust as needed.
                            //    ImportLog.Add(new FileLog { ImportFileId = 1, LogType = "Error", LogMessage = errorMessage });
                            //    row[columnName] = DBNull.Value;
                            //}
                        }

                    }
                    // No else block is needed here as we only care about existing columns.
                }
            }
        }

        //private void CleanCurrencyColumns(DataTable data)
        //{
        //    // List of columns that contain currency values
        //    string[] currencyColumns = {
        //        //"TotalCharge", "TotalAllowed", "CarrierPayment", "CarrierWO",
        //        //"PatientPayment", "PatientWO", "CarrierBalance", "PatientBalance", "TotalBalance",
        //        "BilledAmount","AllowedAmount","InsurancePayments","InsuranceAdjustments","PatientPayments",
        //        "PatientAdjustments","InsuranceBalance","PatientBalance","TotalBalance"


        //    };

        //    foreach (DataRow row in data.Rows)
        //    {
        //        foreach (string columnName in currencyColumns)
        //        {

        //            if (data.Columns.Contains(columnName) && !row.IsNull(columnName))
        //            {
        //                string value = row[columnName].ToString();

        //                // Remove currency symbols, commas, and trim whitespace
        //                string cleanedValue = value.Replace("$", "").Replace(",", "").Trim();

        //                // Handle empty strings
        //                if (string.IsNullOrEmpty(cleanedValue))
        //                {
        //                    row[columnName] = DBNull.Value;
        //                }
        //                else if (decimal.TryParse(cleanedValue, out decimal decimalValue))
        //                {
        //                    row[columnName] = decimalValue;
        //                }
        //                else
        //                {
        //                    // If parsing fails, set to null
        //                    row[columnName] = DBNull.Value;
        //                }
        //            }
        //            else
        //            {

        //                ImportLog.Add(new FileLog { ImportFileId = 1, LogType = "Info", LogMessage = row[columnName].ToString() });
        //            }
        //        }
        //    }
        //}


    }
}