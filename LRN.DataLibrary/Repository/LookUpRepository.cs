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

	public async Task<List<ImportFileTypesDto>> GetImportFileTypesAsync(bool isMasterImport = false)
	{
		string query = "Select FileTypeId,(CAST(SeqNo AS VARCHAR)+' . ' + FileTypeName) FileTypeName from ImportFilTypes  WHERE IsActive = 1 AND IsMasterImport =  @IsMasterImport ORDER BY SeqNo";
		if (isMasterImport)
			query = "Select FileTypeId,FileTypeName FileTypeName from ImportFilTypes  WHERE IsActive = 1 AND IsMasterImport =  @IsMasterImport ORDER BY SeqNo";

		using var connection = _context.CreateConnection();
		var results = await connection.QueryAsync<ImportFileTypesDto>(query, new { IsMasterImport = isMasterImport });
		return results.AsList(); // slightly faster than ToList()
	}
}