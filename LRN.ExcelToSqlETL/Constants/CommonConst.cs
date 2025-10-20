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
            Panel_Group = 7,

            [Description("Accession Payment Report")]
            Accession_Payment_Report = 8,

            [Description("Diagnose Order LIS")]
            Order_LIS = 9,

            [Description("Diagnose Sample LIS")]
            Diagnos_SampleLIS = 10,

            [Description("Client Billing Sheet")]
            Client_Billing_Sheet = 11,
            IATLISFile = 406,
            PCRCO_LIS = 407,

            #region Cove        
            [Description("LIS Raw Report")]
            Cove_LIS_Report = 401,

            [Description("Custom Collection Report")]
            Cove_Custom_Collection = 402,

            [Description("Transaction_Detail_Report")]
            Cove_Transaction_Detail_Report = 403,

            [Description("Denial_Tracking_Report")]
            Cove_Denial_Tracking_Report = 404,

            [Description("Accession Payment Report")]
            Cove_Accession_Payment_Report = 405,
            #endregion

            #region InHealth DTR File Types 
            [Description("InHealthDTR LIS Master")]
            InHealthDTR_LIS_Master = 201,
            [Description("InHealth_CCW")]
            InHealth_CCW = 202,
            [Description("DTR_CCW")]
            DTR_CCW = 203,
            [Description("VISIT_AGAINST_ACCESSION_InHealth_DTR")]
            VISIT_AGAINST_ACCESSION_IHDTR = 204,
            [Description("Transaction_Detail_Report")]
            Transaction_Detail_Report_IHDTR = 205,
            [Description("InHealth_Denial_Tracking")]
            InHealth_Denial_Tracking = 206,
            [Description("DTR Denail Tracking")]
            DTR_Denail_Tracking = 207,
            [Description("Nexum Claim Scrubbing - DTR")]
            Nexum_Claim_Scrubbing_DTR = 208,
            [Description("Nexum Claim Scrubbing - IH")]
            Nexum_Claim_Scrubbing_IH = 209,
            [Description("Nexum Preprocessing - DTR")]
            Nexum_Preprocessing_DTR = 210,
            [Description("Nexum Preprocessing - IH")]
            Nexum_Preprocessing_IH = 211,

            #endregion

        }

        public enum DownloadReportType
        {
            LIS_Master = 1,
            Production_Master = 2,
            Collection_Report = 3,
            Production_LineLevel = 4
        }
    }
}
