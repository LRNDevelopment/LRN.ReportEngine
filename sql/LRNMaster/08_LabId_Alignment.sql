/*
    Makes dbo.Labs the single global lab registry and moves every other table onto its ids.

    ############################  DRY RUN BY DEFAULT  ############################
    Set @Commit = 1 near the top to actually write. With @Commit = 0 it reports exactly what would
    change and rolls back, so it is safe to run against production to preview.
    ##############################################################################

    What it does, in order:

      1. Backfills dbo.Labs.ConnectionKey from dbo.LRNMetricsLab where Labs holds the 'XXXXXXXXX'
         placeholder. Labs cannot be the global registry until it can resolve a connection.

      2. Remaps LabId on the data tables that are on the wrong id family. Each remap below was
         confirmed against the LabName stored on the rows themselves (see
         07_LabId_Alignment_Report.sql section 4):

              7  -> 6    PCR Dx AL   (denial tables carried the LRNMetricsLab id)
              8  -> 7    PCR Dx CO   (denial tables + 29 LabInsuranceMaster rows)
              19 -> 24   Augustus    (denial tables carried the LRNMetricsLab id)
              20 -> 23   NorthWest   (legacy id, in neither registry)

         7->6 and 8->7 overlap, so the remap runs in two phases through a +100000 offset. Doing it
         in one pass would turn the 8->7 rows into 6 as well.

      3. Repoints dbo.LRNMetricsLab at dbo.Labs. The table is renamed to LRNMetricsLab_Backup and
         replaced by a view of the same shape, so the Metrics app keeps working unchanged but now
         reads global ids. Reverting is a DROP VIEW plus a rename back.

    Everything runs in ONE transaction. Any failure rolls the whole thing back.

    PREREQUISITE: take a backup. This rewrites LabId on ~250,000 rows.
*/

USE [LRNMaster];
GO
SET NOCOUNT ON;
SET XACT_ABORT ON;
GO

DECLARE @Commit bit = 0;        -- <<<<<< set to 1 to apply
DECLARE @Offset int = 100000;   -- temporary space, must not collide with any real LabId

/* The remap. Add rows here rather than editing the statements below. */
DECLARE @Map TABLE (OldLabId int NOT NULL PRIMARY KEY, NewLabId int NOT NULL, Reason nvarchar(100));
INSERT INTO @Map (OldLabId, NewLabId, Reason) VALUES
    (7,  6,  N'PCR Dx AL  - LRNMetricsLab id'),
    (8,  7,  N'PCR Dx CO  - LRNMetricsLab id'),
    (19, 24, N'Augustus   - LRNMetricsLab id'),
    (20, 23, N'NorthWest  - legacy id');

/* Tables whose LabId belongs to the wrong family. Confirmed table by table; anything not listed
   here is already on dbo.Labs ids and is deliberately left alone. */
DECLARE @Targets TABLE (TableName sysname NOT NULL PRIMARY KEY, ApplyMapForIds nvarchar(50));
INSERT INTO @Targets (TableName, ApplyMapForIds) VALUES
    (N'DenialTaskBoard',      N'7,8,19'),
    (N'DenialLineItem',       N'7,8,19'),
    (N'DenialInsight',        N'7,8,19'),
    (N'DenialAnalysisRunLog', N'20'),
    (N'LabInsuranceMaster',   N'8,20'),
    (N'LabMedians',           N'20'),
    (N'LabModes',             N'20');

BEGIN TRANSACTION;

