IF COL_LENGTH('dbo.DenialTaskBoard', 'ICDCodes') IS NULL
BEGIN
    ALTER TABLE dbo.DenialTaskBoard ADD ICDCodes NVARCHAR(MAX) NULL;
END;

IF COL_LENGTH('dbo.DenialTaskBoard', 'CoverageStatus') IS NULL
BEGIN
    ALTER TABLE dbo.DenialTaskBoard ADD CoverageStatus NVARCHAR(200) NULL;
END;

IF COL_LENGTH('dbo.DenialTaskBoard', 'ICDComplianceStatus') IS NULL
BEGIN
    ALTER TABLE dbo.DenialTaskBoard ADD ICDComplianceStatus NVARCHAR(200) NULL;
END;

IF COL_LENGTH('dbo.DenialTaskBoard', 'DenialValidity') IS NULL
BEGIN
    ALTER TABLE dbo.DenialTaskBoard ADD DenialValidity NVARCHAR(MAX) NULL;
END;
