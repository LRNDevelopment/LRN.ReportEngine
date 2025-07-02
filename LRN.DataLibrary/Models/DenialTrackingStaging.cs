using System;
using System.Collections.Generic;

namespace LRN.DataLibrary.Models;

public partial class DenialTrackingStaging
{
    public string? Provider { get; set; }

    public string? TransactionCarrierCode { get; set; }

    public string? FinancialClass { get; set; }

    public DateOnly? PaymentDate { get; set; }

    public string? PaymentReasonCode { get; set; }

    public string? PaymentReasonDescription { get; set; }

    public string? ChargeCode { get; set; }

    public string? PatientName { get; set; }

    public DateOnly? ServiceDate { get; set; }

    public string? VisitNumber { get; set; }

    public decimal? Charge { get; set; }

    public decimal? TotalBalance { get; set; }

    public decimal? TotalAdjustment { get; set; }

    public decimal? ReasonAmount { get; set; }

    public string? DenialUser { get; set; }

    public DateOnly? LastActionDate { get; set; }

    public string? LastAction { get; set; }

    public DateOnly? NextActionDate { get; set; }

    public string? NextAction { get; set; }

    public string? Note { get; set; }

    public string? DenialCategoryCode { get; set; }

    public string? DenialCategoryDescription { get; set; }

    public DateTime? ImportedOn { get; set; }

    public int? ImportedFileId { get; set; }
}
