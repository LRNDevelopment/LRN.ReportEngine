/*
    AdditionalFields - the JSON catch-all column on this lab's line-level and claim-level tables.

    WHY
    Labs keep adding columns to the files they send. Without this column every new column means an
    ALTER TABLE plus a lab-mapping edit before the data can land, and until both are done the column
    is silently dropped. With it, any CSV column the lab mapping does not claim is written into one
    JSON object per row, so no data is lost while the mapping catches up. A column that matters is
    still promoted to a real column afterwards - this is the safety net, not the destination.

    Column name and type must match BulkLoad/AuditColumns.cs (AdditionalFields, NVARCHAR(MAX)).
    The loader checks for the column before it writes: a database that has not run this file keeps
    loading exactly as before.

    Idempotent: adds the column only when missing. Never drops, renames or retypes anything.

    USAGE:  sqlcmd -S <server> -d <LabDb> -E -i 03_AdditionalFields.sql

    READING IT BACK
        SELECT JSON_VALUE(AdditionalFields, '$."Some New Column"') FROM dbo.LineLevelData;
        -- every extra column seen in one run:
        SELECT DISTINCT k.[key]
        FROM   dbo.LineLevelData d
        CROSS APPLY OPENJSON(d.AdditionalFields) k
        WHERE  d.RunId = '<RunId>';
*/

SET NOCOUNT ON;
GO

DECLARE @tables TABLE (TableName SYSNAME);

INSERT INTO @tables (TableName)
VALUES ('LineLevelData'), ('ClaimLevelData');

DECLARE @table SYSNAME;
DECLARE @sql   NVARCHAR(MAX);

DECLARE table_cursor CURSOR LOCAL FAST_FORWARD FOR
    SELECT t.TableName
    FROM   @tables t
    WHERE  OBJECT_ID('dbo.' + t.TableName, 'U') IS NOT NULL
      AND  COL_LENGTH('dbo.' + t.TableName, 'AdditionalFields') IS NULL;

OPEN table_cursor;
FETCH NEXT FROM table_cursor INTO @table;

WHILE @@FETCH_STATUS = 0
BEGIN
    SET @sql = N'ALTER TABLE [dbo].' + QUOTENAME(@table) + N' ADD [AdditionalFields] NVARCHAR(MAX) NULL;';
    EXEC sp_executesql @sql;
    PRINT '  + AdditionalFields on dbo.' + @table;

    FETCH NEXT FROM table_cursor INTO @table;
END

CLOSE table_cursor;
DEALLOCATE table_cursor;
GO

/* What the tables look like now. */
SELECT t.name AS TableName,
       CASE WHEN COL_LENGTH('dbo.' + t.name, 'AdditionalFields') IS NULL
            THEN 'MISSING' ELSE 'present' END AS AdditionalFields
FROM   sys.tables t
JOIN   sys.schemas s ON s.schema_id = t.schema_id
WHERE  s.name = 'dbo'
  AND  t.name IN ('LineLevelData', 'ClaimLevelData')
ORDER BY t.name;
GO
