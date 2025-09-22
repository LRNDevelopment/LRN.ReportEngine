USE [PrismLRN]
GO
/****** Object:  StoredProcedure [dbo].[SP_UpdateLIS_Statuses]******/
DROP PROCEDURE [dbo].[SP_UpdateLIS_Statuses]
GO
/****** Object:  StoredProcedure [dbo].[SP_ProcessVAAvsLIS]******/
DROP PROCEDURE [dbo].[SP_ProcessVAAvsLIS]
GO
/****** Object:  StoredProcedure [dbo].[Sp_ProcessTransactionDetails_BAK]******/
DROP PROCEDURE [dbo].[Sp_ProcessTransactionDetails_BAK]
GO
/****** Object:  StoredProcedure [dbo].[Sp_ProcessTransactionDetails]******/
DROP PROCEDURE [dbo].[Sp_ProcessTransactionDetails]
GO
/****** Object:  StoredProcedure [dbo].[Sp_ProcessDenialTrackingMaster]******/
DROP PROCEDURE [dbo].[Sp_ProcessDenialTrackingMaster]
GO
/****** Object:  StoredProcedure [dbo].[Sp_ProcessBillingMasterData]******/
DROP PROCEDURE [dbo].[Sp_ProcessBillingMasterData]
GO
/****** Object:  StoredProcedure [dbo].[Sp_Process_VAA_ByFileId]******/
DROP PROCEDURE [dbo].[Sp_Process_VAA_ByFileId]
GO
/****** Object:  StoredProcedure [dbo].[Sp_Process_PanelMasterStaging]******/
DROP PROCEDURE [dbo].[Sp_Process_PanelMasterStaging]
GO
/****** Object:  StoredProcedure [dbo].[Sp_Process_LISSample_Report]******/
DROP PROCEDURE [dbo].[Sp_Process_LISSample_Report]
GO
/****** Object:  StoredProcedure [dbo].[Sp_Process_LISOrderStaging]******/
DROP PROCEDURE [dbo].[Sp_Process_LISOrderStaging]
GO
/****** Object:  StoredProcedure [dbo].[SP_Process_LISMaster_From_Staging]******/
DROP PROCEDURE [dbo].[SP_Process_LISMaster_From_Staging]
GO
/****** Object:  StoredProcedure [dbo].[SP_Process_LISMaster_ByFileId]******/
DROP PROCEDURE [dbo].[SP_Process_LISMaster_ByFileId]
GO
/****** Object:  StoredProcedure [dbo].[sp_Process_FinalCalimStatus_bak_old]******/
DROP PROCEDURE [dbo].[sp_Process_FinalCalimStatus_bak_old]
GO
/****** Object:  StoredProcedure [dbo].[sp_Process_FinalCalimStatus_bak]******/
DROP PROCEDURE [dbo].[sp_Process_FinalCalimStatus_bak]
GO
/****** Object:  StoredProcedure [dbo].[sp_Process_FinalCalimStatus]******/
DROP PROCEDURE [dbo].[sp_Process_FinalCalimStatus]
GO
/****** Object:  StoredProcedure [dbo].[Sp_Process_ClientBillingSheet]******/
DROP PROCEDURE [dbo].[Sp_Process_ClientBillingSheet]
GO
/****** Object:  StoredProcedure [dbo].[Sp_Process_BillingSheet_ByFileId]******/
DROP PROCEDURE [dbo].[Sp_Process_BillingSheet_ByFileId]
GO
/****** Object:  StoredProcedure [dbo].[SP_InsertReportDownloadLog]******/
DROP PROCEDURE [dbo].[SP_InsertReportDownloadLog]
GO
/****** Object:  StoredProcedure [dbo].[sp_InsertMasterData]******/
DROP PROCEDURE [dbo].[sp_InsertMasterData]
GO
/****** Object:  StoredProcedure [dbo].[sp_InsertClaimDenialCode]******/
DROP PROCEDURE [dbo].[sp_InsertClaimDenialCode]
GO
/****** Object:  StoredProcedure [dbo].[sp_GetProductionReportMaster_bak]******/
DROP PROCEDURE [dbo].[sp_GetProductionReportMaster_bak]
GO
/****** Object:  StoredProcedure [dbo].[sp_GetProductionReportMaster]******/
DROP PROCEDURE [dbo].[sp_GetProductionReportMaster]
GO
/****** Object:  StoredProcedure [dbo].[sp_GetProductionLineLevelReport]******/
DROP PROCEDURE [dbo].[sp_GetProductionLineLevelReport]
GO
/****** Object:  StoredProcedure [dbo].[sp_GetLISMasterReportByDateRange]******/
DROP PROCEDURE [dbo].[sp_GetLISMasterReportByDateRange]
GO
/****** Object:  StoredProcedure [dbo].[sp_GetCollectionReport]******/
DROP PROCEDURE [dbo].[sp_GetCollectionReport]
GO
/****** Object:  StoredProcedure [dbo].[sp_GetCollectionLineLevelReport]******/
DROP PROCEDURE [dbo].[sp_GetCollectionLineLevelReport]
GO
/****** Object:  StoredProcedure [dbo].[sp_ClaimLevelStatusUpdate]******/
DROP PROCEDURE [dbo].[sp_ClaimLevelStatusUpdate]
GO
/****** Object:  StoredProcedure [dbo].[sp_ClaimBillingDetails]******/
DROP PROCEDURE [dbo].[sp_ClaimBillingDetails]
GO
/****** Object:  StoredProcedure [dbo].[EvaluateClaims]******/
DROP PROCEDURE [dbo].[EvaluateClaims]
GO
/****** Object:  StoredProcedure [dbo].[BillingMasterProcess_Proc]******/
DROP PROCEDURE [dbo].[BillingMasterProcess_Proc]
GO
/****** Object:  UserDefinedFunction [dbo].[fn_GetClaimStatusByVisitAndCPT]******/
DROP FUNCTION [dbo].[fn_GetClaimStatusByVisitAndCPT]
GO
/****** Object:  UserDefinedFunction [dbo].[GetDenailCodeByVisitNumber]******/
DROP FUNCTION [dbo].[GetDenailCodeByVisitNumber]
GO
/****** Object:  UserDefinedFunction [dbo].[GetDenailCodeByVisitCPT]******/
DROP FUNCTION [dbo].[GetDenailCodeByVisitCPT]
GO
/****** Object:  UserDefinedFunction [dbo].[GETCPTCodesByAccessionNo]******/
DROP FUNCTION [dbo].[GETCPTCodesByAccessionNo]
GO
/****** Object:  UserDefinedFunction [dbo].[GETCPTCodeCombined]******/
DROP FUNCTION [dbo].[GETCPTCodeCombined]
GO
/****** Object:  UserDefinedFunction [dbo].[fn_NormalizePanelCode]******/
DROP FUNCTION [dbo].[fn_NormalizePanelCode]
GO
/****** Object:  UserDefinedFunction [dbo].[fn_GetLineItemStatus_BAK]******/
DROP FUNCTION [dbo].[fn_GetLineItemStatus_BAK]
GO
/****** Object:  UserDefinedFunction [dbo].[fn_GetLineItemStatus]******/
DROP FUNCTION [dbo].[fn_GetLineItemStatus]
GO
/****** Object:  UserDefinedFunction [dbo].[fn_GetClaimStatus]******/
DROP FUNCTION [dbo].[fn_GetClaimStatus]
GO
/****** Object:  UserDefinedFunction [dbo].[BuildCondition]******/
DROP FUNCTION [dbo].[BuildCondition]
GO
/****** Object:  UserDefinedFunction [dbo].[BuildCondition]******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE   FUNCTION [dbo].[BuildCondition] (
    @ColumnName NVARCHAR(100),
    @RuleExpression NVARCHAR(100)
)
RETURNS NVARCHAR(MAX)
AS
BEGIN
    DECLARE @Condition NVARCHAR(MAX)

    IF @RuleExpression = 'IS NOT NULL'
        SET @Condition = 'c.' + QUOTENAME(@ColumnName) + ' IS NOT NULL'
    ELSE IF @RuleExpression = '= 0'
        SET @Condition = 'c.' + QUOTENAME(@ColumnName) + ' = 0'
    ELSE IF @RuleExpression = '> 0'
        SET @Condition = 'c.' + QUOTENAME(@ColumnName) + ' > 0'
    ELSE IF @RuleExpression = '= BilledAmount'
        SET @Condition = 'c.' + QUOTENAME(@ColumnName) + ' = b.BilledAmount'
    ELSE IF @RuleExpression = '= AllowedAmount'
        SET @Condition = 'c.' + QUOTENAME(@ColumnName) + ' = b.AllowedAmount'
    ELSE IF @RuleExpression = '= InsuranceBalance'
        SET @Condition = 'c.' + QUOTENAME(@ColumnName) + ' = b.InsuranceBalance'
    ELSE IF @RuleExpression = '= PatientBalance'
        SET @Condition = 'c.' + QUOTENAME(@ColumnName) + ' = b.PatientBalance'
    ELSE IF @RuleExpression = '= InsuranceBalance + PatientBalance'
        SET @Condition = 'c.' + QUOTENAME(@ColumnName) + ' = b.InsuranceBalance + b.PatientBalance'
    ELSE
        SET @Condition = 'c.' + QUOTENAME(@ColumnName) + ' = ' + @RuleExpression

    RETURN @Condition
END
GO
/****** Object:  UserDefinedFunction [dbo].[fn_GetClaimStatus]******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE FUNCTION [dbo].[fn_GetClaimStatus] (
    @SampleResultedDate DATE,
    @FirstBillDate DATE,
    @BilledAmount DECIMAL(18, 2),
    @AllowedAmount DECIMAL(18, 2),
    @InsurancePayment DECIMAL(18, 2),
    @InsuranceAdjustment DECIMAL(18, 2),
    @PatientPaidAmount DECIMAL(18, 2),
    @PatientAdjustment DECIMAL(18, 2),
    @InsuranceBalance DECIMAL(18, 2),
    @PatientBalance DECIMAL(18, 2),
    @TotalBalance DECIMAL(18, 2),
    @DenialCode NVARCHAR(100)
)
RETURNS NVARCHAR(100)
AS
BEGIN
    DECLARE @Status NVARCHAR(100);

    SET @Status = CASE
        WHEN @SampleResultedDate IS NULL OR @FirstBillDate IS NULL THEN 'Missing Dates'
        WHEN @BilledAmount = 0 THEN 'Billed Amount 0'
        WHEN @InsurancePayment = 0 AND @InsuranceAdjustment = 0 AND @AllowedAmount = 0 AND @DenialCode IS NOT NULL THEN 'Fully Denied'
        WHEN @InsuranceBalance > 0 AND @InsurancePayment > 0 THEN 'Partially Paid'
        WHEN @InsurancePayment = @BilledAmount AND @InsuranceBalance = 0 THEN 'Fully Paid'
        WHEN @InsuranceAdjustment = @BilledAmount THEN 'Fully Adjusted'
        WHEN @PatientBalance = @BilledAmount AND @InsurancePayment = 0 THEN 'Patient Responsibility'
        WHEN @InsurancePayment = 0 AND @InsuranceAdjustment = 0 AND @InsuranceBalance = @BilledAmount THEN 'No Response from Payer'
        ELSE 'Uncategorized'
    END;

    RETURN @Status;
END;
GO
/****** Object:  UserDefinedFunction [dbo].[fn_GetLineItemStatus]******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE   FUNCTION [dbo].[fn_GetLineItemStatus]
(
    @BilledAmount DECIMAL(18,2),
    @AllowedAmount DECIMAL(18,2),
    @InsurancePayments DECIMAL(18,2),
    @PatientPayments DECIMAL(18,2),
    @Adjustment DECIMAL(18,2),
    @InsuranceBalance DECIMAL(18,2),
    @PatientBalance DECIMAL(18,2),
    @TotalBalance DECIMAL(18,2),
    @DenialCode NVARCHAR(100)
)
RETURNS NVARCHAR(50)
AS
BEGIN
    DECLARE @Status NVARCHAR(50);

    -- Paid
    IF
		@BilledAmount > = 0 AND 
		@AllowedAmount > = 0 AND 
		@InsurancePayments > = 0 AND
		@PatientPayments > = 0 AND 
		@Adjustment > = 0 AND 
		@InsuranceBalance  > = 0 AND 
		@PatientBalance > = 0 AND
		@TotalBalance > = 0 AND
		(@DenialCode IS NULL OR @DenialCode = 'Denied')
    BEGIN
        SET @Status = 'Paid';
    END
    -- Patient Responsibility
    ELSE IF 
		@BilledAmount > = 0 AND 
		@AllowedAmount > = 0 AND 
		@InsurancePayments = 0 AND
		@PatientPayments > = 0 AND 
		@Adjustment > = 0 AND 
		@InsuranceBalance = 0 AND 
		@PatientBalance > = 0 AND
		@TotalBalance > = 0 AND
		(@DenialCode IS NULL OR @DenialCode = 'Denied')
    BEGIN
        SET @Status = 'Patient Responsibility';
    END
    -- Adjusted
    ELSE IF 
		@BilledAmount > = 0 AND 
		@AllowedAmount = 0 AND 
		@InsurancePayments = 0 AND
		@PatientPayments  = 0 AND 
		@Adjustment >  0 AND 
		@InsuranceBalance = 0 AND 
		@PatientBalance  = 0 AND
		@TotalBalance < = 0 AND
		(@DenialCode IS NULL OR @DenialCode = 'Denied')
    BEGIN
        SET @Status = 'Adjusted';
    END
    -- Denied
    ELSE IF 
		@BilledAmount > = 0 AND 
		@AllowedAmount > = 0 AND 
		@InsurancePayments = 0 AND
		@PatientPayments  = 0 AND 
		@Adjustment = 0 AND 
		@InsuranceBalance > 0 AND 
		@PatientBalance  = 0 AND
		@TotalBalance > 0 AND
		(@DenialCode IS NOT NULL)
    BEGIN
        SET @Status = 'Denied';
    END
    -- No Response
    ELSE IF 
		@BilledAmount > = 0 AND 
		@AllowedAmount > = 0 AND 
		@InsurancePayments = 0 AND
		@PatientPayments  = 0 AND 
		@Adjustment = 0 AND 
		@InsuranceBalance > 0 AND 
		@PatientBalance  = 0 AND
		@TotalBalance > 0 AND
		(@DenialCode IS NULL)
    BEGIN
        SET @Status = 'No Response';
    END
    ELSE
    BEGIN
        SET @Status = 'Adjudicated';
    END

    RETURN @Status;
END;
GO
/****** Object:  UserDefinedFunction [dbo].[fn_GetLineItemStatus_BAK]******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE   FUNCTION [dbo].[fn_GetLineItemStatus_BAK]
(
    @BilledAmount DECIMAL(18,2),
    @AllowedAmount DECIMAL(18,2),
    @InsurancePayments DECIMAL(18,2),
    @PatientPayments DECIMAL(18,2),
    @Adjustment DECIMAL(18,2),
    @InsuranceBalance DECIMAL(18,2),
    @PatientBalance DECIMAL(18,2),
    @TotalBalance DECIMAL(18,2),
    @DenialCode NVARCHAR(100)
)
RETURNS NVARCHAR(50)
AS
BEGIN
    DECLARE @Status NVARCHAR(50);

    -- Paid
    IF
		@BilledAmount > = 0 AND 
		@AllowedAmount > = 0 AND 
		@InsurancePayments > = 0 AND
		@PatientPayments > = 0 AND 
		@Adjustment > = 0 AND 
		@InsuranceBalance  > = 0 AND 
		@PatientBalance > = 0 AND
		@TotalBalance > = 0 AND
		(@DenialCode IS NULL OR @DenialCode = 'Denied')
    BEGIN
        SET @Status = 'Paid';
    END
    -- Patient Responsibility
    ELSE IF 
		@BilledAmount > = 0 AND 
		@AllowedAmount > = 0 AND 
		@InsurancePayments = 0 AND
		@PatientPayments > = 0 AND 
		@Adjustment > = 0 AND 
		@InsuranceBalance = 0 AND 
		@PatientBalance > = 0 AND
		@TotalBalance > = 0 AND
		(@DenialCode IS NULL OR @DenialCode = 'Denied')
    BEGIN
        SET @Status = 'Patient Responsibility';
    END
    -- Adjusted
    ELSE IF 
		@BilledAmount > = 0 AND 
		@AllowedAmount = 0 AND 
		@InsurancePayments = 0 AND
		@PatientPayments  = 0 AND 
		@Adjustment >  0 AND 
		@InsuranceBalance = 0 AND 
		@PatientBalance  = 0 AND
		@TotalBalance < = 0 AND
		(@DenialCode IS NULL OR @DenialCode = 'Denied')
    BEGIN
        SET @Status = 'Adjusted';
    END
    -- Denied
    ELSE IF 
		@BilledAmount > = 0 AND 
		@AllowedAmount > = 0 AND 
		@InsurancePayments = 0 AND
		@PatientPayments  = 0 AND 
		@Adjustment = 0 AND 
		@InsuranceBalance > 0 AND 
		@PatientBalance  = 0 AND
		@TotalBalance > 0 AND
		(@DenialCode IS NOT NULL)
    BEGIN
        SET @Status = 'Denied';
    END
    -- No Response
    ELSE IF 
		@BilledAmount > = 0 AND 
		@AllowedAmount > = 0 AND 
		@InsurancePayments = 0 AND
		@PatientPayments  = 0 AND 
		@Adjustment = 0 AND 
		@InsuranceBalance > 0 AND 
		@PatientBalance  = 0 AND
		@TotalBalance > 0 AND
		(@DenialCode IS NULL)
    BEGIN
        SET @Status = 'No Response';
    END
    ELSE
    BEGIN
        SET @Status = 'Adjudicated';
    END

    RETURN @Status;
END;
GO
/****** Object:  UserDefinedFunction [dbo].[fn_NormalizePanelCode]******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE FUNCTION [dbo].[fn_NormalizePanelCode] (@s nvarchar(400))
RETURNS nvarchar(400)
AS
BEGIN
    IF @s IS NULL RETURN NULL;

    -- Trim outer whitespace; do NOT touch inner spaces
    DECLARE @trimmed nvarchar(400) = NULLIF(LTRIM(RTRIM(@s)), '');
    IF @trimmed IS NULL RETURN NULL;

    -- Normalize separators: treat '&' like ','
    DECLARE @commas nvarchar(400) = REPLACE(@trimmed, N'&', N',');

    -- Hold distinct components (case-insensitive key), preserving original casing/spaces
    DECLARE @u TABLE (
        component  nvarchar(400) NOT NULL,
        key_lower  nvarchar(400) NOT NULL
    );

    ;WITH raw AS (
        SELECT TRIM(value) AS component
        FROM STRING_SPLIT(@commas, N',')
    ),
    filtered AS (
        SELECT component
        FROM raw
        WHERE component <> N''
    ),
    dedup AS (
        SELECT component,
               LOWER(component) AS key_lower,
               ROW_NUMBER() OVER (PARTITION BY LOWER(component) ORDER BY component) AS rn
        FROM filtered
    )
    INSERT INTO @u (component, key_lower)
    SELECT component, key_lower
    FROM dedup
    WHERE rn = 1;

    DECLARE @cnt int;
    SELECT @cnt = COUNT(*) FROM @u;

    -- 3 or more comma/&-separated components => catch-all label
    IF @cnt >= 3
        RETURN N'Infectious Disease';  -- or N'others' per your rule

    -- 0 components (all separators/empties) => NULL
    IF @cnt = 0
        RETURN NULL;

    -- 1 or 2 components: join alphabetically (case-insensitive),
    -- preserving original casing and inner spaces.
    DECLARE @result nvarchar(400);
    SELECT @result =
        STRING_AGG(component, N', ')
            WITHIN GROUP (ORDER BY key_lower)
    FROM @u;

    RETURN NULLIF(@result, N'');
END
GO
/****** Object:  UserDefinedFunction [dbo].[GETCPTCodeCombined]******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE FUNCTION [dbo].[GETCPTCodeCombined] (@visitno VARCHAR(100))
RETURNS NVARCHAR(MAX)
AS
BEGIN
    DECLARE @Result NVARCHAR(MAX);

	WITH CodeCTE AS (
    SELECT  DISTINCT 
        CPTCode 
    FROM BillingMaster
    WHERE VisitNumber = @visitno and CPTCode IS NOT NULL
	) SELECT @Result =  STRING_AGG(CPTCode, ',')  FROM CodeCTE


    RETURN @Result
END
GO
/****** Object:  UserDefinedFunction [dbo].[GETCPTCodesByAccessionNo]******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE FUNCTION [dbo].[GETCPTCodesByAccessionNo] (@AccessionNo VARCHAR(100))
RETURNS NVARCHAR(MAX)
AS
BEGIN
    DECLARE @Result NVARCHAR(MAX);

	WITH CodeCTE AS (
    SELECT  DISTINCT 
        SUBSTRING(CCS.BilledCPTCode, 1, CHARINDEX(' ', CCS.BilledCPTCode) - 1) AS CodePrefix
    FROM LISStaging LIS
    JOIN VisitAgaistAccessionStaging VS ON LIS.AccessionNo = VS.AccessionNo
    JOIN CustomCollectionStaging CCS ON VS.VisitNumber = CCS.VisitNumber
    WHERE LIS.AccessionNo = @AccessionNo
	) SELECT @Result =  STRING_AGG(CodePrefix, ', ')  FROM CodeCTE


    RETURN @Result
END

GO
/****** Object:  UserDefinedFunction [dbo].[GetDenailCodeByVisitCPT]******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE FUNCTION [dbo].[GetDenailCodeByVisitCPT] (@visitno VARCHAR(100),@cptCode VARCHAR(30))
RETURNS NVARCHAR(MAX)
AS
BEGIN
    DECLARE @Result NVARCHAR(MAX);

    ;WITH Ranked AS
	(
    SELECT 
        VisitNumber,
        CPTCodes,
        PaymentReasonCode,
        PaymentDate,
        ROW_NUMBER() OVER (
            PARTITION BY VisitNumber, CPTCodes 
            ORDER BY PaymentDate DESC
        ) AS rn
    FROM DenialTrackingMaster
    WHERE PaymentReasonCode IS NOT NULL
),  Tokenized AS (
        SELECT DISTINCT
            TRIM(s.value) AS Code
        FROM Ranked d
        CROSS APPLY STRING_SPLIT(d.PaymentReasonCode, ';') AS s
        WHERE d.VisitNumber = @visitno AND d.CPTCodes = @cptCode
          AND d.PaymentReasonCode IS NOT NULL
          AND TRIM(s.value) <> ''  AND rn = 1
    ),
    Filtered AS (
        SELECT DISTINCT Code
        FROM Tokenized
        WHERE Code NOT IN (
            'CO45','CO253','CO1','CO2','CO3',
            'PR1','PR2','PR3','PR45','PR253'
        )
    )
    SELECT @Result = STRING_AGG(Code, ';') WITHIN GROUP (ORDER BY Code)
    FROM Filtered;

    RETURN @Result;  -- returns NULL if nothing remains
END
GO
/****** Object:  UserDefinedFunction [dbo].[GetDenailCodeByVisitNumber]******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE   FUNCTION [dbo].[GetDenailCodeByVisitNumber] (@visitno VARCHAR(100))
RETURNS NVARCHAR(MAX)
AS
BEGIN
    DECLARE @Result NVARCHAR(MAX);
	;WITH Ranked AS
	(
    SELECT 
        VisitNumber,
        CPTCodes,
        PaymentReasonCode,
        PaymentDate,
        ROW_NUMBER() OVER (
            PARTITION BY VisitNumber, CPTCodes 
            ORDER BY PaymentDate DESC
        ) AS rn
    FROM DenialTrackingMaster
    WHERE PaymentReasonCode IS NOT NULL
), Tokenized AS (
        SELECT DISTINCT
            TRIM(s.value) AS Code
        FROM Ranked d
        CROSS APPLY STRING_SPLIT(d.PaymentReasonCode, ';') AS s
        WHERE d.VisitNumber = @visitno
          AND d.PaymentReasonCode IS NOT NULL
          AND TRIM(s.value) <> '' AND rn = 1
    ),
    Filtered AS (
        SELECT DISTINCT Code
        FROM Tokenized
        WHERE Code NOT IN (
            'CO45','CO253','CO1','CO2','CO3',
            'PR1','PR2','PR3','PR45','PR253'
        )
    )
    SELECT @Result = STRING_AGG(Code, ';') WITHIN GROUP (ORDER BY Code)
    FROM Filtered;

    RETURN @Result;  -- returns NULL if nothing remains
END
GO
/****** Object:  UserDefinedFunction [dbo].[fn_GetClaimStatusByVisitAndCPT]******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO




CREATE FUNCTION [dbo].[fn_GetClaimStatusByVisitAndCPT]
(
    @VisitNumber VARCHAR(50),
    @CPTCode VARCHAR(50),
	@FirstBillDate Date,
	@Units int,
	@BilledAmount decimal(18,2),
	@Modifier varchar(30)
)
RETURNS TABLE
AS
RETURN
(
  SELECT 
CASE 

WHEN  BilledAmount > 0 AND AllowedAmount =  BilledAmount  AND  InsurancePayment = 0 AND  InsuranceAdjustment  =  BilledAmount  AND PatientPaidAmount  = 0 AND PatientAdjustment  = 0 AND InsuranceBalance  = 0 AND PatientBalance = 0 AND a.TotalBalance  = 0 AND (PaymentReasonCode IS NULL OR PaymentReasonCode IS NOT NULL) THEN  'Adjusted'
WHEN  BilledAmount > 0 AND AllowedAmount > 0 AND  InsurancePayment =  AllowedAmount  AND  InsuranceAdjustment  > 0 AND PatientPaidAmount  = 0 AND PatientAdjustment  = 0 AND InsuranceBalance  = 0 AND PatientBalance = 0 AND a.TotalBalance  = 0 AND (PaymentReasonCode IS NULL OR PaymentReasonCode IS NOT NULL)  THEN  'Paid'
WHEN  BilledAmount > 0 AND AllowedAmount =  BilledAmount  AND  InsurancePayment = 0 AND  InsuranceAdjustment  = 0 AND PatientPaidAmount  = 0 AND PatientAdjustment  = 0 AND InsuranceBalance  = BilledAmount  AND PatientBalance = 0 AND a.TotalBalance  = BilledAmount  AND PaymentReasonCode  IS NOT NULL THEN  'Denied'
WHEN  BilledAmount > 0 AND AllowedAmount =  BilledAmount  AND  InsurancePayment = 0 AND  InsuranceAdjustment  = 0 AND PatientPaidAmount  = 0 AND PatientAdjustment  = 0 AND InsuranceBalance  = BilledAmount  AND PatientBalance = 0 AND a.TotalBalance  = BilledAmount  AND PaymentReasonCode IS NULL THEN  'No Response'
WHEN  BilledAmount > 0 AND AllowedAmount > 0 AND  InsurancePayment = 0 AND  InsuranceAdjustment  > 0 AND PatientPaidAmount  = 0 AND PatientAdjustment  = 0 AND InsuranceBalance  =  AllowedAmount  AND PatientBalance = 0 AND a.TotalBalance  =  InsuranceBalance  AND (PaymentReasonCode IS NULL OR PaymentReasonCode IS NOT NULL)  THEN  'Paid'
WHEN  BilledAmount > 0 AND AllowedAmount > 0 AND  InsurancePayment = 0 AND  InsuranceAdjustment  =  BilledAmount  AND PatientPaidAmount  = 0 AND PatientAdjustment  = 0 AND InsuranceBalance  = 0 AND PatientBalance = 0 AND a.TotalBalance  = 0 AND (PaymentReasonCode IS NULL OR PaymentReasonCode IS NOT NULL) THEN  'Adjusted'
WHEN  BilledAmount > 0 AND AllowedAmount > 0 AND  InsurancePayment = 0 AND  InsuranceAdjustment  = 0 AND PatientPaidAmount  = 0 AND PatientAdjustment  = 0 AND InsuranceBalance  = BilledAmount  AND PatientBalance = 0 AND a.TotalBalance  = BilledAmount  AND PaymentReasonCode IS NULL THEN  'No Response'
WHEN  BilledAmount > 0 AND AllowedAmount > 0 AND  InsurancePayment =  AllowedAmount  AND  InsuranceAdjustment  = 0 AND PatientPaidAmount  = 0 AND PatientAdjustment  = 0 AND InsuranceBalance  = 0 AND PatientBalance  > 0 AND a.TotalBalance  = PatientBalance AND (PaymentReasonCode IS NULL OR PaymentReasonCode IS NOT NULL)  THEN  'Paid'
WHEN  BilledAmount > 0 AND AllowedAmount > 0 AND  InsurancePayment =  AllowedAmount  AND  InsuranceAdjustment  > 0 AND PatientPaidAmount  = 0 AND PatientAdjustment  = 0 AND InsuranceBalance  = 0 AND PatientBalance = 0 AND a.TotalBalance  = 0 AND (PaymentReasonCode IS NULL OR PaymentReasonCode IS NOT NULL)  THEN  'Paid'
WHEN  BilledAmount > 0 AND AllowedAmount > 0 AND  InsurancePayment  > 0 AND  InsuranceAdjustment  > 0 AND PatientPaidAmount  = 0 AND PatientAdjustment  = 0 AND InsuranceBalance  = 0 AND PatientBalance =  AllowedAmount  -  InsurancePayment  AND a.TotalBalance  = PatientBalance AND (PaymentReasonCode IS NULL OR PaymentReasonCode IS NOT NULL)  THEN  'Paid'
WHEN  BilledAmount > 0 AND AllowedAmount =  BilledAmount  AND  InsurancePayment  > 0 AND  InsuranceAdjustment  > 0 AND PatientPaidAmount  = 0 AND PatientAdjustment  = 0 AND InsuranceBalance  = 0 AND PatientBalance = 0 AND a.TotalBalance  = 0 AND (PaymentReasonCode IS NULL OR PaymentReasonCode IS NOT NULL)  THEN  'Paid'
WHEN  BilledAmount > 0 AND AllowedAmount > 0 AND  InsurancePayment =  AllowedAmount  AND  InsuranceAdjustment  = 0 AND PatientPaidAmount  = 0 AND PatientAdjustment  = 0 AND InsuranceBalance  = BilledAmount  AND PatientBalance = 0 AND a.TotalBalance  = BilledAmount  AND (PaymentReasonCode IS NULL OR PaymentReasonCode IS NOT NULL)  THEN  'Paid'
WHEN  BilledAmount > 0 AND AllowedAmount > 0 AND  InsurancePayment =  AllowedAmount  AND  InsuranceAdjustment  = 0 AND PatientPaidAmount  = 0 AND PatientAdjustment  = 0 AND InsuranceBalance  = BilledAmount  AND PatientBalance = 0 AND a.TotalBalance  = BilledAmount  AND (PaymentReasonCode IS NULL OR PaymentReasonCode IS NOT NULL)  THEN  'Paid'
WHEN  BilledAmount > 0 AND AllowedAmount = 0 AND  InsurancePayment = 0 AND  InsuranceAdjustment  =  BilledAmount  AND PatientPaidAmount  = 0 AND PatientAdjustment  = 0 AND InsuranceBalance  = 0 AND PatientBalance = 0 AND a.TotalBalance  = 0 AND (PaymentReasonCode IS NULL OR PaymentReasonCode IS NOT NULL) THEN  'Adjusted'
WHEN  BilledAmount > 0 AND AllowedAmount > 0 AND  InsurancePayment  > 0 AND  InsuranceAdjustment  > 0 AND PatientPaidAmount  = 0 AND PatientAdjustment  = 0 AND InsuranceBalance  = 0 AND PatientBalance = 0 AND a.TotalBalance  = 0 AND (PaymentReasonCode IS NULL OR PaymentReasonCode IS NOT NULL)  THEN  'Paid'
WHEN  BilledAmount > 0 AND AllowedAmount = 0 AND  InsurancePayment = 0 AND  InsuranceAdjustment  = 0 AND PatientPaidAmount  = 0 AND PatientAdjustment  = 0 AND InsuranceBalance  = BilledAmount  AND PatientBalance = 0 AND a.TotalBalance  = BilledAmount  AND PaymentReasonCode IS NULL THEN  'No Response'
WHEN  BilledAmount > 0 AND AllowedAmount > 0 AND  InsurancePayment =  AllowedAmount  AND  InsuranceAdjustment  = 0 AND PatientPaidAmount  = 0 AND PatientAdjustment  = 0 AND InsuranceBalance  = BilledAmount  AND PatientBalance = 0 AND a.TotalBalance  = BilledAmount  AND (PaymentReasonCode IS NULL OR PaymentReasonCode IS NOT NULL)  THEN  'Paid'
WHEN  BilledAmount > 0 AND AllowedAmount > 0 AND  InsurancePayment =  AllowedAmount  AND  InsuranceAdjustment  > 0 AND PatientPaidAmount  = 0 AND PatientAdjustment  = 0 AND InsuranceBalance  = BilledAmount  AND PatientBalance = 0 AND a.TotalBalance  = BilledAmount  AND (PaymentReasonCode IS NULL OR PaymentReasonCode IS NOT NULL)  THEN  'Paid'
WHEN  BilledAmount > 0 AND AllowedAmount > 0 AND  InsurancePayment  > 0 AND  InsuranceAdjustment  > 0 AND PatientPaidAmount  = 0 AND PatientAdjustment  = 0 AND InsuranceBalance  = BilledAmount  AND PatientBalance = 0 AND a.TotalBalance  = BilledAmount  AND (PaymentReasonCode IS NULL OR PaymentReasonCode IS NOT NULL)  THEN  'Paid'
WHEN  BilledAmount > 0 AND AllowedAmount =  BilledAmount  AND  InsurancePayment =  AllowedAmount  AND  InsuranceAdjustment  = 0 AND PatientPaidAmount  = 0 AND PatientAdjustment  = 0 AND InsuranceBalance  = 0 AND PatientBalance = 0 AND a.TotalBalance  = 0 AND (PaymentReasonCode IS NULL OR PaymentReasonCode IS NOT NULL)  THEN  'Paid'
WHEN  BilledAmount > 0 AND AllowedAmount > 0 AND  InsurancePayment = 0 AND  InsuranceAdjustment  = 0 AND PatientPaidAmount  = 0 AND PatientAdjustment  = 0 AND InsuranceBalance  = BilledAmount  AND PatientBalance = 0 AND a.TotalBalance  = BilledAmount  AND PaymentReasonCode  IS NOT NULL THEN  'Denied'
WHEN  BilledAmount > 0 AND AllowedAmount > 0 AND  InsurancePayment  > 0 AND  InsuranceAdjustment  > 0 AND PatientPaidAmount  = 0 AND PatientAdjustment  = 0 AND InsuranceBalance  = BilledAmount  AND PatientBalance = 0 AND a.TotalBalance  = BilledAmount  AND (PaymentReasonCode IS NULL OR PaymentReasonCode IS NOT NULL)  THEN  'Paid'
WHEN  BilledAmount > 0 AND AllowedAmount > 0 AND  InsurancePayment =  AllowedAmount  AND  InsuranceAdjustment  > 0 AND PatientPaidAmount  = 0 AND PatientAdjustment  = 0 AND InsuranceBalance  =  AllowedAmount  AND PatientBalance = 0 AND a.TotalBalance  =  InsuranceBalance  AND (PaymentReasonCode IS NULL OR PaymentReasonCode IS NOT NULL)  THEN  'Paid'
WHEN  BilledAmount > 0 AND AllowedAmount > 0 AND  InsurancePayment =  AllowedAmount  AND  InsuranceAdjustment  > 0 AND PatientPaidAmount  = 0 AND PatientAdjustment  = 0 AND InsuranceBalance  = BilledAmount  AND PatientBalance = 0 AND a.TotalBalance  = BilledAmount  AND (PaymentReasonCode IS NULL OR PaymentReasonCode IS NOT NULL)  THEN  'Paid'
WHEN  BilledAmount > 0 AND AllowedAmount =  BilledAmount  AND  InsurancePayment  > 0 AND  InsuranceAdjustment  > 0 AND PatientPaidAmount  = 0 AND PatientAdjustment  = 0 AND InsuranceBalance  = 0 AND PatientBalance = 0 AND a.TotalBalance  = 0 AND (PaymentReasonCode IS NULL OR PaymentReasonCode IS NOT NULL)  THEN  'Paid'
WHEN  BilledAmount > 0 AND AllowedAmount = 0 AND  InsurancePayment = 0 AND  InsuranceAdjustment  = 0 AND PatientPaidAmount  = 0 AND PatientAdjustment  = 0 AND InsuranceBalance  = BilledAmount  AND PatientBalance = 0 AND a.TotalBalance  = BilledAmount  AND PaymentReasonCode  IS NOT NULL THEN  'Denied'
WHEN  BilledAmount > 0 AND AllowedAmount > 0 AND  InsurancePayment = 0 AND  InsuranceAdjustment  > 0 AND PatientPaidAmount  = 0 AND PatientAdjustment  = 0 AND InsuranceBalance  = BilledAmount  AND PatientBalance = 0 AND a.TotalBalance  = BilledAmount  AND (PaymentReasonCode IS NULL OR PaymentReasonCode IS NOT NULL)  THEN  'Paid'
WHEN  BilledAmount > 0 AND AllowedAmount =  BilledAmount  AND  InsurancePayment = 0 AND  InsuranceAdjustment  = 0 AND PatientPaidAmount  = 0 AND PatientAdjustment  = 0 AND InsuranceBalance  = 0 AND PatientBalance =  AllowedAmount  AND a.TotalBalance  =  AllowedAmount  AND (PaymentReasonCode IS NULL OR PaymentReasonCode IS NOT NULL) THEN  'Patient Responsibility'
WHEN  BilledAmount > 0 AND AllowedAmount = 0 AND  InsurancePayment = 0 AND  InsuranceAdjustment  = 0 AND PatientPaidAmount  = 0 AND PatientAdjustment  = 0 AND InsuranceBalance  = 0 AND PatientBalance = BilledAmount  AND a.TotalBalance  = BilledAmount  AND (PaymentReasonCode IS NULL OR PaymentReasonCode IS NOT NULL) THEN  'Patient Responsibility'
WHEN  BilledAmount > 0 AND AllowedAmount =  BilledAmount  AND  InsurancePayment  > 0 AND  InsuranceAdjustment  = 0 AND PatientPaidAmount  = 0 AND PatientAdjustment  = 0 AND InsuranceBalance  = BilledAmount  AND PatientBalance = 0 AND a.TotalBalance  = BilledAmount  AND (PaymentReasonCode IS NULL OR PaymentReasonCode IS NOT NULL)  THEN  'Paid'
WHEN  BilledAmount > 0 AND AllowedAmount > 0 AND  InsurancePayment =  AllowedAmount  AND  InsuranceAdjustment  > 0 AND PatientPaidAmount  = 0 AND PatientAdjustment > 0 AND InsuranceBalance  = 0 AND PatientBalance = 0 AND a.TotalBalance  = 0 AND (PaymentReasonCode IS NULL OR PaymentReasonCode IS NOT NULL)  THEN  'Paid'
WHEN  BilledAmount > 0 AND AllowedAmount > 0 AND  InsurancePayment = 0 AND  InsuranceAdjustment  > 0 AND PatientPaidAmount  = 0 AND PatientAdjustment  = 0 AND InsuranceBalance  = 0 AND PatientBalance =  AllowedAmount  AND a.TotalBalance  =  AllowedAmount  AND (PaymentReasonCode IS NULL OR PaymentReasonCode IS NOT NULL) THEN  'Patient Responsibility'
WHEN  BilledAmount > 0 AND AllowedAmount =  BilledAmount  AND  InsurancePayment = 0 AND  InsuranceAdjustment  > 0 AND PatientPaidAmount  = 0 AND PatientAdjustment  = 0 AND InsuranceBalance  = BilledAmount  AND PatientBalance = 0 AND a.TotalBalance  = BilledAmount  AND (PaymentReasonCode IS NULL OR PaymentReasonCode IS NOT NULL) THEN  'Adjusted'
WHEN  BilledAmount > 0 AND AllowedAmount =  BilledAmount  AND  InsurancePayment = 0 AND  InsuranceAdjustment  =  BilledAmount  AND PatientPaidAmount  = 0 AND PatientAdjustment  = 0 AND InsuranceBalance  = 0 AND PatientBalance = 0 AND a.TotalBalance  = 0 AND (PaymentReasonCode IS NULL OR PaymentReasonCode IS NOT NULL) THEN  'Adjusted'
WHEN  BilledAmount > 0 AND AllowedAmount =  BilledAmount  AND  InsurancePayment = 0 AND  InsuranceAdjustment  > 0 AND PatientPaidAmount  = 0 AND PatientAdjustment  = 0 AND InsuranceBalance  = BilledAmount  AND PatientBalance = 0 AND a.TotalBalance  = BilledAmount  AND (PaymentReasonCode IS NULL OR PaymentReasonCode IS NOT NULL)  THEN  'Paid'
WHEN  BilledAmount > 0 AND AllowedAmount > 0 AND  InsurancePayment = 0 AND  InsuranceAdjustment  > 0 AND PatientPaidAmount  = 0 AND PatientAdjustment  = 0 AND InsuranceBalance  =  AllowedAmount  AND PatientBalance = 0 AND a.TotalBalance  =  InsuranceBalance  AND (PaymentReasonCode IS NULL OR PaymentReasonCode IS NOT NULL)  THEN  'Paid'
WHEN  BilledAmount > 0 AND AllowedAmount > 0 AND  InsurancePayment  > 0 AND  InsuranceAdjustment  = 0 AND PatientPaidAmount  = 0 AND PatientAdjustment  = 0 AND InsuranceBalance  = BilledAmount  AND PatientBalance = 0 AND a.TotalBalance  = BilledAmount  AND (PaymentReasonCode IS NULL OR PaymentReasonCode IS NOT NULL)  THEN  'Paid'
WHEN  BilledAmount > 0 AND AllowedAmount > 0 AND  InsurancePayment  > 0 AND  InsuranceAdjustment  > 0 AND PatientPaidAmount  = 0 AND PatientAdjustment  = 0 AND InsuranceBalance  = 0 AND PatientBalance =  AllowedAmount  -  InsurancePayment  AND a.TotalBalance  = PatientBalance AND (PaymentReasonCode IS NULL OR PaymentReasonCode IS NOT NULL)  THEN  'Paid'
WHEN  BilledAmount > 0 AND AllowedAmount > 0 AND AllowedAmount <> BilledAmount AND  InsurancePayment = 0 AND  InsuranceAdjustment  > 0 AND PatientPaidAmount  = 0 AND PatientAdjustment  = 0 AND InsuranceBalance  =  AllowedAmount  AND PatientBalance = 0 AND a.TotalBalance  =  InsuranceBalance  AND (PaymentReasonCode IS NULL OR PaymentReasonCode IS NOT NULL)  THEN  'Paid'
WHEN  BilledAmount > 0 AND AllowedAmount =  BilledAmount  AND  InsurancePayment  > 0 AND  InsuranceAdjustment  = 0 AND PatientPaidAmount  = 0 AND PatientAdjustment  = 0 AND InsuranceBalance  = 0 AND PatientBalance =  AllowedAmount  -  InsurancePayment  AND a.TotalBalance  = PatientBalance AND (PaymentReasonCode IS NULL OR PaymentReasonCode IS NOT NULL)  THEN  'Paid'
WHEN  BilledAmount > 0 AND AllowedAmount > 0 AND  InsurancePayment  > 0 AND  InsuranceAdjustment  > 0 AND PatientPaidAmount  = 0 AND PatientAdjustment  = 0 AND InsuranceBalance > 0 AND PatientBalance = 0 AND a.TotalBalance  = InsuranceBalance AND (PaymentReasonCode IS NULL OR PaymentReasonCode IS NOT NULL)  THEN  'Paid'
WHEN  BilledAmount > 0 AND AllowedAmount =  BilledAmount  AND  InsurancePayment = 0 AND  InsuranceAdjustment > 0 AND InsuranceAdjustment < AllowedAmount AND PatientPaidAmount  = 0 AND PatientAdjustment  = 0 AND InsuranceBalance = (BilledAmount - InsuranceAdjustment) AND PatientBalance = 0 AND a.TotalBalance  = InsuranceBalance AND (PaymentReasonCode IS NULL OR PaymentReasonCode IS NOT NULL)  THEN  'Paid'
WHEN  BilledAmount > 0 AND AllowedAmount =  BilledAmount  AND InsurancePayment > 0 AND InsurancePayment < AllowedAmount AND  InsuranceAdjustment  = 0 AND PatientPaidAmount  = 0 AND PatientAdjustment  = 0 AND InsuranceBalance = (BilledAmount - InsurancePayment) AND PatientBalance = 0 AND a.TotalBalance  = InsuranceBalance AND (PaymentReasonCode IS NULL OR PaymentReasonCode IS NOT NULL)  THEN  'Paid'
WHEN  BilledAmount > 0 AND AllowedAmount > 0 AND AllowedAmount < BilledAmount AND InsurancePayment = AllowedAmount AND  InsuranceAdjustment  = 0 AND PatientPaidAmount  = 0 AND PatientAdjustment  = 0 AND InsuranceBalance = (BilledAmount - InsurancePayment) AND PatientBalance = 0 AND a.TotalBalance  = InsuranceBalance AND (PaymentReasonCode IS NULL OR PaymentReasonCode IS NOT NULL)  THEN  'Paid'
WHEN  BilledAmount > 0 AND AllowedAmount > 0 AND AllowedAmount < BilledAmount AND InsurancePayment > AllowedAmount AND  InsuranceAdjustment  = 0 AND PatientPaidAmount  = 0 AND PatientAdjustment  = 0 AND InsuranceBalance = (BilledAmount - InsurancePayment) AND PatientBalance = 0 AND a.TotalBalance  = InsuranceBalance AND (PaymentReasonCode IS NULL OR PaymentReasonCode IS NOT NULL)  THEN  'Paid'
WHEN  BilledAmount > 0 AND AllowedAmount =  BilledAmount  AND InsurancePayment = 0 AND InsuranceAdjustment > 0 AND InsuranceAdjustment < AllowedAmount AND PatientPaidAmount  = 0 AND PatientAdjustment  = 0 AND InsuranceBalance =  (BilledAmount - InsuranceAdjustment) AND PatientBalance = 0 AND a.TotalBalance  = InsuranceBalance AND (PaymentReasonCode IS NULL OR PaymentReasonCode IS NOT NULL) THEN 'Adjusted'
WHEN  BilledAmount > 0 AND AllowedAmount =  BilledAmount  AND InsurancePayment = 0 AND InsuranceAdjustment = 0 AND InsuranceAdjustment = 0 AND PatientPaidAmount  = 0 AND PatientAdjustment  = BilledAmount AND InsuranceBalance =  0 AND PatientBalance = 0 AND a.TotalBalance  = 0 AND (PaymentReasonCode IS NOT NULL) THEN 'Adjusted'


ELSE 'No Response' END AS FinalStatus, 
CASE
WHEN  BilledAmount > 0 AND AllowedAmount =  BilledAmount  AND  InsurancePayment = 0 AND  InsuranceAdjustment  =  BilledAmount  AND   PatientPaidAmount  = 0 AND   PatientAdjustment  = 0 AND   InsuranceBalance  = 0 AND PatientBalance = 0 AND   a.TotalBalance  = 0 AND (PaymentReasonCode IS NULL OR PaymentReasonCode IS NOT NULL) THEN  'Fully Written Off'
WHEN  BilledAmount > 0 AND AllowedAmount > 0 AND  InsurancePayment =  AllowedAmount  AND  InsuranceAdjustment  > 0 AND   PatientPaidAmount  = 0 AND   PatientAdjustment  = 0 AND   InsuranceBalance  = 0 AND PatientBalance = 0 AND   a.TotalBalance  = 0 AND (PaymentReasonCode IS NULL OR PaymentReasonCode IS NOT NULL) THEN  'Insurance Payment'
WHEN  BilledAmount > 0 AND AllowedAmount =  BilledAmount  AND  InsurancePayment = 0 AND  InsuranceAdjustment  = 0 AND   PatientPaidAmount  = 0 AND   PatientAdjustment  = 0 AND   InsuranceBalance  =   BilledAmount  AND PatientBalance = 0 AND   a.TotalBalance  =   BilledAmount  AND PaymentReasonCode  IS NOT NULL THEN  'Insurance Denial'
WHEN  BilledAmount > 0 AND AllowedAmount =  BilledAmount  AND  InsurancePayment = 0 AND  InsuranceAdjustment  = 0 AND   PatientPaidAmount  = 0 AND   PatientAdjustment  = 0 AND   InsuranceBalance  =   BilledAmount  AND PatientBalance = 0 AND   a.TotalBalance  =   BilledAmount  AND PaymentReasonCode IS NULL THEN  'No Response from Payer Yet'
WHEN  BilledAmount > 0 AND AllowedAmount > 0 AND  InsurancePayment = 0 AND  InsuranceAdjustment  > 0 AND   PatientPaidAmount  = 0 AND   PatientAdjustment  = 0 AND   InsuranceBalance  =  AllowedAmount  AND PatientBalance = 0 AND   a.TotalBalance  =  InsuranceBalance  AND PaymentReasonCode  IS NOT NULL THEN  'Posting Pending'
WHEN  BilledAmount > 0 AND AllowedAmount > 0 AND  InsurancePayment = 0 AND  InsuranceAdjustment  =  BilledAmount  AND   PatientPaidAmount  = 0 AND   PatientAdjustment  = 0 AND   InsuranceBalance  = 0 AND PatientBalance = 0 AND   a.TotalBalance  = 0 AND (PaymentReasonCode IS NULL OR PaymentReasonCode IS NOT NULL) THEN  'Fully Written Off'
WHEN  BilledAmount > 0 AND AllowedAmount > 0 AND  InsurancePayment = 0 AND  InsuranceAdjustment  = 0 AND   PatientPaidAmount  = 0 AND   PatientAdjustment  = 0 AND   InsuranceBalance  =   BilledAmount  AND PatientBalance = 0 AND   a.TotalBalance  =   BilledAmount  AND PaymentReasonCode IS NULL THEN  'No Response from Payer Yet'
WHEN  BilledAmount > 0 AND AllowedAmount > 0 AND  InsurancePayment =  AllowedAmount  AND  InsuranceAdjustment  = 0 AND   PatientPaidAmount  = 0 AND   PatientAdjustment  = 0 AND   InsuranceBalance  = 0 AND PatientBalance  > 0 AND   a.TotalBalance  = PatientBalance AND (PaymentReasonCode IS NULL OR PaymentReasonCode IS NOT NULL) THEN  'Balance Billed to Patient'
WHEN  BilledAmount > 0 AND AllowedAmount > 0 AND  InsurancePayment =  AllowedAmount  AND  InsuranceAdjustment  > 0 AND   PatientPaidAmount  = 0 AND   PatientAdjustment  = 0 AND   InsuranceBalance  = 0 AND PatientBalance = 0 AND   a.TotalBalance  = 0 AND PaymentReasonCode  IS NOT NULL THEN  'Insurance Payment'
WHEN  BilledAmount > 0 AND AllowedAmount > 0 AND  InsurancePayment  > 0 AND  InsuranceAdjustment  > 0 AND   PatientPaidAmount  = 0 AND   PatientAdjustment  = 0 AND   InsuranceBalance  = 0 AND PatientBalance =  AllowedAmount  -  InsurancePayment  AND   a.TotalBalance  = PatientBalance AND (PaymentReasonCode IS NULL OR PaymentReasonCode IS NOT NULL) THEN  'Insurance Payment'
WHEN  BilledAmount > 0 AND AllowedAmount =  BilledAmount  AND  InsurancePayment  > 0 AND  InsuranceAdjustment  > 0 AND   PatientPaidAmount  = 0 AND   PatientAdjustment  = 0 AND   InsuranceBalance  = 0 AND PatientBalance = 0 AND   a.TotalBalance  = 0 AND (PaymentReasonCode IS NULL OR PaymentReasonCode IS NOT NULL) THEN  'Posting Error'
WHEN  BilledAmount > 0 AND AllowedAmount > 0 AND  InsurancePayment =  AllowedAmount  AND  InsuranceAdjustment  = 0 AND   PatientPaidAmount  = 0 AND   PatientAdjustment  = 0 AND   InsuranceBalance  =   BilledAmount  AND PatientBalance = 0 AND   a.TotalBalance  =   BilledAmount  AND (PaymentReasonCode IS NULL OR PaymentReasonCode IS NOT NULL) THEN  'Insurance Adjustment not posted'
WHEN  BilledAmount > 0 AND AllowedAmount > 0 AND  InsurancePayment =  AllowedAmount  AND  InsuranceAdjustment  = 0 AND   PatientPaidAmount  = 0 AND   PatientAdjustment  = 0 AND   InsuranceBalance  =   BilledAmount  AND PatientBalance = 0 AND   a.TotalBalance  =   BilledAmount  AND (PaymentReasonCode IS NULL OR PaymentReasonCode IS NOT NULL) THEN  'Adjustment not posted'
WHEN  BilledAmount > 0 AND AllowedAmount = 0 AND  InsurancePayment = 0 AND  InsuranceAdjustment  =  BilledAmount  AND   PatientPaidAmount  = 0 AND   PatientAdjustment  = 0 AND   InsuranceBalance  = 0 AND PatientBalance = 0 AND   a.TotalBalance  = 0 AND (PaymentReasonCode IS NULL OR PaymentReasonCode IS NOT NULL) THEN  'Fully Written Off'
WHEN  BilledAmount > 0 AND AllowedAmount > 0 AND  InsurancePayment  > 0 AND  InsuranceAdjustment  > 0 AND   PatientPaidAmount  = 0 AND   PatientAdjustment  = 0 AND   InsuranceBalance  = 0 AND PatientBalance = 0 AND   a.TotalBalance  = 0 AND (PaymentReasonCode IS NULL OR PaymentReasonCode IS NOT NULL) THEN  'Posting Error'
WHEN  BilledAmount > 0 AND AllowedAmount = 0 AND  InsurancePayment = 0 AND  InsuranceAdjustment  = 0 AND   PatientPaidAmount  = 0 AND   PatientAdjustment  = 0 AND   InsuranceBalance  =   BilledAmount  AND PatientBalance = 0 AND   a.TotalBalance  =   BilledAmount  AND PaymentReasonCode IS NULL THEN  'No Response from Payer Yet'
WHEN  BilledAmount > 0 AND AllowedAmount > 0 AND  InsurancePayment =  AllowedAmount  AND  InsuranceAdjustment  = 0 AND   PatientPaidAmount  = 0 AND   PatientAdjustment  = 0 AND   InsuranceBalance  =   BilledAmount  AND PatientBalance = 0 AND   a.TotalBalance  =   BilledAmount  AND PaymentReasonCode  IS NOT NULL THEN  'Adjustment not posted'
WHEN  BilledAmount > 0 AND AllowedAmount > 0 AND  InsurancePayment =  AllowedAmount  AND  InsuranceAdjustment  > 0 AND   PatientPaidAmount  = 0 AND   PatientAdjustment  = 0 AND   InsuranceBalance  =   BilledAmount  AND PatientBalance = 0 AND   a.TotalBalance  =   BilledAmount  AND PaymentReasonCode  IS NOT NULL THEN  'Insurance Payment'
WHEN  BilledAmount > 0 AND AllowedAmount > 0 AND  InsurancePayment  > 0 AND  InsuranceAdjustment  > 0 AND   PatientPaidAmount  = 0 AND   PatientAdjustment  = 0 AND   InsuranceBalance  =   BilledAmount  AND PatientBalance = 0 AND   a.TotalBalance  =   BilledAmount  AND PaymentReasonCode  IS NOT NULL THEN  '  BilledAmount  not equal to Allowed + Adjustment'
WHEN  BilledAmount > 0 AND AllowedAmount =  BilledAmount  AND  InsurancePayment =  AllowedAmount  AND  InsuranceAdjustment  = 0 AND   PatientPaidAmount  = 0 AND   PatientAdjustment  = 0 AND   InsuranceBalance  = 0 AND PatientBalance = 0 AND   a.TotalBalance  = 0 AND (PaymentReasonCode IS NULL OR PaymentReasonCode IS NOT NULL) THEN  'Insurance Payment'
WHEN  BilledAmount > 0 AND AllowedAmount > 0 AND  InsurancePayment = 0 AND  InsuranceAdjustment  = 0 AND   PatientPaidAmount  = 0 AND   PatientAdjustment  = 0 AND   InsuranceBalance  =   BilledAmount  AND PatientBalance = 0 AND   a.TotalBalance  =   BilledAmount  AND PaymentReasonCode  IS NOT NULL THEN  'Insurance Denial'
WHEN  BilledAmount > 0 AND AllowedAmount > 0 AND  InsurancePayment  > 0 AND  InsuranceAdjustment  > 0 AND   PatientPaidAmount  = 0 AND   PatientAdjustment  = 0 AND   InsuranceBalance  =   BilledAmount  AND PatientBalance = 0 AND   a.TotalBalance  =   BilledAmount  AND (PaymentReasonCode IS NULL OR PaymentReasonCode IS NOT NULL) THEN  'Posting Error'
WHEN  BilledAmount > 0 AND AllowedAmount > 0 AND  InsurancePayment =  AllowedAmount  AND  InsuranceAdjustment  > 0 AND   PatientPaidAmount  = 0 AND   PatientAdjustment  = 0 AND   InsuranceBalance  =  AllowedAmount  AND PatientBalance = 0 AND   a.TotalBalance  =  InsuranceBalance  AND PaymentReasonCode  IS NOT NULL THEN  'Posting Pending'
WHEN  BilledAmount > 0 AND AllowedAmount > 0 AND  InsurancePayment =  AllowedAmount  AND  InsuranceAdjustment  > 0 AND   PatientPaidAmount  = 0 AND   PatientAdjustment  = 0 AND   InsuranceBalance  =   BilledAmount  AND PatientBalance = 0 AND   a.TotalBalance  =   BilledAmount  AND (PaymentReasonCode IS NULL OR PaymentReasonCode IS NOT NULL) THEN  'Insurance Payment'
WHEN  BilledAmount > 0 AND AllowedAmount =  BilledAmount  AND  InsurancePayment  > 0 AND  InsuranceAdjustment  > 0 AND   PatientPaidAmount  = 0 AND   PatientAdjustment  = 0 AND   InsuranceBalance  = 0 AND PatientBalance = 0 AND   a.TotalBalance  = 0 AND (PaymentReasonCode IS NULL OR PaymentReasonCode IS NOT NULL) THEN  'Insurance Payment'
WHEN  BilledAmount > 0 AND AllowedAmount = 0 AND  InsurancePayment = 0 AND  InsuranceAdjustment  = 0 AND   PatientPaidAmount  = 0 AND   PatientAdjustment  = 0 AND   InsuranceBalance  =   BilledAmount  AND PatientBalance = 0 AND   a.TotalBalance  =   BilledAmount  AND PaymentReasonCode  IS NOT NULL THEN  'Insurance Denial'
WHEN  BilledAmount > 0 AND AllowedAmount > 0 AND  InsurancePayment = 0 AND  InsuranceAdjustment  > 0 AND   PatientPaidAmount  = 0 AND   PatientAdjustment  = 0 AND   InsuranceBalance  =   BilledAmount  AND PatientBalance = 0 AND   a.TotalBalance  =   BilledAmount  AND PaymentReasonCode  IS NOT NULL THEN  'Posting Pending'
WHEN  BilledAmount > 0 AND AllowedAmount =  BilledAmount  AND  InsurancePayment = 0 AND  InsuranceAdjustment  = 0 AND   PatientPaidAmount  = 0 AND   PatientAdjustment  = 0 AND   InsuranceBalance  = 0 AND PatientBalance =  AllowedAmount  AND   a.TotalBalance  =  AllowedAmount  AND (PaymentReasonCode IS NULL OR PaymentReasonCode IS NOT NULL) THEN  'Adjudicated towards Patient Responsibility'
WHEN  BilledAmount > 0 AND AllowedAmount = 0 AND  InsurancePayment = 0 AND  InsuranceAdjustment  = 0 AND   PatientPaidAmount  = 0 AND   PatientAdjustment  = 0 AND   InsuranceBalance  = 0 AND PatientBalance =   BilledAmount  AND   a.TotalBalance  =   BilledAmount  AND (PaymentReasonCode IS NULL OR PaymentReasonCode IS NOT NULL) THEN  'Moved to Patient Responsibility'
WHEN  BilledAmount > 0 AND AllowedAmount =  BilledAmount  AND  InsurancePayment  > 0 AND  InsuranceAdjustment  = 0 AND   PatientPaidAmount  = 0 AND   PatientAdjustment  = 0 AND   InsuranceBalance  =   BilledAmount  AND PatientBalance = 0 AND   a.TotalBalance  =   BilledAmount  AND PaymentReasonCode  IS NOT NULL THEN  'Posting Pending'
WHEN  BilledAmount > 0 AND AllowedAmount > 0 AND  InsurancePayment =  AllowedAmount  AND  InsuranceAdjustment  > 0 AND   PatientPaidAmount  = 0 AND   PatientAdjustment   > 0 AND   InsuranceBalance  = 0 AND PatientBalance = 0 AND   a.TotalBalance  = 0 AND (PaymentReasonCode IS NULL OR PaymentReasonCode IS NOT NULL) THEN  'Insurance Payment'
WHEN  BilledAmount > 0 AND AllowedAmount > 0 AND  InsurancePayment = 0 AND  InsuranceAdjustment  > 0 AND   PatientPaidAmount  = 0 AND   PatientAdjustment  = 0 AND   InsuranceBalance  = 0 AND PatientBalance =  AllowedAmount  AND   a.TotalBalance  =  AllowedAmount  AND (PaymentReasonCode IS NULL OR PaymentReasonCode IS NOT NULL) THEN  'Adjudicated towards Patient Responsibility'
WHEN  BilledAmount > 0 AND AllowedAmount =  BilledAmount  AND  InsurancePayment = 0 AND  InsuranceAdjustment  > 0 AND   PatientPaidAmount  = 0 AND   PatientAdjustment  = 0 AND   InsuranceBalance  =   BilledAmount  AND PatientBalance = 0 AND   a.TotalBalance  =   BilledAmount  AND (PaymentReasonCode IS NULL OR PaymentReasonCode IS NOT NULL) THEN  'Posting Error'
WHEN  BilledAmount > 0 AND AllowedAmount =  BilledAmount  AND  InsurancePayment = 0 AND  InsuranceAdjustment  =  BilledAmount  AND   PatientPaidAmount  = 0 AND   PatientAdjustment  = 0 AND   InsuranceBalance  = 0 AND PatientBalance = 0 AND   a.TotalBalance  = 0 AND PaymentReasonCode  IS NOT NULL THEN  'Fully Written Off'
WHEN  BilledAmount > 0 AND AllowedAmount =  BilledAmount  AND  InsurancePayment = 0 AND  InsuranceAdjustment  > 0 AND   PatientPaidAmount  = 0 AND   PatientAdjustment  = 0 AND   InsuranceBalance  =   BilledAmount  AND PatientBalance = 0 AND   a.TotalBalance  =   BilledAmount  AND PaymentReasonCode  IS NOT NULL THEN  'Posting Pending'
WHEN  BilledAmount > 0 AND AllowedAmount > 0 AND  InsurancePayment = 0 AND  InsuranceAdjustment  > 0 AND   PatientPaidAmount  = 0 AND   PatientAdjustment  = 0 AND   InsuranceBalance  =  AllowedAmount  AND PatientBalance = 0 AND   a.TotalBalance  =  InsuranceBalance  AND (PaymentReasonCode IS NULL OR PaymentReasonCode IS NOT NULL) THEN  'Posting Pending'
WHEN  BilledAmount > 0 AND AllowedAmount > 0 AND  InsurancePayment  > 0 AND  InsuranceAdjustment  = 0 AND   PatientPaidAmount  = 0 AND   PatientAdjustment  = 0 AND   InsuranceBalance  =   BilledAmount  AND PatientBalance = 0 AND   a.TotalBalance  =   BilledAmount  AND (PaymentReasonCode IS NULL OR PaymentReasonCode IS NOT NULL) THEN  'Insurance Adjustment not posted'
WHEN  BilledAmount > 0 AND AllowedAmount > 0 AND  InsurancePayment  > 0 AND  InsuranceAdjustment  > 0 AND   PatientPaidAmount  = 0 AND   PatientAdjustment  = 0 AND   InsuranceBalance  = 0 AND PatientBalance =  AllowedAmount  -  InsurancePayment  AND   a.TotalBalance  = PatientBalance AND PaymentReasonCode  IS NOT NULL THEN  'Insurance Payment'
WHEN  BilledAmount > 0 AND AllowedAmount > 0 AND AllowedAmount <> BilledAmount AND  InsurancePayment = 0 AND  InsuranceAdjustment  > 0 AND   PatientPaidAmount  = 0 AND   PatientAdjustment  = 0 AND   InsuranceBalance  =  AllowedAmount  AND PatientBalance = 0 AND   a.TotalBalance  =  InsuranceBalance  AND PaymentReasonCode  IS NOT NULL THEN  'Posting Pending'
WHEN  BilledAmount > 0 AND AllowedAmount =  BilledAmount  AND  InsurancePayment  > 0 AND  InsuranceAdjustment  = 0 AND   PatientPaidAmount  = 0 AND   PatientAdjustment  = 0 AND   InsuranceBalance  = 0 AND PatientBalance =  AllowedAmount  -  InsurancePayment  AND   a.TotalBalance  = PatientBalance AND (PaymentReasonCode IS NULL OR PaymentReasonCode IS NOT NULL) THEN  'Balance Billed to Patient'
WHEN  BilledAmount > 0 AND  AllowedAmount > 0 AND  InsurancePayment  > 0 AND  InsuranceAdjustment  > 0 AND   PatientPaidAmount  = 0 AND   PatientAdjustment  = 0 AND InsuranceBalance > 0 AND PatientBalance = 0 AND   a.TotalBalance  = InsuranceBalance AND PaymentReasonCode  IS NOT NULL THEN  'Insurance Payment'
WHEN  BilledAmount > 0 AND AllowedAmount =  BilledAmount  AND  InsurancePayment = 0 AND  InsuranceAdjustment > 0 AND InsuranceAdjustment < AllowedAmount AND   PatientPaidAmount  = 0 AND   PatientAdjustment  = 0 AND InsuranceBalance = (BilledAmount - InsuranceAdjustment) AND PatientBalance = 0 AND   a.TotalBalance  = InsuranceBalance AND PaymentReasonCode  IS NOT NULL THEN  'Posting Error'
WHEN  BilledAmount > 0 AND AllowedAmount =  BilledAmount  AND InsurancePayment > 0 AND InsurancePayment < AllowedAmount AND  InsuranceAdjustment  = 0 AND   PatientPaidAmount  = 0 AND   PatientAdjustment  = 0 AND InsuranceBalance = (BilledAmount - InsurancePayment) AND PatientBalance = 0 AND   a.TotalBalance  = InsuranceBalance AND PaymentReasonCode  IS NOT NULL THEN  'Posting Error'
WHEN  BilledAmount > 0 AND AllowedAmount > 0 AND AllowedAmount < BilledAmount AND InsurancePayment = AllowedAmount AND  InsuranceAdjustment  = 0 AND   PatientPaidAmount  = 0 AND   PatientAdjustment  = 0 AND InsuranceBalance = (BilledAmount - InsurancePayment) AND PatientBalance = 0 AND   a.TotalBalance  = InsuranceBalance and (PaymentReasonCode IS NULL OR PaymentReasonCode IS NOT NULL)  THEN  'Posting Error'
WHEN  BilledAmount > 0 AND AllowedAmount > 0 AND AllowedAmount < BilledAmount AND InsurancePayment > AllowedAmount AND  InsuranceAdjustment  = 0 AND   PatientPaidAmount  = 0 AND   PatientAdjustment  = 0 AND InsuranceBalance = (BilledAmount - InsurancePayment) AND PatientBalance = 0 AND   a.TotalBalance  = InsuranceBalance  and  (PaymentReasonCode IS NULL OR PaymentReasonCode IS NOT NULL)  THEN  'Posting Error'
WHEN  BilledAmount > 0 AND AllowedAmount =  BilledAmount  AND InsurancePayment = 0 AND InsuranceAdjustment > 0 AND InsuranceAdjustment < AllowedAmount AND   PatientPaidAmount  = 0 AND   PatientAdjustment  = 0 AND InsuranceBalance =  (BilledAmount - InsuranceAdjustment) AND PatientBalance = 0 AND   a.TotalBalance  = InsuranceBalance  and (PaymentReasonCode IS NULL OR PaymentReasonCode IS NOT NULL)  THEN  'Posting Error'
WHEN  BilledAmount > 0 AND AllowedAmount =  BilledAmount  AND InsurancePayment = 0 AND InsuranceAdjustment = 0 AND InsuranceAdjustment = 0 AND PatientPaidAmount  = 0 AND PatientAdjustment  = BilledAmount AND InsuranceBalance =  0 AND PatientBalance = 0 AND a.TotalBalance  = 0 AND (PaymentReasonCode IS NULL OR PaymentReasonCode IS NOT NULL) THEN 'Adjusted'
ELSE 'No Response'
END AS ClaimSubStatus FROM BillingMaster a
  LEFT JOIN DenialTrackingMaster b 
  ON a.VisitNumber = b.VisitNumber AND a.CPTCode = b.CPTCodes
AND (
    PaymentReasonCode IS NOT NULL

    AND NOT (
			';' + PaymentReasonCode + ';' LIKE '%;CO45;%'
		OR	';' + PaymentReasonCode + ';' LIKE '%;CO253;%'
		OR	';' + PaymentReasonCode + ';' LIKE '%;PR1;%'
        OR	';' + PaymentReasonCode + ';' LIKE '%;PR2;%'
        OR	';' + PaymentReasonCode + ';' LIKE '%;PR3;%'
    )
)
    WHERE a.VisitNumber = @VisitNumber AND a.CPTCode = @CPTCode 
	  AND ISNULL(a.FirstBillDate, '1900-01-01') = ISNULL(@FirstBillDate, '1900-01-01')
		   AND ISNULL(a.Units,999) = ISNULL(@Units,999)
		   AND ABS(a.BilledAmount - @BilledAmount) < 0.01
		   AND ISNULL(a.Modifier,9999) = ISNULL(@Modifier,9999)
);
GO
/****** Object:  StoredProcedure [dbo].[BillingMasterProcess_Proc]******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE PROCEDURE [dbo].[BillingMasterProcess_Proc]
@FileId INT = NULL
AS
BEGIN
    SET NOCOUNT ON;


    -- Drop temp tables if they exist
	DROP TABLE IF EXISTS #CustomCollectionData;
    DROP TABLE IF EXISTS #BillingMaster;
    DROP TABLE IF EXISTS #BillingMaster_Deduped;
	DROP TABLE IF EXISTS #VAATemp;
	DROP TABLE IF EXISTS #CollectionFiles;
	DROP TABLE IF EXISTS #TransData
	DROP TABLE IF EXISTS #FinalBillingMaster

	IF @FileId IS NULL
		SET @FileId = (SELECT TOP 1 ImportedFileID FROM CustomCollectionStaging ORDER BY ImportedFileID DESC)

    -- Step 1: Load distinct staging data
    SELECT 
        VisitNumber,
        LTRIM(RTRIM(SUBSTRING(BilledCPTCode, 1, 5))) AS CPTCode,
        LastBillDate,
        ChargeEntryDate,
        PayerName,
        PayerType,
        BillingProvider,
        ReferringProvider,
        PerformingLab,
        PatientID,
        LTRIM(RTRIM(UPPER(PatientName))) PatientName,
        DOB,
        ResponsibleParty,
        MemberID,
        ClientAccNum,
        BeginDOS,
        EndDOS,
        BillingFrequency,
        ChargeEnteredBy,
        POS,
        TOS,
        Modifier,
        ICD10Code,
        BilledAmount,
        AllowedAmount,
        InsurancePayments,
        InsuranceAdjustments,
        PatientPayments,
        PatientAdjustments,
        InsuranceBalance,
        PatientBalance,
        TotalBalance
    INTO #CustomCollectionData
    FROM CustomCollectionStaging WHERE (ImportedFileID = @FileId OR @FileId IS NULL);

	Select distinct lis.LISMasterId,vaa.AccessionNo,vaa.VisitNumber into #VAATemp  from VisitAgaistAccessionStaging vaa
	join LISMaster lis on vaa.AccessionNo = lis.AccessionNo where vaa.AccessionNo is not null;

	select distinct VisitNo,CPTCode,Units,TotalBilledAmount INTO #TransData from TransactionMaster 
	where TransactionType = 'Charge' and TotalBilledAmount > 0 and void is null 

	SELECT CD.*,Units INTO #FinalBillingMaster FROM #CustomCollectionData CD 
	JOIN #TransData TD  ON CD.VisitNumber = TD.VisitNo and CD.CPTCode = TD.CPTCode and CD.BilledAmount = TD.TotalBilledAmount;

    SELECT
        CC.VisitNumber VisitNumber,
        CC.CPTCode,
        CC.LastBillDate AS FirstBillDate,
        CC.ChargeEntryDate,
        IPM.InsurancePayerId,
        PT.PayerTypeId,
        BP.BillingProviderID,
        CC.MemberID,
        CC.ClientAccNum,
        CC.BeginDOS,
        CC.EndDOS,
        CC.BillingFrequency,
        CC.ChargeEnteredBy,
        CC.POS,
        CC.TOS,
        CC.ICD10Code,
		PatientID,
        PatientName,
		RP.ReferingProviderId,
		ISNULL(cc.UNITS,0) UNITS,
		ISNULL(CC.Modifier,0) Modifier,
        SUM(CC.BilledAmount) AS BilledAmount,
        SUM(CC.AllowedAmount) AS AllowedAmount,
        SUM(CC.InsurancePayments) AS InsurancePayments,
        SUM(CC.InsuranceAdjustments) AS InsuranceAdjustments,
        SUM(CC.PatientPayments) AS PatientPayments,
        SUM(CC.PatientAdjustments) AS PatientAdjustments,
        SUM(CC.InsuranceBalance) AS InsuranceBalance,
        SUM(CC.PatientBalance) AS PatientBalance,
        SUM(CC.TotalBalance) AS TotalBalance
    INTO #BillingMaster
    FROM #FinalBillingMaster CC
	--LEFT JOIN #VAATemp vaa ON CC.VisitNumber = vaa.VisitNumber
    LEFT JOIN InsurancePayerMaster IPM ON TRIM(CC.PayerName) = TRIM(IPM.PayerName)
    LEFT JOIN PayerTypeMaster PT ON TRIM(CC.PayerType) = TRIM(PT.PayerType)
    LEFT JOIN BillingProviderMaster BP ON TRIM(CC.BillingProvider) = TRIM(BP.BillingProvider)
	LEFT JOIN ReferringProviderMaster RP on TRIM(CC.ReferringProvider) = TRIM(RP.ReferringProviderName)
    GROUP BY
		--vaa.LISMasterId,
  --      vaa.AccessionNo,
        CC.VisitNumber,
        CC.CPTCode,
        CC.LastBillDate,
        CC.ChargeEntryDate,
        IPM.InsurancePayerId,
        PT.PayerTypeId,
        BP.BillingProviderID,
        CC.MemberID,
        CC.ClientAccNum,
        CC.BeginDOS,
        CC.EndDOS,
        CC.BillingFrequency,
        CC.ChargeEnteredBy,
        CC.POS,
        CC.TOS,
        CC.ICD10Code,
		--VAA.AccessionNo,
		cc.UNITS,CC.Modifier,PatientID,
        PatientName,RP.ReferingProviderId;

     ------Step 3: Deduplicate
    --WITH RankedBilling AS (
    --    SELECT *,
    --        ROW_NUMBER() OVER (
    --            PARTITION BY 
    --    VisitNumber, CPTCode,  FirstBillDate,UNITS,Modifier,BilledAmount
    --            ORDER BY BilledAmount DESC
    --        ) AS RowNum
    --    FROM #BillingMaster
    --)
    --SELECT *
    --INTO #BillingMaster_Deduped
    --FROM RankedBilling
    --WHERE RowNum = 1;

    -- Step 4: Merge
    BEGIN TRY
        BEGIN TRANSACTION;

				DELETE FROM BillingMaster WHERE VisitNumber IN (SELECT DISTINCT VisitNumber FROM #BillingMaster)

				DECLARE @mx bigint;
				SELECT @mx = ISNULL(MAX(BillingMasterId), 0) FROM dbo.BillingMaster WITH (TABLOCKX);
				DBCC CHECKIDENT ('dbo.BillingMaster', RESEED, @mx);
				
     
	            INSERT into BillingMaster(
                --LISMasterId,
                --AccessionNo,
                VisitNumber,
                PrimaryPayerID,
                PayerTypeId,
                BillingProviderID,
                ClientAccNum,
                MemberID,
                BeginDOS,
                EndDOS,
                ChargeEntryDate,
                FirstBillDate,
                BillingFrequency,
                ChargeEnteredBy,
                CPTCode,
                POS,
                TOS,
                Modifier,
                ICD10Code,
                BilledAmount,
                AllowedAmount,
                InsurancePayment,
                InsuranceAdjustment,
                PatientPaidAmount,
                PatientAdjustment,
                InsuranceBalance,
                PatientBalance,
                TotalBalance,
				Units,
				PatientID,
				PatientName,
				ReferringProviderId
            )
			SELECT VisitNumber,InsurancePayerId,PayerTypeId,BillingProviderID,ClientAccNum,MemberID,BeginDOS,EndDOS,
			ChargeEntryDate,FirstBillDate,BillingFrequency,ChargeEnteredBy,CPTCode,POS,TOS,Modifier,ICD10Code,BilledAmount,AllowedAmount,InsurancePayments,
			InsuranceAdjustments,PatientPayments,PatientAdjustments,InsuranceBalance,PatientBalance,TotalBalance,UNITS,
			PatientID,PatientName,ReferingProviderId FROM #BillingMaster BM 

			UPDATE BM SET BM.AccessionNo = vaa.AccessionNo,bm.LISMasterId = vaa.LISMasterId FROM BillingMaster BM 
			JOIN #VAATemp vaa ON BM.VisitNumber = VAA.VisitNumber

		UPDATE 	BillingMaster SET CheckDate = NULL ,PaymentPostedDate = NULL,CheckNumber = NULL,ChartNumber =NULL;

		WITH CTE_TransData AS
		(
			SELECT 
				VisitNo,
				CPTCode,
				ChartNumber,
				CheckNumber,
				DateofDeposit AS CheckDate,
				DateofEntry AS LastPostedDate,
				ROW_NUMBER() OVER (
					PARTITION BY VisitNo,CPTCode
					ORDER BY DateofDeposit DESC, DateofEntry DESC
				) AS rn
			FROM TransactionMaster 
			WHERE CheckNumber is not null
		)
		SELECT 
			VisitNo,CPTCode,
			ChartNumber,
			CheckNumber,
			CheckDate,
			LastPostedDate
			into #TransMaster_ChckDtl
		FROM CTE_TransData 
		WHERE rn = 1
		ORDER BY VisitNo;



		UPDATE BM SET BM.CheckDate = PPI.CheckDate ,BM.PaymentPostedDate = PPI.LastPostedDate,bm.CheckNumber = PPI.CheckNumber,BM.ChartNumber = PPI.ChartNumber
		FROM BillingMaster BM JOIN #TransMaster_ChckDtl PPI ON BM.VisitNumber = PPI.VisitNo AND BM.CPTCode = PPI.CPTCode --where InsurancePayment > 0


		EXEC sp_ClaimLevelStatusUpdate;
		EXEC SP_ProcessVAAvsLIS;
		EXEC sp_Process_FinalCalimStatus;
		EXEC sp_ClaimBillingDetails @FileId;
		EXEC SP_UpdateLIS_Statuses;

        COMMIT TRANSACTION;
    END TRY
    BEGIN CATCH
        ROLLBACK TRANSACTION;
        PRINT 'Error during MERGE: ' + ERROR_MESSAGE();
			update ImportedFiles set FileStatus = 2,ProcessedOn = GETDATE() where ImportedFileID = @FileId;
    END CATCH;
END;
GO
/****** Object:  StoredProcedure [dbo].[EvaluateClaims]******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE   PROCEDURE [dbo].[EvaluateClaims]
AS
BEGIN
    SET NOCOUNT ON;

    IF OBJECT_ID('tempdb..#EvaluationResults') IS NOT NULL DROP TABLE #EvaluationResults;

    CREATE TABLE #EvaluationResults (
        VisitNumber INT,
        Final_Output_Status NVARCHAR(100)
    );

    DECLARE @VisitNumber INT, @FinalStatus NVARCHAR(100), @sql NVARCHAR(MAX);

    DECLARE claim_cursor CURSOR FOR
        SELECT VisitNumber FROM ClaimsProdStatus;

    OPEN claim_cursor;
    FETCH NEXT FROM claim_cursor INTO @VisitNumber;

    WHILE @@FETCH_STATUS = 0
    BEGIN
        SET @FinalStatus = 'Unmatched';

        DECLARE rule_cursor CURSOR FOR
            SELECT RuleID, 
                   Resulted_Date_Condition, Billed_Date_Condition, TotalCharge_Condition,
                   TotalAllowed_Condition, CarrierPayment_Condition, CarrierWO_Condition,
                   PatientPayment_Condition, PatientWO_Condition, CarrierBalance_Condition,
                   PatientBalance_Condition, TotalBalance_Condition, Denial_Code_Condition,
                   Final_Output_Status
            FROM ProdStatusRuleEngine
            ORDER BY RuleID;

        DECLARE @RuleID INT,
                @Resulted_Date_Condition NVARCHAR(50), @Billed_Date_Condition NVARCHAR(50),
                @TotalCharge_Condition NVARCHAR(50), @TotalAllowed_Condition NVARCHAR(50),
                @CarrierPayment_Condition NVARCHAR(50), @CarrierWO_Condition NVARCHAR(50),
                @PatientPayment_Condition NVARCHAR(50), @PatientWO_Condition NVARCHAR(50),
                @CarrierBalance_Condition NVARCHAR(50), @PatientBalance_Condition NVARCHAR(50),
                @TotalBalance_Condition NVARCHAR(50), @Denial_Code_Condition NVARCHAR(50),
                @RuleStatus NVARCHAR(100);

        OPEN rule_cursor;
        FETCH NEXT FROM rule_cursor INTO
            @RuleID, @Resulted_Date_Condition, @Billed_Date_Condition, @TotalCharge_Condition,
            @TotalAllowed_Condition, @CarrierPayment_Condition, @CarrierWO_Condition,
            @PatientPayment_Condition, @PatientWO_Condition, @CarrierBalance_Condition,
            @PatientBalance_Condition, @TotalBalance_Condition, @Denial_Code_Condition, @RuleStatus;

        WHILE @@FETCH_STATUS = 0
        BEGIN
            -- Build dynamic SQL condition
            SET @sql = '
            IF EXISTS (
                SELECT 1
                FROM ClaimsProdStatus c
                JOIN BillingMaster b ON c.VisitNumber = TRY_CAST(b.VisitNumber AS INT)
                WHERE c.VisitNumber = @VisitNumber
                ' +
                COALESCE(' AND ' + dbo.BuildCondition('Resulted_Date', @Resulted_Date_Condition), '') +
                COALESCE(' AND ' + dbo.BuildCondition('Billed_Date', @Billed_Date_Condition), '') +
                COALESCE(' AND ' + dbo.BuildCondition('TotalCharge', @TotalCharge_Condition), '') +
                COALESCE(' AND ' + dbo.BuildCondition('TotalAllowed', @TotalAllowed_Condition), '') +
                COALESCE(' AND ' + dbo.BuildCondition('CarrierPayment', @CarrierPayment_Condition), '') +
                COALESCE(' AND ' + dbo.BuildCondition('CarrierWO', @CarrierWO_Condition), '') +
                COALESCE(' AND ' + dbo.BuildCondition('PatientPayment', @PatientPayment_Condition), '') +
                COALESCE(' AND ' + dbo.BuildCondition('PatientWO', @PatientWO_Condition), '') +
                COALESCE(' AND ' + dbo.BuildCondition('CarrierBalance', @CarrierBalance_Condition), '') +
                COALESCE(' AND ' + dbo.BuildCondition('PatientBalance', @PatientBalance_Condition), '') +
                COALESCE(' AND ' + dbo.BuildCondition('TotalBalance', @TotalBalance_Condition), '') +
                COALESCE(' AND ' + dbo.BuildCondition('Denial_Code', @Denial_Code_Condition), '') +
                '
            )
            BEGIN
                SET @FinalStatus = ''' + @RuleStatus + ''';
                PRINT ''VisitNumber ' + CAST(@VisitNumber AS NVARCHAR) + ' matched RuleID ' + CAST(@RuleID AS NVARCHAR) + ''';
            END
            ELSE
            BEGIN
                -- PRINT unmatched for diagnostics
                PRINT ''VisitNumber ' + CAST(@VisitNumber AS NVARCHAR) + ' did NOT match RuleID ' + CAST(@RuleID AS NVARCHAR) + ''';
            END
            '

            -- DEBUG: Print the dynamic SQL
            PRINT @sql;

            EXEC sp_executesql @sql, N'@VisitNumber INT, @FinalStatus NVARCHAR(100) OUTPUT', @VisitNumber = @VisitNumber, @FinalStatus = @FinalStatus OUTPUT;

            IF @FinalStatus <> 'Unmatched'
                BREAK;

            FETCH NEXT FROM rule_cursor INTO
                @RuleID, @Resulted_Date_Condition, @Billed_Date_Condition, @TotalCharge_Condition,
                @TotalAllowed_Condition, @CarrierPayment_Condition, @CarrierWO_Condition,
                @PatientPayment_Condition, @PatientWO_Condition, @CarrierBalance_Condition,
                @PatientBalance_Condition, @TotalBalance_Condition, @Denial_Code_Condition, @RuleStatus;
        END

        CLOSE rule_cursor;
        DEALLOCATE rule_cursor;

        INSERT INTO #EvaluationResults (VisitNumber, Final_Output_Status)
        VALUES (@VisitNumber, @FinalStatus);

        FETCH NEXT FROM claim_cursor INTO @VisitNumber;
    END

    CLOSE claim_cursor;
    DEALLOCATE claim_cursor;

    -- Final update
    UPDATE c
    SET c.Final_Output_Status = e.Final_Output_Status
    FROM ClaimsProdStatus c
    JOIN #EvaluationResults e ON c.VisitNumber = e.VisitNumber;

    DROP TABLE #EvaluationResults;
END
GO
/****** Object:  StoredProcedure [dbo].[sp_ClaimBillingDetails]******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE   PROCEDURE [dbo].[sp_ClaimBillingDetails]
    @CutomCollectionFileID VARCHAR(200) = NULL
AS
BEGIN
    SET NOCOUNT ON;

    -- Drop temp tables if they exist
    DROP TABLE IF EXISTS #ClaimBillingDetail;
    DROP TABLE IF EXISTS #CollectionFiles;

    -- Parse file IDs into a temp table
    SELECT TRY_CAST(value AS INT) AS FileId
    INTO #CollectionFiles
    FROM STRING_SPLIT(@CutomCollectionFileID, ',')
    WHERE TRY_CAST(value AS INT) IS NOT NULL;

    -- Load distinct claim billing data into temp table
    SELECT DISTINCT 
        UPPER(LTRIM(RTRIM(VAA.AccessionNo))) AccessionNo,
        CCW.VisitNumber,
        LTRIM(RTRIM(SUBSTRING(CCW.BilledCPTCode, 0, 6))) AS CPTCode,
        CCW.LastBillDate,
        CCW.BilledAmount,
        CCW.AllowedAmount,
        CCW.InsurancePayments,
        CCW.InsuranceAdjustments,
        CCW.PatientPayments,
        CCW.PatientAdjustments,
        CCW.InsuranceBalance,
        CCW.PatientBalance,
        CCW.TotalBalance
    INTO #ClaimBillingDetail
    FROM CustomCollectionStaging CCW
    JOIN VisitAgaistAccessionStaging VAA ON CCW.VisitNumber = VAA.VisitNumber
    WHERE VAA.AccessionNo IS NOT NULL
      AND (@CutomCollectionFileID IS NULL OR CCW.ImportedFileID IN (SELECT FileId FROM #CollectionFiles));

    -- Update existing records
    UPDATE CD
    SET 
        CD.FirstBillDate = CBD.LastBillDate,
        CD.BilledAmount = CBD.BilledAmount,
        CD.AllowedAmount = CBD.AllowedAmount,
        CD.InsurancePaidAmount = CBD.InsurancePayments,
        CD.InsuranceAdjustmentAmount = CBD.InsuranceAdjustments,
        CD.PatientPaidAmount = CBD.PatientPayments,
        CD.PatientAdjustmentAmount = CBD.PatientAdjustments,
        CD.InsuranceBalance = CBD.InsuranceBalance,
        CD.PatientBalance = CBD.PatientBalance,
        CD.TotalBalance = CBD.TotalBalance
    FROM [dbo].[ClaimBillingDetails] CD
    JOIN #ClaimBillingDetail CBD 
        ON CD.AccessionNo = CBD.AccessionNo 
        AND CD.VisitNumber = CBD.VisitNumber 
        AND CD.CPTCode = CBD.CPTCode;

    -- Insert new records
    INSERT INTO [dbo].[ClaimBillingDetails]
    (
        [AccessionNo], [VisitNumber], [CPTCode], [FirstBillDate], [BilledAmount],
        [AllowedAmount], [InsurancePaidAmount], [InsuranceAdjustmentAmount],
        [PatientPaidAmount], [PatientAdjustmentAmount], [InsuranceBalance],
        [PatientBalance], [TotalBalance]
    )
    SELECT 
        CBD.AccessionNo, CBD.VisitNumber, CBD.CPTCode, CBD.LastBillDate, CBD.BilledAmount,
        CBD.AllowedAmount, CBD.InsurancePayments, CBD.InsuranceAdjustments,
        CBD.PatientPayments, CBD.PatientAdjustments, CBD.InsuranceBalance,
        CBD.PatientBalance, CBD.TotalBalance
    FROM #ClaimBillingDetail CBD
    WHERE NOT EXISTS (
        SELECT 1 FROM [dbo].[ClaimBillingDetails] CD
        WHERE CD.AccessionNo = CBD.AccessionNo 
          AND CD.VisitNumber = CBD.VisitNumber 
          AND CD.CPTCode = CBD.CPTCode
    );
END;
GO
/****** Object:  StoredProcedure [dbo].[sp_ClaimLevelStatusUpdate]******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE   PROC [dbo].[sp_ClaimLevelStatusUpdate]
AS
BEGIN
    SET NOCOUNT ON;
    SET XACT_ABORT ON; -- ensures uncommittable transactions are rolled back

    BEGIN TRY
        BEGIN TRAN;

        -- Clean up any existing temp tables
        DROP TABLE IF EXISTS #DenailTracker;
        DROP TABLE IF EXISTS #CptCodes;
        DROP TABLE IF EXISTS #BillingMaster;

        -- Billing Master aggregation
        SELECT 
            VisitNumber,
            MIN(FirstBillDate) AS FirstBillDate,
            SUM(BilledAmount) AS BilledAmount,
            SUM(AllowedAmount) AS AllowedAmount,
            SUM(InsurancePayment) AS InsurancePayment,
            SUM(InsuranceAdjustment) AS InsuranceAdjustment,
            SUM(PatientPaidAmount) AS PatientPaidAmount,
            SUM(PatientAdjustment) AS PatientAdjustment,
            SUM(InsuranceBalance) AS InsuranceBalance,
            SUM(PatientBalance) AS PatientBalance,
            SUM(TotalBalance) AS TotalBalance
        INTO #BillingMaster
        FROM BillingMaster
        GROUP BY VisitNumber;

        -- Denial Codes
        SELECT DISTINCT 
            VisitNumber,
            DBO.[GetDenailCodeByVisitNumber](VisitNumber) AS DenailCode
        INTO #DenailTracker
        FROM DenialTrackingMaster;

        -- Reset ClaimsLevelStatus
        TRUNCATE TABLE [ClaimsLevelStatus];

        -- CPT Codes
        SELECT DISTINCT 
            VisitNumber,
            DBO.GETCPTCodeCombined(VisitNumber) AS CPTCode
        INTO #CptCodes
        FROM BillingMaster;

        -- Insert processed claims status
        INSERT INTO [dbo].[ClaimsLevelStatus]
            ([VisitNumber],[CPTCodes],FirstBillDate,[BilledAmount],[AllowedAmount],[InsurancePayment],
             [InsuranceAdjustment],[PatientPaidAmount],[PatientAdjustment],[InsuranceBalance],
             [PatientBalance],[TotalBalance],[DenailCode],[FinalStatus],[CreatedOn])
        SELECT 
            BM.VisitNumber,
            CPTCode,
            FirstBillDate,
            BilledAmount,
            AllowedAmount,
            InsurancePayment,
            InsuranceAdjustment,
            PatientPaidAmount,
            PatientAdjustment,
            InsuranceBalance,
            PatientBalance,
            TotalBalance,
            DenailCode,
    CASE
-----------------Rule Id : 1
WHEN BilledAmount > 0 AND InsurancePayment = 0 AND PatientPaidAmount = 0 AND InsuranceAdjustment = 0 AND InsuranceBalance = 0 AND PatientBalance = 0 AND PatientAdjustment = BilledAmount THEN 'Fully Adjusted'
-----------------Rule Id : 2
WHEN BilledAmount > 0 AND InsurancePayment = 0 AND PatientPaidAmount = 0 AND InsuranceAdjustment = BilledAmount AND InsuranceBalance = 0 AND PatientBalance = 0 AND PatientAdjustment = 0 THEN 'Fully Adjusted'
-----------------Rule Id : 3
WHEN BilledAmount > 0 AND InsurancePayment = 0 AND PatientPaidAmount = 0 AND InsuranceAdjustment > 0 AND InsuranceBalance = 0 AND PatientBalance = 0 AND PatientAdjustment > 0 AND  DenailCode IS NULL THEN 'Fully Adjusted'
-----------------Rule Id : 4
WHEN BilledAmount > 0 AND InsurancePayment = 0 AND PatientPaidAmount = 0 AND InsuranceAdjustment = 0 AND InsuranceBalance = BilledAmount AND PatientBalance = 0 AND PatientAdjustment = 0  AND FirstBillDate IS NOT NULL AND DenailCode IS NOT NULL THEN 'Fully Denied'
-----------------Rule Id : 
--WHEN BilledAmount > 0 AND InsurancePayment = 0 AND PatientPaidAmount = 0 AND InsuranceAdjustment > 0 AND InsuranceBalance > 0 AND PatientBalance = 0 AND PatientAdjustment = 0 AND DenailCode IS NOT NULL THEN 'Fully Denied'
-----------------Rule Id : 5
WHEN BilledAmount > 0 AND InsurancePayment = BilledAmount AND PatientPaidAmount = 0 AND InsuranceAdjustment = 0 AND InsuranceBalance = 0 AND PatientBalance = 0 AND PatientAdjustment = 0 AND CPTCode NOT LIKE '%99999%'  THEN 'Fully Paid'
-----------------Rule Id : 6
WHEN BilledAmount > 0 AND InsurancePayment > 0 AND PatientPaidAmount = 0 AND InsuranceAdjustment = 0 AND InsuranceBalance = 0 AND PatientBalance = 0 AND PatientAdjustment > 0 THEN 'Fully Paid'
-----------------Rule Id : 7
WHEN BilledAmount > 0 AND InsurancePayment > 0 AND PatientPaidAmount = 0 AND InsuranceAdjustment > 0 AND InsuranceBalance = 0 AND PatientBalance = 0 AND PatientAdjustment = 0 THEN 'Fully Paid'
-----------------Rule Id : 8
WHEN BilledAmount > 0 AND InsurancePayment > 0 AND PatientPaidAmount = 0 AND InsuranceAdjustment > 0 AND InsuranceBalance = 0 AND PatientBalance = 0 AND PatientAdjustment > 0 THEN 'Fully Paid'
-----------------Rule Id : 9
WHEN BilledAmount > 0 AND InsurancePayment > 0 AND PatientPaidAmount = 0 AND InsuranceAdjustment = 0 AND InsuranceBalance = 0 AND PatientBalance> 0 AND PatientAdjustment = 0 THEN 'Partially Paid'
-----------------Rule Id : 10
WHEN BilledAmount > 0 AND InsurancePayment > 0 AND PatientPaidAmount = 0 AND InsuranceAdjustment > 0 AND InsuranceBalance = 0 AND PatientBalance > 0 AND PatientAdjustment = 0 THEN 'Partially Paid'
-----------------Rule Id : 11
WHEN BilledAmount > 0 AND InsurancePayment > 0 AND PatientPaidAmount = 0 AND InsuranceAdjustment > 0 AND InsuranceBalance = 0 AND PatientBalance > 0 AND PatientAdjustment > 0 THEN 'Fully Paid'
-----------------Rule Id : 12
WHEN BilledAmount > 0 AND InsurancePayment = 0 AND PatientPaidAmount = 0 AND InsuranceAdjustment = 0 AND InsuranceBalance = BilledAmount AND PatientBalance = 0 AND PatientAdjustment = 0  AND FirstBillDate IS NOT NULL AND CPTCode NOT LIKE '%99999%' THEN 'No Response'
-----------------Rule Id : 13
WHEN BilledAmount > 0 AND InsurancePayment = 0 AND PatientPaidAmount = 0 AND InsuranceAdjustment = 0 AND InsuranceBalance = BilledAmount AND PatientBalance = 0 AND PatientAdjustment = 0 AND DenailCode IS NULL AND CPTCode LIKE '%99999%' AND FirstBillDate IS NOT NULL THEN 'No Response - Client'
-----------------Rule Id : 14
WHEN BilledAmount > 0 AND InsurancePayment = BilledAmount AND PatientPaidAmount = 0 AND InsuranceAdjustment = 0 AND InsuranceBalance = 0 AND PatientBalance = 0 AND PatientAdjustment = 0 AND CPTCode LIKE '%99999%'  THEN 'Paid To Client'
-----------------Rule Id : 15
WHEN BilledAmount > 0 AND InsurancePayment = 0 AND PatientPaidAmount = 0 AND InsuranceAdjustment > 0 AND InsuranceBalance > 0 AND PatientBalance > 0 AND PatientAdjustment = 0 AND DenailCode IS NULL THEN 'Patient Responsibility'
-----------------Rule Id : 16
WHEN BilledAmount > 0 AND InsurancePayment = 0 AND PatientPaidAmount = 0 AND InsuranceAdjustment = 0 AND InsuranceBalance > 0 AND PatientBalance > 0 AND PatientAdjustment = 0 AND DenailCode IS NOT NULL THEN 'Partially Denied'
-----------------Rule Id : 17
WHEN BilledAmount > 0 AND InsurancePayment = 0 AND PatientPaidAmount = 0 AND InsuranceAdjustment > 0 AND InsuranceBalance > 0 AND PatientBalance > 0 AND PatientAdjustment = 0 AND DenailCode IS NOT NULL THEN 'Partially Denied'
-----------------Rule Id : 18
WHEN BilledAmount > 0 AND InsurancePayment = 0 AND PatientPaidAmount = 0 AND InsuranceAdjustment > 0 AND InsuranceBalance > 0 AND PatientBalance > 0 AND PatientAdjustment > 0 AND DenailCode IS NOT NULL THEN 'Partially Denied'
-----------------Rule Id : 19
WHEN BilledAmount > 0 AND InsurancePayment = 0 AND PatientPaidAmount = 0 AND InsuranceAdjustment > 0 AND InsuranceBalance > 0 AND PatientBalance = 0 AND PatientAdjustment > 0 AND DenailCode IS NOT NULL THEN 'Partially Denied'
-----------------Rule Id : 20
WHEN BilledAmount > 0 AND InsurancePayment > 0 AND PatientPaidAmount = 0 AND InsuranceAdjustment = 0 AND InsuranceBalance > 0 AND PatientBalance = 0 AND PatientAdjustment = 0 THEN 'Partially Paid'
-----------------Rule Id : 21
WHEN BilledAmount > 0 AND InsurancePayment > 0 AND PatientPaidAmount = 0 AND InsuranceAdjustment = 0 AND InsuranceBalance > 0 AND PatientBalance > 0 AND PatientAdjustment = 0 THEN 'Partially Paid'
-----------------Rule Id : 22
WHEN BilledAmount > 0 AND InsurancePayment > 0 AND PatientPaidAmount = 0 AND InsuranceAdjustment > 0 AND InsuranceBalance > 0 AND PatientBalance = 0 AND PatientAdjustment = 0 THEN 'Partially Paid'
-----------------Rule Id : 23
WHEN BilledAmount > 0 AND InsurancePayment > 0 AND PatientPaidAmount = 0 AND InsuranceAdjustment > 0 AND InsuranceBalance > 0 AND PatientBalance > 0 AND PatientAdjustment = 0 THEN 'Partially Paid'
-----------------Rule Id : 24
WHEN BilledAmount > 0 AND InsurancePayment = 0 AND PatientPaidAmount > 0 AND InsuranceAdjustment > 0 AND InsuranceBalance = 0 AND PatientBalance = 0 AND PatientAdjustment = 0 THEN 'Patient Payment'
-----------------Rule Id : 25
WHEN BilledAmount > 0 AND InsurancePayment = 0 AND PatientPaidAmount = BilledAmount AND InsuranceAdjustment = 0 AND InsuranceBalance = 0 AND PatientBalance = 0 AND PatientAdjustment = 0 THEN 'Patient Payment'
-----------------Rule Id : 26
WHEN BilledAmount > 0 AND InsurancePayment = 0 AND PatientPaidAmount = 0 AND InsuranceAdjustment = 0 AND InsuranceBalance = 0 AND PatientBalance = BilledAmount AND PatientAdjustment = 0 AND CPTCode NOT LIKE '%99999%' THEN 'Patient Responsibility'
-----------------Rule Id : 27
WHEN BilledAmount > 0 AND InsurancePayment = 0 AND PatientPaidAmount = 0 AND InsuranceAdjustment = 0 AND InsuranceBalance = 0 AND PatientBalance > 0 AND PatientAdjustment > 0 THEN 'Patient Responsibility'
-----------------Rule Id : 28
WHEN BilledAmount > 0 AND InsurancePayment = 0 AND PatientPaidAmount = 0 AND InsuranceAdjustment > 0 AND InsuranceBalance = 0 AND PatientBalance > 0 AND PatientAdjustment = 0 THEN 'Patient Responsibility'
-----------------Rule Id : 29
WHEN BilledAmount > 0 AND InsurancePayment = 0 AND PatientPaidAmount = 0 AND InsuranceAdjustment > 0 AND InsuranceBalance = 0 AND PatientBalance > 0 AND PatientAdjustment > 0 THEN 'Patient Responsibility'
-----------------Rule Id : 30
WHEN BilledAmount > 0 AND InsurancePayment = 0 AND PatientPaidAmount = 0 AND InsuranceAdjustment = 0 AND InsuranceBalance = 0 AND PatientBalance = BilledAmount AND PatientAdjustment = 0  AND CPTCode LIKE '%99999%' THEN 'Patient Responsibility - Client'
-----------------Rule Id : 31
WHEN BilledAmount > 0 AND InsurancePayment = 0 AND PatientPaidAmount = 0 AND InsuranceAdjustment = 0 AND InsuranceBalance = BilledAmount AND PatientBalance = 0 AND PatientAdjustment = 0 AND FirstBillDate IS NULL AND CPTCode NOT LIKE '%99999%'  THEN 'Unbilled'
-----------------Rule Id : 32
WHEN BilledAmount > 0 AND InsurancePayment = 0 AND PatientPaidAmount = 0 AND InsuranceAdjustment = 0 AND InsuranceBalance = BilledAmount AND PatientBalance = 0 AND PatientAdjustment = 0 AND FirstBillDate IS NULL  AND CPTCode LIKE '%99999%' THEN 'Unbilled - Client'
-----------------Rule Id : 33
WHEN BilledAmount > 0 AND InsurancePayment = 0 AND PatientPaidAmount = 0 AND InsuranceAdjustment > 0 AND InsuranceBalance > 0 AND PatientBalance = 0 AND PatientAdjustment = 0 AND DenailCode IS NOT NULL THEN 'Partially Denied'
-----------------Rule Id : 34
WHEN BilledAmount > 0 AND InsurancePayment = 0 AND PatientPaidAmount = 0 AND InsuranceAdjustment = 0 AND InsuranceBalance > 0 AND PatientBalance > 0 AND PatientAdjustment > 0 AND DenailCode IS NOT NULL THEN 'Partially Denied'
-----------------Rule Id : 35
WHEN BilledAmount > 0 AND InsurancePayment = 0 AND PatientPaidAmount = 0 AND InsuranceAdjustment = 0 AND InsuranceBalance > 0 AND PatientBalance = 0 AND PatientAdjustment > 0 AND DenailCode IS NOT NULL THEN 'Partially Denied'
-----------------Rule Id : 36
WHEN BilledAmount > 0 AND InsurancePayment > 0 AND PatientPaidAmount > 0 AND InsuranceAdjustment = 0 AND InsuranceBalance > 0 AND PatientBalance = 0 AND PatientAdjustment = 0 THEN 'Partially Paid'
-----------------Rule Id : 37
WHEN BilledAmount > 0 AND InsurancePayment > 0 AND PatientPaidAmount > 0 AND InsuranceAdjustment > 0 AND InsuranceBalance > 0 AND PatientBalance = 0 AND PatientAdjustment = 0 THEN 'Partially Paid'
-----------------Rule Id : 38
WHEN BilledAmount > 0 AND InsurancePayment > 0 AND PatientPaidAmount > 0 AND InsuranceAdjustment > 0 AND InsuranceBalance > 0 AND PatientBalance = 0 AND PatientAdjustment > 0 THEN 'Partially Paid'
-----------------Rule Id : 39
WHEN BilledAmount > 0 AND InsurancePayment = 0 AND PatientPaidAmount = 0 AND InsuranceAdjustment > 0 AND InsuranceBalance > 0 AND PatientBalance = 0 AND PatientAdjustment = 0 AND TotalBalance > 0 AND (InsuranceAdjustment + PatientAdjustment) > 0 THEN 'Partially Adjusted'

ELSE 'Un Categorized' END ClaimStatus,
            GETDATE()
        FROM #BillingMaster BM
        LEFT JOIN #DenailTracker DT ON BM.VisitNumber = DT.VisitNumber
        LEFT JOIN #CptCodes CPT ON BM.VisitNumber = CPT.VisitNumber;

        COMMIT TRAN;
    END TRY
    BEGIN CATCH
        IF @@TRANCOUNT > 0
            ROLLBACK TRAN;

        -- Optional: log error info
        DECLARE 
            @ErrMsg NVARCHAR(4000),
            @ErrSeverity INT,
            @ErrState INT;

        SELECT 
            @ErrMsg = ERROR_MESSAGE(),
            @ErrSeverity = ERROR_SEVERITY(),
            @ErrState = ERROR_STATE();

        RAISERROR(@ErrMsg, @ErrSeverity, @ErrState);
    END CATCH
END;
GO
/****** Object:  StoredProcedure [dbo].[sp_GetCollectionLineLevelReport]******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[sp_GetCollectionLineLevelReport]
    @FromDate Date = NULL,
    @ToDate Date = NULL
AS
BEGIN
  SET NOCOUNT ON;
DROP TABLE IF EXISTS #DenialCodeMaster;
SELECT 
    VisitNumber,CPTCodes,DBO.[GetDenailCodeByVisitCPT](VisitNumber,CPTCodes) AS PaymentReasonCodes,MAX(PaymentDate) AS MostRecentDenialPostingDate
	INTO #DenialCodeMaster
FROM DenialTrackingMaster
WHERE PaymentReasonCode IS NOT NULL
GROUP BY VisitNumber,CPTCodes ORDER BY VisitNumber

CREATE NONCLUSTERED INDEX IX_VisitNumber ON #DenialCodeMaster (VisitNumber,CPTCodes);

    SELECT DISTINCT 
        ISNULL(UPPER(b.AccessionNo),'Missing LIS Info') AccessionNo,
        b.VisitNumber,
        b.CPTCode,
        b.PatientName,
		CAST(CheckDate AS DATE) AS  PatientDOB, 
        PayerName,
        PayerType,
        BillingProvider,
		CAST(BeginDOS AS DATE) AS   BeginDOS,
		CAST(EndDOS AS DATE) AS  EndDOS,
		CAST(b.ChargeEntryDate AS DATE) AS	   ChargeEntryDate,
		CAST(FirstBillDate AS DATE) AS     FirstBillDate,
		ISNULL(pg.PanelName,'Missing LIS Info') PanelName,
		ISNULL(l.OrderInfo,'Missing LIS Info') OrderInfo,
        b.ICD10Code,
        b.Units,
		CAST(CheckDate AS DATE) AS     CheckDate,
		CAST(PaymentPostedDate AS DATE) AS   PaymentPostedDate,
		CAST(dt.MostRecentDenialPostingDate AS DATE) AS    DenialPostedDate,
        b.CheckNumber,
        b.Modifier,
        PaymentReasonCodes as DenialCode,
        ISNULL(BilledAmount,0.0) TotalCharge,
        ISNULL(AllowedAmount,0.0) AS TotalAllowed,
        ISNULL(InsurancePayment,0.0) AS CarrierPayment,
        CAST(ROUND(CASE WHEN BilledAmount > 0 THEN InsurancePayment * 100.0 / BilledAmount ELSE 0 END, 1) AS DECIMAL(8,2)) AS PaymentPercentage,
        ISNULL(InsuranceAdjustment,0.0) AS CarrierWO,
        ISNULL(PatientPaidAmount,0.0) PatientPaidAmount,
        ISNULL(PatientAdjustment,0.0) AS PatientWO,
        ISNULL(InsuranceBalance,0.0) AS CarrierBalance,
        ISNULL(PatientBalance,0.0) PatientBalance,
        ISNULL(b.TotalBalance,0.0) TotalBalance,
        (InsurancePayment + PatientPaidAmount) AS FullyPaid,
        b.FinalClaimStatus,
		Lab.LabName,
		cm.ClinicName,
		og.OperationsGroup,
		tt.TestTypeName TestType,
		rp.ReferringProviderName,
		b.ClaimSubStatus,
		CASE WHEN b.AccessionNo is null then 'Missing LIS Data' else '' end LISMissingRecord 
FROM BillingMaster b
LEFT JOIN LISMaster l ON b.LISMasterId = l.LISMasterId
LEFT JOIN InsurancePayerMaster i ON b.PrimaryPayerID = i.InsurancePayerId
LEFT JOIN PayerTypeMaster p ON b.PayerTypeId = p.PayerTypeId
LEFT JOIN BillingProviderMaster bp ON b.BillingProviderID = bp.BillingProviderID
LEFT JOIN #DenialCodeMaster dt ON b.VisitNumber = dt.VisitNumber AND b.CPTCode = dt.CPTCodes
LEFT JOIN PanelGroup pg ON l.OrderInfo = pg.OrderInfo 

LEFT JOIN LabMaster LAB ON l.LabId = LAB.LabID
LEFT JOIN ClinicMaster CM ON l.ClinicId = CM.ClinicId
LEFT JOIN OperationsGroupMaster OG ON l.OperationalGroupId = OG.OperationGroupID 
LEFT JOIN TestTypeMaster TT ON l.TestTypeId = TT.TestTypeId
LEFT JOIN ReferringProviderMaster RP ON b.ReferringProviderId = RP.ReferingProviderId

    WHERE 
        (@FromDate IS NULL OR TRY_CONVERT(date, b.PaymentPostedDate) >= @FromDate)
        AND
        (@ToDate IS NULL OR TRY_CONVERT(date, b.PaymentPostedDate) <= @ToDate)
    ORDER BY AccessionNo
END
GO
/****** Object:  StoredProcedure [dbo].[sp_GetCollectionReport]******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[sp_GetCollectionReport] 
    @FromDate DATE = NULL,
    @ToDate DATE = NULL
AS
BEGIN
    SET NOCOUNT ON;

    -- Step 1: Filtered BillingMaster load into temp table (single scan)
		SELECT * INTO #BillingMasterTemp FROM BillingMaster WITH (NOLOCK)
		WHERE (@FromDate IS NULL OR PaymentPostedDate >= @FromDate) AND (@ToDate IS NULL OR PaymentPostedDate <= @ToDate) 
		--AND FinalClaimStatus in ('Paid','Adjusted','Denied');
	 
		DROP TABLE IF EXISTS #DenialCode

		SELECT DISTINCT VisitNumber,DBO.GetDenailCodeByVisitNumber(VisitNumber) DenialCode INTO #DenialCode FROM DenialTrackingMaster
		WHERE PaymentReasonCode IS NOT  NULL

		CREATE NONCLUSTERED INDEX IX_VisitNumber ON #DenialCode (VisitNumber);

		SELECT bm.VisitNumber, bm.CheckNumber, bm.PaymentPostedDate, bm.CheckDate into #TransactionDetail
			FROM #BillingMasterTemp bm
			INNER JOIN (
				SELECT VisitNumber,
					   MAX(PaymentPostedDate) AS MaxPostedDate
				FROM #BillingMasterTemp
				WHERE CheckNumber IS NOT NULL
				GROUP BY VisitNumber
			) latestPosted ON bm.VisitNumber = latestPosted.VisitNumber
						  AND bm.PaymentPostedDate = latestPosted.MaxPostedDate
			WHERE bm.CheckDate = (
				SELECT MAX(CheckDate)
				FROM #BillingMasterTemp
				WHERE VisitNumber = bm.VisitNumber
				  AND PaymentPostedDate = bm.PaymentPostedDate
			)
			GROUP BY bm.VisitNumber, bm.CheckNumber, bm.PaymentPostedDate, bm.CheckDate

    -- Step 2: Aggregations
    ;WITH BillingAgg AS (
        SELECT 
            VisitNumber,
            SUM(BilledAmount) AS TotalCharge,
            SUM(AllowedAmount) AS AllowedAmount,
            SUM(InsurancePayment) AS InsurancePayment,
            SUM(InsuranceAdjustment) AS InsuranceAdjustment,
            SUM(PatientPaidAmount) AS PatientPaidAmount,
            SUM(PatientAdjustment) AS PatientAdjustment,
            SUM(InsuranceBalance) AS InsuranceBalance,
            SUM(PatientBalance) AS PatientBalance,
            SUM(TotalBalance) AS TotalBalance
        FROM #BillingMasterTemp
        GROUP BY VisitNumber
    ),
    MostFrequentFinancialClass AS (
        SELECT VisitNumber, PT.PayerType,
               ROW_NUMBER() OVER (PARTITION BY VisitNumber ORDER BY COUNT(*) DESC) AS rn
        FROM #BillingMasterTemp BM
        JOIN PayerTypeMaster PT WITH (NOLOCK) ON BM.PayerTypeId = PT.PayerTypeId
        GROUP BY VisitNumber, PT.PayerType
    ),
    MostFrequentPOS AS (
        SELECT VisitNumber, POS,
               ROW_NUMBER() OVER (PARTITION BY VisitNumber ORDER BY COUNT(*) DESC) AS rn
        FROM #BillingMasterTemp
        WHERE POS IS NOT NULL
        GROUP BY VisitNumber, POS
    ),
    MostFrequentTOS AS (
        SELECT VisitNumber, TOS,
               ROW_NUMBER() OVER (PARTITION BY VisitNumber ORDER BY COUNT(*) DESC) AS rn
        FROM #BillingMasterTemp
        WHERE TOS IS NOT NULL
        GROUP BY VisitNumber, TOS
    ),
    EarliestCharge AS (
        SELECT VisitNumber, MIN(ChargeEntryDate) AS ChargeEntryDate
        FROM #BillingMasterTemp
        GROUP BY VisitNumber
    ),
    GroupedCPT AS (
        SELECT bm.VisitNumber, bm.CPTCode, SUM(bm.Units) AS Units
        FROM #BillingMasterTemp bm
        GROUP BY bm.VisitNumber, bm.CPTCode
    ),
    AggregatedCPT AS (
        SELECT VisitNumber,
               STRING_AGG(CAST(CPTCode AS VARCHAR(20)) + 
                 (CASE WHEN ISNULL(Units,0) = 0 THEN '' ELSE '* ' + CAST(ISNULL(Units,0) AS VARCHAR(10)) END), ', ') AS CPTCode
        FROM GroupedCPT
        GROUP BY VisitNumber
    ), 

    MainData AS (
        SELECT 
            BM.VisitNumber,
            BM.PrimaryPayerID,
            BM.PayerTypeId,
            BM.BillingProviderID,
            BM.BeginDOS,
            BM.FirstBillDate,
            BM.ChargeEntryDate,
            BM.TOS,
            BM.ICD10Code,
            LIS.LISMasterId,
            LIS.AccessionNo,
            BM.PatientName,
			bm.ChartNumber,
				TT.TestTypeName TestType,
			CM.ClinicName,
			PG.PanelCategory,
            ISNULL(LIS.ReferringProviderId,0) ReferringProviderId,
            PG.PanelName,
			ISNULL(LIS.LabId,0) LabId,
			ISNULL(LIS.PanelId,0) PanelId,
            ROW_NUMBER() OVER (PARTITION BY BM.VisitNumber ORDER BY BM.FirstBillDate DESC) AS rn
        FROM #BillingMasterTemp BM
        LEFT JOIN LISMaster LIS WITH (NOLOCK) ON BM.LISMasterId = LIS.LISMasterId
        LEFT JOIN PanelGroup PG WITH (NOLOCK) ON LIS.PanelId = PG.PanelGroupId
				LEFT JOIN TestTypeMaster TT ON LIS.TestTypeId = TT.TestTypeId
		LEFT JOIN ClinicMaster CM ON LIS.ClinicId = CM.ClinicId
    )

    SELECT DISTINCT
		md.VisitNumber VisitNumber,
       ISNULL(md.AccessionNo,'Missing LIS Data') AccessionNo,
        ISNULL(PG.PanelName,'Missing LIS Data') PanelName,
        ISNULL(IPM.PayerName,'Missing Payer Info') AS Carrier,
        FC.PayerType AS FinancialClass,
		BP.BillingProvider BillingProvider,
        RF.ReferringProviderName ReferringProviderName,
        md.ChartNumber ChartNumber,
        md.PatientName PatientName,
		LM.LabName Facility,
			md.TestType,
		md.ClinicName,
		md.PanelCategory PanelGroup,
        CAST(md.BeginDOS AS DATE) AS BeginDOS,
        DATEDIFF(DAY, md.FirstBillDate, td.PaymentPostedDate) AS Aging,
        CASE 
            WHEN DATEDIFF(DAY, md.FirstBillDate, td.PaymentPostedDate) <= 30 THEN 'Current'
            WHEN DATEDIFF(DAY, md.FirstBillDate, td.PaymentPostedDate) BETWEEN 31 AND 60 THEN '30 +'
            WHEN DATEDIFF(DAY, md.FirstBillDate, td.PaymentPostedDate) BETWEEN 61 AND 90 THEN '60 +'
            WHEN DATEDIFF(DAY, md.FirstBillDate, td.PaymentPostedDate) BETWEEN 91 AND 120 THEN '90 +'
            ELSE '120 +'
        END AS AgingBucket,
        CAST(EC.ChargeEntryDate AS DATE) AS [AMDDOE],
        CAST(md.FirstBillDate AS DATE) AS FirstBillDate,
        CAST(EC.ChargeEntryDate AS DATE) AS ChargeEntryDate,
		CheckNumber,
		CAST(td.CheckDate AS DATE) AS CheckDate,
		CAST(td.PaymentPostedDate AS DATE) AS PaymentPostedDate,
        CASE 
            WHEN md.FirstBillDate IS NOT NULL THEN 'Billed'
            ELSE 'Not Billed'
        END AS [BilledNotBilled],
        POS.POS AS POS,
        TOS.TOS TOS,	
        AG.CPTCode CPTCode,
        md.ICD10Code AS PrimaryDiagnosis,
        DenialCode ,
        ISNULL(BA.TotalCharge,0.0) TotalCharge,
        ISNULL(BA.AllowedAmount,0.0) AS TotalAllowed,
        ISNULL(BA.InsurancePayment,0.0) AS CarrierPayment,
        CAST(ROUND(CASE WHEN BA.TotalCharge > 0 THEN BA.InsurancePayment * 100.0 / BA.TotalCharge ELSE 0 END, 1) AS DECIMAL(8,2)) AS PaymentPercentage,
        ISNULL(BA.InsuranceAdjustment,0.0) AS CarrierWO,
        ISNULL(BA.PatientPaidAmount,0.0) PatientPaidAmount,
        ISNULL(BA.PatientAdjustment,0.0) AS PatientWO,
        ISNULL(BA.InsuranceBalance,0.0) AS CarrierBalance,
        ISNULL(BA.PatientBalance,0.0) PatientBalance,
        ISNULL(BA.TotalBalance,0.0) TotalBalance,
        (BA.InsurancePayment + BA.PatientPaidAmount) AS FullyPaid,
        CASE 
            WHEN CPS.FinalStatus = 'Fully Paid' THEN 'Fully Paid Count' 
            ELSE NULL 
        END AS [FullyPaidCount],
        CASE 
            WHEN DATEDIFF(DAY, md.FirstBillDate, td.PaymentPostedDate) <= 30 THEN '30 Days Count' 
            ELSE NULL 
        END AS [T30DaysCount],
        CASE 
            WHEN DATEDIFF(DAY, md.FirstBillDate, td.PaymentPostedDate) <= 30 THEN (BA.InsurancePayment + BA.PatientPaidAmount) 
            ELSE NULL 
        END AS [T30Amount],
        CASE 
            WHEN DATEDIFF(DAY,md.FirstBillDate, td.PaymentPostedDate) BETWEEN 31 AND 60 THEN '60 Days Count' 
            ELSE NULL 
        END AS [T60DaysCount],
        CASE 
            WHEN DATEDIFF(DAY,md.FirstBillDate, td.PaymentPostedDate) BETWEEN 31 AND 60 THEN (BA.InsurancePayment + BA.PatientPaidAmount) 
            ELSE NULL 
        END AS [T60Amount],
		   -- Conditionally return AdjudicatedAmount
		CASE 
			WHEN CPS.FinalStatus IN ('No Response') THEN NULL
			WHEN CPS.FinalStatus = 'Fully Adjusted' AND DC.DenialCode IS NULL THEN NULL
			ELSE (BA.InsuranceAdjustment + BA.PatientAdjustment)
		END AS AdjudicatedAmount,

		-- Conditionally return AdjudicatedCount
		CASE 
			WHEN CPS.FinalStatus IN ('No Response') THEN NULL
			WHEN CPS.FinalStatus = 'Fully Adjusted' AND DC.DenialCode IS NULL THEN NULL
			ELSE 'Adjudicated Count' END
			 AdjudicatedCount,
       CPS.FinalStatus
    FROM MainData md
    JOIN InsurancePayerMaster IPM WITH (NOLOCK) ON md.PrimaryPayerID = IPM.InsurancePayerId
    JOIN BillingProviderMaster BP WITH (NOLOCK) ON md.BillingProviderID = BP.BillingProviderID
    JOIN ReferringProviderMaster RF WITH (NOLOCK) ON md.ReferringProviderId = RF.ReferingProviderId
	LEFT JOIN LabMaster LM WITH (NOLOCK) ON md.LabId = LM.LabID
    LEFT JOIN PanelGroup PG WITH (NOLOCK) ON md.PanelId = PG.PanelGroupId
    LEFT JOIN MostFrequentFinancialClass FC ON md.VisitNumber = FC.VisitNumber AND FC.rn = 1
    LEFT JOIN MostFrequentPOS POS ON md.VisitNumber = POS.VisitNumber AND POS.rn = 1
    LEFT JOIN MostFrequentTOS TOS ON md.VisitNumber = TOS.VisitNumber AND TOS.rn = 1
    LEFT JOIN EarliestCharge EC ON md.VisitNumber = EC.VisitNumber
    LEFT JOIN BillingAgg BA ON md.VisitNumber = BA.VisitNumber
    LEFT JOIN AggregatedCPT AG ON md.VisitNumber = AG.VisitNumber
    LEFT JOIN ClaimsLevelStatus CPS ON md.VisitNumber = CPS.VisitNumber
	LEFT JOIN #DenialCode DC ON md.VisitNumber = DC.VisitNumber
	LEFT JOIN #TransactionDetail td on md.VisitNumber = td.VisitNumber
    WHERE md.rn = 1

    DROP TABLE IF EXISTS #BillingMasterTemp;
END
GO
/****** Object:  StoredProcedure [dbo].[sp_GetLISMasterReportByDateRange]******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[sp_GetLISMasterReportByDateRange]
    @StartDate DATE = NULL,
    @EndDate DATE = NULL
AS
BEGIN
    SET NOCOUNT ON;

    -- Determine actual date range using ISNULL
    DECLARE @ActualStartDate DATE;
    DECLARE @ActualEndDate DATE;

    SELECT
        @ActualStartDate = ISNULL(@StartDate, MIN(SampleCollectedDate)),
        @ActualEndDate = ISNULL(@EndDate, MAX(SampleCollectedDate))
    FROM LISMaster;

    -- Main query with date filtering
    SELECT DISTINCT
        AccessionNo,
        --LAB.LabName,
        --BP.BillingProvider,
        PatientName,
        --PatientID,
        --CAST(PatientDOB AS DATE) AS PatientDOB,
        [PrimaryPayerName],
        --PT.PayerType,
        PrimaryMemberId,
        --PrimaryGroupNo,
        --CAST(PrimaryEffectiveDate AS DATE) AS PrimaryEffectiveDate,
        --RelationshipToInsurance,
        --SecondaryPayerId,
        --SecondaryMemberID,
        --SecondaryGroupNo,
        --SecondaryEffectiveDate,
		CONVERT(VARCHAR, SampleCollectedDate, 101)   SampleCollectedDate,
		CONVERT(VARCHAR, SampleReceivedDate, 101) AS SampleReceivedDate,
		CONVERT(VARCHAR, SampleAccessionedDate, 101) AS SampleAccessionedDate,
		CONVERT(VARCHAR, SampleResultedDate, 101)   AS SampleResultedDate,
		CONVERT(VARCHAR, SampleRunDate, 101)  AS SampleRunDate,
        SS.SpecimenStatusName,
        BilledTo,
        --RP.ReferringProviderName,
        LIS.SpecimenType,
        CM.ClinicName,
        sp.SalesPersonName,
        OG.OperationsGroup,
        --ICD10Code,
        --DBO.GETCPTCodesByAccessionNo(LIS.AccessionNo) AS CPTCodes,
        TestCode,
        TT.TestTypeName,
		pg.PanelCategory PanelGroup,
        Sendouts,
        TurnAround,
        OutStanding,
        ISNULL(lis.OrderInfo,LIS.Tests) OrderInfo,
        PG.PanelName,
        PanelCode,
        ResultedStatus,
        CASE WHEN DaystoReceive = 0 THEN 1 ELSE DaystoReceive END DaystoReceive ,
        CASE WHEN DaystoResult = 0 THEN 1 ELSE DaystoResult END DaystoResult  ,
        CASE WHEN DaystoBill = 0 THEN 1 ELSE DaystoBill END DaystoBill ,
        ClientStatus,
        VisitNumber,
       CASE 
		WHEN ResultedStatus = 'Resulted' AND BillingStatus = 'Not Billed' 
        AND BillingSubStatus = 'Resulted Yet to Billed' AND ISNULL(ClientStatus,'') <> '' 
		THEN ClientStatus  ELSE BillingSubStatus END AS BillingSubStatus,
        LIS.BillingStatus,
		CONVERT(VARCHAR, LIS.[FirstBilledDate], 101) [FirstBilledDate],
		CONVERT(VARCHAR, LIS.ChargeEntryDate, 101) ChargeEntryDate,
        SelfPay,
        AccountPay,
        ContractPay,
        Analtyics,
        ScrubSettings,
        Actions,
		LISFile
    FROM LISMaster LIS
    LEFT JOIN LabMaster LAB ON LIS.LabId = LAB.LabID
    LEFT JOIN BillingProviderMaster BP ON LIS.BillingProviderID = BP.BillingProviderID 
    LEFT JOIN SpecimenStatus SS ON LIS.SampleStatusId = SS.SpecimenStatusId 
    LEFT JOIN ClinicMaster CM ON LIS.ClinicId = CM.ClinicId
    LEFT JOIN OperationsGroupMaster OG ON LIS.OperationalGroupId = OG.OperationGroupID 
    LEFT JOIN TestTypeMaster TT ON LIS.TestTypeId = TT.TestTypeId
    LEFT JOIN PanelGroup PG ON LIS.PanelId = PG.PanelGroupId
    LEFT JOIN ReferringProviderMaster RP ON LIS.ReferringProviderId = RP.ReferingProviderId
    LEFT JOIN PayerTypeMaster PT ON LIS.PayerTypeId = PT.PayerTypeId
	LEFT JOIN SalesPerson SP ON LIS.SalesPersonId = SP.SalesPersonID
    WHERE 
        CAST(SampleCollectedDate AS DATE) BETWEEN @ActualStartDate AND @ActualEndDate;
END;
GO
/****** Object:  StoredProcedure [dbo].[sp_GetProductionLineLevelReport]******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[sp_GetProductionLineLevelReport]
    @FromDate Date = NULL,
    @ToDate Date = NULL
AS
BEGIN

  SET NOCOUNT ON;

DROP TABLE IF EXISTS #DenialCodeMaster;
SELECT 
    VisitNumber,CPTCodes,DBO.[GetDenailCodeByVisitCPT](VisitNumber,CPTCodes) AS PaymentReasonCodes,MAX(PaymentDate) AS MostRecentDenialPostingDate
	INTO #DenialCodeMaster
FROM DenialTrackingMaster
WHERE PaymentReasonCode IS NOT NULL
GROUP BY VisitNumber,CPTCodes ORDER BY VisitNumber

CREATE NONCLUSTERED INDEX IX_VisitNumber ON #DenialCodeMaster (VisitNumber,CPTCodes);
SELECT DISTINCT 
    ISNULL(UPPER(b.AccessionNo),'Missing LIS Info') AccessionNo,
    b.VisitNumber,
    b.CPTCode,
    b.PatientName,
	b.PatientID,
	CONVERT(VARCHAR, CAST(PatientDOB AS DATE), 101)  PatientDOB, 
    PayerName,
    PayerType,
    BillingProvider,
	CONVERT(VARCHAR, BeginDOS, 101)   BeginDOS,
	CONVERT(VARCHAR, EndDOS, 101)    EndDOS,
	CONVERT(VARCHAR, b.ChargeEntryDate, 101)	   ChargeEntryDate,
	CONVERT(VARCHAR, FirstBillDate, 101)        FirstBillDate,
    ISNULL(pg.PanelName,'Missing LIS Info') PanelName,
    ISNULL(l.OrderInfo,'Missing LIS Info') OrderInfo,
    b.ICD10Code,
    b.Units,
	CONVERT(VARCHAR, CheckDate, 101)	     CheckDate,
	CONVERT(VARCHAR, PaymentPostedDate, 101)	   PaymentPostedDate,
	CONVERT(VARCHAR, dt.MostRecentDenialPostingDate, 101)	DenialPostedDate,
    b.CheckNumber,
    b.Modifier,
    PaymentReasonCodes as DenialCode,
    b.BilledAmount,
    b.AllowedAmount,
    b.InsurancePayment,
    b.InsuranceAdjustment,
    b.PatientPaidAmount,
    b.PatientAdjustment,
    b.InsuranceBalance,
    b.PatientBalance,
    b.TotalBalance,
    b.FinalClaimStatus,
	Lab.LabName,
	cm.ClinicName,
	og.OperationsGroup,
	tt.TestTypeName TestType,
	rp.ReferringProviderName,
	pg.PanelCategory PanelGroup,
	CASE WHEN b.AccessionNo is null then 'Missing LIS Data' else '' end LISMissingRecord,
	b.ClaimSubStatus
FROM BillingMaster b
LEFT JOIN LISMaster l ON b.LISMasterId = l.LISMasterId
LEFT JOIN InsurancePayerMaster i ON b.PrimaryPayerID = i.InsurancePayerId
LEFT JOIN PayerTypeMaster p ON b.PayerTypeId = p.PayerTypeId
LEFT JOIN BillingProviderMaster bp ON b.BillingProviderID = bp.BillingProviderID
LEFT JOIN #DenialCodeMaster dt ON b.VisitNumber = dt.VisitNumber AND b.CPTCode = dt.CPTCodes
LEFT JOIN PanelGroup pg ON l.OrderInfo = pg.OrderInfo 

LEFT JOIN LabMaster LAB ON l.LabId = LAB.LabID
LEFT JOIN ClinicMaster CM ON l.ClinicId = CM.ClinicId
LEFT JOIN OperationsGroupMaster OG ON l.OperationalGroupId = OG.OperationGroupID 
LEFT JOIN TestTypeMaster TT ON l.TestTypeId = TT.TestTypeId
LEFT JOIN ReferringProviderMaster RP ON b.ReferringProviderId = RP.ReferingProviderId

WHERE 
    (@FromDate IS NULL OR TRY_CONVERT(date, b.FirstBillDate) >= @FromDate)
    AND
    (@ToDate IS NULL OR TRY_CONVERT(date, b.FirstBillDate) <= @ToDate)
ORDER BY AccessionNo
END
GO
/****** Object:  StoredProcedure [dbo].[sp_GetProductionReportMaster]******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[sp_GetProductionReportMaster] 
    @FromDate DATE = NULL,
    @ToDate DATE = NULL
AS
BEGIN
    SET NOCOUNT ON;

    -- Temp tables
    SELECT * INTO #BillingMasterTemp 
    FROM BillingMaster WITH (NOLOCK)
    WHERE (@FromDate IS NULL OR FirstBillDate >= @FromDate) 
      AND (@ToDate IS NULL OR FirstBillDate <= @ToDate);

	----;WITH CTE_Trans AS(
 ----   SELECT VisitNo, ChartNumber,ROW_NUMBER() OVER (
 ----           PARTITION BY VisitNo 
 ----           ORDER BY DateOfService DESC
 ----       ) AS rn
 ----   FROM TransactionMaster 
 ----   WHERE VisitNo IS NOT NULL AND TransactionType = 'Charge'
    
	----)SELECT VisitNo,ChartNumber INTO #TransactionMaster FROM CTE_Trans WHERE rn = 1;

    CREATE NONCLUSTERED INDEX IX_VisitNumber_BM ON #BillingMasterTemp (VisitNumber);

    DROP TABLE IF EXISTS #DenialCode;
    SELECT DISTINCT VisitNumber, DBO.GetDenailCodeByVisitNumber(VisitNumber) AS DenialCode,MAX(PaymentDate) DenialDate
    INTO #DenialCode 
    FROM DenialTrackingMaster 
    WHERE PaymentReasonCode IS NOT NULL GROUP BY  VisitNumber, DBO.GetDenailCodeByVisitNumber(VisitNumber);

    CREATE NONCLUSTERED INDEX IX_VisitNumber_DC ON #DenialCode (VisitNumber);

    -- Aggregations
    ;WITH BillingAgg AS (
        SELECT VisitNumber,
            SUM(BilledAmount) AS TotalCharge,
            SUM(AllowedAmount) AS AllowedAmount,
            SUM(InsurancePayment) AS InsurancePayment,
            SUM(InsuranceAdjustment) AS InsuranceAdjustment,
            SUM(PatientPaidAmount) AS PatientPaidAmount,
            SUM(PatientAdjustment) AS PatientAdjustment,
            SUM(InsuranceBalance) AS InsuranceBalance,
            SUM(PatientBalance) AS PatientBalance,
            SUM(TotalBalance) AS TotalBalance
        FROM #BillingMasterTemp
        GROUP BY VisitNumber
    ),
    MostFrequentFinancialClass AS (
        SELECT VisitNumber, PT.PayerType,
               ROW_NUMBER() OVER (PARTITION BY VisitNumber ORDER BY COUNT(*) DESC) AS rn
        FROM #BillingMasterTemp BM
        JOIN PayerTypeMaster PT WITH (NOLOCK) ON BM.PayerTypeId = PT.PayerTypeId
        GROUP BY VisitNumber, PT.PayerType
    ),
    MostFrequentPOS AS (
        SELECT VisitNumber, POS,
               ROW_NUMBER() OVER (PARTITION BY VisitNumber ORDER BY COUNT(*) DESC) AS rn
        FROM #BillingMasterTemp
        WHERE POS IS NOT NULL
        GROUP BY VisitNumber, POS
    ),
    MostFrequentTOS AS (
        SELECT VisitNumber, TOS,
               ROW_NUMBER() OVER (PARTITION BY VisitNumber ORDER BY COUNT(*) DESC) AS rn
        FROM #BillingMasterTemp
        WHERE TOS IS NOT NULL
        GROUP BY VisitNumber, TOS
    ),
    EarliestCharge AS (
        SELECT VisitNumber, MIN(ChargeEntryDate) AS ChargeEntryDate
        FROM #BillingMasterTemp
        GROUP BY VisitNumber
    ),
    GroupedCPT AS (
        SELECT bm.VisitNumber, bm.CPTCode, SUM(bm.Units) AS Units
        FROM #BillingMasterTemp bm
        GROUP BY bm.VisitNumber, bm.CPTCode
    ),
    AggregatedCPT AS (
        SELECT VisitNumber,
            STRING_AGG(CAST(CPTCode AS VARCHAR(20)) + 
                (CASE WHEN ISNULL(Units,0) = 0 THEN '' ELSE '* ' + CAST(ISNULL(Units,0) AS VARCHAR(10)) END), ', ') AS CPTCode
        FROM GroupedCPT
        GROUP BY VisitNumber
    ),
    MainData AS (
        SELECT 
        BM.VisitNumber,
        BM.PrimaryPayerID,
        BM.PayerTypeId,
        BM.BillingProviderID,

        -- Window function instead of MIN()
        MIN(BM.BeginDOS) OVER (PARTITION BY BM.VisitNumber) AS BeginDOS,
		MAX(BM.ChargeEntryDate) OVER (PARTITION BY BM.VisitNumber) AS ChargeEntryDate,
		MAX(BM.CheckDate) OVER (PARTITION BY BM.VisitNumber) AS CheckDate,
		MAX(BM.PaymentPostedDate) OVER (PARTITION BY BM.VisitNumber) AS PaymentPostedDate,
        BM.FirstBillDate,
        BM.TOS,
        BM.ICD10Code,
        LIS.LISMasterId,
        LIS.AccessionNo,
        BM.PatientName,
		BM.ChartNumber,
        TT.TestTypeName AS TestType,
        CM.ClinicName,
        LIS.SampleCollectedDate,
        PG.PanelCategory,
		BM.CheckNumber,
        ISNULL(BM.ReferringProviderId, 0) AS ReferringProviderId,
        PG.PanelName,
        ISNULL(LIS.LabId, 0) AS LabId,
        ISNULL(LIS.PanelId, 0) AS PanelId,

        ROW_NUMBER() OVER (
            PARTITION BY BM.VisitNumber 
            ORDER BY BM.FirstBillDate DESC
        ) AS rn
    FROM BillingMaster BM
    LEFT JOIN LISMaster LIS WITH (NOLOCK) 
        ON BM.LISMasterId = LIS.LISMasterId
    LEFT JOIN PanelGroup PG WITH (NOLOCK) 
        ON LIS.PanelId = PG.PanelGroupId
    LEFT JOIN TestTypeMaster TT 
        ON LIS.TestTypeId = TT.TestTypeId
    LEFT JOIN ClinicMaster CM 
        ON LIS.ClinicId = CM.ClinicId
    )
    SELECT DISTINCT
        md.VisitNumber,
        ISNULL(md.AccessionNo,'Missing LIS Data') AS AccessionNo,
        ISNULL(md.PanelName,'Missing Panel Info') AS PanelName,
        ISNULL(IPM.PayerName,'Missing Payer Info') AS Carrier,
        FC.PayerType AS FinancialClass,
        BP.BillingProvider,
        RF.ReferringProviderName,
        md.ChartNumber,
        md.PatientName,
		md.TestType,
		md.ClinicName,
		md.PanelCategory PanelGroup,
        LM.LabName AS Facility,
        CONVERT(VARCHAR, md.BeginDOS, 101)  AS BeginDOS,
        DATEDIFF(DAY, md.SampleCollectedDate, GETDATE()) AS Aging,
        CASE 
            WHEN DATEDIFF(DAY, md.SampleCollectedDate, GETDATE()) <= 30 THEN 'Current'
            WHEN DATEDIFF(DAY, md.SampleCollectedDate, GETDATE()) <= 60 THEN '30 +'
            WHEN DATEDIFF(DAY, md.SampleCollectedDate, GETDATE()) <= 90 THEN '60 +'
            WHEN DATEDIFF(DAY, md.SampleCollectedDate, GETDATE()) <= 120 THEN '90 +'
            ELSE '120 +'
        END AS AgingBucket,
		CONVERT(VARCHAR, EC.ChargeEntryDate, 101)   AS AMDDOE,
		CONVERT(VARCHAR, md.FirstBillDate, 101)  AS FirstBillDate,
		CONVERT(VARCHAR, EC.ChargeEntryDate, 101)   AS ChargeEntryDate,
		CONVERT(VARCHAR, DC.DenialDate, 101)	DenialPostedDate,
		CONVERT(VARCHAR, md.CheckDate, 101)	CheckDate,
		CONVERT(VARCHAR, md.PaymentPostedDate, 101)	PaymentPostedDate,
		md.CheckNumber,
        CASE WHEN md.FirstBillDate IS NOT NULL THEN 'Billed' ELSE 'Not Billed' END AS BilledNotBilled,
        POS.POS,
        TOS.TOS,
        AG.CPTCode,
        md.ICD10Code AS PrimaryDiagnosis,
        DC.DenialCode,
        ISNULL(BA.TotalCharge, 0.0) AS TotalCharge,
        ISNULL(BA.AllowedAmount, 0.0) AS TotalAllowed,
        ISNULL(BA.InsurancePayment, 0.0) AS CarrierPayment,
        CAST(ROUND(CASE WHEN BA.TotalCharge > 0 THEN BA.InsurancePayment * 100.0 / BA.TotalCharge ELSE 0 END, 1) AS DECIMAL(8,2)) AS PaymentPercentage,
        ISNULL(BA.InsuranceAdjustment, 0.0) AS CarrierWO,
        ISNULL(BA.PatientPaidAmount, 0.0) AS PatientPaidAmount,
        ISNULL(BA.PatientAdjustment, 0.0) AS PatientWO,
        ISNULL(BA.InsuranceBalance, 0.0) AS CarrierBalance,
        ISNULL(BA.PatientBalance, 0.0) AS PatientBalance,
        ISNULL(BA.TotalBalance, 0.0) AS TotalBalance,
        (BA.InsurancePayment + BA.PatientPaidAmount) AS FullyPaid,
        CASE WHEN CPS.FinalStatus = 'Fully Paid' THEN 'Fully Paid Count' ELSE NULL END AS FullyPaidCount,
        CASE WHEN DATEDIFF(DAY, md.SampleCollectedDate, md.FirstBillDate) <= 30 THEN '30 Days Count' ELSE NULL END AS T30DaysCount,
        CASE WHEN DATEDIFF(DAY, md.SampleCollectedDate, md.FirstBillDate) <= 30 THEN (BA.InsurancePayment + BA.PatientPaidAmount) ELSE NULL END AS T30Amount,
        CASE WHEN DATEDIFF(DAY, md.SampleCollectedDate, md.FirstBillDate) BETWEEN 31 AND 60 THEN '60 Days Count' ELSE NULL END AS T60DaysCount,
        CASE WHEN DATEDIFF(DAY, md.SampleCollectedDate, md.FirstBillDate) BETWEEN 31 AND 60 THEN (BA.InsurancePayment + BA.PatientPaidAmount) ELSE NULL END AS T60Amount,
    -- Conditionally return AdjudicatedAmount
		CASE 
			WHEN CPS.FinalStatus IN ('No Response') THEN NULL
			WHEN CPS.FinalStatus = 'Fully Adjusted' AND DC.DenialCode IS NULL THEN NULL
			ELSE (BA.InsurancePayment)
		END AS AdjudicatedAmount,

		-- Conditionally return AdjudicatedCount
		CASE 
			WHEN CPS.FinalStatus IN ('No Response') THEN NULL
			WHEN CPS.FinalStatus = 'Fully Adjusted' AND DC.DenialCode IS NULL THEN NULL
			ELSE 'Adjudicated Count' END
			 AdjudicatedCount,

        CPS.FinalStatus,
		CASE WHEN md.AccessionNo is null then 'Missing LIS Data' else '' end LISMissingRecord 
    FROM MainData md
    LEFT JOIN InsurancePayerMaster IPM WITH (NOLOCK) ON md.PrimaryPayerID = IPM.InsurancePayerId
    LEFT JOIN BillingProviderMaster BP WITH (NOLOCK) ON md.BillingProviderID = BP.BillingProviderID
    LEFT JOIN ReferringProviderMaster RF WITH (NOLOCK) ON md.ReferringProviderId = RF.ReferingProviderId
    LEFT JOIN LabMaster LM WITH (NOLOCK) ON md.LabId = LM.LabID
    ----LEFT JOIN #TransactionMaster TM ON md.VisitNumber = TM.VisitNo
    LEFT JOIN MostFrequentFinancialClass FC ON md.VisitNumber = FC.VisitNumber AND FC.rn = 1
    LEFT JOIN MostFrequentPOS POS ON md.VisitNumber = POS.VisitNumber AND POS.rn = 1
    LEFT JOIN MostFrequentTOS TOS ON md.VisitNumber = TOS.VisitNumber AND TOS.rn = 1
    LEFT JOIN EarliestCharge EC ON md.VisitNumber = EC.VisitNumber
    LEFT JOIN BillingAgg BA ON md.VisitNumber = BA.VisitNumber
    LEFT JOIN AggregatedCPT AG ON md.VisitNumber = AG.VisitNumber
    LEFT JOIN ClaimsLevelStatus CPS ON md.VisitNumber = CPS.VisitNumber
    LEFT JOIN #DenialCode DC ON md.VisitNumber = DC.VisitNumber
    WHERE md.rn = 1 order by FirstBillDate 

    DROP TABLE IF EXISTS #BillingMasterTemp, #TransactionMaster, #DenialCode;
END
GO
/****** Object:  StoredProcedure [dbo].[sp_GetProductionReportMaster_bak]******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE   PROCEDURE [dbo].[sp_GetProductionReportMaster_bak] 
    @FromDate DATE = NULL,
    @ToDate DATE = NULL
AS
BEGIN
    SET NOCOUNT ON;

    -- Step 1: Filtered BillingMaster
    SELECT *
    INTO #BillingMasterTemp
    FROM BillingMaster WITH (NOLOCK)
    WHERE (@FromDate IS NULL OR FirstBillDate >= @FromDate)
      AND (@ToDate IS NULL OR FirstBillDate <= @ToDate);

    CREATE NONCLUSTERED INDEX IX_BillingMasterTemp_VisitNumber ON #BillingMasterTemp(VisitNumber);

    -- Step 2: Pre-aggregated TransactionMaster
    SELECT VisitNo, CPTCode, ChartNumber, SUM(units) AS Units
    INTO #TransactionMaster
    FROM TransactionMaster WITH (NOLOCK)
    GROUP BY VisitNo, CPTCode, ChartNumber;

    CREATE NONCLUSTERED INDEX IX_TransactionMaster_VisitNo ON #TransactionMaster(VisitNo);

    -- Step 3: Pre-aggregated Denial Codes
    SELECT VisitNumber, STRING_AGG(PaymentReasonCode, ', ') AS DenialCode
    INTO #DenialCode
    FROM DenialTrackingMaster WITH (NOLOCK)
    WHERE PaymentReasonCode IS NOT NULL
    GROUP BY VisitNumber;

    CREATE NONCLUSTERED INDEX IX_DenialCode_VisitNumber ON #DenialCode(VisitNumber);

    -- Step 4: Aggregations
    ;WITH BillingAgg AS (
        SELECT 
            VisitNumber,
            SUM(BilledAmount) AS TotalCharge,
            SUM(AllowedAmount) AS AllowedAmount,
            SUM(InsurancePayment) AS InsurancePayment,
            SUM(InsuranceAdjustment) AS InsuranceAdjustment,
            SUM(PatientPaidAmount) AS PatientPaidAmount,
            SUM(PatientAdjustment) AS PatientAdjustment,
            SUM(InsuranceBalance) AS InsuranceBalance,
            SUM(PatientBalance) AS PatientBalance,
            SUM(TotalBalance) AS TotalBalance
        FROM #BillingMasterTemp
        GROUP BY VisitNumber
    ),
    MostFrequentFinancialClass AS (
        SELECT VisitNumber, PT.PayerType,
               ROW_NUMBER() OVER (PARTITION BY VisitNumber ORDER BY COUNT(*) DESC) AS rn
        FROM #BillingMasterTemp BM
        JOIN PayerTypeMaster PT WITH (NOLOCK) ON BM.PayerTypeId = PT.PayerTypeId
        GROUP BY VisitNumber, PT.PayerType
    ),
    MostFrequentPOS AS (
        SELECT VisitNumber, POS,
               ROW_NUMBER() OVER (PARTITION BY VisitNumber ORDER BY COUNT(*) DESC) AS rn
        FROM #BillingMasterTemp
        WHERE POS IS NOT NULL
        GROUP BY VisitNumber, POS
    ),
    MostFrequentTOS AS (
        SELECT VisitNumber, TOS,
               ROW_NUMBER() OVER (PARTITION BY VisitNumber ORDER BY COUNT(*) DESC) AS rn
        FROM #BillingMasterTemp
        WHERE TOS IS NOT NULL
        GROUP BY VisitNumber, TOS
    ),
    EarliestCharge AS (
        SELECT VisitNumber, MIN(ChargeEntryDate) AS ChargeEntryDate
        FROM #BillingMasterTemp
        GROUP BY VisitNumber
    ),
    GroupedCPT AS (
        SELECT bm.VisitNumber, bm.CPTCode, SUM(ISNULL(tm.Units, 0)) AS Units
        FROM #BillingMasterTemp bm
        LEFT JOIN #TransactionMaster tm ON bm.VisitNumber = tm.VisitNo
        GROUP BY bm.VisitNumber, bm.CPTCode
    ),
    AggregatedCPT AS (
        SELECT VisitNumber,
               STRING_AGG(CAST(CPTCode AS VARCHAR(20)) + 
                 CASE WHEN Units = 0 THEN '' ELSE '* ' + CAST(Units AS VARCHAR(10)) END, ', ') AS CPTCode
        FROM GroupedCPT
        GROUP BY VisitNumber
    ),
    MainData AS (
        SELECT 
            BM.VisitNumber,
            BM.PrimaryPayerID,
            BM.PayerTypeId,
            BM.BillingProviderID,
            BM.BeginDOS,
            BM.FirstBillDate,
            BM.ChargeEntryDate,
            BM.TOS,
            BM.ICD10Code,
            LIS.LISMasterId,
            LIS.AccessionNo,
            LIS.PatientName,
            LIS.ReferringProviderId,
            PG.PanelName,
            LIS.LabId,
            LIS.PanelId,
            ROW_NUMBER() OVER (PARTITION BY BM.VisitNumber ORDER BY BM.FirstBillDate DESC) AS rn
        FROM #BillingMasterTemp BM
        JOIN LISMaster LIS WITH (NOLOCK) ON BM.LISMasterId = LIS.LISMasterId
        LEFT JOIN PanelGroup PG WITH (NOLOCK) ON LIS.PanelId = PG.PanelGroupId
    )

    SELECT
     DISTINCT   md.VisitNumber,
        md.AccessionNo,
        md.PanelName,
        IPM.PayerName AS Carrier,
        FC.PayerType AS FinancialClass,
        BP.BillingProvider,
        RF.ReferringProviderName,
        TM.ChartNumber,
        md.PatientName,
        LM.LabName AS Facility,
        CAST(md.BeginDOS AS DATE) AS BeginDOS,
        DATEDIFF(DAY, md.FirstBillDate, GETDATE()) AS Aging,
        CASE 
            WHEN DATEDIFF(DAY, md.FirstBillDate, GETDATE()) <= 30 THEN 'Current'
            WHEN DATEDIFF(DAY, md.FirstBillDate, GETDATE()) <= 60 THEN '30 +'
            WHEN DATEDIFF(DAY, md.FirstBillDate, GETDATE()) <= 90 THEN '60 +'
            WHEN DATEDIFF(DAY, md.FirstBillDate, GETDATE()) <= 120 THEN '90 +'
            ELSE '120 +'
        END AS AgingBucket,
        CAST(EC.ChargeEntryDate AS DATE) AS AMDDOE,
        CAST(md.FirstBillDate AS DATE) AS FirstBillDate,
        CAST(EC.ChargeEntryDate AS DATE) AS LatestPostDate,
        CASE WHEN md.FirstBillDate IS NOT NULL THEN 'Billed' ELSE 'Not Billed' END AS BilledNotBilled,
        POS.POS,
        TOS.TOS,
        AG.CPTCode,
        md.ICD10Code AS PrimaryDiagnosis,
        DC.DenialCode,
        ISNULL(BA.TotalCharge, 0.0) AS TotalCharge,
        ISNULL(BA.AllowedAmount, 0.0) AS TotalAllowed,
        ISNULL(BA.InsurancePayment, 0.0) AS CarrierPayment,
        CAST(ROUND(CASE WHEN BA.TotalCharge > 0 THEN BA.InsurancePayment * 100.0 / BA.TotalCharge ELSE 0 END, 1) AS DECIMAL(8,2)) AS PaymentPercentage,
        ISNULL(BA.InsuranceAdjustment, 0.0) AS CarrierWO,
        ISNULL(BA.PatientPaidAmount, 0.0) AS PatientPaidAmount,
        ISNULL(BA.PatientAdjustment, 0.0) AS PatientWO,
        ISNULL(BA.InsuranceBalance, 0.0) AS CarrierBalance,
        ISNULL(BA.PatientBalance, 0.0) AS PatientBalance,
        ISNULL(BA.TotalBalance, 0.0) AS TotalBalance,
        (BA.InsurancePayment + BA.PatientPaidAmount) AS FullyPaid,
        CASE WHEN CPS.FinalStatus = 'Fully Paid' THEN 'Fully Paid Count' END AS FullyPaidCount,
        (BA.InsuranceAdjustment + BA.PatientAdjustment) AS AdjudicatedAmount,
        CASE WHEN DATEDIFF(DAY, md.FirstBillDate, GETDATE()) <= 30 THEN '30 Days Count' END AS T30DaysCount,
        CASE WHEN DATEDIFF(DAY, md.FirstBillDate, GETDATE()) <= 30 THEN (BA.InsurancePayment + BA.PatientPaidAmount) END AS T30Amount,
        CASE WHEN DATEDIFF(DAY, md.FirstBillDate, GETDATE()) BETWEEN 31 AND 60 THEN '60 Days Count' END AS T60DaysCount,
        CASE WHEN DATEDIFF(DAY, md.FirstBillDate, GETDATE()) BETWEEN 31 AND 60 THEN (BA.InsurancePayment + BA.PatientPaidAmount) END AS T60Amount,
        CPS.FinalStatus
    FROM MainData md
    JOIN InsurancePayerMaster IPM WITH (NOLOCK) ON md.PrimaryPayerID = IPM.InsurancePayerId
    JOIN BillingProviderMaster BP WITH (NOLOCK) ON md.BillingProviderID = BP.BillingProviderID
    JOIN ReferringProviderMaster RF WITH (NOLOCK) ON md.ReferringProviderId = RF.ReferingProviderId
	LEFT JOIN LabMaster LM WITH (NOLOCK) ON md.LabId = ISNULL(LM.LabID,0)
    LEFT JOIN #TransactionMaster TM ON md.VisitNumber = TM.VisitNo
    LEFT JOIN MostFrequentFinancialClass FC ON md.VisitNumber = FC.VisitNumber AND FC.rn = 1
    LEFT JOIN MostFrequentPOS POS ON md.VisitNumber = POS.VisitNumber AND POS.rn = 1
    LEFT JOIN MostFrequentTOS TOS ON md.VisitNumber = TOS.VisitNumber AND TOS.rn = 1
    LEFT JOIN EarliestCharge EC ON md.VisitNumber = EC.VisitNumber
    LEFT JOIN BillingAgg BA ON md.VisitNumber = BA.VisitNumber
    LEFT JOIN AggregatedCPT AG ON md.VisitNumber = AG.VisitNumber
    LEFT JOIN SampleFinalStatus CPS ON md.VisitNumber = CPS.VisitNumber
    LEFT JOIN #DenialCode DC ON md.VisitNumber = DC.VisitNumber
    WHERE md.rn = 1;

    -- Cleanup
    DROP TABLE IF EXISTS #BillingMasterTemp;
    DROP TABLE IF EXISTS #TransactionMaster;
    DROP TABLE IF EXISTS #DenialCode;
END
GO
/****** Object:  StoredProcedure [dbo].[sp_InsertClaimDenialCode]******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE Procedure [dbo].[sp_InsertClaimDenialCode]
AS BEGIN

  SET NOCOUNT ON;

;WITH Tokenized AS (
        SELECT DISTINCT VisitNumber,CPTCodes,
            TRIM(s.value) AS Code
        FROM DenialTrackingMaster d
        CROSS APPLY STRING_SPLIT(d.PaymentReasonCode, ';') AS s
        WHERE  d.PaymentReasonCode IS NOT NULL
          AND TRIM(s.value) <> ''
    ),
    Filtered AS (
        SELECT DISTINCT VisitNumber,CPTCodes,Code
        FROM Tokenized
        WHERE Code NOT IN (
            'CO45','CO253','CO1','CO2','CO3',
            'PR1','PR2','PR3','PR45','PR253'
        )
    )
    SELECT VisitNumber,CPTCodes,STRING_AGG(Code, ';') DenialCode  INTO #DenailCodeMaster
    FROM Filtered GROUP BY VisitNumber,CPTCodes;

	TRUNCATE TABLE [ClaimDenialCodes];

	INSERT INTO [dbo].[ClaimDenialCodes]
           ([VisitNumber],[CPTCode],[DenialCode])
	SELECT VisitNumber,CPTCodes,DenialCode FROM #DenailCodeMaster

END
GO
/****** Object:  StoredProcedure [dbo].[sp_InsertMasterData]******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[sp_InsertMasterData]
as begin 

  SET NOCOUNT ON;

INSERT INTO [dbo].[ClinicMaster]([ClinicName],[ClinicStatus])
SELECT DISTINCT LTRIM(RTRIM(ClinicName)),1 FROM LISStaging 
WHERE LTRIM(RTRIM(ClinicName)) NOT IN (SELECT DISTINCT ClinicName FROM [ClinicMaster]) AND ClinicName IS NOT NULL

--PRINT '[ClinicMaster] Inserted Completed'



INSERT INTO [dbo].[OperationsGroupMaster]([OperationsGroup],[IsActive])
SELECT DISTINCT LTRIM(RTRIM(OperationsGroup)),1 FROM LISStaging 
WHERE LTRIM(RTRIM(OperationsGroup)) NOT IN (SELECT DISTINCT [OperationsGroup] FROM [OperationsGroupMaster]) AND OperationsGroup IS NOT NULL

--PRINT '[OperationsGroupMaster] Inserted Completed'



INSERT INTO [dbo].[SpecimenStatus]([SpecimenStatusName],[IsActive])
SELECT DISTINCT LTRIM(RTRIM(SpecimenStatus)),1 FROM LISStaging 
WHERE LTRIM(RTRIM(SpecimenStatus)) NOT IN (SELECT DISTINCT [SpecimenStatusName] FROM [SpecimenStatus]) AND SpecimenStatus IS NOT NULL

--PRINT '[SpecimenStatu] Inserted Completed'



INSERT INTO [dbo].[TestTypeMaster]([TestTypeName],[IsActive])
SELECT DISTINCT LTRIM(RTRIM(TestType)),1 FROM LISStaging 
WHERE LTRIM(RTRIM(TestType)) NOT IN (SELECT DISTINCT [TestTypeName] FROM [TestTypeMaster]) AND TestType IS NOT NULL

--PRINT '[TestTypeMaster] Inserted Completed'

 


INSERT INTO [dbo].[InsurancePayerMaster]([PayerName],[IsActive])
SELECT DISTINCT LTRIM(RTRIM(PayerName)),1 FROM LISStaging 
WHERE LTRIM(RTRIM(PayerName)) NOT IN (SELECT DISTINCT [PayerName] FROM [InsurancePayerMaster]) AND PayerName IS NOT NULL



INSERT INTO [dbo].[InsurancePayerMaster]([PayerName],[IsActive])
SELECT DISTINCT LTRIM(RTRIM(PayerName)),1 FROM CustomCollectionStaging 
WHERE LTRIM(RTRIM(PayerName)) NOT IN (SELECT DISTINCT [PayerName] FROM [InsurancePayerMaster]) AND PayerName IS NOT NULL

--PRINT '[InsurancePayerMaster] Inserted Completed'

 

INSERT INTO [dbo].PayerTypeMaster([PayerType],[IsActive])
SELECT DISTINCT LTRIM(RTRIM(PayerType)),1 FROM CustomCollectionStaging 
WHERE LTRIM(RTRIM(PayerType)) NOT IN (SELECT DISTINCT [PayerType] FROM PayerTypeMaster) AND PayerType IS NOT NULL

--PRINT '[PayerTypeMaster] Inserted Completed'

 

INSERT INTO [dbo].BillingProviderMaster([BillingProvider],[IsActive])
SELECT DISTINCT LTRIM(RTRIM(BillingProvider)),1 FROM CustomCollectionStaging 
WHERE LTRIM(RTRIM(BillingProvider)) NOT IN (SELECT DISTINCT [BillingProvider] FROM BillingProviderMaster) AND BillingProvider IS NOT NULL

--PRINT '[BillingProviderMaster] Inserted Completed'

 

INSERT INTO [dbo].ReferringProviderMaster([ReferringProviderName],[IsActive])
SELECT DISTINCT LTRIM(RTRIM(ReferringProvider)),1 FROM CustomCollectionStaging 
WHERE LTRIM(RTRIM(ReferringProvider)) NOT IN (SELECT DISTINCT [ReferringProviderName] FROM ReferringProviderMaster) AND ReferringProvider IS NOT NULL

--PRINT '[ReferringProviderMaster] Inserted Completed'

 

INSERT INTO [dbo].LabMaster(LabName,[IsActive])
SELECT DISTINCT LTRIM(RTRIM(PerformingLab)),1 FROM CustomCollectionStaging 
WHERE LTRIM(RTRIM(PerformingLab)) NOT IN (SELECT DISTINCT LabName FROM LabMaster) AND PerformingLab IS NOT NULL

--PRINT '[LabMaster] Inserted Completed'

 

DROP TABLE IF EXISTS #CPTCodes;
SELECT DISTINCT LTRIM(RTRIM(SUBSTRING(BilledCPTCode, 0, 6))) CPTCode,LTRIM(RTRIM(SUBSTRING(BilledCPTCode, 6, LEN(BilledCPTCode)))) CodeDescription,
BilledCPTCode OriginalCode INTO #CPTCodes FROM CustomCollectionStaging WHERE BilledCPTCode IS NOT NULL

INSERT INTO [dbo].CPTCodeMaster(CPTCode,CodeDescription,OriginalCode,[IsActive])
SELECT CPTCode,CodeDescription,OriginalCode,1 FROM #CPTCodes
WHERE CPTCode NOT IN (SELECT DISTINCT CPTCode FROM CPTCodeMaster) 

--PRINT '[CPTCodeMaster] Inserted Completed'



DROP TABLE IF EXISTS #ICD10Codes;
SELECT DISTINCT   LTRIM(RTRIM(LEFT(ICD10Code, CHARINDEX('-', ICD10Code) - 1))) ICD10Code,
LTRIM(RTRIM(SUBSTRING(ICD10Code, CHARINDEX('-', ICD10Code) + 1, LEN(ICD10Code)))) CodeDescription , ICD10Code AS [OriginalCode]
INTO #ICD10Codes FROM CustomCollectionStaging WHERE  LTRIM(RTRIM(ICD10Code)) IS NOT NULL


INSERT INTO [dbo].ICDCodeMaster(ICD10Code,CodeDescription,OriginalCode)
SELECT ICD10Code,CodeDescription,[OriginalCode] FROM #ICD10Codes WHERE ICD10Code NOT IN (SELECT DISTINCT ICD10Code FROM ICDCodeMaster)

--PRINT '[ICDCodeMaster] Inserted Completed'

END
GO
/****** Object:  StoredProcedure [dbo].[SP_InsertReportDownloadLog]******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SP_InsertReportDownloadLog]
@ReportId INT,@LogString NVARCHAR(MAX)
AS BEGIN 

UPDATE [dbo].[ReportDownloadSts]
   SET LogString = @LogString
 WHERE ReportID =  @ReportId 

END
GO
/****** Object:  StoredProcedure [dbo].[Sp_Process_BillingSheet_ByFileId]******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[Sp_Process_BillingSheet_ByFileId]
    @FileId INT = NULL
AS
BEGIN
    SET NOCOUNT ON;

    BEGIN TRY
        BEGIN TRANSACTION;
			update ImportedFiles set FileStatus = 3,ProcessedOn = GETDATE()  where ImportedFileID = @FileId;

        /*******************************************************************************************
         Step 4c: Update ClientStatus from PrismBillingStaging
        ********************************************************************************************/
        WITH CTE_SheetLogic AS (
            SELECT DISTINCT 
                SpecimenID, 
                LTRIM(RTRIM(SheetName)) AS SheetName
            FROM PrismBillingStaging
            WHERE 
                SpecimenID IS NOT NULL
                AND ImportedFileID = @FileId OR @FileId IS NULL
        )
        UPDATE LIS
        SET LIS.ClientStatus = 
            CASE 
                WHEN LTRIM(RTRIM(PS.SheetName)) = 'To Bill' THEN 'Current Billing Queue'
                WHEN LTRIM(RTRIM(PS.SheetName)) = 'Medicare On Hold' THEN 'Medicare On Hold'
                WHEN LTRIM(RTRIM(PS.SheetName)) = 'MO Medicaid On Hold' THEN 'MO Medicaid On Hold'
                WHEN LTRIM(RTRIM(PS.SheetName)) = 'Missing Info' THEN 'Missing Information'
                WHEN LTRIM(RTRIM(PS.SheetName)) = 'PGX' THEN 'Pending PGX  Coding / Meds'
                WHEN LTRIM(RTRIM(PS.SheetName)) IN ('Paid', 'Billed') THEN ''
				WHEN LTRIM(RTRIM(PS.SheetName)) IN ('New to Bill', 'Eden to Bill') THEN 'Current Billing Queue'
                WHEN LIS.SampleResultedDate IS NOT NULL 
                     AND LIS.ResultedStatus = 'Resulted' 
                     AND LIS.SampleStatusId = 3 
                     AND LIS.ChargeEntryDate IS NULL 
                     AND LIS.FirstBilledDate IS NULL  
                     THEN 'Billing Review Required'
                ELSE PS.SheetName
            END
        FROM LISMaster LIS
        JOIN CTE_SheetLogic PS ON LIS.AccessionNo = PS.SpecimenID;

				update ImportedFiles set FileStatus = 1,ProcessedOn = GETDATE()  where ImportedFileID = @FileId;

        COMMIT TRANSACTION;
    END TRY
    BEGIN CATCH
        IF @@TRANCOUNT > 0
            ROLLBACK TRANSACTION;
					
		update ImportedFiles set FileStatus = 2,ProcessedOn = GETDATE()  where ImportedFileID = @FileId;

        DECLARE 
            @ErrMsg NVARCHAR(4000) = ERROR_MESSAGE(),
            @ErrSeverity INT = ERROR_SEVERITY(),
            @ErrState INT = ERROR_STATE();

        RAISERROR(@ErrMsg, @ErrSeverity, @ErrState);
    END CATCH
