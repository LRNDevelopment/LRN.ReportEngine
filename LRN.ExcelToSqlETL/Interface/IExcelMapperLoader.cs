using LRN.ExcelToSqlETL.Core.Models;

namespace LRN.ExcelToSqlETL.Core.Interface
{
    public interface IExcelMapperLoader
    {
        ExcelSheetMapping LoadMapping(string mappingFilePath);
    }
}
