using System;
using System.Collections.Generic;

namespace LRN.DataAccess.Models;

public partial class SalesPerson
{
    public int SalesPersonId { get; set; }

    public string? FirstName { get; set; }

    public string? LastName { get; set; }

    public string SalesPersonName { get; set; } = null!;

    public int? ReportingTo { get; set; }

    public int ReportingLevelTop { get; set; }

    public byte Status { get; set; }

    public DateTime? CreatedDate { get; set; }
}
