using Microsoft.Extensions.Configuration;
using System.IO;

namespace LRN.CodingMasterValidation
{
    public class LabContext
    {

        private readonly IConfiguration _configuration;
        private DatabaseService _dbService;


        public string Lab { get; }

        public string LogFolder { get; }
        public string InputFolder { get; }
        public string OutputFolder { get; }
        public string ProcessingFilesFolder { get; }
        public string SourceFile { get; }
        public string FeeSchedulePath { get; }
        public string CodingMasterFile { get; }

        public string SuccessFolder { get; }
        public string ErrorFolder { get; }
        public string ValidationCodingMasterFile { get; }

        public string PayerMasterFile { get; }
        public string SourceFileName { get; }
        public bool UseDbProductionSource { get; }

        // New properties for database functionality
        public int ValidationReportId { get; private set; }
        public string GeneratedExcelPath { get; set; }
        public DatabaseService DbService => _dbService ??= new DatabaseService(_configuration, Lab);

        public LabContext(IConfiguration config, string lab)
        {
            Lab = lab;
            UseDbProductionSource = config.GetValue<bool>($"LabExecution:{lab}:UseDbProductionSource", false);

          

            // Initialize database service
            _dbService = new DatabaseService(config, lab);

            LogFolder = Resolve(config["CodingMaster:LogFolder"], lab);
            InputFolder = Resolve(config["CodingMaster:InputFolder"], lab);
            OutputFolder = Resolve(config["CodingMaster:OutputFolder"], lab);
            ProcessingFilesFolder = Resolve(config["CodingMaster:ProcessingFilesFolder"], lab);
            SourceFile = Resolve(config["CodingMaster:SourceFile"], lab);
            FeeSchedulePath = Resolve(config["CodingMaster:FeeSchedulePath"], lab);
            CodingMasterFile = Resolve(config["ValidationSettings:CodingMaster:FilePath"], lab);

            OutputFolder = Resolve(config["CodingMaster:OutputFolder"], lab);
            ProcessingFilesFolder = Resolve(config["CodingMaster:ProcessingFilesFolder"], lab);
            PayerMasterFile = Resolve(config["PayerMaster:FilePath"], lab);

            ValidationCodingMasterFile = Resolve(config["ValidationSettings:CodingMaster:FilePath"],lab);
            SourceFileName = GetSourceFileName();


            var dateFolder = DateTime.Now.ToString("yyyy-MM-dd");

            SuccessFolder = Path.Combine(ProcessingFilesFolder, dateFolder);
            ErrorFolder = Path.Combine(ProcessingFilesFolder, "ERROR", dateFolder);

            Directory.CreateDirectory(OutputFolder);
            Directory.CreateDirectory(ProcessingFilesFolder);


            EnsureFolders();
        }


        private string GetSourceFileName()
        {
            string SourceFileName = "";
            try
            {
                
                if (!UseDbProductionSource)
                {
                    // For file system labs, use the existing logic
                    SourceFileName = GetLatestSourceFileName(SourceFile);
                    Console.WriteLine($"📂 {Lab} uses file system source: {SourceFileName}");
                }
                
            }
            catch (Exception ex)
            {
                // If we can't get the source file name, set a default
             //   SourceFileName = $"ProductionMaster_{DateTime.Now:yyyyMMdd}";
                Console.WriteLine($"⚠️ Could not determine source file name for {Lab}: {ex.Message}");
                Console.WriteLine($"   Using default: {SourceFileName}");
            }
            return SourceFileName;
        }

        private static string Resolve(string template, string lab)
        {
            return template.Replace("{LAB}", lab);
        }

        private void EnsureFolders()
        {
            Directory.CreateDirectory(LogFolder);
            Directory.CreateDirectory(InputFolder);
            Directory.CreateDirectory(OutputFolder);
            Directory.CreateDirectory(ProcessingFilesFolder);
            Directory.CreateDirectory(OutputFolder);
            Directory.CreateDirectory(ProcessingFilesFolder);
            
        }

