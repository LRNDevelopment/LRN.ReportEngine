using LRN.ExcelToSqlETL.Core.DtoModels;

namespace LRN.DataLibrary.Repository.Interfaces;

public interface IImportFilesRepository
{
    Task<List<ImportFileDto>> InsertImportFilesDataAsync(List<ImportFileDto> files);
    Task UpdateImportFilesAsync(List<ImportFileDto> files);
    Task ProcessImportFilesAsync(ImportFileDto file);
    Task<ImportFileDto> AddImportFileAync(ImportFileDto file);
    Task UpdateFileAsync(ImportFileDto file);
    Task<List<ImportFileDto>> GetImportFilesAsync();
    Task<List<ImportFileTypesDto>> GetImportFilesTypesAsync();

    Task<ImportFileDto> GetImportFileById(int fileId);
}