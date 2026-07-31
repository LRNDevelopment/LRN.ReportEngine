/*
    dbo.LineClaimFileLogs - one row per line-level / claim-level file copied into this lab database.

    Run against EVERY lab database. Idempotent, and safe on databases where the table already
    exists: it creates the table only when missing, and adds the outcome columns only when missing.
    Nothing is ever renamed, retyped or dropped.

    Column types match BulkLoad/AuditColumns.cs exactly, because FileLogId / RunId / WeekFolder /
    SourceFullPath / FileName / FileType / LabName are stamped from here onto every row of
    LineLevelData and ClaimLevelData. If you change one, change both.

    USAGE:  sqlcmd -S <server> -d <LabDb> -E -i 02_LineClaimFileLogs.sql
*/

SET NOCOUNT ON;
GO

IF NOT EXISTS (SELECT 1 FROM sys.tables t JOIN sys.schemas s ON s.schema_id = t.schema_id
               WHERE s.name = 'dbo' AND t.name = 'LineClaimFileLogs')
BEGIN
    CREATE TABLE [dbo].[LineClaimFileLogs]
    (
        [FileLogId]           BIGINT IDENTITY(1,1) NOT NULL
            CONSTRAINT [PK_LineClaimFileLogs] PRIMARY KEY CLUSTERED,
        [RunId]               VARCHAR(30)    NOT NULL,
        [WeekFolder]          NVARCHAR(200)  NULL,
        [LabName]             NVARCHAR(200)  NULL,
        [SourceFullPath]      NVARCHAR(1000) NULL,
        [FileName]            NVARCHAR(400)  NULL,
        [FileType]            VARCHAR(20)    NOT NULL,   -- 'Line Level' / 'Claim Level'
        [FileCreatedDateTime] DATETIME2(3)   NULL,
        [InsertedDateTime]    DATETIME2(3)   NOT NULL
            CONSTRAINT [DF_LineClaimFileLogs_InsertedDateTime] DEFAULT (SYSDATETIME()),

        -- Outcome of the copy. Separate columns rather than overloading an existing one.
        [Status]              VARCHAR(50)    NULL,       -- Success | Failed | Skipped | InProgress
        [RowsCopied]          BIGINT         NULL,
        [ErrorMessage]        NVARCHAR(MAX)  NULL,
        [CompletedDateTime]   DATETIME2(3)   NULL
    );

    PRINT '  created dbo.LineClaimFileLogs';
END
ELSE
BEGIN
    -- Pre-existing table: add only the outcome columns, leaving the original ones untouched.
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

IF NOT EXISTS (SELECT 1 FROM sys.indexes
               WHERE name = 'IX_LineClaimFileLogs_RunId_FileType'
                 AND object_id = OBJECT_ID('dbo.LineClaimFileLogs'))
BEGIN
    CREATE NONCLUSTERED INDEX [IX_LineClaimFileLogs_RunId_FileType]
        ON [dbo].[LineClaimFileLogs] ([RunId], [FileType]);
END
GO
