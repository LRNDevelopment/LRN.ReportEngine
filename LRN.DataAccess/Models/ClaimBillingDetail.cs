using System;
using System.Collections.Generic;

namespace LRN.DataAccess.Models;

public partial class ClaimBillingDetail
{
    public int BillingDetailId { get; set; }

    public string AccessionNo { get; set; } = null!;

    public string VisitNumber { get; set; } = null!;

    public string Cptcode { get; set; } = null!;

    public DateOnly? FirstBillDate { get; set; }

    public decimal? BilledAmount { get; set; }

    public decimal? AllowedAmount { get; set; }

    public decimal? InsurancePaidAmount { get; set; }

    public decimal? InsuranceAdjustmentAmount { get; set; }

    public decimal? PatientPaidAmount { get; set; }

    public decimal? PatientAdjustmentAmount { get; set; }

    public decimal? InsuranceBalance { get; set; }

    public decimal? PatientBalance { get; set; }

    public decimal? TotalBalance { get; set; }

    public DateTime? CreatedOn { get; set; }
}
