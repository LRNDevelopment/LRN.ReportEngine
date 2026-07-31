/*
    LRNMaster.dbo.ReportRunIdInfoLog

    Cross-lab, per-run information log. ADDITIVE: dbo.LRN_Run_Log, dbo.LRN_Step_Log and
    dbo.LRN_Error_Log are unchanged and keep receiving every write they receive today.

    RunId is VARCHAR(30) to match dbo.LRN_Run_Log.RunID from sql/Create_ProcessLogs.sql, which is
    the authoritative RunId type in this repo. (The brief sketched VARCHAR(50); 30 is what the
    existing table actually uses, and a FK-compatible width matters more than the sketch.)

    CreatedOn is IST, matching ProcessLogService.NowIST() and every other timestamp in this
    pipeline. It is written by the application, not defaulted to UTC, so the whole trail is in one
    time zone.

    Idempotent - safe to re-run.
*/

USE [LRNMaster];
GO

IF NOT EXISTS (SELECT 1 FROM sys.tables t JOIN sys.schemas s ON s.schema_id = t.schema_id
               WHERE s.name = 'dbo' AND t.name = 'ReportRunIdInfoLog')
BEGIN
    CREATE TABLE [dbo].[ReportRunIdInfoLog]
    (
        [ReportRunIdInfoLogId] BIGINT IDENTITY(1,1) NOT NULL
            CONSTRAINT [PK_ReportRunIdInfoLog] PRIMARY KEY CLUSTERED,
        [RunId]        VARCHAR(30)    NOT NULL,
        [ReportType]   VARCHAR(100)   NOT NULL,   -- 'Line Level' / 'Claim Level'
        [SourceSystem] VARCHAR(100)   NOT NULL,   -- lab name, or 'SharePoint'
        [LogType]      VARCHAR(50)    NOT NULL,   -- Start | Info | Warning | Error | End
        [LogMessage]   NVARCHAR(MAX)  NULL,
        [CreatedOn]    DATETIME2(3)   NOT NULL
            CONSTRAINT [DF_ReportRunIdInfoLog_CreatedOn] DEFAULT (SYSDATETIME()),
        [CreatedBy]    VARCHAR(100)   NOT NULL    -- process/account NAME, never an id
    );
END
GO

IF NOT EXISTS (SELECT 1 FROM sys.indexes
               WHERE name = 'IX_ReportRunIdInfoLog_RunId' AND object_id = OBJECT_ID('dbo.ReportRunIdInfoLog'))
BEGIN
    CREATE NONCLUSTERED INDEX [IX_ReportRunIdInfoLog_RunId]
        ON [dbo].[ReportRunIdInfoLog] ([RunId])
        INCLUDE ([ReportType], [LogType], [CreatedOn]);
END
GO

-- Error triage across all labs for a run.
IF NOT EXISTS (SELECT 1 FROM sys.indexes
               WHERE name = 'IX_ReportRunIdInfoLog_LogType_CreatedOn' AND object_id = OBJECT_ID('dbo.ReportRunIdInfoLog'))
BEGIN
    CREATE NONCLUSTERED INDEX [IX_ReportRunIdInfoLog_LogType_CreatedOn]
        ON [dbo].[ReportRunIdInfoLog] ([LogType], [CreatedOn] DESC)
        INCLUDE ([RunId], [ReportType], [SourceSystem]);
END
GO
