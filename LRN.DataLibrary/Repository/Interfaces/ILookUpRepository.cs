using LRN.ExcelToSqlETL.Core.DtoModels;

namespace LRN.DataLibrary.Repository.Interfaces;

public interface ILookUpRepository
{
    Task<List<ImportFileTypesDto>> GetImportFileTypesAsync(bool isMasterImport=false);
}