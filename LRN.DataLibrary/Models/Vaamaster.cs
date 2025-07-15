using System;
using System.Collections.Generic;

namespace LRN.DataLibrary.Models;

public partial class Vaamaster
{
    public string VisitNumber { get; set; } = null!;

    public string? AccessionNo { get; set; }

    public DateOnly? DateOfEntry { get; set; }

    public DateOnly? ServiceDate { get; set; }

    public DateTime? CreatedOn { get; set; }
}
