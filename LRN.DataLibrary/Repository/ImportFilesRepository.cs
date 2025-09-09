using Dapper;
using LRN.DataLibrary.Models;
using LRN.DataLibrary.Repository.Interfaces;
using LRN.ExcelToSqlETL.Core.Constants;
using LRN.ExcelToSqlETL.Core.DtoModels;
using LRN.ExcelToSqlETL.Core.Models;
using Microsoft.Data.SqlClient;
using Microsoft.EntityFrameworkCore;
using Microsoft.VisualBasic.FileIO;
using System.Data;
using System.Linq;
using System.Net.NetworkInformation;
using static LRN.ExcelToSqlETL.Core.Constants.CommonConst;
using static Microsoft.EntityFrameworkCore.DbLoggerCategory.Database;

namespace LRN.DataLibrary.Repository;

public class ImportFilesRepository : IImportFilesRepository
{
    private readonly DapperContext _context;

    public ImportFilesRepository(DapperContext context)
    {
        _context = context;
    }

    public async Task<List<ImportFileDto>> InsertImportFilesDataAsync(List<ImportFileDto> files)
    {
        if (files == null || files.Count == 0)
            return new List<ImportFileDto>();

        const string sql = @"INSERT INTO ImportedFiles (ImportFileName, ExcelRowCount, ImportedRowCount, FileStatus, ImportedOn, FileType, ProcessedOn, LabId,ImportFilePath)
                             VALUES (@ImportFileName, @ExcelRowCount, @ImportedRowCount, @FileStatus, @ImportedOn, @FileType, @ProcessedOn, @LabId,@ImportFilePath);
                             SELECT CAST(SCOPE_IDENTITY() as int);";
        using var connection = _context.CreateConnection();
        foreach (var file in files)
        {
            var id = await connection.ExecuteScalarAsync<int>(sql, file);
            file.ImportedFileId = id;
        }
        return files;
    }

    public async Task<ImportFileDto> AddImportFileAync(ImportFileDto file)
    {
        var list = await InsertImportFilesDataAsync(new List<ImportFileDto> { file });
        return list.First();
    }

    public async Task UpdateImportFilesAsync(List<ImportFileDto> files)
    {
        const string sql = @"UPDATE ImportedFiles SET  ExcelRowCount=@ExcelRowCount, ImportedRowCount=@ImportedRowCount, FileStatus=@FileStatus,  ProcessedOn=GETDATE()  WHERE ImportedFileID = @ImportedFileId";
        using var connection = _context.CreateConnection();
        await connection.ExecuteAsync(sql, files);
    }

    public async Task UpdateFileAsync(ImportFileDto file)
    {
        await UpdateImportFilesAsync(new List<ImportFileDto> { file });
    }

    // map file type -> staging table
    private static readonly IReadOnlyDictionary<int, string> StagingByType = new Dictionary<int, string>
    {
        [(int)CommonConst.ImportFileType.LIS_Report] = "dbo.LISStaging",
        [(int)CommonConst.ImportFileType.Custom_Collection] = "dbo.CustomCollectionStaging",
        [(int)CommonConst.ImportFileType.Visit_Against_Accession] = "dbo.VisitAgaistAccessionStaging",
        [(int)CommonConst.ImportFileType.Transaction_Detail_Report] = "dbo.TransactionDetailStaging",
        [(int)CommonConst.ImportFileType.Denial_Tracking_Report] = "dbo.DenialTrackingStaging",
        [(int)CommonConst.ImportFileType.Prism_Billing_Sheet] = "dbo.PrismBillingStaging",
        [(int)CommonConst.ImportFileType.Accession_Payment_Report] = "dbo.AccPaymentReportStaging",
        [(int)CommonConst.ImportFileType.Order_LIS] = "dbo.DiagnoseLISStaging",
        [(int)CommonConst.ImportFileType.Diagnos_SampleLIS] = "dbo.DiagnoseLISStaging",
        [(int)CommonConst.ImportFileType.Panel_Group] = "dbo.PanelMasterStaging",
        [(int)CommonConst.ImportFileType.Client_Billing_Sheet] = "dbo.ClientBillingSheet"
    };

