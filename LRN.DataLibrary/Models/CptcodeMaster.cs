using System;
using System.Collections.Generic;

namespace LRN.DataLibrary.Models;

public partial class CptcodeMaster
{
    public int CptcodeId { get; set; }

    public string Cptcode { get; set; } = null!;

    public string? CodeDescription { get; set; }

    public string? OriginalCode { get; set; }

    public bool IsActive { get; set; }

    public DateTime? CreatedOn { get; set; }
}
