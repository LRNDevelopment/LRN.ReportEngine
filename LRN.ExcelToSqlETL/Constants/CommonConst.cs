using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace LRN.ExcelToSqlETL.Core.Constants
{
    public static class CommonConst
    {
        public static string InputFilePath { get; set; }

        public static string JSONPath { get; set; }

        public static string MappingJSONPath { get; set; }

        public static string LISMaster_Template { get; set; }
        public static string ProdMaster_Template { get; set; }

        public static string CollectionTemplate { get; set; }
        public static string DefaultConnection { get; set; }
        public static string DownloadFilePath { get; set; }
        public static string ImportFilePath { get; set; }



        public enum FileStatusEnum
        {
            [Description("Import Successful")]
            ImportSuccess = 1,

            [Description("Import Failed")]
            ImportFailed = 2,

            [Description("Import InProgresss")]
            ImportInProgresss = 3,

            [Description("Import Queued")]
            ImportQueued = 4,

            [Description("Import Waiting")]
            ImportWaiting = 5,

            [Description("Import Warning")]
            ImportWarning = 6
        }

        public enum ImportFileType
        {
            [Description("LIS Raw Report")]
            LIS_Report = 1,

            [Description("Custom Collection Report")]
            Custom_Collection = 2,

            [Description("Visit Against Accession")]
            Visit_Against_Accession = 3,

            [Description("Transaction_Detail_Report")]
            Transaction_Detail_Report = 4,

            [Description("Denial_Tracking_Report")]
            Denial_Tracking_Report = 5,

            [Description("Prism_Billing_Sheet")]
            Prism_Billing_Sheet = 6,

            [Description("Panel_Group")]
            Panel_Group = 7
        }
    }
}
