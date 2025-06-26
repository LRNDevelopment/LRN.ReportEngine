using System;
using System.Collections.Generic;

namespace LRN.DataAccess.Models;

public partial class TransactionDetailStaging
{
    public int TransactionDetailId { get; set; }

    public string? LabIdentityKey { get; set; }

    public string? TransactionType { get; set; }

    public string? ChartNumber { get; set; }

    public string? PatientName { get; set; }

    public string? FinancialClass { get; set; }

    public string? VisitNo { get; set; }

    public string? FacilityName { get; set; }

    public string? ProviderProfile { get; set; }

    public string? ChargeCode { get; set; }

    public string? TransactionCode { get; set; }

    public string? TransactionCodeDesc { get; set; }

    public string? Modifiers { get; set; }

    public string? VisitPrimaryCarrier { get; set; }

    public string? VisitSecondaryCarrier { get; set; }

    public string? TransactionCarrier { get; set; }

    public string? PrimaryDxIcd9 { get; set; }

    public string? PrimaryDxIcd10 { get; set; }

    public string? PaymentMethod { get; set; }

    public string? CheckNumber { get; set; }

    public DateTime? DateofService { get; set; }

    public DateTime? DateofEntry { get; set; }

    public DateTime? DateofDeposit { get; set; }

    public string? Void { get; set; }

    public int? Units { get; set; }

    public decimal? TotalBilledAmount { get; set; }

    public decimal? PatientPaidAmount { get; set; }

    public decimal? InsurancePaidAmount { get; set; }

    public decimal? TotalPaidAmount { get; set; }

    public decimal? AdjustmentAmount { get; set; }

    public DateTime? ImportedOn { get; set; }

    public int? ImportedFileId { get; set; }
}
