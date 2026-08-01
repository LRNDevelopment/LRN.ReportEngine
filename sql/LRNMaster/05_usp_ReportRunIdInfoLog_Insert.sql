/*
    dbo.usp_ReportRunIdInfoLog_Insert

    Public entry point for any team writing to ReportRunIdInfoLog. Callers never touch the table
    directly, so column changes stay behind this contract.

    CALL:
        EXEC dbo.usp_ReportRunIdInfoLog_Insert
             @RunId          = '20260801R0003',
             @ReportType     = 'Line Level Master',
             @SourceSystem   = 'Certus',
             @SourceFileName = '20260801R0003_Certus_Line Level_07.20.2026 to 07.26.2026.csv',
             @LogType        = 'Info',
             @LogMessage     = 'Bulk copy completed. Rows=195161.',
             @CreatedBy      = 'LRN.MasterFileProcessorWorker';

    CreatedOn defaults to GETDATE() - callers do not pass it.

    @LogType must be one of Start / Info / Warning / Error / End. Anything else is rejected rather
    than stored, so the log stays queryable by type.

    @ReportType is free text on purpose: this is a progress log and a caller may want finer-grained
    labels than the master list. When the value does match dbo.ReportTypeMaster the id is resolved
    and stored alongside, so the log can still be joined to the master.

    Never throws for a bad @ReportType - logging must not break a caller's pipeline. It throws only
    for a missing @RunId or an invalid @LogType, which are caller bugs worth surfacing.
*/

USE [LRNMaster];
GO

CREATE OR ALTER PROCEDURE [dbo].[usp_ReportRunIdInfoLog_Insert]
    @RunId          VARCHAR(30),
    @ReportType     VARCHAR(100),
    @SourceSystem   VARCHAR(100),
    @SourceFileName NVARCHAR(400) = NULL,
    @LogType        VARCHAR(50),
    @LogMessage     NVARCHAR(MAX) = NULL,
    @CreatedBy      VARCHAR(100),
    @ReportRunIdInfoLogId BIGINT = NULL OUTPUT
AS
BEGIN
    SET NOCOUNT ON;

    IF NULLIF(LTRIM(RTRIM(@RunId)), '') IS NULL
    BEGIN
        RAISERROR('usp_ReportRunIdInfoLog_Insert: @RunId is required.', 16, 1);
        RETURN;
    END

    IF @LogType NOT IN ('Start', 'Info', 'Warning', 'Error', 'End')
    BEGIN
        RAISERROR('usp_ReportRunIdInfoLog_Insert: @LogType must be Start, Info, Warning, Error or End. Got "%s".', 16, 1, @LogType);
        RETURN;
    END

    DECLARE @ReportTypeId INT =
    (
        SELECT TOP (1) ReportTypeId
        FROM   dbo.ReportTypeMaster
        WHERE  ReportTypeName = @ReportType AND IsActive = 1
    );

    INSERT INTO dbo.ReportRunIdInfoLog
        (RunId, ReportType, SourceSystem, SourceFileName, LogType, LogMessage, CreatedBy, CreatedOn)
    VALUES
        (LTRIM(RTRIM(@RunId)), @ReportType, @SourceSystem, @SourceFileName,
         @LogType, @LogMessage, @CreatedBy, GETDATE());

    SET @ReportRunIdInfoLogId = SCOPE_IDENTITY();
END
GO

GRANT EXECUTE ON [dbo].[usp_ReportRunIdInfoLog_Insert] TO [public];
GO
