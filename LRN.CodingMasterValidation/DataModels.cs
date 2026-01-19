namespace LRN.CodingMasterValidation
{
   

    public class CodingMasterRecord
    {
        public string ProductionPanelName { get; set; }
        public string Payer { get; set; }
        public string Procedure { get; set; }
        public bool IsFallbackPayer { get; set; }
    }

    public class ValidationResult
    {
        public ProductionRecord ProductionRecord { get; }
        public List<string> ExpectedCPTCodes { get; set; } = new List<string>();
        public Dictionary<string, int> MissingCPTCodes { get; set; } = new Dictionary<string, int>();
        public Dictionary<string, int> AdditionalCPTCodes { get; set; } = new Dictionary<string, int>();
        public bool HasMatch { get; set; }
        public string MatchType { get; set; } = "";

        // New property for sorted actual CPT codes
        public string SortedActualCPTCodes { get; set; } = "";
        public string Remarks { get; set; } = "";

        public string PayerCommonCode { get; set; }
        public string PayerName { get; set; }


        public ValidationResult(ProductionRecord record)
        {


            ProductionRecord = record;
        }
    }

    //public class ProductionRecord
    //{
    //    public string VisitNumber { get; set; }
    //    public string AccessionNo { get; set; }
    //    public string PanelName { get; set; }
    //    public string Carrier { get; set; }
    //    public string ActualCPTCode { get; set; }
    //    public decimal TotalCharge { get; set; }
    //    public string Panel1 { get; set; } = "";
    //}


    public class ProductionRecord
    {
        // Existing fields
        public string VisitNumber { get; set; } = "";
        public string AccessionNo { get; set; } = "";
        public string PanelName { get; set; } = "";
        public string Carrier { get; set; } = "";
        public string ActualCPTCode { get; set; } = "";
        public decimal TotalCharge { get; set; }
        public string Panel1 { get; set; } = "";

        // NEW FIELDS for Master Claim Level
        public string FinancialClass { get; set; } = "";
        public string BillingProvider { get; set; } = "";
        public string ReferringProviderName { get; set; } = "";
        public string ChartNumber { get; set; } = "";
        public string PatientName { get; set; } = "";
        public string PatientDOB { get; set; } = "";
        public string ResponsibleParty { get; set; } = "";
        public string TestType { get; set; } = "";
        public string ClinicName { get; set; } = "";
        public string Facility { get; set; } = "";
        public string BeginDOS { get; set; } = "";
        public string Aging { get; set; } = "";
        public string AgingBucket { get; set; } = "";
        public string AMDDOE { get; set; } = "";
        public string FirstBillDate { get; set; } = "";
        public string ChargeEntryDate { get; set; } = "";
        public string DenialPostedDate { get; set; } = "";
        public string CheckDate { get; set; } = "";
        public string PaymentPostedDate { get; set; } = "";
        public string CheckNumber { get; set; } = "";
        public string BilledNotBilled { get; set; } = "";
        public string POS { get; set; } = "";
        public string TOS { get; set; } = "";
        public string PrimaryDiagnosis { get; set; } = "";
        public string ActualDenialCode { get; set; } = "";
        public string DenialCode { get; set; } = "";
        public string DenialDescription { get; set; } = "";
        public decimal TotalAllowed { get; set; }
        public decimal CarrierPayment { get; set; }
        public decimal PaymentPercentage { get; set; }
        public decimal CarrierWO { get; set; }
        public decimal PatientPaidAmount { get; set; }
        public decimal PatientWO { get; set; }
        public decimal CarrierBalance { get; set; }
        public decimal PatientBalance { get; set; }
        public decimal TotalBalance { get; set; }
        public decimal TotalPayment { get; set; }
        public decimal TotalWO { get; set; }
        public decimal TotalAdjustment { get; set; }
        public string FullyPaid { get; set; } = "";
        public string FullyPaidStatus { get; set; } = ""; // Note: Column name has space: "Fully Paid"
        public string Bucket30 { get; set; } = ""; // "30 Bucket #"
        public decimal T30Amount { get; set; }
        public string Bucket60 { get; set; } = ""; // "60 Bucket #"
        public decimal T60Amount { get; set; }
        public decimal AdjudicatedAmount { get; set; }
        public decimal AdjudicatedCount { get; set; }
        public string FinalStatus { get; set; } = "";
    }



    public class PayerMasterRecord
    {
        public string Global_Payer_ID { get; set; }
        public string Payer_Code { get; set; }
        public string Payer_Common_Code { get; set; }
        public string Payer_Group_Code { get; set; }
        public string Payer_Name_Raw { get; set; }
        public string Payer_Name_Normalized { get; set; }
        public string Plan_Type { get; set; }
        public string Payer_State { get; set; }
        public string Is_Active { get; set; }
        public string Global_Payer_ID2 { get; set; }
    }

    //public class MasterLineLevelRecord
    //{
    //    public string AccessionNo { get; set; }
    //    public string VisitNumber { get; set; }
    //    public string CPTCode { get; set; }
    //    public string PayerName { get; set; }
    //    public string PanelName { get; set; }

    //    public string Panel1 { get; set; }
    //    public string Units { get; set; }
    //    public string PaymentPercentage { get; set; }
    //    public string BilledAmount { get; set; }
    //    public string AllowedAmount { get; set; }
    //    public string InsurancePayment { get; set; }
    //    public string InsuranceAdjustment { get; set; }
    //    public string PatientPaidAmount { get; set; }
    //    public string PatientAdjustment { get; set; }
    //    public string InsuranceBalance { get; set; }
    //    public string PatientBalance { get; set; }
    //    public string TotalBalance { get; set; }
    //    public string FinalClaimStatus { get; set; }

    //    // Calculated (leave empty for now)
    //    public string BilledAmountPerUnit { get; set; }
    //    public string AllowedAmountPerUnit { get; set; }
    //    public string InsurancePaymentPerUnit { get; set; }
    //    public string PatientPaymentPerUnit { get; set; }
    //    public string PatientBalancePerUnit { get; set; }
    //}
    public class MasterLineLevelRecord
    {
        // Existing fields
        public string AccessionNo { get; set; }
        public string VisitNumber { get; set; }
        public string CPTCode { get; set; }
        public string PayerName { get; set; }
        public string PanelName { get; set; }
        public string Panel1 { get; set; }

        // NEW FIELDS for Master Line Level
        public string PatientName { get; set; }
        public string ChartNumber { get; set; }
        public string PatientDOB { get; set; }
        public string PayerType { get; set; }
        public string BillingProvider { get; set; }
        public string BeginDOS { get; set; }
        public string EndDOS { get; set; }
        public string ChargeEntryDate { get; set; }
        public string FirstBillDate { get; set; }
        public string OrderInfo { get; set; }
        public string ICD10Code { get; set; }
        public string Units { get; set; }
             
        public string CheckDate { get; set; }
        public string PaymentPercentage { get; set; }
        public string PaymentPostedDate { get; set; }
        public string DenialPostedDate { get; set; }
        public string CheckNumber { get; set; }
        public string Modifier { get; set; }
        public string ActualDenialCode { get; set; }
        public string DenialCode { get; set; }
        public string DenialDescription { get; set; }
        public string BilledAmount { get; set; }
        public string AllowedAmount { get; set; }
        public string InsurancePayment { get; set; }
        public string InsuranceAdjustment { get; set; }
        public string PatientPaidAmount { get; set; }
        public string PatientAdjustment { get; set; }
        public string InsuranceBalance { get; set; }
        public string PatientBalance { get; set; }
        public string TotalBalance { get; set; }
        public string FinalClaimStatus { get; set; }
        public string LabName { get; set; }
        public string ClinicName { get; set; }
        public string OperationsGroup { get; set; }
        public string TestType { get; set; }
        public string ReferringProviderName { get; set; }
        public string PanelGroup { get; set; }
        public string LISMissingRecord { get; set; }
        public string ClaimSubStatus { get; set; }

        // Calculated fields
        public string BilledAmountPerUnit { get; set; }
        public string AllowedAmountPerUnit { get; set; }
        public string InsurancePaymentPerUnit { get; set; }
        public string PatientPaymentPerUnit { get; set; }
        public string PatientBalancePerUnit { get; set; }
    }
    public class ReferenceFileUpdateResult
    {
        public int? FeeScheduleImportedFileID { get; set; }
        public int? PayerMasterImportedFileID { get; set; }
    }

    public class ImportedFileInfo
    {
        public int ImportedFileID { get; set; }
        public string ImportFileName { get; set; }
        public int FileType { get; set; }
        public DateTime ImportedOn { get; set; }
        public DateTime? ProcessedOn { get; set; }
        public string ImportFilePath { get; set; }
    }

}