using LRN.ExcelToSqlETL.Core.Models;
using System.Data;

namespace LRN.ExcelToSqlETL.Core.Interface
{
    public interface IFileReader
    {
        Task<List<ExcelReadResult>> ReadAsync(Stream stream, ExcelSheetMapping mapping);
    }
}
