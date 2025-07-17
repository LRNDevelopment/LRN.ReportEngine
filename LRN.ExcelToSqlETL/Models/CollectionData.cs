using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace LRN.ExcelToSqlETL.Core.Models
{
    public class CollectionData
    {
        [PropertyName(ColumnName = "AMD Visit #")]
        public string? VisitNumber { get; set; }
        [PropertyName(ColumnName = "Accession # per Dakota")]
        public string? AccessionNo { get; set; }
        [PropertyName(ColumnName = "Panel Group")]
        public string? PanelName { get; set; }
        [PropertyName(ColumnName = "Carrier")]
        public string? Carrier { get; set; }
        [PropertyName(ColumnName = "FinancialClass")]
        public string? FinancialClass { get; set; }
        [PropertyName(ColumnName = "Provider")]
        public string? BillingProvider { get; set; }
        [PropertyName(ColumnName = "ReferringProvider")]
        public string? ReferringProviderName { get; set; }
        [PropertyName(ColumnName = "Facility")]
        public string? Facility { get; set; }
        [PropertyName(ColumnName = "ChartNum")]
        public string? ChartNumber { get; set; }
        [PropertyName(ColumnName = "PatientName")]
        public string? PatientName { get; set; }
        [PropertyName(ColumnName = "BeginDOS")]
        public DateTime? BeginDOS { get; set; }
        [PropertyName(ColumnName = "Aging")]
        public int? Aging { get; set; }
        [PropertyName(ColumnName = "Aging Bucket")]
        public string? AgingBucket { get; set; }
        [PropertyName(ColumnName = "AMD DOE")]
        public DateTime? AMDDOE { get; set; }
        [PropertyName(ColumnName = "First Bill Date")]
        public DateTime? FirstBillDate { get; set; }
        [PropertyName(ColumnName = "Charge Entry Date")]
        public DateTime? ChargeEntryDate { get; set; }
        [PropertyName(ColumnName = "Check Number")]
        public string? CheckNumber { get; set; }
        [PropertyName(ColumnName = "Check Date")]
        public DateTime? CheckDate { get; set; }
        [PropertyName(ColumnName = "Payment Posted Date")]
        public DateTime? PaymentPostedDate { get; set; }
        [PropertyName(ColumnName = "Billed / Not")]
        public string? BilledNotBilled { get; set; }
        [PropertyName(ColumnName = "POS")]
        public string? POS { get; set; }
        [PropertyName(ColumnName = "TOS")]
        public string? TOS { get; set; }
        [PropertyName(ColumnName = "CPT Combination")]
        public string? CPTCode { get; set; }
        [PropertyName(ColumnName = "PrimaryDiagnosis")]
        public string? PrimaryDiagnosis { get; set; }
        [PropertyName(ColumnName = "Denial Code")]
        public string? DenialCode { get; set; }
        [PropertyName(ColumnName = "TotalCharge", PropertyType = "Currency")]
        public decimal? TotalCharge { get; set; }
        [PropertyName(ColumnName = "TotalAllowed", PropertyType = "Currency")]
        public decimal? TotalAllowed { get; set; }

        [PropertyName(ColumnName = "CarrierPayment", PropertyType = "Currency")]
        public decimal? CarrierPayment { get; set; }
        [PropertyName(ColumnName = "Payment %")]
        public decimal? PaymentPercentage { get; set; }
        [PropertyName(ColumnName = "CarrierWO", PropertyType = "Currency")]
        public decimal? CarrierWO { get; set; }
        [PropertyName(ColumnName = "PatientPayment", PropertyType = "Currency")]
        public decimal? PatientPaidAmount { get; set; }
        [PropertyName(ColumnName = "PatientWO", PropertyType = "Currency")]
        public decimal? PatientWO { get; set; }
        [PropertyName(ColumnName = "CarrierBalance", PropertyType = "Currency")]
        public decimal? CarrierBalance { get; set; }
        [PropertyName(ColumnName = "PatientBalance", PropertyType = "Currency")]
        public decimal? PatientBalance { get; set; }
        [PropertyName(ColumnName = "TotalBalance", PropertyType = "Currency")]
        public decimal? TotalBalance { get; set; }
        [PropertyName(ColumnName = "Fully Paid $", PropertyType = "Currency")]
        public decimal? FullyPaid { get; set; }
        [PropertyName(ColumnName = "Fully Paid Count")]
        public string? FullyPaidCount { get; set; }
        [PropertyName(ColumnName = "Adjudicated $", PropertyType = "Currency")]
        public decimal? AdjudicatedAmount { get; set; }
        [PropertyName(ColumnName = "30 Days Count")]
        public string? T30DaysCount { get; set; }
        [PropertyName(ColumnName = "30 Days $", PropertyType = "Currency")]
        public decimal? T30Amount { get; set; }
        [PropertyName(ColumnName = "60 Days Count")]
        public string? T60DaysCount { get; set; }
        [PropertyName(ColumnName = "60 Days $", PropertyType = "Currency")]
        public decimal? T60Amount { get; set; }
        [PropertyName(ColumnName = "Claim Status")]
        public string? FinalStatus { get; set; }

        [PropertyName(ColumnName = "TestType")]
        public string? TestType { get; set; }

        [PropertyName(ColumnName = "ClinicName")]
        public string? ClinicName { get; set; }

        [PropertyName(ColumnName = "PanelGroup")]
        public string? PanelGroup { get; set; }
    }
}
