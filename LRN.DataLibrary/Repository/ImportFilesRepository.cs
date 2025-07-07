using Dapper;
using LRN.DataLibrary.Repository.Interfaces;
using LRN.ExcelToSqlETL.Core.DtoModels;
using Microsoft.Data.SqlClient;
using System.Data;

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
        const string sql = @"UPDATE ImportedFiles SET ImportFileName = @ImportFileName, ExcelRowCount=@ExcelRowCount, ImportedRowCount=@ImportedRowCount, FileStatus=@FileStatus, ImportedOn=@ImportedOn, FileType=@FileType, ProcessedOn=@ProcessedOn, LabId=@LabId WHERE ImportedFileID = @ImportedFileId";
        using var connection = _context.CreateConnection();
        await connection.ExecuteAsync(sql, files);
    }

    public async Task UpdateFileAsync(ImportFileDto file)
    {
        await UpdateImportFilesAsync(new List<ImportFileDto> { file });
    }

    public async Task ProcessImportFilesAsync(List<ImportFileDto> files)
    {
        using var connection = _context.CreateConnection();
        using var transaction = connection.BeginTransaction();
        try
        {
            await connection.ExecuteAsync("sp_InsertMasterData", transaction: transaction, commandType: CommandType.StoredProcedure);
            // Additional stored procedure calls would go here as in EF version
            foreach (var file in files)
            {
                file.ProcessedOn = DateTime.Now;
            }
            await UpdateImportFilesAsync(files);
            transaction.Commit();
        }
        catch
        {
            transaction.Rollback();
            throw;
        }
    }

    public async Task<List<ImportFileDto>> GetImportFilesAsync()
    {
        const string query = @"SELECT ImportedFileID AS ImportedFileId, ImportFileName, FileTypeName, c.FileStatus AS FileStatusName,
               ExcelRowCount, ImportedRowCount, ImportedOn, ProcessedOn, a.LabId, l.LabName,ImportFilePath 
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

}