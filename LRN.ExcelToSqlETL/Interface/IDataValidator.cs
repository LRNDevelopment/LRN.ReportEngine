using LRN.ExcelToSqlETL.Core.Models;
using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace LRN.ExcelToSqlETL.Core.Interface
{
    public interface IDataValidator
    {
        Task<ValidationResult> Validate(DataTable data, ExcelSheetMapping mapping, int fileId);

        MappingEntry FileMapping(MappingConfigRoot masterConfig, string filename);
    }

}
