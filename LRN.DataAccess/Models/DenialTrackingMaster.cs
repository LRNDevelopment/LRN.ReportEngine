using System;
using System.Collections.Generic;

namespace LRN.DataAccess.Models;

public partial class DenialTrackingMaster
{
    public int DenailTrackId { get; set; }

    public int? LismasterId { get; set; }

    public string? VisitNumber { get; set; }

    public string? Cptcodes { get; set; }

    public string? TransactionCarrierCode { get; set; }

    public DateTime? PaymentDate { get; set; }

    public string? PaymentReasonCode { get; set; }

    public DateTime? DateOfService { get; set; }

    public decimal? ChargeAmount { get; set; }

    public decimal? TotalBalance { get; set; }

    public decimal? TotalAdjustment { get; set; }

    public decimal? ReasonAmount { get; set; }

    public string? DenailUser { get; set; }

    public string? LastAction { get; set; }

    public string? NextAction { get; set; }

    public DateTime? LastActionDate { get; set; }

    public DateTime? NextActionDate { get; set; }

    public string? Note { get; set; }

    public string? DenialCategoryCode { get; set; }

    public string? DenialCategoryDescription { get; set; }

    public DateTime? CreateOn { get; set; }

    public DateTime? UpdatedOn { get; set; }
}
