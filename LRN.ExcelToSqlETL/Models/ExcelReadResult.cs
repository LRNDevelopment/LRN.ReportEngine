using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace LRN.ExcelToSqlETL.Core.Models
{
    public class ExcelReadResult
    {
        public DataTable Data { get; set; }
        public int TotalRows { get; set; }
        public int ImportedRows { get; set; }
        public int ErrorRows { get; set; }

        public bool IsFailedRead { get; set; }
    }
}
