using System;
using System.Collections.Generic;

namespace LRN.DataAccess.Models;

public partial class SampleFinalStatus
{
    public string VisitNumber { get; set; } = null!;

    public string FinalStatus { get; set; } = null!;

    public string ClaimSubStatus { get; set; } = null!;
}
