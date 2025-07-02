using System;
using System.Collections.Generic;

namespace LRN.DataLibrary.Models;

public partial class ImportFilType
{
    public int FileTypeId { get; set; }

    public string? FileTypeName { get; set; }

    public int LabId { get; set; }

    public bool? IsActive { get; set; }
}