END;
GO
/****** Object:  StoredProcedure [dbo].[Sp_Process_ClientBillingSheet]******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[Sp_Process_ClientBillingSheet]
    @FileId INT = NULL
AS
BEGIN
    SET NOCOUNT ON;

    BEGIN TRY
        BEGIN TRANSACTION;
			update ImportedFiles set FileStatus = 3,ProcessedOn = GETDATE()  where ImportedFileID = @FileId;

        /*******************************************************************************************
         Step 4c: Update ClientStatus from PrismBillingStaging
        ********************************************************************************************/
        WITH CTE_SheetLogic AS (
            SELECT DISTINCT 
                AccessionNo,
				PerformingFacility,
                LTRIM(RTRIM(SheetName)) AS SheetName
            FROM ClientBillingSheet
            WHERE 
                AccessionNo IS NOT NULL
                AND ImportedFileID = @FileId OR @FileId IS NULL
        )
        UPDATE LIS
        SET LIS.ClientStatus = 
            CASE 
                WHEN LTRIM(RTRIM(PS.SheetName)) = 'Billed to Phi (Prism Ran)' THEN 'Phi Life (Prism) - Client Billed'
                WHEN LTRIM(RTRIM(PS.SheetName)) = 'Phi Paid (Prism Ran)' THEN 'Phi Life (Prism) - Client Bill Paid'
                WHEN LTRIM(RTRIM(PS.SheetName)) = 'Billed to Phi (Phi Ran)' THEN 'Phi Life - Client Billed'
                WHEN LTRIM(RTRIM(PS.SheetName)) = 'Phi Paid (Phi Ran)' THEN 'Phi Life - Client Billed'
				WHEN LTRIM(RTRIM(PS.PerformingFacility)) = 'Phi Life Sciences' THEN 'Phi Life Client Bill'
               
                ELSE PS.SheetName
            END
        FROM LISMaster LIS
        JOIN CTE_SheetLogic PS ON LIS.AccessionNo = PS.AccessionNo;

				update ImportedFiles set FileStatus = 1,ProcessedOn = GETDATE()  where ImportedFileID = @FileId;

        COMMIT TRANSACTION;
    END TRY
    BEGIN CATCH
        IF @@TRANCOUNT > 0
            ROLLBACK TRANSACTION;
					
		update ImportedFiles set FileStatus = 2,ProcessedOn = GETDATE()  where ImportedFileID = @FileId;

        DECLARE 
            @ErrMsg NVARCHAR(4000) = ERROR_MESSAGE(),
            @ErrSeverity INT = ERROR_SEVERITY(),
            @ErrState INT = ERROR_STATE();

        RAISERROR(@ErrMsg, @ErrSeverity, @ErrState);
    END CATCH
