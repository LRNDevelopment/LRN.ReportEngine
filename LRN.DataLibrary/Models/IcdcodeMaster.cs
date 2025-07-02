using System;
using System.Collections.Generic;

namespace LRN.DataLibrary.Models;

public partial class IcdcodeMaster
{
    public int IcdcodeId { get; set; }

    public string Icd10code { get; set; } = null!;

    public string? CodeDescription { get; set; }

    public string? OriginalCode { get; set; }

    public bool IsActive { get; set; }

    public DateTime? CreatedOn { get; set; }
}
