using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace LRN.ExcelToSqlETL.Core.DtoModels
{
    public class ImportFileDto
    {
        public int ImportedFileId { get; set; }

        public string ImportFileName { get; set; } = null!;

        public int? ExcelRowCount { get; set; }

        public int? ImportedRowCount { get; set; }

        public int? FileStatus { get; set; }

        public DateTime? ImportedOn { get; set; }

        public int FileType { get; set; }

        public DateTime? ProcessedOn { get; set; }
    }
}
