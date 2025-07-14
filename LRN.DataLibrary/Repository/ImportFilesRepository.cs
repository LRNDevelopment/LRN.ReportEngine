using Dapper;
using LRN.DataLibrary.Models;
using LRN.DataLibrary.Repository.Interfaces;
using LRN.ExcelToSqlETL.Core.Constants;
using LRN.ExcelToSqlETL.Core.DtoModels;
using LRN.ExcelToSqlETL.Core.Models;
using Microsoft.Data.SqlClient;
using Microsoft.EntityFrameworkCore;
using System.Data;
using static LRN.ExcelToSqlETL.Core.Constants.CommonConst;

namespace LRN.DataLibrary.Repository;

public class ImportFilesRepository : IImportFilesRepository
{
    private readonly DapperContext _context;
    private readonly LRNDbContext _dbContext;

    public ImportFilesRepository(DapperContext context, LRNDbContext dbContext)
    {
        _context = context;
        _dbContext = dbContext;
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
        const string sql = @"UPDATE ImportedFiles SET ImportFileName = @ImportFileName, ExcelRowCount=@ExcelRowCount, ImportedRowCount=@ImportedRowCount, FileStatus=@FileStatus, ImportedOn=@ImportedOn, FileType=@FileType, ProcessedOn=GETDATE(), LabId=@LabId WHERE ImportedFileID = @ImportedFileId";
        using var connection = _context.CreateConnection();
        await connection.ExecuteAsync(sql, files);
    }

    public async Task UpdateFileAsync(ImportFileDto file)
    {
        await UpdateImportFilesAsync(new List<ImportFileDto> { file });
    }

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
            await connection.ExecuteAsync("sp_InsertMasterData", transaction: transaction, commandType: CommandType.StoredProcedure);

            if (file != null)
            {
                var parameters = new DynamicParameters();
                parameters.Add("@FileId", file.ImportedFileId, DbType.Int32);

                switch (file.FileType)
                {
                    case (int)CommonConst.ImportFileType.LIS_Report:
                        await connection.ExecuteAsync("SP_Process_LISMaster_ByFileId", parameters, transaction, commandType: CommandType.StoredProcedure);
                        break;

                    case (int)CommonConst.ImportFileType.Custom_Collection:
                        await connection.ExecuteAsync("Sp_ProcessBillingMasterData", parameters, transaction, commandType: CommandType.StoredProcedure);
                        break;

                    case (int)CommonConst.ImportFileType.Visit_Against_Accession:
                        await connection.ExecuteAsync("Sp_Process_VAA_ByFileId", parameters, transaction, commandType: CommandType.StoredProcedure);
                        break;

                    case (int)CommonConst.ImportFileType.Transaction_Detail_Report:
                        await connection.ExecuteAsync("Sp_ProcessTransactionDetails", parameters, transaction, commandType: CommandType.StoredProcedure);
                        break;

                    case (int)CommonConst.ImportFileType.Denial_Tracking_Report:
                        await connection.ExecuteAsync("Sp_ProcessDenialTrackingMaster", parameters, transaction, commandType: CommandType.StoredProcedure);
                        break;

                    case (int)CommonConst.ImportFileType.Prism_Billing_Sheet:
                        await connection.ExecuteAsync("Sp_Process_BillingSheet_ByFileId", parameters, transaction, commandType: CommandType.StoredProcedure);
                        break;

                    case (int)CommonConst.ImportFileType.Panel_Group:
                        // Future implementation
                        break;
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


    public async Task ProcessImportFilesGroupAsync(List<ImportFileDto> files)
    {
        if (files == null || !files.Any())
            throw new ArgumentException("File list is empty or null.");

        using var transaction = await _dbContext.Database.BeginTransactionAsync();

        try
        {
            await _dbContext.Database.ExecuteSqlInterpolatedAsync($"EXEC sp_InsertMasterData");

            var fileGroups = files
                .Where(f => f.ImportedFileId != 0)
                .GroupBy(f => (ImportFileType)f.FileType)
                .ToDictionary(g => g.Key, g => string.Join(",", g.Select(f => f.ImportedFileId)));

            fileGroups.TryGetValue(ImportFileType.LIS_Report, out string lisFileId);
            fileGroups.TryGetValue(ImportFileType.Visit_Against_Accession, out string vaaFileId);
            fileGroups.TryGetValue(ImportFileType.Custom_Collection, out string customCollectionFileId);
            fileGroups.TryGetValue(ImportFileType.Prism_Billing_Sheet, out string billingSheetFileId);
            fileGroups.TryGetValue(ImportFileType.Denial_Tracking_Report, out string denialFileId);
            fileGroups.TryGetValue(ImportFileType.Transaction_Detail_Report, out string transFileId);

            await _dbContext.Database.ExecuteSqlInterpolatedAsync(
                $"EXEC SP_Process_LISMaster_From_Staging {lisFileId}, {vaaFileId}, {customCollectionFileId}, {billingSheetFileId}");

            await _dbContext.Database.ExecuteSqlInterpolatedAsync(
                $"EXEC Sp_ProcessBillingMasterData {customCollectionFileId}");

            await _dbContext.Database.ExecuteSqlInterpolatedAsync(
                $"EXEC Sp_ProcessDenialTrackingMaster {denialFileId}");

            await _dbContext.Database.ExecuteSqlInterpolatedAsync(
                $"EXEC Sp_ProcessTransactionDetails {transFileId}");

            foreach (var file in files)
            {
                file.ProcessedOn = DateTime.Now;
                file.FileStatus = (int)CommonConst.FileStatusEnum.ImportSuccess;
            }

            await UpdateImportFilesAsync(files);
            await transaction.CommitAsync();
        }
        catch (Exception ex)
        {
            await transaction.RollbackAsync();
            //.LogError(ex, "An error occurred while processing import files.");
            throw new ApplicationException("An error occurred while processing import files.", ex);
        }
    }

    public async Task<List<ImportFileDto>> GetImportFilesAsync()
    {
        const string query = @"SELECT ImportedFileID AS ImportedFileId, ImportFileName, FileTypeName, c.FileStatus AS FileStatusName,
               ExcelRowCount, ImportedRowCount, ImportedOn, ProcessedOn, a.LabId, l.LabName,ImportFilePath,c.FileStatusId 
        FROM ImportedFiles a
        JOIN ImportFilTypes b ON a.FileType = b.FileTypeId
        JOIN FileStatuses c ON a.FileStatus = c.FileStatusId
        JOIN LabMaster l on a.LabId = l.LabID";
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
}