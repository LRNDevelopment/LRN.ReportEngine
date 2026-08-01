/*
    dbo.usp_ReportsWorkflowTracker_Upsert

    Public entry point for any team recording a report outcome against a run.

    The caller sends a RunId and a ReportName. Everything else about the lab is looked up here:

        LabId, LabName, WeekFolder   <-  dbo.LRN_Run_Log  (by RunId)
        ReportTypeId, ReportType     <-  dbo.ReportTypeMaster (by ReportName)

    so no two teams have to agree on how to spell a lab or a report.

    CALL:
        EXEC dbo.usp_ReportsWorkflowTracker_Upsert
             @RunId       = '20260801R0003',
             @ReportName  = 'Line Level Master',
             @Status      = 'Success',
             @RowCount    = 195161,
             @StartedOn   = '2026-08-01T10:15:00',
             @CompletedOn = '2026-08-01T10:15:23',
             @Remarks     = NULL,
             @CreatedBy   = 'LRN.MasterFileProcessorWorker';

    CreatedOn defaults to GETDATE() - callers do not pass it.

    UPSERT on (RunId, LabID, ReportName): re-running a report for the same run updates the existing
    row instead of duplicating it. StartedOn is preserved from the first call so a later
    Success/Failed update does not erase when the work actually began.

    Validation is strict here, unlike the info-log procedure: this table drives the workflow
    dashboard, so a misspelt report name must fail loudly rather than create a phantom row.
*/

USE [LRNMaster];
GO

CREATE OR ALTER PROCEDURE [dbo].[usp_ReportsWorkflowTracker_Upsert]
    @RunId       VARCHAR(30),
    @ReportName  VARCHAR(200),
    @Status      VARCHAR(50),
    @RowCount    BIGINT        = NULL,
    @StartedOn   DATETIME2(3)  = NULL,
    @CompletedOn DATETIME2(3)  = NULL,
    @Remarks     NVARCHAR(MAX) = NULL,
    @CreatedBy   VARCHAR(100),
    @LabId       INT           = NULL,   -- optional override when the run log has no lab yet
    @WeekFolder  VARCHAR(200)  = NULL    -- optional override
AS
BEGIN
    SET NOCOUNT ON;

    IF NULLIF(LTRIM(RTRIM(@RunId)), '') IS NULL
    BEGIN
        RAISERROR('usp_ReportsWorkflowTracker_Upsert: @RunId is required.', 16, 1);
        RETURN;
    END

    IF @Status NOT IN ('Success', 'Failed', 'Skipped', 'InProgress')
    BEGIN
        RAISERROR('usp_ReportsWorkflowTracker_Upsert: @Status must be Success, Failed, Skipped or InProgress. Got "%s".', 16, 1, @Status);
        RETURN;
    END

    /* ---- report type, from the master by name ---- */
    DECLARE @ReportTypeId INT, @ReportTypeName VARCHAR(200);

    SELECT TOP (1) @ReportTypeId = ReportTypeId, @ReportTypeName = ReportTypeName
    FROM   dbo.ReportTypeMaster
    WHERE  ReportTypeName = @ReportName AND IsActive = 1;

    IF @ReportTypeId IS NULL
    BEGIN
        RAISERROR('usp_ReportsWorkflowTracker_Upsert: "%s" is not an active report in dbo.ReportTypeMaster. Add it there first.', 16, 1, @ReportName);
        RETURN;
    END

    /* ---- lab context, from the run log ---- */
    DECLARE @LabName VARCHAR(200);

    SELECT TOP (1)
           @LabId      = COALESCE(@LabId, r.LabId),
           @LabName    = r.LabName,
           @WeekFolder = COALESCE(@WeekFolder, r.WeekFolder)
    FROM   dbo.LRN_Run_Log r
    WHERE  r.RunID = @RunId
    ORDER BY r.StartTimeIST DESC;

    IF @LabName IS NULL AND @LabId IS NULL
    BEGIN
        RAISERROR('usp_ReportsWorkflowTracker_Upsert: RunId "%s" was not found in dbo.LRN_Run_Log and no @LabId was supplied.', 16, 1, @RunId);
        RETURN;
    END

    -- LabID is part of the natural key, so it cannot be NULL. -1 marks "run log had no lab id yet"
    -- and is still upsertable; it gets corrected on the next call once the run log is stamped.
    SET @LabId = ISNULL(@LabId, -1);

    /* ---- upsert ---- */
    MERGE dbo.ReportsWorkflowTracker WITH (HOLDLOCK) AS target
    USING (SELECT @RunId AS RunId, @LabId AS LabID, @ReportName AS ReportName) AS source
        ON  target.RunId      = source.RunId
        AND target.LabID      = source.LabID
        AND target.ReportName = source.ReportName
    WHEN MATCHED THEN
        UPDATE SET LabName      = ISNULL(@LabName, target.LabName),
                   WeekFolder   = ISNULL(@WeekFolder, target.WeekFolder),
                   ReportTypeId = @ReportTypeId,
                   ReportType   = @ReportTypeName,
                   Status       = @Status,
                   [RowCount]   = ISNULL(@RowCount, target.[RowCount]),
                   StartedOn    = ISNULL(target.StartedOn, @StartedOn),   -- keep the first start
                   CompletedOn  = ISNULL(@CompletedOn, target.CompletedOn),
                   Remarks      = @Remarks
    WHEN NOT MATCHED THEN
        INSERT (RunId, LabID, LabName, WeekFolder, ReportName, ReportTypeId, ReportType,
                Status, [RowCount], StartedOn, CompletedOn, Remarks, CreatedOn, CreatedBy)
        VALUES (@RunId, @LabId, @LabName, @WeekFolder, @ReportName, @ReportTypeId, @ReportTypeName,
                @Status, @RowCount, @StartedOn, @CompletedOn, @Remarks, GETDATE(), @CreatedBy);
END
GO

GRANT EXECUTE ON [dbo].[usp_ReportsWorkflowTracker_Upsert] TO [public];
GO
