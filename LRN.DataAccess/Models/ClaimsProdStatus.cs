using System;
using System.Collections.Generic;

namespace LRN.DataAccess.Models;

public partial class ClaimsProdStatus
{
    public int VisitNumber { get; set; }

    public string Cptcode { get; set; } = null!;

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

    public string? ClaimSubStatus { get; set; }

    public DateTime? CreatedOn { get; set; }
}
