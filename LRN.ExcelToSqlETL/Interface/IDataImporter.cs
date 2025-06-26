using System.Data;

namespace LRN.ExcelToSqlETL.Core.Interface
{
    public interface IDataImporter
    {
        Task ImportAsync(DataTable data, string tableName);
    }
}
