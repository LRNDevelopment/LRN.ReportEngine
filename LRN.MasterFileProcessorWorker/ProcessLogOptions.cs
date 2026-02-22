public sealed class ProcessLogOptions
{
    public bool Enabled { get; set; } = true;

    // Table names should match the SQL script (Create_ProcessLogs.sql)
    public string RunLogTable { get; set; } = "dbo.LRN_Run_Log";
    public string StepLogTable { get; set; } = "dbo.LRN_Step_Log";
    public string ErrorLogTable { get; set; } = "dbo.LRN_Error_Log";

    // Stored proc that generates RUN-YYYY-MM-DD-0001
    public string NextRunIdStoredProc { get; set; } = "dbo.sp_LRN_NextRunId";

    // Defaults used when worker doesn't supply values
    public string DefaultPipelineName { get; set; } = "LRN.MasterFileProcessorWorker";
    public string DefaultTriggerType { get; set; } = "Schedule";
    public string DefaultTriggeredBy { get; set; } = "Worker";
}
