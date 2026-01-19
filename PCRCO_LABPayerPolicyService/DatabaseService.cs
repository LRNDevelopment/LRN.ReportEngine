using System;
using System.Collections.Generic;
using System.Data;
using Microsoft.Data.SqlClient;

namespace PCRCO_LABPayerPolicyService
{
    public class DatabaseService
    {
        
        private readonly string _connectionString;
        private readonly string _logFolder;

        public DatabaseService(string connectionString)
        {
            _connectionString = connectionString;
            _logFolder = Path.Combine(AppContext.BaseDirectory, "DatabaseLogs");

            // Create log folder if it doesn't exist
            if (!Directory.Exists(_logFolder))
            {
                Directory.CreateDirectory(_logFolder);
            }
        }

        // In DatabaseService.cs
        public (int ReportID, string ReportServerPath) GetReportInfo(int reportType, int reportStatus)
        {
            using (var connection = new SqlConnection(_connectionString))
            {
                connection.Open();
                using (var command = new SqlCommand("sp_GetReportStatusInfo", connection))
                {
                    command.CommandType = CommandType.StoredProcedure;
                    command.Parameters.AddWithValue("@ReportType", reportType);
                    command.Parameters.AddWithValue("@ReportStatus", reportStatus);

                    using (var reader = command.ExecuteReader())
                    {
                        if (reader.Read())
                        {
                            int reportID = reader.GetInt32(reader.GetOrdinal("ReportID"));
                            string reportServerPath = reader.GetString(reader.GetOrdinal("ReportServerPath"));
                            return (reportID, reportServerPath);
                        }
                    }
                }
            }
            return (0, null);
        }
        private void LogDatabaseOperation(string operation, string status, string message)
        {
            try
            {
                string logFile = Path.Combine(_logFolder, $"DatabaseOperations_{DateTime.Now:yyyyMMdd}.log");
                string logEntry = $"[{DateTime.Now:yyyy-MM-dd HH:mm:ss}] [{operation}] [{status}] {message}";
                File.AppendAllText(logFile, logEntry + Environment.NewLine);
            }
            catch
            {
                // Silent fail for logging
            }
        }

        public bool CheckReportStatus(int reportType, int reportStatus)
        {
            try
            {
                using (var connection = new SqlConnection(_connectionString))
                {
                    connection.Open();

                    using (var command = new SqlCommand("sp_GetReportStatusInfo", connection))
                    {
                        command.CommandType = CommandType.StoredProcedure;
                        command.Parameters.AddWithValue("@ReportType", reportType);
                        command.Parameters.AddWithValue("@ReportStatus", reportStatus);

                        using (var reader = command.ExecuteReader())
                        {
                            if (reader.Read())
                            {
                                var hasReport = Convert.ToBoolean(reader["HasReport"]);
                                LogDatabaseOperation("CheckReportStatus", "SUCCESS",
                                   $"ReportType={reportType}, Status={reportStatus}, Result={hasReport}");
                                return hasReport;
                            }
                        }
                    }
                }
                return false;
            }
            catch (Exception ex)
            {
                Console.WriteLine($"Error checking report status: {ex.Message}");
                LogDatabaseOperation("CheckReportStatus", "ERROR",
                   $"ReportType={reportType}, Status={reportStatus}, Error={ex.Message}");
                throw;
            }
        }



        public string GetReportServerPath(int reportType, int reportStatus)
        {
            try
            {
                using (var connection = new SqlConnection(_connectionString))
                {
                    connection.Open();

                    using (var command = new SqlCommand("sp_GetReportStatusInfo", connection))
                    {
                        command.CommandType = CommandType.StoredProcedure;
                        command.Parameters.AddWithValue("@ReportType", reportType);
                        command.Parameters.AddWithValue("@ReportStatus", reportStatus);

                        using (var reader = command.ExecuteReader())
                        {
                            if (reader.Read())
                            {
                                return reader["ReportServerPath"]?.ToString() ?? string.Empty;
                            }
                        }
                    }
                }
                return string.Empty;
            }
            catch (Exception ex)
            {
                LogDatabaseOperation("GetReportServerPath", "ERROR",
                     $"ReportType={reportType}, Status={reportStatus}, Error={ex.Message}");
                throw;
            }
        }


