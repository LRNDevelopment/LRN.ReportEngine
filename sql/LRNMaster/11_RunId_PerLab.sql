/*
    Per-lab RunIds:  R<YYYYMMDD><SHORT><NNNN>     e.g. R20260803CRT0001

    Replaces the old global daily counter (20260801R0007), where every lab shared one sequence and
    the id said nothing about which lab it belonged to.

    The counter is per lab and CONTINUOUS - it never resets, so the number is that lab's lifetime run
    number. Certus's 44th run ever is R20260804CRT0044 whatever the date. Two labs running on the
    same day get their own sequences:

        R20260803CRT0041   R20260803NWL0016
        R20260803CRT0042   R20260804NWL0017
        R20260804CRT0043

    Old-format ids already in the log tables stay exactly as they are. The two shapes never collide -
    the new one starts with 'R' and the old one starts with a digit - so nothing needs migrating.

    Width: 1 + 8 + 3 + 4 = 16 characters against VARCHAR(30) columns, leaving room for the sequence
    to grow past 9999 (see the padding note in the procedure).

    Idempotent - safe to re-run.
*/

USE [LRNMaster];
GO

/* ------------------------------------------------------------------ *
 *  1.  dbo.Labs.ShortName - the code that goes in the RunId
 * ------------------------------------------------------------------ */

IF COL_LENGTH('dbo.Labs', 'ShortName') IS NULL
BEGIN
    ALTER TABLE [dbo].[Labs] ADD [ShortName] VARCHAR(10) NULL;
    PRINT 'dbo.Labs + ShortName';
END
GO

/* Two labs sharing a code would silently interleave their sequences. */
IF NOT EXISTS (SELECT 1 FROM sys.indexes WHERE name = 'UQ_Labs_ShortName' AND object_id = OBJECT_ID('dbo.Labs'))
BEGIN
    CREATE UNIQUE NONCLUSTERED INDEX [UQ_Labs_ShortName]
        ON [dbo].[Labs] ([ShortName]) WHERE [ShortName] IS NOT NULL;
END
GO

/*
    Seeded by LabId, not by name: dbo.Labs spells them differently from the worker config
    ('Northwest' vs 'NorthWest', 'Augustus_Labs' vs 'Augustus'), and LabId is the identity the
    alignment work already settled on.
*/
MERGE dbo.Labs AS target
USING (VALUES
        ( 2, 'INH', 'InHealth'),
        ( 4, 'COV', 'Cove'),
        ( 6, 'PAL', 'PCRDx - AL'),
        ( 7, 'PCO', 'PCRDx - CO'),
        ( 9, 'RST', 'Rising Tides'),
        (10, 'BCT', 'BeechTree'),
        (12, 'PHY', 'Phi Life'),
        (13, 'PLA', 'PCR Labs of America'),
        (16, 'ELX', 'Elixir'),
        (18, 'CRT', 'Certus'),
        (23, 'NWL', 'Northwest'),
        (24, 'AUG', 'Augustus_Labs')
      ) AS source (LabId, ShortName, ExpectedName)
    ON target.LabId = source.LabId
WHEN MATCHED THEN
    UPDATE SET ShortName = source.ShortName;
GO

/* Anything active that can still not produce a RunId. */
IF EXISTS (SELECT 1 FROM dbo.Labs WHERE IsActive = 1 AND ShortName IS NULL AND LabId <> 999)
BEGIN
    PRINT 'WARNING - active labs with no ShortName (they cannot generate a RunId):';
    SELECT LabId, LabName FROM dbo.Labs WHERE IsActive = 1 AND ShortName IS NULL AND LabId <> 999;
END
GO

/* ------------------------------------------------------------------ *
 *  2.  dbo.LRN_RunIdSequence - one continuous counter per lab
 * ------------------------------------------------------------------ */

/*
    The old table was keyed on RunDate alone - one global counter that reset daily. That is a
    different thing from what we now store, so it is set aside rather than reshaped: the counters in
    it are meaningless under the new scheme, and keeping it makes the change reversible.
*/
IF OBJECT_ID('dbo.LRN_RunIdSequence', 'U') IS NOT NULL
   AND COL_LENGTH('dbo.LRN_RunIdSequence', 'LabShortName') IS NULL
BEGIN
    IF OBJECT_ID('dbo.LRN_RunIdSequence_Legacy', 'U') IS NOT NULL
        DROP TABLE dbo.LRN_RunIdSequence_Legacy;

    EXEC sp_rename 'dbo.LRN_RunIdSequence', 'LRN_RunIdSequence_Legacy';
    PRINT 'Old global counter set aside as dbo.LRN_RunIdSequence_Legacy';
END
GO

/*
    sp_rename moves the table but leaves its constraints named after the old one, so the new table
    cannot claim PK_LRN_RunIdSequence. Renaming the constraint is a separate step on purpose: if the
    table rename already happened on an earlier run, this still needs doing.
*/
IF OBJECT_ID('dbo.LRN_RunIdSequence_Legacy', 'U') IS NOT NULL
   AND EXISTS (SELECT 1 FROM sys.key_constraints
               WHERE name = 'PK_LRN_RunIdSequence'
                 AND parent_object_id = OBJECT_ID('dbo.LRN_RunIdSequence_Legacy'))
