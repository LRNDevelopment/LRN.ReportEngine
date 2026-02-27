using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;

namespace LRN.DataLibrary.Entities;

[Table("LRN_Error_Log")]
public class LrnErrorLog
{
    [Key]
    public long ErrorLogId { get; set; }

    public long RunID { get; set; }

    [MaxLength(200)]
    public string LabName { get; set; } = string.Empty;

    public DateTimeOffset ErrorTimeIST { get; set; }

    [MaxLength(50)]
    public string Severity { get; set; } = "Error"; // Error | Warning

    [MaxLength(200)]
    public string? StepName { get; set; }

    [MaxLength(100)]
    public string? ErrorCode { get; set; }

    [MaxLength(500)]
    public string ErrorSummary { get; set; } = string.Empty;

    [MaxLength(2000)]
    public string? MissingColumns { get; set; }

    [MaxLength(200)]
    public string? SheetName { get; set; }

    [MaxLength(500)]
    public string? FileName { get; set; }

    [MaxLength(1000)]
    public string? FilePath { get; set; }

    [MaxLength(1000)]
    public string? RecommendedAction { get; set; }

    [MaxLength(100)]
    public string SourceSystem { get; set; } = "LRN.MasterFileProcessor";

    [MaxLength(50)]
    public string Status { get; set; } = "Open";
}
