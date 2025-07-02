using LRN.ExcelToSqlETL.Core.DtoModels;
using LRN.ExcelToSqlETL.Core.Models;

namespace LRN.DataLibrary.Repository.Interfaces;

public interface IReportRepository
{
    List<LISMasterData> GetLISMasterReport(DateTime? startDate, DateTime? endDate);

    List<ProdBillingData> GetProductionDataAsync(DateTime? startDate, DateTime? endDate);
    List<CollectionData> GetCollectionDateByDateAsync(DateTime? startDate, DateTime? endDate);

    List<ClaimDetailDateOnlyDto> GetProdLineLevelAsync(DateTime? startDate, DateTime? endDate);

    List<ClaimDetailDateOnlyDto> GetProdLineLevelManualAsync(DateTime? startDate, DateTime? endDate);
    List<InsightData> GetInsightData();

    Task<List<ImportFileTypesDto>> GetImportFileTypesAsync();
}