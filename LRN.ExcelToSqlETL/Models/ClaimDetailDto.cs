using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace LRN.ExcelToSqlETL.Core.Models
{
    public class ClaimDetailDto
    {
        public string? AccessionNo { get; set; }
        public string? VisitNumber { get; set; }
        public string? CPTCode { get; set; }
        public string? PatientName { get; set; }
        public string? PatientID { get; set; }
        public DateTime? PatientDOB { get; set; }
        public string? PayerName { get; set; }
        public string? PayerType { get; set; }
        public string? BillingProvider { get; set; }
        public DateTime? BeginDOS { get; set; }
        public DateTime? EndDOS { get; set; }
        public DateTime? ChargeEntryDate { get; set; }
        public DateTime? FirstBillDate { get; set; }
        public string? PanelName { get; set; }
        public string? OrderInfo { get; set; }
        public string? ICD10Code { get; set; }
        public int? Units { get; set; }
        public DateTime? CheckDate { get; set; }
        public DateTime? PaymentPostedDate { get; set; }
        public DateTime? DenialPostedDate { get; set; }
        public string? CheckNumber { get; set; }
        public string? Modifier { get; set; }
        public string? DenialCode { get; set; }
        public decimal? BilledAmount { get; set; }
        public decimal? AllowedAmount { get; set; }
        public decimal? InsurancePayment { get; set; }
        public decimal? InsuranceAdjustment { get; set; }
        public decimal? PatientPaidAmount { get; set; }
        public decimal? PatientAdjustment { get; set; }
        public decimal? InsuranceBalance { get; set; }
        public decimal? PatientBalance { get; set; }
        public decimal? TotalBalance { get; set; }
        public string? FinalClaimStatus { get; set; }
    }

    public class ClaimDetailDateOnlyDto
    {
        [PropertyName(ColumnName = "AccessionNo")]
        public string? AccessionNo { get; set; }

        [PropertyName(ColumnName = "VisitNumber")]
        public string? VisitNumber { get; set; }

        [PropertyName(ColumnName = "CPTCode")]
        public string? CPTCode { get; set; }

        [PropertyName(ColumnName = "PatientName")]
        public string? PatientName { get; set; }

        [PropertyName(ColumnName = "PatientID")]
        public string? PatientID { get; set; }

        [PropertyName(ColumnName = "PatientDOB")]
        public DateOnly? PatientDOB { get; set; }

        [PropertyName(ColumnName = "PayerName")]
        public string? PayerName { get; set; }

        [PropertyName(ColumnName = "PayerType")]
        public string? PayerType { get; set; }

        [PropertyName(ColumnName = "BillingProvider")]
        public string? BillingProvider { get; set; }

        [PropertyName(ColumnName = "BeginDOS")]
        public DateOnly? BeginDOS { get; set; }

        [PropertyName(ColumnName = "EndDOS")]
        public DateOnly? EndDOS { get; set; }

        [PropertyName(ColumnName = "ChargeEntryDate")]
        public DateOnly? ChargeEntryDate { get; set; }

        [PropertyName(ColumnName = "FirstBillDate")]
        public DateOnly? FirstBillDate { get; set; }

        [PropertyName(ColumnName = "PanelName")]
        public string? PanelName { get; set; }

        [PropertyName(ColumnName = "OrderInfo")]
        public string? OrderInfo { get; set; }

        [PropertyName(ColumnName = "ICD10Code")]
        public string? ICD10Code { get; set; }

        [PropertyName(ColumnName = "Units")]
        public int? Units { get; set; }

        [PropertyName(ColumnName = "CheckDate")]
        public DateOnly? CheckDate { get; set; }

        [PropertyName(ColumnName = "PaymentPostedDate")]
        public DateOnly? PaymentPostedDate { get; set; }

        [PropertyName(ColumnName = "DenialPostedDate")]
        public DateOnly? DenialPostedDate { get; set; }

        [PropertyName(ColumnName = "CheckNumber")]
        public string? CheckNumber { get; set; }

        [PropertyName(ColumnName = "Modifier")]
        public string? Modifier { get; set; }

        [PropertyName(ColumnName = "DenialCode")]
        public string? DenialCode { get; set; }

        [PropertyName(ColumnName = "BilledAmount", PropertyType = "Currency")]
        public decimal? BilledAmount { get; set; }

        [PropertyName(ColumnName = "AllowedAmount", PropertyType = "Currency")]
        public decimal? AllowedAmount { get; set; }

        [PropertyName(ColumnName = "InsurancePayment", PropertyType = "Currency")]
        public decimal? InsurancePayment { get; set; }

        [PropertyName(ColumnName = "InsuranceAdjustment", PropertyType = "Currency")]
        public decimal? InsuranceAdjustment { get; set; }

        [PropertyName(ColumnName = "PatientPaidAmount", PropertyType = "Currency")]
        public decimal? PatientPaidAmount { get; set; }

        [PropertyName(ColumnName = "PatientAdjustment", PropertyType = "Currency")]
        public decimal? PatientAdjustment { get; set; }

        [PropertyName(ColumnName = "InsuranceBalance", PropertyType = "Currency")]
        public decimal? InsuranceBalance { get; set; }

        [PropertyName(ColumnName = "PatientBalance", PropertyType = "Currency")]
        public decimal? PatientBalance { get; set; }

        [PropertyName(ColumnName = "TotalBalance", PropertyType = "Currency")]
        public decimal? TotalBalance { get; set; }

        [PropertyName(ColumnName = "FinalClaimStatus")]
        public string? FinalClaimStatus { get; set; }
    }

    public static class DateTimeExtensions
    {
        public static DateOnly? ToDateOnly(this DateTime? dateTime)
            => dateTime.HasValue ? DateOnly.FromDateTime(dateTime.Value) : null;
    }


    public static class ClaimDetailMapper
    {
        public static List<ClaimDetailDateOnlyDto> ProjectToDateOnlyDto(List<ClaimDetailDto> list)
        {
            return list.Select(item => new ClaimDetailDateOnlyDto
            {
                AccessionNo = item.AccessionNo,
                VisitNumber = item.VisitNumber,
                CPTCode = item.CPTCode,
                PatientName = item.PatientName,
                PatientID = item.PatientID,
                PatientDOB = item.PatientDOB.ToDateOnly(),
                PayerName = item.PayerName,
                PayerType = item.PayerType,
                BillingProvider = item.BillingProvider,
                BeginDOS = item.BeginDOS.ToDateOnly(),
                EndDOS = item.EndDOS.ToDateOnly(),
                ChargeEntryDate = item.ChargeEntryDate.ToDateOnly(),
                FirstBillDate = item.FirstBillDate.ToDateOnly(),
                PanelName = item.PanelName,
                OrderInfo = item.OrderInfo,
                ICD10Code = item.ICD10Code,
                Units = item.Units,
                CheckDate = item.CheckDate.ToDateOnly(),
                PaymentPostedDate = item.PaymentPostedDate.ToDateOnly(),
                DenialPostedDate = item.DenialPostedDate.ToDateOnly(),
                CheckNumber = item.CheckNumber,
                Modifier = item.Modifier,
                DenialCode = item.DenialCode,
                BilledAmount = item.BilledAmount,
                AllowedAmount = item.AllowedAmount,
                InsurancePayment = item.InsurancePayment,
                InsuranceAdjustment = item.InsuranceAdjustment,
                PatientPaidAmount = item.PatientPaidAmount,
                PatientAdjustment = item.PatientAdjustment,
                InsuranceBalance = item.InsuranceBalance,
                PatientBalance = item.PatientBalance,
                TotalBalance = item.TotalBalance,
                FinalClaimStatus = item.FinalClaimStatus
            }).ToList();
        }
    }

}
