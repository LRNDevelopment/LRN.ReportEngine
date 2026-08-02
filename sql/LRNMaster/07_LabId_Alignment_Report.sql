/*
    dbo.Labs is the single global lab registry for every LRN application.

    READ-ONLY report. Changes nothing. Run this first, and again after 08_LabId_Alignment.sql, to
    see exactly which rows are on the wrong LabId.

    Background - three different id families are currently mixed:

      dbo.Labs            the intended global registry
      dbo.LRNMetricsLab   the LRN Metrics app's own list, which disagrees on four labs
      legacy ids          e.g. NorthWest = 20, which exists in neither table

    Where they disagree (confirmed against the LabName stored alongside each row):

      Lab             Labs   LRNMetricsLab   legacy
      PCRDx - AL        6          7
      PCRDx - CO        7          8
      Augustus         24         19
      DTR              22          6
      NorthWest        23         --           20

    dbo.Labs wins everywhere.
*/

USE [LRNMaster];
GO
SET NOCOUNT ON;
GO

PRINT '=== 1. Labs vs LRNMetricsLab: same lab, different id ===';
SELECT  L.LabName            AS Lab,
        L.LabId              AS Labs_LabId,
        M.LabId              AS Metrics_LabId,
        L.ConnectionKey      AS Labs_ConnectionKey,
        M.ConnectionKey      AS Metrics_ConnectionKey
FROM    dbo.Labs L
JOIN    dbo.LRNMetricsLab M
        ON REPLACE(REPLACE(L.LabName, '_', ''), ' ', '') = REPLACE(REPLACE(M.LabName, '_', ''), ' ', '')
WHERE   L.LabId <> M.LabId
ORDER BY L.LabName;
GO

PRINT '';
PRINT '=== 2. Labs rows still carrying a placeholder ConnectionKey ===';
SELECT  L.LabId, L.LabName, L.ConnectionKey,
        M.ConnectionKey AS AvailableFromMetrics
FROM    dbo.Labs L
LEFT JOIN dbo.LRNMetricsLab M
        ON REPLACE(REPLACE(L.LabName, '_', ''), ' ', '') = REPLACE(REPLACE(M.LabName, '_', ''), ' ', '')
WHERE   L.ConnectionKey IS NULL OR L.ConnectionKey = 'XXXXXXXXX'
ORDER BY L.LabId;
GO

PRINT '';
PRINT '=== 3. Rows keyed by a LabId that does not exist in dbo.Labs ===';
/*
    Anything listed here is orphaned: the application cannot resolve it back to a lab.
    Column order is table, offending id, row count, and the name the row itself carries.
*/
SELECT 'DenialTaskBoard' AS TableName, d.LabId, COUNT(*) AS Rows_, MAX(d.LabName) AS NameOnRow
FROM dbo.DenialTaskBoard d WHERE NOT EXISTS (SELECT 1 FROM dbo.Labs L WHERE L.LabId = d.LabId)
GROUP BY d.LabId
UNION ALL
SELECT 'DenialLineItem', d.LabId, COUNT(*), MAX(d.LabName)
FROM dbo.DenialLineItem d WHERE NOT EXISTS (SELECT 1 FROM dbo.Labs L WHERE L.LabId = d.LabId)
GROUP BY d.LabId
UNION ALL
SELECT 'DenialInsight', d.LabId, COUNT(*), NULL
FROM dbo.DenialInsight d WHERE NOT EXISTS (SELECT 1 FROM dbo.Labs L WHERE L.LabId = d.LabId)
GROUP BY d.LabId
UNION ALL
SELECT 'LabInsuranceMaster', d.LabId, COUNT(*), MAX(d.LabName)
FROM dbo.LabInsuranceMaster d WHERE d.LabId IS NOT NULL AND NOT EXISTS (SELECT 1 FROM dbo.Labs L WHERE L.LabId = d.LabId)
GROUP BY d.LabId
UNION ALL
SELECT 'LabMedians', d.LabId, COUNT(*), NULL
FROM dbo.LabMedians d WHERE NOT EXISTS (SELECT 1 FROM dbo.Labs L WHERE L.LabId = d.LabId)
GROUP BY d.LabId
UNION ALL
SELECT 'LabModes', d.LabId, COUNT(*), NULL
FROM dbo.LabModes d WHERE NOT EXISTS (SELECT 1 FROM dbo.Labs L WHERE L.LabId = d.LabId)
GROUP BY d.LabId
UNION ALL
SELECT 'DenialAnalysisRunLog', d.LabId, COUNT(*), NULL
FROM dbo.DenialAnalysisRunLog d WHERE NOT EXISTS (SELECT 1 FROM dbo.Labs L WHERE L.LabId = d.LabId)
GROUP BY d.LabId
ORDER BY TableName, LabId;
GO

PRINT '';
PRINT '=== 4. Rows whose stored LabName disagrees with dbo.Labs for that LabId ===';
/*
    The dangerous class: the id resolves, but to the WRONG lab. LabId 7 means PCRDx - CO in
    dbo.Labs, so a DenialTaskBoard row with LabId 7 and LabName 'PCR Dx AL' is mis-attributed.
*/
SELECT 'DenialTaskBoard' AS TableName, d.LabId, MAX(d.LabName) AS NameOnRow,
       MAX(L.LabName) AS NameInLabs, COUNT(*) AS Rows_
FROM dbo.DenialTaskBoard d
JOIN dbo.Labs L ON L.LabId = d.LabId
WHERE REPLACE(REPLACE(ISNULL(d.LabName, ''), ' ', ''), '_', '') <> REPLACE(REPLACE(L.LabName, ' ', ''), '_', '')
GROUP BY d.LabId
UNION ALL
SELECT 'LabInsuranceMaster', d.LabId, MAX(d.LabName), MAX(L.LabName), COUNT(*)
FROM dbo.LabInsuranceMaster d
JOIN dbo.Labs L ON L.LabId = d.LabId
WHERE REPLACE(REPLACE(ISNULL(d.LabName, ''), ' ', ''), '_', '') <> REPLACE(REPLACE(L.LabName, ' ', ''), '_', '')
GROUP BY d.LabId
ORDER BY TableName, LabId;
GO

PRINT '';
PRINT '=== 5. The global registry as it stands ===';
SELECT LabId, LabName, ConnectionKey, IsActive FROM dbo.Labs ORDER BY LabId;
GO
