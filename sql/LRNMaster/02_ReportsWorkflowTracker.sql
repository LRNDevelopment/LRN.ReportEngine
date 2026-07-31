/*
    LRNMaster.dbo.ReportsWorkflowTracker  (+ dbo.vw_ReportsWorkflowTracker_Wide)

    Modelled on Reports_Workflow_Tracker_v1.0.xlsx, but stored TALL (one row per
    RunId + LabID + ReportName) rather than wide.

    Why tall, when the workbook is wide:
      * The workbook has one Success/Failure column per report (Line Level Master, Claim Level
        Master, LIS Summary, Production Summary, Collection Summary, Denial Report, Executive
        Summary, Clinic Summary, Sales Rep Summary, Coding Validation, Payer Policy Validation,
        Forecasting, Prediction Analysis, Error Log). Adding a report to a wide table is an
        ALTER TABLE plus a code change; adding one here is a new row.
      * Per-report RowCount / StartedOn / CompletedOn / Remarks have nowhere to live in the wide
        shape without 4 columns per report.
      * The unique key makes the write idempotent on re-run, as the brief requires.

    The workbook's exact layout is reproduced by vw_ReportsWorkflowTracker_Wide below, so the
    spreadsheet can still be produced directly from the database.

    Idempotent - safe to re-run.
*/

USE [LRNMaster];
GO

IF NOT EXISTS (SELECT 1 FROM sys.tables t JOIN sys.schemas s ON s.schema_id = t.schema_id
               WHERE s.name = 'dbo' AND t.name = 'ReportsWorkflowTracker')
BEGIN
    CREATE TABLE [dbo].[ReportsWorkflowTracker]
    (
        [WorkflowTrackerId] BIGINT IDENTITY(1,1) NOT NULL
            CONSTRAINT [PK_ReportsWorkflowTracker] PRIMARY KEY CLUSTERED,
        [RunId]       VARCHAR(30)   NOT NULL,   -- matches dbo.LRN_Run_Log.RunID
        [LabID]       INT           NOT NULL,   -- NOT NULL so the unique key is reliable
        [LabName]     VARCHAR(200)  NULL,
        [WeekFolder]  VARCHAR(200)  NULL,       -- workbook column 'Week'
        [ReportName]  VARCHAR(200)  NOT NULL,   -- 'Line Level Master' / 'Claim Level Master' / ...
        [ReportType]  VARCHAR(100)  NULL,
        [Status]      VARCHAR(50)   NOT NULL,   -- Success | Failed | Skipped | InProgress
        [RowCount]    BIGINT        NULL,
        [StartedOn]   DATETIME2(3)  NULL,
        [CompletedOn] DATETIME2(3)  NULL,       -- workbook column 'Synced on'
        [Remarks]     NVARCHAR(MAX) NULL,
        [CreatedOn]   DATETIME2(3)  NOT NULL
            CONSTRAINT [DF_ReportsWorkflowTracker_CreatedOn] DEFAULT (SYSDATETIME()),
        [CreatedBy]   VARCHAR(100)  NOT NULL,
        CONSTRAINT [UQ_ReportsWorkflowTracker_Run_Report]
            UNIQUE ([RunId], [LabID], [ReportName])
    );
END
GO

IF NOT EXISTS (SELECT 1 FROM sys.indexes
               WHERE name = 'IX_ReportsWorkflowTracker_RunId' AND object_id = OBJECT_ID('dbo.ReportsWorkflowTracker'))
BEGIN
    CREATE NONCLUSTERED INDEX [IX_ReportsWorkflowTracker_RunId]
        ON [dbo].[ReportsWorkflowTracker] ([RunId])
        INCLUDE ([LabID], [ReportName], [Status]);
END
GO

/*
    Wide projection matching Reports_Workflow_Tracker_v1.0.xlsx column-for-column.
    Report names not yet produced by any pipeline simply come back NULL.
*/
CREATE OR ALTER VIEW [dbo].[vw_ReportsWorkflowTracker_Wide]
AS
SELECT
    t.LabName                                                        AS [Lab],
    MAX(t.CompletedOn)                                               AS [Synced on],
    t.RunId                                                          AS [RunID],
    MAX(t.WeekFolder)                                                AS [Week],
    MAX(CASE WHEN t.ReportName = 'Line Level Master'        THEN t.Status END) AS [Line Level Master],
    MAX(CASE WHEN t.ReportName = 'Claim Level Master'       THEN t.Status END) AS [Claim Level Master],
    MAX(CASE WHEN t.ReportName = 'LIS Summary'              THEN t.Status END) AS [LIS Summary],
    MAX(CASE WHEN t.ReportName = 'Production Summary'       THEN t.Status END) AS [Production Summary],
    MAX(CASE WHEN t.ReportName = 'Collection Summary'       THEN t.Status END) AS [Collection Summary],
    MAX(CASE WHEN t.ReportName = 'Denial Report'            THEN t.Status END) AS [Denial Report],
    MAX(CASE WHEN t.ReportName = 'Executive Summary'        THEN t.Status END) AS [Executive Summary],
    MAX(CASE WHEN t.ReportName = 'Clinic Summary'           THEN t.Status END) AS [Clinic Summary],
    MAX(CASE WHEN t.ReportName = 'Sales Rep Summary'        THEN t.Status END) AS [Sales Rep Summary],
    MAX(CASE WHEN t.ReportName = 'Coding Validation'        THEN t.Status END) AS [Coding Validation],
    MAX(CASE WHEN t.ReportName = 'Payer Policy Validation'  THEN t.Status END) AS [Payer Policy Validation],
    MAX(CASE WHEN t.ReportName = 'Forecasting'              THEN t.Status END) AS [Forecasting],
    MAX(CASE WHEN t.ReportName = 'Prediction Analysis'      THEN t.Status END) AS [Prediction Analysis],
    MAX(CASE WHEN t.ReportName = 'Error Log'                THEN t.Status END) AS [Error Log]
FROM dbo.ReportsWorkflowTracker AS t
GROUP BY t.RunId, t.LabID, t.LabName;
GO
