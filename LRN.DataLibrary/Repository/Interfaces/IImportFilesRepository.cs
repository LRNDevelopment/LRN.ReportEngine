using LRN.DataLibrary.Models;
using LRN.ExcelToSqlETL.Core.DtoModels;
using LRN.ExcelToSqlETL.Core.Models;

namespace LRN.DataLibrary.Repository.Interfaces;

public interface IImportFilesRepository
{
	Task<List<ImportFileDto>> InsertImportFilesDataAsync(List<ImportFileDto> files);
	Task UpdateImportFilesAsync(List<ImportFileDto> files);
	Task ProcessImportFilesAsync(ImportFileDto file);
	Task<ImportFileDto> AddImportFileAync(ImportFileDto file);
	Task UpdateFileAsync(ImportFileDto file);
	Task<List<ImportFileDto>> GetImportFilesAsync(bool isMasterImport);
	Task<List<ImportFileDto>> GetImportFilesAsync();
	Task<List<ImportFileTypesDto>> GetImportFilesTypesAsync();

	Task<ImportFileDto> GetImportFileById(int fileId);

	Task<List<FileLog>> InsertFileLog(List<FileLog> fileLogs);

	Task<List<FileLog>> GetFileLogsById(int fileId);

	Task<List<ReportDownloadSts>> GetReportDownloadStslst();

	Task<ReportDownloadSts> InsertReportDownloadSts(ReportDownloadSts reportDownloadSts);

	Task<ReportDownloadSts> GetDownloadReportById(int fileId);

	Task<List<LabMaster>> GetLabMaster();

	Task<ImportFilType> GetImportFileType(int fileTypeId);


	Task<List<DownloadReportType>> GetDownloadReportTypes();

}