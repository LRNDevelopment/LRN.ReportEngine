using CsvHelper.Configuration.Attributes;

namespace PayerPolicyStatusGenerator.Models
{
    public class ClaimRecord
    {
        public string SNo { get; set; }
        public string PayerName { get; set; }
        public string GlobalPayerID { get; set; }
        public string Accession { get; set; }
        public string VisitNumber { get; set; }
        public string DenialCode { get; set; }
        public string CPTCode { get; set; }
        public string ICD10Code { get; set; }
        public string CCWICDCode { get; set; }
        public string CoverageStatus { get; set; }
        public string ICDValidation { get; set; }
        public string ValidationRemarks { get; set; }
        public string CoveredICDCodes { get; set; }
        public string NonCoveredICDCodes { get; set; }
        public string ICDNOTAvailableinPayerPolicy { get; set; }

        // Calculated columns (not in input)
        public string PaymentStatus { get; set; }
        public string PaymentRemark { get; set; }
    }

    // Class map for writing (not reading)
    public class ClaimRecordWriteMap : CsvHelper.Configuration.ClassMap<ClaimRecord>
    {
        public ClaimRecordWriteMap()
        {
            Map(m => m.SNo).Name("SNo");
            Map(m => m.PayerName).Name("PayerName");
            Map(m => m.GlobalPayerID).Name("GlobalPayerID");
            Map(m => m.Accession).Name("Accession");
            Map(m => m.VisitNumber).Name("VisitNumber");
            Map(m => m.DenialCode).Name("DenialCode");
            Map(m => m.CPTCode).Name("CPTCode");
            Map(m => m.ICD10Code).Name("ICD10Code");
            Map(m => m.CCWICDCode).Name("CCWICDCode");
            Map(m => m.CoverageStatus).Name("CoverageStatus");
            Map(m => m.ICDValidation).Name("ICDValidation");
            Map(m => m.ValidationRemarks).Name("ValidationRemarks");
            Map(m => m.CoveredICDCodes).Name("CoveredICDCodes");
            Map(m => m.NonCoveredICDCodes).Name("NonCoveredICDCodes");
            Map(m => m.ICDNOTAvailableinPayerPolicy).Name("ICDNOTAvailableinPayerPolicy");
            Map(m => m.PaymentStatus).Name("Payment Status");
            Map(m => m.PaymentRemark).Name("Payment Remark");
        }
    }
}