    // map file type -> processing stored proc
    private static readonly IReadOnlyDictionary<int, string> ProcByType = new Dictionary<int, string>
    {
        [(int)CommonConst.ImportFileType.LIS_Report] = "SP_Process_LISMaster_ByFileId",
        [(int)CommonConst.ImportFileType.Custom_Collection] = "Sp_ProcessBillingMasterData",
        [(int)CommonConst.ImportFileType.Visit_Against_Accession] = "Sp_Process_VAA_ByFileId",
        [(int)CommonConst.ImportFileType.Transaction_Detail_Report] = "Sp_ProcessTransactionDetails",
        [(int)CommonConst.ImportFileType.Denial_Tracking_Report] = "Sp_ProcessDenialTrackingMaster",
        [(int)CommonConst.ImportFileType.Prism_Billing_Sheet] = "Sp_Process_BillingSheet_ByFileId",
        [(int)CommonConst.ImportFileType.Accession_Payment_Report] = "Sp_ProcessAccessionPaymentReport",
        [(int)CommonConst.ImportFileType.Order_LIS] = "Sp_Process_LISOrderStaging",
        [(int)CommonConst.ImportFileType.Diagnos_SampleLIS] = "Sp_Process_LISSample_Report",
        [(int)CommonConst.ImportFileType.Panel_Group] = "Sp_Process_PanelMasterStaging",
        [(int)CommonConst.ImportFileType.Client_Billing_Sheet] = "Sp_Process_ClientBillingSheet"
    };
    public async Task ProcessImportFilesAsync(ImportFileDto file)
    {
        using var connection = _context.CreateConnection();

        // Cast to SqlConnection to access OpenAsync
        if (connection is SqlConnection sqlConnection)
        {
            await sqlConnection.OpenAsync();
        }
        else
        {
            connection.Open(); // Fallback for other providers
        }

        using var transaction = connection.BeginTransaction();

        try
        {
            int commandTimeout = 2500;
            await connection.ExecuteAsync("sp_InsertMasterData", transaction: transaction, commandType: CommandType.StoredProcedure, commandTimeout: commandTimeout);

            if (file != null)
            {
                ////// 1) get ALL related import file ids safely (await, no .Result)
                ////var ids = (await GetImportFilesByFileType(file.FileType, (int)file.ImportedFileId))
                ////          ?.Distinct().ToList() ?? new List<int>();

                ////// 2) purge staging inside the SAME transaction, parameterized, batched
                ////if (ids.Count > 0 && StagingByType.TryGetValue(file.FileType, out var table))
                ////{
                ////    const int batchSize = 1000; // under 2100-param limit headroom
                ////    var sql = $"DELETE t FROM {table} AS t WHERE t.ImportedFileID IN @Ids";

                ////    foreach (var chunk in ids.Chunk(batchSize))
                ////    {
                ////        var delCmd = new CommandDefinition(
                ////            sql,
                ////            new { Ids = chunk },
                ////            transaction: transaction,
                ////            commandTimeout: commandTimeout,          // consider 0 = infinite if you expect long runs
                ////            commandType: CommandType.Text);

                ////        await connection.ExecuteAsync(delCmd);
                ////    }
                ////}

                // 3) run the processing proc, still inside the SAME transaction & explicit timeout
                if (ProcByType.TryGetValue(file.FileType, out var proc))
                {
                    var p = new DynamicParameters();
                    p.Add("@FileId", file.ImportedFileId, DbType.Int32);

                    var procCmd = new CommandDefinition(
                        proc,
                        parameters: p,
                        transaction: transaction,
                        commandTimeout: commandTimeout,             // or 0 for infinite
                        commandType: CommandType.StoredProcedure);

                    await connection.ExecuteAsync(procCmd);
                }
            }

            transaction.Commit();
        }
        catch (Exception ex)
        {
            transaction.Rollback();
            throw ex;
        }
    }


