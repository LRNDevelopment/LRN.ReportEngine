using System;
using System.Collections.Generic;

namespace LRN.DataAccess.Models;

public partial class TransactionSummary
{
    public int VisitNumber { get; set; }

    public string Cptcode { get; set; } = null!;

    public string? CheckNumber { get; set; }

    public DateOnly? DateOfDeposit { get; set; }

    public DateOnly? DateOfEntry { get; set; }

    public string TransactionType { get; set; } = null!;

    public int Units { get; set; }

    public decimal TotalBilledAmount { get; set; }

    public decimal AdjustmentAmount { get; set; }

    public decimal PatientPaidAmount { get; set; }

    public decimal TotalPaidAmount { get; set; }

    public decimal InsurancePaidAmount { get; set; }

    public DateTime? CreatedOn { get; set; }
}
