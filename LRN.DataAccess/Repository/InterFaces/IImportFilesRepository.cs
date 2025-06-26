using LRN.ExcelToSqlETL.Core.DtoModels;

namespace LRN.DataAccess.Repository.Interfaces;

public interface IImportFilesRepository
{
    Task<List<ImportFileDto>> InsertImportFilesDataAsync(List<ImportFileDto> files);

    Task UpdateImportFilesAsync(List<ImportFileDto> files); // <-- updated from void to Task

    Task ProcessImportFilesAsync(List<ImportFileDto> files); // <-- updated from void to Task

    Task<ImportFileDto> AddImportFileAync(ImportFileDto file);

    Task UpdateFileAsync(ImportFileDto file);
}