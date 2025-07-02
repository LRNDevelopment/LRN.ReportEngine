using Dapper;
using LRN.DataLibrary.Repository.Interfaces;
using LRN.ExcelToSqlETL.Core.DtoModels;

namespace LRN.DataLibrary.Repository;

public class LookUpRepository : ILookUpRepository
{
    private readonly DapperContext _context;

    public LookUpRepository(DapperContext context)
    {
        _context = context;
    }

    public async Task<List<ImportFileTypesDto>> GetImportFileTypesAsync()
    {
        const string query = "SELECT FileTypeId, FileTypeName, LabId, IsActive FROM ImportFilTypes";
        using var connection = _context.CreateConnection();
        var results = await connection.QueryAsync<ImportFileTypesDto>(query);
        return results.ToList();
    }
}