        public List<PayerInfo> GetPayerInfoFromCOInsuranceMaster(List<string> payerNames)
        {
            var payerInfos = new List<PayerInfo>();

            if (payerNames == null || !payerNames.Any())
                return payerInfos;

            try
            {
                using (var connection = new SqlConnection(_connectionString))
                {
                    connection.Open();

                    using (var command = new SqlCommand("sp_GetPayerInfoByNames", connection))
                    {
                        command.CommandType = CommandType.StoredProcedure;
                        command.Parameters.AddWithValue("@PayerNames", string.Join(",", payerNames));

                        using (var reader = command.ExecuteReader())
                        {
                            while (reader.Read())
                            {
                                var payerInfo = new PayerInfo
                                {
                                    GlobalPayerID = reader["Global_Payer_ID"]?.ToString() ?? "",
                                    PayerName = reader["PayerName"]?.ToString() ?? "",
                                    PayerShortCode = reader["PayerShortCode"]?.ToString() ?? ""
                                };

                                payerInfos.Add(payerInfo);
                            }
                        }
                    }
                }

                LogDatabaseOperation("GetPayerInfoFromCOInsuranceMaster", "SUCCESS",
                    $"Retrieved {payerInfos.Count} payer mappings for {payerNames.Count} payer names");
            }
            catch (Exception ex)
            {
                LogDatabaseOperation("GetPayerInfoFromCOInsuranceMaster", "ERROR",
                    $"Error: {ex.Message}");
                throw;
            }

            return payerInfos;
        }


        public string GetICD10CodeFromLISMaster(string accessionNo)
        {
            if (string.IsNullOrEmpty(accessionNo))
                return string.Empty;

            try
            {
                using (var connection = new SqlConnection(_connectionString))
                {
                    connection.Open();

                    using (var command = new SqlCommand("sp_GetICD10CodeByAccession", connection))
                    {
                        command.CommandType = CommandType.StoredProcedure;
                        command.Parameters.AddWithValue("@AccessionNo", accessionNo);

                        var result = command.ExecuteScalar();
                        return result?.ToString() ?? string.Empty;
                    }
                }
            }
            catch (Exception ex)
            {
                LogDatabaseOperation("GetICD10CodeFromLISMaster", "ERROR",
                    $"AccessionNo={accessionNo}, Error={ex.Message}");
                return string.Empty;
            }
        }

        public Dictionary<string, string> GetICD10CodesFromLISMaster(List<string> accessionNos)
        {
            var results = new Dictionary<string, string>();

            if (accessionNos == null || !accessionNos.Any())
                return results;

            try
            {
                using (var connection = new SqlConnection(_connectionString))
                {
                    connection.Open();

                    using (var command = new SqlCommand("sp_GetICD10CodesByAccessions", connection))
                    {
                        command.CommandType = CommandType.StoredProcedure;
                        command.Parameters.AddWithValue("@AccessionNos", string.Join(",", accessionNos));

                        using (var reader = command.ExecuteReader())
                        {
                            while (reader.Read())
                            {
                                var accession = reader["AccessionNo"]?.ToString() ?? "";
                                var icd10Code = reader["ICD10Code"]?.ToString() ?? "";

                                if (!string.IsNullOrEmpty(accession) && !string.IsNullOrEmpty(icd10Code))
                                {
                                    results[accession] = icd10Code;
                                }
                            }
                        }
                    }
                }

                LogDatabaseOperation("GetICD10CodesFromLISMaster", "SUCCESS",
                    $"Retrieved {results.Count} ICD10 codes for {accessionNos.Count} accession numbers");
            }
            catch (Exception ex)
            {
                LogDatabaseOperation("GetICD10CodesFromLISMaster", "ERROR",
                    $"Error: {ex.Message}\nStack: {ex.StackTrace}");
            }

            return results;
        }

        public void LogProcessStatus(string processName, string status, string message = "")
        {
            try
            {
                using (var connection = new SqlConnection(_connectionString))
                {
                    connection.Open();

                    using (var command = new SqlCommand("sp_LogProcessStatus", connection))
                    {
                        command.CommandType = CommandType.StoredProcedure;
                        command.Parameters.AddWithValue("@ProcessName", processName);
                        command.Parameters.AddWithValue("@Status", status);
                        command.Parameters.AddWithValue("@Message", message ?? string.Empty);

                        command.ExecuteNonQuery();
                    }
                }
            }
            catch (Exception ex)
            {
                Console.WriteLine($"Error logging process status: {ex.Message}");
                // Don't throw here as logging shouldn't break the main process
            }
        }