    //public async Task ProcessImportFilesGroupAsync(List<ImportFileDto> files)
    //{
    //    if (files == null || !files.Any())
    //        throw new ArgumentException("File list is empty or null.");

    //    using var transaction = await _dbContext.Database.BeginTransactionAsync();

    //    try
    //    {
    //        await _dbContext.Database.ExecuteSqlInterpolatedAsync($"EXEC sp_InsertMasterData");

    //        var fileGroups = files
    //            .Where(f => f.ImportedFileId != 0)
    //            .GroupBy(f => (ImportFileType)f.FileType)
    //            .ToDictionary(g => g.Key, g => string.Join(",", g.Select(f => f.ImportedFileId)));

    //        fileGroups.TryGetValue(ImportFileType.LIS_Report, out string lisFileId);
    //        fileGroups.TryGetValue(ImportFileType.Visit_Against_Accession, out string vaaFileId);
    //        fileGroups.TryGetValue(ImportFileType.Custom_Collection, out string customCollectionFileId);
    //        fileGroups.TryGetValue(ImportFileType.Prism_Billing_Sheet, out string billingSheetFileId);
    //        fileGroups.TryGetValue(ImportFileType.Denial_Tracking_Report, out string denialFileId);
    //        fileGroups.TryGetValue(ImportFileType.Transaction_Detail_Report, out string transFileId);

    //        await _dbContext.Database.ExecuteSqlInterpolatedAsync(
    //            $"EXEC SP_Process_LISMaster_From_Staging {lisFileId}, {vaaFileId}, {customCollectionFileId}, {billingSheetFileId}");

    //        await _dbContext.Database.ExecuteSqlInterpolatedAsync(
    //            $"EXEC Sp_ProcessBillingMasterData {customCollectionFileId}");

    //        await _dbContext.Database.ExecuteSqlInterpolatedAsync(
    //            $"EXEC Sp_ProcessDenialTrackingMaster {denialFileId}");

    //        await _dbContext.Database.ExecuteSqlInterpolatedAsync(
    //            $"EXEC Sp_ProcessTransactionDetails {transFileId}");

    //        foreach (var file in files)
    //        {
    //            file.ProcessedOn = DateTime.Now;
    //            file.FileStatus = (int)CommonConst.FileStatusEnum.ImportSuccess;
    //        }

    //        await UpdateImportFilesAsync(files);
    //        await transaction.CommitAsync();
    //    }
    //    catch (Exception ex)
    //    {
    //        await transaction.RollbackAsync();
    //        //.LogError(ex, "An error occurred while processing import files.");
    //        throw new ApplicationException("An error occurred while processing import files.", ex);
    //    }
    //}

    public async Task<List<ImportFileDto>> GetImportFilesAsync()
    {
        const string query = @"SELECT ImportedFileID AS ImportedFileId, ImportFileName, FileTypeName, c.FileStatus AS FileStatusName,
               ExcelRowCount, ImportedRowCount, ImportedOn, ProcessedOn, a.LabId, ImportFilePath,c.FileStatusId 
        FROM ImportedFiles a
        JOIN ImportFilTypes b ON a.FileType = b.FileTypeId
        JOIN FileStatuses c ON a.FileStatus = c.FileStatusId";
        using var connection = _context.CreateConnection();
        var results = await connection.QueryAsync<ImportFileDto>(query);
        return results.ToList();
    }

    public async Task<List<ImportFileTypesDto>> GetImportFilesTypesAsync()
    {
        const string query = "Select FileTypeId, FileTypeName from ImportFilTypes";
        using var connection = _context.CreateConnection();
        var results = await connection.QueryAsync<ImportFileTypesDto>(query);
        return results.ToList();
    }