BEGIN
    EXEC sp_rename 'dbo.PK_LRN_RunIdSequence', 'PK_LRN_RunIdSequence_Legacy', 'OBJECT';
END
GO

IF OBJECT_ID('dbo.LRN_RunIdSequence', 'U') IS NULL
BEGIN
    CREATE TABLE [dbo].[LRN_RunIdSequence]
    (
        [LabShortName] VARCHAR(10)  NOT NULL
            CONSTRAINT [PK_LRN_RunIdSequence] PRIMARY KEY CLUSTERED,
        [LastSeq]      INT          NOT NULL,
        [LastRunId]    VARCHAR(30)  NULL,   -- diagnostics: what the last allocation handed out
        [LastIssuedOn] DATETIME2(3) NULL
    );
    PRINT 'dbo.LRN_RunIdSequence created (per-lab, continuous)';
END
GO

/* ------------------------------------------------------------------ *
 *  3.  dbo.sp_LRN_NextRunId
 * ------------------------------------------------------------------ */

CREATE OR ALTER PROCEDURE [dbo].[sp_LRN_NextRunId]
    @RunId     VARCHAR(30) OUTPUT,
    @LabId     INT          = NULL,   -- preferred: unambiguous
    @LabName   VARCHAR(200) = NULL,   -- fallback when the caller only knows the name
    @ShortName VARCHAR(10)  = NULL    -- explicit override, skips the lookup
AS
BEGIN
    SET NOCOUNT ON;

    /* ---- resolve the lab code ---- */
    SET @ShortName = NULLIF(LTRIM(RTRIM(@ShortName)), '');

    IF @ShortName IS NULL AND @LabId IS NOT NULL
        SELECT @ShortName = ShortName FROM dbo.Labs WHERE LabId = @LabId;

    /*
        Name matching is deliberately loose - callers say 'NorthWest', dbo.Labs says 'Northwest',
        and the mapping JSONs use 'Augustus' against 'Augustus_Labs'. Case, spaces, underscores and
        hyphens are all noise here.
    */
    IF @ShortName IS NULL AND NULLIF(LTRIM(RTRIM(@LabName)), '') IS NOT NULL
    BEGIN
        DECLARE @needle VARCHAR(200) =
            UPPER(REPLACE(REPLACE(REPLACE(LTRIM(RTRIM(@LabName)), ' ', ''), '_', ''), '-', ''));

        SELECT TOP (1) @ShortName = ShortName
        FROM   dbo.Labs
        WHERE  ShortName IS NOT NULL
          AND  UPPER(REPLACE(REPLACE(REPLACE(LabName, ' ', ''), '_', ''), '-', '')) = @needle
        ORDER BY IsActive DESC, LabId;
    END

    /*
        Fail rather than invent a code. A RunId is written into every log table and into 12 lab
        databases; a wrong or placeholder one is permanent and would have to be unpicked by hand,
        whereas this stops the run with something the operator can fix in one UPDATE.
    */
    IF @ShortName IS NULL
    BEGIN
        RAISERROR('sp_LRN_NextRunId: no ShortName for LabId %d / LabName "%s". Set dbo.Labs.ShortName for that lab (see sql/LRNMaster/11_RunId_PerLab.sql).',
                  16, 1, @LabId, @LabName);
        RETURN;
    END

    /* ---- allocate the next number ---- */
    DECLARE @seq INT;

    BEGIN TRAN;

        -- Assignment-in-UPDATE: reads and increments under one lock, so two labs starting at the
        -- same instant cannot be handed the same number.
        UPDATE dbo.LRN_RunIdSequence WITH (UPDLOCK, HOLDLOCK)
           SET @seq         = LastSeq = LastSeq + 1,
               LastIssuedOn = SYSDATETIME()
         WHERE LabShortName = @ShortName;

        IF @@ROWCOUNT = 0
        BEGIN
            -- HOLDLOCK above range-locks the missing key, so this insert is not a race.
            INSERT dbo.LRN_RunIdSequence (LabShortName, LastSeq, LastIssuedOn)
            VALUES (@ShortName, 1, SYSDATETIME());

            SET @seq = 1;
        END

        /*
            Pad to 4, but never truncate. A continuous counter does eventually pass 9999, and
            RIGHT(...,4) would then start handing out numbers it had already used - so the id grows
            to five digits instead of silently colliding.
        */
        DECLARE @seqText VARCHAR(10) = CONVERT(VARCHAR(10), @seq);
        IF LEN(@seqText) < 4
            SET @seqText = RIGHT('0000' + @seqText, 4);

        SET @RunId = 'R' + CONVERT(VARCHAR(8), GETDATE(), 112) + @ShortName + @seqText;

        UPDATE dbo.LRN_RunIdSequence
           SET LastRunId = @RunId
         WHERE LabShortName = @ShortName;

    COMMIT;
END
GO

GRANT EXECUTE ON [dbo].[sp_LRN_NextRunId] TO [public];
GO

SELECT LabId, LabName, ShortName, IsActive FROM dbo.Labs WHERE ShortName IS NOT NULL ORDER BY ShortName;
GO