        private static string GetLatestSourceFileName(string sourceFolder)
        {
            if (!Directory.Exists(sourceFolder))
                throw new DirectoryNotFoundException(
                    $"Source folder not found: {sourceFolder}");

            var latestFile = new DirectoryInfo(sourceFolder)
                .GetFiles()
                .OrderByDescending(f => f.LastWriteTime)
                .FirstOrDefault();

            if (latestFile == null)
                throw new FileNotFoundException(
                    $"No source files found in: {sourceFolder}");

            return Path.GetFileNameWithoutExtension(latestFile.Name);
        }


        // New methods for database functionality
        public bool TryGetPendingValidationJob(out int reportId, out string reportPath)
        {
            reportId = 0;
            reportPath = null;

            try
            {
                // First check if database connection is available
                if (!TestDatabaseConnection())
                {
                    Console.WriteLine($"⚠️ Database connection not available for {Lab}");
                    return false;
                }

                var result = DbService.GetPendingValidationJob();
                reportId = result.ReportID;
                reportPath = result.ReportServerPath;

                // For validation jobs, ReportServerPath can be NULL because we're creating the report
                // We only need the ReportID to track the job
                if (reportId > 0)
                {
                    Console.WriteLine($"✅ Found pending validation job: ReportID={reportId}");
                    if (!string.IsNullOrEmpty(reportPath))
                    {
                        Console.WriteLine($"   Report will be saved to: {reportPath}");
                    }
                    else
                    {
                        Console.WriteLine($"   Report path will be determined after generation");
                    }
                    return true;
                }

                return false;
            }
            catch (Exception ex)
            {
                Console.WriteLine($"⚠️ Error checking pending validation job: {ex.Message}");
                reportId = 0;
                reportPath = null;
                return false;
            }
        }

        public bool TryGetLatestProductionReport(out int reportId, out string reportPath)
        {
            reportId = 0;
            reportPath = null;

            try
            {
                if (!TestDatabaseConnection())
                {
                    Console.WriteLine($"⚠️ Database connection not available for {Lab}");
                    return false;
                }

                var result = DbService.GetLatestProductionReport();
                reportId = result.ReportID;
                reportPath = result.ReportServerPath;

                // For Production Master, we NEED the file path
                if (reportId > 0 && !string.IsNullOrEmpty(reportPath))
                {
                    // Check if file exists
                    if (File.Exists(reportPath))
                    {
                        Console.WriteLine($"✅ Found production report: {Path.GetFileName(reportPath)}");
                        return true;
                    }
                    else
                    {
                        Console.WriteLine($"❌ Production report file not found: {reportPath}");
                        return false;
                    }
                }
                else
                {
                    Console.WriteLine($"⚠️ No valid production report found in database");
                    return false;
                }
            }
            catch (Exception ex)
            {
                Console.WriteLine($"⚠️ Error getting production report: {ex.Message}");
                return false;
            }
        }

        //public bool TryGetLatestProductionReport(out int reportId, out string reportPath)
        //{
        //    try
        //    {
        //        var result = DbService.GetLatestProductionReport();
        //        reportId = result.ReportID;
        //        reportPath = result.ReportServerPath;
        //        return reportId > 0;
        //    }
        //    catch
        //    {
        //        reportId = 0;
        //        reportPath = null;
        //        return false;
        //    }
        //}

        public bool UpdateDatabaseStatus(bool success, string generatedExcelPath = null)
        {
            try
            {
                if (ValidationReportId > 0)
                {
                    // If we have a generated Excel path, use it
                    if (!string.IsNullOrEmpty(generatedExcelPath))
                    {
                        GeneratedExcelPath = generatedExcelPath;
                    }

                    // Update the database with success status and file path
                    DbService.UpdateValidationStatus(ValidationReportId, GeneratedExcelPath, success);

                    Console.WriteLine($"✅ Updated database status for ReportID={ValidationReportId}");
                    Console.WriteLine($"   Status: {(success ? "Success" : "Failed")}");
                    Console.WriteLine($"   Output file: {GeneratedExcelPath ?? "Not generated"}");
                    return true;
                }
                return false;
            }
            catch (Exception ex)
            {
                Console.WriteLine($"⚠️ Failed to update database status: {ex.Message}");
                return false;
            }
        }


