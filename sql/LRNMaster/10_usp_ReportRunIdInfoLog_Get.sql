/*
    dbo.usp_ReportRunIdInfoLog_Get

    Reads the run log back. Send a RunId and get that run's whole trail in the order it happened;
    add @LogType to narrow it to the errors.

    CALL:
        EXEC dbo.usp_ReportRunIdInfoLog_Get @RunId = '20260801R0007';                     -- everything
        EXEC dbo.usp_ReportRunIdInfoLog_Get @RunId = '20260801R0007', @LogType = 'Error'; -- errors only
        EXEC dbo.usp_ReportRunIdInfoLog_Get @RunId = '20260801R0007', @LogType = 'Error,Warning';
        EXEC dbo.usp_ReportRunIdInfoLog_Get @LogType = 'Error', @FromDate = '2026-08-01'; -- across runs
        EXEC dbo.usp_ReportRunIdInfoLog_Get @RunId = '20260801R0007', @IncludeSummary = 1;

    @LogType NULL means every type - the caller does not have to name them to get all of them.
    It accepts a comma-separated list so error-and-warning triage is one call.

    Rows come back oldest first, which is how a run reads as a story: Start, the Info steps, then
    whatever went wrong. Pass @Newest = 1 to flip it for a 'what just broke' view.

    A typo'd @LogType is rejected rather than silently returning nothing - an empty result during
    triage is indistinguishable from a clean run, and that is the worst possible answer to be wrong
    about.
*/

USE [LRNMaster];
GO

CREATE OR ALTER PROCEDURE [dbo].[usp_ReportRunIdInfoLog_Get]
    @RunId          VARCHAR(30)  = NULL,   -- one run, or all runs when NULL
    @LogType        VARCHAR(200) = NULL,   -- 'Error', 'Error,Warning', or NULL for every type
    @ReportType     VARCHAR(100) = NULL,   -- e.g. 'Line Level'
    @SourceSystem   VARCHAR(100) = NULL,   -- lab name, or 'SharePoint'
    @FromDate       DATE         = NULL,   -- filters on CreatedOn
    @ToDate         DATE         = NULL,
    @Newest         BIT          = 0,      -- 1 = newest first
    @IncludeSummary BIT          = 0       -- 1 = also return a count per LogType
AS
BEGIN
    SET NOCOUNT ON;

    /* ---- the requested types, split and trimmed; empty table = no filter ---- */
    DECLARE @types TABLE ([LogType] VARCHAR(50) NOT NULL PRIMARY KEY);

    IF NULLIF(LTRIM(RTRIM(@LogType)), '') IS NOT NULL
    BEGIN
        INSERT INTO @types ([LogType])
        SELECT DISTINCT LTRIM(RTRIM(value))
        FROM   STRING_SPLIT(@LogType, ',')
        WHERE  NULLIF(LTRIM(RTRIM(value)), '') IS NOT NULL;

        /*
            Validate against what the log actually contains, not a hard-coded list - teams add log
            types over time and this must not become the reason a new one cannot be read back.
        */
        DECLARE @unknown VARCHAR(MAX), @known VARCHAR(MAX);

        SELECT @unknown = STRING_AGG(t.[LogType], ', ')
        FROM   @types t
        WHERE  NOT EXISTS (SELECT 1 FROM dbo.ReportRunIdInfoLog L WHERE L.LogType = t.[LogType]);

        IF @unknown IS NOT NULL
        BEGIN
            SELECT @known = STRING_AGG(CONVERT(VARCHAR(MAX), LogType), ', ')
            FROM   (SELECT DISTINCT LogType FROM dbo.ReportRunIdInfoLog) d;

            RAISERROR('usp_ReportRunIdInfoLog_Get: unknown @LogType (%s). Types present in the log: %s. Omit @LogType for all types.',
                      16, 1, @unknown, @known);
            RETURN;
        END
    END

    /* ---- the log ---- */
    SELECT  L.ReportRunIdInfoLogId,
            L.RunId,
            L.ReportType,
            L.SourceSystem,
            L.LogType,
            L.LogMessage,
            L.SourceFileName,
            L.CreatedOn,
            L.CreatedBy
    FROM    dbo.ReportRunIdInfoLog L
    WHERE  (@RunId        IS NULL OR L.RunId        = @RunId)
      AND  (@ReportType   IS NULL OR L.ReportType   = @ReportType)
      AND  (@SourceSystem IS NULL OR L.SourceSystem = @SourceSystem)
      AND  (@FromDate     IS NULL OR L.CreatedOn   >= @FromDate)
      AND  (@ToDate       IS NULL OR L.CreatedOn    < DATEADD(DAY, 1, @ToDate))
      AND  (NOT EXISTS (SELECT 1 FROM @types)
            OR L.LogType IN (SELECT [LogType] FROM @types))
    -- The unused direction is NULL for every row, so that key ties and falls through. Both CASE
    -- arms must be the same type: 0 vs CreatedOn is an operand clash (msg 206).
    ORDER BY CASE WHEN @Newest = 1 THEN NULL ELSE L.CreatedOn END ASC,
             CASE WHEN @Newest = 1 THEN L.CreatedOn ELSE NULL END DESC,
             CASE WHEN @Newest = 1 THEN -L.ReportRunIdInfoLogId ELSE L.ReportRunIdInfoLogId END ASC
    OPTION (RECOMPILE);   -- the filters vary per call; one cached plan would suit only one of them

    /* ---- optional second result set: how many of each type ---- */
    IF @IncludeSummary = 1
    BEGIN
        SELECT  L.LogType,
                COUNT(*)          AS [Entries],
                MIN(L.CreatedOn)  AS [FirstAt],
                MAX(L.CreatedOn)  AS [LastAt]
        FROM    dbo.ReportRunIdInfoLog L
        WHERE  (@RunId        IS NULL OR L.RunId        = @RunId)
          AND  (@ReportType   IS NULL OR L.ReportType   = @ReportType)
          AND  (@SourceSystem IS NULL OR L.SourceSystem = @SourceSystem)
          AND  (@FromDate     IS NULL OR L.CreatedOn   >= @FromDate)
          AND  (@ToDate       IS NULL OR L.CreatedOn    < DATEADD(DAY, 1, @ToDate))
          AND  (NOT EXISTS (SELECT 1 FROM @types)
                OR L.LogType IN (SELECT [LogType] FROM @types))
        GROUP BY L.LogType
        ORDER BY [Entries] DESC
        OPTION (RECOMPILE);
    END
END
GO

GRANT EXECUTE ON [dbo].[usp_ReportRunIdInfoLog_Get] TO [public];
GO
