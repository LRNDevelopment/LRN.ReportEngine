/*
    Additive column migration. Nothing is renamed, retyped or dropped.

      dbo.LRN_Run_Log            + LabId, + WeekFolder
      dbo.LRN_Step_Log           + LabId
      dbo.ReportRunIdInfoLog     + SourceFileName
      dbo.ReportsWorkflowTracker + ReportTypeId  (FK -> dbo.ReportTypeMaster)

    LabId and WeekFolder are added to LRN_Run_Log because usp_ReportsWorkflowTracker_Upsert reads
    them from there: a developer sends only a RunId and the procedure fills in the lab context.
    Both tables previously carried LabName only.

    Existing rows are backfilled where the lab can be identified unambiguously by name.

    Run 03_ReportTypeMaster.sql first (the FK below depends on it).
    Idempotent - safe to re-run.
*/

USE [LRNMaster];
GO
SET NOCOUNT ON;
GO

/* ---------- dbo.LRN_Run_Log ---------- */
IF COL_LENGTH('dbo.LRN_Run_Log', 'LabId') IS NULL
BEGIN
    ALTER TABLE [dbo].[LRN_Run_Log] ADD [LabId] INT NULL;
    PRINT 'LRN_Run_Log + LabId';
END
GO

IF COL_LENGTH('dbo.LRN_Run_Log', 'WeekFolder') IS NULL
BEGIN
    ALTER TABLE [dbo].[LRN_Run_Log] ADD [WeekFolder] VARCHAR(200) NULL;
    PRINT 'LRN_Run_Log + WeekFolder';
END
GO

/* ---------- dbo.LRN_Step_Log ---------- */
IF COL_LENGTH('dbo.LRN_Step_Log', 'LabId') IS NULL
BEGIN
    ALTER TABLE [dbo].[LRN_Step_Log] ADD [LabId] INT NULL;
    PRINT 'LRN_Step_Log + LabId';
END
GO

/* ---------- dbo.ReportRunIdInfoLog ---------- */
IF COL_LENGTH('dbo.ReportRunIdInfoLog', 'SourceFileName') IS NULL
BEGIN
    ALTER TABLE [dbo].[ReportRunIdInfoLog] ADD [SourceFileName] NVARCHAR(400) NULL;
    PRINT 'ReportRunIdInfoLog + SourceFileName';
END
GO

/* ---------- dbo.ReportsWorkflowTracker ---------- */
IF COL_LENGTH('dbo.ReportsWorkflowTracker', 'ReportTypeId') IS NULL
BEGIN
    ALTER TABLE [dbo].[ReportsWorkflowTracker] ADD [ReportTypeId] INT NULL;
    PRINT 'ReportsWorkflowTracker + ReportTypeId';
END
GO

IF OBJECT_ID('dbo.ReportTypeMaster', 'U') IS NOT NULL
   AND NOT EXISTS (SELECT 1 FROM sys.foreign_keys WHERE name = 'FK_ReportsWorkflowTracker_ReportType')
BEGIN
    ALTER TABLE [dbo].[ReportsWorkflowTracker] WITH NOCHECK
        ADD CONSTRAINT [FK_ReportsWorkflowTracker_ReportType]
        FOREIGN KEY ([ReportTypeId]) REFERENCES [dbo].[ReportTypeMaster] ([ReportTypeId]);
    PRINT 'ReportsWorkflowTracker + FK_ReportsWorkflowTracker_ReportType';
END
GO

/* ---------- backfill LabId from dbo.Labs, where the name matches exactly one lab ---------- */
IF OBJECT_ID('dbo.Labs', 'U') IS NOT NULL
BEGIN
    UPDATE r
    SET    r.LabId = m.LabId
    FROM   dbo.LRN_Run_Log r
    JOIN   dbo.Labs   m ON m.LabName = r.LabName
    WHERE  r.LabId IS NULL;

    PRINT CONCAT('LRN_Run_Log LabId backfilled: ', @@ROWCOUNT);

    UPDATE s
    SET    s.LabId = m.LabId
    FROM   dbo.LRN_Step_Log s
    JOIN   dbo.Labs   m ON m.LabName = s.LabName
    WHERE  s.LabId IS NULL;

    PRINT CONCAT('LRN_Step_Log LabId backfilled: ', @@ROWCOUNT);
END
ELSE
BEGIN
    PRINT 'dbo.Labs not present - LabId left NULL on existing rows (new rows are stamped by the worker).';
END
GO

/* Lab-scoped reporting over the run log. */
IF NOT EXISTS (SELECT 1 FROM sys.indexes
               WHERE name = 'IX_LRN_Run_Log_LabId' AND object_id = OBJECT_ID('dbo.LRN_Run_Log'))
    CREATE NONCLUSTERED INDEX [IX_LRN_Run_Log_LabId] ON [dbo].[LRN_Run_Log] ([LabId]) INCLUDE ([WeekFolder]);
GO

IF NOT EXISTS (SELECT 1 FROM sys.indexes
               WHERE name = 'IX_LRN_Step_Log_LabId' AND object_id = OBJECT_ID('dbo.LRN_Step_Log'))
    CREATE NONCLUSTERED INDEX [IX_LRN_Step_Log_LabId] ON [dbo].[LRN_Step_Log] ([LabId]);
GO
