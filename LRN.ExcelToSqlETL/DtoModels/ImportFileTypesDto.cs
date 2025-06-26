using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace LRN.ExcelToSqlETL.Core.DtoModels
{
    public partial class ImportFileTypesDto
    {
        public int FileTypeId { get; set; }

        public string? FileTypeName { get; set; }

        public int LabId { get; set; }

        public bool? IsActive { get; set; }
    }

}
