using Microsoft.Data.SqlClient;
using System.Data;
using Microsoft.Extensions.Configuration;

namespace LRN.CodingMasterValidation
{
    public class DatabaseService
    {
        private readonly IConfiguration _configuration;
        private readonly string _lab;
        private string _connectionString;

        public DatabaseService(IConfiguration configuration, string lab)
        {
            _configuration = configuration;
            _lab = lab;

            // Lazy load connection string
            _connectionString = null;
        }

        private string GetConnectionString()
        {
            if (_connectionString == null)
            {
                try
                {
                    var connectionStringName = _configuration[$"LabExecution:{_lab}:ConnectionStringName"];
                    _connectionString = _configuration.GetConnectionString(connectionStringName);

                    if (string.IsNullOrEmpty(_connectionString))
                    {
                        // Fallback to default pattern if specific connection string not found
                        _connectionString = _configuration.GetConnectionString($"{_lab}_Connection");
                    }
                }
                catch
                {
                    _connectionString = string.Empty;
                }
            }

            return _connectionString;
        }
        public (int ReportID, string ReportServerPath) GetPendingValidationJob()
        {
            var connectionString = GetConnectionString();
            if (string.IsNullOrEmpty(connectionString))
                return (0, null);

            using (var connection = new SqlConnection(connectionString))
            {
                connection.Open();

                string query = @"
            SELECT TOP 1 ReportID, ReportServerPath 
            FROM ReportDownloadSts 
            WHERE ReportName = 'Coding Master Validation' 
            AND ReportStatus = 4 
            ORDER BY CreatedOn DESC";

                using (var command = new SqlCommand(query, connection))
                using (var reader = command.ExecuteReader())
                {
                    if (reader.Read())
                    {
                        // Safely handle NULL values for ReportID
                        int reportId = 0;
                        if (!reader.IsDBNull(reader.GetOrdinal("ReportID")))
                        {
                            reportId = reader.GetInt32(reader.GetOrdinal("ReportID"));
                        }

                        // Safely handle NULL values for ReportServerPath
                        string reportPath = null;
                        if (!reader.IsDBNull(reader.GetOrdinal("ReportServerPath")))
                        {
                            reportPath = reader.GetString(reader.GetOrdinal("ReportServerPath"));
                        }

                        return (reportId, reportPath);
                    }
                }
            }

            return (0, null);
        }

        public (int ReportID, string ReportServerPath) GetLatestProductionReport()
        {
            var connectionString = GetConnectionString();
            if (string.IsNullOrEmpty(connectionString))
                return (0, null);

            using (var connection = new SqlConnection(connectionString))
            {
                connection.Open();

                string query = @"
            SELECT TOP 1 ReportID, ReportServerPath 
            FROM ReportDownloadSts 
            WHERE ReportName = 'Production Master' 
            AND ReportStatus = 1 
            ORDER BY CreatedOn DESC";

                using (var command = new SqlCommand(query, connection))
                using (var reader = command.ExecuteReader())
                {
                    if (reader.Read())
                    {
                        // Safely handle NULL values for ReportID
                        int reportId = 0;
                        if (!reader.IsDBNull(reader.GetOrdinal("ReportID")))
                        {
                            reportId = reader.GetInt32(reader.GetOrdinal("ReportID"));
                        }

                        // Safely handle NULL values for ReportServerPath
                        string reportPath = null;
                        if (!reader.IsDBNull(reader.GetOrdinal("ReportServerPath")))
                        {
                            reportPath = reader.GetString(reader.GetOrdinal("ReportServerPath"));
                        }

                        return (reportId, reportPath);
                    }
                }
            }

            return (0, null);
        }
        public void UpdateValidationStatus(int reportId, string outputFilePath, bool success)
        {
            var connectionString = GetConnectionString();
            if (string.IsNullOrEmpty(connectionString))
            {
                Console.WriteLine("⚠️ Cannot update database status: No connection string");
                return;
            }

            using (var connection = new SqlConnection(connectionString))
            {
                connection.Open();

                string query = @"
            UPDATE ReportDownloadSts 
            SET ReportStatus = @status, 
                ReportServerPath = @outputPath
               WHERE ReportID = @reportId";

                using (var command = new SqlCommand(query, connection))
                {
                    command.Parameters.AddWithValue("@reportId", reportId);
                    command.Parameters.AddWithValue("@outputPath", outputFilePath ?? string.Empty);
                    command.Parameters.AddWithValue("@status", success ? 1 : 2); // 1=Success, 2=Failed

                    int rowsAffected = command.ExecuteNonQuery();

                    if (rowsAffected > 0)
                    {
                        Console.WriteLine($"✅ Updated {rowsAffected} record(s) in database");
                    }
                    else
                    {
                        Console.WriteLine($"⚠️ No records updated in database for ReportID={reportId}");
                    }
                }
            }
        }

