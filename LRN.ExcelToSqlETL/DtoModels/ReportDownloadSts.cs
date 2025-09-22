using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace LRN.ExcelToSqlETL.Core.DtoModels
{
    public class ReportDownloadSts
    {
        public int ReportID { get; set; }

        public string ReportName { get; set; }

        public int ReportType { get; set; }

        public string ReportServerPath { get; set; }

        public int ReportStatus { get; set; }

        public DateTime CreatedOn { get; set; }

        public string FileStatus { get; set; }

        public string LogString { get; set; }
    }
}
