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
        ValidationResult Validate(DataTable data, ExcelSheetMapping mapping);

        MappingEntry FileMapping(MappingConfigRoot masterConfig, string filename);
    }

}
