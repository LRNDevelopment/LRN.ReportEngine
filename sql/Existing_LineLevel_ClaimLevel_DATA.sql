USE [Augustus_LRN]
GO

/****** Object:  Table [dbo].[ClaimLevelData]    Script Date: 8/1/2026 7:07:57 AM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[ClaimLevelData](
	[RecordId] [int] IDENTITY(1,1) NOT NULL,
	[FileLogId] [nvarchar](500) NULL,
	[RunId] [nvarchar](500) NULL,
	[WeekFolder] [nvarchar](500) NULL,
	[SourceFullPath] [nvarchar](1000) NULL,
	[FileName] [nvarchar](500) NULL,
	[FileType] [nvarchar](100) NULL,
	[RowHash] [nvarchar](64) NULL,
	[LabID] [nvarchar](500) NULL,
	[LabName] [nvarchar](500) NULL,
	[ClaimID] [nvarchar](500) NULL,
	[AccessionNumber] [nvarchar](500) NULL,
	[SourceFileID] [nvarchar](1000) NULL,
	[IngestedOn] [nvarchar](500) NULL,
	[CsvRowHash] [nvarchar](500) NULL,
	[PayerName_Raw] [nvarchar](500) NULL,
	[PayerName] [nvarchar](500) NULL,
	[Payer_Code] [nvarchar](500) NULL,
	[Payer_Common_Code] [nvarchar](500) NULL,
	[Payer_Group_Code] [nvarchar](500) NULL,
	[Global_Payer_ID] [nvarchar](500) NULL,
	[PayerType] [nvarchar](500) NULL,
	[BillingProvider] [nvarchar](500) NULL,
	[ReferringProvider] [nvarchar](500) NULL,
	[ClinicName] [nvarchar](500) NULL,
	[SalesRepname] [nvarchar](500) NULL,
	[PatientID] [nvarchar](500) NULL,
	[PatientDOB] [nvarchar](500) NULL,
	[DateofService] [nvarchar](500) NULL,
	[ChargeEnteredDate] [nvarchar](500) NULL,
	[FirstBilledDate] [nvarchar](500) NULL,
	[Panelname] [nvarchar](500) NULL,
	[CPTCodeXUnitsXModifier] [nvarchar](max) NULL,
	[POS] [nvarchar](500) NULL,
	[TOS] [nvarchar](500) NULL,
	[ChargeAmount] [nvarchar](500) NULL,
	[AllowedAmount] [nvarchar](500) NULL,
	[InsurancePayment] [nvarchar](500) NULL,
	[PatientPayment] [nvarchar](500) NULL,
	[TotalPayments] [nvarchar](500) NULL,
	[InsuranceAdjustments] [nvarchar](500) NULL,
	[PatientAdjustments] [nvarchar](500) NULL,
	[TotalAdjustments] [nvarchar](500) NULL,
	[InsuranceBalance] [nvarchar](500) NULL,
	[PatientBalance] [nvarchar](500) NULL,
	[TotalBalance] [nvarchar](500) NULL,
	[CheckDate] [nvarchar](500) NULL,
	[ClaimStatus] [nvarchar](500) NULL,
	[DenialCode] [nvarchar](max) NULL,
	[ICDCode] [nvarchar](500) NULL,
	[DaystoDOS] [nvarchar](500) NULL,
	[RollingDays] [nvarchar](500) NULL,
	[DaystoBill] [nvarchar](500) NULL,
	[DaystoPost] [nvarchar](500) NULL,
	[ICDPointer] [nvarchar](500) NULL,
	[InsertedDateTime] [datetime] NOT NULL,
	[InsuranceBalance_Decimal]  AS (TRY_CAST([InsuranceBalance] AS [decimal](18,2))) PERSISTED,
	[UID] [nvarchar](500) NULL,
	[Aging] [nvarchar](100) NULL,
	[PatientName] [nvarchar](1000) NULL,
	[SubscriberId] [nvarchar](1000) NULL,
	[EnteredWeek] [nvarchar](500) NULL,
	[EnteredStatus] [nvarchar](1000) NULL,
	[BilledWeek] [nvarchar](500) NULL,
	[BilledStatus] [nvarchar](max) NULL,
	[PostedWeek] [nvarchar](500) NULL,
	[ModField] [nvarchar](100) NULL,
	[ScrubberEditReason] [nvarchar](max) NULL,
	[CheqNo] [nvarchar](500) NULL,
	[TimeToPay] [nvarchar](500) NULL,
	[PaymentPercent] [nvarchar](100) NULL,
	[FullyPaidCount] [nvarchar](500) NULL,
	[FullyPaidAmount] [nvarchar](500) NULL,
	[Adjudicated] [nvarchar](500) NULL,
	[AdjudicatedAmount] [nvarchar](500) NULL,
	[Bucket30] [nvarchar](500) NULL,
	[Bucket30Amount] [nvarchar](500) NULL,
	[Bucket60] [nvarchar](500) NULL,
	[Bucket60Amount] [nvarchar](500) NULL,
	[CPTCodeXUnitsXModifierOrginal] [nvarchar](max) NULL,
	[PanelNew] [nvarchar](500) NULL,
	[Source] [nvarchar](500) NULL,
	[PanelCategory] [nvarchar](500) NULL,
	[BillingStatus] [nvarchar](200) NULL,
	[LBilledDate] [nvarchar](100) NULL,
	[BProcessDate] [nvarchar](100) NULL,
PRIMARY KEY CLUSTERED 
(
	[RecordId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO

ALTER TABLE [dbo].[ClaimLevelData] ADD  DEFAULT (getdate()) FOR [InsertedDateTime]
GO


USE [Augustus_LRN]
GO

/****** Object:  Table [dbo].[LineLevelData]    Script Date: 8/1/2026 7:08:24 AM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[LineLevelData](
	[RecordId] [int] IDENTITY(1,1) NOT NULL,
	[FileLogId] [nvarchar](500) NULL,
	[RunId] [nvarchar](500) NULL,
	[WeekFolder] [nvarchar](500) NULL,
	[SourceFullPath] [nvarchar](1000) NULL,
	[FileName] [nvarchar](500) NULL,
	[FileType] [nvarchar](100) NULL,
	[RowHash] [nvarchar](64) NULL,
	[LabID] [nvarchar](500) NULL,
	[LabName] [nvarchar](500) NULL,
	[ClaimID] [nvarchar](500) NULL,
	[AccessionNumber] [nvarchar](500) NULL,
	[SourceFileID] [nvarchar](1000) NULL,
	[IngestedOn] [nvarchar](500) NULL,
	[CsvRowHash] [nvarchar](500) NULL,
	[PayerName_Raw] [nvarchar](500) NULL,
	[PayerName] [nvarchar](500) NULL,
	[Payer_Code] [nvarchar](500) NULL,
	[Payer_Common_Code] [nvarchar](500) NULL,
	[Payer_Group_Code] [nvarchar](500) NULL,
	[Global_Payer_ID] [nvarchar](500) NULL,
	[PayerType] [nvarchar](500) NULL,
	[BillingProvider] [nvarchar](500) NULL,
	[ReferringProvider] [nvarchar](500) NULL,
	[ClinicName] [nvarchar](500) NULL,
	[SalesRepname] [nvarchar](500) NULL,
	[PatientID] [nvarchar](500) NULL,
	[PatientDOB] [nvarchar](500) NULL,
	[DateofService] [nvarchar](500) NULL,
	[ChargeEnteredDate] [nvarchar](500) NULL,
	[FirstBilledDate] [nvarchar](500) NULL,
	[Panelname] [nvarchar](500) NULL,
	[CPTCode] [nvarchar](500) NULL,
	[Units] [nvarchar](500) NULL,
	[Modifier] [nvarchar](500) NULL,
	[POS] [nvarchar](500) NULL,
	[TOS] [nvarchar](500) NULL,
	[ChargeAmount] [nvarchar](500) NULL,
	[ChargeAmountPerUnit] [nvarchar](500) NULL,
	[AllowedAmount] [nvarchar](500) NULL,
	[AllowedAmountPerUnit] [nvarchar](500) NULL,
	[InsurancePayment] [nvarchar](500) NULL,
	[InsurancePaymentPerUnit] [nvarchar](500) NULL,
	[PatientPayment] [nvarchar](500) NULL,
	[PatientPaymentPerUnit] [nvarchar](500) NULL,
	[TotalPayments] [nvarchar](500) NULL,
	[InsuranceAdjustments] [nvarchar](500) NULL,
	[PatientAdjustments] [nvarchar](500) NULL,
	[TotalAdjustments] [nvarchar](500) NULL,
	[InsuranceBalance] [nvarchar](500) NULL,
	[PatientBalance] [nvarchar](500) NULL,
	[PatientBalancePerUnit] [nvarchar](500) NULL,
	[TotalBalance] [nvarchar](500) NULL,
	[CheckDate] [nvarchar](500) NULL,
	[PostingDate] [nvarchar](500) NULL,
	[ClaimStatus] [nvarchar](500) NULL,
	[PayStatus] [nvarchar](500) NULL,
	[DenialCode] [nvarchar](max) NULL,
	[DenialDate] [nvarchar](500) NULL,
	[ICDCode] [nvarchar](500) NULL,
	[DaystoDOS] [nvarchar](500) NULL,
	[RollingDays] [nvarchar](500) NULL,
	[DaystoBill] [nvarchar](500) NULL,
	[DaystoPost] [nvarchar](500) NULL,
	[ICDPointer] [nvarchar](500) NULL,
	[InsertedDateTime] [datetime] NOT NULL,
	[PaymentPostedDate] [nvarchar](500) NULL,
	[EncounterPaymentPostedDate] [nvarchar](500) NULL,
	[PanelNew] [nvarchar](500) NULL,
	[Source] [nvarchar](500) NULL,
	[UID] [nvarchar](500) NULL,
	[Valid] [nvarchar](100) NULL,
	[PanelCategory] [nvarchar](500) NULL,
	[PatientName] [nvarchar](1000) NULL,
	[SubscriberId] [nvarchar](500) NULL,
	[ClaimAmount] [nvarchar](500) NULL,
	[Date] [nvarchar](100) NULL,
	[EnteredStatus] [nvarchar](500) NULL,
	[BilledStatus] [nvarchar](500) NULL,
	[CptWithUnits] [nvarchar](max) NULL,
	[Proc] [nvarchar](max) NULL,
	[CheqNo] [nvarchar](500) NULL,
	[AdjAmount] [nvarchar](500) NULL,
	[InsBalance] [nvarchar](500) NULL,
	[PatBalance] [nvarchar](500) NULL,
	[UpdatedDenial] [nvarchar](max) NULL,
	[CombinedDenial] [nvarchar](max) NULL,
	[PaymentPercent] [nvarchar](100) NULL,
	[Loc] [nvarchar](500) NULL,
	[BillingStatus] [nvarchar](200) NULL,
	[LBilledDate] [nvarchar](100) NULL,
	[BProcessDate] [nvarchar](100) NULL,
PRIMARY KEY CLUSTERED 
(
	[RecordId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO

ALTER TABLE [dbo].[LineLevelData] ADD  DEFAULT (getdate()) FOR [InsertedDateTime]
GO


USE [BeechTree_LRN]
GO

/****** Object:  Table [dbo].[ClaimLevelData]    Script Date: 8/1/2026 7:08:52 AM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[ClaimLevelData](
	[RecordId] [int] IDENTITY(1,1) NOT NULL,
	[FileLogId] [nvarchar](500) NULL,
	[RunId] [nvarchar](500) NULL,
	[WeekFolder] [nvarchar](500) NULL,
	[SourceFullPath] [nvarchar](1000) NULL,
	[FileName] [nvarchar](500) NULL,
	[FileType] [nvarchar](100) NULL,
	[RowHash] [nvarchar](64) NULL,
	[LabID] [nvarchar](500) NULL,
	[LabName] [nvarchar](500) NULL,
	[ClaimID] [nvarchar](500) NULL,
	[AccessionNumber] [nvarchar](500) NULL,
	[SourceFileID] [nvarchar](1000) NULL,
	[IngestedOn] [nvarchar](500) NULL,
	[CsvRowHash] [nvarchar](500) NULL,
	[PayerName_Raw] [nvarchar](500) NULL,
	[PayerName] [nvarchar](500) NULL,
	[Payer_Code] [nvarchar](500) NULL,
	[Payer_Common_Code] [nvarchar](500) NULL,
	[Payer_Group_Code] [nvarchar](500) NULL,
	[Global_Payer_ID] [nvarchar](500) NULL,
	[PayerType] [nvarchar](500) NULL,
	[BillingProvider] [nvarchar](500) NULL,
	[ReferringProvider] [nvarchar](500) NULL,
	[ClinicName] [nvarchar](500) NULL,
	[SalesRepname] [nvarchar](500) NULL,
	[PatientID] [nvarchar](500) NULL,
	[PatientDOB] [nvarchar](500) NULL,
	[DateofService] [nvarchar](500) NULL,
	[ChargeEnteredDate] [nvarchar](500) NULL,
	[FirstBilledDate] [nvarchar](500) NULL,
	[Panelname] [nvarchar](500) NULL,
	[CPTCodeXUnitsXModifier] [nvarchar](max) NULL,
	[POS] [nvarchar](500) NULL,
	[TOS] [nvarchar](500) NULL,
	[ChargeAmount] [nvarchar](500) NULL,
	[AllowedAmount] [nvarchar](500) NULL,
	[InsurancePayment] [nvarchar](500) NULL,
	[PatientPayment] [nvarchar](500) NULL,
	[TotalPayments] [nvarchar](500) NULL,
	[InsuranceAdjustments] [nvarchar](500) NULL,
	[PatientAdjustments] [nvarchar](500) NULL,
	[TotalAdjustments] [nvarchar](500) NULL,
	[InsuranceBalance] [nvarchar](500) NULL,
	[PatientBalance] [nvarchar](500) NULL,
	[TotalBalance] [nvarchar](500) NULL,
	[CheckDate] [nvarchar](500) NULL,
	[ClaimStatus] [nvarchar](500) NULL,
	[DenialCode] [nvarchar](max) NULL,
	[ICDCode] [nvarchar](500) NULL,
	[DaystoDOS] [nvarchar](500) NULL,
	[RollingDays] [nvarchar](500) NULL,
	[DaystoBill] [nvarchar](500) NULL,
	[DaystoPost] [nvarchar](500) NULL,
	[ICDPointer] [nvarchar](500) NULL,
	[InsertedDateTime] [datetime] NOT NULL,
	[PatientName] [nvarchar](1000) NULL,
	[PaymentPercent] [nvarchar](100) NULL,
	[Aging] [nvarchar](100) NULL,
	[BilledWeek] [nvarchar](500) NULL,
	[PostedWeek] [nvarchar](500) NULL,
	[FullyPaidCount] [nvarchar](500) NULL,
	[FullyPaidAmount] [nvarchar](500) NULL,
	[AdjudicatedAmount] [nvarchar](500) NULL,
	[CPTCodeXUnitsXModifierOrginal] [nvarchar](max) NULL,
	[BilledUnbilled] [nvarchar](100) NULL,
	[AgingBucket] [nvarchar](200) NULL,
	[AdjudicatedCount] [nvarchar](500) NULL,
	[Days30Count] [nvarchar](500) NULL,
	[Days30Amount] [nvarchar](500) NULL,
	[Days60Count] [nvarchar](500) NULL,
	[Days60Amount] [nvarchar](500) NULL,
	[DOE_Year] [nvarchar](20) NULL,
	[DOE_Month] [nvarchar](20) NULL,
PRIMARY KEY CLUSTERED 
(
	[RecordId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO

ALTER TABLE [dbo].[ClaimLevelData] ADD  DEFAULT (getdate()) FOR [InsertedDateTime]
GO


USE [BeechTree_LRN]
GO

/****** Object:  Table [dbo].[LineLevelData]    Script Date: 8/1/2026 7:09:10 AM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[LineLevelData](
	[RecordId] [int] IDENTITY(1,1) NOT NULL,
	[FileLogId] [nvarchar](500) NULL,
	[RunId] [nvarchar](500) NULL,
	[WeekFolder] [nvarchar](500) NULL,
	[SourceFullPath] [nvarchar](1000) NULL,
	[FileName] [nvarchar](500) NULL,
	[FileType] [nvarchar](100) NULL,
	[RowHash] [nvarchar](64) NULL,
	[LabID] [nvarchar](500) NULL,
	[LabName] [nvarchar](500) NULL,
	[ClaimID] [nvarchar](500) NULL,
	[AccessionNumber] [nvarchar](500) NULL,
	[SourceFileID] [nvarchar](1000) NULL,
	[IngestedOn] [nvarchar](500) NULL,
	[CsvRowHash] [nvarchar](500) NULL,
	[PayerName_Raw] [nvarchar](500) NULL,
	[PayerName] [nvarchar](500) NULL,
	[Payer_Code] [nvarchar](500) NULL,
	[Payer_Common_Code] [nvarchar](500) NULL,
	[Payer_Group_Code] [nvarchar](500) NULL,
	[Global_Payer_ID] [nvarchar](500) NULL,
	[PayerType] [nvarchar](500) NULL,
	[BillingProvider] [nvarchar](500) NULL,
	[ReferringProvider] [nvarchar](500) NULL,
	[ClinicName] [nvarchar](500) NULL,
	[SalesRepname] [nvarchar](500) NULL,
	[PatientID] [nvarchar](500) NULL,
	[PatientDOB] [nvarchar](500) NULL,
	[DateofService] [nvarchar](500) NULL,
	[ChargeEnteredDate] [nvarchar](500) NULL,
	[FirstBilledDate] [nvarchar](500) NULL,
	[Panelname] [nvarchar](500) NULL,
	[CPTCode] [nvarchar](500) NULL,
	[Units] [nvarchar](500) NULL,
	[Modifier] [nvarchar](500) NULL,
	[POS] [nvarchar](500) NULL,
	[TOS] [nvarchar](500) NULL,
	[ChargeAmount] [nvarchar](500) NULL,
	[ChargeAmountPerUnit] [nvarchar](500) NULL,
	[AllowedAmount] [nvarchar](500) NULL,
	[AllowedAmountPerUnit] [nvarchar](500) NULL,
	[InsurancePayment] [nvarchar](500) NULL,
	[InsurancePaymentPerUnit] [nvarchar](500) NULL,
	[PatientPayment] [nvarchar](500) NULL,
	[PatientPaymentPerUnit] [nvarchar](500) NULL,
	[TotalPayments] [nvarchar](500) NULL,
	[InsuranceAdjustments] [nvarchar](500) NULL,
	[PatientAdjustments] [nvarchar](500) NULL,
	[TotalAdjustments] [nvarchar](500) NULL,
	[InsuranceBalance] [nvarchar](500) NULL,
	[PatientBalance] [nvarchar](500) NULL,
	[PatientBalancePerUnit] [nvarchar](500) NULL,
	[TotalBalance] [nvarchar](500) NULL,
	[CheckDate] [nvarchar](500) NULL,
	[PostingDate] [nvarchar](500) NULL,
	[ClaimStatus] [nvarchar](500) NULL,
	[PayStatus] [nvarchar](500) NULL,
	[DenialCode] [nvarchar](max) NULL,
	[DenialDate] [nvarchar](500) NULL,
	[ICDCode] [nvarchar](500) NULL,
	[DaystoDOS] [nvarchar](500) NULL,
	[RollingDays] [nvarchar](500) NULL,
	[DaystoBill] [nvarchar](500) NULL,
	[DaystoPost] [nvarchar](500) NULL,
	[ICDPointer] [nvarchar](500) NULL,
	[InsertedDateTime] [datetime] NOT NULL,
	[PatientName] [nvarchar](1000) NULL,
	[SubscriberId] [nvarchar](500) NULL,
	[PaymentPostedDate] [nvarchar](500) NULL,
	[ResponsibleParty] [nvarchar](500) NULL,
	[EndDOS] [nvarchar](500) NULL,
	[BillOccurance] [nvarchar](500) NULL,
	[EntryUser] [nvarchar](500) NULL,
	[CPTUnits] [nvarchar](500) NULL,
	[CPTMOD] [nvarchar](500) NULL,
	[PostedWeek] [nvarchar](500) NULL,
PRIMARY KEY CLUSTERED 
(
	[RecordId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO

ALTER TABLE [dbo].[LineLevelData] ADD  DEFAULT (getdate()) FOR [InsertedDateTime]
GO


USE [Certus_LRN]
GO

/****** Object:  Table [dbo].[ClaimLevelData]    Script Date: 8/1/2026 7:09:41 AM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[ClaimLevelData](
	[RecordId] [int] IDENTITY(1,1) NOT NULL,
	[FileLogId] [nvarchar](500) NULL,
	[RunId] [nvarchar](500) NULL,
	[WeekFolder] [nvarchar](500) NULL,
	[SourceFullPath] [nvarchar](1000) NULL,
	[FileName] [nvarchar](500) NULL,
	[FileType] [nvarchar](100) NULL,
	[RowHash] [nvarchar](64) NULL,
	[LabID] [nvarchar](500) NULL,
	[LabName] [nvarchar](500) NULL,
	[ClaimID] [nvarchar](500) NULL,
	[AccessionNumber] [nvarchar](500) NULL,
	[SourceFileID] [nvarchar](1000) NULL,
	[IngestedOn] [nvarchar](500) NULL,
	[CsvRowHash] [nvarchar](500) NULL,
	[PayerName_Raw] [nvarchar](500) NULL,
	[PayerName] [nvarchar](500) NULL,
	[Payer_Code] [nvarchar](500) NULL,
	[Payer_Common_Code] [nvarchar](500) NULL,
	[Payer_Group_Code] [nvarchar](500) NULL,
	[Global_Payer_ID] [nvarchar](500) NULL,
	[PayerType] [nvarchar](500) NULL,
	[BillingProvider] [nvarchar](500) NULL,
	[ReferringProvider] [nvarchar](500) NULL,
	[ClinicName] [nvarchar](500) NULL,
	[SalesRepname] [nvarchar](500) NULL,
	[PatientID] [nvarchar](500) NULL,
	[PatientDOB] [nvarchar](500) NULL,
	[DateofService] [nvarchar](500) NULL,
	[ChargeEnteredDate] [nvarchar](500) NULL,
	[FirstBilledDate] [nvarchar](500) NULL,
	[Panelname] [nvarchar](500) NULL,
	[CPTCodeXUnitsXModifier] [nvarchar](max) NULL,
	[POS] [nvarchar](500) NULL,
	[TOS] [nvarchar](500) NULL,
	[ChargeAmount] [nvarchar](500) NULL,
	[AllowedAmount] [nvarchar](500) NULL,
	[InsurancePayment] [nvarchar](500) NULL,
	[PatientPayment] [nvarchar](500) NULL,
	[TotalPayments] [nvarchar](500) NULL,
	[InsuranceAdjustments] [nvarchar](500) NULL,
	[PatientAdjustments] [nvarchar](500) NULL,
	[TotalAdjustments] [nvarchar](500) NULL,
	[InsuranceBalance] [nvarchar](500) NULL,
	[PatientBalance] [nvarchar](500) NULL,
	[TotalBalance] [nvarchar](500) NULL,
	[CheckDate] [nvarchar](500) NULL,
	[ClaimStatus] [nvarchar](500) NULL,
	[DenialCode] [nvarchar](max) NULL,
	[ICDCode] [nvarchar](500) NULL,
	[DaystoDOS] [nvarchar](500) NULL,
	[RollingDays] [nvarchar](500) NULL,
	[DaystoBill] [nvarchar](500) NULL,
	[DaystoPost] [nvarchar](500) NULL,
	[ICDPointer] [nvarchar](500) NULL,
	[InsertedDateTime] [datetime] NOT NULL,
	[InsuranceBalance_Decimal]  AS (TRY_CAST([InsuranceBalance] AS [decimal](18,2))) PERSISTED,
	[CPTCodeXUnitsXModifierOrginal] [nvarchar](max) NULL,
	[T_F] [nvarchar](100) NULL,
	[SubscriberId] [nvarchar](1000) NULL,
	[PatientName] [nvarchar](1000) NULL,
	[ICDCodes] [nvarchar](max) NULL,
	[DiagnosisPointer] [nvarchar](500) NULL,
	[EnteredWeek] [nvarchar](500) NULL,
	[EnteredStatus] [nvarchar](1000) NULL,
	[BilledWeek] [nvarchar](500) NULL,
	[BilledStatus] [nvarchar](max) NULL,
	[ModField] [nvarchar](100) NULL,
	[ServiceUnit] [nvarchar](500) NULL,
	[CPTXUnits] [nvarchar](max) NULL,
	[CPTCombined] [nvarchar](max) NULL,
	[Aging] [nvarchar](100) NULL,
	[Description] [nvarchar](max) NULL,
	[PostedWeek] [nvarchar](500) NULL,
	[ClaimAmount] [nvarchar](500) NULL,
	[OriginalDenialCode] [nvarchar](max) NULL,
	[LineLevelDenials] [nvarchar](max) NULL,
	[DenialCombination] [nvarchar](max) NULL,
	[PaymentPercent] [nvarchar](100) NULL,
	[RejectionReasons] [nvarchar](max) NULL,
	[RejectionCategory] [nvarchar](max) NULL,
	[FullyPaidCount] [nvarchar](500) NULL,
	[FullyPaidAmount] [nvarchar](500) NULL,
	[Adjudicated] [nvarchar](500) NULL,
	[AdjudicatedAmount] [nvarchar](500) NULL,
	[Bucket30] [nvarchar](500) NULL,
	[Bucket30Amount] [nvarchar](500) NULL,
	[Bucket60] [nvarchar](500) NULL,
	[Bucket60Amount] [nvarchar](500) NULL,
	[ClaimType] [nvarchar](max) NULL,
PRIMARY KEY CLUSTERED 
(
	[RecordId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO

ALTER TABLE [dbo].[ClaimLevelData] ADD  DEFAULT (getdate()) FOR [InsertedDateTime]
GO


USE [Certus_LRN]
GO

/****** Object:  Table [dbo].[LineLevelData]    Script Date: 8/1/2026 7:09:58 AM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[LineLevelData](
	[RecordId] [int] IDENTITY(1,1) NOT NULL,
	[FileLogId] [nvarchar](500) NULL,
	[RunId] [nvarchar](500) NULL,
	[WeekFolder] [nvarchar](500) NULL,
	[SourceFullPath] [nvarchar](1000) NULL,
	[FileName] [nvarchar](500) NULL,
	[FileType] [nvarchar](100) NULL,
	[RowHash] [nvarchar](64) NULL,
	[LabID] [nvarchar](500) NULL,
	[LabName] [nvarchar](500) NULL,
	[ClaimID] [nvarchar](500) NULL,
	[AccessionNumber] [nvarchar](500) NULL,
	[SourceFileID] [nvarchar](1000) NULL,
	[IngestedOn] [nvarchar](500) NULL,
	[CsvRowHash] [nvarchar](500) NULL,
	[PayerName_Raw] [nvarchar](500) NULL,
	[PayerName] [nvarchar](500) NULL,
	[Payer_Code] [nvarchar](500) NULL,
	[Payer_Common_Code] [nvarchar](500) NULL,
	[Payer_Group_Code] [nvarchar](500) NULL,
	[Global_Payer_ID] [nvarchar](500) NULL,
	[PayerType] [nvarchar](500) NULL,
	[BillingProvider] [nvarchar](500) NULL,
	[ReferringProvider] [nvarchar](500) NULL,
	[ClinicName] [nvarchar](500) NULL,
	[SalesRepname] [nvarchar](500) NULL,
	[PatientID] [nvarchar](500) NULL,
	[PatientDOB] [nvarchar](500) NULL,
	[DateofService] [nvarchar](500) NULL,
	[ChargeEnteredDate] [nvarchar](500) NULL,
	[FirstBilledDate] [nvarchar](500) NULL,
	[Panelname] [nvarchar](500) NULL,
	[CPTCode] [nvarchar](500) NULL,
	[Units] [nvarchar](500) NULL,
	[Modifier] [nvarchar](500) NULL,
	[POS] [nvarchar](500) NULL,
	[TOS] [nvarchar](500) NULL,
	[ChargeAmount] [nvarchar](500) NULL,
	[ChargeAmountPerUnit] [nvarchar](500) NULL,
	[AllowedAmount] [nvarchar](500) NULL,
	[AllowedAmountPerUnit] [nvarchar](500) NULL,
	[InsurancePayment] [nvarchar](500) NULL,
	[InsurancePaymentPerUnit] [nvarchar](500) NULL,
	[PatientPayment] [nvarchar](500) NULL,
	[PatientPaymentPerUnit] [nvarchar](500) NULL,
	[TotalPayments] [nvarchar](500) NULL,
	[InsuranceAdjustments] [nvarchar](500) NULL,
	[PatientAdjustments] [nvarchar](500) NULL,
	[TotalAdjustments] [nvarchar](500) NULL,
	[InsuranceBalance] [nvarchar](500) NULL,
	[PatientBalance] [nvarchar](500) NULL,
	[PatientBalancePerUnit] [nvarchar](500) NULL,
	[TotalBalance] [nvarchar](500) NULL,
	[CheckDate] [nvarchar](500) NULL,
	[PostingDate] [nvarchar](500) NULL,
	[ClaimStatus] [nvarchar](500) NULL,
	[PayStatus] [nvarchar](500) NULL,
	[DenialCode] [nvarchar](max) NULL,
	[DenialDate] [nvarchar](500) NULL,
	[ICDCode] [nvarchar](500) NULL,
	[DaystoDOS] [nvarchar](500) NULL,
	[RollingDays] [nvarchar](500) NULL,
	[DaystoBill] [nvarchar](500) NULL,
	[DaystoPost] [nvarchar](500) NULL,
	[ICDPointer] [nvarchar](500) NULL,
	[InsertedDateTime] [datetime] NOT NULL,
	[PaymentPostedDate] [nvarchar](500) NULL,
	[T_F] [nvarchar](100) NULL,
	[UID] [nvarchar](500) NULL,
	[SubscriberId] [nvarchar](500) NULL,
	[PatientName] [nvarchar](1000) NULL,
	[DiagnosisPointer] [nvarchar](500) NULL,
	[EnteredWeek] [nvarchar](500) NULL,
	[EnteredStatus] [nvarchar](500) NULL,
	[BilledWeek] [nvarchar](500) NULL,
	[BilledStatus] [nvarchar](500) NULL,
	[CPTXUnits] [nvarchar](max) NULL,
	[CPTCombined] [nvarchar](max) NULL,
	[Aging] [nvarchar](100) NULL,
	[Description] [nvarchar](max) NULL,
	[PostedWeek] [nvarchar](500) NULL,
	[BilledAmounts] [nvarchar](500) NULL,
	[OriginalDenialCode] [nvarchar](max) NULL,
	[DenialCombination] [nvarchar](max) NULL,
	[PaymentPercent] [nvarchar](100) NULL,
PRIMARY KEY CLUSTERED 
(
	[RecordId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO

ALTER TABLE [dbo].[LineLevelData] ADD  DEFAULT (getdate()) FOR [InsertedDateTime]
GO


USE [CoveLRN]
GO

/****** Object:  Table [dbo].[ClaimLevelData]    Script Date: 8/1/2026 7:10:38 AM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[ClaimLevelData](
	[RecordId] [int] IDENTITY(1,1) NOT NULL,
	[FileLogId] [nvarchar](500) NULL,
	[RunId] [nvarchar](500) NULL,
	[WeekFolder] [nvarchar](500) NULL,
	[SourceFullPath] [nvarchar](1000) NULL,
	[FileName] [nvarchar](500) NULL,
	[FileType] [nvarchar](100) NULL,
	[RowHash] [nvarchar](64) NULL,
	[LabID] [nvarchar](500) NULL,
	[LabName] [nvarchar](500) NULL,
	[ClaimID] [nvarchar](500) NULL,
	[AccessionNumber] [nvarchar](500) NULL,
	[SourceFileID] [nvarchar](1000) NULL,
	[IngestedOn] [nvarchar](500) NULL,
	[CsvRowHash] [nvarchar](500) NULL,
	[PayerName_Raw] [nvarchar](500) NULL,
	[PayerName] [nvarchar](500) NULL,
	[Payer_Code] [nvarchar](500) NULL,
	[Payer_Common_Code] [nvarchar](500) NULL,
	[Payer_Group_Code] [nvarchar](500) NULL,
	[Global_Payer_ID] [nvarchar](500) NULL,
	[PayerType] [nvarchar](500) NULL,
	[BillingProvider] [nvarchar](500) NULL,
	[ReferringProvider] [nvarchar](500) NULL,
	[ClinicName] [nvarchar](500) NULL,
	[SalesRepname] [nvarchar](500) NULL,
	[PatientID] [nvarchar](500) NULL,
	[PatientDOB] [nvarchar](500) NULL,
	[DateofService] [nvarchar](500) NULL,
	[ChargeEnteredDate] [nvarchar](500) NULL,
	[FirstBilledDate] [nvarchar](500) NULL,
	[Panelname] [nvarchar](500) NULL,
	[CPTCodeXUnitsXModifier] [nvarchar](max) NULL,
	[POS] [nvarchar](500) NULL,
	[TOS] [nvarchar](500) NULL,
	[ChargeAmount] [nvarchar](500) NULL,
	[AllowedAmount] [nvarchar](500) NULL,
	[InsurancePayment] [nvarchar](500) NULL,
	[PatientPayment] [nvarchar](500) NULL,
	[TotalPayments] [nvarchar](500) NULL,
	[InsuranceAdjustments] [nvarchar](500) NULL,
	[PatientAdjustments] [nvarchar](500) NULL,
	[TotalAdjustments] [nvarchar](500) NULL,
	[InsuranceBalance] [nvarchar](500) NULL,
	[PatientBalance] [nvarchar](500) NULL,
	[TotalBalance] [nvarchar](500) NULL,
	[CheckDate] [nvarchar](500) NULL,
	[ClaimStatus] [nvarchar](500) NULL,
	[DenialCode] [nvarchar](max) NULL,
	[ICDCode] [nvarchar](500) NULL,
	[DaystoDOS] [nvarchar](500) NULL,
	[RollingDays] [nvarchar](500) NULL,
	[DaystoBill] [nvarchar](500) NULL,
	[DaystoPost] [nvarchar](500) NULL,
	[ICDPointer] [nvarchar](500) NULL,
	[InsertedDateTime] [datetime] NOT NULL,
	[CPTCodeXUnitsXModifierOrginal] [nvarchar](max) NULL,
	[T_F] [nvarchar](100) NULL,
	[UID] [nvarchar](500) NULL,
	[Facility] [nvarchar](500) NULL,
	[PatientName] [nvarchar](1000) NULL,
	[SubscriberId] [nvarchar](1000) NULL,
	[AgingDOS] [nvarchar](100) NULL,
	[EndDOS] [nvarchar](500) NULL,
	[AgingDOE] [nvarchar](100) NULL,
	[BilledWeek] [nvarchar](500) NULL,
	[ProcedureField] [nvarchar](max) NULL,
	[Units] [nvarchar](500) NULL,
	[LineLevelCPT] [nvarchar](max) NULL,
	[DODWeek] [nvarchar](500) NULL,
	[DenialDate] [nvarchar](500) NULL,
	[DeniedWeek] [nvarchar](500) NULL,
	[LineLevelDenialCode] [nvarchar](max) NULL,
	[LineLevelICD] [nvarchar](max) NULL,
	[ModifierField] [nvarchar](500) NULL,
	[TotalWO] [nvarchar](500) NULL,
	[TotalPayment] [nvarchar](500) NULL,
	[PaymentPercent] [nvarchar](100) NULL,
	[BillStatus] [nvarchar](200) NULL,
	[FullyPaidCount] [nvarchar](500) NULL,
	[FullyPaidAmount] [nvarchar](500) NULL,
	[AdjucticatedCount] [nvarchar](500) NULL,
	[AdjucticatedAmount] [nvarchar](500) NULL,
	[Bucket30Count] [nvarchar](500) NULL,
	[Bucket30Amount] [nvarchar](500) NULL,
	[Bucket60Count] [nvarchar](500) NULL,
	[Bucket60Amount] [nvarchar](500) NULL,
	[Aging] [nvarchar](100) NULL,
	[LISPatientName] [nvarchar](1000) NULL,
	[PanelType] [nvarchar](max) NULL,
	[EnteredWeek] [nvarchar](500) NULL,
	[EnteredStatus] [nvarchar](1000) NULL,
	[LastActivityDate] [nvarchar](100) NULL,
	[EmedixSubmissionDate] [nvarchar](100) NULL,
	[ClaimType] [nvarchar](max) NULL,
	[BilledStatus] [nvarchar](max) NULL,
	[PostedWeek] [nvarchar](500) NULL,
	[ModField] [nvarchar](100) NULL,
	[CheqNo] [nvarchar](500) NULL,
	[DuplicatePaymentPosted] [nvarchar](100) NULL,
	[ActualPayment] [nvarchar](500) NULL,
	[ProcTotalBal] [nvarchar](500) NULL,
	[DeniedStatus] [nvarchar](500) NULL,
	[ScrubberEditReason] [nvarchar](max) NULL,
	[EmedixRejectionDate] [nvarchar](100) NULL,
	[EmedixRejection] [nvarchar](max) NULL,
	[RejectionCategory] [nvarchar](max) NULL,
	[TimeToPay] [nvarchar](500) NULL,
	[Adjudicated] [nvarchar](500) NULL,
	[AdjudicatedAmount] [nvarchar](500) NULL,
	[Bucket30] [nvarchar](500) NULL,
	[Bucket60] [nvarchar](500) NULL,
PRIMARY KEY CLUSTERED 
(
	[RecordId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO

ALTER TABLE [dbo].[ClaimLevelData] ADD  DEFAULT (getdate()) FOR [InsertedDateTime]
GO


USE [CoveLRN]
GO

/****** Object:  Table [dbo].[LineLevelData]    Script Date: 8/1/2026 7:10:50 AM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[LineLevelData](
	[RecordId] [int] IDENTITY(1,1) NOT NULL,
	[FileLogId] [nvarchar](500) NULL,
	[RunId] [nvarchar](500) NULL,
	[WeekFolder] [nvarchar](500) NULL,
	[SourceFullPath] [nvarchar](1000) NULL,
	[FileName] [nvarchar](500) NULL,
	[FileType] [nvarchar](100) NULL,
	[RowHash] [nvarchar](64) NULL,
	[LabID] [nvarchar](500) NULL,
	[LabName] [nvarchar](500) NULL,
	[ClaimID] [nvarchar](500) NULL,
	[AccessionNumber] [nvarchar](500) NULL,
	[SourceFileID] [nvarchar](1000) NULL,
	[IngestedOn] [nvarchar](500) NULL,
	[CsvRowHash] [nvarchar](500) NULL,
	[PayerName_Raw] [nvarchar](500) NULL,
	[PayerName] [nvarchar](500) NULL,
	[Payer_Code] [nvarchar](500) NULL,
	[Payer_Common_Code] [nvarchar](500) NULL,
	[Payer_Group_Code] [nvarchar](500) NULL,
	[Global_Payer_ID] [nvarchar](500) NULL,
	[PayerType] [nvarchar](500) NULL,
	[BillingProvider] [nvarchar](500) NULL,
	[ReferringProvider] [nvarchar](500) NULL,
	[ClinicName] [nvarchar](500) NULL,
	[SalesRepname] [nvarchar](500) NULL,
	[PatientID] [nvarchar](500) NULL,
	[PatientDOB] [nvarchar](500) NULL,
	[DateofService] [nvarchar](500) NULL,
	[ChargeEnteredDate] [nvarchar](500) NULL,
	[FirstBilledDate] [nvarchar](500) NULL,
	[Panelname] [nvarchar](500) NULL,
	[CPTCode] [nvarchar](max) NULL,
	[Units] [nvarchar](500) NULL,
	[Modifier] [nvarchar](500) NULL,
	[POS] [nvarchar](500) NULL,
	[TOS] [nvarchar](500) NULL,
	[ChargeAmount] [nvarchar](500) NULL,
	[ChargeAmountPerUnit] [nvarchar](500) NULL,
	[AllowedAmount] [nvarchar](500) NULL,
	[AllowedAmountPerUnit] [nvarchar](500) NULL,
	[InsurancePayment] [nvarchar](500) NULL,
	[InsurancePaymentPerUnit] [nvarchar](500) NULL,
	[PatientPayment] [nvarchar](500) NULL,
	[PatientPaymentPerUnit] [nvarchar](500) NULL,
	[TotalPayments] [nvarchar](500) NULL,
	[InsuranceAdjustments] [nvarchar](500) NULL,
	[PatientAdjustments] [nvarchar](500) NULL,
	[TotalAdjustments] [nvarchar](500) NULL,
	[InsuranceBalance] [nvarchar](500) NULL,
	[PatientBalance] [nvarchar](500) NULL,
	[PatientBalancePerUnit] [nvarchar](500) NULL,
	[TotalBalance] [nvarchar](500) NULL,
	[CheckDate] [nvarchar](500) NULL,
	[PostingDate] [nvarchar](500) NULL,
	[ClaimStatus] [nvarchar](500) NULL,
	[PayStatus] [nvarchar](500) NULL,
	[DenialCode] [nvarchar](max) NULL,
	[DenialDate] [nvarchar](500) NULL,
	[ICDCode] [nvarchar](500) NULL,
	[DaystoDOS] [nvarchar](500) NULL,
	[RollingDays] [nvarchar](500) NULL,
	[DaystoBill] [nvarchar](500) NULL,
	[DaystoPost] [nvarchar](500) NULL,
	[ICDPointer] [nvarchar](500) NULL,
	[InsertedDateTime] [datetime] NOT NULL,
	[PaymentPostedDate] [nvarchar](500) NULL,
	[T_F] [nvarchar](100) NULL,
	[UID] [nvarchar](500) NULL,
	[Facility] [nvarchar](500) NULL,
	[PatientName] [nvarchar](1000) NULL,
	[SubscriberId] [nvarchar](500) NULL,
	[AgingDOS] [nvarchar](100) NULL,
	[EndDOS] [nvarchar](500) NULL,
	[AgingDOE] [nvarchar](100) NULL,
	[BilledWeek] [nvarchar](500) NULL,
	[LineLevelCPT] [nvarchar](max) NULL,
	[DODWeek] [nvarchar](500) NULL,
	[DeniedWeek] [nvarchar](500) NULL,
	[LineLevelDenialCode] [nvarchar](max) NULL,
	[PaymentPercent] [nvarchar](100) NULL,
PRIMARY KEY CLUSTERED 
(
	[RecordId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO

ALTER TABLE [dbo].[LineLevelData] ADD  DEFAULT (getdate()) FOR [InsertedDateTime]
GO


USE [Elixir_LRN]
GO

/****** Object:  Table [dbo].[ClaimLevelData]    Script Date: 8/1/2026 7:11:28 AM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[ClaimLevelData](
	[RecordId] [int] IDENTITY(1,1) NOT NULL,
	[FileLogId] [nvarchar](500) NULL,
	[RunId] [nvarchar](500) NULL,
	[WeekFolder] [nvarchar](500) NULL,
	[SourceFullPath] [nvarchar](1000) NULL,
	[FileName] [nvarchar](500) NULL,
	[FileType] [nvarchar](100) NULL,
	[RowHash] [nvarchar](64) NULL,
	[LabID] [nvarchar](500) NULL,
	[LabName] [nvarchar](500) NULL,
	[ClaimID] [nvarchar](500) NULL,
	[AccessionNumber] [nvarchar](500) NULL,
	[SourceFileID] [nvarchar](1000) NULL,
	[IngestedOn] [nvarchar](500) NULL,
	[CsvRowHash] [nvarchar](500) NULL,
	[PayerName_Raw] [nvarchar](500) NULL,
	[PayerName] [nvarchar](500) NULL,
	[Payer_Code] [nvarchar](500) NULL,
	[Payer_Common_Code] [nvarchar](500) NULL,
	[Payer_Group_Code] [nvarchar](500) NULL,
	[Global_Payer_ID] [nvarchar](500) NULL,
	[PayerType] [nvarchar](500) NULL,
	[BillingProvider] [nvarchar](500) NULL,
	[ReferringProvider] [nvarchar](500) NULL,
	[ClinicName] [nvarchar](500) NULL,
	[SalesRepname] [nvarchar](500) NULL,
	[PatientID] [nvarchar](500) NULL,
	[PatientDOB] [nvarchar](500) NULL,
	[DateofService] [nvarchar](500) NULL,
	[ChargeEnteredDate] [nvarchar](500) NULL,
	[FirstBilledDate] [nvarchar](500) NULL,
	[Panelname] [nvarchar](500) NULL,
	[CPTCodeXUnitsXModifier] [nvarchar](max) NULL,
	[POS] [nvarchar](500) NULL,
	[TOS] [nvarchar](500) NULL,
	[ChargeAmount] [nvarchar](500) NULL,
	[AllowedAmount] [nvarchar](500) NULL,
	[InsurancePayment] [nvarchar](500) NULL,
	[PatientPayment] [nvarchar](500) NULL,
	[TotalPayments] [nvarchar](500) NULL,
	[InsuranceAdjustments] [nvarchar](500) NULL,
	[PatientAdjustments] [nvarchar](500) NULL,
	[TotalAdjustments] [nvarchar](500) NULL,
	[InsuranceBalance] [nvarchar](500) NULL,
	[PatientBalance] [nvarchar](500) NULL,
	[TotalBalance] [nvarchar](500) NULL,
	[CheckDate] [nvarchar](500) NULL,
	[ClaimStatus] [nvarchar](500) NULL,
	[DenialCode] [nvarchar](max) NULL,
	[ICDCode] [nvarchar](500) NULL,
	[DaystoDOS] [nvarchar](500) NULL,
	[RollingDays] [nvarchar](500) NULL,
	[DaystoBill] [nvarchar](500) NULL,
	[DaystoPost] [nvarchar](500) NULL,
	[ICDPointer] [nvarchar](500) NULL,
	[InsertedDateTime] [datetime] NOT NULL,
	[CPTCodeXUnitsXModifierOrginal] [nvarchar](max) NULL,
	[T_F] [nvarchar](100) NULL,
	[PatientFirstName] [nvarchar](500) NULL,
	[PatientLastName] [nvarchar](500) NULL,
	[PatientAddress] [nvarchar](max) NULL,
	[Coverage] [nvarchar](500) NULL,
	[AgingDOS] [nvarchar](100) NULL,
	[ServiceToDate] [nvarchar](500) NULL,
	[AgingDOE] [nvarchar](100) NULL,
	[Facility] [nvarchar](500) NULL,
	[ServiceLocationCode] [nvarchar](500) NULL,
	[ServiceLocationName] [nvarchar](500) NULL,
	[PrimarySubId] [nvarchar](500) NULL,
	[ICDField] [nvarchar](max) NULL,
	[DODWeek] [nvarchar](500) NULL,
	[BilledWeek] [nvarchar](500) NULL,
	[DenialReason] [nvarchar](max) NULL,
	[BillingOption] [nvarchar](200) NULL,
	[CurrentStatus] [nvarchar](200) NULL,
	[BatchNo] [nvarchar](500) NULL,
	[CreatedOn] [nvarchar](100) NULL,
	[CreatedBy] [nvarchar](500) NULL,
	[UpdatedOn] [nvarchar](100) NULL,
	[UpdatedBy] [nvarchar](500) NULL,
	[BillStatus] [nvarchar](200) NULL,
	[PaymentPercent] [nvarchar](100) NULL,
	[FullyPaidCount] [nvarchar](500) NULL,
	[FullyPaidAmount] [nvarchar](500) NULL,
	[AdjucticatedCount] [nvarchar](500) NULL,
	[AdjucticatedAmount] [nvarchar](500) NULL,
	[Bucket30Count] [nvarchar](500) NULL,
	[Bucket30Amount] [nvarchar](500) NULL,
	[Bucket60Count] [nvarchar](500) NULL,
	[Bucket60Amount] [nvarchar](500) NULL,
PRIMARY KEY CLUSTERED 
(
	[RecordId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO

ALTER TABLE [dbo].[ClaimLevelData] ADD  DEFAULT (getdate()) FOR [InsertedDateTime]
GO


USE [Elixir_LRN]
GO

/****** Object:  Table [dbo].[LineLevelData]    Script Date: 8/1/2026 7:11:41 AM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[LineLevelData](
	[RecordId] [int] IDENTITY(1,1) NOT NULL,
	[FileLogId] [nvarchar](500) NULL,
	[RunId] [nvarchar](500) NULL,
	[WeekFolder] [nvarchar](500) NULL,
	[SourceFullPath] [nvarchar](1000) NULL,
	[FileName] [nvarchar](500) NULL,
	[FileType] [nvarchar](100) NULL,
	[RowHash] [nvarchar](64) NULL,
	[LabID] [nvarchar](500) NULL,
	[LabName] [nvarchar](500) NULL,
	[ClaimID] [nvarchar](500) NULL,
	[AccessionNumber] [nvarchar](500) NULL,
	[SourceFileID] [nvarchar](1000) NULL,
	[IngestedOn] [nvarchar](500) NULL,
	[CsvRowHash] [nvarchar](500) NULL,
	[PayerName_Raw] [nvarchar](500) NULL,
	[PayerName] [nvarchar](500) NULL,
	[Payer_Code] [nvarchar](500) NULL,
	[Payer_Common_Code] [nvarchar](500) NULL,
	[Payer_Group_Code] [nvarchar](500) NULL,
	[Global_Payer_ID] [nvarchar](500) NULL,
	[PayerType] [nvarchar](500) NULL,
	[BillingProvider] [nvarchar](500) NULL,
	[ReferringProvider] [nvarchar](500) NULL,
	[ClinicName] [nvarchar](500) NULL,
	[SalesRepname] [nvarchar](500) NULL,
	[PatientID] [nvarchar](500) NULL,
	[PatientDOB] [nvarchar](500) NULL,
	[DateofService] [nvarchar](500) NULL,
	[ChargeEnteredDate] [nvarchar](500) NULL,
	[FirstBilledDate] [nvarchar](500) NULL,
	[Panelname] [nvarchar](500) NULL,
	[CPTCode] [nvarchar](500) NULL,
	[Units] [nvarchar](500) NULL,
	[Modifier] [nvarchar](500) NULL,
	[POS] [nvarchar](500) NULL,
	[TOS] [nvarchar](500) NULL,
	[ChargeAmount] [nvarchar](500) NULL,
	[ChargeAmountPerUnit] [nvarchar](500) NULL,
	[AllowedAmount] [nvarchar](500) NULL,
	[AllowedAmountPerUnit] [nvarchar](500) NULL,
	[InsurancePayment] [nvarchar](500) NULL,
	[InsurancePaymentPerUnit] [nvarchar](500) NULL,
	[PatientPayment] [nvarchar](500) NULL,
	[PatientPaymentPerUnit] [nvarchar](500) NULL,
	[TotalPayments] [nvarchar](500) NULL,
	[InsuranceAdjustments] [nvarchar](500) NULL,
	[PatientAdjustments] [nvarchar](500) NULL,
	[TotalAdjustments] [nvarchar](500) NULL,
	[InsuranceBalance] [nvarchar](500) NULL,
	[PatientBalance] [nvarchar](500) NULL,
	[PatientBalancePerUnit] [nvarchar](500) NULL,
	[TotalBalance] [nvarchar](500) NULL,
	[CheckDate] [nvarchar](500) NULL,
	[PostingDate] [nvarchar](500) NULL,
	[ClaimStatus] [nvarchar](500) NULL,
	[PayStatus] [nvarchar](500) NULL,
	[DenialCode] [nvarchar](max) NULL,
	[DenialDate] [nvarchar](500) NULL,
	[ICDCode] [nvarchar](500) NULL,
	[DaystoDOS] [nvarchar](500) NULL,
	[RollingDays] [nvarchar](500) NULL,
	[DaystoBill] [nvarchar](500) NULL,
	[DaystoPost] [nvarchar](500) NULL,
	[ICDPointer] [nvarchar](500) NULL,
	[InsertedDateTime] [datetime] NOT NULL,
	[PaymentPostedDate] [nvarchar](500) NULL,
	[T_F] [nvarchar](100) NULL,
	[VisitXCptXMod] [nvarchar](max) NULL,
	[UID] [nvarchar](500) NULL,
	[PatientFirstName] [nvarchar](500) NULL,
	[PatientLastName] [nvarchar](500) NULL,
	[AgingDOS] [nvarchar](100) NULL,
	[ServiceToDate] [nvarchar](500) NULL,
	[AgingDOE] [nvarchar](100) NULL,
	[OrderingPhysicianFirstName] [nvarchar](500) NULL,
	[ServiceLocationCode] [nvarchar](500) NULL,
	[PrimarySubId] [nvarchar](500) NULL,
	[CptXModXUnits] [nvarchar](max) NULL,
	[ServiceChargeAmount] [nvarchar](500) NULL,
	[LineLevelDenialCode] [nvarchar](max) NULL,
	[DenialReason] [nvarchar](max) NULL,
	[BillingOption] [nvarchar](200) NULL,
	[BillStatus] [nvarchar](200) NULL,
	[BatchNo] [nvarchar](500) NULL,
	[CreatedOn] [nvarchar](100) NULL,
	[CreatedBy] [nvarchar](500) NULL,
	[UpdatedOn] [nvarchar](100) NULL,
	[UpdatedBy] [nvarchar](500) NULL,
	[PaymentPercent] [nvarchar](100) NULL,
PRIMARY KEY CLUSTERED 
(
	[RecordId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO

ALTER TABLE [dbo].[LineLevelData] ADD  DEFAULT (getdate()) FOR [InsertedDateTime]
GO


USE [InHealthDTRLRN]
GO

/****** Object:  Table [dbo].[ClaimLevelData]    Script Date: 8/1/2026 7:12:20 AM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[ClaimLevelData](
	[RecordId] [int] IDENTITY(1,1) NOT NULL,
	[FileLogId] [nvarchar](500) NULL,
	[RunId] [nvarchar](500) NULL,
	[WeekFolder] [nvarchar](500) NULL,
	[SourceFullPath] [nvarchar](1000) NULL,
	[FileName] [nvarchar](500) NULL,
	[FileType] [nvarchar](100) NULL,
	[RowHash] [nvarchar](64) NULL,
	[LabID] [nvarchar](500) NULL,
	[LabName] [nvarchar](500) NULL,
	[ClaimID] [nvarchar](500) NULL,
	[AccessionNumber] [nvarchar](500) NULL,
	[SourceFileID] [nvarchar](1000) NULL,
	[IngestedOn] [nvarchar](500) NULL,
	[CsvRowHash] [nvarchar](500) NULL,
	[PayerName_Raw] [nvarchar](500) NULL,
	[PayerName] [nvarchar](500) NULL,
	[Payer_Code] [nvarchar](500) NULL,
	[Payer_Common_Code] [nvarchar](500) NULL,
	[Payer_Group_Code] [nvarchar](500) NULL,
	[Global_Payer_ID] [nvarchar](500) NULL,
	[PayerType] [nvarchar](500) NULL,
	[BillingProvider] [nvarchar](500) NULL,
	[ReferringProvider] [nvarchar](500) NULL,
	[ClinicName] [nvarchar](500) NULL,
	[SalesRepname] [nvarchar](500) NULL,
	[PatientID] [nvarchar](500) NULL,
	[PatientDOB] [nvarchar](500) NULL,
	[DateofService] [nvarchar](500) NULL,
	[ChargeEnteredDate] [nvarchar](500) NULL,
	[FirstBilledDate] [nvarchar](500) NULL,
	[Panelname] [nvarchar](500) NULL,
	[CPTCodeXUnitsXModifier] [nvarchar](max) NULL,
	[POS] [nvarchar](500) NULL,
	[TOS] [nvarchar](500) NULL,
	[ChargeAmount] [nvarchar](500) NULL,
	[AllowedAmount] [nvarchar](500) NULL,
	[InsurancePayment] [nvarchar](500) NULL,
	[PatientPayment] [nvarchar](500) NULL,
	[TotalPayments] [nvarchar](500) NULL,
	[InsuranceAdjustments] [nvarchar](500) NULL,
	[PatientAdjustments] [nvarchar](500) NULL,
	[TotalAdjustments] [nvarchar](500) NULL,
	[InsuranceBalance] [nvarchar](500) NULL,
	[PatientBalance] [nvarchar](500) NULL,
	[TotalBalance] [nvarchar](500) NULL,
	[CheckDate] [nvarchar](500) NULL,
	[ClaimStatus] [nvarchar](500) NULL,
	[DenialCode] [nvarchar](max) NULL,
	[ICDCode] [nvarchar](500) NULL,
	[DaystoDOS] [nvarchar](500) NULL,
	[RollingDays] [nvarchar](500) NULL,
	[DaystoBill] [nvarchar](500) NULL,
	[DaystoPost] [nvarchar](500) NULL,
	[ICDPointer] [nvarchar](500) NULL,
	[InsertedDateTime] [datetime] NOT NULL,
	[DOE_Year] [nvarchar](20) NULL,
	[DOE_Month] [nvarchar](20) NULL,
	[AgingBucket] [nvarchar](200) NULL,
	[BilledUnbilled] [nvarchar](100) NULL,
	[Modifier] [nvarchar](500) NULL,
	[CPTCode] [nvarchar](500) NULL,
	[Units] [nvarchar](500) NULL,
	[CPTCodeXUnitsXModifierOrginal] [nvarchar](max) NULL,
	[PaymentPercent] [nvarchar](100) NULL,
	[AdjudicatedCount] [nvarchar](500) NULL,
	[Days30Count] [nvarchar](500) NULL,
	[Days30Amount] [nvarchar](500) NULL,
	[Days60Count] [nvarchar](500) NULL,
	[Days60Amount] [nvarchar](500) NULL,
	[FullyPaidCount] [nvarchar](500) NULL,
	[FullyPaidAmount] [nvarchar](500) NULL,
	[AdjudicatedAmount] [nvarchar](500) NULL,
	[PatientName] [nvarchar](1000) NULL,
	[BilledWeek] [nvarchar](500) NULL,
	[PostedWeek] [nvarchar](500) NULL,
	[PanelNameLIS] [nvarchar](500) NULL,
	[PanelNameBasedOnCPT] [nvarchar](500) NULL,
	[TotalWO] [nvarchar](500) NULL,
	[BillStatus] [nvarchar](200) NULL,
	[AgingDOS] [nvarchar](100) NULL,
	[AgingDOE] [nvarchar](100) NULL,
	[ResponsibleParty] [nvarchar](500) NULL,
	[SubscriberID] [nvarchar](500) NULL,
	[ClientAccNum] [nvarchar](500) NULL,
	[EndDOS] [nvarchar](500) NULL,
	[DODWeek] [nvarchar](500) NULL,
	[CheckNumber] [nvarchar](500) NULL,
	[LineLevelICD] [nvarchar](max) NULL,
	[Facility] [nvarchar](500) NULL,
PRIMARY KEY CLUSTERED 
(
	[RecordId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO

ALTER TABLE [dbo].[ClaimLevelData] ADD  DEFAULT (getdate()) FOR [InsertedDateTime]
GO


USE [InHealthDTRLRN]
GO

/****** Object:  Table [dbo].[LineLevelData]    Script Date: 8/1/2026 7:12:43 AM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[LineLevelData](
	[RecordId] [int] IDENTITY(1,1) NOT NULL,
	[FileLogId] [nvarchar](500) NULL,
	[RunId] [nvarchar](500) NULL,
	[WeekFolder] [nvarchar](500) NULL,
	[SourceFullPath] [nvarchar](1000) NULL,
	[FileName] [nvarchar](500) NULL,
	[FileType] [nvarchar](100) NULL,
	[RowHash] [nvarchar](64) NULL,
	[LabID] [nvarchar](500) NULL,
	[LabName] [nvarchar](500) NULL,
	[ClaimID] [nvarchar](500) NULL,
	[AccessionNumber] [nvarchar](500) NULL,
	[SourceFileID] [nvarchar](1000) NULL,
	[IngestedOn] [nvarchar](500) NULL,
	[CsvRowHash] [nvarchar](500) NULL,
	[PayerName_Raw] [nvarchar](500) NULL,
	[PayerName] [nvarchar](500) NULL,
	[Payer_Code] [nvarchar](500) NULL,
	[Payer_Common_Code] [nvarchar](500) NULL,
	[Payer_Group_Code] [nvarchar](500) NULL,
	[Global_Payer_ID] [nvarchar](500) NULL,
	[PayerType] [nvarchar](500) NULL,
	[BillingProvider] [nvarchar](500) NULL,
	[ReferringProvider] [nvarchar](500) NULL,
	[ClinicName] [nvarchar](500) NULL,
	[SalesRepname] [nvarchar](500) NULL,
	[PatientID] [nvarchar](500) NULL,
	[PatientDOB] [nvarchar](500) NULL,
	[DateofService] [nvarchar](500) NULL,
	[ChargeEnteredDate] [nvarchar](500) NULL,
	[FirstBilledDate] [nvarchar](500) NULL,
	[Panelname] [nvarchar](500) NULL,
	[CPTCode] [nvarchar](500) NULL,
	[Units] [nvarchar](500) NULL,
	[Modifier] [nvarchar](500) NULL,
	[POS] [nvarchar](500) NULL,
	[TOS] [nvarchar](500) NULL,
	[ChargeAmount] [nvarchar](500) NULL,
	[ChargeAmountPerUnit] [nvarchar](500) NULL,
	[AllowedAmount] [nvarchar](500) NULL,
	[AllowedAmountPerUnit] [nvarchar](500) NULL,
	[InsurancePayment] [nvarchar](500) NULL,
	[InsurancePaymentPerUnit] [nvarchar](500) NULL,
	[PatientPayment] [nvarchar](500) NULL,
	[PatientPaymentPerUnit] [nvarchar](500) NULL,
	[TotalPayments] [nvarchar](500) NULL,
	[InsuranceAdjustments] [nvarchar](500) NULL,
	[PatientAdjustments] [nvarchar](500) NULL,
	[TotalAdjustments] [nvarchar](500) NULL,
	[InsuranceBalance] [nvarchar](500) NULL,
	[PatientBalance] [nvarchar](500) NULL,
	[PatientBalancePerUnit] [nvarchar](500) NULL,
	[TotalBalance] [nvarchar](500) NULL,
	[CheckDate] [nvarchar](500) NULL,
	[PostingDate] [nvarchar](500) NULL,
	[ClaimStatus] [nvarchar](500) NULL,
	[PayStatus] [nvarchar](500) NULL,
	[DenialCode] [nvarchar](max) NULL,
	[DenialDate] [nvarchar](500) NULL,
	[ICDCode] [nvarchar](500) NULL,
	[DaystoDOS] [nvarchar](500) NULL,
	[RollingDays] [nvarchar](500) NULL,
	[DaystoBill] [nvarchar](500) NULL,
	[DaystoPost] [nvarchar](500) NULL,
	[ICDPointer] [nvarchar](500) NULL,
	[InsertedDateTime] [datetime] NOT NULL,
	[PatientName] [nvarchar](1000) NULL,
	[PaymentPostedDate] [nvarchar](100) NULL,
	[ResponsibleParty] [nvarchar](500) NULL,
	[SubscriberID] [nvarchar](500) NULL,
	[EndDOS] [nvarchar](100) NULL,
	[BillOccurance] [nvarchar](100) NULL,
	[EntryUser] [nvarchar](500) NULL,
	[CPTUnits] [nvarchar](500) NULL,
	[CPTMOD] [nvarchar](500) NULL,
	[CPTs] [nvarchar](500) NULL,
	[PostedWeek] [nvarchar](100) NULL,
	[CPTXUnitsxMod] [nvarchar](max) NULL,
	[PaymentPercent] [nvarchar](100) NULL,
	[Facility] [nvarchar](500) NULL,
	[ClientAccNum] [nvarchar](500) NULL,
PRIMARY KEY CLUSTERED 
(
	[RecordId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO

ALTER TABLE [dbo].[LineLevelData] ADD  DEFAULT (getdate()) FOR [InsertedDateTime]
GO


USE [NWL_LRN]
GO

/****** Object:  Table [dbo].[ClaimLevelData]    Script Date: 8/1/2026 7:13:08 AM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[ClaimLevelData](
	[RecordId] [int] IDENTITY(1,1) NOT NULL,
	[FileLogId] [nvarchar](500) NULL,
	[RunId] [nvarchar](500) NULL,
	[WeekFolder] [nvarchar](500) NULL,
	[SourceFullPath] [nvarchar](1000) NULL,
	[FileName] [nvarchar](500) NULL,
	[FileType] [nvarchar](100) NULL,
	[RowHash] [nvarchar](64) NULL,
	[LabID] [nvarchar](500) NULL,
	[LabName] [nvarchar](500) NULL,
	[ClaimID] [nvarchar](500) NULL,
	[AccessionNumber] [nvarchar](500) NULL,
	[SourceFileID] [nvarchar](1000) NULL,
	[IngestedOn] [nvarchar](500) NULL,
	[CsvRowHash] [nvarchar](500) NULL,
	[PayerName_Raw] [nvarchar](500) NULL,
	[PayerName] [nvarchar](500) NULL,
	[Payer_Code] [nvarchar](500) NULL,
	[Payer_Common_Code] [nvarchar](500) NULL,
	[Payer_Group_Code] [nvarchar](500) NULL,
	[Global_Payer_ID] [nvarchar](500) NULL,
	[PayerType] [nvarchar](500) NULL,
	[BillingProvider] [nvarchar](500) NULL,
	[ReferringProvider] [nvarchar](500) NULL,
	[ClinicName] [nvarchar](500) NULL,
	[SalesRepname] [nvarchar](500) NULL,
	[PatientID] [nvarchar](500) NULL,
	[PatientDOB] [nvarchar](500) NULL,
	[DateofService] [nvarchar](500) NULL,
	[ChargeEnteredDate] [nvarchar](500) NULL,
	[FirstBilledDate] [nvarchar](500) NULL,
	[Panelname] [nvarchar](500) NULL,
	[CPTCodeXUnitsXModifier] [nvarchar](max) NULL,
	[POS] [nvarchar](500) NULL,
	[TOS] [nvarchar](500) NULL,
	[ChargeAmount] [nvarchar](500) NULL,
	[AllowedAmount] [nvarchar](500) NULL,
	[InsurancePayment] [nvarchar](500) NULL,
	[PatientPayment] [nvarchar](500) NULL,
	[TotalPayments] [nvarchar](500) NULL,
	[InsuranceAdjustments] [nvarchar](500) NULL,
	[PatientAdjustments] [nvarchar](500) NULL,
	[TotalAdjustments] [nvarchar](500) NULL,
	[InsuranceBalance] [nvarchar](500) NULL,
	[PatientBalance] [nvarchar](500) NULL,
	[TotalBalance] [nvarchar](500) NULL,
	[CheckDate] [nvarchar](500) NULL,
	[ClaimStatus] [nvarchar](500) NULL,
	[DenialCode] [nvarchar](max) NULL,
	[ICDCode] [nvarchar](500) NULL,
	[DaystoDOS] [nvarchar](500) NULL,
	[RollingDays] [nvarchar](500) NULL,
	[DaystoBill] [nvarchar](500) NULL,
	[DaystoPost] [nvarchar](500) NULL,
	[ICDPointer] [nvarchar](500) NULL,
	[InsertedDateTime] [datetime] NOT NULL,
	[InsuranceBalance_Decimal]  AS (TRY_CAST([InsuranceBalance] AS [decimal](18,2))) PERSISTED,
	[UID] [nvarchar](500) NULL,
	[Aging] [nvarchar](100) NULL,
	[PatientName] [nvarchar](1000) NULL,
	[LISPatientName] [nvarchar](1000) NULL,
	[SubscriberId] [nvarchar](1000) NULL,
	[PanelType] [nvarchar](max) NULL,
	[EnteredWeek] [nvarchar](500) NULL,
	[EnteredStatus] [nvarchar](1000) NULL,
	[LastActivityDate] [nvarchar](100) NULL,
	[EmedixSubmissionDate] [nvarchar](100) NULL,
	[ClaimType] [nvarchar](max) NULL,
	[BilledStatus] [nvarchar](max) NULL,
	[BilledWeek] [nvarchar](500) NULL,
	[PostedWeek] [nvarchar](500) NULL,
	[ModField] [nvarchar](100) NULL,
	[CheqNo] [nvarchar](500) NULL,
	[DuplicatePaymentPosted] [nvarchar](100) NULL,
	[ActualPayment] [nvarchar](500) NULL,
	[ProcTotalBal] [nvarchar](500) NULL,
	[DeniedStatus] [nvarchar](500) NULL,
	[ScrubberEditReason] [nvarchar](max) NULL,
	[EmedixRejectionDate] [nvarchar](100) NULL,
	[EmedixRejection] [nvarchar](max) NULL,
	[RejectionCategory] [nvarchar](max) NULL,
	[TimeToPay] [nvarchar](500) NULL,
	[PaymentPercent] [nvarchar](100) NULL,
	[FullyPaidCount] [nvarchar](500) NULL,
	[FullyPaidAmount] [nvarchar](500) NULL,
	[Adjudicated] [nvarchar](500) NULL,
	[AdjudicatedAmount] [nvarchar](500) NULL,
	[Bucket30] [nvarchar](500) NULL,
	[Bucket30Amount] [nvarchar](500) NULL,
	[Bucket60] [nvarchar](500) NULL,
	[Bucket60Amount] [nvarchar](500) NULL,
PRIMARY KEY CLUSTERED 
(
	[RecordId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO

ALTER TABLE [dbo].[ClaimLevelData] ADD  DEFAULT (getdate()) FOR [InsertedDateTime]
GO


USE [NWL_LRN]
GO

/****** Object:  Table [dbo].[LineLevelData]    Script Date: 8/1/2026 7:13:24 AM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[LineLevelData](
	[RecordId] [int] IDENTITY(1,1) NOT NULL,
	[FileLogId] [nvarchar](500) NULL,
	[RunId] [nvarchar](500) NULL,
	[WeekFolder] [nvarchar](500) NULL,
	[SourceFullPath] [nvarchar](1000) NULL,
	[FileName] [nvarchar](500) NULL,
	[FileType] [nvarchar](100) NULL,
	[RowHash] [nvarchar](64) NULL,
	[LabID] [nvarchar](500) NULL,
	[LabName] [nvarchar](500) NULL,
	[ClaimID] [nvarchar](500) NULL,
	[AccessionNumber] [nvarchar](500) NULL,
	[SourceFileID] [nvarchar](1000) NULL,
	[IngestedOn] [nvarchar](500) NULL,
	[CsvRowHash] [nvarchar](500) NULL,
	[PayerName_Raw] [nvarchar](500) NULL,
	[PayerName] [nvarchar](500) NULL,
	[Payer_Code] [nvarchar](500) NULL,
	[Payer_Common_Code] [nvarchar](500) NULL,
	[Payer_Group_Code] [nvarchar](500) NULL,
	[Global_Payer_ID] [nvarchar](500) NULL,
	[PayerType] [nvarchar](500) NULL,
	[BillingProvider] [nvarchar](500) NULL,
	[ReferringProvider] [nvarchar](500) NULL,
	[ClinicName] [nvarchar](500) NULL,
	[SalesRepname] [nvarchar](500) NULL,
	[PatientID] [nvarchar](500) NULL,
	[PatientDOB] [nvarchar](500) NULL,
	[DateofService] [nvarchar](500) NULL,
	[ChargeEnteredDate] [nvarchar](500) NULL,
	[FirstBilledDate] [nvarchar](500) NULL,
	[Panelname] [nvarchar](500) NULL,
	[CPTCode] [nvarchar](500) NULL,
	[Units] [nvarchar](500) NULL,
	[Modifier] [nvarchar](500) NULL,
	[POS] [nvarchar](500) NULL,
	[TOS] [nvarchar](500) NULL,
	[ChargeAmount] [nvarchar](500) NULL,
	[ChargeAmountPerUnit] [nvarchar](500) NULL,
	[AllowedAmount] [nvarchar](500) NULL,
	[AllowedAmountPerUnit] [nvarchar](500) NULL,
	[InsurancePayment] [nvarchar](500) NULL,
	[InsurancePaymentPerUnit] [nvarchar](500) NULL,
	[PatientPayment] [nvarchar](500) NULL,
	[PatientPaymentPerUnit] [nvarchar](500) NULL,
	[TotalPayments] [nvarchar](500) NULL,
	[InsuranceAdjustments] [nvarchar](500) NULL,
	[PatientAdjustments] [nvarchar](500) NULL,
	[TotalAdjustments] [nvarchar](500) NULL,
	[InsuranceBalance] [nvarchar](500) NULL,
	[PatientBalance] [nvarchar](500) NULL,
	[PatientBalancePerUnit] [nvarchar](500) NULL,
	[TotalBalance] [nvarchar](500) NULL,
	[CheckDate] [nvarchar](500) NULL,
	[PostingDate] [nvarchar](500) NULL,
	[ClaimStatus] [nvarchar](500) NULL,
	[PayStatus] [nvarchar](500) NULL,
	[DenialCode] [nvarchar](max) NULL,
	[DenialDate] [nvarchar](500) NULL,
	[ICDCode] [nvarchar](500) NULL,
	[DaystoDOS] [nvarchar](500) NULL,
	[RollingDays] [nvarchar](500) NULL,
	[DaystoBill] [nvarchar](500) NULL,
	[DaystoPost] [nvarchar](500) NULL,
	[ICDPointer] [nvarchar](500) NULL,
	[InsertedDateTime] [datetime] NOT NULL,
	[UID] [nvarchar](500) NULL,
	[T_F] [nvarchar](100) NULL,
	[PatientName] [nvarchar](1000) NULL,
	[CombinedLineLevelICD] [nvarchar](max) NULL,
	[SubscriberId] [nvarchar](500) NULL,
	[ClaimAmount] [nvarchar](500) NULL,
	[CptWithUnits] [nvarchar](max) NULL,
	[Proc] [nvarchar](max) NULL,
	[EnteredStatus] [nvarchar](max) NULL,
	[BilledStatus] [nvarchar](max) NULL,
	[ProcTotalBal] [nvarchar](500) NULL,
	[UpdatedDenialCode] [nvarchar](max) NULL,
	[CombinedLineLevelDenialCode] [nvarchar](max) NULL,
	[Loc] [nvarchar](max) NULL,
	[ProcInsLastRefiledDeniedReason] [nvarchar](max) NULL,
	[ProcInsResponsibleCarrierOriginalFilingDate] [nvarchar](100) NULL,
	[ProcInsStatus] [nvarchar](max) NULL,
	[ProcInsLastRefiledDeniedDate] [nvarchar](100) NULL,
PRIMARY KEY CLUSTERED 
(
	[RecordId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO

ALTER TABLE [dbo].[LineLevelData] ADD  DEFAULT (getdate()) FOR [InsertedDateTime]
GO


USE [PCRAL_LRN]
GO

/****** Object:  Table [dbo].[ClaimLevelData]    Script Date: 8/1/2026 7:13:50 AM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[ClaimLevelData](
	[RecordId] [int] IDENTITY(1,1) NOT NULL,
	[FileLogId] [nvarchar](500) NULL,
	[RunId] [nvarchar](500) NULL,
	[WeekFolder] [nvarchar](500) NULL,
	[SourceFullPath] [nvarchar](1000) NULL,
	[FileName] [nvarchar](500) NULL,
	[FileType] [nvarchar](100) NULL,
	[RowHash] [nvarchar](64) NULL,
	[LabID] [nvarchar](500) NULL,
	[LabName] [nvarchar](500) NULL,
	[ClaimID] [nvarchar](500) NULL,
	[AccessionNumber] [nvarchar](500) NULL,
	[SourceFileID] [nvarchar](1000) NULL,
	[IngestedOn] [nvarchar](500) NULL,
	[CsvRowHash] [nvarchar](500) NULL,
	[PayerName_Raw] [nvarchar](500) NULL,
	[PayerName] [nvarchar](500) NULL,
	[Payer_Code] [nvarchar](500) NULL,
	[Payer_Common_Code] [nvarchar](500) NULL,
	[Payer_Group_Code] [nvarchar](500) NULL,
	[Global_Payer_ID] [nvarchar](500) NULL,
	[PayerType] [nvarchar](500) NULL,
	[BillingProvider] [nvarchar](500) NULL,
	[ReferringProvider] [nvarchar](500) NULL,
	[ClinicName] [nvarchar](500) NULL,
	[SalesRepname] [nvarchar](500) NULL,
	[PatientID] [nvarchar](500) NULL,
	[PatientDOB] [nvarchar](500) NULL,
	[DateofService] [nvarchar](500) NULL,
	[ChargeEnteredDate] [nvarchar](500) NULL,
	[FirstBilledDate] [nvarchar](500) NULL,
	[Panelname] [nvarchar](500) NULL,
	[CPTCodeXUnitsXModifier] [nvarchar](max) NULL,
	[POS] [nvarchar](500) NULL,
	[TOS] [nvarchar](500) NULL,
	[ChargeAmount] [nvarchar](500) NULL,
	[AllowedAmount] [nvarchar](500) NULL,
	[InsurancePayment] [nvarchar](500) NULL,
	[PatientPayment] [nvarchar](500) NULL,
	[TotalPayments] [nvarchar](500) NULL,
	[InsuranceAdjustments] [nvarchar](500) NULL,
	[PatientAdjustments] [nvarchar](500) NULL,
	[TotalAdjustments] [nvarchar](500) NULL,
	[InsuranceBalance] [nvarchar](500) NULL,
	[PatientBalance] [nvarchar](500) NULL,
	[TotalBalance] [nvarchar](500) NULL,
	[CheckDate] [nvarchar](500) NULL,
	[ClaimStatus] [nvarchar](500) NULL,
	[DenialCode] [nvarchar](max) NULL,
	[ICDCode] [nvarchar](500) NULL,
	[DaystoDOS] [nvarchar](500) NULL,
	[RollingDays] [nvarchar](500) NULL,
	[DaystoBill] [nvarchar](500) NULL,
	[DaystoPost] [nvarchar](500) NULL,
	[ICDPointer] [nvarchar](500) NULL,
	[InsertedDateTime] [datetime] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[RecordId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO

ALTER TABLE [dbo].[ClaimLevelData] ADD  DEFAULT (getdate()) FOR [InsertedDateTime]
GO


USE [PCRAL_LRN]
GO

/****** Object:  Table [dbo].[LineLevelData]    Script Date: 8/1/2026 7:14:11 AM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[LineLevelData](
	[RecordId] [int] IDENTITY(1,1) NOT NULL,
	[FileLogId] [nvarchar](500) NULL,
	[RunId] [nvarchar](500) NULL,
	[WeekFolder] [nvarchar](500) NULL,
	[SourceFullPath] [nvarchar](1000) NULL,
	[FileName] [nvarchar](500) NULL,
	[FileType] [nvarchar](100) NULL,
	[RowHash] [nvarchar](64) NULL,
	[LabID] [nvarchar](500) NULL,
	[LabName] [nvarchar](500) NULL,
	[ClaimID] [nvarchar](500) NULL,
	[AccessionNumber] [nvarchar](500) NULL,
	[SourceFileID] [nvarchar](1000) NULL,
	[IngestedOn] [nvarchar](500) NULL,
	[CsvRowHash] [nvarchar](500) NULL,
	[PayerName_Raw] [nvarchar](500) NULL,
	[PayerName] [nvarchar](500) NULL,
	[Payer_Code] [nvarchar](500) NULL,
	[Payer_Common_Code] [nvarchar](500) NULL,
	[Payer_Group_Code] [nvarchar](500) NULL,
	[Global_Payer_ID] [nvarchar](500) NULL,
	[PayerType] [nvarchar](500) NULL,
	[BillingProvider] [nvarchar](500) NULL,
	[ReferringProvider] [nvarchar](500) NULL,
	[ClinicName] [nvarchar](500) NULL,
	[SalesRepname] [nvarchar](500) NULL,
	[PatientID] [nvarchar](500) NULL,
	[PatientDOB] [nvarchar](500) NULL,
	[DateofService] [nvarchar](500) NULL,
	[ChargeEnteredDate] [nvarchar](500) NULL,
	[FirstBilledDate] [nvarchar](500) NULL,
	[Panelname] [nvarchar](500) NULL,
	[CPTCode] [nvarchar](500) NULL,
	[Units] [nvarchar](500) NULL,
	[Modifier] [nvarchar](500) NULL,
	[POS] [nvarchar](500) NULL,
	[TOS] [nvarchar](500) NULL,
	[ChargeAmount] [nvarchar](500) NULL,
	[ChargeAmountPerUnit] [nvarchar](500) NULL,
	[AllowedAmount] [nvarchar](500) NULL,
	[AllowedAmountPerUnit] [nvarchar](500) NULL,
	[InsurancePayment] [nvarchar](500) NULL,
	[InsurancePaymentPerUnit] [nvarchar](500) NULL,
	[PatientPayment] [nvarchar](500) NULL,
	[PatientPaymentPerUnit] [nvarchar](500) NULL,
	[TotalPayments] [nvarchar](500) NULL,
	[InsuranceAdjustments] [nvarchar](500) NULL,
	[PatientAdjustments] [nvarchar](500) NULL,
	[TotalAdjustments] [nvarchar](500) NULL,
	[InsuranceBalance] [nvarchar](500) NULL,
	[PatientBalance] [nvarchar](500) NULL,
	[PatientBalancePerUnit] [nvarchar](500) NULL,
	[TotalBalance] [nvarchar](500) NULL,
	[CheckDate] [nvarchar](500) NULL,
	[PostingDate] [nvarchar](500) NULL,
	[ClaimStatus] [nvarchar](500) NULL,
	[PayStatus] [nvarchar](500) NULL,
	[DenialCode] [nvarchar](max) NULL,
	[DenialDate] [nvarchar](500) NULL,
	[ICDCode] [nvarchar](500) NULL,
	[DaystoDOS] [nvarchar](500) NULL,
	[RollingDays] [nvarchar](500) NULL,
	[DaystoBill] [nvarchar](500) NULL,
	[DaystoPost] [nvarchar](500) NULL,
	[ICDPointer] [nvarchar](500) NULL,
	[InsertedDateTime] [datetime] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[RecordId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO

ALTER TABLE [dbo].[LineLevelData] ADD  DEFAULT (getdate()) FOR [InsertedDateTime]
GO


USE [PCRCO_LRN]
GO

/****** Object:  Table [dbo].[ClaimLevelData]    Script Date: 8/1/2026 7:14:37 AM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[ClaimLevelData](
	[RecordId] [int] IDENTITY(1,1) NOT NULL,
	[FileLogId] [nvarchar](500) NULL,
	[RunId] [nvarchar](500) NULL,
	[WeekFolder] [nvarchar](500) NULL,
	[SourceFullPath] [nvarchar](1000) NULL,
	[FileName] [nvarchar](500) NULL,
	[FileType] [nvarchar](100) NULL,
	[RowHash] [nvarchar](64) NULL,
	[LabID] [nvarchar](500) NULL,
	[LabName] [nvarchar](500) NULL,
	[ClaimID] [nvarchar](500) NULL,
	[AccessionNumber] [nvarchar](500) NULL,
	[SourceFileID] [nvarchar](1000) NULL,
	[IngestedOn] [nvarchar](500) NULL,
	[CsvRowHash] [nvarchar](500) NULL,
	[PayerName_Raw] [nvarchar](500) NULL,
	[PayerName] [nvarchar](500) NULL,
	[Payer_Code] [nvarchar](500) NULL,
	[Payer_Common_Code] [nvarchar](500) NULL,
	[Payer_Group_Code] [nvarchar](500) NULL,
	[Global_Payer_ID] [nvarchar](500) NULL,
	[PayerType] [nvarchar](500) NULL,
	[BillingProvider] [nvarchar](500) NULL,
	[ReferringProvider] [nvarchar](500) NULL,
	[ClinicName] [nvarchar](500) NULL,
	[SalesRepname] [nvarchar](500) NULL,
	[PatientID] [nvarchar](500) NULL,
	[PatientDOB] [nvarchar](500) NULL,
	[DateofService] [nvarchar](500) NULL,
	[ChargeEnteredDate] [nvarchar](500) NULL,
	[FirstBilledDate] [nvarchar](500) NULL,
	[Panelname] [nvarchar](500) NULL,
	[CPTCodeXUnitsXModifier] [nvarchar](max) NULL,
	[POS] [nvarchar](500) NULL,
	[TOS] [nvarchar](500) NULL,
	[ChargeAmount] [nvarchar](500) NULL,
	[AllowedAmount] [nvarchar](500) NULL,
	[InsurancePayment] [nvarchar](500) NULL,
	[PatientPayment] [nvarchar](500) NULL,
	[TotalPayments] [nvarchar](500) NULL,
	[InsuranceAdjustments] [nvarchar](500) NULL,
	[PatientAdjustments] [nvarchar](500) NULL,
	[TotalAdjustments] [nvarchar](500) NULL,
	[InsuranceBalance] [nvarchar](500) NULL,
	[PatientBalance] [nvarchar](500) NULL,
	[TotalBalance] [nvarchar](500) NULL,
	[CheckDate] [nvarchar](500) NULL,
	[ClaimStatus] [nvarchar](500) NULL,
	[DenialCode] [nvarchar](max) NULL,
	[ICDCode] [nvarchar](500) NULL,
	[DaystoDOS] [nvarchar](500) NULL,
	[RollingDays] [nvarchar](500) NULL,
	[DaystoBill] [nvarchar](500) NULL,
	[DaystoPost] [nvarchar](500) NULL,
	[ICDPointer] [nvarchar](500) NULL,
	[InsertedDateTime] [datetime] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[RecordId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO

ALTER TABLE [dbo].[ClaimLevelData] ADD  DEFAULT (getdate()) FOR [InsertedDateTime]
GO


USE [PCRCO_LRN]
GO

/****** Object:  Table [dbo].[LineLevelData]    Script Date: 8/1/2026 7:14:54 AM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[LineLevelData](
	[RecordId] [int] IDENTITY(1,1) NOT NULL,
	[FileLogId] [nvarchar](500) NULL,
	[RunId] [nvarchar](500) NULL,
	[WeekFolder] [nvarchar](500) NULL,
	[SourceFullPath] [nvarchar](1000) NULL,
	[FileName] [nvarchar](500) NULL,
	[FileType] [nvarchar](100) NULL,
	[RowHash] [nvarchar](64) NULL,
	[LabID] [nvarchar](500) NULL,
	[LabName] [nvarchar](500) NULL,
	[ClaimID] [nvarchar](500) NULL,
	[AccessionNumber] [nvarchar](500) NULL,
	[SourceFileID] [nvarchar](1000) NULL,
	[IngestedOn] [nvarchar](500) NULL,
	[CsvRowHash] [nvarchar](500) NULL,
	[PayerName_Raw] [nvarchar](500) NULL,
	[PayerName] [nvarchar](500) NULL,
	[Payer_Code] [nvarchar](500) NULL,
	[Payer_Common_Code] [nvarchar](500) NULL,
	[Payer_Group_Code] [nvarchar](500) NULL,
	[Global_Payer_ID] [nvarchar](500) NULL,
	[PayerType] [nvarchar](500) NULL,
	[BillingProvider] [nvarchar](500) NULL,
	[ReferringProvider] [nvarchar](500) NULL,
	[ClinicName] [nvarchar](500) NULL,
	[SalesRepname] [nvarchar](500) NULL,
	[PatientID] [nvarchar](500) NULL,
	[PatientDOB] [nvarchar](500) NULL,
	[DateofService] [nvarchar](500) NULL,
	[ChargeEnteredDate] [nvarchar](500) NULL,
	[FirstBilledDate] [nvarchar](500) NULL,
	[Panelname] [nvarchar](500) NULL,
	[CPTCode] [nvarchar](500) NULL,
	[Units] [nvarchar](500) NULL,
	[Modifier] [nvarchar](500) NULL,
	[POS] [nvarchar](500) NULL,
	[TOS] [nvarchar](500) NULL,
	[ChargeAmount] [nvarchar](500) NULL,
	[ChargeAmountPerUnit] [nvarchar](500) NULL,
	[AllowedAmount] [nvarchar](500) NULL,
	[AllowedAmountPerUnit] [nvarchar](500) NULL,
	[InsurancePayment] [nvarchar](500) NULL,
	[InsurancePaymentPerUnit] [nvarchar](500) NULL,
	[PatientPayment] [nvarchar](500) NULL,
	[PatientPaymentPerUnit] [nvarchar](500) NULL,
	[TotalPayments] [nvarchar](500) NULL,
	[InsuranceAdjustments] [nvarchar](500) NULL,
	[PatientAdjustments] [nvarchar](500) NULL,
	[TotalAdjustments] [nvarchar](500) NULL,
	[InsuranceBalance] [nvarchar](500) NULL,
	[PatientBalance] [nvarchar](500) NULL,
	[PatientBalancePerUnit] [nvarchar](500) NULL,
	[TotalBalance] [nvarchar](500) NULL,
	[CheckDate] [nvarchar](500) NULL,
	[PostingDate] [nvarchar](500) NULL,
	[ClaimStatus] [nvarchar](500) NULL,
	[PayStatus] [nvarchar](500) NULL,
	[DenialCode] [nvarchar](max) NULL,
	[DenialDate] [nvarchar](500) NULL,
	[ICDCode] [nvarchar](500) NULL,
	[DaystoDOS] [nvarchar](500) NULL,
	[RollingDays] [nvarchar](500) NULL,
	[DaystoBill] [nvarchar](500) NULL,
	[DaystoPost] [nvarchar](500) NULL,
	[ICDPointer] [nvarchar](500) NULL,
	[InsertedDateTime] [datetime] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[RecordId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO

ALTER TABLE [dbo].[LineLevelData] ADD  DEFAULT (getdate()) FOR [InsertedDateTime]
GO


USE [PCRLOA_LRN]
GO

/****** Object:  Table [dbo].[ClaimLevelData]    Script Date: 8/1/2026 7:15:21 AM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[ClaimLevelData](
	[RecordId] [int] IDENTITY(1,1) NOT NULL,
	[FileLogId] [nvarchar](500) NULL,
	[RunId] [nvarchar](500) NULL,
	[WeekFolder] [nvarchar](500) NULL,
	[SourceFullPath] [nvarchar](1000) NULL,
	[FileName] [nvarchar](500) NULL,
	[FileType] [nvarchar](100) NULL,
	[RowHash] [nvarchar](64) NULL,
	[LabID] [nvarchar](500) NULL,
	[LabName] [nvarchar](500) NULL,
	[ClaimID] [nvarchar](500) NULL,
	[AccessionNumber] [nvarchar](500) NULL,
	[SourceFileID] [nvarchar](1000) NULL,
	[IngestedOn] [nvarchar](500) NULL,
	[CsvRowHash] [nvarchar](500) NULL,
	[PayerName_Raw] [nvarchar](500) NULL,
	[PayerName] [nvarchar](500) NULL,
	[Payer_Code] [nvarchar](500) NULL,
	[Payer_Common_Code] [nvarchar](500) NULL,
	[Payer_Group_Code] [nvarchar](500) NULL,
	[Global_Payer_ID] [nvarchar](500) NULL,
	[PayerType] [nvarchar](500) NULL,
	[BillingProvider] [nvarchar](500) NULL,
	[ReferringProvider] [nvarchar](500) NULL,
	[ClinicName] [nvarchar](500) NULL,
	[SalesRepname] [nvarchar](500) NULL,
	[PatientID] [nvarchar](500) NULL,
	[PatientDOB] [nvarchar](500) NULL,
	[DateofService] [nvarchar](500) NULL,
	[ChargeEnteredDate] [nvarchar](500) NULL,
	[FirstBilledDate] [nvarchar](500) NULL,
	[Panelname] [nvarchar](500) NULL,
	[CPTCodeXUnitsXModifier] [nvarchar](max) NULL,
	[POS] [nvarchar](500) NULL,
	[TOS] [nvarchar](500) NULL,
	[ChargeAmount] [nvarchar](500) NULL,
	[AllowedAmount] [nvarchar](500) NULL,
	[InsurancePayment] [nvarchar](500) NULL,
	[PatientPayment] [nvarchar](500) NULL,
	[TotalPayments] [nvarchar](500) NULL,
	[InsuranceAdjustments] [nvarchar](500) NULL,
	[PatientAdjustments] [nvarchar](500) NULL,
	[TotalAdjustments] [nvarchar](500) NULL,
	[InsuranceBalance] [nvarchar](500) NULL,
	[PatientBalance] [nvarchar](500) NULL,
	[TotalBalance] [nvarchar](500) NULL,
	[CheckDate] [nvarchar](500) NULL,
	[ClaimStatus] [nvarchar](500) NULL,
	[DenialCode] [nvarchar](max) NULL,
	[ICDCode] [nvarchar](500) NULL,
	[DaystoDOS] [nvarchar](500) NULL,
	[RollingDays] [nvarchar](500) NULL,
	[DaystoBill] [nvarchar](500) NULL,
	[DaystoPost] [nvarchar](500) NULL,
	[ICDPointer] [nvarchar](500) NULL,
	[InsertedDateTime] [datetime] NOT NULL,
	[CPTCodeXUnitsXModifierOrginal] [nvarchar](max) NULL,
	[PatientName] [nvarchar](1000) NULL,
	[BilledUnbilled] [nvarchar](100) NULL,
	[ModifierField] [nvarchar](500) NULL,
	[PaymentPercent] [nvarchar](100) NULL,
	[Aging] [nvarchar](100) NULL,
	[AgingBucket] [nvarchar](200) NULL,
	[BilledWeek] [nvarchar](500) NULL,
	[PostedWeek] [nvarchar](500) NULL,
	[FullyPaidCount] [nvarchar](500) NULL,
	[FullyPaidAmount] [nvarchar](500) NULL,
	[AdjucticatedCount] [nvarchar](500) NULL,
	[AdjucticatedAmount] [nvarchar](500) NULL,
	[Bucket30Count] [nvarchar](500) NULL,
	[Bucket30Amount] [nvarchar](500) NULL,
	[Bucket60Count] [nvarchar](500) NULL,
	[Bucket60Amount] [nvarchar](500) NULL,
	[DOE_Year] [nvarchar](20) NULL,
	[DOE_Month] [nvarchar](20) NULL,
PRIMARY KEY CLUSTERED 
(
	[RecordId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO

ALTER TABLE [dbo].[ClaimLevelData] ADD  DEFAULT (getdate()) FOR [InsertedDateTime]
GO


USE [PCRLOA_LRN]
GO

/****** Object:  Table [dbo].[LineLevelData]    Script Date: 8/1/2026 7:15:35 AM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[LineLevelData](
	[RecordId] [int] IDENTITY(1,1) NOT NULL,
	[FileLogId] [nvarchar](500) NULL,
	[RunId] [nvarchar](500) NULL,
	[WeekFolder] [nvarchar](500) NULL,
	[SourceFullPath] [nvarchar](1000) NULL,
	[FileName] [nvarchar](500) NULL,
	[FileType] [nvarchar](100) NULL,
	[RowHash] [nvarchar](64) NULL,
	[LabID] [nvarchar](500) NULL,
	[LabName] [nvarchar](500) NULL,
	[ClaimID] [nvarchar](500) NULL,
	[AccessionNumber] [nvarchar](500) NULL,
	[SourceFileID] [nvarchar](1000) NULL,
	[IngestedOn] [nvarchar](500) NULL,
	[CsvRowHash] [nvarchar](500) NULL,
	[PayerName_Raw] [nvarchar](500) NULL,
	[PayerName] [nvarchar](500) NULL,
	[Payer_Code] [nvarchar](500) NULL,
	[Payer_Common_Code] [nvarchar](500) NULL,
	[Payer_Group_Code] [nvarchar](500) NULL,
	[Global_Payer_ID] [nvarchar](500) NULL,
	[PayerType] [nvarchar](500) NULL,
	[BillingProvider] [nvarchar](500) NULL,
	[ReferringProvider] [nvarchar](500) NULL,
	[ClinicName] [nvarchar](500) NULL,
	[SalesRepname] [nvarchar](500) NULL,
	[PatientID] [nvarchar](500) NULL,
	[PatientDOB] [nvarchar](500) NULL,
	[DateofService] [nvarchar](500) NULL,
	[ChargeEnteredDate] [nvarchar](500) NULL,
	[FirstBilledDate] [nvarchar](500) NULL,
	[Panelname] [nvarchar](500) NULL,
	[CPTCode] [nvarchar](500) NULL,
	[Units] [nvarchar](500) NULL,
	[Modifier] [nvarchar](500) NULL,
	[POS] [nvarchar](500) NULL,
	[TOS] [nvarchar](500) NULL,
	[ChargeAmount] [nvarchar](500) NULL,
	[ChargeAmountPerUnit] [nvarchar](500) NULL,
	[AllowedAmount] [nvarchar](500) NULL,
	[AllowedAmountPerUnit] [nvarchar](500) NULL,
	[InsurancePayment] [nvarchar](500) NULL,
	[InsurancePaymentPerUnit] [nvarchar](500) NULL,
	[PatientPayment] [nvarchar](500) NULL,
	[PatientPaymentPerUnit] [nvarchar](500) NULL,
	[TotalPayments] [nvarchar](500) NULL,
	[InsuranceAdjustments] [nvarchar](500) NULL,
	[PatientAdjustments] [nvarchar](500) NULL,
	[TotalAdjustments] [nvarchar](500) NULL,
	[InsuranceBalance] [nvarchar](500) NULL,
	[PatientBalance] [nvarchar](500) NULL,
	[PatientBalancePerUnit] [nvarchar](500) NULL,
	[TotalBalance] [nvarchar](500) NULL,
	[CheckDate] [nvarchar](500) NULL,
	[PostingDate] [nvarchar](500) NULL,
	[ClaimStatus] [nvarchar](500) NULL,
	[PayStatus] [nvarchar](500) NULL,
	[DenialCode] [nvarchar](max) NULL,
	[DenialDate] [nvarchar](500) NULL,
	[ICDCode] [nvarchar](500) NULL,
	[DaystoDOS] [nvarchar](500) NULL,
	[RollingDays] [nvarchar](500) NULL,
	[DaystoBill] [nvarchar](500) NULL,
	[DaystoPost] [nvarchar](500) NULL,
	[ICDPointer] [nvarchar](500) NULL,
	[InsertedDateTime] [datetime] NOT NULL,
	[PaymentPostedDate] [nvarchar](500) NULL,
	[PatientName] [nvarchar](1000) NULL,
	[ResponsibleParty] [nvarchar](500) NULL,
	[SubscriberId] [nvarchar](500) NULL,
	[ClientAccNum] [nvarchar](500) NULL,
	[EndDOS] [nvarchar](500) NULL,
	[BillOccurance] [nvarchar](500) NULL,
	[EntryUser] [nvarchar](500) NULL,
	[CPTUnits] [nvarchar](500) NULL,
	[CPTMOD] [nvarchar](500) NULL,
	[CPTs] [nvarchar](max) NULL,
	[PostedWeek] [nvarchar](500) NULL,
PRIMARY KEY CLUSTERED 
(
	[RecordId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO

ALTER TABLE [dbo].[LineLevelData] ADD  DEFAULT (getdate()) FOR [InsertedDateTime]
GO


USE [PhiLife_LRN]
GO

/****** Object:  Table [dbo].[ClaimLevelData]    Script Date: 8/1/2026 7:15:58 AM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[ClaimLevelData](
	[RecordId] [int] IDENTITY(1,1) NOT NULL,
	[FileLogId] [nvarchar](500) NULL,
	[RunId] [nvarchar](500) NULL,
	[WeekFolder] [nvarchar](500) NULL,
	[SourceFullPath] [nvarchar](1000) NULL,
	[FileName] [nvarchar](500) NULL,
	[FileType] [nvarchar](100) NULL,
	[RowHash] [nvarchar](64) NULL,
	[LabID] [nvarchar](500) NULL,
	[LabName] [nvarchar](500) NULL,
	[ClaimID] [nvarchar](500) NULL,
	[AccessionNumber] [nvarchar](500) NULL,
	[SourceFileID] [nvarchar](1000) NULL,
	[IngestedOn] [nvarchar](500) NULL,
	[CsvRowHash] [nvarchar](500) NULL,
	[PayerName_Raw] [nvarchar](500) NULL,
	[PayerName] [nvarchar](500) NULL,
	[Payer_Code] [nvarchar](500) NULL,
	[Payer_Common_Code] [nvarchar](500) NULL,
	[Payer_Group_Code] [nvarchar](500) NULL,
	[Global_Payer_ID] [nvarchar](500) NULL,
	[PayerType] [nvarchar](500) NULL,
	[BillingProvider] [nvarchar](500) NULL,
	[ReferringProvider] [nvarchar](500) NULL,
	[ClinicName] [nvarchar](500) NULL,
	[SalesRepname] [nvarchar](500) NULL,
	[PatientID] [nvarchar](500) NULL,
	[PatientDOB] [nvarchar](500) NULL,
	[DateofService] [nvarchar](500) NULL,
	[ChargeEnteredDate] [nvarchar](500) NULL,
	[FirstBilledDate] [nvarchar](500) NULL,
	[Panelname] [nvarchar](500) NULL,
	[CPTCodeXUnitsXModifier] [nvarchar](max) NULL,
	[POS] [nvarchar](500) NULL,
	[TOS] [nvarchar](500) NULL,
	[ChargeAmount] [nvarchar](500) NULL,
	[AllowedAmount] [nvarchar](500) NULL,
	[InsurancePayment] [nvarchar](500) NULL,
	[PatientPayment] [nvarchar](500) NULL,
	[TotalPayments] [nvarchar](500) NULL,
	[InsuranceAdjustments] [nvarchar](500) NULL,
	[PatientAdjustments] [nvarchar](500) NULL,
	[TotalAdjustments] [nvarchar](500) NULL,
	[InsuranceBalance] [nvarchar](500) NULL,
	[PatientBalance] [nvarchar](500) NULL,
	[TotalBalance] [nvarchar](500) NULL,
	[CheckDate] [nvarchar](500) NULL,
	[ClaimStatus] [nvarchar](500) NULL,
	[DenialCode] [nvarchar](max) NULL,
	[ICDCode] [nvarchar](500) NULL,
	[DaystoDOS] [nvarchar](500) NULL,
	[RollingDays] [nvarchar](500) NULL,
	[DaystoBill] [nvarchar](500) NULL,
	[DaystoPost] [nvarchar](500) NULL,
	[ICDPointer] [nvarchar](500) NULL,
	[InsertedDateTime] [datetime] NOT NULL,
	[CPTCodeXUnitsXModifierOrginal] [nvarchar](max) NULL,
	[BilledUnbilled] [nvarchar](100) NULL,
	[Modifier] [nvarchar](500) NULL,
	[AgingBucket] [nvarchar](200) NULL,
	[AdjudicatedCount] [nvarchar](500) NULL,
	[Days30Count] [nvarchar](500) NULL,
	[Days30Amount] [nvarchar](500) NULL,
	[Days60Count] [nvarchar](500) NULL,
	[Days60Amount] [nvarchar](500) NULL,
	[DOE_Year] [nvarchar](20) NULL,
	[DOE_Month] [nvarchar](20) NULL,
	[PatientName] [nvarchar](1000) NULL,
	[PaymentPercent] [nvarchar](100) NULL,
	[Aging] [nvarchar](100) NULL,
	[BilledWeek] [nvarchar](500) NULL,
	[PostedWeek] [nvarchar](500) NULL,
	[FullyPaidCount] [nvarchar](500) NULL,
	[FullyPaidAmount] [nvarchar](500) NULL,
	[AdjudicatedAmount] [nvarchar](500) NULL,
	[CPTCode] [nvarchar](500) NULL,
	[Units] [nvarchar](500) NULL,
	[Adjudicated] [nvarchar](1000) NULL,
PRIMARY KEY CLUSTERED 
(
	[RecordId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO

ALTER TABLE [dbo].[ClaimLevelData] ADD  DEFAULT (getdate()) FOR [InsertedDateTime]
GO


USE [PhiLife_LRN]
GO

/****** Object:  Table [dbo].[LineLevelData]    Script Date: 8/1/2026 7:16:10 AM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[LineLevelData](
	[RecordId] [int] IDENTITY(1,1) NOT NULL,
	[FileLogId] [nvarchar](500) NULL,
	[RunId] [nvarchar](500) NULL,
	[WeekFolder] [nvarchar](500) NULL,
	[SourceFullPath] [nvarchar](1000) NULL,
	[FileName] [nvarchar](500) NULL,
	[FileType] [nvarchar](100) NULL,
	[RowHash] [nvarchar](64) NULL,
	[LabID] [nvarchar](500) NULL,
	[LabName] [nvarchar](500) NULL,
	[ClaimID] [nvarchar](500) NULL,
	[AccessionNumber] [nvarchar](500) NULL,
	[SourceFileID] [nvarchar](1000) NULL,
	[IngestedOn] [nvarchar](500) NULL,
	[CsvRowHash] [nvarchar](500) NULL,
	[PayerName_Raw] [nvarchar](500) NULL,
	[PayerName] [nvarchar](500) NULL,
	[Payer_Code] [nvarchar](500) NULL,
	[Payer_Common_Code] [nvarchar](500) NULL,
	[Payer_Group_Code] [nvarchar](500) NULL,
	[Global_Payer_ID] [nvarchar](500) NULL,
	[PayerType] [nvarchar](500) NULL,
	[BillingProvider] [nvarchar](500) NULL,
	[ReferringProvider] [nvarchar](500) NULL,
	[ClinicName] [nvarchar](500) NULL,
	[SalesRepname] [nvarchar](500) NULL,
	[PatientID] [nvarchar](500) NULL,
	[PatientDOB] [nvarchar](500) NULL,
	[DateofService] [nvarchar](500) NULL,
	[ChargeEnteredDate] [nvarchar](500) NULL,
	[FirstBilledDate] [nvarchar](500) NULL,
	[Panelname] [nvarchar](500) NULL,
	[CPTCode] [nvarchar](500) NULL,
	[Units] [nvarchar](500) NULL,
	[Modifier] [nvarchar](500) NULL,
	[POS] [nvarchar](500) NULL,
	[TOS] [nvarchar](500) NULL,
	[ChargeAmount] [nvarchar](500) NULL,
	[ChargeAmountPerUnit] [nvarchar](500) NULL,
	[AllowedAmount] [nvarchar](500) NULL,
	[AllowedAmountPerUnit] [nvarchar](500) NULL,
	[InsurancePayment] [nvarchar](500) NULL,
	[InsurancePaymentPerUnit] [nvarchar](500) NULL,
	[PatientPayment] [nvarchar](500) NULL,
	[PatientPaymentPerUnit] [nvarchar](500) NULL,
	[TotalPayments] [nvarchar](500) NULL,
	[InsuranceAdjustments] [nvarchar](500) NULL,
	[PatientAdjustments] [nvarchar](500) NULL,
	[TotalAdjustments] [nvarchar](500) NULL,
	[InsuranceBalance] [nvarchar](500) NULL,
	[PatientBalance] [nvarchar](500) NULL,
	[PatientBalancePerUnit] [nvarchar](500) NULL,
	[TotalBalance] [nvarchar](500) NULL,
	[CheckDate] [nvarchar](500) NULL,
	[PostingDate] [nvarchar](500) NULL,
	[ClaimStatus] [nvarchar](500) NULL,
	[PayStatus] [nvarchar](500) NULL,
	[DenialCode] [nvarchar](max) NULL,
	[DenialDate] [nvarchar](500) NULL,
	[ICDCode] [nvarchar](500) NULL,
	[DaystoDOS] [nvarchar](500) NULL,
	[RollingDays] [nvarchar](500) NULL,
	[DaystoBill] [nvarchar](500) NULL,
	[DaystoPost] [nvarchar](500) NULL,
	[ICDPointer] [nvarchar](500) NULL,
	[InsertedDateTime] [datetime] NOT NULL,
	[PaymentPostedDate] [nvarchar](500) NULL,
	[PatientName] [nvarchar](1000) NULL,
	[ResponsibleParty] [nvarchar](500) NULL,
	[SubscriberId] [nvarchar](1000) NULL,
	[EndDOS] [nvarchar](500) NULL,
	[BillOccurance] [nvarchar](500) NULL,
	[EntryUser] [nvarchar](500) NULL,
	[CPTUnits] [nvarchar](500) NULL,
	[CPTMOD] [nvarchar](500) NULL,
	[CPTs] [nvarchar](max) NULL,
	[PostedWeek] [nvarchar](500) NULL,
	[AgingBucket] [nvarchar](200) NULL,
PRIMARY KEY CLUSTERED 
(
	[RecordId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO

ALTER TABLE [dbo].[LineLevelData] ADD  DEFAULT (getdate()) FOR [InsertedDateTime]
GO


USE [RisingTides]
GO

/****** Object:  Table [dbo].[ClaimLevelData]    Script Date: 8/1/2026 7:16:38 AM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[ClaimLevelData](
	[RecordId] [int] IDENTITY(1,1) NOT NULL,
	[FileLogId] [nvarchar](500) NULL,
	[RunId] [nvarchar](500) NULL,
	[WeekFolder] [nvarchar](500) NULL,
	[SourceFullPath] [nvarchar](1000) NULL,
	[FileName] [nvarchar](500) NULL,
	[FileType] [nvarchar](100) NULL,
	[RowHash] [nvarchar](64) NULL,
	[LabID] [nvarchar](500) NULL,
	[LabName] [nvarchar](500) NULL,
	[ClaimID] [nvarchar](500) NULL,
	[AccessionNumber] [nvarchar](500) NULL,
	[SourceFileID] [nvarchar](1000) NULL,
	[IngestedOn] [nvarchar](500) NULL,
	[CsvRowHash] [nvarchar](500) NULL,
	[PayerName_Raw] [nvarchar](500) NULL,
	[PayerName] [nvarchar](500) NULL,
	[Payer_Code] [nvarchar](500) NULL,
	[Payer_Common_Code] [nvarchar](500) NULL,
	[Payer_Group_Code] [nvarchar](500) NULL,
	[Global_Payer_ID] [nvarchar](500) NULL,
	[PayerType] [nvarchar](500) NULL,
	[BillingProvider] [nvarchar](500) NULL,
	[ReferringProvider] [nvarchar](500) NULL,
	[ClinicName] [nvarchar](500) NULL,
	[SalesRepname] [nvarchar](500) NULL,
	[PatientID] [nvarchar](500) NULL,
	[PatientDOB] [nvarchar](500) NULL,
	[DateofService] [nvarchar](500) NULL,
	[ChargeEnteredDate] [nvarchar](500) NULL,
	[FirstBilledDate] [nvarchar](500) NULL,
	[Panelname] [nvarchar](500) NULL,
	[CPTCodeXUnitsXModifier] [nvarchar](max) NULL,
	[POS] [nvarchar](500) NULL,
	[TOS] [nvarchar](500) NULL,
	[ChargeAmount] [nvarchar](500) NULL,
	[AllowedAmount] [nvarchar](500) NULL,
	[InsurancePayment] [nvarchar](500) NULL,
	[PatientPayment] [nvarchar](500) NULL,
	[TotalPayments] [nvarchar](500) NULL,
	[InsuranceAdjustments] [nvarchar](500) NULL,
	[PatientAdjustments] [nvarchar](500) NULL,
	[TotalAdjustments] [nvarchar](500) NULL,
	[InsuranceBalance] [nvarchar](500) NULL,
	[PatientBalance] [nvarchar](500) NULL,
	[TotalBalance] [nvarchar](500) NULL,
	[CheckDate] [nvarchar](500) NULL,
	[ClaimStatus] [nvarchar](500) NULL,
	[DenialCode] [nvarchar](max) NULL,
	[ICDCode] [nvarchar](500) NULL,
	[DaystoDOS] [nvarchar](500) NULL,
	[RollingDays] [nvarchar](500) NULL,
	[DaystoBill] [nvarchar](500) NULL,
	[DaystoPost] [nvarchar](500) NULL,
	[ICDPointer] [nvarchar](500) NULL,
	[InsertedDateTime] [datetime] NOT NULL,
	[CPTCodeXUnitsXModifierOrginal] [nvarchar](max) NULL,
	[PatientName] [nvarchar](1000) NULL,
	[BilledUnbilled] [nvarchar](100) NULL,
	[ModifierField] [nvarchar](500) NULL,
	[PaymentPercent] [nvarchar](100) NULL,
	[Aging] [nvarchar](100) NULL,
	[AgingBucket] [nvarchar](200) NULL,
	[BilledWeek] [nvarchar](500) NULL,
	[PostedWeek] [nvarchar](500) NULL,
	[Facility] [nvarchar](500) NULL,
	[FullyPaidCount] [nvarchar](500) NULL,
	[FullyPaidAmount] [nvarchar](500) NULL,
	[AdjucticatedCount] [nvarchar](500) NULL,
	[AdjucticatedAmount] [nvarchar](500) NULL,
	[Bucket30Count] [nvarchar](500) NULL,
	[Bucket30Amount] [nvarchar](500) NULL,
	[Bucket60Count] [nvarchar](500) NULL,
	[Bucket60Amount] [nvarchar](500) NULL,
	[DOE_Year] [nvarchar](20) NULL,
	[DOE_Month] [nvarchar](20) NULL,
PRIMARY KEY CLUSTERED 
(
	[RecordId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO

ALTER TABLE [dbo].[ClaimLevelData] ADD  DEFAULT (getdate()) FOR [InsertedDateTime]
GO


USE [RisingTides]
GO

/****** Object:  Table [dbo].[LineLevelData]    Script Date: 8/1/2026 7:16:57 AM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[LineLevelData](
	[RecordId] [int] IDENTITY(1,1) NOT NULL,
	[FileLogId] [nvarchar](500) NULL,
	[RunId] [nvarchar](500) NULL,
	[WeekFolder] [nvarchar](500) NULL,
	[SourceFullPath] [nvarchar](1000) NULL,
	[FileName] [nvarchar](500) NULL,
	[FileType] [nvarchar](100) NULL,
	[RowHash] [nvarchar](64) NULL,
	[LabID] [nvarchar](500) NULL,
	[LabName] [nvarchar](500) NULL,
	[ClaimID] [nvarchar](500) NULL,
	[AccessionNumber] [nvarchar](500) NULL,
	[SourceFileID] [nvarchar](1000) NULL,
	[IngestedOn] [nvarchar](500) NULL,
	[CsvRowHash] [nvarchar](500) NULL,
	[PayerName_Raw] [nvarchar](500) NULL,
	[PayerName] [nvarchar](500) NULL,
	[Payer_Code] [nvarchar](500) NULL,
	[Payer_Common_Code] [nvarchar](500) NULL,
	[Payer_Group_Code] [nvarchar](500) NULL,
	[Global_Payer_ID] [nvarchar](500) NULL,
	[PayerType] [nvarchar](500) NULL,
	[BillingProvider] [nvarchar](500) NULL,
	[ReferringProvider] [nvarchar](500) NULL,
	[ClinicName] [nvarchar](500) NULL,
	[SalesRepname] [nvarchar](500) NULL,
	[PatientID] [nvarchar](500) NULL,
	[PatientDOB] [nvarchar](500) NULL,
	[DateofService] [nvarchar](500) NULL,
	[ChargeEnteredDate] [nvarchar](500) NULL,
	[FirstBilledDate] [nvarchar](500) NULL,
	[Panelname] [nvarchar](500) NULL,
	[CPTCode] [nvarchar](500) NULL,
	[Units] [nvarchar](500) NULL,
	[Modifier] [nvarchar](500) NULL,
	[POS] [nvarchar](500) NULL,
	[TOS] [nvarchar](500) NULL,
	[ChargeAmount] [nvarchar](500) NULL,
	[ChargeAmountPerUnit] [nvarchar](500) NULL,
	[AllowedAmount] [nvarchar](500) NULL,
	[AllowedAmountPerUnit] [nvarchar](500) NULL,
	[InsurancePayment] [nvarchar](500) NULL,
	[InsurancePaymentPerUnit] [nvarchar](500) NULL,
	[PatientPayment] [nvarchar](500) NULL,
	[PatientPaymentPerUnit] [nvarchar](500) NULL,
	[TotalPayments] [nvarchar](500) NULL,
	[InsuranceAdjustments] [nvarchar](500) NULL,
	[PatientAdjustments] [nvarchar](500) NULL,
	[TotalAdjustments] [nvarchar](500) NULL,
	[InsuranceBalance] [nvarchar](500) NULL,
	[PatientBalance] [nvarchar](500) NULL,
	[PatientBalancePerUnit] [nvarchar](500) NULL,
	[TotalBalance] [nvarchar](500) NULL,
	[CheckDate] [nvarchar](500) NULL,
	[PostingDate] [nvarchar](500) NULL,
	[ClaimStatus] [nvarchar](500) NULL,
	[PayStatus] [nvarchar](500) NULL,
	[DenialCode] [nvarchar](max) NULL,
	[DenialDate] [nvarchar](500) NULL,
	[ICDCode] [nvarchar](500) NULL,
	[DaystoDOS] [nvarchar](500) NULL,
	[RollingDays] [nvarchar](500) NULL,
	[DaystoBill] [nvarchar](500) NULL,
	[DaystoPost] [nvarchar](500) NULL,
	[ICDPointer] [nvarchar](500) NULL,
	[InsertedDateTime] [datetime] NOT NULL,
	[PaymentPostedDate] [nvarchar](500) NULL,
	[PatientName] [nvarchar](1000) NULL,
	[ResponsibleParty] [nvarchar](500) NULL,
	[SubscriberId] [nvarchar](500) NULL,
	[ClientAccNum] [nvarchar](500) NULL,
	[EndDOS] [nvarchar](500) NULL,
	[BillOccurance] [nvarchar](500) NULL,
	[EntryUser] [nvarchar](500) NULL,
	[CPTUnits] [nvarchar](500) NULL,
	[CPTMOD] [nvarchar](500) NULL,
	[CPTs] [nvarchar](max) NULL,
	[PostedWeek] [nvarchar](500) NULL,
	[Facility] [nvarchar](500) NULL,
PRIMARY KEY CLUSTERED 
(
	[RecordId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO

ALTER TABLE [dbo].[LineLevelData] ADD  DEFAULT (getdate()) FOR [InsertedDateTime]
GO


