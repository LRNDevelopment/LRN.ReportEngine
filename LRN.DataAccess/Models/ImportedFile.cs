using System;
using System.Collections.Generic;

namespace LRN.DataAccess.Models;

public partial class ImportedFile
{
    public int ImportedFileId { get; set; }

    public string ImportFileName { get; set; } = null!;

    public int? ExcelRowCount { get; set; }

    public int? ImportedRowCount { get; set; }

    public int? FileStatus { get; set; }

    public int? FileType { get; set; }

    public DateTime? ImportedOn { get; set; }

    public DateTime? ProcessedOn { get; set; }

    public int LabId { get; set; }
}
