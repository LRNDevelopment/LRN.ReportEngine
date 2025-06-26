using System;
using System.Collections.Generic;

namespace LRN.DataAccess.Models;

public partial class PrismBillingStaging
{
    public string? SpecimenId { get; set; }

    public string? Customer { get; set; }

    public string? Notes { get; set; }

    public string? Payments { get; set; }

    public string? Lab { get; set; }

    public string? TestInfo { get; set; }

    public string? Meds { get; set; }

    public decimal? Paid { get; set; }

    public string? SheetName { get; set; }

    public DateTime? ImportedOn { get; set; }

    public int? ImportedFileId { get; set; }
}
