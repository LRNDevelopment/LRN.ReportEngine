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
        -- Column order in the workbook / pivot. NOT the same as ReportTypeId, which is just the
        -- insert order and happened to come out alphabetical.
        [DisplayOrder]   INT           NOT NULL
            CONSTRAINT [DF_ReportTypeMaster_DisplayOrder] DEFAULT (999),
        [CreatedOn]      DATETIME2(3)  NOT NULL
            CONSTRAINT [DF_ReportTypeMaster_CreatedOn] DEFAULT (GETDATE()),
        CONSTRAINT [UQ_ReportTypeMaster_Name] UNIQUE ([ReportTypeName])
    );
END
GO

/* DisplayOrder for databases created before the column existed. */
IF COL_LENGTH('dbo.ReportTypeMaster', 'DisplayOrder') IS NULL
BEGIN
    ALTER TABLE [dbo].[ReportTypeMaster] ADD [DisplayOrder] INT NOT NULL
        CONSTRAINT [DF_ReportTypeMaster_DisplayOrder] DEFAULT (999);
    PRINT 'ReportTypeMaster + DisplayOrder';
END
GO

/*
    Seed / re-seed. The order below is the column order of
    Reports_Workflow_Tracker_v1.0.xlsx, which is how the business reads the dashboard - line level
    and claim level first, then the summaries, then the validations. MERGE so re-running adds
    anything new and corrects DisplayOrder without renumbering existing ids.
*/
MERGE dbo.ReportTypeMaster AS target
USING (VALUES
        ( 1, 'Line Level Master'),
        ( 2, 'Claim Level Master'),
        ( 3, 'LIS Summary'),
        ( 4, 'Production Summary'),
        ( 5, 'Collection Summary'),
        ( 6, 'Denial Report'),
        ( 7, 'Executive Summary'),
        ( 8, 'Clinic Summary'),
        ( 9, 'Sales Rep Summary'),
        (10, 'Coding Validation'),
        (11, 'Payer Policy Validation'),
        (12, 'Forecasting'),
        (13, 'Prediction Analysis'),
        (14, 'Error Log')
      ) AS source (DisplayOrder, ReportTypeName)
    ON target.ReportTypeName = source.ReportTypeName
WHEN MATCHED THEN
    UPDATE SET IsActive = 1, DisplayOrder = source.DisplayOrder
WHEN NOT MATCHED BY TARGET THEN
    INSERT (ReportTypeName, IsActive, DisplayOrder)
    VALUES (source.ReportTypeName, 1, source.DisplayOrder);
GO

SELECT ReportTypeId, ReportTypeName, IsActive, DisplayOrder FROM dbo.ReportTypeMaster ORDER BY DisplayOrder;
GO