        public bool UpdateDatabaseFailed(int reportId, string error)
        {
            try
            {
                return DbService.UpdateValidationFailed(reportId, error);
            }
            catch (Exception ex)
            {
                FileLogger.Error("❌ Failed to update DB FAILED status", ex);
                return false;
            }
        }

        public bool UpdateInProgressStatus(int intReportID)
        {
            try
            {
                if (intReportID > 0)
                {
                    // If we have a generated Excel path, use it
                   
                    // Update the database with success status and file path
                    DbService.UpdateInProgressStatus(intReportID);

                    Console.WriteLine($"✅ Updated database status to InProgress for ReportID={intReportID}");
                  return true;
                }
                return false;
            }
            catch (Exception ex)
            {
                Console.WriteLine($"⚠️ Failed to update database status: {ex.Message}");
                return false;
            }
        }
       

        public bool TestDatabaseConnection()
        {
            try
            {
                return DbService.TestConnection();
            }
            catch
            {
                return false;
            }
        }

        public void SetValidationReportId(int reportId)
        {
            ValidationReportId = reportId;
        }


        public bool TryInitializeSourceFromDatabase()
        {
            if (!UseDbProductionSource)
                return false;

            // Check for pending validation job
            if (!TryGetPendingValidationJob(out int reportId, out string validationPath))
            {
                Console.WriteLine($"⚠️ No pending validation job found for {Lab}");
                return false;
            }

            // Get latest production report
            if (!TryGetLatestProductionReport(out int prodReportId, out string prodReportPath))
            {
                Console.WriteLine($"⚠️ No production report found in database for {Lab}");
                return false;
            }

            if (!File.Exists(prodReportPath))
            {
                Console.WriteLine($"❌ Production report file not found: {prodReportPath}");
                return false;
            }

            try
            {
                // Ensure source directory exists
                var sourceDir = Path.GetDirectoryName(SourceFile);
                if (!Directory.Exists(sourceDir))
                    Directory.CreateDirectory(sourceDir);

                // Generate unique filename with timestamp
                var timestamp = DateTime.Now.ToString("yyyyMMdd_HHmmss");
                var newFileName = $"ProductionMaster_{timestamp}.xlsx";
                var destinationPath = Path.Combine(sourceDir, newFileName);

                // Copy the file
                File.Copy(prodReportPath, destinationPath, true);
                Console.WriteLine($"✅ Copied production report from DB to: {destinationPath}");

                // Update ValidationReportId for database update later
                SetValidationReportId(reportId);

                return true;
            }
            catch (Exception ex)
            {
                Console.WriteLine($"❌ Failed to copy production report: {ex.Message}");
                return false;
            }
        }

        // Method to get the actual source file path (supports both DB and file system)
        public string GetActualSourceFilePath()
        {
            // First try to get file from database
            if (TryInitializeSourceFromDatabase())
            {
                // Get the latest file in source directory (which should be the one we just copied)
                var sourceDir = Path.GetDirectoryName(SourceFile);
                if (Directory.Exists(sourceDir))
                {
                    var latestFile = new DirectoryInfo(sourceDir)
                        .GetFiles("*.xlsx")
                        .OrderByDescending(f => f.LastWriteTime)
                        .FirstOrDefault();

                    if (latestFile != null)
                        return latestFile.FullName;
                }
            }

            // Fallback to original file system logic
            if (File.Exists(SourceFile))
                return SourceFile;

            throw new FileNotFoundException($"No source file found for lab: {Lab}");
        }

        


    }
}
