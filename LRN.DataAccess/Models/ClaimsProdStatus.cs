using System;
using System.Collections.Generic;

namespace LRN.DataAccess.Models;

public partial class ClaimsProdStatus
{
    public int ClaimId { get; set; }

    public DateOnly? SampleResultedDate { get; set; }

    public DateOnly? FirstBillDate { get; set; }

    public double? BilledAmount { get; set; }

    public double? AllowedAmount { get; set; }

    public double? InsurancePayment { get; set; }

    public double? InsuranceAdjustment { get; set; }

    public double? PatientPaidAmount { get; set; }

    public double? PatientAdjustment { get; set; }

    public double? InsuranceBalance { get; set; }

    public double? PatientBalance { get; set; }

    public double? TotalBalance { get; set; }

    public string? DenialCode { get; set; }

    public string? FinalStatus { get; set; }
}
