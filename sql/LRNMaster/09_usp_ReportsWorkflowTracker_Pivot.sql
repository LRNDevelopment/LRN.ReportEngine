/*
    dbo.usp_ReportsWorkflowTracker_Pivot

    Renders ReportsWorkflowTracker in the workbook layout: one row per RunId + Lab, with every report
    type as its own column and the status as the value.

        Lab | Synced on | RunID | Week | Line Level Master | Claim Level Master | LIS Summary | ...

    The columns come from dbo.ReportTypeMaster in DisplayOrder, which is the column order of
    Reports_Workflow_Tracker_v1.0.xlsx. Adding a report there adds a column here with no change to
    this procedure; changing DisplayOrder moves it.

    CALL:
        EXEC dbo.usp_ReportsWorkflowTracker_Pivot;                          -- everything
        EXEC dbo.usp_ReportsWorkflowTracker_Pivot @RunId = '20260724R0044'; -- one run
        EXEC dbo.usp_ReportsWorkflowTracker_Pivot @LabId = 4;               -- one lab
        EXEC dbo.usp_ReportsWorkflowTracker_Pivot @FromDate = '2026-07-01', @ToDate = '2026-07-31';

    A blank cell means that report never wrote a row for the run - which is NOT the same as a
    failure, and is worth chasing separately. Pass @ShowBlankAs to substitute a marker.

    The column list is built by dynamic SQL, so every report name goes through QUOTENAME. The
    caller's filter values are passed as parameters to sp_executesql and are never concatenated.
*/

USE [LRNMaster];
GO

CREATE OR ALTER PROCEDURE [dbo].[usp_ReportsWorkflowTracker_Pivot]
    @RunId                  VARCHAR(30)  = NULL,   -- one run, or all
    @LabId                  INT          = NULL,   -- one lab, or all
    @FromDate               DATE         = NULL,   -- filters on CreatedOn
    @ToDate                 DATE         = NULL,
    @IncludeInactiveReports BIT          = 0,      -- include IsActive = 0 report types as columns
    @ShowBlankAs            VARCHAR(50)  = NULL    -- e.g. 'Not Run'; NULL leaves the cell empty
AS
BEGIN
    SET NOCOUNT ON;

    /* ---- column list, straight from the master ---- */
    DECLARE @cols NVARCHAR(MAX);

    SELECT @cols = STRING_AGG(CAST(QUOTENAME(ReportTypeName) AS NVARCHAR(MAX)), N', ')
                       WITHIN GROUP (ORDER BY DisplayOrder, ReportTypeId)
    FROM   dbo.ReportTypeMaster
    WHERE  @IncludeInactiveReports = 1 OR IsActive = 1;

    IF @cols IS NULL
    BEGIN
        RAISERROR('usp_ReportsWorkflowTracker_Pivot: dbo.ReportTypeMaster has no matching report types.', 16, 1);
        RETURN;
    END

    /* ---- the same list again, wrapped so empty cells can carry a marker ---- */
    DECLARE @select NVARCHAR(MAX);

    SELECT @select = STRING_AGG(
               CAST(CASE WHEN @ShowBlankAs IS NULL
                         THEN N'p.' + QUOTENAME(ReportTypeName)
                         ELSE N'ISNULL(p.' + QUOTENAME(ReportTypeName) + N', @Blank)'
                    END + N' AS ' + QUOTENAME(ReportTypeName) AS NVARCHAR(MAX)), N',
        ')
           WITHIN GROUP (ORDER BY DisplayOrder, ReportTypeId)
    FROM   dbo.ReportTypeMaster
    WHERE  @IncludeInactiveReports = 1 OR IsActive = 1;

    /*
        The PIVOT source must contain ONLY the key columns plus ReportName/Status. Any extra column
        left in there silently becomes part of the implicit GROUP BY and splits a lab's run across
        several rows, so LabName / WeekFolder / Synced on are joined back on afterwards.
    */
    DECLARE @sql NVARCHAR(MAX) = N'
    WITH hdr AS (
        SELECT  t.RunId,
                t.LabID,
                MAX(t.LabName)     AS LabName,
                MAX(t.WeekFolder)  AS WeekFolder,
                MAX(COALESCE(t.CompletedOn, t.CreatedOn)) AS SyncedOn
        FROM    dbo.ReportsWorkflowTracker t
        WHERE  (@pRunId    IS NULL OR t.RunId = @pRunId)
          AND  (@pLabId    IS NULL OR t.LabID = @pLabId)
          AND  (@pFromDate IS NULL OR t.CreatedOn >= @pFromDate)
          AND  (@pToDate   IS NULL OR t.CreatedOn <  DATEADD(DAY, 1, @pToDate))
        GROUP BY t.RunId, t.LabID
    ),
    src AS (
        SELECT  t.RunId, t.LabID, t.ReportName, t.Status
        FROM    dbo.ReportsWorkflowTracker t
        WHERE  (@pRunId    IS NULL OR t.RunId = @pRunId)
          AND  (@pLabId    IS NULL OR t.LabID = @pLabId)
          AND  (@pFromDate IS NULL OR t.CreatedOn >= @pFromDate)
          AND  (@pToDate   IS NULL OR t.CreatedOn <  DATEADD(DAY, 1, @pToDate))
    )
    SELECT  h.LabName                                  AS [Lab],
            CONVERT(VARCHAR(10), h.SyncedOn, 101)      AS [Synced on],
            p.RunId                                    AS [RunID],
            h.WeekFolder                               AS [Week],
            ' + @select + N'
    FROM    src
    PIVOT  (MAX(Status) FOR ReportName IN (' + @cols + N')) AS p
    JOIN    hdr h
            ON  h.RunId = p.RunId
            AND h.LabID = p.LabID
    ORDER BY h.SyncedOn DESC, h.LabName;';

    EXEC sp_executesql
         @sql,
         N'@pRunId VARCHAR(30), @pLabId INT, @pFromDate DATE, @pToDate DATE, @Blank VARCHAR(50)',
         @pRunId    = @RunId,
         @pLabId    = @LabId,
         @pFromDate = @FromDate,
         @pToDate   = @ToDate,
         @Blank     = @ShowBlankAs;
END
GO

GRANT EXECUTE ON [dbo].[usp_ReportsWorkflowTracker_Pivot] TO [public];
GO

