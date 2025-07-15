using System;
using System.Collections.Generic;

namespace LRN.DataLibrary.Models;

public partial class ImportFileLog
{
    public int LogId { get; set; }

    public int ImportFileId { get; set; }

    public string LogType { get; set; } = null!;

    public string LogMessage { get; set; } = null!;

    public int? RowNo { get; set; }

    public string? ColumnName { get; set; }

    public DateTime? CreatedOn { get; set; }
}