BEGIN TRY

    /* ---------- 1. connection keys ---------- */
    PRINT '--- 1. Backfilling placeholder ConnectionKeys in dbo.Labs ---';

    UPDATE  L
    SET     L.ConnectionKey = M.ConnectionKey,
            L.ModifiedBy    = 'LabIdAlignment',
            L.ModifiedDate  = GETDATE()
    FROM    dbo.Labs L
    JOIN    dbo.LRNMetricsLab M
            ON REPLACE(REPLACE(L.LabName, '_', ''), ' ', '') = REPLACE(REPLACE(M.LabName, '_', ''), ' ', '')
    WHERE  (L.ConnectionKey IS NULL OR L.ConnectionKey = 'XXXXXXXXX')
      AND   M.ConnectionKey IS NOT NULL
      AND   M.ConnectionKey <> 'XXXXXXXXX';

    PRINT CONCAT('    ConnectionKey backfilled: ', @@ROWCOUNT);

    /* ---------- 2. remap LabId ---------- */
    PRINT '';
    PRINT '--- 2. Remapping LabId ---';

    DECLARE @tbl sysname, @ids nvarchar(50), @sql nvarchar(max), @n int;
    DECLARE tables CURSOR LOCAL FAST_FORWARD FOR SELECT TableName, ApplyMapForIds FROM @Targets;

    OPEN tables;
    FETCH NEXT FROM tables INTO @tbl, @ids;

    WHILE @@FETCH_STATUS = 0
    BEGIN
        IF OBJECT_ID('dbo.' + QUOTENAME(@tbl), 'U') IS NULL
        BEGIN
            PRINT CONCAT('    ', @tbl, ' : table not present, skipped');
        END
        ELSE
        BEGIN
            -- phase A: park the affected rows above every real id so the two remaps cannot collide
            SET @sql = N'UPDATE t SET t.LabId = m.NewLabId + @Off
                         FROM dbo.' + QUOTENAME(@tbl) + N' t
                         JOIN @M m ON m.OldLabId = t.LabId
                         WHERE t.LabId IN (' + @ids + N');';
            SET @sql = REPLACE(@sql, '@M m', '(SELECT * FROM (VALUES (7,6),(8,7),(19,24),(20,23)) v(OldLabId,NewLabId)) m');

            EXEC sp_executesql @sql, N'@Off int', @Off = @Offset;
            SET @n = @@ROWCOUNT;

            -- phase B: bring them back down to the real target id
            SET @sql = N'UPDATE dbo.' + QUOTENAME(@tbl) + N' SET LabId = LabId - @Off WHERE LabId > @Off;';
            EXEC sp_executesql @sql, N'@Off int', @Off = @Offset;

            PRINT CONCAT('    ', @tbl, ' : ', @n, ' row(s) remapped');
        END

        FETCH NEXT FROM tables INTO @tbl, @ids;
    END

    CLOSE tables;
    DEALLOCATE tables;

    /* ---------- 3. LRNMetricsLab becomes a view over dbo.Labs ---------- */
    PRINT '';
    PRINT '--- 3. Repointing dbo.LRNMetricsLab at dbo.Labs ---';

    IF OBJECT_ID('dbo.LRNMetricsLab', 'U') IS NOT NULL
    BEGIN
        EXEC sp_rename 'dbo.LRNMetricsLab', 'LRNMetricsLab_Backup';
        PRINT '    dbo.LRNMetricsLab renamed to dbo.LRNMetricsLab_Backup';

        EXEC(N'CREATE VIEW dbo.LRNMetricsLab AS
                   SELECT LabId, LabName, ConnectionKey, IsActive FROM dbo.Labs;');
        PRINT '    dbo.LRNMetricsLab recreated as a view over dbo.Labs';
    END
    ELSE
    BEGIN
        PRINT '    already a view (or absent) - nothing to do';
    END

    /* ---------- verification ---------- */
    PRINT '';
    PRINT '--- Verification: any LabId still unresolvable against dbo.Labs? ---';

    DECLARE @orphans int = 0;
    SELECT @orphans = COUNT(*) FROM (
        SELECT LabId FROM dbo.DenialTaskBoard      WHERE LabId IS NOT NULL
        UNION ALL SELECT LabId FROM dbo.DenialLineItem     WHERE LabId IS NOT NULL
        UNION ALL SELECT LabId FROM dbo.DenialInsight      WHERE LabId IS NOT NULL
        UNION ALL SELECT LabId FROM dbo.LabInsuranceMaster WHERE LabId IS NOT NULL
        UNION ALL SELECT LabId FROM dbo.LabMedians         WHERE LabId IS NOT NULL
        UNION ALL SELECT LabId FROM dbo.LabModes           WHERE LabId IS NOT NULL
    ) q
    WHERE NOT EXISTS (SELECT 1 FROM dbo.Labs L WHERE L.LabId = q.LabId);

    PRINT CONCAT('    Orphaned rows remaining: ', @orphans);

    IF @orphans > 0 AND @Commit = 1
    BEGIN
        RAISERROR('Alignment left %d orphaned rows. Rolling back - investigate with 07_LabId_Alignment_Report.sql.', 16, 1, @orphans);
    END

    /* ---------- commit or roll back ---------- */
    IF @Commit = 1
    BEGIN
        COMMIT TRANSACTION;
        PRINT '';
        PRINT '=== COMMITTED ===';
    END
    ELSE
    BEGIN
        ROLLBACK TRANSACTION;
        PRINT '';
        PRINT '=== DRY RUN - rolled back. Set @Commit = 1 to apply. ===';
    END

END TRY
BEGIN CATCH
    IF @@TRANCOUNT > 0 ROLLBACK TRANSACTION;
    PRINT '';
    PRINT '=== FAILED - rolled back, nothing changed ===';
    THROW;
END CATCH
GO