        //public bool CheckReportStatus(int reportType, int reportStatus)
        //{
        //    try
        //    {
        //        using (var connection = new SqlConnection(_connectionString))
        //        {
        //            connection.Open();

        //            var query = "SELECT TOP 1 ReportID FROM ReportDownloadSts WHERE ReportType = @ReportType AND ReportStatus = @ReportStatus";

        //            using (var command = new SqlCommand(query, connection))
        //            {
        //                command.Parameters.AddWithValue("@ReportType", reportType);
        //                command.Parameters.AddWithValue("@ReportStatus", reportStatus);

        //                var result = command.ExecuteScalar();
        //                LogDatabaseOperation("CheckReportStatus", "SUCCESS",
        //                   $"ReportType={reportType}, Status={reportStatus}, Result={result}");

        //                return result != null;
        //            }
        //        }
        //    }
        //    catch (Exception ex)
        //    {
        //        Console.WriteLine($"Error checking report status: {ex.Message}");
        //        LogDatabaseOperation("CheckReportStatus", "ERROR",
        //           $"ReportType={reportType}, Status={reportStatus}, Error={ex.Message}");
        //        throw;
        //    }
        //}

        //public string GetReportServerPath(int reportType, int reportStatus)
        //{
        //    try
        //    {
        //        using (var connection = new SqlConnection(_connectionString))
        //        {
        //            connection.Open();

        //            var query = "SELECT TOP 1 ReportServerPath FROM ReportDownloadSts WHERE ReportType = @ReportType AND ReportStatus = @ReportStatus";

        //            using (var command = new SqlCommand(query, connection))
        //            {
        //                command.Parameters.AddWithValue("@ReportType", reportType);
        //                command.Parameters.AddWithValue("@ReportStatus", reportStatus);

        //                var result = command.ExecuteScalar();
        //                return result?.ToString() ?? string.Empty;
        //            }
        //        }
        //    }
        //    catch (Exception ex)
        //    {
        //        LogDatabaseOperation("GetReportServerPath", "ERROR",
        //             $"ReportType={reportType}, Status={reportStatus}, Error={ex.Message}");
        //        throw;
        //    }
        //}
        //public List<PayerInfo> GetPayerInfoFromCOInsuranceMaster(List<string> payerNames)
        //{
        //    var payerInfos = new List<PayerInfo>();

        //    if (payerNames == null || !payerNames.Any())
        //        return payerInfos;

        //    try
        //    {
        //        using (var connection = new SqlConnection(_connectionString))
        //        {
        //            connection.Open();

        //            // Create parameterized query
        //            var parameters = payerNames.Select((name, index) => $"@PayerName{index}").ToList();
        //            var parameterNames = string.Join(", ", parameters);

        //            var query = $@"
        //                SELECT 
        //                    Global_Payer_ID,
        //                    Payer_Name_Raw,
        //                    Payer_Code
        //                FROM COInsuranceMaster
        //                WHERE Payer_Name_Raw IN ({parameterNames})
        //            ";

        //            using (var command = new SqlCommand(query, connection))
        //            {
        //                // Add parameters
        //                for (int i = 0; i < payerNames.Count; i++)
        //                {
        //                    command.Parameters.AddWithValue($"@PayerName{i}", payerNames[i]);
        //                }

        //                using (var reader = command.ExecuteReader())
        //                {
        //                    while (reader.Read())
        //                    {
        //                        var payerInfo = new PayerInfo
        //                        {
        //                            GlobalPayerID = reader["Global_Payer_ID"]?.ToString() ?? "",
        //                            PayerName = reader["Payer_Name_Raw"]?.ToString() ?? "",
        //                            PayerShortCode = reader["Payer_Code"]?.ToString() ?? ""
        //                        };

        //                        payerInfos.Add(payerInfo);
        //                    }
        //                }
        //            }
        //        }

        //        LogDatabaseOperation("GetPayerInfoFromCOInsuranceMaster", "SUCCESS",
        //            $"Retrieved {payerInfos.Count} payer mappings for {payerNames.Count} payer names");
        //    }
        //    catch (Exception ex)
        //    {
        //        LogDatabaseOperation("GetPayerInfoFromCOInsuranceMaster", "ERROR",
        //            $"Error: {ex.Message}");
        //        throw;
        //    }

