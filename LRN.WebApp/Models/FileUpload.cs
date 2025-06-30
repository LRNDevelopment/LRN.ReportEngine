
using System;

public class FileUpload
{
    public int? ImportedFileId { get; set; }

    public string ImportFileName { get; set; } = null!;

    public int? ExcelRowCount { get; set; }

    public int? ImportedRowCount { get; set; }

    public int? FileStatus { get; set; }

    public DateTime? ImportedOn { get; set; }

    public int FileType { get; set; }

    public DateTime? ProcessedOn { get; set; }

    public string FileTypeName { get; set; }
    public string FileStatusName { get; set; }
}