END;
GO
/****** Object:  StoredProcedure [dbo].[sp_Process_FinalCalimStatus]******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[sp_Process_FinalCalimStatus]
AS
BEGIN
    SET NOCOUNT ON;

    BEGIN TRY
        BEGIN TRAN;

        -- Drop temp tables if exist
        DROP TABLE IF EXISTS #ProductionDetails;
        DROP TABLE IF EXISTS #ClaimFinalStatus;
        DROP TABLE IF EXISTS #VisitClaimStatus;

        -- Step 1: Load production details
        SELECT DISTINCT 
            BM.VisitNumber,
            BM.CPTCode,
            DT.PaymentReasonCode,
            BilledAmount,
            AllowedAmount,
            InsurancePayment,
            PatientPaidAmount,
            InsuranceAdjustment,
            InsuranceBalance,
            PatientBalance,
            BM.TotalBalance,
            BM.PatientAdjustment
        INTO #ProductionDetails
        FROM BillingMaster BM
        LEFT JOIN DenialTrackingMaster DT 
            ON BM.VisitNumber = DT.VisitNumber AND BM.CPTCode = DT.CPTCodes
			
AND (
    PaymentReasonCode IS NOT NULL

    AND NOT (
			';' + PaymentReasonCode + ';' LIKE '%;CO45;%'
		OR	';' + PaymentReasonCode + ';' LIKE '%;CO253;%'
		OR	';' + PaymentReasonCode + ';' LIKE '%;PR1;%'
        OR	';' + PaymentReasonCode + ';' LIKE '%;PR2;%'
        OR	';' + PaymentReasonCode + ';' LIKE '%;PR3;%'
    )
);

        -- Step 2: Determine line item level final status
  
	SELECT b.VisitNumber,b.CPTCode,b.FirstBillDate,b.Units,b.BilledAmount,b.Modifier, status.*  INTO #ClaimFinalStatus FROM BillingMaster b
	CROSS APPLY dbo.fn_GetClaimStatusByVisitAndCPT(b.VisitNumber, b.CPTCode,b.FirstBillDate,b.Units,b.BilledAmount,b.Modifier) AS status;

        -- Step 3: Populate ClaimsProdStatus table
        TRUNCATE TABLE [ClaimsProdStatus];

        INSERT INTO [dbo].[ClaimsProdStatus]
        (
            VisitNumber, CPTCode, BilledAmount, AllowedAmount, InsurancePayment,
            InsuranceAdjustment, PatientPaidAmount, PatientAdjustment,
            InsuranceBalance, PatientBalance, TotalBalance, DenialCode, FinalStatus,ClaimSubStatus
        )
        SELECT 
            cf.VisitNumber,
            cf.CPTCode,
            pd.BilledAmount,
            pd.AllowedAmount,
            pd.InsurancePayment,
            pd.InsuranceAdjustment,
            pd.PatientPaidAmount,
            pd.PatientAdjustment,
            pd.InsuranceBalance,
            pd.PatientBalance,
            pd.TotalBalance,
            pd.PaymentReasonCode,
            cf.FinalStatus,
			CF.ClaimSubStatus
        FROM #ProductionDetails pd
        JOIN #ClaimFinalStatus cf 
            ON pd.VisitNumber = cf.VisitNumber AND pd.CPTCode = cf.CPTCode
		   AND pd.BilledAmount = cf.BilledAmount;

        -- Step 4: Update BillingMaster table
        UPDATE BM
        SET FinalClaimStatus = CF.FinalStatus,
		ClaimSubStatus = CF.ClaimSubStatus
        FROM BillingMaster BM
        JOIN #ClaimFinalStatus CF 
            ON BM.VisitNumber = CF.VisitNumber AND BM.CPTCode = CF.CPTCode
           AND ISNULL(BM.FirstBillDate, '1900-01-01') = ISNULL(CF.FirstBillDate, '1900-01-01')
		   AND ISNULL(BM.Units,999) = ISNULL(CF.Units,999)
		   AND BM.BilledAmount = CF.BilledAmount
		   AND ISNULL(BM.Modifier,9999) = ISNULL(CF.Modifier,9999);

        -- Step 5: Derive claim-level final status
       WITH StatusFlags AS (
    SELECT 
        VisitNumber,
        SUM(CASE WHEN FinalClaimStatus = 'Paid' THEN 1 ELSE 0 END) AS PaidCount,
        SUM(CASE WHEN FinalClaimStatus = 'Patient Responsibility' THEN 1 ELSE 0 END) AS PatientRespCount,
        SUM(CASE WHEN FinalClaimStatus = 'Adjusted' THEN 1 ELSE 0 END) AS AdjustedCount,
        SUM(CASE WHEN FinalClaimStatus = 'Denied' THEN 1 ELSE 0 END) AS DeniedCount,
        SUM(CASE WHEN FinalClaimStatus = 'No Response' THEN 1 ELSE 0 END) AS NoResponseCount,
        COUNT(*) AS TotalCount
    FROM BillingMaster
    GROUP BY VisitNumber
)
SELECT 
    VisitNumber,
    CASE
        -- All same statuses
        WHEN PaidCount = TotalCount THEN 'Fully Paid'
        WHEN PatientRespCount = TotalCount THEN 'Patient Responsibility'
        WHEN AdjustedCount = TotalCount THEN 'Fully Adjusted'
        WHEN DeniedCount = TotalCount THEN 'Fully Denied'
        WHEN NoResponseCount = TotalCount THEN 'No Response'

        -- Combination logic
        WHEN PaidCount > 0 AND PatientRespCount > 0 AND AdjustedCount = 0 AND DeniedCount = 0 AND NoResponseCount = 0 THEN 'Fully Paid'
        WHEN PaidCount > 0 AND AdjustedCount > 0 AND PatientRespCount = 0 AND DeniedCount = 0 AND NoResponseCount = 0 THEN 'Fully Paid'
        WHEN PaidCount > 0 AND DeniedCount > 0 THEN 'Partially Paid'
        WHEN PaidCount > 0 AND AdjustedCount = 0 AND PatientRespCount = 0 AND DeniedCount = 0 AND NoResponseCount = 0 THEN 'Fully Paid'

        WHEN PatientRespCount > 0 AND AdjustedCount > 0 AND DeniedCount = 0 AND NoResponseCount = 0 AND PaidCount = 0 THEN 'Patient Responsibility'
        WHEN PatientRespCount > 0 AND ((AdjustedCount + DeniedCount + NoResponseCount) > 0) THEN 'Partial Patient Responsibility'

        WHEN AdjustedCount > 0 AND DeniedCount > 0 AND PaidCount = 0 AND PatientRespCount = 0 THEN 'Partially Denied'
        WHEN DeniedCount > 0 AND NoResponseCount > 0 AND PaidCount = 0 AND PatientRespCount = 0 THEN 'Partially Denied'

        ELSE 'No Response'
    END AS ClaimStatus
INTO #VisitClaimStatus
FROM StatusFlags;


		WITH RankedStatuses AS (
			SELECT 
				VisitNumber,
				ClaimSubStatus,
				COUNT(*) AS Frequency,
				ROW_NUMBER() OVER (PARTITION BY VisitNumber ORDER BY COUNT(*) DESC) AS rn
			FROM dbo.ClaimsProdStatus
			GROUP BY VisitNumber, ClaimSubStatus
		)
		SELECT distinct VisitNumber, ClaimSubStatus  INTO #ClaimSubStatus FROM RankedStatuses
		WHERE rn = 1;

        -- Step 6: Insert into SampleFinalStatus
        TRUNCATE TABLE SampleFinalStatus;

        INSERT INTO SampleFinalStatus (VisitNumber, FinalStatus,ClaimSubStatus)
        SELECT a.VisitNumber, ClaimStatus,ClaimSubStatus
        FROM #VisitClaimStatus a 
		JOIN #ClaimSubStatus b on a.VisitNumber = b.VisitNumber 
        WHERE ISNULL(ClaimStatus, '') <> '';

        COMMIT; -- Commit the transaction if everything succeeds
    END TRY
    BEGIN CATCH
        ROLLBACK; -- Roll back transaction if any error occurs

        -- Optionally: raise the error back to caller
        THROW;
    END CATCH
END;
GO
/****** Object:  StoredProcedure [dbo].[sp_Process_FinalCalimStatus_bak]******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[sp_Process_FinalCalimStatus_bak]
AS
BEGIN
    SET NOCOUNT ON;

    BEGIN TRY
        BEGIN TRANSACTION;

        TRUNCATE TABLE [ClaimsProdStatus];
        DROP TABLE IF EXISTS #ProdFinalStatus;
        DROP TABLE IF EXISTS #ClaimStatusTable;

        -- Step 1: Aggregate billing per VisitNumber and CPTCode
        ;WITH AggregatedBilling AS (
            SELECT 
                VisitNumber,
                CPTCode,
                SUM(BilledAmount) AS BilledAmount,
                SUM(AllowedAmount) AS AllowedAmount,
                SUM(InsurancePayment) AS InsurancePayment,
                SUM(InsuranceAdjustment) AS InsuranceAdjustment,
                SUM(PatientPaidAmount) AS PatientPaidAmount,
                SUM(PatientAdjustment) AS PatientAdjustment,
                SUM(InsuranceBalance) AS InsuranceBalance,
                SUM(PatientBalance) AS PatientBalance,
                SUM(TotalBalance) AS TotalBalance
            FROM BillingMaster
            GROUP BY VisitNumber, CPTCode
        ),
        EarliestBillDate AS (
            SELECT 
                VisitNumber, CPTCode,
                MIN(FirstBillDate) AS FirstBillDate
            FROM BillingMaster
            GROUP BY VisitNumber, CPTCode
        ),
        LISInfo AS (
            SELECT 
                VisitNumber,
                SampleResultedDate,
                dbo.GetDenailCodeByVisitNumber(VisitNumber) AS DenialCode
            FROM LISMaster
        )

        -- Step 2: Merge data into a temp table
        SELECT 
            ab.VisitNumber,
            ab.CPTCode,
            li.SampleResultedDate,
            ebd.FirstBillDate,
            li.DenialCode,
            ab.BilledAmount,
            ab.AllowedAmount,
            ab.InsurancePayment,
            ab.InsuranceAdjustment,
            ab.PatientPaidAmount,
            ab.PatientAdjustment,
            ab.InsuranceBalance,
            ab.PatientBalance,
            ab.TotalBalance
        INTO #ProdFinalStatus
        FROM AggregatedBilling ab
        INNER JOIN EarliestBillDate ebd 
            ON ab.VisitNumber = ebd.VisitNumber AND ab.CPTCode = ebd.CPTCode
        INNER JOIN LISInfo li 
            ON ab.VisitNumber = li.VisitNumber;

        -- Step 3: Classify claim status
        SELECT 
            VisitNumber,
            CPTCode,
          (CASE 
WHEN  SampleResultedDate IS NOT NULL AND FirstBillDate IS NOT NULL AND BilledAmount > 0 AND AllowedAmount  = BilledAmount AND InsurancePayment  = BilledAmount AND InsuranceAdjustment = 0 
AND PatientPaidAmount = 0 AND PatientAdjustment = 0 AND InsuranceBalance = 0 AND PatientBalance = 0 AND TotalBalance = 0 AND DenialCode IS NULL THEN 'Fully Paid' 

WHEN  SampleResultedDate IS NOT NULL AND FirstBillDate IS NOT NULL AND BilledAmount > 0 AND AllowedAmount  = BilledAmount AND InsurancePayment > 0 AND InsuranceAdjustment = 0 
AND PatientPaidAmount = 0 AND PatientAdjustment = 0 AND InsuranceBalance = 0 AND PatientBalance > 0 AND TotalBalance  = PatientBalance AND DenialCode IS NULL THEN 'Fully Paid' 

WHEN  SampleResultedDate IS NOT NULL AND FirstBillDate IS NOT NULL AND BilledAmount > 0 AND AllowedAmount  = BilledAmount AND InsurancePayment > 0 AND InsuranceAdjustment = 0 
AND PatientPaidAmount > 0 AND PatientAdjustment = 0 AND InsuranceBalance = 0 AND PatientBalance = 0 AND TotalBalance = 0 AND DenialCode IS NULL THEN 'Fully Paid' 

WHEN  SampleResultedDate IS NOT NULL AND FirstBillDate IS NOT NULL AND BilledAmount > 0 AND AllowedAmount  = BilledAmount AND InsurancePayment > 0 AND InsuranceAdjustment = 0 
AND PatientPaidAmount = 0 AND PatientAdjustment > 0 AND InsuranceBalance = 0 AND PatientBalance = 0 AND TotalBalance = 0 AND DenialCode IS NULL THEN 'Fully Paid' 

WHEN  SampleResultedDate IS NOT NULL AND FirstBillDate IS NOT NULL AND BilledAmount > 0 AND AllowedAmount > 0 AND InsurancePayment > 0 AND InsuranceAdjustment > 0 
AND PatientPaidAmount = 0 AND PatientAdjustment = 0 AND InsuranceBalance = 0 AND PatientBalance = 0 AND TotalBalance = 0 AND DenialCode IS NULL THEN 'Fully Paid' 

WHEN  SampleResultedDate IS NOT NULL AND FirstBillDate IS NOT NULL AND BilledAmount > 0 AND AllowedAmount > 0 AND InsurancePayment > 0 AND InsuranceAdjustment > 0 
AND PatientPaidAmount = 0 AND PatientAdjustment = 0 AND InsuranceBalance = 0 AND PatientBalance > 0 AND TotalBalance  = PatientBalance AND DenialCode IS NULL THEN 'Fully Paid' 

WHEN  SampleResultedDate IS NOT NULL AND FirstBillDate IS NOT NULL AND BilledAmount > 0 AND AllowedAmount > 0 AND InsurancePayment > 0 AND InsuranceAdjustment > 0 
AND PatientPaidAmount > 0 AND PatientAdjustment = 0 AND InsuranceBalance = 0 AND PatientBalance = 0 AND TotalBalance = 0 AND DenialCode IS NULL THEN 'Fully Paid' 

WHEN  SampleResultedDate IS NOT NULL AND FirstBillDate IS NOT NULL AND BilledAmount > 0 AND AllowedAmount > 0 AND InsurancePayment > 0 AND InsuranceAdjustment > 0 
AND PatientPaidAmount = 0 AND PatientAdjustment > 0 AND InsuranceBalance = 0 AND PatientBalance = 0 AND TotalBalance = 0 AND DenialCode IS NULL THEN 'Fully Paid' 

WHEN  SampleResultedDate IS NOT NULL AND FirstBillDate IS NOT NULL AND BilledAmount > 0 AND AllowedAmount  = BilledAmount AND InsurancePayment = 0 AND InsuranceAdjustment = 0 
AND PatientPaidAmount = 0 AND PatientAdjustment = 0 AND InsuranceBalance = 0 AND PatientBalance  = BilledAmount AND TotalBalance  = BilledAmount AND DenialCode IS NULL THEN 'Patient Responsibility' 

WHEN  SampleResultedDate IS NOT NULL AND FirstBillDate IS NOT NULL AND BilledAmount > 0 AND AllowedAmount  = BilledAmount AND InsurancePayment = 0 AND InsuranceAdjustment = 0 
AND PatientPaidAmount = AllowedAmount AND PatientAdjustment = 0 AND InsuranceBalance = 0 AND PatientBalance = 0 AND TotalBalance = 0 AND DenialCode IS NULL THEN 'Patient Responsibility' 

WHEN  SampleResultedDate IS NOT NULL AND FirstBillDate IS NOT NULL AND BilledAmount > 0 AND AllowedAmount > 0 AND InsurancePayment = 0 AND InsuranceAdjustment > 0 
AND PatientPaidAmount = 0 AND PatientAdjustment = 0 AND InsuranceBalance = 0 AND PatientBalance = AllowedAmount AND TotalBalance = AllowedAmount AND DenialCode IS NULL THEN 'Patient Responsibility' 

WHEN  SampleResultedDate IS NOT NULL AND FirstBillDate IS NOT NULL AND BilledAmount > 0 AND AllowedAmount > 0 AND InsurancePayment = 0 AND InsuranceAdjustment > 0 
AND PatientPaidAmount = AllowedAmount AND PatientAdjustment = 0 AND InsuranceBalance = 0 AND PatientBalance = 0 AND TotalBalance = 0 AND DenialCode IS NULL THEN 'Patient Responsibility' 

WHEN  SampleResultedDate IS NOT NULL AND FirstBillDate IS NOT NULL AND BilledAmount > 0 AND AllowedAmount > 0 AND InsurancePayment = 0 AND InsuranceAdjustment > 0 
AND PatientPaidAmount > 0 AND PatientAdjustment = 0 AND InsuranceBalance = 0 AND PatientBalance = 0 AND TotalBalance = 0 AND DenialCode IS NULL THEN 'Patient Responsibility' 

WHEN  SampleResultedDate IS NOT NULL AND FirstBillDate IS NOT NULL AND BilledAmount > 0 AND AllowedAmount > 0 AND InsurancePayment = 0 AND InsuranceAdjustment > 0 
AND PatientPaidAmount = 0 AND PatientAdjustment = AllowedAmount AND InsuranceBalance = 0 AND PatientBalance = 0 AND TotalBalance = 0 AND DenialCode IS NULL THEN 'Patient WO' 

WHEN  SampleResultedDate IS NOT NULL AND FirstBillDate IS NOT NULL AND BilledAmount > 0 AND AllowedAmount > 0 AND InsurancePayment > 0 AND InsuranceAdjustment > 0 
AND PatientPaidAmount = 0 AND PatientAdjustment = 0 AND InsuranceBalance > 0 AND PatientBalance = 0 AND TotalBalance = InsuranceBalance AND DenialCode IS NULL THEN 'Partially Paid' 

WHEN  SampleResultedDate IS NOT NULL AND FirstBillDate IS NOT NULL AND BilledAmount > 0 AND AllowedAmount > 0 AND InsurancePayment > 0 AND InsuranceAdjustment > 0 
AND PatientPaidAmount = 0 AND PatientAdjustment = 0 AND InsuranceBalance > 0 AND PatientBalance > 0 AND TotalBalance = InsuranceBalance + PatientBalance AND DenialCode IS NULL THEN 'Partially Paid' 

WHEN  SampleResultedDate IS NOT NULL AND FirstBillDate IS NOT NULL AND BilledAmount > 0 AND AllowedAmount > 0 AND InsurancePayment > 0 AND InsuranceAdjustment > 0 
AND PatientPaidAmount > 0 AND PatientAdjustment = 0 AND InsuranceBalance > 0 AND PatientBalance = 0 AND TotalBalance = InsuranceBalance AND DenialCode IS NULL THEN 'Partially Paid' 

WHEN  SampleResultedDate IS NOT NULL AND FirstBillDate IS NOT NULL AND BilledAmount > 0 AND AllowedAmount > 0 AND InsurancePayment > 0 AND InsuranceAdjustment > 0 
AND PatientPaidAmount > 0 AND PatientAdjustment > 0 AND InsuranceBalance > 0 AND PatientBalance = 0 AND TotalBalance = InsuranceBalance AND DenialCode IS NULL THEN 'Partially Paid' 

WHEN  SampleResultedDate IS NOT NULL AND FirstBillDate IS NOT NULL AND BilledAmount > 0 AND AllowedAmount > 0 AND InsurancePayment > 0 AND InsuranceAdjustment = 0 
AND PatientPaidAmount = 0 AND PatientAdjustment = 0 AND InsuranceBalance > 0 AND PatientBalance = 0 AND TotalBalance = InsuranceBalance AND DenialCode IS NULL THEN 'Partially Paid' 

WHEN  SampleResultedDate IS NOT NULL AND FirstBillDate IS NOT NULL AND BilledAmount > 0 AND AllowedAmount > 0 AND InsurancePayment > 0 AND InsuranceAdjustment = 0 
AND PatientPaidAmount = 0 AND PatientAdjustment = 0 AND InsuranceBalance > 0 AND PatientBalance > 0 AND TotalBalance > 0 AND DenialCode IS NULL THEN 'Partially Paid' 

WHEN  SampleResultedDate IS NOT NULL AND FirstBillDate IS NOT NULL AND BilledAmount > 0 AND AllowedAmount > 0 AND InsurancePayment > 0 AND InsuranceAdjustment = 0 
AND PatientPaidAmount > 0 AND PatientAdjustment = 0 AND InsuranceBalance > 0 AND PatientBalance = 0 AND TotalBalance = InsuranceBalance AND DenialCode IS NULL THEN 'Partially Paid' 

WHEN  SampleResultedDate IS NOT NULL AND FirstBillDate IS NOT NULL AND BilledAmount > 0 AND AllowedAmount > 0 AND InsurancePayment > 0 AND InsuranceAdjustment = 0 
AND PatientPaidAmount > 0 AND PatientAdjustment > 0 AND InsuranceBalance > 0 AND PatientBalance = 0 AND TotalBalance = InsuranceBalance AND DenialCode IS NULL THEN 'Partially Paid' 

WHEN  SampleResultedDate IS NOT NULL AND FirstBillDate IS NOT NULL AND BilledAmount = 0 AND AllowedAmount = 0 AND InsurancePayment = 0 AND InsuranceAdjustment = 0 
AND PatientPaidAmount = 0 AND PatientAdjustment = 0 AND InsuranceBalance = 0 AND PatientBalance = 0 AND TotalBalance = 0 AND DenialCode IS NULL THEN 'Billed Amount 0' 

WHEN  SampleResultedDate IS NOT NULL AND FirstBillDate IS NOT NULL AND BilledAmount > 0 AND AllowedAmount  = BilledAmount AND InsurancePayment = 0 AND InsuranceAdjustment = 0 
AND PatientPaidAmount = 0 AND PatientAdjustment = 0 AND InsuranceBalance  = BilledAmount AND PatientBalance = 0 AND TotalBalance  = BilledAmount AND DenialCode IS NULL THEN 'No Response from Payer' 

WHEN  SampleResultedDate IS NOT NULL AND FirstBillDate IS NOT NULL AND BilledAmount > 0 AND AllowedAmount = 0 AND InsurancePayment = 0 AND InsuranceAdjustment = 0 
AND PatientPaidAmount = 0 AND PatientAdjustment = 0 AND InsuranceBalance  = BilledAmount AND PatientBalance = 0 AND TotalBalance  = BilledAmount AND DenialCode IS NULL THEN 'No Response from Payer' 

WHEN  SampleResultedDate IS NOT NULL AND FirstBillDate IS NOT NULL AND BilledAmount > 0 AND AllowedAmount > 0 AND InsurancePayment = 0 AND InsuranceAdjustment = 0 
AND PatientPaidAmount = 0 AND PatientAdjustment = 0 AND InsuranceBalance  = BilledAmount AND PatientBalance = 0 AND TotalBalance  = BilledAmount AND DenialCode IS NULL THEN 'No Response from Payer' 

WHEN  SampleResultedDate IS NOT NULL AND FirstBillDate IS NOT NULL AND BilledAmount > 0 AND AllowedAmount  = BilledAmount AND InsurancePayment = 0 AND InsuranceAdjustment = 0 
AND PatientPaidAmount = 0 AND PatientAdjustment = 0 AND InsuranceBalance  = BilledAmount AND PatientBalance = 0 AND TotalBalance  = BilledAmount AND DenialCode IS NOT NULL THEN 'Fully Denied' 

WHEN  SampleResultedDate IS NOT NULL AND FirstBillDate IS NOT NULL AND BilledAmount > 0 AND AllowedAmount = 0 AND InsurancePayment = 0 AND InsuranceAdjustment = 0 
AND PatientPaidAmount = 0 AND PatientAdjustment = 0 AND InsuranceBalance  = BilledAmount AND PatientBalance = 0 AND TotalBalance  = BilledAmount AND DenialCode IS NOT NULL THEN 'Fully Denied' 

WHEN  SampleResultedDate IS NOT NULL AND FirstBillDate IS NOT NULL AND BilledAmount > 0 AND AllowedAmount = 0 AND InsurancePayment = 0 AND InsuranceAdjustment > 0 
AND PatientPaidAmount = 0 AND PatientAdjustment = 0 AND InsuranceBalance > 0 AND PatientBalance = 0 AND TotalBalance = InsuranceBalance AND DenialCode IS NOT NULL THEN 'Partial Denied' 

WHEN  SampleResultedDate IS NOT NULL AND FirstBillDate IS NOT NULL AND BilledAmount > 0 AND AllowedAmount  = BilledAmount AND InsurancePayment = 0 AND InsuranceAdjustment  = BilledAmount 
AND PatientPaidAmount = 0 AND PatientAdjustment = 0 AND InsuranceBalance = 0 AND PatientBalance = 0 AND TotalBalance = 0 AND DenialCode IS NULL THEN 'Fully Adjusted' 

WHEN  SampleResultedDate IS NOT NULL AND FirstBillDate IS NOT NULL AND BilledAmount > 0 AND AllowedAmount = 0 AND InsurancePayment = 0 AND InsuranceAdjustment  = BilledAmount 
AND PatientPaidAmount = 0 AND PatientAdjustment = 0 AND InsuranceBalance = 0 AND PatientBalance = 0 AND TotalBalance = 0 AND DenialCode IS NULL THEN 'Fully Adjusted' 

WHEN  SampleResultedDate IS NOT NULL AND FirstBillDate IS NOT NULL AND BilledAmount > 0 AND AllowedAmount > 0 AND InsurancePayment = 0 AND InsuranceAdjustment  = BilledAmount 
AND PatientPaidAmount = 0 AND PatientAdjustment = 0 AND InsuranceBalance = 0 AND PatientBalance = 0 AND TotalBalance = 0 AND DenialCode IS NULL THEN 'Fully Adjusted' 

WHEN  SampleResultedDate IS NOT NULL AND FirstBillDate IS NOT NULL AND BilledAmount > 0 AND AllowedAmount  = BilledAmount AND InsurancePayment = 0 AND InsuranceAdjustment = 0 
AND PatientPaidAmount = 0 AND PatientAdjustment  = BilledAmount AND InsuranceBalance = 0 AND PatientBalance = 0 AND TotalBalance = 0 AND DenialCode IS NULL THEN 'Patient WO' 
ELSE '' END) FinalStatus
        INTO #ClaimStatusTable
        FROM #ProdFinalStatus;

        -- Step 4: Insert final results
        INSERT INTO dbo.ClaimsProdStatus (
            VisitNumber,
            CPTCode,
            SampleResultedDate,
            FirstBillDate,
            BilledAmount,
            AllowedAmount,
            InsurancePayment,
            InsuranceAdjustment,
            PatientPaidAmount,
            PatientAdjustment,
            InsuranceBalance,
            PatientBalance,
            TotalBalance,
            DenialCode,
            FinalStatus
        )
        SELECT 
            PS.VisitNumber,
            PS.CPTCode,
            PS.SampleResultedDate,
            PS.FirstBillDate,
            PS.BilledAmount,
            PS.AllowedAmount,
            PS.InsurancePayment,
            PS.InsuranceAdjustment,
            PS.PatientPaidAmount,
            PS.PatientAdjustment,
            PS.InsuranceBalance,
            PS.PatientBalance,
            PS.TotalBalance,
            PS.DenialCode,
            CS.FinalStatus
        FROM #ProdFinalStatus PS
        LEFT JOIN #ClaimStatusTable CS 
            ON PS.VisitNumber = CS.VisitNumber AND PS.CPTCode = CS.CPTCode;

        -- Step 5: Update BillingMaster with final status
        UPDATE BM
        SET BM.FinalClaimStatus = CP.FinalStatus
        FROM BillingMaster BM
        JOIN ClaimsProdStatus CP 
            ON BM.VisitNumber = CP.VisitNumber AND BM.CPTCode = CP.CPTCode;

        COMMIT TRANSACTION;
    END TRY
    BEGIN CATCH
        IF @@TRANCOUNT > 0
            ROLLBACK TRANSACTION;

        DECLARE @ErrorMessage NVARCHAR(4000) = ERROR_MESSAGE();
        RAISERROR('Error in sp_Process_FinalCalimStatus: %s', 16, 1, @ErrorMessage);
    END CATCH
END
GO
/****** Object:  StoredProcedure [dbo].[sp_Process_FinalCalimStatus_bak_old]******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[sp_Process_FinalCalimStatus_bak_old]
AS
BEGIN
    SET NOCOUNT ON;

    BEGIN TRY
        BEGIN TRAN;

        -- Drop temp tables if exist
        DROP TABLE IF EXISTS #ProductionDetails;
        DROP TABLE IF EXISTS #ClaimFinalStatus;
        DROP TABLE IF EXISTS #VisitClaimStatus;

        -- Step 1: Load production details
        SELECT DISTINCT 
            BM.VisitNumber,
            BM.CPTCode,
            DT.PaymentReasonCode,
            BilledAmount,
            AllowedAmount,
            InsurancePayment,
            PatientPaidAmount,
            InsuranceAdjustment,
            InsuranceBalance,
            PatientBalance,
            BM.TotalBalance,
            BM.PatientAdjustment
        INTO #ProductionDetails
        FROM BillingMaster BM
        LEFT JOIN DenialTrackingMaster DT 
            ON BM.VisitNumber = DT.VisitNumber AND BM.CPTCode = DT.CPTCodes
           
AND (
    PaymentReasonCode IS NOT NULL

    AND NOT (
			';' + PaymentReasonCode + ';' LIKE '%;CO45;%'
		OR	';' + PaymentReasonCode + ';' LIKE '%;CO253;%'
		OR	';' + PaymentReasonCode + ';' LIKE '%;PR1;%'
        OR	';' + PaymentReasonCode + ';' LIKE '%;PR2;%'
        OR	';' + PaymentReasonCode + ';' LIKE '%;PR3;%'
    )
);

        -- Step 2: Determine line item level final status
        SELECT 
            VisitNumber,
            CPTCode,
            dbo.fn_GetLineItemStatus(
                BilledAmount,
                AllowedAmount,
                InsurancePayment,
                PatientPaidAmount,
                InsuranceAdjustment,
                InsuranceBalance,
                PatientBalance,
                TotalBalance,
                PaymentReasonCode
            ) AS FinalStatus
        INTO #ClaimFinalStatus
        FROM #ProductionDetails
        ORDER BY FinalStatus DESC;

        -- Step 3: Populate ClaimsProdStatus table
        TRUNCATE TABLE [ClaimsProdStatus];

        INSERT INTO [dbo].[ClaimsProdStatus]
        (
            VisitNumber, CPTCode, BilledAmount, AllowedAmount, InsurancePayment,
            InsuranceAdjustment, PatientPaidAmount, PatientAdjustment,
            InsuranceBalance, PatientBalance, TotalBalance, DenialCode, FinalStatus
        )
        SELECT 
            cf.VisitNumber,
            cf.CPTCode,
            pd.BilledAmount,
            pd.AllowedAmount,
            pd.InsurancePayment,
            pd.InsuranceAdjustment,
            pd.PatientPaidAmount,
            pd.PatientAdjustment,
            pd.InsuranceBalance,
            pd.PatientBalance,
            pd.TotalBalance,
            pd.PaymentReasonCode,
            cf.FinalStatus
        FROM #ProductionDetails pd
        JOIN #ClaimFinalStatus cf 
            ON pd.VisitNumber = cf.VisitNumber AND pd.CPTCode = cf.CPTCode;

        -- Step 4: Update BillingMaster table
        UPDATE BM
        SET FinalClaimStatus = CF.FinalStatus
        FROM BillingMaster BM
        JOIN #ClaimFinalStatus CF 
            ON BM.VisitNumber = CF.VisitNumber AND BM.CPTCode = CF.CPTCode;

        -- Step 5: Derive claim-level final status
        WITH StatusFlags AS (
            SELECT 
                VisitNumber,
                MAX(CASE WHEN FinalClaimStatus = 'Paid' THEN 1 ELSE 0 END) AS HasPaid,
                MAX(CASE WHEN FinalClaimStatus = 'Patient Responsibility' THEN 1 ELSE 0 END) AS HasPatientResp,
                MAX(CASE WHEN FinalClaimStatus = 'Adjusted' THEN 1 ELSE 0 END) AS HasAdjusted,
                MAX(CASE WHEN FinalClaimStatus = 'Denied' THEN 1 ELSE 0 END) AS HasDenied,
                MAX(CASE WHEN FinalClaimStatus = 'No Response' THEN 1 ELSE 0 END) AS HasNoResponse,
                COUNT(DISTINCT FinalClaimStatus) AS StatusCount
            FROM BillingMaster
            GROUP BY VisitNumber
        )
        SELECT 
            VisitNumber,
            CASE
                WHEN StatusCount = 1 AND HasPaid = 1 THEN 'Fully Paid'
                WHEN StatusCount = 1 AND HasPatientResp = 1 THEN 'Patient Responsibility'
                WHEN StatusCount = 1 AND HasAdjusted = 1 THEN 'Fully Adjusted'
                WHEN StatusCount = 1 AND HasDenied = 1 THEN 'Fully Denied'
                WHEN StatusCount = 1 AND HasNoResponse = 1 THEN 'No Response'
                WHEN HasPaid = 1 THEN 'Partially Paid'
                WHEN HasPatientResp = 1 THEN 'Partial Patient Responsibility'
                WHEN HasAdjusted = 1 THEN 'Partially Denied'
                WHEN HasDenied = 1 AND HasNoResponse = 1 THEN 'Partially Denied'
                ELSE 'Adjudicated'
            END AS ClaimStatus
        INTO #VisitClaimStatus
        FROM StatusFlags;

        -- Step 6: Insert into SampleFinalStatus
        TRUNCATE TABLE SampleFinalStatus;

        INSERT INTO SampleFinalStatus (VisitNumber, FinalStatus)
        SELECT VisitNumber, ClaimStatus
        FROM #VisitClaimStatus
        WHERE ISNULL(ClaimStatus, '') <> '';

        COMMIT; -- Commit the transaction if everything succeeds
    END TRY
    BEGIN CATCH
        ROLLBACK; -- Roll back transaction if any error occurs

        -- Optionally: raise the error back to caller
        THROW;
    END CATCH
END;
GO
/****** Object:  StoredProcedure [dbo].[SP_Process_LISMaster_ByFileId]******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE   PROCEDURE [dbo].[SP_Process_LISMaster_ByFileId]
@FileId INT = NULL
AS
BEGIN
    SET NOCOUNT ON;

    BEGIN TRY
        BEGIN TRANSACTION;

		 update ImportedFiles set FileStatus = 3,ProcessedOn = GETDATE() where ImportedFileID = @FileId; 

drop table if exists #LISmaster;

WITH RankedLIS AS (
    SELECT 
        CAST(UPPER(LIS.AccessionNo) as VARCHAR) AS accessionNO,
        LIS.CollectedDate,
        LIS.ReceivedDate,
        LIS.AccessionedDate,
        LIS.ResultedDate,
        LIS.Outstanding,
        LIS.Turnaround,
        SS.SpecimenStatusId,
        LIS.PatientName,
        CAST(COALESCE(CAST(TRY_CAST(LIS.MemberID AS BIGINT) AS VARCHAR(50)), LIS.MemberID) AS VARCHAR) AS MemberID,
        LIS.RelToInsured,
        LIS.SelfPay,
        LIS.AccountPay,
        LIS.ContractPay,
        CM.ClinicId,
        OPG.OperationGroupID,
        TT.TestTypeId,
        LIS.ScrubSettings,
        LIS.Actions,
        LIS.OrderInfo,
        PG.PanelGroupId,
        LIS.PayerName,
        SS.SpecimenStatusName,
        
        ROW_NUMBER() OVER (
            PARTITION BY LIS.AccessionNo
            ORDER BY 
                -- Prefer non-rejected/cancelled
                CASE WHEN SS.SpecimenStatusName IN ('Rejected', 'Cancelled') THEN 1 ELSE 0 END,
                -- Then by most recent date
                ISNULL(LIS.ResultedDate, LIS.AccessionedDate) DESC,
                ISNULL(LIS.ReceivedDate, LIS.CollectedDate) DESC
        ) AS rn
    FROM LISStaging LIS
    LEFT JOIN SpecimenStatus SS         ON LIS.SpecimenStatus   = SS.SpecimenStatusName
    LEFT JOIN ClinicMaster CM           ON LIS.ClinicName       = CM.ClinicName
    LEFT JOIN OperationsGroupMaster OPG ON LIS.OperationsGroup  = OPG.OperationsGroup
    LEFT JOIN TestTypeMaster TT         ON LIS.TestType         = TT.TestTypeName
    LEFT JOIN PanelGroup PG             ON LIS.OrderInfo        = PG.OrderInfo
	where LIS.ImportedFileID = @FileId OR @FileId IS NULL
          
)

SELECT *
INTO #LISmaster
FROM RankedLIS
WHERE rn = 1


        /*******************************************************************************************
         Step 1: Insert new records from LISStaging to LISMaster 
         - Only insert records where AccessionNo doesn't already exist in LISMaster
         - Filter out records with status 'Cancelled' or 'Rejected'
        ********************************************************************************************/
        INSERT INTO [dbo].[LISMaster] (
            AccessionNo, SampleCollectedDate, SampleReceivedDate, SampleAccessionedDate,
            SampleResultedDate, OutStanding, TurnAround, SampleStatusId, PatientName,
            PrimaryMemberId, RelationshipToInsurance, SelfPay, AccountPay, ContractPay,
            ClinicId, OperationalGroupId, TestTypeId, ScrubSettings, Actions,
            OrderInfo, PanelId, PrimaryPayerName
        )
		select distinct accessionNO,CollectedDate,ReceivedDate,AccessionedDate,ResultedDate,Outstanding,Turnaround,SpecimenStatusId,
		PatientName,MemberID,RelToInsured,SelfPay,AccountPay,ContractPay,ClinicId,OperationGroupID,TestTypeId,ScrubSettings,Actions,
		OrderInfo,PanelGroupId,PayerName from #LISmaster lis where rn = 1
		 and   NOT EXISTS (
              SELECT 1 FROM [dbo].[LISMaster] LM WHERE LM.AccessionNo = lis.AccessionNo
          );
      
        /*******************************************************************************************
         Step 2: Update existing LISMaster records based on LISStaging
         - Skip 'Cancelled' or 'Rejected'
        ********************************************************************************************/
        UPDATE LIS
        SET 
            SampleCollectedDate     = LISS.CollectedDate,
            SampleReceivedDate      = LISS.ReceivedDate,
            SampleAccessionedDate   = LISS.AccessionedDate,
            SampleResultedDate      = LISS.ResultedDate,
            OutStanding             = LISS.OutStanding,
            TurnAround              = LISS.TurnAround,
            SampleStatusId          = LISS.SpecimenStatusId,
            PatientName             = LISS.PatientName,
            PrimaryMemberId         = LISS.MemberID,
            RelationshipToInsurance = LISS.RelToInsured,
            SelfPay                 = LISS.SelfPay,
            AccountPay              = LISS.AccountPay,
            ContractPay             = LISS.ContractPay,
            ClinicId                = LISS.ClinicId,
            OperationalGroupId      = LISS.OperationGroupID,
            TestTypeId              = LISS.TestTypeId,
            ScrubSettings           = LISS.ScrubSettings,
            Actions                 = LISS.Actions,
            OrderInfo               = LISS.OrderInfo,
            PanelId                 = LISS.PanelGroupId,
            PrimaryPayerName        = LISS.PayerName
        FROM [dbo].[LISMaster] LIS
        JOIN #LISmaster LISS                ON LIS.AccessionNo     = LISS.AccessionNo



        /*******************************************************************************************
         Step 4b: Derive ResultedStatus, BillingStatus, SubStatus, etc.
        ********************************************************************************************/
      UPDATE [dbo].[LISMaster]