        //    return payerInfos;
        //}
        // In DatabaseService class, add this method:
        //public string GetICD10CodeFromLISMaster(string accessionNo)
        //{
        //    if (string.IsNullOrEmpty(accessionNo))
        //        return string.Empty;

        //    try
        //    {
        //        using (var connection = new SqlConnection(_connectionString))
        //        {
        //            connection.Open();
        //            var query = @"
        //        SELECT TOP 1 
        //            REPLACE(ICD10Code, '|', ',') as ICD10Code
        //        FROM LISMaster 
        //        WHERE AccessionNo = @AccessionNo
        //        AND ICD10Code IS NOT NULL
        //        AND ICD10Code != ''";

        //            using (var command = new SqlCommand(query, connection))
        //            {
        //                command.Parameters.AddWithValue("@AccessionNo", accessionNo);
        //                var result = command.ExecuteScalar();
        //                return result?.ToString() ?? string.Empty;
        //            }
        //        }
        //    }
        //    catch (Exception ex)
        //    {
        //        LogDatabaseOperation("GetICD10CodeFromLISMaster", "ERROR",
        //            $"AccessionNo={accessionNo}, Error={ex.Message}");
        //        return string.Empty;
        //    }
        //}

        // For batch processing, add this method to get multiple ICD10Codes at once:
        //public Dictionary<string, string> GetICD10CodesFromLISMaster(List<string> accessionNos)
        //{
        //    var results = new Dictionary<string, string>();

        //    if (accessionNos == null || !accessionNos.Any())
        //        return results;

        //    try
        //    {
        //        // Process in batches of 2000 to stay under the 2100 parameter limit
        //        int batchSize = 2000;
        //        int totalBatches = (int)Math.Ceiling((double)accessionNos.Count / batchSize);

        //        for (int batch = 0; batch < totalBatches; batch++)
        //        {
        //            int startIndex = batch * batchSize;
        //            int endIndex = Math.Min(startIndex + batchSize, accessionNos.Count);
        //            var batchAccessions = accessionNos.Skip(startIndex).Take(batchSize).ToList();

        //            LogDatabaseOperation("GetICD10CodesFromLISMaster", "INFO",
        //                $"Processing batch {batch + 1}/{totalBatches} with {batchAccessions.Count} accession numbers");

        //            using (var connection = new SqlConnection(_connectionString))
        //            {
        //                connection.Open();

        //                // Create parameterized query for this batch
        //                var parameters = batchAccessions.Select((acc, index) => $"@AccessionNo{index}").ToList();
        //                var parameterNames = string.Join(", ", parameters);

        //                var query = $@"
        //            SELECT 
        //                AccessionNo,
        //                REPLACE(ICD10Code, '|', ',') as ICD10Code
        //            FROM LISMaster 
        //            WHERE AccessionNo IN ({parameterNames})
        //            AND ICD10Code IS NOT NULL
        //            AND LTRIM(RTRIM(ICD10Code)) != ''";

        //                using (var command = new SqlCommand(query, connection))
        //                {
        //                    // Add parameters for this batch
        //                    for (int i = 0; i < batchAccessions.Count; i++)
        //                    {
        //                        command.Parameters.AddWithValue($"@AccessionNo{i}", batchAccessions[i]);
        //                    }

        //                    using (var reader = command.ExecuteReader())
        //                    {
        //                        while (reader.Read())
        //                        {
        //                            var accession = reader["AccessionNo"]?.ToString() ?? "";
        //                            var icd10Code = reader["ICD10Code"]?.ToString() ?? "";

        //                            if (!string.IsNullOrEmpty(accession) && !string.IsNullOrEmpty(icd10Code))
        //                            {
        //                                results[accession] = icd10Code;
        //                            }
        //                        }
        //                    }
        //                }
        //            }
        //        }

        //        LogDatabaseOperation("GetICD10CodesFromLISMaster", "SUCCESS",
        //            $"Retrieved {results.Count} ICD10 codes for {accessionNos.Count} accession numbers in {totalBatches} batches");
        //    }
        //    catch (Exception ex)
        //    {
        //        LogDatabaseOperation("GetICD10CodesFromLISMaster", "ERROR",
        //            $"Error: {ex.Message}\nStack: {ex.StackTrace}");
        //    }

        //    return results;
        //}

