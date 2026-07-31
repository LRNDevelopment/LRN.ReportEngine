/*
    ADDITIVE migration for dbo.LineClaimFileLogs, run once per LAB database.

    The existing columns (FileLogId, RunId, WeekFolder, LabName, SourceFullPath, FileName,
    FileType, FileCreatedDateTime, InsertedDateTime) are NOT touched, renamed or retyped.

    Four outcome columns are added rather than overloading an existing one, so the file log can
    record how a copy ended:

        Status             Success | Failed | Skipped | InProgress
        RowsCopied         verified destination row count
        ErrorMessage       failure detail
        CompletedDateTime  when the copy finished (IST, written by the application)

    LineClaimFileLogRepository.TryCompleteAsync guards on COL_LENGTH, so the worker runs correctly
    against a database where this migration has NOT yet been applied - it simply skips the update.
    Deploy this at your convenience; nothing breaks in the meantime.

    Run against every lab database. Idempotent - safe to re-run.

    USAGE:  sqlcmd -S <server> -d <LabDb> -i 03_LineClaimFileLogs_AddStatusColumns.sql
*/

SET NOCOUNT ON;
GO

IF OBJECT_ID('dbo.LineClaimFileLogs', 'U') IS NULL
BEGIN
    RAISERROR('dbo.LineClaimFileLogs does not exist in this database. Nothing to migrate.', 10, 1) WITH NOWAIT;
END
ELSE
BEGIN
    IF COL_LENGTH('dbo.LineClaimFileLogs', 'Status') IS NULL
    BEGIN
        ALTER TABLE [dbo].[LineClaimFileLogs] ADD [Status] VARCHAR(50) NULL;
        PRINT '  + Status';
    END

    IF COL_LENGTH('dbo.LineClaimFileLogs', 'RowsCopied') IS NULL
    BEGIN
        ALTER TABLE [dbo].[LineClaimFileLogs] ADD [RowsCopied] BIGINT NULL;
        PRINT '  + RowsCopied';
    END

    IF COL_LENGTH('dbo.LineClaimFileLogs', 'ErrorMessage') IS NULL
    BEGIN
        ALTER TABLE [dbo].[LineClaimFileLogs] ADD [ErrorMessage] NVARCHAR(MAX) NULL;
        PRINT '  + ErrorMessage';
    END

    IF COL_LENGTH('dbo.LineClaimFileLogs', 'CompletedDateTime') IS NULL
    BEGIN
        ALTER TABLE [dbo].[LineClaimFileLogs] ADD [CompletedDateTime] DATETIME2(3) NULL;
        PRINT '  + CompletedDateTime';
    END
END
GO

-- Data rows join back to their file log by FileLogId; make that lookup cheap.
IF OBJECT_ID('dbo.LineClaimFileLogs', 'U') IS NOT NULL
   AND NOT EXISTS (SELECT 1 FROM sys.indexes
                   WHERE name = 'IX_LineClaimFileLogs_RunId_FileType'
                     AND object_id = OBJECT_ID('dbo.LineClaimFileLogs'))
BEGIN
    CREATE NONCLUSTERED INDEX [IX_LineClaimFileLogs_RunId_FileType]
        ON [dbo].[LineClaimFileLogs] ([RunId], [FileType]);
END
GO
