using System;
using System.Collections.Generic;

namespace LRN.DataAccess.Models;

public partial class ImportFilType
{
    public int FileTypeId { get; set; }

    public string? FileTypeName { get; set; }

    public int LabId { get; set; }

    public bool? IsActive { get; set; }
}