        //public Dictionary<string, string> GetPayerShortCodeMapping(List<string> payerNames)
        //{
        //    var mapping = new Dictionary<string, string>(StringComparer.OrdinalIgnoreCase);
        //    var nullShortCodePayers = new List<string>();
        //    var payerNameMapping = new Dictionary<string, string>(); // Original -> Processed

        //    if (payerNames == null || !payerNames.Any())
        //        return mapping;

        //    try
        //    {
        //        // Process payer names and create mapping
        //        foreach (var originalPayerName in payerNames)
        //        {
        //            if (string.IsNullOrEmpty(originalPayerName))
        //                continue;

        //            //var processedPayerName = ExtractPayerNameBeforeLastHyphen(originalPayerName);
        //            var processedPayerName = originalPayerName;

        //            payerNameMapping[originalPayerName] = processedPayerName;
        //        }

        //        var processedPayerNames = payerNameMapping.Values.Distinct().ToList();

        //        using (var connection = new SqlConnection(_connectionString))
        //        {
        //            connection.Open();




        //            var query = @"
        //        SELECT Global_Payer_ID,Payer_Name_Raw 
        //        FROM COInsuranceMaster
        //        WHERE Payer_Name_Raw  IN ({0}) ";

        //            var parameters = processedPayerNames.Select((name, index) => $"@PayerName{index}").ToArray();
        //            var inClause = string.Join(",", parameters);
        //            query = string.Format(query, inClause);

        //            using (var command = new SqlCommand(query, connection))
        //            {
        //                for (int i = 0; i < processedPayerNames.Count; i++)
        //                {
        //                    command.Parameters.AddWithValue($"@PayerName{i}", processedPayerNames[i]);
        //                }

        //                using (var reader = command.ExecuteReader())
        //                {
        //                    var dbResults = new Dictionary<string, string>(StringComparer.OrdinalIgnoreCase);

        //                    while (reader.Read())
        //                    {
        //                        var payerName = reader["Payer_Name_Raw"]?.ToString();
        //                        var shortCode = reader["Global_Payer_ID"]?.ToString();

        //                        if (!string.IsNullOrEmpty(payerName))
        //                        {
        //                            dbResults[payerName] = shortCode;
        //                        }
        //                    }

        //                    // Map results back to original payer names
        //                    foreach (var kvp in payerNameMapping)
        //                    {
        //                        var originalPayerName = kvp.Key;
        //                        var processedPayerName = kvp.Value;

        //                        if (dbResults.TryGetValue(processedPayerName, out var shortCode))
        //                        {
        //                            if (string.IsNullOrEmpty(shortCode))
        //                            {
        //                                mapping[originalPayerName] = processedPayerName;
        //                                nullShortCodePayers.Add(processedPayerName);
        //                            }
        //                            else
        //                            {
        //                                mapping[originalPayerName] = shortCode;
        //                            }
        //                        }
        //                        else
        //                        {
        //                            // If no match found in database, use processed name
        //                            mapping[originalPayerName] = processedPayerName;
        //                            Console.WriteLine($"No database entry found for payer: {processedPayerName}");
        //                        }
        //                    }
        //                }
        //            }
        //        }

        //        Console.WriteLine($"Retrieved {mapping.Count} payer short codes from database");

        //        // Log payers that had null short codes
        //        if (nullShortCodePayers.Any())
        //        {
        //            Console.WriteLine($"Payers with null short codes (using payer name instead): {string.Join(", ", nullShortCodePayers)}");
        //        }
        //    }
        //    catch (Exception ex)
        //    {
        //        Console.WriteLine($"Error retrieving payer short codes from database: {ex.Message}");
        //        throw;
        //    }

        //    return mapping;
        //}

        private string ExtractPayerNameBeforeLastHyphen(string payerName)
        {
            if (string.IsNullOrEmpty(payerName))
                return payerName;

            // Trim any leading/trailing whitespace
            payerName = payerName.Trim();

            // Find the last occurrence of hyphen
            int lastHyphenIndex = payerName.LastIndexOf('-');

            if (lastHyphenIndex > 0)
            {
                // Extract substring before the last hyphen and trim
                return payerName.Substring(0, lastHyphenIndex).Trim();
            }

            // If no hyphen found or it's the first character, return the original name
            return payerName;
        }