SET 
    ResultedStatus = CASE 
        WHEN SampleResultedDate IS NULL THEN 'Not Resulted'
        ELSE 'Resulted'
    END,

    BillingStatus = CASE 
        WHEN FirstBilledDate IS NULL THEN 'Not Billed'
        WHEN FirstBilledDate IS NOT NULL AND ChargeEntryDate IS NOT NULL THEN 'Billed'
        ELSE 'Billed'
    END,

    BillingSubStatus = CASE 
        WHEN FirstBilledDate IS NOT NULL THEN 'Claim Submitted'
        WHEN FirstBilledDate IS NULL AND ChargeEntryDate IS NOT NULL THEN 'Charge Entered in AMD'
        WHEN SampleResultedDate IS NOT NULL AND FirstBilledDate IS NULL AND ChargeEntryDate IS NULL THEN 'Resulted Yet to Billed'
        WHEN SampleResultedDate IS NULL AND FirstBilledDate IS NULL AND ChargeEntryDate IS NULL THEN 'Yet to be Resulted'
        ELSE ''
    END,

    BilledTo = CASE 
        WHEN SelfPay = 'TRUE' AND ISNULL(LTRIM(RTRIM(PrimaryPayerName)), '') = '' THEN 'Self Pay'
        WHEN AccountPay = 'TRUE' THEN 'Client Bill'
        ELSE 'Insurance'
    END,

    DaystoReceive = DATEDIFF(DAY, SampleCollectedDate, SampleReceivedDate),
    DaystoResult  = DATEDIFF(DAY, SampleReceivedDate, SampleResultedDate),
    DaystoBill    = DATEDIFF(DAY, SampleResultedDate, FirstBilledDate);


       
	 update ImportedFiles set FileStatus = 1,ProcessedOn = GETDATE() where ImportedFileID = @FileId; 

        -- Commit the transaction if all steps succeed
        COMMIT TRANSACTION;
    END TRY
    BEGIN CATCH
        -- Rollback on error
        IF @@TRANCOUNT > 0
            ROLLBACK TRANSACTION;

        -- Optionally log or throw the error
        DECLARE @ErrorMessage NVARCHAR(4000) = ERROR_MESSAGE();
		
		update ImportedFiles set FileStatus = 2,ProcessedOn = GETDATE() where ImportedFileID = @FileId; 

        RAISERROR('Error in SP_Process_LISMaster_From_Staging: %s', 16, 1, @ErrorMessage);
    END CATCH
