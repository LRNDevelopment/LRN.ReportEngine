using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;
using LRN.DataLibrary.Abstractions;

namespace LRN.DataLibrary.Entities;

[Table("LRN_STEP_LOG")]
public class LrnStepLog
{
    [Key]
    public long StepLogId { get; set; }

    public long RunID { get; set; }

    [MaxLength(200)]
    public string LabName { get; set; } = string.Empty;

    public int StepSeq { get; set; }

    [MaxLength(200)]
    public string StepName { get; set; } = string.Empty;

    [MaxLength(200)]
    public string StepCategory { get; set; } = string.Empty;

    [MaxLength(100)]
    public string SourceSystem { get; set; } = "LRN.MasterFileProcessor";

    public DateTimeOffset StartTimeUSST { get; set; }

    public DateTimeOffset? EndTimeUSST { get; set; }

    [MaxLength(50)]
    public string Status { get; set; } = LrnStatuses.Pending;

    public long? RecordsIn { get; set; }
    public long? RecordsOut { get; set; }

    [MaxLength(500)]
    public string? FileNameIn { get; set; }

    [MaxLength(500)]
    public string? FileNameOut { get; set; }

    [MaxLength(1000)]
    public string? PathIn { get; set; }

    [MaxLength(1000)]
    public string? PathOut { get; set; }

    [MaxLength(100)]
    public string? ErrorCode { get; set; }

    [MaxLength(2000)]
    public string? ErrorMessage { get; set; }

    [MaxLength(4000)]
    public string? ErrorDetail { get; set; }

    public int RetryCount { get; set; }

    [MaxLength(200)]
    public string? ExecutedBy { get; set; }

    [MaxLength(200)]
    public string? Host { get; set; }

    [MaxLength(100)]
    public string? ModuleVersion { get; set; }
}