    public async Task<List<int>> GetImportFilesByFileType(int fileType, int fileId)
    {
        const string sql = @"
        SELECT ImportedFileID
        FROM dbo.ImportedFiles
        WHERE FileType = @fileType AND ImportedFileID = @fileId;";

        using var connection = _context.CreateConnection();
        var results = await connection.QueryAsync<int>(sql, new { fileType, fileId });
        return results.ToList();
    }

    public async Task<List<ReportDownloadSts>> GetReportDownloadStslst()
    {
        const string query = "SELECT [ReportID],[ReportName],[ReportType],[ReportServerPath],[ReportStatus],[CreatedOn]," +
            "FileStatus FROM [dbo].[ReportDownloadSts] a join FileStatuses b on a.ReportStatus = b.FileStatusId";
        using var connection = _context.CreateConnection();
        var results = await connection.QueryAsync<ReportDownloadSts>(query);
        return results.ToList();
    }

    public async Task<ImportFileDto> GetImportFileById(int fileId)
    {
        const string query = @"
        SELECT [ImportedFileID], [ImportFileName], [ExcelRowCount], [ImportedRowCount], 
               [FileStatus], [FileType], [ImportedOn], [ProcessedOn], [LabId], [ImportFilePath]
        FROM [dbo].[ImportedFiles]
        WHERE ImportedFileID = @FileId";  // Use parameterized query

        using var connection = _context.CreateConnection();
        // Use parameterized query to avoid SQL Injection
        var result = await connection.QuerySingleOrDefaultAsync<ImportFileDto>(query, new { FileId = fileId });

        return result;
    }

    public async Task<List<FileLog>> InsertFileLog(List<FileLog> fileLogs)
    {
        if (!fileLogs.Any())
            return new List<FileLog>();

        const string sql = @"INSERT INTO [dbo].[ImportFileLogs] ([ImportFileId],[LogType],[LogMessage],[RowNo],[ColumnName],[CreatedOn])
                                     VALUES (@ImportFileId,@LogType,@LogMessage,@RowNo,@ColumnName,GETDATE());";
        using var connection = _context.CreateConnection();
        foreach (var log in fileLogs)
        {
            await connection.ExecuteAsync(sql, log);
        }
        return fileLogs;
    }

    public async Task<ReportDownloadSts> InsertReportDownloadSts(ReportDownloadSts reportDownloadSts)
    {
        const string sql = @"INSERT INTO [dbo].[ReportDownloadSts]([ReportName],[ReportType],[ReportStatus],[CreatedOn])
                                     VALUES (@ReportName,@ReportType,@ReportStatus,GETDATE());";
        using var connection = _context.CreateConnection();
        await connection.ExecuteAsync(sql, reportDownloadSts);
        return reportDownloadSts;
    }

    public async Task<List<FileLog>> GetFileLogsById(int fileId)
    {
        const string query = @"SELECT LogType, LogMessage, RowNo, ColumnName, CreatedOn 
                           FROM ImportFileLogs 
                           WHERE ImportFileId = @FileId 
                           ORDER BY CreatedOn";

        using var connection = _context.CreateConnection();
        var results = await connection.QueryAsync<FileLog>(query, new { FileId = fileId });
        return results.ToList();
    }

    public async Task<ReportDownloadSts> GetDownloadReportById(int fileId)
    {
        const string query = "select * from ReportDownloadSts Where ReportID = @FileId";  // Use parameterized query

        using var connection = _context.CreateConnection();
        // Use parameterized query to avoid SQL Injection
        var result = await connection.QuerySingleOrDefaultAsync<ReportDownloadSts>(query, new { FileId = fileId });

        return result;
    }

    public async Task<List<LabMaster>> GetLabMaster()
    {
        const string query = "SELECT LabId, LabName, ConnectionKey FROM Labs WHERE IsActive = 1";
        using var connection = _context.CreateConnection();

        var result = await connection.QueryAsync<LabMaster>(query);
        return result.ToList();
    }

}
