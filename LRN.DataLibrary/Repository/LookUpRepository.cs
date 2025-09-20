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
        const string query = "Select FileTypeId,(CAST(SeqNo AS VARCHAR)+' . ' + FileTypeName) FileTypeName from ImportFilTypes ORDER BY SeqNo";
        using var connection = _context.CreateConnection();
        var results = await connection.QueryAsync<ImportFileTypesDto>(query);
        return results.ToList();
    }
}