        public bool UpdateValidationFailed(int reportId, string error)
        {
            var connectionString = GetConnectionString();
            if (string.IsNullOrEmpty(connectionString))
                return false;

            if (error?.Length > 4000)
                error = error.Substring(0, 4000);

            using var connection = new SqlConnection(connectionString);
            connection.Open();

            string query = @"
                    UPDATE ReportDownloadSts
                    SET ReportStatus = 2,
                        ReportServerPath = '',
                        LogString = @error
                    WHERE ReportID = @reportId";

            using var cmd = new SqlCommand(query, connection);
            cmd.Parameters.AddWithValue("@reportId", reportId);
            cmd.Parameters.AddWithValue("@error", error ?? string.Empty);

            return cmd.ExecuteNonQuery() > 0;
        }


        public void UpdateInProgressStatus(int reportId)
        {
            var connectionString = GetConnectionString();
            if (string.IsNullOrEmpty(connectionString))
            {
                Console.WriteLine("⚠️ Cannot update database status: No connection string");
                return;
            }

            using (var connection = new SqlConnection(connectionString))
            {
                connection.Open();

                string query = @"UPDATE ReportDownloadSts SET ReportStatus = @status WHERE ReportID = @reportId";

                using (var command = new SqlCommand(query, connection))
                {
                    command.Parameters.AddWithValue("@reportId", reportId);
                    command.Parameters.AddWithValue("@status", 3); // 1=Success, 2=Failed

                    int rowsAffected = command.ExecuteNonQuery();

                    if (rowsAffected > 0)
                    {
                        Console.WriteLine($"✅ Updated {rowsAffected} record(s) in database");
                    }
                    else
                    {
                        Console.WriteLine($"⚠️ No records updated in database for ReportID={reportId}");
                    }
                }
            }
        }


        public ImportedFileInfo GetLatestImportedFile(int fileType)
        {
            var connectionString = GetConnectionString();
            if (string.IsNullOrEmpty(connectionString))
                return null;

            using var conn = new SqlConnection(connectionString);
            conn.Open();

            string sql = @"SELECT TOP 1 ImportedFileID, ImportFileName, FileType,
                            ImportedOn, ProcessedOn, ImportFilePath
                            FROM ImportedFiles
                            WHERE FileType = @FileType AND FileStatus = 1
                            ORDER BY ImportedFileID DESC";

            using var cmd = new SqlCommand(sql, conn);
            cmd.Parameters.AddWithValue("@FileType", fileType);

            using var rdr = cmd.ExecuteReader();
            if (!rdr.Read()) return null;

            return new ImportedFileInfo
            {
                ImportedFileID = rdr.GetInt32(0),
                ImportFileName = rdr.GetString(1),
                FileType = rdr.GetInt32(2),
                ImportedOn = rdr.GetDateTime(3),
                ProcessedOn = rdr.IsDBNull(4) ? null : rdr.GetDateTime(4),
                ImportFilePath = rdr.GetString(5)
            };
        }

        public bool TestConnection()
        {
            try
            {
                var connectionString = GetConnectionString();
                if (string.IsNullOrEmpty(connectionString))
                    return false;

                using (var connection = new SqlConnection(connectionString))
                {
                    connection.Open();
                    return connection.State == ConnectionState.Open;
                }
            }
            catch
            {
                return false;
            }
        }
    }
}