        //public Dictionary<string, string> GetPayerShortCodeMapping(List<string> payerNames)
        //{
        //    var mapping = new Dictionary<string, string>(StringComparer.OrdinalIgnoreCase);
        //    var nullShortCodePayers = new List<string>();

        //    if (payerNames == null || !payerNames.Any())
        //        return mapping;

        //    try
        //    {
        //        using (var connection = new SqlConnection(_connectionString))
        //        {
        //            connection.Open();

        //            var query = @"
        //    SELECT PayerName, PayerShortCode 
        //    FROM COINSMAS 
        //    WHERE PayerName IN ({0}) ";

        //            var parameters = payerNames.Select((name, index) => $"@PayerName{index}").ToArray();
        //            var inClause = string.Join(",", parameters);
        //            query = string.Format(query, inClause);

        //            using (var command = new SqlCommand(query, connection))
        //            {
        //                for (int i = 0; i < payerNames.Count; i++)
        //                {
        //                    command.Parameters.AddWithValue($"@PayerName{i}", payerNames[i]);
        //                }

        //                using (var reader = command.ExecuteReader())
        //                {
        //                    while (reader.Read())
        //                    {
        //                        var payerName = reader["PayerName"]?.ToString();
        //                        var shortCode = reader["PayerShortCode"]?.ToString();

        //                        if (!string.IsNullOrEmpty(payerName))
        //                        {
        //                            if (string.IsNullOrEmpty(shortCode))
        //                            {
        //                                // Use payer name as short code and log it
        //                                mapping[payerName] = payerName;
        //                                nullShortCodePayers.Add(payerName);
        //                            }
        //                            else
        //                            {
        //                                mapping[payerName] = shortCode;
        //                            }
        //                        }
        //                    }
        //                }
        //            }
        //        }

        //        Console.WriteLine($"Retrieved {mapping.Count} payer short codes from database");

        //        // Log payers that had null short codes
        //        if (nullShortCodePayers.Any())
        //        {
        //            Console.WriteLine($"Payers with null short codes (using payer name instead): {string.Join(", ", nullShortCodePayers)}");
        //        }
        //    }
        //    catch (Exception ex)
        //    {
        //        Console.WriteLine($"Error retrieving payer short codes from database: {ex.Message}");
        //        throw;
        //    }

        //    return mapping;
        //}
        // Additional database methods can be added here in the future
        //public void LogProcessStatus(string processName, string status, string message = "")
        //{
        //    try
        //    {
        //        using (var connection = new SqlConnection(_connectionString))
        //        {
        //            connection.Open();

        //            var query = @"INSERT INTO ProcessLog (ProcessName, Status, Message, CreatedDate) 
        //                         VALUES (@ProcessName, @Status, @Message, GETDATE())";

        //            using (var command = new SqlCommand(query, connection))
        //            {
        //                command.Parameters.AddWithValue("@ProcessName", processName);
        //                command.Parameters.AddWithValue("@Status", status);
        //                command.Parameters.AddWithValue("@Message", message ?? string.Empty);

        //                command.ExecuteNonQuery();
        //            }
        //        }
        //    }
        //    catch (Exception ex)
        //    {
        //        Console.WriteLine($"Error logging process status: {ex.Message}");
        //        // Don't throw here as logging shouldn't break the main process
        //    }
        //}


        public void ExecuteStoredProcedure(string procedureName, Dictionary<string, object> parameters = null)
        {
            try
            {
                using (var connection = new SqlConnection(_connectionString))
                {
                    connection.Open();

                    using (var command = new SqlCommand(procedureName, connection))
                    {
                        command.CommandType = CommandType.StoredProcedure;
                        command.CommandTimeout = 300; // 5 minutes timeout

                        if (parameters != null)
                        {
                            foreach (var param in parameters)
                            {
                                command.Parameters.AddWithValue(param.Key, param.Value ?? DBNull.Value);
                            }
                        }

                        command.ExecuteNonQuery();
                        LogDatabaseOperation("ExecuteStoredProcedure", "SUCCESS",
                            $"Executed {procedureName} successfully");
                    }
                }
            }
            catch (Exception ex)
            {
                LogDatabaseOperation("ExecuteStoredProcedure", "ERROR",
                    $"Procedure: {procedureName}, Error: {ex.Message}");
                throw;
            }
        }
    }


    public class PayerInfo
    {
        public string GlobalPayerID { get; set; }
        public string PayerName { get; set; }
        public string PayerShortCode { get; set; }
    }
}