END
GO
/****** Object:  StoredProcedure [dbo].[SP_Process_LISMaster_From_Staging]******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE   PROCEDURE [dbo].[SP_Process_LISMaster_From_Staging]
@LISFileId varchar(20) = NULL,@VAAFileID varchar(20) = NULL,@CutomCollectionFileID varchar(20) = NULL,@BllingSheetFileID varchar(20) = NULL
AS
BEGIN
    SET NOCOUNT ON;

    BEGIN TRY
        BEGIN TRANSACTION;

		 SELECT CAST(value AS INT) FileId INTO #LISFiles FROM STRING_SPLIT(@LISFileId, ',');

		 SELECT CAST(value AS INT) FileId INTO #VAAFiles FROM STRING_SPLIT(@VAAFileID, ',');

		 SELECT CAST(value AS INT) FileId INTO #CollectionFiles FROM STRING_SPLIT(@CutomCollectionFileID, ',');

		 SELECT CAST(value AS INT) FileId INTO #BillingFiles FROM STRING_SPLIT(@BllingSheetFileID, ',');

		 
drop table if exists #LISmaster;

WITH RankedLIS AS (
    SELECT 
        CAST(UPPER(LIS.AccessionNo) as VARCHAR) AS accessionNO,
        LIS.CollectedDate,
        LIS.ReceivedDate,
        LIS.AccessionedDate,
        LIS.ResultedDate,
        LIS.Outstanding,
        LIS.Turnaround,
        SS.SpecimenStatusId,
        LIS.PatientName,
        CAST(COALESCE(CAST(TRY_CAST(LIS.MemberID AS BIGINT) AS VARCHAR(50)), LIS.MemberID) AS VARCHAR) AS MemberID,
        LIS.RelToInsured,
        LIS.SelfPay,
        LIS.AccountPay,
        LIS.ContractPay,
        CM.ClinicId,
        OPG.OperationGroupID,
        TT.TestTypeId,
        LIS.ScrubSettings,
        LIS.Actions,
        LIS.OrderInfo,
        PG.PanelGroupId,
        LIS.PayerName,
        SS.SpecimenStatusName,
        
        ROW_NUMBER() OVER (
            PARTITION BY LIS.AccessionNo
            ORDER BY 
                -- Prefer non-rejected/cancelled
                CASE WHEN SS.SpecimenStatusName IN ('Rejected', 'Cancelled') THEN 1 ELSE 0 END,
                -- Then by most recent date
                ISNULL(LIS.ResultedDate, LIS.AccessionedDate) DESC,
                ISNULL(LIS.ReceivedDate, LIS.CollectedDate) DESC
        ) AS rn
    FROM LISStaging LIS
    LEFT JOIN SpecimenStatus SS         ON LIS.SpecimenStatus   = SS.SpecimenStatusName
    LEFT JOIN ClinicMaster CM           ON LIS.ClinicName       = CM.ClinicName
    LEFT JOIN OperationsGroupMaster OPG ON LIS.OperationsGroup  = OPG.OperationsGroup
    LEFT JOIN TestTypeMaster TT         ON LIS.TestType         = TT.TestTypeName
    LEFT JOIN PanelGroup PG             ON LIS.OrderInfo        = PG.OrderInfo
	where (LIS.ImportedFileID IN (SELECT FileId FROM #LISFiles) OR @LISFileId IS NULL)
          
)

SELECT *
INTO #LISmaster
FROM RankedLIS
WHERE rn = 1


        /*******************************************************************************************
         Step 1: Insert new records from LISStaging to LISMaster 
         - Only insert records where AccessionNo doesn't already exist in LISMaster
         - Filter out records with status 'Cancelled' or 'Rejected'
        ********************************************************************************************/
        INSERT INTO [dbo].[LISMaster] (
            AccessionNo, SampleCollectedDate, SampleReceivedDate, SampleAccessionedDate,
            SampleResultedDate, OutStanding, TurnAround, SampleStatusId, PatientName,
            PrimaryMemberId, RelationshipToInsurance, SelfPay, AccountPay, ContractPay,
            ClinicId, OperationalGroupId, TestTypeId, ScrubSettings, Actions,
            OrderInfo, PanelId, PrimaryPayerName
        )
		select distinct accessionNO,CollectedDate,ReceivedDate,AccessionedDate,ResultedDate,Outstanding,Turnaround,SpecimenStatusId,
		PatientName,MemberID,RelToInsured,SelfPay,AccountPay,ContractPay,ClinicId,OperationGroupID,TestTypeId,ScrubSettings,Actions,
		OrderInfo,PanelGroupId,PayerName from #LISmaster lis where rn = 1
		 and   NOT EXISTS (
              SELECT 1 FROM [dbo].[LISMaster] LM WHERE LM.AccessionNo = lis.AccessionNo
          );
      
        /*******************************************************************************************
         Step 2: Update existing LISMaster records based on LISStaging
         - Skip 'Cancelled' or 'Rejected'
        ********************************************************************************************/
        UPDATE LIS
        SET 
            SampleCollectedDate     = LISS.CollectedDate,
            SampleReceivedDate      = LISS.ReceivedDate,
            SampleAccessionedDate   = LISS.AccessionedDate,
            SampleResultedDate      = LISS.ResultedDate,
            OutStanding             = LISS.OutStanding,
            TurnAround              = LISS.TurnAround,
            SampleStatusId          = LISS.SpecimenStatusId,
            PatientName             = LISS.PatientName,
            PrimaryMemberId         = LISS.MemberID,
            RelationshipToInsurance = LISS.RelToInsured,
            SelfPay                 = LISS.SelfPay,
            AccountPay              = LISS.AccountPay,
            ContractPay             = LISS.ContractPay,
            ClinicId                = LISS.ClinicId,
            OperationalGroupId      = LISS.OperationGroupID,
            TestTypeId              = LISS.TestTypeId,
            ScrubSettings           = LISS.ScrubSettings,
            Actions                 = LISS.Actions,
            OrderInfo               = LISS.OrderInfo,
            PanelId                 = LISS.PanelGroupId,
            PrimaryPayerName        = LISS.PayerName
        FROM [dbo].[LISMaster] LIS
        JOIN #LISmaster LISS                ON LIS.AccessionNo     = LISS.AccessionNo

        /*******************************************************************************************
         Step 3: Prepare enriched patient and billing data
         - Rank by service date to keep only latest per accession
        ********************************************************************************************/
        DROP TABLE IF EXISTS #SampleCollectionData;

        WITH RankedData AS (
            SELECT 
                LIS.AccessionNo,
                LAB.LabID,
                BPM.BillingProviderID,
                CCS.PatientID,
                CCS.DOB,
                CCS.ResponsibleParty,
                PT.PayerTypeId,
                VAA.VisitNumber,
                CCS.ICD10Code,
                CCS.LastBillDate,
                CCS.ChargeEntryDate,
                RP.ReferingProviderId,
                ROW_NUMBER() OVER (PARTITION BY LIS.AccessionNo ORDER BY VAA.EntryDate) AS RowNum
            FROM [dbo].[LISMaster] LIS
            LEFT JOIN VisitAgaistAccessionStaging VAA    ON LIS.AccessionNo     = VAA.AccessionNo  AND (VAA.ImportedFileID IN (SELECT FileId FROM #VAAFiles) OR @VAAFileID IS NULL)
            LEFT JOIN CustomCollectionStaging CCS        ON VAA.VisitNumber     = CCS.VisitNumber AND (CCS.ImportedFileID IN (SELECT FileId FROM #CollectionFiles) OR @CutomCollectionFileID IS NULL) 
            LEFT JOIN LabMaster LAB                      ON CCS.PerformingLab   = LAB.LabName
            LEFT JOIN BillingProviderMaster BPM          ON CCS.BillingProvider = BPM.BillingProvider
            LEFT JOIN PayerTypeMaster PT                 ON CCS.PayerType       = PT.PayerType
            LEFT JOIN ReferringProviderMaster RP         ON CCS.ReferringProvider = RP.ReferringProviderName
        )
        SELECT *
        INTO #SampleCollectionData
        FROM RankedData
        WHERE RowNum = 1;

        /*******************************************************************************************
         Step 4a: Update LISMaster with enriched patient/billing data
        ********************************************************************************************/
        UPDATE LIS
        SET 
            LabId               = SCD.LabID,
            BillingProviderID   = SCD.BillingProviderID,
            PatientID           = SCD.PatientID,
            PatientDOB          = SCD.DOB,
            ResponsibleParty    = SCD.ResponsibleParty,
            VisitNumber         = SCD.VisitNumber,
            ICD10Code           = SCD.ICD10Code,
            ReferringProviderId = SCD.ReferingProviderId,
            PayerTypeId         = SCD.PayerTypeId,
            FirstBilledDate      = SCD.LastBillDate,
            ChargeEntryDate     = SCD.ChargeEntryDate
        FROM [dbo].[LISMaster] LIS
        JOIN #SampleCollectionData SCD ON LIS.AccessionNo = SCD.AccessionNo;

        /*******************************************************************************************
         Step 4b: Derive ResultedStatus, BillingStatus, SubStatus, etc.
        ********************************************************************************************/
      UPDATE [dbo].[LISMaster]
SET 
    ResultedStatus = CASE 
        WHEN SampleResultedDate IS NULL THEN 'Not Resulted'
        ELSE 'Resulted'
    END,

    BillingStatus = CASE 
        WHEN FirstBilledDate IS NULL THEN 'Not Billed'
        WHEN FirstBilledDate IS NOT NULL AND ChargeEntryDate IS NOT NULL THEN 'Billed'
        ELSE 'Billed'
    END,

    BillingSubStatus = CASE 
        WHEN FirstBilledDate IS NOT NULL THEN 'Claim Submitted'
        WHEN FirstBilledDate IS NULL AND ChargeEntryDate IS NOT NULL THEN 'Charge Entered in AMD'
        WHEN SampleResultedDate IS NOT NULL AND FirstBilledDate IS NULL AND ChargeEntryDate IS NULL THEN 'Resulted Yet to Billed'
        WHEN SampleResultedDate IS NULL AND FirstBilledDate IS NULL AND ChargeEntryDate IS NULL THEN 'Yet to be Resulted'
        ELSE ''
    END,

    BilledTo = CASE 
        WHEN SelfPay = 'TRUE' AND ISNULL(LTRIM(RTRIM(PrimaryPayerName)), '') = '' THEN 'Self Pay'
        WHEN AccountPay = 'TRUE' THEN 'Client Bill'
        ELSE 'Insurance'
    END,

    DaystoReceive = DATEDIFF(DAY, SampleCollectedDate, SampleReceivedDate),
    DaystoResult  = DATEDIFF(DAY, SampleReceivedDate, SampleResultedDate),
    DaystoBill    = DATEDIFF(DAY, SampleResultedDate, FirstBilledDate);


        /*******************************************************************************************
         Step 4c: Update ClientStatus from PrismBillingStaging
        ********************************************************************************************/
		WITH CTE_SheetLogic AS (
    SELECT DISTINCT SpecimenID, LTRIM(RTRIM(SheetName)) AS SheetName
    FROM PrismBillingStaging
    WHERE SpecimenID IS NOT NULL
      AND LTRIM(RTRIM(SheetName)) IN (
        'To Bill', 'Medicare On Hold', 'MO Medicaid On Hold', 
        'Missing Info', 'PGX', 'Paid', 'Billed'
    ) AND (ImportedFileID IN (SELECT FileId FROM #BillingFiles) OR @BllingSheetFileID IS NULL)
	)
	UPDATE LIS
        SET LIS.ClientStatus = 
            CASE 
                WHEN LTRIM(RTRIM(PS.SheetName)) = 'To Bill' THEN 'Current Billing Queue'
                WHEN LTRIM(RTRIM(PS.SheetName)) = 'Medicare On Hold' THEN 'Medicare On Hold'
                WHEN LTRIM(RTRIM(PS.SheetName)) = 'MO Medicaid On Hold' THEN 'MO Medicaid On Hold'
                WHEN LTRIM(RTRIM(PS.SheetName)) = 'Missing Info' THEN 'Missing Information'
                WHEN LTRIM(RTRIM(PS.SheetName)) = 'PGX' THEN 'Pending PGX  Coding / Meds'
				WHEN LTRIM(RTRIM(PS.SheetName)) = 'Paid' THEN ''
				WHEN LTRIM(RTRIM(PS.SheetName)) = 'Billed' THEN ''
                WHEN SampleResultedDate IS NOT NULL 
                     AND ResultedStatus = 'Resulted' 
                     AND SampleStatusId = 3 
                     AND ChargeEntryDate IS NULL 
                     AND FirstBilledDate IS NULL  
                     THEN 'Billing Review Required'
                ELSE PS.SheetName
            END
        FROM LISMaster LIS
        JOIN CTE_SheetLogic PS ON LIS.AccessionNo = PS.SpecimenID;

        -- Commit the transaction if all steps succeed
        COMMIT TRANSACTION;
    END TRY
    BEGIN CATCH
        -- Rollback on error
        IF @@TRANCOUNT > 0
            ROLLBACK TRANSACTION;

        -- Optionally log or throw the error
        DECLARE @ErrorMessage NVARCHAR(4000) = ERROR_MESSAGE();
        RAISERROR('Error in SP_Process_LISMaster_From_Staging: %s', 16, 1, @ErrorMessage);
    END CATCH
END
GO
/****** Object:  StoredProcedure [dbo].[Sp_Process_LISOrderStaging]******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE   PROCEDURE [dbo].[Sp_Process_LISOrderStaging]
@FileId INT = NULL
AS
BEGIN
    SET NOCOUNT ON;

	update ImportedFiles set FileStatus = 3,ProcessedOn = GETDATE() where ImportedFileID = @FileId;

	    BEGIN TRY
        BEGIN TRANSACTION;

		DROP TABLE IF EXISTS #LISStage;

		SELECT DISTINCT OrderID,Tests,Results INTO #LISStage FROM DiagnoseLISStaging WHERE (ImportedFileID = @FileID OR @FileId = NULL)

		INSERT INTO LISMaster(AccessionNo,Tests,Results,LISFile,OrderInfo)
		SELECT OrderID,Tests,Results,'NEW LIS',Tests FROM #LISStage WHERE OrderID NOT IN (SELECT AccessionNo FROM LISMaster)

		UPDATE LIS SET LIS.Results = LST.Results,LIS.Tests = LST.Tests,LISFile = 'NEW LIS' FROM LISMaster LIS
		JOIN #LISStage LST ON LIS.AccessionNo = LST.OrderID

		update ImportedFiles set FileStatus = 1,ProcessedOn = GETDATE() where ImportedFileID = @FileId;

			EXEC [SP_UpdateLIS_Statuses];

        COMMIT TRANSACTION;
    END TRY
    BEGIN CATCH
        ROLLBACK TRANSACTION;
        PRINT 'Error during MERGE: ' + ERROR_MESSAGE();
			update ImportedFiles set FileStatus = 2,ProcessedOn = GETDATE() where ImportedFileID = @FileId;
    END CATCH;
END;
GO
/****** Object:  StoredProcedure [dbo].[Sp_Process_LISSample_Report]******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE   PROCEDURE [dbo].[Sp_Process_LISSample_Report]
@FileId INT = NULL
AS
BEGIN
    SET NOCOUNT ON;

	update ImportedFiles set FileStatus = 3,ProcessedOn = GETDATE() where ImportedFileID = @FileId;

	    BEGIN TRY
        BEGIN TRANSACTION;

	
INSERT INTO [dbo].[TestTypeMaster]([TestTypeName],[IsActive])
SELECT DISTINCT LTRIM(RTRIM(Specimen)),1 FROM DiagnoseLISStaging 
WHERE LTRIM(RTRIM(Specimen)) NOT IN (SELECT DISTINCT [TestTypeName] FROM [TestTypeMaster]) AND Specimen IS NOT NULL AND  ImportedFileID = @FileId

INSERT INTO [dbo].PayerTypeMaster(PayerType,[IsActive])
SELECT DISTINCT LTRIM(RTRIM(PaymentMethod)),1 FROM DiagnoseLISStaging 
WHERE LTRIM(RTRIM(PaymentMethod)) NOT IN (SELECT DISTINCT PayerType FROM PayerTypeMaster) AND PaymentMethod IS NOT NULL AND  ImportedFileID = @FileId

INSERT INTO [dbo].[SpecimenStatus]([SpecimenStatusName],[IsActive])
SELECT DISTINCT LTRIM(RTRIM(SpecimenStatus)),1 FROM DiagnoseLISStaging 
WHERE LTRIM(RTRIM(SpecimenStatus)) NOT IN (SELECT DISTINCT [SpecimenStatusName] FROM [SpecimenStatus]) AND SpecimenStatus IS NOT NULL AND  ImportedFileID = @FileId

INSERT INTO [dbo].[ClinicMaster]([ClinicName],[ClinicStatus])
SELECT DISTINCT LTRIM(RTRIM(Facility)),1 FROM DiagnoseLISStaging 
WHERE LTRIM(RTRIM(Facility)) NOT IN (SELECT DISTINCT ClinicName FROM [ClinicMaster]) AND Facility IS NOT NULL
AND ImportedFileID = @FileId

INSERT INTO [dbo].LabMaster(LabName,IsActive)
SELECT DISTINCT UPPER(LTRIM(RTRIM(PerformingLaboratory))),1 FROM DiagnoseLISStaging 
WHERE LTRIM(RTRIM(PerformingLaboratory)) NOT IN (SELECT DISTINCT LabName FROM LabMaster) AND PerformingLaboratory IS NOT NULL
AND ImportedFileID = @FileId

INSERT INTO [dbo].ReferringProviderMaster([ReferringProviderName],[IsActive])
SELECT DISTINCT UPPER(LTRIM(RTRIM(ProviderName))),1 FROM DiagnoseLISStaging 
WHERE LTRIM(RTRIM(ProviderName)) NOT IN (SELECT DISTINCT [ReferringProviderName] FROM ReferringProviderMaster) AND ProviderName IS NOT NULL
AND ImportedFileID = @FileId


INSERT INTO SalesPerson(FirstName,LastName,SalesPersonName,ReportingLevelTop,Status)
SELECT DISTINCT UPPER(LTRIM(RTRIM(SalesRep))),UPPER(LTRIM(RTRIM(SalesRep))),UPPER(LTRIM(RTRIM(SalesRep))),0,1 FROM DiagnoseLISStaging 
WHERE LTRIM(RTRIM(SalesRep)) NOT IN (SELECT DISTINCT SalesPersonName FROM SalesPerson) AND SalesRep IS NOT NULL
AND ImportedFileID = @FileId


INSERT INTO [dbo].[InsurancePayerMaster]([PayerName],[IsActive])
SELECT DISTINCT UPPER(LTRIM(RTRIM(PrimaryInsurance))),1 FROM DiagnoseLISStaging 
WHERE LTRIM(RTRIM(PrimaryInsurance)) NOT IN (SELECT DISTINCT [PayerName] FROM [InsurancePayerMaster]) AND PrimaryInsurance IS NOT NULL
AND ImportedFileID = @FileId


DROP TABLE IF EXISTS #DiagnoseLIS;

WITH RankedLIS AS (
SELECT OrderID,PaymentMethod,SampleID,Barcode,Specimen,Container,Collectors,OrderStatus,SpecimenStatus,ShipmentTracking,
DateSubmitted,TimeSubmitted,DateCollected,TimeCollected,DateReceived,TimeReceived,DateReported ResultedDate,TimeReported,Facility,
PerformingLaboratory,Tests,Results,PatientID,PatientFirstName,PatientLastName,PatientDateofBirth,PatientSex,PatientAddress1,
PatientAddress2,PatientCity,PatientState,PatientZipCode,SalesRep,ProviderName,ProviderNPI,PrimaryInsurance,PrimaryInsuranceID,SecondaryInsurance,
SecondaryInsuranceID,ICD10Codes,OrderNotes,SampleNotes,SampleRejectionReason,ROW_NUMBER() OVER (
            PARTITION BY OrderID
            ORDER BY DateCollected 
        ) AS rn
FROM DiagnoseLISStaging WHERE ImportedFileID = @FileId OR @FileId IS NULL
)
SELECT * INTO #DiagnoseLIS FROM RankedLIS WHERE rn = 1;


			INSERT INTO LISMaster(AccessionNo,PayerTypeId,SampleID,Barcode,TestTypeId,Container,Collectors,OrderStatus,SampleStatusId,ShipmentTrackingNo,TimeSubmitted,
			SampleCollectedDate,TimeCollected,SampleReceivedDate,TimeReceived,SampleResultedDate,TimeReported,FacilityId,LabId,Tests,Results,PatientID,
			PatientFirstName,PatientLastName,PatientName,PatientDOB,PatientSex,PatientAddress1,PatientAddress2,PatientCity,PatientState,PatientZipCode,
			SalesPersonId,ReferringProviderId,ProviderNPI,PrimaryPayerName,PrimaryMemberId,SecondaryMemberID,ICD10Code,OrderNotes,SampleNotes,
			SampleRejectionReason,OrderInfo)
			Select OrderID,PT.PayerTypeId,SampleID,Barcode,TT.TestTypeId,Container,Collectors,OrderStatus,SS.SpecimenStatusId,ShipmentTracking,
			TimeSubmitted,DateCollected,TimeCollected,DateReceived,TimeReceived,ResultedDate,TimeReported,CM.ClinicId,LAB.LabID,Tests,Results,
			PatientID,PatientFirstName,PatientLastName,PatientLastName+', '+PatientFirstName,PatientDateofBirth,PatientSex,PatientAddress1,PatientAddress2,
			PatientCity,PatientState,PatientZipCode,SP.SalesPersonID,RPM.ReferingProviderId,ProviderNPI,PrimaryInsurance,PrimaryInsuranceID,
			SecondaryInsuranceID,ICD10Codes,OrderNotes,SampleNotes,SampleRejectionReason,Tests
			From #DiagnoseLIS LIS
			LEFT JOIN PayerTypeMaster PT ON LIS.PaymentMethod = PT.PayerType
			LEFT JOIN TestTypeMaster TT ON LIS.Specimen = TT.TestTypeName
			LEFT JOIN SpecimenStatus SS ON LIS.SpecimenStatus = SS.SpecimenStatusName
			LEFT JOIN ClinicMaster CM ON LIS.Facility = CM.ClinicName
			LEFT JOIN LabMaster LAB ON LIS.PerformingLaboratory = LAB.LabName
			LEFT JOIN SalesPerson SP ON LIS.SalesRep = SP.SalesPersonName
			LEFT JOIN ReferringProviderMaster RPM ON LIS.ProviderName = RPM.ReferringProviderName
			WHERE OrderID NOT IN (SELECT DISTINCT AccessionNo FROM LISMaster)

			-- Update existing LISMaster rows from #DiagnoseLIS using the same lookups as the INSERT
			UPDATE LM
			SET
				LM.PayerTypeId           = PT.PayerTypeId,
				LM.SampleID              = LIS.SampleID,
				LM.Barcode               = LIS.Barcode,
				LM.TestTypeId            = TT.TestTypeId,
				LM.Container             = LIS.Container,
				LM.Collectors            = LIS.Collectors,
				LM.OrderStatus           = LIS.OrderStatus,
				LM.SampleStatusId        = SS.SpecimenStatusId,
				LM.ShipmentTrackingNo    = LIS.ShipmentTracking,
				LM.TimeSubmitted         = LIS.TimeSubmitted,
				LM.SampleCollectedDate   = LIS.DateCollected,
				LM.TimeCollected         = LIS.TimeCollected,
				LM.SampleReceivedDate    = LIS.DateReceived,
				LM.TimeReceived          = LIS.TimeReceived,
				LM.SampleResultedDate    = LIS.ResultedDate,
				LM.TimeReported          = LIS.TimeReported,
				LM.FacilityId            = CM.ClinicId,
				LM.LabId                 = LAB.LabID,
				LM.Tests                 = LIS.Tests,
				LM.Results               = LIS.Results,
				LM.PatientID             = LIS.PatientID,
				LM.PatientFirstName      = LIS.PatientFirstName,
				LM.PatientLastName       = LIS.PatientLastName,
				LM.PatientName           = CONCAT(LIS.PatientLastName, ', ', LIS.PatientFirstName),
				LM.PatientDOB            = LIS.PatientDateofBirth,
				LM.PatientSex            = LIS.PatientSex,
				LM.PatientAddress1       = LIS.PatientAddress1,
				LM.PatientAddress2       = LIS.PatientAddress2,
				LM.PatientCity           = LIS.PatientCity,
				LM.PatientState          = LIS.PatientState,
				LM.PatientZipCode        = LIS.PatientZipCode,
				LM.SalesPersonId         = SP.SalesPersonID,
				LM.ReferringProviderId   = RPM.ReferingProviderId,
				LM.ProviderNPI           = LIS.ProviderNPI,
				LM.PrimaryPayerName      = LIS.PrimaryInsurance,
				LM.PrimaryMemberId       = LIS.PrimaryInsuranceID,
				LM.SecondaryMemberID     = LIS.SecondaryInsuranceID,
				LM.ICD10Code             = LIS.ICD10Codes,
				LM.OrderNotes            = LIS.OrderNotes,
				LM.SampleNotes           = LIS.SampleNotes,
				LM.SampleRejectionReason = LIS.SampleRejectionReason,
				LM.OrderInfo			 = LIS.Tests
			FROM dbo.LISMaster AS LM
			JOIN #DiagnoseLIS     AS LIS ON LIS.OrderID = LM.AccessionNo
			LEFT JOIN dbo.PayerTypeMaster        AS PT  ON LIS.PaymentMethod        = PT.PayerType
			LEFT JOIN dbo.TestTypeMaster         AS TT  ON LIS.Specimen             = TT.TestTypeName
			LEFT JOIN dbo.SpecimenStatus         AS SS  ON LIS.SpecimenStatus       = SS.SpecimenStatusName
			LEFT JOIN dbo.ClinicMaster           AS CM  ON LIS.Facility             = CM.ClinicName
			LEFT JOIN dbo.LabMaster              AS LAB ON LIS.PerformingLaboratory = LAB.LabName
			LEFT JOIN dbo.SalesPerson            AS SP  ON LIS.SalesRep             = SP.SalesPersonName
			LEFT JOIN dbo.ReferringProviderMaster AS RPM ON LIS.ProviderName       = RPM.ReferringProviderName;

			UPDATE LIS SET LIS.PanelId = PanelGroupId FROM LISMaster LIS 
			JOIN PanelGroup PG on LIS.Tests = PG.OrderInfo

			EXEC [SP_UpdateLIS_Statuses];

		update ImportedFiles set FileStatus = 1,ProcessedOn = GETDATE() where ImportedFileID = @FileId;

        COMMIT TRANSACTION;
    END TRY
    BEGIN CATCH
        ROLLBACK TRANSACTION;
        PRINT 'Error during MERGE: ' + ERROR_MESSAGE();
			update ImportedFiles set FileStatus = 2,ProcessedOn = GETDATE() where ImportedFileID = @FileId;
    END CATCH;
END;
GO
/****** Object:  StoredProcedure [dbo].[Sp_Process_PanelMasterStaging]******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[Sp_Process_PanelMasterStaging]
@FileId INT = NULL 
AS
BEGIN
    SET NOCOUNT ON;

	update ImportedFiles set FileStatus = 3,ProcessedOn = GETDATE() where ImportedFileID = @FileId;

	    BEGIN TRY
        BEGIN TRANSACTION;

		IF OBJECT_ID('tempdb..#PanelDetail', 'U') IS NOT NULL
			DROP TABLE #PanelDetail;

		SELECT DISTINCT
			PanelName = LTRIM(RTRIM(PanelName)),
			OrderInfo,
			PanelCategory
		INTO #PanelDetail
		FROM PanelMasterStaging
		WHERE (@FileId IS NULL OR ImportedFileID = @FileId);


		INSERT INTO PanelGroup (PanelName, OrderInfo, PanelCategory)
		SELECT d.PanelName,LTRIM(RTRIM(ISNULL(d.OrderInfo,d.PanelCategory))),LTRIM(RTRIM(d.PanelCategory))
		FROM #PanelDetail d
		LEFT JOIN PanelGroup pg
			ON LTRIM(RTRIM(pg.OrderInfo)) = LTRIM(RTRIM(d.OrderInfo))
		WHERE pg.OrderInfo IS NULL;

		UPDATE pg
		SET
			pg.PanelName     = LTRIM(RTRIM(d.PanelName)),
			pg.PanelCategory = LTRIM(RTRIM(d.PanelCategory))
		FROM PanelGroup pg
		JOIN #PanelDetail d
			ON LTRIM(RTRIM(d.OrderInfo)) = LTRIM(RTRIM(pg.OrderInfo))
		WHERE
			ISNULL(pg.PanelName, '')     <> ISNULL(d.PanelName, '')
			OR ISNULL(pg.PanelCategory,'') <> ISNULL(d.PanelCategory,'');


		update ImportedFiles set FileStatus = 1,ProcessedOn = GETDATE() where ImportedFileID = @FileId;

        COMMIT TRANSACTION;
    END TRY
    BEGIN CATCH
        ROLLBACK TRANSACTION;
        PRINT 'Error during MERGE: ' + ERROR_MESSAGE();
			update ImportedFiles set FileStatus = 2,ProcessedOn = GETDATE() where ImportedFileID = @FileId;
    END CATCH;
END;
GO
/****** Object:  StoredProcedure [dbo].[Sp_Process_VAA_ByFileId]******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[Sp_Process_VAA_ByFileId]
    @FileId INT = NULL
AS
BEGIN
    SET NOCOUNT ON;

    BEGIN TRY
        BEGIN TRANSACTION;

		update ImportedFiles set FileStatus = 3,ProcessedOn = GETDATE() where ImportedFileID = @FileId; 

        -- Drop temp table if exists
        DROP TABLE IF EXISTS #VAATemp;

        ---- Prepare temp data with distinct AccessionNo
        --WITH CTE_VAA AS
        --(
        --    SELECT 
        --        VisitNumber,
        --        AccessionNo,
        --        EntryDate AS DateOfEntry,
        --        ServiceDate,
        --        ROW_NUMBER() OVER (PARTITION BY AccessionNo ORDER BY EntryDate) AS RowNum
        --    FROM VisitAgaistAccessionStaging  
        --    WHERE (ImportedFileID = @FileId OR @FileId is Null) and AccessionNo is not null AND VisitNumber is not null
        --)
        --SELECT 
        --    VisitNumber,
        --    AccessionNo,
        --    DateOfEntry,
        --    ServiceDate
        --INTO #VAATemp 
        --FROM CTE_VAA 
        --WHERE RowNum = 1;

		DELETE FROM VAAMaster WHERE VisitNumber IN (SELECT DISTINCT VisitNumber FROM VisitAgaistAccessionStaging WHERE  ImportedFileID = @FileId)
		
		--DBCC CHECKIDENT ('VAAMaster', RESEED, 0);

        -- Insert new records into VAAMaster if not exists
        INSERT INTO VAAMaster (VisitNumber, AccessionNo, DateOfEntry, ServiceDate)
		SELECT DISTINCT VisitNumber,AccessionNo,EntryDate,ServiceDate FROM VisitAgaistAccessionStaging WHERE  ImportedFileID = @FileId
        --SELECT 
        --    t.VisitNumber,
        --    t.AccessionNo,
        --    t.DateOfEntry,
        --    t.ServiceDate
        --FROM #VAATemp t
        --WHERE NOT EXISTS (
        --    SELECT 1 
        --    FROM VAAMaster v
        --    WHERE 
        --        v.VisitNumber = t.VisitNumber AND 
        --        v.AccessionNo = t.AccessionNo AND
        --        v.DateOfEntry = t.DateOfEntry AND
        --        v.ServiceDate = t.ServiceDate
        --);

		EXEC SP_ProcessVAAvsLIS;

        -- Update the file status
        UPDATE ImportedFiles
        SET FileStatus = 1,ProcessedOn = GETDATE()   -- Adjust value to your desired status
        WHERE ImportedFileID = @FileId;



        COMMIT TRANSACTION;
    END TRY
    BEGIN CATCH
        -- Rollback on error
        IF @@TRANCOUNT > 0
            ROLLBACK TRANSACTION;
		UPDATE ImportedFiles
        SET FileStatus = 2 ,ProcessedOn = GETDATE() -- Adjust value to your desired status
        WHERE ImportedFileID = @FileId;
        -- Optionally log the error
        DECLARE @ErrMsg NVARCHAR(4000), @ErrSeverity INT, @ErrState INT;
        SELECT 
            @ErrMsg = ERROR_MESSAGE(),
            @ErrSeverity = ERROR_SEVERITY(),
            @ErrState = ERROR_STATE();

        RAISERROR(@ErrMsg, @ErrSeverity, @ErrState);
    END CATCH
END;
GO
/****** Object:  StoredProcedure [dbo].[Sp_ProcessBillingMasterData]******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE PROCEDURE [dbo].[Sp_ProcessBillingMasterData]
@FileId INT = NULL
AS
BEGIN
    SET NOCOUNT ON;

	update ImportedFiles set FileStatus = 3,ProcessedOn = GETDATE() where ImportedFileID = @FileId;

	    BEGIN TRY
        BEGIN TRANSACTION;

		EXEC [Sp_ProcessTransactionDetails] ;
	

		EXEC BillingMasterProcess_Proc @FileId;


		update ImportedFiles set FileStatus = 1,ProcessedOn = GETDATE() where ImportedFileID = @FileId;

        COMMIT TRANSACTION;
    END TRY
    BEGIN CATCH
        ROLLBACK TRANSACTION;
        PRINT 'Error during MERGE: ' + ERROR_MESSAGE();
			update ImportedFiles set FileStatus = 2,ProcessedOn = GETDATE() where ImportedFileID = @FileId;
    END CATCH;
END;
GO
/****** Object:  StoredProcedure [dbo].[Sp_ProcessDenialTrackingMaster]******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[Sp_ProcessDenialTrackingMaster]
@FileId int = NULL
AS
BEGIN
    SET NOCOUNT ON;

    BEGIN TRY
		update ImportedFiles set FileStatus = 3,ProcessedOn = GETDATE()  where ImportedFileID = @FileId;

        -- Drop temp table if exists
        DROP TABLE IF EXISTS #DenialTrackingDetail;

        -- Load unique records into a temp table
        SELECT DISTINCT  
            DTM.VisitNumber,
            LTRIM(RTRIM(SUBSTRING(DTM.ChargeCode, 1, 5))) AS CPTCode,
            DTM.TransactionCarrierCode,
            DTM.PaymentDate,
            DTM.PaymentReasonCode,
            DTM.ServiceDate,
            DTM.Charge,
            DTM.TotalBalance,
            DTM.TotalAdjustment,
            DTM.ReasonAmount,
            DTM.DenialUser,
            DTM.LastAction,
            DTM.NextAction,
            DTM.LastActionDate,
            DTM.NextActionDate,
            DTM.Note,
            DTM.DenialCategoryCode,
            DTM.DenialCategoryDescription
        INTO #DenialTrackingDetail
        FROM DenialTrackingStaging DTM WHERE (ImportedFileID = @FileId OR @FileId IS NULL);

        
        
		Truncate table DenialTrackingMaster;
       
            INSERT into DenialTrackingMaster (
                [LISMasterID],
                [VisitNumber],
                [CPTCodes],
                [TransactionCarrierCode],
                [PaymentDate],
                [PaymentReasonCode],
                [DateOfService],
                [ChargeAmount],
                [TotalBalance],
                [TotalAdjustment],
                [ReasonAmount],
                [DenailUser],
                [LastAction],
                [NextAction],
                [LastActionDate],
                [NextActionDate],
                [Note],
                [DenialCategoryCode],
                [DenialCategoryDEscription]
            )
         SELECT LISMasterId,dt.VisitNumber,CPTCode,TransactionCarrierCode,PaymentDate,PaymentReasonCode,ServiceDate,dt.Charge,TotalBalance,
		 TotalAdjustment,ReasonAmount,DenialUser,LastAction,LastActionDate,NextAction,NextActionDate,Note,DenialCategoryCode,DenialCategoryDescription
		 From #DenialTrackingDetail dt left join LISMaster lis on dt.VisitNumber = lis.VisitNumber


		 EXEC sp_InsertClaimDenialCode;
		 EXEC sp_ClaimLevelStatusUpdate;
		update ImportedFiles set FileStatus = 1,ProcessedOn = GETDATE()  where ImportedFileID = @FileId;
    END TRY
    BEGIN CATCH
        DECLARE @ErrorMessage NVARCHAR(4000), @ErrorSeverity INT, @ErrorState INT;
        SELECT 
            @ErrorMessage = ERROR_MESSAGE(), 
            @ErrorSeverity = ERROR_SEVERITY(), 
            @ErrorState = ERROR_STATE();

			update ImportedFiles set FileStatus = 2,ProcessedOn = GETDATE()  where ImportedFileID = @FileId;

        RAISERROR (@ErrorMessage, @ErrorSeverity, @ErrorState);
    END CATCH
END
GO
/****** Object:  StoredProcedure [dbo].[Sp_ProcessTransactionDetails]******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- Create stored procedure
CREATE PROCEDURE [dbo].[Sp_ProcessTransactionDetails]
@FileId INT = NULL
AS
BEGIN
    SET NOCOUNT ON;

    BEGIN TRY
        BEGIN TRANSACTION;

		update ImportedFiles set FileStatus = 3,ProcessedOn = GETDATE()  where ImportedFileID = @FileId;

        -- Drop temp table if exists
       DROP TABLE if exists #TransacionnDetailTemp;
			DROP TABLE if exists #AggregatedTemp;

        -- Step 1: Create temp table from staging and LISMaster
        SELECT DISTINCT 
            LabIdentityKey,
            TDS.TransactionType,
            TDS.ChartNumber,
            TDS.VisitNo,
            TDS.ChargeCode,
            TDS.TransactionCodeDesc,
            TDS.Modifiers,
            TDS.VisitPrimaryCarrier,
            TDS.VisitSecondaryCarrier,
            TDS.PrimaryDxICD10,
            TDS.PrimaryDxICD9,
            TDS.PaymentMethod,
            TDS.CheckNumber,
            TDS.Void,
            TDS.Units,
            TDS.TotalBilledAmount,
            TDS.PatientPaidAmount,
            TDS.InsurancePaidAmount,
            TDS.TotalPaidAmount,
            TDS.AdjustmentAmount,
			TDS.DateofDeposit,
			TDS.DateofEntry,
			TDS.DateofService
        INTO #TransacionnDetailTemp
        FROM TransactionDetailStaging TDS 
		WHERE Void IS NULL AND (TDS.ImportedFileID = @FileId OR @FileId IS NULL)
		AND VisitNo IS NOT NULL;
		



        ------------------------------------------------------------
        -- Step 2: UPDATE existing records

            SELECT 
                TT.LabIdentityKey,
                TT.TransactionType,
                TT.ChartNumber,
                TT.VisitNo,
                TT.ChargeCode,
                TT.TransactionCodeDesc,
                TT.Modifiers,
                TT.VisitPrimaryCarrier,
                TT.VisitSecondaryCarrier,
                TT.PrimaryDxICD10,
                TT.PrimaryDxICD9,
                TT.PaymentMethod,
                TT.CheckNumber,
                TT.Void,
				TT.DateofDeposit,
				TT.DateofEntry,
				TT.DateofService,
                TT.Units AS Units,
                SUM(TT.TotalBilledAmount) AS TotalBilledAmount,
                SUM(TT.PatientPaidAmount) AS PatientPaidAmount,
                SUM(TT.InsurancePaidAmount) AS InsurancePaidAmount,
                SUM(TT.TotalPaidAmount) AS TotalPaidAmount,
                SUM(TT.AdjustmentAmount) AS AdjustmentAmount
				into #AggregatedTemp
            FROM #TransacionnDetailTemp TT  
            GROUP BY 
                TT.LabIdentityKey,
                TT.TransactionType,
                TT.ChartNumber,
                TT.VisitNo,
                TT.ChargeCode,
                TT.TransactionCodeDesc,
                TT.Modifiers,
                TT.VisitPrimaryCarrier,
                TT.VisitSecondaryCarrier,
                TT.PrimaryDxICD10,
                TT.PrimaryDxICD9,
                TT.PaymentMethod,
                TT.CheckNumber,
                TT.Void,
				TT.DateofDeposit,
				TT.DateofEntry,
				TT.DateofService,TT.Units
      
		
  		DELETE FROM TransactionMaster WHERE [VisitNo] IN (SELECT DISTINCT VisitNo FROM #AggregatedTemp)
		
		DECLARE @mx bigint;
		SELECT @mx = ISNULL(MAX(TransactionDetailID), 0) FROM dbo.TransactionMaster WITH (TABLOCKX);
		DBCC CHECKIDENT ('dbo.TransactionMaster', RESEED, @mx);
		

        ------------------------------------------------------------
       
        INSERT INTO [dbo].TransactionMaster (
            [LabIdentityKey],
            [TransactionType],
            [ChartNumber],
            [VisitNo],
            [CPTCode],
            [TransactionCodeDesc],
            [Modifiers],
            [VisitPrimaryCarrier],
            [VisitSecondaryCarrier],
            [TransactionCarrier], -- Placeholder
            [PrimaryDxICD10],
            [PrimaryDxICD9],
            [PaymentMethod],
            [CheckNumber],
            [Void],
            [Units],
            [TotalBilledAmount],
            [PatientPaidAmount],
            [InsurancePaidAmount],
            [TotalPaidAmount],
            [AdjustmentAmount],
			TT.DateofDeposit,
			TT.DateofEntry,
			TT.DateofService
        )
			SELECT 
			AT.LabIdentityKey,
			AT.TransactionType,
			AT.ChartNumber,
			AT.VisitNo,
			AT.ChargeCode,
			AT.TransactionCodeDesc,
			AT.Modifiers,
			AT.VisitPrimaryCarrier,
			AT.VisitSecondaryCarrier,
			NULL AS TransactionCarrier,
			AT.PrimaryDxICD10,
			AT.PrimaryDxICD9,
			AT.PaymentMethod,
			AT.CheckNumber,
			AT.Void,
			AT.Units,
			AT.TotalBilledAmount,
			AT.PatientPaidAmount,
			AT.InsurancePaidAmount,
			AT.TotalPaidAmount,
			AT.AdjustmentAmount,
			AT.DateofDeposit,
			AT.DateofEntry,
			AT.DateofService
		FROM #AggregatedTemp AT
		

		

		TRUNCATE TABLE [TransactionSummary];

		INSERT INTO [dbo].[TransactionSummary]
           ([VisitNumber]
           ,[CPTCode]
           ,[CheckNumber]
           ,[DateOfDeposit]
           ,[DateOfEntry]
           ,[TransactionType]
           ,[Units]
           ,[TotalBilledAmount]
           ,[AdjustmentAmount]
           ,[PatientPaidAmount]
           ,[TotalPaidAmount]
           ,[InsurancePaidAmount])
		SELECT VisitNo,CPTCode,CheckNumber,DateofDeposit,DateofEntry,TransactionType,Units,sum(TotalBilledAmount) TotalBilledAmount,Sum(AdjustmentAmount) AdjustmentAmount ,
		sum(PatientPaidAmount) PatientPaidAmount,sum(TotalPaidAmount) TotalPaidAmount,Sum(InsurancePaidAmount) InsurancePaidAmount FROM TransactionMaster 
		Group By VisitNo,CPTCode,CheckNumber,DateofDeposit,DateofEntry,TransactionType,Units;

		EXEC [BillingMasterProcess_Proc];

		update ImportedFiles set FileStatus = 1,ProcessedOn = GETDATE()  where ImportedFileID = @FileId;

        COMMIT TRANSACTION;
    END TRY
    BEGIN CATCH
        IF @@TRANCOUNT > 0
            ROLLBACK TRANSACTION;

			update ImportedFiles set FileStatus = 2,ProcessedOn = GETDATE()  where ImportedFileID = @FileId;

        -- Raise error with details
        DECLARE @ErrMsg NVARCHAR(4000), @ErrSeverity INT, @ErrState INT;
        SELECT 
            @ErrMsg = ERROR_MESSAGE(),
            @ErrSeverity = ERROR_SEVERITY(),
            @ErrState = ERROR_STATE();

        RAISERROR(@ErrMsg, @ErrSeverity, @ErrState);
    END CATCH
END
GO
/****** Object:  StoredProcedure [dbo].[Sp_ProcessTransactionDetails_BAK]******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- Create stored procedure
CREATE PROCEDURE [dbo].[Sp_ProcessTransactionDetails_BAK]
@TransFileID varchar(20) = NULL
AS
BEGIN
    SET NOCOUNT ON;

    BEGIN TRY
        BEGIN TRANSACTION;

        -- Drop temp table if exists
        IF OBJECT_ID('tempdb..#TransacionnDetailTemp') IS NOT NULL
            DROP TABLE #TransacionnDetailTemp;


		SELECT CAST(value AS INT) FileId INTO #TransactionFiles FROM STRING_SPLIT(@TransFileID, ',');

        -- Step 1: Create temp table from staging and LISMaster
        SELECT DISTINCT 
            LIS.LISMasterId,
            LabIdentityKey,
            TDS.TransactionType,
            TDS.ChartNumber,
            TDS.VisitNo,
            TDS.ChargeCode,
            TDS.TransactionCodeDesc,
            TDS.Modifiers,
            TDS.VisitPrimaryCarrier,
            TDS.VisitSecondaryCarrier,
            TDS.PrimaryDxICD10,
            TDS.PrimaryDxICD9,
            TDS.PaymentMethod,
            TDS.CheckNumber,
            TDS.Void,
            TDS.Units,
            TDS.TotalBilledAmount,
            TDS.PatientPaidAmount,
            TDS.InsurancePaidAmount,
            TDS.TotalPaidAmount,
            TDS.AdjustmentAmount,
			TDS.DateofDeposit,
			TDS.DateofEntry,
			TDS.DateofService
        INTO #TransacionnDetailTemp
        FROM TransactionDetailStaging TDS
        JOIN LISMaster LIS ON TDS.VisitNo = LIS.VisitNumber AND (TDS.ImportedFileID IN (SELECT FileId FROM #TransactionFiles) OR @TransFileID IS NULL);

		



        ------------------------------------------------------------
        -- Step 2: UPDATE existing records
        WITH AggregatedTemp AS (
            SELECT 
                TT.LISMasterId,
                TT.LabIdentityKey,
                TT.TransactionType,
                TT.ChartNumber,
                TT.VisitNo,
                TT.ChargeCode,
                TT.TransactionCodeDesc,
                TT.Modifiers,
                TT.VisitPrimaryCarrier,
                TT.VisitSecondaryCarrier,
                TT.PrimaryDxICD10,
                TT.PrimaryDxICD9,
                TT.PaymentMethod,
                TT.CheckNumber,
                TT.Void,
				TT.DateofDeposit,
				TT.DateofEntry,
				TT.DateofService,
                TT.Units AS Units,
                SUM(TT.TotalBilledAmount) AS TotalBilledAmount,
                SUM(TT.PatientPaidAmount) AS PatientPaidAmount,
                SUM(TT.InsurancePaidAmount) AS InsurancePaidAmount,
                SUM(TT.TotalPaidAmount) AS TotalPaidAmount,
                SUM(TT.AdjustmentAmount) AS AdjustmentAmount
            FROM #TransacionnDetailTemp TT
            GROUP BY 
                TT.LISMasterId,
                TT.LabIdentityKey,
                TT.TransactionType,
                TT.ChartNumber,
                TT.VisitNo,
                TT.ChargeCode,
                TT.TransactionCodeDesc,
                TT.Modifiers,
                TT.VisitPrimaryCarrier,
                TT.VisitSecondaryCarrier,
                TT.PrimaryDxICD10,
                TT.PrimaryDxICD9,
                TT.PaymentMethod,
                TT.CheckNumber,
                TT.Void,
				TT.DateofDeposit,
				TT.DateofEntry,
				TT.DateofService,TT.Units
        )
        UPDATE TM
        SET 
            TM.TransactionType = AT.TransactionType,
            TM.ChartNumber = AT.ChartNumber,
            TM.TransactionCodeDesc = AT.TransactionCodeDesc,
            TM.Modifiers = AT.Modifiers,
            TM.VisitPrimaryCarrier = AT.VisitPrimaryCarrier,
            TM.VisitSecondaryCarrier = AT.VisitSecondaryCarrier,
            TM.PrimaryDxICD10 = AT.PrimaryDxICD10,
            TM.PrimaryDxICD9 = AT.PrimaryDxICD9,
            TM.PaymentMethod = AT.PaymentMethod,
            TM.CheckNumber = AT.CheckNumber,
            TM.Void = AT.Void,
            TM.Units = AT.Units,
            TM.TotalBilledAmount = AT.TotalBilledAmount,
            TM.PatientPaidAmount = AT.PatientPaidAmount,
            TM.InsurancePaidAmount = AT.InsurancePaidAmount,
            TM.TotalPaidAmount = AT.TotalPaidAmount,
            TM.AdjustmentAmount = AT.AdjustmentAmount,
			TM.DateofDeposit = AT.DateofDeposit,
			TM.DateofEntry = AT.DateofEntry,
			TM.DateofService = AT.DateofService
		
        FROM TransactionMaster TM
        JOIN AggregatedTemp AT 
            ON TM.VisitNo = AT.VisitNo AND TM.CPTCode = AT.ChargeCode and ISNULL(TM.Units,999) =  ISNULL(AT.Units,999) 
			and ISNULL(TM.Modifiers,999) =  ISNULL(AT.Modifiers,999)   and TM.TotalBilledAmount =  AT.TotalBilledAmount;

        ------------------------------------------------------------
        -- Step 3: INSERT new records
        WITH AggregatedTemp AS (
            SELECT 
                TT.LISMasterId,
                TT.LabIdentityKey,
                TT.TransactionType,
                TT.ChartNumber,
                TT.VisitNo,
                TT.ChargeCode,
                TT.TransactionCodeDesc,
                TT.Modifiers,
                TT.VisitPrimaryCarrier,
                TT.VisitSecondaryCarrier,
                TT.PrimaryDxICD10,
                TT.PrimaryDxICD9,
                TT.PaymentMethod,
                TT.CheckNumber,
                TT.Void,
				TT.DateofDeposit,
				TT.DateofEntry,
				TT.DateofService,
                TT.Units AS Units,
                SUM(TT.TotalBilledAmount) AS TotalBilledAmount,
                SUM(TT.PatientPaidAmount) AS PatientPaidAmount,
                SUM(TT.InsurancePaidAmount) AS InsurancePaidAmount,
                SUM(TT.TotalPaidAmount) AS TotalPaidAmount,
                SUM(TT.AdjustmentAmount) AS AdjustmentAmount
            FROM #TransacionnDetailTemp TT
            GROUP BY 
                TT.LISMasterId,
                TT.LabIdentityKey,
                TT.TransactionType,
                TT.ChartNumber,
                TT.VisitNo,
                TT.ChargeCode,
                TT.TransactionCodeDesc,
                TT.Modifiers,
                TT.VisitPrimaryCarrier,
                TT.VisitSecondaryCarrier,
                TT.PrimaryDxICD10,
                TT.PrimaryDxICD9,
                TT.PaymentMethod,
                TT.CheckNumber,
                TT.Void,
				TT.DateofDeposit,
				TT.DateofEntry,
				TT.DateofService,
				TT.Units
        )
        INSERT INTO [dbo].TransactionMaster (
            [LISMasterID],
            [LabIdentityKey],
            [TransactionType],
            [ChartNumber],
            [VisitNo],
            [CPTCode],
            [TransactionCodeDesc],
            [Modifiers],
            [VisitPrimaryCarrier],
            [VisitSecondaryCarrier],
            [TransactionCarrier], -- Placeholder
            [PrimaryDxICD10],
            [PrimaryDxICD9],
            [PaymentMethod],
            [CheckNumber],
            [Void],
            [Units],
            [TotalBilledAmount],
            [PatientPaidAmount],
            [InsurancePaidAmount],
            [TotalPaidAmount],
            [AdjustmentAmount],
			TT.DateofDeposit,
			TT.DateofEntry,
			TT.DateofService
        )
        SELECT 
            AT.LISMasterId,
            AT.LabIdentityKey,
            AT.TransactionType,
            AT.ChartNumber,
            AT.VisitNo,
            AT.ChargeCode,
            AT.TransactionCodeDesc,
            AT.Modifiers,
            AT.VisitPrimaryCarrier,
            AT.VisitSecondaryCarrier,
            NULL, -- TransactionCarrier
            AT.PrimaryDxICD10,
            AT.PrimaryDxICD9,
            AT.PaymentMethod,
            AT.CheckNumber,
            AT.Void,
            AT.Units,
            AT.TotalBilledAmount,
            AT.PatientPaidAmount,
            AT.InsurancePaidAmount,
            AT.TotalPaidAmount,
            AT.AdjustmentAmount,
			AT.DateofDeposit,
			AT.DateofEntry,
			AT.DateofService
        FROM AggregatedTemp AT
        LEFT JOIN TransactionMaster TM 
            ON TM.VisitNo = AT.VisitNo AND TM.CPTCode = AT.ChargeCode  and ISNULL(TM.Units,999) =  ISNULL(AT.Units,999)
			and ISNULL(TM.Modifiers,999) =  ISNULL(AT.Modifiers,999)   and TM.TotalBilledAmount =  AT.TotalBilledAmount
        WHERE TM.VisitNo IS NULL;
		

		TRUNCATE TABLE [TransactionSummary];

		INSERT INTO [dbo].[TransactionSummary]
           ([VisitNumber]
           ,[CPTCode]
           ,[CheckNumber]
           ,[DateOfDeposit]
           ,[DateOfEntry]
           ,[TransactionType]
           ,[Units]
           ,[TotalBilledAmount]
           ,[AdjustmentAmount]
           ,[PatientPaidAmount]
           ,[TotalPaidAmount]
           ,[InsurancePaidAmount])
		SELECT VisitNo,CPTCode,CheckNumber,DateofDeposit,DateofEntry,TransactionType,Units,sum(TotalBilledAmount) TotalBilledAmount,Sum(AdjustmentAmount) AdjustmentAmount ,
		sum(PatientPaidAmount) PatientPaidAmount,sum(TotalPaidAmount) TotalPaidAmount,Sum(InsurancePaidAmount) InsurancePaidAmount FROM TransactionMaster 
		Group By VisitNo,CPTCode,CheckNumber,DateofDeposit,DateofEntry,TransactionType,Units;


        COMMIT TRANSACTION;
    END TRY
    BEGIN CATCH
        IF @@TRANCOUNT > 0
            ROLLBACK TRANSACTION;

        -- Raise error with details
        DECLARE @ErrMsg NVARCHAR(4000), @ErrSeverity INT, @ErrState INT;
        SELECT 
            @ErrMsg = ERROR_MESSAGE(),
            @ErrSeverity = ERROR_SEVERITY(),
            @ErrState = ERROR_STATE();

        RAISERROR(@ErrMsg, @ErrSeverity, @ErrState);
    END CATCH
END
GO
/****** Object:  StoredProcedure [dbo].[SP_ProcessVAAvsLIS]******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[SP_ProcessVAAvsLIS]
AS
BEGIN
    SET NOCOUNT ON;

    BEGIN TRY
        BEGIN TRANSACTION;

        /*******************************************************************************************
         Step 3: Prepare enriched patient and billing data
         - Rank by service date to keep only latest per accession
        ********************************************************************************************/
        DROP TABLE IF EXISTS #SampleCollectionData;
        DROP TABLE IF EXISTS #CCSTemp;

        -- Prepare a grouped temp version of CustomCollectionStaging
        SELECT 
            PatientID,
            DOB,
            ResponsibleParty,
            LastBillDate,
            PerformingLab,
            BillingProvider,
            PayerType,
            ReferringProvider,
            VisitNumber,
            ICD10Code,
            ChargeEntryDate
        INTO #CCSTemp
        FROM CustomCollectionStaging
        GROUP BY 
            PatientID,
            DOB,
            ResponsibleParty,
            LastBillDate,
            PerformingLab,
            BillingProvider,
            PayerType,
            ReferringProvider,
            VisitNumber,
            ICD10Code,
            ChargeEntryDate;

        WITH RankedData AS (
            SELECT 
                LIS.AccessionNo,
                LAB.LabID,
                BPM.BillingProviderID,
                CCS.PatientID,
                CCS.DOB,
                CCS.ResponsibleParty,
                PT.PayerTypeId,
                VAA.VisitNumber,
                CCS.ICD10Code,
                CCS.LastBillDate,
                CCS.ChargeEntryDate,
                RP.ReferingProviderId,
                ROW_NUMBER() OVER (PARTITION BY LIS.AccessionNo ORDER BY VAA.DateOfEntry) AS RowNum
            FROM [dbo].[LISMaster] LIS
            LEFT JOIN VAAMaster VAA                   ON LIS.AccessionNo = VAA.AccessionNo  
            LEFT JOIN #CCSTemp CCS                   ON VAA.VisitNumber = CCS.VisitNumber 
            LEFT JOIN LabMaster LAB                  ON CCS.PerformingLab = LAB.LabName
            LEFT JOIN BillingProviderMaster BPM      ON CCS.BillingProvider = BPM.BillingProvider
            LEFT JOIN PayerTypeMaster PT             ON CCS.PayerType = PT.PayerType
            LEFT JOIN ReferringProviderMaster RP     ON CCS.ReferringProvider = RP.ReferringProviderName
        )
        SELECT *
        INTO #SampleCollectionData
        FROM RankedData
        WHERE RowNum = 1;

        /*******************************************************************************************
         Step 4a: Update LISMaster with enriched patient/billing data
        ********************************************************************************************/
        UPDATE LIS
        SET 
            LabId                = SCD.LabID,
            BillingProviderID    = SCD.BillingProviderID,
            PatientID            = SCD.PatientID,
            PatientDOB           = SCD.DOB,
            ResponsibleParty     = SCD.ResponsibleParty,
            VisitNumber          = SCD.VisitNumber,
            ICD10Code            = SCD.ICD10Code,
            ReferringProviderId  = SCD.ReferingProviderId,
            PayerTypeId          = SCD.PayerTypeId,
            FirstBilledDate      = SCD.LastBillDate,
            ChargeEntryDate      = SCD.ChargeEntryDate
        FROM [dbo].[LISMaster] LIS
        JOIN #SampleCollectionData SCD ON LIS.AccessionNo = SCD.AccessionNo;

        COMMIT TRANSACTION;
    END TRY
    BEGIN CATCH
        IF @@TRANCOUNT > 0
            ROLLBACK TRANSACTION;

        DECLARE 
            @ErrMsg NVARCHAR(4000) = ERROR_MESSAGE(),
            @ErrSeverity INT = ERROR_SEVERITY(),
            @ErrState INT = ERROR_STATE();

        RAISERROR(@ErrMsg, @ErrSeverity, @ErrState);
    END CATCH
END;
GO
/****** Object:  StoredProcedure [dbo].[SP_UpdateLIS_Statuses]******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
	
	CREATE PROC [dbo].[SP_UpdateLIS_Statuses]
	AS BEGIN
	  SET NOCOUNT ON;
	
	/*******************************************************************************************
         Step 1: Derive ResultedStatus, BillingStatus, SubStatus, etc.
        ********************************************************************************************/
      UPDATE [dbo].[LISMaster]
SET 
    ResultedStatus = CASE 
        WHEN SampleResultedDate IS NULL THEN 'Not Resulted'
        ELSE 'Resulted'
    END,

    BillingStatus = CASE 
        WHEN FirstBilledDate IS NULL THEN 'Not Billed'
        WHEN FirstBilledDate IS NOT NULL AND ChargeEntryDate IS NOT NULL THEN 'Billed'
        ELSE 'Billed'
    END,

    BillingSubStatus = CASE 
        WHEN FirstBilledDate IS NOT NULL THEN 'Claim Submitted'
        WHEN FirstBilledDate IS NULL AND ChargeEntryDate IS NOT NULL THEN 'Charge Entered in AMD'
        WHEN SampleResultedDate IS NOT NULL AND FirstBilledDate IS NULL AND ChargeEntryDate IS NULL THEN 'Resulted Yet to Billed'
        WHEN SampleResultedDate IS NULL AND FirstBilledDate IS NULL AND ChargeEntryDate IS NULL THEN 'Yet to be Resulted'
        ELSE ''
    END,

    BilledTo = CASE 
        WHEN SelfPay = 'TRUE' AND ISNULL(LTRIM(RTRIM(PrimaryPayerName)), '') = '' THEN 'Self Pay'
        WHEN AccountPay = 'TRUE' THEN 'Client Bill'
        ELSE 'Insurance'
    END,

    DaystoReceive = DATEDIFF(DAY, SampleCollectedDate, SampleReceivedDate),
    DaystoResult  = DATEDIFF(DAY, SampleReceivedDate, SampleResultedDate),
    DaystoBill    = DATEDIFF(DAY, SampleResultedDate, FirstBilledDate);
	END
GO
