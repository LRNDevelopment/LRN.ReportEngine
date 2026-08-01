/*
    LRNMaster.dbo.ReportTypeMaster

    Master list of the report types tracked in ReportsWorkflowTracker. The names match the column
    headers of Reports_Workflow_Tracker_v1.0.xlsx exactly, so a report name sent by a developer
    resolves without any translation.

    ReportTypeName is UNIQUE - it is the natural key developers send, and the workflow tracker
    procedure resolves ReportTypeId from it.

    Idempotent: safe to re-run. Re-running re-activates and re-seeds any missing type but never
    deletes or renumbers an existing one, so foreign keys stay valid.
*/

USE [LRNMaster];
GO

IF NOT EXISTS (SELECT 1 FROM sys.tables t JOIN sys.schemas s ON s.schema_id = t.schema_id
               WHERE s.name = 'dbo' AND t.name = 'ReportTypeMaster')
BEGIN
    CREATE TABLE [dbo].[ReportTypeMaster]
    (
        [ReportTypeId]   INT IDENTITY(1,1) NOT NULL
            CONSTRAINT [PK_ReportTypeMaster] PRIMARY KEY CLUSTERED,
        [ReportTypeName] VARCHAR(200)  NOT NULL,
        [IsActive]       BIT           NOT NULL
            CONSTRAINT [DF_ReportTypeMaster_IsActive] DEFAULT (1),
        [CreatedOn]      DATETIME2(3)  NOT NULL
            CONSTRAINT [DF_ReportTypeMaster_CreatedOn] DEFAULT (GETDATE()),
        CONSTRAINT [UQ_ReportTypeMaster_Name] UNIQUE ([ReportTypeName])
    );
END
GO

/* Seed / re-seed. MERGE so re-running adds anything new without touching existing ids. */
MERGE dbo.ReportTypeMaster AS target
USING (VALUES
        ('Line Level Master'),
        ('Claim Level Master'),
        ('LIS Summary'),
        ('Production Summary'),
        ('Collection Summary'),
        ('Denial Report'),
        ('Executive Summary'),
        ('Clinic Summary'),
        ('Sales Rep Summary'),
        ('Coding Validation'),
        ('Payer Policy Validation'),
        ('Forecasting'),
        ('Prediction Analysis')
      ) AS source (ReportTypeName)
    ON target.ReportTypeName = source.ReportTypeName
WHEN MATCHED AND target.IsActive = 0 THEN
    UPDATE SET IsActive = 1
WHEN NOT MATCHED BY TARGET THEN
    INSERT (ReportTypeName, IsActive) VALUES (source.ReportTypeName, 1);
GO

SELECT ReportTypeId, ReportTypeName, IsActive FROM dbo.ReportTypeMaster ORDER BY ReportTypeId;
GO
