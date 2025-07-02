using System;
using System.Collections.Generic;

namespace LRN.DataLibrary.Models;

public partial class BillingMaster
{
    public long BillingMasterId { get; set; }

    public long? LismasterId { get; set; }

    public string? AccessionNo { get; set; }

    public string? VisitNumber { get; set; }

    public int? PrimaryPayerId { get; set; }

    public int? SecondaryPayerId { get; set; }

    public int? PayerTypeId { get; set; }

    public int BillingProviderId { get; set; }

    public string? ClientAccNum { get; set; }

    public string? MemberId { get; set; }

    public DateOnly? BeginDos { get; set; }

    public DateOnly? EndDos { get; set; }

    public DateOnly? ChargeEntryDate { get; set; }

    public DateOnly? FirstBillDate { get; set; }

    public string? BillingFrequency { get; set; }

    public string? ChargeEnteredBy { get; set; }

    public string? Cptcode { get; set; }

    public string? Pos { get; set; }

    public string? Tos { get; set; }

    public string? Modifier { get; set; }

    public string? Icd10code { get; set; }

    public int? Units { get; set; }

    public DateOnly? CheckDate { get; set; }

    public DateOnly? PaymentPostedDate { get; set; }

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

    public string? CheckNumber { get; set; }

    public string? ChartNumber { get; set; }

    public DateTime? CreatedOn { get; set; }

    public DateTime? UpdatedOn { get; set; }

    public virtual BillingProviderMaster BillingProvider { get; set; } = null!;

    public virtual Lismaster? Lismaster { get; set; }

    public virtual PayerTypeMaster? PayerType { get; set; }

    public virtual InsurancePayerMaster? PrimaryPayer { get; set; }
}
