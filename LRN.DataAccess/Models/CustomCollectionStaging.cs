using System;
using System.Collections.Generic;

namespace LRN.DataAccess.Models;

public partial class CustomCollectionStaging
{
    public long Ccwid { get; set; }

    public string? PayerName { get; set; }

    public string? PayerType { get; set; }

    public string? BillingProvider { get; set; }

    public string? ReferringProvider { get; set; }

    public string? PerformingLab { get; set; }

    public int? PatientId { get; set; }

    public string? PatientName { get; set; }

    public DateTime? Dob { get; set; }

    public string? ResponsibleParty { get; set; }

    public string? MemberId { get; set; }

    public int? ClaimId { get; set; }

    public string? ClientAccNum { get; set; }

    public string? AccessionNo { get; set; }

    public DateTime? BeginDos { get; set; }

    public DateTime? EndDos { get; set; }

    public DateTime? ChargeEntryDate { get; set; }

    public DateTime? LastBillDate { get; set; }

    public string? BillingFrequency { get; set; }

    public string? ChargeEnteredBy { get; set; }

    public string? BilledCptcode { get; set; }

    public string? Pos { get; set; }

    public string? Tos { get; set; }

    public string? Modifier { get; set; }

    public string? Icd10code { get; set; }

    public decimal? BilledAmount { get; set; }

    public decimal? AllowedAmount { get; set; }

    public decimal? InsurancePayments { get; set; }

    public decimal? InsuranceAdjustments { get; set; }

    public decimal? PatientPayments { get; set; }

    public decimal? PatientAdjustments { get; set; }

    public decimal? InsuranceBalance { get; set; }

    public decimal? PatientBalance { get; set; }

    public decimal? TotalBalance { get; set; }

    public DateTime? ImpotedOn { get; set; }

    public int? ImportedFileId { get; set; }
}
