using System;
using System.Collections.Generic;

namespace LRN.DataAccess.Models;

public partial class TrasactionMaster
{
    public int TransactionDetailId { get; set; }

    public int LismasterId { get; set; }

    public int LabIdentityKey { get; set; }

    public string? TransactionType { get; set; }

    public string? ChartNumber { get; set; }

    public string? VisitNo { get; set; }

    public string? Cptcode { get; set; }

    public string? TransactionCodeDesc { get; set; }

    public int? Modifiers { get; set; }

    public string? VisitPrimaryCarrier { get; set; }

    public string? VisitSecondaryCarrier { get; set; }

    public string? TransactionCarrier { get; set; }

    public string? PrimaryDxIcd10 { get; set; }

    public string? PrimaryDxIcd9 { get; set; }

    public string? PaymentMethod { get; set; }

    public string? CheckNumber { get; set; }

    public string? Void { get; set; }

    public int? Units { get; set; }

    public decimal? TotalBilledAmount { get; set; }

    public decimal? PatientPaidAmount { get; set; }

    public decimal? InsurancePaidAmount { get; set; }

    public decimal? TotalPaidAmount { get; set; }

    public decimal? AdjustmentAmount { get; set; }

    public DateTime? CreatedOn { get; set; }

    public DateTime? UpdatedOn { get; set; }
}
