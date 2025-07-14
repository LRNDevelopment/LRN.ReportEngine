using System;
using System.Collections.Generic;

namespace LRN.DataLibrary.Models;

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

    public string ImportFilePath { get; set; }
}
public class ImportFileLog
{
    public int ImportFileId { get; set; }  // Corresponds to [ImportFileId]
    public string LogType { get; set; }    // Corresponds to [LogType]
    public string LogMessage { get; set; } // Corresponds to [LogMessage]
    public int? RowNo { get; set; }        // Corresponds to [RowNo]
    public string ColumnName { get; set; } // Corresponds to [ColumnName]
    public DateTime? CreatedOn { get; set; } // Corresponds to [CreatedOn]
}