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
/****** Object:  StoredProcedure [dbo].[Sp_Process_BillingSheet_ByFileId]******/
DROP PROCEDURE [dbo].[Sp_Process_BillingSheet_ByFileId]
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
ALTER TABLE [dbo].[LISMaster] DROP CONSTRAINT [FK__LISMaster__TestT__19D5B7CA]
GO
ALTER TABLE [dbo].[LISMaster] DROP CONSTRAINT [FK__LISMaster__TestT__18E19391]
GO
ALTER TABLE [dbo].[LISMaster] DROP CONSTRAINT [FK__LISMaster__TestT__17ED6F58]
GO
ALTER TABLE [dbo].[LISMaster] DROP CONSTRAINT [FK__LISMaster__TestT__16F94B1F]
GO
ALTER TABLE [dbo].[LISMaster] DROP CONSTRAINT [FK__LISMaster__TestT__160526E6]
GO
ALTER TABLE [dbo].[LISMaster] DROP CONSTRAINT [FK__LISMaster__Sampl__151102AD]
GO
ALTER TABLE [dbo].[LISMaster] DROP CONSTRAINT [FK__LISMaster__Sampl__141CDE74]
GO
ALTER TABLE [dbo].[LISMaster] DROP CONSTRAINT [FK__LISMaster__Sampl__1328BA3B]
GO
ALTER TABLE [dbo].[LISMaster] DROP CONSTRAINT [FK__LISMaster__Sampl__12349602]
GO
ALTER TABLE [dbo].[LISMaster] DROP CONSTRAINT [FK__LISMaster__Sampl__114071C9]
GO
ALTER TABLE [dbo].[LISMaster] DROP CONSTRAINT [FK__LISMaster__Refer__104C4D90]
GO
ALTER TABLE [dbo].[LISMaster] DROP CONSTRAINT [FK__LISMaster__Refer__0F582957]
GO
ALTER TABLE [dbo].[LISMaster] DROP CONSTRAINT [FK__LISMaster__Refer__0E64051E]
GO
ALTER TABLE [dbo].[LISMaster] DROP CONSTRAINT [FK__LISMaster__Refer__0D6FE0E5]
GO
ALTER TABLE [dbo].[LISMaster] DROP CONSTRAINT [FK__LISMaster__Refer__0C7BBCAC]
GO
ALTER TABLE [dbo].[LISMaster] DROP CONSTRAINT [FK__LISMaster__Payer__0B879873]
GO
ALTER TABLE [dbo].[LISMaster] DROP CONSTRAINT [FK__LISMaster__Payer__0A93743A]
GO
ALTER TABLE [dbo].[LISMaster] DROP CONSTRAINT [FK__LISMaster__Payer__099F5001]
GO
ALTER TABLE [dbo].[LISMaster] DROP CONSTRAINT [FK__LISMaster__Payer__08AB2BC8]
GO
ALTER TABLE [dbo].[LISMaster] DROP CONSTRAINT [FK__LISMaster__Payer__07B7078F]
GO
ALTER TABLE [dbo].[LISMaster] DROP CONSTRAINT [FK__LISMaster__Panel__06C2E356]
GO
ALTER TABLE [dbo].[LISMaster] DROP CONSTRAINT [FK__LISMaster__Panel__05CEBF1D]
GO
ALTER TABLE [dbo].[LISMaster] DROP CONSTRAINT [FK__LISMaster__Panel__04DA9AE4]
GO
ALTER TABLE [dbo].[LISMaster] DROP CONSTRAINT [FK__LISMaster__Panel__03E676AB]
GO
ALTER TABLE [dbo].[LISMaster] DROP CONSTRAINT [FK__LISMaster__Panel__02F25272]
GO
ALTER TABLE [dbo].[LISMaster] DROP CONSTRAINT [FK__LISMaster__Opera__7F21C18E]
GO
ALTER TABLE [dbo].[LISMaster] DROP CONSTRAINT [FK__LISMaster__Opera__7E2D9D55]
GO
ALTER TABLE [dbo].[LISMaster] DROP CONSTRAINT [FK__LISMaster__Opera__01FE2E39]
GO
ALTER TABLE [dbo].[LISMaster] DROP CONSTRAINT [FK__LISMaster__Opera__010A0A00]
GO
ALTER TABLE [dbo].[LISMaster] DROP CONSTRAINT [FK__LISMaster__Opera__0015E5C7]
GO
ALTER TABLE [dbo].[LISMaster] DROP CONSTRAINT [FK__LISMaster__LabId__7D39791C]
GO
ALTER TABLE [dbo].[LISMaster] DROP CONSTRAINT [FK__LISMaster__LabId__7C4554E3]
GO
ALTER TABLE [dbo].[LISMaster] DROP CONSTRAINT [FK__LISMaster__LabId__7B5130AA]
GO
ALTER TABLE [dbo].[LISMaster] DROP CONSTRAINT [FK__LISMaster__LabId__7A5D0C71]
GO
ALTER TABLE [dbo].[LISMaster] DROP CONSTRAINT [FK__LISMaster__LabId__7968E838]
GO
ALTER TABLE [dbo].[LISMaster] DROP CONSTRAINT [FK__LISMaster__Clini__7874C3FF]
GO
ALTER TABLE [dbo].[LISMaster] DROP CONSTRAINT [FK__LISMaster__Clini__77809FC6]
GO
ALTER TABLE [dbo].[LISMaster] DROP CONSTRAINT [FK__LISMaster__Clini__768C7B8D]
GO
ALTER TABLE [dbo].[LISMaster] DROP CONSTRAINT [FK__LISMaster__Clini__75985754]
GO
ALTER TABLE [dbo].[LISMaster] DROP CONSTRAINT [FK__LISMaster__Clini__74A4331B]
GO
ALTER TABLE [dbo].[LISMaster] DROP CONSTRAINT [FK__LISMaster__Billi__73B00EE2]
GO
ALTER TABLE [dbo].[LISMaster] DROP CONSTRAINT [FK__LISMaster__Billi__72BBEAA9]
GO
ALTER TABLE [dbo].[LISMaster] DROP CONSTRAINT [FK__LISMaster__Billi__71C7C670]
GO
ALTER TABLE [dbo].[LISMaster] DROP CONSTRAINT [FK__LISMaster__Billi__70D3A237]
GO
ALTER TABLE [dbo].[LISMaster] DROP CONSTRAINT [FK__LISMaster__Billi__6FDF7DFE]
GO
ALTER TABLE [dbo].[BillingMaster] DROP CONSTRAINT [FK__BillingMa__Prima__31AD415B]
GO
ALTER TABLE [dbo].[BillingMaster] DROP CONSTRAINT [FK__BillingMa__Prima__30B91D22]
GO
ALTER TABLE [dbo].[BillingMaster] DROP CONSTRAINT [FK__BillingMa__Prima__2FC4F8E9]
GO
ALTER TABLE [dbo].[BillingMaster] DROP CONSTRAINT [FK__BillingMa__Prima__2ED0D4B0]
GO
ALTER TABLE [dbo].[BillingMaster] DROP CONSTRAINT [FK__BillingMa__Prima__2DDCB077]
GO
ALTER TABLE [dbo].[BillingMaster] DROP CONSTRAINT [FK__BillingMa__Payer__2CE88C3E]
GO
ALTER TABLE [dbo].[BillingMaster] DROP CONSTRAINT [FK__BillingMa__Payer__2BF46805]
GO
ALTER TABLE [dbo].[BillingMaster] DROP CONSTRAINT [FK__BillingMa__Payer__2B0043CC]
GO
ALTER TABLE [dbo].[BillingMaster] DROP CONSTRAINT [FK__BillingMa__Payer__2A0C1F93]
GO
ALTER TABLE [dbo].[BillingMaster] DROP CONSTRAINT [FK__BillingMa__Payer__2917FB5A]
GO
ALTER TABLE [dbo].[BillingMaster] DROP CONSTRAINT [FK__BillingMa__LISMa__2823D721]
GO
ALTER TABLE [dbo].[BillingMaster] DROP CONSTRAINT [FK__BillingMa__LISMa__272FB2E8]
GO
ALTER TABLE [dbo].[BillingMaster] DROP CONSTRAINT [FK__BillingMa__LISMa__263B8EAF]
GO
ALTER TABLE [dbo].[BillingMaster] DROP CONSTRAINT [FK__BillingMa__LISMa__25476A76]
GO
ALTER TABLE [dbo].[BillingMaster] DROP CONSTRAINT [FK__BillingMa__LISMa__2453463D]
GO
ALTER TABLE [dbo].[BillingMaster] DROP CONSTRAINT [FK__BillingMa__Billi__235F2204]
GO
ALTER TABLE [dbo].[BillingMaster] DROP CONSTRAINT [FK__BillingMa__Billi__226AFDCB]
GO
ALTER TABLE [dbo].[BillingMaster] DROP CONSTRAINT [FK__BillingMa__Billi__2176D992]
GO
ALTER TABLE [dbo].[BillingMaster] DROP CONSTRAINT [FK__BillingMa__Billi__2082B559]
GO
ALTER TABLE [dbo].[BillingMaster] DROP CONSTRAINT [FK__BillingMa__Billi__1F8E9120]
GO
ALTER TABLE [dbo].[VisitAgaistAccessionStaging] DROP CONSTRAINT [DF__VisitAgai__Impor__1CBC4616]
GO
ALTER TABLE [dbo].[VAAMaster] DROP CONSTRAINT [DF__VAAMaster__Creat__37661AB1]
GO
ALTER TABLE [dbo].[TransactionSummary] DROP CONSTRAINT [DF__Transacti__Creat__7775B2CE]
GO
ALTER TABLE [dbo].[TransactionSummary] DROP CONSTRAINT [DF__Transacti__Insur__76818E95]
GO
ALTER TABLE [dbo].[TransactionSummary] DROP CONSTRAINT [DF__Transacti__Total__758D6A5C]
GO
ALTER TABLE [dbo].[TransactionSummary] DROP CONSTRAINT [DF__Transacti__Patie__74994623]
GO
ALTER TABLE [dbo].[TransactionSummary] DROP CONSTRAINT [DF__Transacti__Adjus__73A521EA]
GO
ALTER TABLE [dbo].[TransactionSummary] DROP CONSTRAINT [DF__Transacti__Total__72B0FDB1]
GO
ALTER TABLE [dbo].[TransactionSummary] DROP CONSTRAINT [DF__Transacti__Units__71BCD978]
GO
ALTER TABLE [dbo].[TransactionMaster] DROP CONSTRAINT [DF__Transacti__Creat__5AE46118]
GO
ALTER TABLE [dbo].[TransactionDetailStaging] DROP CONSTRAINT [DF__Transacti__Impor__17F790F9]
GO
ALTER TABLE [dbo].[TestTypeMaster] DROP CONSTRAINT [DF__TestTypeM__Creat__151B244E]
GO
ALTER TABLE [dbo].[TestTypeMaster] DROP CONSTRAINT [DF__TestTypeM__IsAct__32AB8735]
GO
ALTER TABLE [dbo].[SpecimenStatus] DROP CONSTRAINT [DF__SpecimenS__Creat__114A936A]
GO
ALTER TABLE [dbo].[SpecimenStatus] DROP CONSTRAINT [DF__SpecimenS__IsAct__31B762FC]
GO
ALTER TABLE [dbo].[SalesPerson] DROP CONSTRAINT [DF__SalesPers__Creat__0B91BA14]
GO
ALTER TABLE [dbo].[ReferringProviderMaster] DROP CONSTRAINT [DF__Referring__Creat__07C12930]
GO
ALTER TABLE [dbo].[ReferringProviderMaster] DROP CONSTRAINT [DF__Referring__IsAct__30C33EC3]
GO
ALTER TABLE [dbo].[PrismBillingStaging] DROP CONSTRAINT [DF__PrismBill__Impor__01142BA1]
GO
ALTER TABLE [dbo].[PayerTypeMaster] DROP CONSTRAINT [DF__PayerType__Creat__7F2BE32F]
GO
ALTER TABLE [dbo].[PayerTypeMaster] DROP CONSTRAINT [DF__PayerType__IsAct__2FCF1A8A]
GO
ALTER TABLE [dbo].[PanelMasterStaging] DROP CONSTRAINT [DF__PanelMast__Impor__11957784]
GO
ALTER TABLE [dbo].[PanelGroup] DROP CONSTRAINT [DF__PanelGrou__Creat__6932806F]
GO
ALTER TABLE [dbo].[PanelGroup] DROP CONSTRAINT [DF__PanelGrou__IsAct__683E5C36]
GO
ALTER TABLE [dbo].[OperationsGroupMaster] DROP CONSTRAINT [DF__Operation__Creat__787EE5A0]
GO
ALTER TABLE [dbo].[OperationsGroupMaster] DROP CONSTRAINT [DF__Operation__IsAct__2DE6D218]
GO
ALTER TABLE [dbo].[LISStaging] DROP CONSTRAINT [DF__LISStagin__Impor__74AE54BC]
GO
ALTER TABLE [dbo].[LISMaster] DROP CONSTRAINT [DF__LISMaster__Creat__6EEB59C5]
GO
ALTER TABLE [dbo].[LISMaster] DROP CONSTRAINT [DF__LISMaster__Creat__6DF7358C]
GO
ALTER TABLE [dbo].[LabMaster] DROP CONSTRAINT [DF__LabMaster__Creat__6C190EBB]
GO
ALTER TABLE [dbo].[LabMaster] DROP CONSTRAINT [DF__LabMaster__IsAct__2CF2ADDF]
GO
ALTER TABLE [dbo].[InsurancePayerMaster] DROP CONSTRAINT [DF__Insurance__Creat__68487DD7]
GO
ALTER TABLE [dbo].[InsurancePayerMaster] DROP CONSTRAINT [DF__Insurance__IsAct__2BFE89A6]
GO
ALTER TABLE [dbo].[ImportFilTypes] DROP CONSTRAINT [DF__ImportFil__IsAct__2B0A656D]
GO
ALTER TABLE [dbo].[ImportFileLogs] DROP CONSTRAINT [DF__ImportFil__Creat__42D7CD5D]
GO
ALTER TABLE [dbo].[ImportedFiles] DROP CONSTRAINT [DF__ImportedF__LabId__561FABFB]
GO
ALTER TABLE [dbo].[ImportedFiles] DROP CONSTRAINT [DF__ImportedF__Impor__619B8048]
GO
ALTER TABLE [dbo].[ICDCodeMaster] DROP CONSTRAINT [DF__ICDCodeMa__Creat__5EBF139D]
GO
ALTER TABLE [dbo].[ICDCodeMaster] DROP CONSTRAINT [DF__ICDCodeMa__IsAct__2A164134]
GO
ALTER TABLE [dbo].[DownloadReportTypes] DROP CONSTRAINT [DF__DownloadR__IsAct__29221CFB]
GO
ALTER TABLE [dbo].[DiagnoseLISStaging] DROP CONSTRAINT [DF__DiagnoseL__Impor__10A1534B]
GO
ALTER TABLE [dbo].[DenialTrackingStaging] DROP CONSTRAINT [DF__DenialTra__Impor__5812160E]
GO
ALTER TABLE [dbo].[DenialTrackingMaster] DROP CONSTRAINT [DF__DenialTra__Updat__4316F928]
GO
ALTER TABLE [dbo].[DenialTrackingMaster] DROP CONSTRAINT [DF__DenialTra__Creat__4222D4EF]
GO
ALTER TABLE [dbo].[CustomCollectionStaging] DROP CONSTRAINT [DF__CustomCol__Impot__5629CD9C]
GO
ALTER TABLE [dbo].[CPTCodeMaster] DROP CONSTRAINT [DF__CPTCodeMa__Creat__534D60F1]
GO
ALTER TABLE [dbo].[CPTCodeMaster] DROP CONSTRAINT [DF__CPTCodeMa__IsAct__282DF8C2]
GO
ALTER TABLE [dbo].[ClinicMaster] DROP CONSTRAINT [DF__ClinicMas__Creat__5070F446]
GO
ALTER TABLE [dbo].[ClinicMaster] DROP CONSTRAINT [DF__ClinicMas__Clini__2739D489]
GO
ALTER TABLE [dbo].[ClaimsProdStatus] DROP CONSTRAINT [DF__ClaimsPro__Creat__4CA06362]
GO
ALTER TABLE [dbo].[ClaimsLevelStatus] DROP CONSTRAINT [DF__ClaimsLev__Creat__58E70A0D]
GO
ALTER TABLE [dbo].[ClaimsLevelStatus] DROP CONSTRAINT [DF__ClaimsLev__Total__57F2E5D4]
GO
ALTER TABLE [dbo].[ClaimsLevelStatus] DROP CONSTRAINT [DF__ClaimsLev__Patie__56FEC19B]
GO
ALTER TABLE [dbo].[ClaimsLevelStatus] DROP CONSTRAINT [DF__ClaimsLev__Insur__560A9D62]
GO
ALTER TABLE [dbo].[ClaimsLevelStatus] DROP CONSTRAINT [DF__ClaimsLev__Patie__55167929]
GO
ALTER TABLE [dbo].[ClaimsLevelStatus] DROP CONSTRAINT [DF__ClaimsLev__Patie__542254F0]
GO
ALTER TABLE [dbo].[ClaimsLevelStatus] DROP CONSTRAINT [DF__ClaimsLev__Insur__532E30B7]
GO
ALTER TABLE [dbo].[ClaimsLevelStatus] DROP CONSTRAINT [DF__ClaimsLev__Insur__523A0C7E]
GO
ALTER TABLE [dbo].[ClaimsLevelStatus] DROP CONSTRAINT [DF__ClaimsLev__Allow__5145E845]
GO
ALTER TABLE [dbo].[ClaimsLevelStatus] DROP CONSTRAINT [DF__ClaimsLev__Bille__5051C40C]
GO
ALTER TABLE [dbo].[ClaimBillingDetails] DROP CONSTRAINT [DF__ClaimBill__Creat__4AB81AF0]
GO
ALTER TABLE [dbo].[ClaimBillingDetails] DROP CONSTRAINT [DF__ClaimBill__Total__2645B050]
GO
ALTER TABLE [dbo].[ClaimBillingDetails] DROP CONSTRAINT [DF__ClaimBill__Patie__25518C17]
GO
ALTER TABLE [dbo].[ClaimBillingDetails] DROP CONSTRAINT [DF__ClaimBill__Insur__245D67DE]
GO
ALTER TABLE [dbo].[ClaimBillingDetails] DROP CONSTRAINT [DF__ClaimBill__Patie__236943A5]
GO
ALTER TABLE [dbo].[ClaimBillingDetails] DROP CONSTRAINT [DF__ClaimBill__Patie__22751F6C]
GO
ALTER TABLE [dbo].[ClaimBillingDetails] DROP CONSTRAINT [DF__ClaimBill__Insur__2180FB33]
GO
ALTER TABLE [dbo].[ClaimBillingDetails] DROP CONSTRAINT [DF__ClaimBill__Insur__208CD6FA]
GO
ALTER TABLE [dbo].[ClaimBillingDetails] DROP CONSTRAINT [DF__ClaimBill__Allow__1F98B2C1]
GO
ALTER TABLE [dbo].[ClaimBillingDetails] DROP CONSTRAINT [DF__ClaimBill__Bille__1EA48E88]
GO
ALTER TABLE [dbo].[BillingProviderMaster] DROP CONSTRAINT [DF__BillingPr__Creat__47DBAE45]
GO
ALTER TABLE [dbo].[BillingProviderMaster] DROP CONSTRAINT [DF__BillingPr__IsAct__1DB06A4F]
GO
ALTER TABLE [dbo].[BillingMaster] DROP CONSTRAINT [DF__BillingMa__Updat__1E9A6CE7]
GO
ALTER TABLE [dbo].[BillingMaster] DROP CONSTRAINT [DF__BillingMa__Creat__1DA648AE]
GO
/****** Object:  Table [dbo].[VisitAgaistAccessionStaging]******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[VisitAgaistAccessionStaging]') AND type in (N'U'))
DROP TABLE [dbo].[VisitAgaistAccessionStaging]
GO
/****** Object:  Table [dbo].[VAAMaster]******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[VAAMaster]') AND type in (N'U'))
DROP TABLE [dbo].[VAAMaster]
GO
/****** Object:  Table [dbo].[TransactionSummary]******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[TransactionSummary]') AND type in (N'U'))
DROP TABLE [dbo].[TransactionSummary]
GO
/****** Object:  Table [dbo].[TransactionMaster]******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[TransactionMaster]') AND type in (N'U'))
DROP TABLE [dbo].[TransactionMaster]
GO
/****** Object:  Table [dbo].[TransactionDetailStaging]******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[TransactionDetailStaging]') AND type in (N'U'))
DROP TABLE [dbo].[TransactionDetailStaging]
GO
/****** Object:  Table [dbo].[TestTypeMaster]******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[TestTypeMaster]') AND type in (N'U'))
DROP TABLE [dbo].[TestTypeMaster]
GO
/****** Object:  Table [dbo].[SpecimenStatus]******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[SpecimenStatus]') AND type in (N'U'))
DROP TABLE [dbo].[SpecimenStatus]
GO
/****** Object:  Table [dbo].[SampleFinalStatus]******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[SampleFinalStatus]') AND type in (N'U'))
DROP TABLE [dbo].[SampleFinalStatus]
GO
/****** Object:  Table [dbo].[SalesPerson]******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[SalesPerson]') AND type in (N'U'))
DROP TABLE [dbo].[SalesPerson]
GO
/****** Object:  Table [dbo].[ReportDownloadSts]******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ReportDownloadSts]') AND type in (N'U'))
DROP TABLE [dbo].[ReportDownloadSts]
GO
/****** Object:  Table [dbo].[ReferringProviderMaster]******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ReferringProviderMaster]') AND type in (N'U'))
DROP TABLE [dbo].[ReferringProviderMaster]
GO
/****** Object:  Table [dbo].[ProdStatusRuleEngine]******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ProdStatusRuleEngine]') AND type in (N'U'))
DROP TABLE [dbo].[ProdStatusRuleEngine]
GO
/****** Object:  Table [dbo].[PrismBillingStaging]******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[PrismBillingStaging]') AND type in (N'U'))
DROP TABLE [dbo].[PrismBillingStaging]
GO
/****** Object:  Table [dbo].[PayerTypeMaster]******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[PayerTypeMaster]') AND type in (N'U'))
DROP TABLE [dbo].[PayerTypeMaster]
GO
/****** Object:  Table [dbo].[PanelMasterStaging]******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[PanelMasterStaging]') AND type in (N'U'))
DROP TABLE [dbo].[PanelMasterStaging]
GO
/****** Object:  Table [dbo].[PanelGroup]******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[PanelGroup]') AND type in (N'U'))
DROP TABLE [dbo].[PanelGroup]
GO
/****** Object:  Table [dbo].[OperationsGroupMaster]******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[OperationsGroupMaster]') AND type in (N'U'))
DROP TABLE [dbo].[OperationsGroupMaster]
GO
/****** Object:  Table [dbo].[LISStaging]******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[LISStaging]') AND type in (N'U'))
DROP TABLE [dbo].[LISStaging]
GO
/****** Object:  Table [dbo].[LISMaster]******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[LISMaster]') AND type in (N'U'))
DROP TABLE [dbo].[LISMaster]
GO
/****** Object:  Table [dbo].[LabMaster]******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[LabMaster]') AND type in (N'U'))
DROP TABLE [dbo].[LabMaster]
GO
/****** Object:  Table [dbo].[InsurancePayerMaster]******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[InsurancePayerMaster]') AND type in (N'U'))
DROP TABLE [dbo].[InsurancePayerMaster]
GO
/****** Object:  Table [dbo].[ImportFilTypes]******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ImportFilTypes]') AND type in (N'U'))
DROP TABLE [dbo].[ImportFilTypes]
GO
/****** Object:  Table [dbo].[ImportFileLogs]******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ImportFileLogs]') AND type in (N'U'))
DROP TABLE [dbo].[ImportFileLogs]
GO
/****** Object:  Table [dbo].[ImportedFiles]******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ImportedFiles]') AND type in (N'U'))
DROP TABLE [dbo].[ImportedFiles]
GO
/****** Object:  Table [dbo].[ICDCodeMaster]******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ICDCodeMaster]') AND type in (N'U'))
DROP TABLE [dbo].[ICDCodeMaster]
GO
/****** Object:  Table [dbo].[FileStatuses]******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[FileStatuses]') AND type in (N'U'))
DROP TABLE [dbo].[FileStatuses]
GO
/****** Object:  Table [dbo].[DownloadReportTypes]******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[DownloadReportTypes]') AND type in (N'U'))
DROP TABLE [dbo].[DownloadReportTypes]
GO
/****** Object:  Table [dbo].[DiagnoseLISStaging]******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[DiagnoseLISStaging]') AND type in (N'U'))
DROP TABLE [dbo].[DiagnoseLISStaging]
GO
/****** Object:  Table [dbo].[DenialTrackingStaging]******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[DenialTrackingStaging]') AND type in (N'U'))
DROP TABLE [dbo].[DenialTrackingStaging]
GO
/****** Object:  Table [dbo].[CustomCollectionStaging]******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[CustomCollectionStaging]') AND type in (N'U'))
DROP TABLE [dbo].[CustomCollectionStaging]
GO
/****** Object:  Table [dbo].[CPTCodeMaster]******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[CPTCodeMaster]') AND type in (N'U'))
DROP TABLE [dbo].[CPTCodeMaster]
GO
/****** Object:  Table [dbo].[ClinicMaster]******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ClinicMaster]') AND type in (N'U'))
DROP TABLE [dbo].[ClinicMaster]
GO
/****** Object:  Table [dbo].[ClaimsProdStatus]******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ClaimsProdStatus]') AND type in (N'U'))
DROP TABLE [dbo].[ClaimsProdStatus]
GO
/****** Object:  Table [dbo].[ClaimsLevelStatus]******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ClaimsLevelStatus]') AND type in (N'U'))
DROP TABLE [dbo].[ClaimsLevelStatus]
GO
/****** Object:  Table [dbo].[ClaimBillingDetails]******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ClaimBillingDetails]') AND type in (N'U'))
DROP TABLE [dbo].[ClaimBillingDetails]
GO
/****** Object:  Table [dbo].[BillingProviderMaster]******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[BillingProviderMaster]') AND type in (N'U'))
DROP TABLE [dbo].[BillingProviderMaster]
GO
/****** Object:  UserDefinedFunction [dbo].[fn_GetClaimStatusByVisitAndCPT]******/
DROP FUNCTION [dbo].[fn_GetClaimStatusByVisitAndCPT]
GO
/****** Object:  Table [dbo].[DenialTrackingMaster]******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[DenialTrackingMaster]') AND type in (N'U'))
DROP TABLE [dbo].[DenialTrackingMaster]
GO
/****** Object:  Table [dbo].[BillingMaster]******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[BillingMaster]') AND type in (N'U'))
DROP TABLE [dbo].[BillingMaster]
GO
/****** Object:  UserDefinedFunction [dbo].[GetDenailCodeByVisitNumber]******/
DROP FUNCTION [dbo].[GetDenailCodeByVisitNumber]
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
/****** Object:  UserDefinedFunction [dbo].[GetDenailCodeByVisitNumber]******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE FUNCTION [dbo].[GetDenailCodeByVisitNumber] (@visitno VARCHAR(100))
RETURNS NVARCHAR(MAX)
AS
BEGIN
    DECLARE @Result NVARCHAR(MAX);

    ;WITH Tokenized AS (
        SELECT DISTINCT
            TRIM(s.value) AS Code
        FROM DenialTrackingMaster d
        CROSS APPLY STRING_SPLIT(d.PaymentReasonCode, ';') AS s
        WHERE d.VisitNumber = @visitno
          AND d.PaymentReasonCode IS NOT NULL
          AND TRIM(s.value) <> ''
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
/****** Object:  Table [dbo].[BillingMaster]******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[BillingMaster](
	[BillingMasterID] [bigint] IDENTITY(1,1) NOT NULL,
	[LISMasterId] [bigint] NULL,
	[AccessionNo] [varchar](50) NULL,
	[VisitNumber] [nvarchar](250) NULL,
	[PrimaryPayerID] [int] NULL,
	[SecondaryPayerId] [int] NULL,
	[PayerTypeId] [int] NULL,
	[BillingProviderID] [int] NOT NULL,
	[ClientAccNum] [nvarchar](250) NULL,
	[MemberID] [varchar](25) NULL,
	[BeginDOS] [date] NULL,
	[EndDOS] [date] NULL,
	[ChargeEntryDate] [date] NULL,
	[FirstBillDate] [date] NULL,
	[BillingFrequency] [nvarchar](250) NULL,
	[ChargeEnteredBy] [nvarchar](250) NULL,
	[CPTCode] [varchar](25) NULL,
	[POS] [nvarchar](250) NULL,
	[TOS] [nvarchar](250) NULL,
	[Modifier] [varchar](50) NULL,
	[ICD10Code] [nvarchar](250) NULL,
	[Units] [int] NULL,
	[CheckDate] [date] NULL,
	[PaymentPostedDate] [date] NULL,
	[BilledAmount] [decimal](10, 2) NULL,
	[AllowedAmount] [decimal](10, 2) NULL,
	[InsurancePayment] [decimal](10, 2) NULL,
	[InsuranceAdjustment] [decimal](10, 2) NULL,
	[PatientPaidAmount] [decimal](10, 2) NULL,
	[PatientAdjustment] [decimal](10, 2) NULL,
	[InsuranceBalance] [decimal](10, 2) NULL,
	[PatientBalance] [decimal](10, 2) NULL,
	[TotalBalance] [decimal](10, 2) NULL,
	[FinalClaimStatus] [varchar](50) NULL,
	[CheckNumber] [varchar](150) NULL,
	[ChartNumber] [varchar](25) NULL,
	[CreatedOn] [datetime] NULL,
	[UpdatedOn] [datetime] NULL,
	[ClaimSubStatus] [varchar](50) NULL,
PRIMARY KEY CLUSTERED 
(
	[BillingMasterID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY],
 CONSTRAINT [UQ_BillingMaster_ACC] UNIQUE NONCLUSTERED 
(
	[VisitNumber] ASC,
	[CPTCode] ASC,
	[FirstBillDate] ASC,
	[Units] ASC,
	[Modifier] ASC,
	[BilledAmount] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[DenialTrackingMaster]******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[DenialTrackingMaster](
	[DenailTrackID] [int] IDENTITY(1,1) NOT NULL,
	[LISMasterID] [int] NULL,
	[VisitNumber] [varchar](50) NULL,
	[CPTCodes] [varchar](25) NULL,
	[TransactionCarrierCode] [varchar](50) NULL,
	[PaymentDate] [date] NULL,
	[PaymentReasonCode] [varchar](50) NULL,
	[DateOfService] [date] NULL,
	[ChargeAmount] [decimal](18, 2) NULL,
	[TotalBalance] [decimal](18, 2) NULL,
	[TotalAdjustment] [decimal](18, 2) NULL,
	[ReasonAmount] [decimal](18, 2) NULL,
	[DenailUser] [varchar](50) NULL,
	[LastAction] [varchar](50) NULL,
	[NextAction] [varchar](50) NULL,
	[LastActionDate] [date] NULL,
	[NextActionDate] [date] NULL,
	[Note] [varchar](250) NULL,
	[DenialCategoryCode] [varchar](50) NULL,
	[DenialCategoryDEscription] [varchar](250) NULL,
	[CreateOn] [datetime] NULL,
	[UpdatedOn] [datetime] NULL,
PRIMARY KEY CLUSTERED 
(
	[DenailTrackID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
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
/****** Object:  Table [dbo].[BillingProviderMaster]******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[BillingProviderMaster](
	[BillingProviderID] [int] IDENTITY(1,1) NOT NULL,
	[BillingProvider] [nvarchar](500) NOT NULL,
	[IsActive] [bit] NOT NULL,
	[CreatedOn] [datetime] NULL,
PRIMARY KEY CLUSTERED 
(
	[BillingProviderID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY],
UNIQUE NONCLUSTERED 
(
	[BillingProvider] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[ClaimBillingDetails]******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ClaimBillingDetails](
	[BillingDetailID] [int] IDENTITY(1,1) NOT NULL,
	[AccessionNo] [varchar](25) NOT NULL,
	[VisitNumber] [varchar](25) NOT NULL,
	[CPTCode] [varchar](25) NOT NULL,
	[FirstBillDate] [date] NULL,
	[BilledAmount] [decimal](18, 2) NULL,
	[AllowedAmount] [decimal](18, 2) NULL,
	[InsurancePaidAmount] [decimal](18, 2) NULL,
	[InsuranceAdjustmentAmount] [decimal](18, 2) NULL,
	[PatientPaidAmount] [decimal](18, 2) NULL,
	[PatientAdjustmentAmount] [decimal](18, 2) NULL,
	[InsuranceBalance] [decimal](18, 2) NULL,
	[PatientBalance] [decimal](18, 2) NULL,
	[TotalBalance] [decimal](18, 2) NULL,
	[CreatedOn] [datetime] NULL,
PRIMARY KEY CLUSTERED 
(
	[BillingDetailID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[ClaimsLevelStatus]******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ClaimsLevelStatus](
	[VisitNumber] [int] NOT NULL,
	[CPTCodes] [nvarchar](500) NOT NULL,
	[BilledAmount] [decimal](18, 2) NULL,
	[AllowedAmount] [decimal](18, 2) NULL,
	[InsurancePayment] [decimal](18, 2) NULL,
	[InsuranceAdjustment] [decimal](18, 2) NULL,
	[PatientPaidAmount] [decimal](18, 2) NULL,
	[PatientAdjustment] [decimal](18, 2) NULL,
	[InsuranceBalance] [decimal](18, 2) NULL,
	[PatientBalance] [decimal](18, 2) NULL,
	[TotalBalance] [decimal](18, 2) NULL,
	[DenailCode] [nvarchar](500) NULL,
	[FinalStatus] [nvarchar](50) NOT NULL,
	[ClaimSubStatus] [nvarchar](50) NULL,
	[FirstBillDate] [date] NULL,
	[CreatedOn] [datetime] NULL,
PRIMARY KEY CLUSTERED 
(
	[VisitNumber] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[ClaimsProdStatus]******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ClaimsProdStatus](
	[VisitNumber] [int] NOT NULL,
	[CPTCode] [varchar](20) NOT NULL,
	[BilledAmount] [float] NULL,
	[AllowedAmount] [float] NULL,
	[InsurancePayment] [float] NULL,
	[InsuranceAdjustment] [float] NULL,
	[PatientPaidAmount] [float] NULL,
	[PatientAdjustment] [float] NULL,
	[InsuranceBalance] [float] NULL,
	[PatientBalance] [float] NULL,
	[TotalBalance] [float] NULL,
	[DenialCode] [nvarchar](50) NULL,
	[FinalStatus] [nvarchar](50) NULL,
	[ClaimSubStatus] [nvarchar](500) NULL,
	[CreatedOn] [datetime] NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[ClinicMaster]******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ClinicMaster](
	[ClinicId] [int] IDENTITY(1,1) NOT NULL,
	[ClinicName] [nvarchar](500) NOT NULL,
	[ClinicStatus] [bit] NOT NULL,
	[CreatedOn] [datetime] NULL,
PRIMARY KEY CLUSTERED 
(
	[ClinicId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY],
UNIQUE NONCLUSTERED 
(
	[ClinicName] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[CPTCodeMaster]******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[CPTCodeMaster](
	[CPTCodeID] [int] IDENTITY(1,1) NOT NULL,
	[CPTCode] [varchar](20) NOT NULL,
	[CodeDescription] [nvarchar](500) NULL,
	[OriginalCode] [nvarchar](500) NULL,
	[IsActive] [bit] NOT NULL,
	[CreatedOn] [datetime] NULL,
PRIMARY KEY CLUSTERED 
(
	[CPTCodeID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[CustomCollectionStaging]******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[CustomCollectionStaging](
	[CCWId] [bigint] IDENTITY(1,1) NOT NULL,
	[PayerName] [nvarchar](500) NULL,
	[PayerType] [nvarchar](500) NULL,
	[BillingProvider] [nvarchar](500) NULL,
	[ReferringProvider] [nvarchar](500) NULL,
	[PerformingLab] [nvarchar](500) NULL,
	[PatientID] [int] NULL,
	[PatientName] [nvarchar](500) NULL,
	[DOB] [date] NULL,
	[ResponsibleParty] [nvarchar](500) NULL,
	[MemberID] [nvarchar](500) NULL,
	[VisitNumber] [int] NULL,
	[ClientAccNum] [nvarchar](500) NULL,
	[AccessionNo] [nvarchar](500) NULL,
	[BeginDOS] [date] NULL,
	[EndDOS] [date] NULL,
	[ChargeEntryDate] [date] NULL,
	[LastBillDate] [date] NULL,
	[BillingFrequency] [nvarchar](500) NULL,
	[ChargeEnteredBy] [nvarchar](500) NULL,
	[BilledCPTCode] [nvarchar](500) NULL,
	[POS] [nvarchar](500) NULL,
	[TOS] [nvarchar](500) NULL,
	[Modifier] [nvarchar](500) NULL,
	[ICD10Code] [nvarchar](500) NULL,
	[BilledAmount] [decimal](10, 2) NULL,
	[AllowedAmount] [decimal](10, 2) NULL,
	[InsurancePayments] [decimal](10, 2) NULL,
	[InsuranceAdjustments] [decimal](10, 2) NULL,
	[PatientPayments] [decimal](10, 2) NULL,
	[PatientAdjustments] [decimal](10, 2) NULL,
	[InsuranceBalance] [decimal](10, 2) NULL,
	[PatientBalance] [decimal](10, 2) NULL,
	[TotalBalance] [decimal](10, 2) NULL,
	[ImpotedOn] [datetime] NULL,
	[ImportedFileID] [int] NULL,
PRIMARY KEY CLUSTERED 
(
	[CCWId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[DenialTrackingStaging]******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[DenialTrackingStaging](
	[Provider] [nvarchar](500) NULL,
	[TransactionCarrierCode] [nvarchar](500) NULL,
	[FinancialClass] [nvarchar](500) NULL,
	[PaymentDate] [date] NULL,
	[PaymentReasonCode] [nvarchar](500) NULL,
	[PaymentReasonDescription] [nvarchar](500) NULL,
	[ChargeCode] [nvarchar](500) NULL,
	[PatientName] [nvarchar](500) NULL,
	[ServiceDate] [date] NULL,
	[VisitNumber] [nvarchar](500) NULL,
	[Charge] [decimal](18, 2) NULL,
	[TotalBalance] [decimal](18, 2) NULL,
	[TotalAdjustment] [decimal](18, 2) NULL,
	[ReasonAmount] [decimal](18, 2) NULL,
	[DenialUser] [nvarchar](500) NULL,
	[LastActionDate] [date] NULL,
	[LastAction] [nvarchar](500) NULL,
	[NextActionDate] [date] NULL,
	[NextAction] [nvarchar](500) NULL,
	[Note] [nvarchar](500) NULL,
	[DenialCategoryCode] [nvarchar](500) NULL,
	[DenialCategoryDescription] [nvarchar](500) NULL,
	[ImportedOn] [datetime] NULL,
	[ImportedFileID] [int] NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[DiagnoseLISStaging]******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[DiagnoseLISStaging](
	[DiagnoseLISID] [int] IDENTITY(1,1) NOT NULL,
	[OrderID] [nvarchar](max) NULL,
	[ReferenceID] [nvarchar](max) NULL,
	[SampleID] [nvarchar](max) NULL,
	[PaymentMethod] [nvarchar](max) NULL,
	[Barcode] [nvarchar](max) NULL,
	[Specimen] [nvarchar](max) NULL,
	[Container] [nvarchar](max) NULL,
	[Collectors] [nvarchar](max) NULL,
	[OrderStatus] [nvarchar](max) NULL,
	[BillingStatus] [nvarchar](max) NULL,
	[SpecimenStatus] [nvarchar](max) NULL,
	[ShipmentTracking] [nvarchar](max) NULL,
	[DateSubmitted] [date] NULL,
	[TimeSubmitted] [nvarchar](max) NULL,
	[DateCollected] [date] NULL,
	[TimeCollected] [nvarchar](max) NULL,
	[DateReceived] [date] NULL,
	[TimeReceived] [nvarchar](max) NULL,
	[DateReported] [date] NULL,
	[TimeReported] [nvarchar](max) NULL,
	[FacilityID] [nvarchar](max) NULL,
	[Facility] [nvarchar](255) NULL,
	[PerformingLaboratory] [nvarchar](255) NULL,
	[Tests] [nvarchar](max) NULL,
	[Results] [nvarchar](max) NULL,
	[PatientID] [nvarchar](max) NULL,
	[PatientFirstName] [nvarchar](max) NULL,
	[PatientLastName] [nvarchar](max) NULL,
	[PatientDateofBirth] [date] NULL,
	[PatientSex] [nvarchar](max) NULL,
	[PatientAddress1] [nvarchar](max) NULL,
	[PatientAddress2] [nvarchar](max) NULL,
	[PatientCity] [nvarchar](max) NULL,
	[PatientState] [nvarchar](max) NULL,
	[PatientZipCode] [nvarchar](max) NULL,
	[SalesRep] [nvarchar](max) NULL,
	[ProviderID] [nvarchar](max) NULL,
	[ProviderName] [nvarchar](255) NULL,
	[ProviderNPI] [nvarchar](max) NULL,
	[PrimaryInsurance] [nvarchar](max) NULL,
	[PrimaryInsuranceID] [nvarchar](max) NULL,
	[SecondaryInsurance] [nvarchar](max) NULL,
	[SecondaryInsuranceID] [nvarchar](max) NULL,
	[ICD10Codes] [nvarchar](max) NULL,
	[OrderNotes] [nvarchar](max) NULL,
	[SampleNotes] [nvarchar](max) NULL,
	[SampleRejectionReason] [nvarchar](max) NULL,
	[ImportedFileID] [int] NULL,
	[ImportedOn] [datetime] NULL,
PRIMARY KEY CLUSTERED 
(
	[DiagnoseLISID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[DownloadReportTypes]******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[DownloadReportTypes](
	[ReportTypeId] [int] NOT NULL,
	[ReportName] [varchar](50) NOT NULL,
	[IsActive] [bit] NULL,
	[LabId] [int] NULL,
PRIMARY KEY CLUSTERED 
(
	[ReportTypeId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY],
UNIQUE NONCLUSTERED 
(
	[ReportName] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[FileStatuses]******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[FileStatuses](
	[FileStatusId] [int] NOT NULL,
	[FileStatus] [varchar](30) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[FileStatusId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY],
UNIQUE NONCLUSTERED 
(
	[FileStatus] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[ICDCodeMaster]******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ICDCodeMaster](
	[ICDCodeID] [int] IDENTITY(1,1) NOT NULL,
	[ICD10Code] [nvarchar](500) NOT NULL,
	[CodeDescription] [nvarchar](500) NULL,
	[OriginalCode] [nvarchar](500) NULL,
	[IsActive] [bit] NOT NULL,
	[CreatedOn] [datetime] NULL,
PRIMARY KEY CLUSTERED 
(
	[ICDCodeID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY],
UNIQUE NONCLUSTERED 
(
	[ICD10Code] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[ImportedFiles]******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ImportedFiles](
	[ImportedFileID] [int] IDENTITY(1,1) NOT NULL,
	[ImportFileName] [nvarchar](500) NOT NULL,
	[ExcelRowCount] [int] NULL,
	[ImportedRowCount] [int] NULL,
	[FileStatus] [int] NULL,
	[FileType] [int] NULL,
	[ImportedOn] [datetime] NULL,
	[ProcessedOn] [datetime] NULL,
	[LabId] [int] NOT NULL,
	[ImportFilePath] [varchar](250) NULL,
	[LogFilePath] [nvarchar](500) NULL,
PRIMARY KEY CLUSTERED 
(
	[ImportedFileID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[ImportFileLogs]******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ImportFileLogs](
	[LogID] [int] IDENTITY(1,1) NOT NULL,
	[ImportFileId] [int] NOT NULL,
	[LogType] [varchar](30) NOT NULL,
	[LogMessage] [nvarchar](max) NOT NULL,
	[RowNo] [int] NULL,
	[ColumnName] [varchar](30) NULL,
	[CreatedOn] [datetime] NULL,
PRIMARY KEY CLUSTERED 
(
	[LogID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[ImportFilTypes]******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ImportFilTypes](
	[FileTypeId] [int] NOT NULL,
	[FileTypeName] [varchar](50) NULL,
	[LabId] [int] NOT NULL,
	[IsActive] [bit] NULL,
PRIMARY KEY CLUSTERED 
(
	[FileTypeId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY],
UNIQUE NONCLUSTERED 
(
	[FileTypeName] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[InsurancePayerMaster]******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[InsurancePayerMaster](
	[InsurancePayerId] [int] IDENTITY(1,1) NOT NULL,
	[PayerName] [nvarchar](500) NOT NULL,
	[IsActive] [bit] NOT NULL,
	[CreatedOn] [datetime] NULL,
PRIMARY KEY CLUSTERED 
(
	[InsurancePayerId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY],
UNIQUE NONCLUSTERED 
(
	[PayerName] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[LabMaster]******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[LabMaster](
	[LabID] [int] IDENTITY(1,1) NOT NULL,
	[LabName] [nvarchar](500) NOT NULL,
	[IsActive] [bit] NOT NULL,
	[CreatedOn] [datetime] NULL,
PRIMARY KEY CLUSTERED 
(
	[LabID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY],
UNIQUE NONCLUSTERED 
(
	[LabName] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[LISMaster]******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[LISMaster](
	[LISMasterId] [bigint] IDENTITY(1,1) NOT NULL,
	[AccessionNo] [nvarchar](150) NOT NULL,
	[LabId] [int] NULL,
	[BillingProviderID] [int] NULL,
	[PatientName] [nvarchar](250) NULL,
	[PatientID] [nvarchar](250) NULL,
	[PatientDOB] [nvarchar](250) NULL,
	[ResponsibleParty] [nvarchar](250) NULL,
	[PrimaryPayerName] [varchar](250) NULL,
	[PrimaryMemberId] [varchar](250) NULL,
	[PrimaryGroupNo] [varchar](250) NULL,
	[PrimaryEffectiveDate] [date] NULL,
	[RelationshipToInsurance] [nvarchar](250) NULL,
	[SecondaryPayerId] [int] NULL,
	[SecondaryMemberID] [varchar](250) NULL,
	[SecondaryGroupNo] [varchar](250) NULL,
	[SecondaryEffectiveDate] [date] NULL,
	[SampleCollectedDate] [date] NULL,
	[SampleReceivedDate] [date] NULL,
	[SampleAccessionedDate] [date] NULL,
	[SampleResultedDate] [date] NULL,
	[SampleRunDate] [date] NULL,
	[SampleStatusId] [int] NULL,
	[BilledTo] [varchar](250) NULL,
	[ReferringProviderId] [int] NULL,
	[ClinicId] [int] NULL,
	[SalesPersonId] [int] NULL,
	[OperationalGroupId] [int] NULL,
	[ICD10Code] [nvarchar](250) NULL,
	[TestCode] [nvarchar](250) NULL,
	[TestTypeId] [int] NULL,
	[Sendouts] [nvarchar](250) NULL,
	[TurnAround] [int] NULL,
	[OutStanding] [int] NULL,
	[OrderInfo] [nvarchar](max) NULL,
	[PanelId] [int] NULL,
	[PanelCode] [nvarchar](250) NULL,
	[PanelName] [nvarchar](250) NULL,
	[ResultedStatus] [varchar](100) NULL,
	[DaystoReceive] [int] NULL,
	[DaystoResult] [int] NULL,
	[DaystoBill] [int] NULL,
	[ClientStatus] [nvarchar](250) NULL,
	[PayerTypeId] [int] NULL,
	[SpecimenType] [varchar](200) NULL,
	[BillingSubStatus] [varchar](50) NULL,
	[BillingStatus] [varchar](50) NULL,
	[FirstBilledDate] [date] NULL,
	[ChargeEntryDate] [date] NULL,
	[VisitNumber] [varchar](100) NULL,
	[SelfPay] [varchar](100) NULL,
	[AccountPay] [varchar](100) NULL,
	[ContractPay] [varchar](100) NULL,
	[Analtyics] [varchar](100) NULL,
	[ScrubSettings] [varchar](500) NULL,
	[Actions] [varchar](200) NULL,
	[CreatedOn] [datetime] NULL,
	[CreatedBy] [varchar](20) NULL,
	[OrderID] [int] NULL,
	[ReferenceID] [int] NULL,
	[SampleID] [nvarchar](50) NULL,
	[Barcode] [nvarchar](50) NULL,
	[Container] [nvarchar](150) NULL,
	[Collectors] [nvarchar](150) NULL,
	[OrderStatus] [nvarchar](150) NULL,
	[ShipmentTrackingNo] [nvarchar](150) NULL,
	[TimeSubmitted] [nvarchar](150) NULL,
	[TimeCollected] [nvarchar](150) NULL,
	[TimeReceived] [nvarchar](150) NULL,
	[TimeReported] [nvarchar](150) NULL,
	[FacilityId] [int] NULL,
	[Tests] [nvarchar](max) NULL,
	[Results] [nvarchar](max) NULL,
	[PatientFirstName] [nvarchar](250) NULL,
	[PatientLastName] [nvarchar](250) NULL,
	[PatientSex] [nvarchar](50) NULL,
	[PatientAddress1] [nvarchar](250) NULL,
	[PatientAddress2] [nvarchar](250) NULL,
	[PatientCity] [nvarchar](50) NULL,
	[PatientState] [nvarchar](25) NULL,
	[PatientZipCode] [nvarchar](50) NULL,
	[ProviderNPI] [nvarchar](50) NULL,
	[OrderNotes] [nvarchar](250) NULL,
	[SampleNotes] [nvarchar](250) NULL,
	[SampleRejectionReason] [nvarchar](500) NULL,
	[LISFile] [nvarchar](30) NULL,
PRIMARY KEY CLUSTERED 
(
	[LISMasterId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY],
UNIQUE NONCLUSTERED 
(
	[AccessionNo] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY],
 CONSTRAINT [UQ_LISMaster_ACC] UNIQUE NONCLUSTERED 
(
	[AccessionNo] ASC,
	[LabId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[LISStaging]******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[LISStaging](
	[LISStagingId] [bigint] IDENTITY(1,1) NOT NULL,
	[CollectedDate] [date] NULL,
	[ReceivedDate] [date] NULL,
	[AccessionedDate] [date] NULL,
	[ResultedDate] [date] NULL,
	[Outstanding] [nvarchar](50) NULL,
	[Turnaround] [nvarchar](50) NULL,
	[SpecimenStatus] [nvarchar](500) NULL,
	[AccessionNo] [nvarchar](500) NOT NULL,
	[PerformingLab] [nvarchar](500) NULL,
	[PatientName] [nvarchar](500) NULL,
	[PayerName] [nvarchar](500) NULL,
	[MemberID] [nvarchar](500) NULL,
	[RelToInsured] [nvarchar](500) NULL,
	[SelfPay] [nvarchar](500) NULL,
	[AccountPay] [nvarchar](500) NULL,
	[ContractPay] [nvarchar](500) NULL,
	[ClinicName] [nvarchar](500) NULL,
	[OperationsGroup] [nvarchar](500) NULL,
	[SalesRep] [nvarchar](500) NULL,
	[Reference] [nvarchar](500) NULL,
	[Analtyics] [nvarchar](500) NULL,
	[TestType] [nvarchar](500) NULL,
	[ScrubSettings] [nvarchar](500) NULL,
	[Actions] [nvarchar](500) NULL,
	[OrderInfo] [nvarchar](max) NULL,
	[ImportedOn] [datetime] NULL,
	[ImportedFileID] [int] NULL,
PRIMARY KEY CLUSTERED 
(
	[LISStagingId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[OperationsGroupMaster]******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[OperationsGroupMaster](
	[OperationGroupID] [int] IDENTITY(1,1) NOT NULL,
	[OperationsGroup] [nvarchar](500) NOT NULL,
	[IsActive] [bit] NOT NULL,
	[CreatedOn] [datetime] NULL,
PRIMARY KEY CLUSTERED 
(
	[OperationGroupID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY],
UNIQUE NONCLUSTERED 
(
	[OperationsGroup] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[PanelGroup]******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[PanelGroup](
	[PanelGroupId] [int] IDENTITY(1,1) NOT NULL,
	[PanelName] [varchar](250) NOT NULL,
	[OrderInfo] [varchar](1000) NOT NULL,
	[PanelCategory] [varchar](50) NOT NULL,
	[IsActive] [bit] NULL,
	[CreatedOn] [datetime] NULL,
PRIMARY KEY CLUSTERED 
(
	[PanelGroupId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[PanelMasterStaging]******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[PanelMasterStaging](
	[PanelMasterID] [int] IDENTITY(1,1) NOT NULL,
	[PanelName] [nvarchar](250) NULL,
	[OrderInfo] [nvarchar](max) NULL,
	[PanelCategory] [nvarchar](250) NULL,
	[ImportedFileID] [int] NULL,
	[ImportedOn] [datetime] NULL,
PRIMARY KEY CLUSTERED 
(
	[PanelMasterID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[PayerTypeMaster]******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[PayerTypeMaster](
	[PayerTypeId] [int] IDENTITY(1,1) NOT NULL,
	[PayerType] [nvarchar](500) NOT NULL,
	[IsActive] [bit] NOT NULL,
	[CreatedOn] [datetime] NULL,
PRIMARY KEY CLUSTERED 
(
	[PayerTypeId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY],
UNIQUE NONCLUSTERED 
(
	[PayerType] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[PrismBillingStaging]******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[PrismBillingStaging](
	[SpecimenID] [varchar](250) NULL,
	[Customer] [nvarchar](1500) NULL,
	[Notes] [nvarchar](2500) NULL,
	[Payments] [varchar](250) NULL,
	[LAB] [varchar](250) NULL,
	[TestInfo] [nvarchar](2500) NULL,
	[MEDS] [nvarchar](2500) NULL,
	[Paid] [decimal](8, 2) NULL,
	[SheetName] [varchar](250) NULL,
	[ImportedOn] [datetime] NULL,
	[ImportedFileID] [int] NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[ProdStatusRuleEngine]******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ProdStatusRuleEngine](
	[RuleID] [int] IDENTITY(1,1) NOT NULL,
	[Resulted_Date_Condition] [nvarchar](50) NULL,
	[Billed_Date_Condition] [nvarchar](50) NULL,
	[TotalCharge_Condition] [nvarchar](50) NULL,
	[TotalAllowed_Condition] [nvarchar](50) NULL,
	[CarrierPayment_Condition] [nvarchar](50) NULL,
	[CarrierWO_Condition] [nvarchar](50) NULL,
	[PatientPayment_Condition] [nvarchar](50) NULL,
	[PatientWO_Condition] [nvarchar](50) NULL,
	[CarrierBalance_Condition] [nvarchar](50) NULL,
	[PatientBalance_Condition] [nvarchar](50) NULL,
	[TotalBalance_Condition] [nvarchar](50) NULL,
	[Denial_Code_Condition] [nvarchar](50) NULL,
	[Final_Output_Status] [nvarchar](100) NULL,
PRIMARY KEY CLUSTERED 
(
	[RuleID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY],
 CONSTRAINT [UQ_RuleEngine_Conditions] UNIQUE NONCLUSTERED 
(
	[Resulted_Date_Condition] ASC,
	[Billed_Date_Condition] ASC,
	[TotalCharge_Condition] ASC,
	[TotalAllowed_Condition] ASC,
	[CarrierPayment_Condition] ASC,
	[CarrierWO_Condition] ASC,
	[PatientPayment_Condition] ASC,
	[PatientWO_Condition] ASC,
	[CarrierBalance_Condition] ASC,
	[PatientBalance_Condition] ASC,
	[TotalBalance_Condition] ASC,
	[Denial_Code_Condition] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[ReferringProviderMaster]******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ReferringProviderMaster](
	[ReferingProviderId] [int] IDENTITY(1,1) NOT NULL,
	[ReferringProviderName] [nvarchar](500) NOT NULL,
	[IsActive] [bit] NOT NULL,
	[CreatedOn] [datetime] NULL,
PRIMARY KEY CLUSTERED 
(
	[ReferingProviderId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY],
UNIQUE NONCLUSTERED 
(
	[ReferringProviderName] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[ReportDownloadSts]******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ReportDownloadSts](
	[ReportID] [int] IDENTITY(1,1) NOT NULL,
	[ReportName] [nvarchar](250) NOT NULL,
	[ReportType] [int] NOT NULL,
	[ReportServerPath] [nvarchar](500) NULL,
	[ReportStatus] [int] NOT NULL,
	[CreatedOn] [datetime] NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[SalesPerson]******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[SalesPerson](
	[SalesPersonID] [int] IDENTITY(1,1) NOT NULL,
	[FirstName] [nvarchar](200) NULL,
	[LastName] [nvarchar](200) NULL,
	[SalesPersonName] [nvarchar](250) NOT NULL,
	[ReportingTo] [int] NULL,
	[ReportingLevelTop] [int] NOT NULL,
	[Status] [tinyint] NOT NULL,
	[CreatedDate] [datetime] NULL,
PRIMARY KEY CLUSTERED 
(
	[SalesPersonID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY],
UNIQUE NONCLUSTERED 
(
	[SalesPersonName] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[SampleFinalStatus]******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[SampleFinalStatus](
	[VisitNumber] [varchar](20) NOT NULL,
	[FinalStatus] [varchar](50) NOT NULL,
	[ClaimSubStatus] [varchar](250) NOT NULL,
 CONSTRAINT [PK_SampleFinalStatus] PRIMARY KEY CLUSTERED 
(
	[VisitNumber] ASC,
	[FinalStatus] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[SpecimenStatus]******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[SpecimenStatus](
	[SpecimenStatusId] [int] IDENTITY(1,1) NOT NULL,
	[SpecimenStatusName] [nvarchar](500) NOT NULL,
	[IsActive] [bit] NOT NULL,
	[CreatedOn] [datetime] NULL,
PRIMARY KEY CLUSTERED 
(
	[SpecimenStatusId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY],
UNIQUE NONCLUSTERED 
(
	[SpecimenStatusName] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[TestTypeMaster]******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[TestTypeMaster](
	[TestTypeId] [int] IDENTITY(1,1) NOT NULL,
	[TestTypeName] [nvarchar](500) NOT NULL,
	[IsActive] [bit] NOT NULL,
	[CreatedOn] [datetime] NULL,
PRIMARY KEY CLUSTERED 
(
	[TestTypeId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY],
UNIQUE NONCLUSTERED 
(
	[TestTypeName] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[TransactionDetailStaging]******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[TransactionDetailStaging](
	[TransactionDetailId] [int] IDENTITY(1,1) NOT NULL,
	[LabIdentityKey] [nvarchar](150) NULL,
	[TransactionType] [nvarchar](150) NULL,
	[ChartNumber] [nvarchar](150) NULL,
	[PatientName] [nvarchar](150) NULL,
	[FinancialClass] [nvarchar](150) NULL,
	[VisitNo] [nvarchar](150) NULL,
	[FacilityName] [nvarchar](150) NULL,
	[ProviderProfile] [nvarchar](150) NULL,
	[ChargeCode] [nvarchar](150) NULL,
	[TransactionCode] [nvarchar](150) NULL,
	[TransactionCodeDesc] [nvarchar](150) NULL,
	[Modifiers] [nvarchar](150) NULL,
	[VisitPrimaryCarrier] [nvarchar](150) NULL,
	[VisitSecondaryCarrier] [nvarchar](150) NULL,
	[TransactionCarrier] [nvarchar](150) NULL,
	[PrimaryDxICD9] [nvarchar](150) NULL,
	[PrimaryDxICD10] [nvarchar](150) NULL,
	[PaymentMethod] [nvarchar](150) NULL,
	[CheckNumber] [nvarchar](150) NULL,
	[DateofService] [date] NULL,
	[DateofEntry] [date] NULL,
	[DateofDeposit] [date] NULL,
	[Void] [nvarchar](150) NULL,
	[Units] [int] NULL,
	[TotalBilledAmount] [decimal](10, 2) NULL,
	[PatientPaidAmount] [decimal](10, 2) NULL,
	[InsurancePaidAmount] [decimal](10, 2) NULL,
	[TotalPaidAmount] [decimal](10, 2) NULL,
	[AdjustmentAmount] [decimal](10, 2) NULL,
	[ImportedOn] [datetime] NULL,
	[ImportedFileID] [int] NULL,
PRIMARY KEY CLUSTERED 
(
	[TransactionDetailId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[TransactionMaster]******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[TransactionMaster](
	[TransactionDetailID] [int] IDENTITY(1,1) NOT NULL,
	[LabIdentityKey] [int] NULL,
	[TransactionType] [varchar](50) NULL,
	[ChartNumber] [varchar](50) NULL,
	[VisitNo] [varchar](50) NULL,
	[CPTCode] [varchar](50) NULL,
	[TransactionCodeDesc] [varchar](250) NULL,
	[Modifiers] [varchar](50) NULL,
	[VisitPrimaryCarrier] [varchar](50) NULL,
	[VisitSecondaryCarrier] [varchar](50) NULL,
	[TransactionCarrier] [varchar](50) NULL,
	[PrimaryDxICD10] [varchar](100) NULL,
	[PrimaryDxICD9] [varchar](50) NULL,
	[PaymentMethod] [varchar](50) NULL,
	[CheckNumber] [varchar](50) NULL,
	[DateofService] [date] NULL,
	[DateofEntry] [date] NULL,
	[DateofDeposit] [date] NULL,
	[Void] [varchar](50) NULL,
	[Units] [int] NULL,
	[TotalBilledAmount] [decimal](18, 2) NULL,
	[PatientPaidAmount] [decimal](18, 2) NULL,
	[InsurancePaidAmount] [decimal](18, 2) NULL,
	[TotalPaidAmount] [decimal](18, 2) NULL,
	[AdjustmentAmount] [decimal](18, 2) NULL,
	[CreatedOn] [datetime] NULL,
	[UpdatedOn] [datetime] NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[TransactionSummary]******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[TransactionSummary](
	[VisitNumber] [int] NOT NULL,
	[CPTCode] [varchar](25) NOT NULL,
	[CheckNumber] [varchar](50) NULL,
	[DateOfDeposit] [date] NULL,
	[DateOfEntry] [date] NULL,
	[TransactionType] [varchar](30) NOT NULL,
	[Units] [int] NOT NULL,
	[TotalBilledAmount] [decimal](18, 2) NOT NULL,
	[AdjustmentAmount] [decimal](18, 2) NOT NULL,
	[PatientPaidAmount] [decimal](18, 2) NOT NULL,
	[TotalPaidAmount] [decimal](18, 2) NOT NULL,
	[InsurancePaidAmount] [decimal](18, 2) NOT NULL,
	[CreatedOn] [datetime] NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[VAAMaster]******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[VAAMaster](
	[VisitNumber] [nvarchar](30) NOT NULL,
	[AccessionNo] [nvarchar](30) NULL,
	[DateOfEntry] [date] NULL,
	[ServiceDate] [date] NULL,
	[CreatedOn] [datetime] NULL,
 CONSTRAINT [UQ_VAAMaster] UNIQUE NONCLUSTERED 
(
	[VisitNumber] ASC,
	[AccessionNo] ASC,
	[DateOfEntry] ASC,
	[ServiceDate] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[VisitAgaistAccessionStaging]******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[VisitAgaistAccessionStaging](
	[VAAId] [int] IDENTITY(1,1) NOT NULL,
	[Void] [nvarchar](50) NULL,
	[OfficeKey] [nvarchar](250) NULL,
	[VisitNumber] [nvarchar](250) NULL,
	[EntryDate] [date] NULL,
	[ServiceDate] [date] NULL,
	[AccessionNo] [nvarchar](250) NULL,
	[ImportedOn] [datetime] NULL,
	[ImportedFileID] [int] NULL,
PRIMARY KEY CLUSTERED 
(
	[VAAId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[BillingMaster] ADD  DEFAULT (getdate()) FOR [CreatedOn]
GO
ALTER TABLE [dbo].[BillingMaster] ADD  DEFAULT (getdate()) FOR [UpdatedOn]
GO
ALTER TABLE [dbo].[BillingProviderMaster] ADD  DEFAULT ((1)) FOR [IsActive]
GO
ALTER TABLE [dbo].[BillingProviderMaster] ADD  DEFAULT (getdate()) FOR [CreatedOn]
GO
ALTER TABLE [dbo].[ClaimBillingDetails] ADD  DEFAULT ((0.0)) FOR [BilledAmount]
GO
ALTER TABLE [dbo].[ClaimBillingDetails] ADD  DEFAULT ((0.0)) FOR [AllowedAmount]
GO
ALTER TABLE [dbo].[ClaimBillingDetails] ADD  DEFAULT ((0.0)) FOR [InsurancePaidAmount]
GO
ALTER TABLE [dbo].[ClaimBillingDetails] ADD  DEFAULT ((0.0)) FOR [InsuranceAdjustmentAmount]
GO
ALTER TABLE [dbo].[ClaimBillingDetails] ADD  DEFAULT ((0.0)) FOR [PatientPaidAmount]
GO
ALTER TABLE [dbo].[ClaimBillingDetails] ADD  DEFAULT ((0.0)) FOR [PatientAdjustmentAmount]
GO
ALTER TABLE [dbo].[ClaimBillingDetails] ADD  DEFAULT ((0.0)) FOR [InsuranceBalance]
GO
ALTER TABLE [dbo].[ClaimBillingDetails] ADD  DEFAULT ((0.0)) FOR [PatientBalance]
GO
ALTER TABLE [dbo].[ClaimBillingDetails] ADD  DEFAULT ((0.0)) FOR [TotalBalance]
GO
ALTER TABLE [dbo].[ClaimBillingDetails] ADD  DEFAULT (getdate()) FOR [CreatedOn]
GO
ALTER TABLE [dbo].[ClaimsLevelStatus] ADD  DEFAULT ((0)) FOR [BilledAmount]
GO
ALTER TABLE [dbo].[ClaimsLevelStatus] ADD  DEFAULT ((0)) FOR [AllowedAmount]
GO
ALTER TABLE [dbo].[ClaimsLevelStatus] ADD  DEFAULT ((0)) FOR [InsurancePayment]
GO
ALTER TABLE [dbo].[ClaimsLevelStatus] ADD  DEFAULT ((0)) FOR [InsuranceAdjustment]
GO
ALTER TABLE [dbo].[ClaimsLevelStatus] ADD  DEFAULT ((0)) FOR [PatientPaidAmount]
GO
ALTER TABLE [dbo].[ClaimsLevelStatus] ADD  DEFAULT ((0)) FOR [PatientAdjustment]
GO
ALTER TABLE [dbo].[ClaimsLevelStatus] ADD  DEFAULT ((0)) FOR [InsuranceBalance]
GO
ALTER TABLE [dbo].[ClaimsLevelStatus] ADD  DEFAULT ((0)) FOR [PatientBalance]
GO
ALTER TABLE [dbo].[ClaimsLevelStatus] ADD  DEFAULT ((0)) FOR [TotalBalance]
GO
ALTER TABLE [dbo].[ClaimsLevelStatus] ADD  DEFAULT (getdate()) FOR [CreatedOn]
GO
ALTER TABLE [dbo].[ClaimsProdStatus] ADD  DEFAULT (getdate()) FOR [CreatedOn]
GO
ALTER TABLE [dbo].[ClinicMaster] ADD  DEFAULT ((1)) FOR [ClinicStatus]
GO
ALTER TABLE [dbo].[ClinicMaster] ADD  DEFAULT (getdate()) FOR [CreatedOn]
GO
ALTER TABLE [dbo].[CPTCodeMaster] ADD  DEFAULT ((1)) FOR [IsActive]
GO
ALTER TABLE [dbo].[CPTCodeMaster] ADD  DEFAULT (getdate()) FOR [CreatedOn]
GO
ALTER TABLE [dbo].[CustomCollectionStaging] ADD  DEFAULT (getdate()) FOR [ImpotedOn]
GO
ALTER TABLE [dbo].[DenialTrackingMaster] ADD  DEFAULT (getdate()) FOR [CreateOn]
GO
ALTER TABLE [dbo].[DenialTrackingMaster] ADD  DEFAULT (getdate()) FOR [UpdatedOn]
GO
ALTER TABLE [dbo].[DenialTrackingStaging] ADD  DEFAULT (getdate()) FOR [ImportedOn]
GO
ALTER TABLE [dbo].[DiagnoseLISStaging] ADD  DEFAULT (getdate()) FOR [ImportedOn]
GO
ALTER TABLE [dbo].[DownloadReportTypes] ADD  DEFAULT ((1)) FOR [IsActive]
GO
ALTER TABLE [dbo].[ICDCodeMaster] ADD  DEFAULT ((1)) FOR [IsActive]
GO
ALTER TABLE [dbo].[ICDCodeMaster] ADD  DEFAULT (getdate()) FOR [CreatedOn]
GO
ALTER TABLE [dbo].[ImportedFiles] ADD  DEFAULT (getdate()) FOR [ImportedOn]
GO
ALTER TABLE [dbo].[ImportedFiles] ADD  DEFAULT ((3)) FOR [LabId]
GO
ALTER TABLE [dbo].[ImportFileLogs] ADD  DEFAULT (getdate()) FOR [CreatedOn]
GO
ALTER TABLE [dbo].[ImportFilTypes] ADD  DEFAULT ((1)) FOR [IsActive]
GO
ALTER TABLE [dbo].[InsurancePayerMaster] ADD  DEFAULT ((1)) FOR [IsActive]
GO
ALTER TABLE [dbo].[InsurancePayerMaster] ADD  DEFAULT (getdate()) FOR [CreatedOn]
GO
ALTER TABLE [dbo].[LabMaster] ADD  DEFAULT ((1)) FOR [IsActive]
GO
ALTER TABLE [dbo].[LabMaster] ADD  DEFAULT (getdate()) FOR [CreatedOn]
GO
ALTER TABLE [dbo].[LISMaster] ADD  DEFAULT (getdate()) FOR [CreatedOn]
GO
ALTER TABLE [dbo].[LISMaster] ADD  DEFAULT ('SYSTEM') FOR [CreatedBy]
GO
ALTER TABLE [dbo].[LISStaging] ADD  DEFAULT (getdate()) FOR [ImportedOn]
GO
ALTER TABLE [dbo].[OperationsGroupMaster] ADD  DEFAULT ((1)) FOR [IsActive]
GO
ALTER TABLE [dbo].[OperationsGroupMaster] ADD  DEFAULT (getdate()) FOR [CreatedOn]
GO
ALTER TABLE [dbo].[PanelGroup] ADD  DEFAULT ((1)) FOR [IsActive]
GO
ALTER TABLE [dbo].[PanelGroup] ADD  DEFAULT (getdate()) FOR [CreatedOn]
GO
ALTER TABLE [dbo].[PanelMasterStaging] ADD  DEFAULT (getdate()) FOR [ImportedOn]
GO
ALTER TABLE [dbo].[PayerTypeMaster] ADD  DEFAULT ((1)) FOR [IsActive]
GO
ALTER TABLE [dbo].[PayerTypeMaster] ADD  DEFAULT (getdate()) FOR [CreatedOn]
GO
ALTER TABLE [dbo].[PrismBillingStaging] ADD  DEFAULT (getdate()) FOR [ImportedOn]
GO
ALTER TABLE [dbo].[ReferringProviderMaster] ADD  DEFAULT ((1)) FOR [IsActive]
GO
ALTER TABLE [dbo].[ReferringProviderMaster] ADD  DEFAULT (getdate()) FOR [CreatedOn]
GO
ALTER TABLE [dbo].[SalesPerson] ADD  DEFAULT (getdate()) FOR [CreatedDate]
GO
ALTER TABLE [dbo].[SpecimenStatus] ADD  DEFAULT ((1)) FOR [IsActive]
GO
ALTER TABLE [dbo].[SpecimenStatus] ADD  DEFAULT (getdate()) FOR [CreatedOn]
GO
ALTER TABLE [dbo].[TestTypeMaster] ADD  DEFAULT ((1)) FOR [IsActive]
GO
ALTER TABLE [dbo].[TestTypeMaster] ADD  DEFAULT (getdate()) FOR [CreatedOn]
GO
ALTER TABLE [dbo].[TransactionDetailStaging] ADD  DEFAULT (getdate()) FOR [ImportedOn]
GO
ALTER TABLE [dbo].[TransactionMaster] ADD  DEFAULT (getdate()) FOR [CreatedOn]
GO
ALTER TABLE [dbo].[TransactionSummary] ADD  DEFAULT ((0)) FOR [Units]
GO
ALTER TABLE [dbo].[TransactionSummary] ADD  DEFAULT ((0.0)) FOR [TotalBilledAmount]
GO
ALTER TABLE [dbo].[TransactionSummary] ADD  DEFAULT ((0.0)) FOR [AdjustmentAmount]
GO
ALTER TABLE [dbo].[TransactionSummary] ADD  DEFAULT ((0.0)) FOR [PatientPaidAmount]
GO
ALTER TABLE [dbo].[TransactionSummary] ADD  DEFAULT ((0.0)) FOR [TotalPaidAmount]
GO
ALTER TABLE [dbo].[TransactionSummary] ADD  DEFAULT ((0.0)) FOR [InsurancePaidAmount]
GO
ALTER TABLE [dbo].[TransactionSummary] ADD  DEFAULT (getdate()) FOR [CreatedOn]
GO
ALTER TABLE [dbo].[VAAMaster] ADD  DEFAULT (getdate()) FOR [CreatedOn]
GO
ALTER TABLE [dbo].[VisitAgaistAccessionStaging] ADD  DEFAULT (getdate()) FOR [ImportedOn]
GO
ALTER TABLE [dbo].[BillingMaster]  WITH NOCHECK ADD FOREIGN KEY([BillingProviderID])
REFERENCES [dbo].[BillingProviderMaster] ([BillingProviderID])
GO
ALTER TABLE [dbo].[BillingMaster]  WITH NOCHECK ADD FOREIGN KEY([BillingProviderID])
REFERENCES [dbo].[BillingProviderMaster] ([BillingProviderID])
GO
ALTER TABLE [dbo].[BillingMaster]  WITH NOCHECK ADD FOREIGN KEY([BillingProviderID])
REFERENCES [dbo].[BillingProviderMaster] ([BillingProviderID])
GO
ALTER TABLE [dbo].[BillingMaster]  WITH NOCHECK ADD FOREIGN KEY([BillingProviderID])
REFERENCES [dbo].[BillingProviderMaster] ([BillingProviderID])
GO
ALTER TABLE [dbo].[BillingMaster]  WITH NOCHECK ADD FOREIGN KEY([BillingProviderID])
REFERENCES [dbo].[BillingProviderMaster] ([BillingProviderID])
GO
ALTER TABLE [dbo].[BillingMaster]  WITH NOCHECK ADD FOREIGN KEY([LISMasterId])
REFERENCES [dbo].[LISMaster] ([LISMasterId])
GO
ALTER TABLE [dbo].[BillingMaster]  WITH NOCHECK ADD FOREIGN KEY([LISMasterId])
REFERENCES [dbo].[LISMaster] ([LISMasterId])
GO
ALTER TABLE [dbo].[BillingMaster]  WITH NOCHECK ADD FOREIGN KEY([LISMasterId])
REFERENCES [dbo].[LISMaster] ([LISMasterId])
GO
ALTER TABLE [dbo].[BillingMaster]  WITH NOCHECK ADD FOREIGN KEY([LISMasterId])
REFERENCES [dbo].[LISMaster] ([LISMasterId])
GO
ALTER TABLE [dbo].[BillingMaster]  WITH NOCHECK ADD FOREIGN KEY([LISMasterId])
REFERENCES [dbo].[LISMaster] ([LISMasterId])
GO
ALTER TABLE [dbo].[BillingMaster]  WITH NOCHECK ADD FOREIGN KEY([PayerTypeId])
REFERENCES [dbo].[PayerTypeMaster] ([PayerTypeId])
GO
ALTER TABLE [dbo].[BillingMaster]  WITH NOCHECK ADD FOREIGN KEY([PayerTypeId])
REFERENCES [dbo].[PayerTypeMaster] ([PayerTypeId])
GO
ALTER TABLE [dbo].[BillingMaster]  WITH NOCHECK ADD FOREIGN KEY([PayerTypeId])
REFERENCES [dbo].[PayerTypeMaster] ([PayerTypeId])
GO
ALTER TABLE [dbo].[BillingMaster]  WITH NOCHECK ADD FOREIGN KEY([PayerTypeId])
REFERENCES [dbo].[PayerTypeMaster] ([PayerTypeId])
GO
ALTER TABLE [dbo].[BillingMaster]  WITH NOCHECK ADD FOREIGN KEY([PayerTypeId])
REFERENCES [dbo].[PayerTypeMaster] ([PayerTypeId])
GO
ALTER TABLE [dbo].[BillingMaster]  WITH NOCHECK ADD FOREIGN KEY([PrimaryPayerID])
REFERENCES [dbo].[InsurancePayerMaster] ([InsurancePayerId])
GO
ALTER TABLE [dbo].[BillingMaster]  WITH NOCHECK ADD FOREIGN KEY([PrimaryPayerID])
REFERENCES [dbo].[InsurancePayerMaster] ([InsurancePayerId])
GO
ALTER TABLE [dbo].[BillingMaster]  WITH NOCHECK ADD FOREIGN KEY([PrimaryPayerID])
REFERENCES [dbo].[InsurancePayerMaster] ([InsurancePayerId])
GO
ALTER TABLE [dbo].[BillingMaster]  WITH NOCHECK ADD FOREIGN KEY([PrimaryPayerID])
REFERENCES [dbo].[InsurancePayerMaster] ([InsurancePayerId])
GO
ALTER TABLE [dbo].[BillingMaster]  WITH NOCHECK ADD FOREIGN KEY([PrimaryPayerID])
REFERENCES [dbo].[InsurancePayerMaster] ([InsurancePayerId])
GO
ALTER TABLE [dbo].[LISMaster]  WITH NOCHECK ADD FOREIGN KEY([BillingProviderID])
REFERENCES [dbo].[BillingProviderMaster] ([BillingProviderID])
GO
ALTER TABLE [dbo].[LISMaster]  WITH NOCHECK ADD FOREIGN KEY([BillingProviderID])
REFERENCES [dbo].[BillingProviderMaster] ([BillingProviderID])
GO
ALTER TABLE [dbo].[LISMaster]  WITH NOCHECK ADD FOREIGN KEY([BillingProviderID])
REFERENCES [dbo].[BillingProviderMaster] ([BillingProviderID])
GO
ALTER TABLE [dbo].[LISMaster]  WITH NOCHECK ADD FOREIGN KEY([BillingProviderID])
REFERENCES [dbo].[BillingProviderMaster] ([BillingProviderID])
GO
ALTER TABLE [dbo].[LISMaster]  WITH NOCHECK ADD FOREIGN KEY([BillingProviderID])
REFERENCES [dbo].[BillingProviderMaster] ([BillingProviderID])
GO
ALTER TABLE [dbo].[LISMaster]  WITH NOCHECK ADD FOREIGN KEY([ClinicId])
REFERENCES [dbo].[ClinicMaster] ([ClinicId])
GO
ALTER TABLE [dbo].[LISMaster]  WITH NOCHECK ADD FOREIGN KEY([ClinicId])
REFERENCES [dbo].[ClinicMaster] ([ClinicId])
GO
ALTER TABLE [dbo].[LISMaster]  WITH NOCHECK ADD FOREIGN KEY([ClinicId])
REFERENCES [dbo].[ClinicMaster] ([ClinicId])
GO
ALTER TABLE [dbo].[LISMaster]  WITH NOCHECK ADD FOREIGN KEY([ClinicId])
REFERENCES [dbo].[ClinicMaster] ([ClinicId])
GO
ALTER TABLE [dbo].[LISMaster]  WITH NOCHECK ADD FOREIGN KEY([ClinicId])
REFERENCES [dbo].[ClinicMaster] ([ClinicId])
GO
ALTER TABLE [dbo].[LISMaster]  WITH NOCHECK ADD FOREIGN KEY([LabId])
REFERENCES [dbo].[LabMaster] ([LabID])
GO
ALTER TABLE [dbo].[LISMaster]  WITH NOCHECK ADD FOREIGN KEY([LabId])
REFERENCES [dbo].[LabMaster] ([LabID])
GO
ALTER TABLE [dbo].[LISMaster]  WITH NOCHECK ADD FOREIGN KEY([LabId])
REFERENCES [dbo].[LabMaster] ([LabID])
GO
ALTER TABLE [dbo].[LISMaster]  WITH NOCHECK ADD FOREIGN KEY([LabId])
REFERENCES [dbo].[LabMaster] ([LabID])
GO
ALTER TABLE [dbo].[LISMaster]  WITH NOCHECK ADD FOREIGN KEY([LabId])
REFERENCES [dbo].[LabMaster] ([LabID])
GO
ALTER TABLE [dbo].[LISMaster]  WITH NOCHECK ADD FOREIGN KEY([OperationalGroupId])
REFERENCES [dbo].[OperationsGroupMaster] ([OperationGroupID])
GO
ALTER TABLE [dbo].[LISMaster]  WITH NOCHECK ADD FOREIGN KEY([OperationalGroupId])
REFERENCES [dbo].[OperationsGroupMaster] ([OperationGroupID])
GO
ALTER TABLE [dbo].[LISMaster]  WITH NOCHECK ADD FOREIGN KEY([OperationalGroupId])
REFERENCES [dbo].[OperationsGroupMaster] ([OperationGroupID])
GO
ALTER TABLE [dbo].[LISMaster]  WITH NOCHECK ADD FOREIGN KEY([OperationalGroupId])
REFERENCES [dbo].[OperationsGroupMaster] ([OperationGroupID])
GO
ALTER TABLE [dbo].[LISMaster]  WITH NOCHECK ADD FOREIGN KEY([OperationalGroupId])
REFERENCES [dbo].[OperationsGroupMaster] ([OperationGroupID])
GO
ALTER TABLE [dbo].[LISMaster]  WITH NOCHECK ADD FOREIGN KEY([PanelId])
REFERENCES [dbo].[PanelGroup] ([PanelGroupId])
GO
ALTER TABLE [dbo].[LISMaster]  WITH NOCHECK ADD FOREIGN KEY([PanelId])
REFERENCES [dbo].[PanelGroup] ([PanelGroupId])
GO
ALTER TABLE [dbo].[LISMaster]  WITH NOCHECK ADD FOREIGN KEY([PanelId])
REFERENCES [dbo].[PanelGroup] ([PanelGroupId])
GO
ALTER TABLE [dbo].[LISMaster]  WITH NOCHECK ADD FOREIGN KEY([PanelId])
REFERENCES [dbo].[PanelGroup] ([PanelGroupId])
GO
ALTER TABLE [dbo].[LISMaster]  WITH NOCHECK ADD FOREIGN KEY([PanelId])
REFERENCES [dbo].[PanelGroup] ([PanelGroupId])
GO
ALTER TABLE [dbo].[LISMaster]  WITH NOCHECK ADD FOREIGN KEY([PayerTypeId])
REFERENCES [dbo].[PayerTypeMaster] ([PayerTypeId])
GO
ALTER TABLE [dbo].[LISMaster]  WITH NOCHECK ADD FOREIGN KEY([PayerTypeId])
REFERENCES [dbo].[PayerTypeMaster] ([PayerTypeId])
GO
ALTER TABLE [dbo].[LISMaster]  WITH NOCHECK ADD FOREIGN KEY([PayerTypeId])
REFERENCES [dbo].[PayerTypeMaster] ([PayerTypeId])
GO
ALTER TABLE [dbo].[LISMaster]  WITH NOCHECK ADD FOREIGN KEY([PayerTypeId])
REFERENCES [dbo].[PayerTypeMaster] ([PayerTypeId])
GO
ALTER TABLE [dbo].[LISMaster]  WITH NOCHECK ADD FOREIGN KEY([PayerTypeId])
REFERENCES [dbo].[PayerTypeMaster] ([PayerTypeId])
GO
ALTER TABLE [dbo].[LISMaster]  WITH NOCHECK ADD FOREIGN KEY([ReferringProviderId])
REFERENCES [dbo].[ReferringProviderMaster] ([ReferingProviderId])
GO
ALTER TABLE [dbo].[LISMaster]  WITH NOCHECK ADD FOREIGN KEY([ReferringProviderId])
REFERENCES [dbo].[ReferringProviderMaster] ([ReferingProviderId])
GO
ALTER TABLE [dbo].[LISMaster]  WITH NOCHECK ADD FOREIGN KEY([ReferringProviderId])
REFERENCES [dbo].[ReferringProviderMaster] ([ReferingProviderId])
GO
ALTER TABLE [dbo].[LISMaster]  WITH NOCHECK ADD FOREIGN KEY([ReferringProviderId])
REFERENCES [dbo].[ReferringProviderMaster] ([ReferingProviderId])
GO
ALTER TABLE [dbo].[LISMaster]  WITH NOCHECK ADD FOREIGN KEY([ReferringProviderId])
REFERENCES [dbo].[ReferringProviderMaster] ([ReferingProviderId])
GO
ALTER TABLE [dbo].[LISMaster]  WITH NOCHECK ADD FOREIGN KEY([SampleStatusId])
REFERENCES [dbo].[SpecimenStatus] ([SpecimenStatusId])
GO
ALTER TABLE [dbo].[LISMaster]  WITH NOCHECK ADD FOREIGN KEY([SampleStatusId])
REFERENCES [dbo].[SpecimenStatus] ([SpecimenStatusId])
GO
ALTER TABLE [dbo].[LISMaster]  WITH NOCHECK ADD FOREIGN KEY([SampleStatusId])
REFERENCES [dbo].[SpecimenStatus] ([SpecimenStatusId])
GO
ALTER TABLE [dbo].[LISMaster]  WITH NOCHECK ADD FOREIGN KEY([SampleStatusId])
REFERENCES [dbo].[SpecimenStatus] ([SpecimenStatusId])
GO
ALTER TABLE [dbo].[LISMaster]  WITH NOCHECK ADD FOREIGN KEY([SampleStatusId])
REFERENCES [dbo].[SpecimenStatus] ([SpecimenStatusId])
GO
ALTER TABLE [dbo].[LISMaster]  WITH NOCHECK ADD FOREIGN KEY([TestTypeId])
REFERENCES [dbo].[TestTypeMaster] ([TestTypeId])
GO
ALTER TABLE [dbo].[LISMaster]  WITH NOCHECK ADD FOREIGN KEY([TestTypeId])
REFERENCES [dbo].[TestTypeMaster] ([TestTypeId])
GO
ALTER TABLE [dbo].[LISMaster]  WITH NOCHECK ADD FOREIGN KEY([TestTypeId])
REFERENCES [dbo].[TestTypeMaster] ([TestTypeId])
GO
ALTER TABLE [dbo].[LISMaster]  WITH NOCHECK ADD FOREIGN KEY([TestTypeId])
REFERENCES [dbo].[TestTypeMaster] ([TestTypeId])
GO
ALTER TABLE [dbo].[LISMaster]  WITH NOCHECK ADD FOREIGN KEY([TestTypeId])
REFERENCES [dbo].[TestTypeMaster] ([TestTypeId])
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


    -- Step 1: Load distinct staging data
    SELECT DISTINCT
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
        PatientName,
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


WITH VAAccession AS(
SELECT DISTINCT AccessionNo,VisitNumber FROM VisitAgaistAccessionStaging 
)

    SELECT
        vaa.LISMasterId,
        vaa.AccessionNo,
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
	LEFT JOIN #VAATemp vaa ON CC.VisitNumber = vaa.VisitNumber
    LEFT JOIN InsurancePayerMaster IPM ON TRIM(CC.PayerName) = TRIM(IPM.PayerName)
    LEFT JOIN PayerTypeMaster PT ON TRIM(CC.PayerType) = TRIM(PT.PayerType)
    LEFT JOIN BillingProviderMaster BP ON TRIM(CC.BillingProvider) = TRIM(BP.BillingProvider)
    GROUP BY
		vaa.LISMasterId,
        vaa.AccessionNo,
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
		VAA.AccessionNo,
		cc.UNITS,CC.Modifier;

    -- Step 3: Deduplicate
    WITH RankedBilling AS (
        SELECT *,
            ROW_NUMBER() OVER (
                PARTITION BY 
        VisitNumber, CPTCode,  FirstBillDate,UNITS,Modifier,BilledAmount
                ORDER BY BilledAmount DESC
            ) AS RowNum
        FROM #BillingMaster
    )
    SELECT *
    INTO #BillingMaster_Deduped
    FROM RankedBilling
    WHERE RowNum = 1;

    -- Step 4: Merge
    BEGIN TRY
        BEGIN TRANSACTION;

     
	            INSERT into BillingMaster(
                LISMasterId,
                AccessionNo,
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
				Units
            )
			SELECT LISMasterId,AccessionNo,VisitNumber,InsurancePayerId,PayerTypeId,BillingProviderID,ClientAccNum,MemberID,BeginDOS,EndDOS,
			ChargeEntryDate,FirstBillDate,BillingFrequency,ChargeEnteredBy,CPTCode,POS,TOS,Modifier,ICD10Code,BilledAmount,AllowedAmount,InsurancePayments,
			InsuranceAdjustments,PatientPayments,PatientAdjustments,InsuranceBalance,PatientBalance,TotalBalance,UNITS FROM #BillingMaster_Deduped BM WHERE NOT EXISTS (
    SELECT 1 FROM BillingMaster tbm
    WHERE tbm.CPTCode = BM.CPTCode
      AND ISNULL(tbm.FirstBillDate, '1900-01-01') = ISNULL(BM.FirstBillDate, '1900-01-01')
      AND tbm.VisitNumber = BM.VisitNumber
      AND ISNULL(tbm.Units, 999) = ISNULL(BM.Units, 999)
      AND tbm.BilledAmount = BM.BilledAmount
      AND ISNULL(tbm.Modifier, 9999) = ISNULL(BM.Modifier, 9999)
)


		   UPDATE BM SET 	
				BM.AccessionNo = BTM.AccessionNo,
				BM.PrimaryPayerID = BTM.InsurancePayerId,
                BM.PayerTypeId = BTM.PayerTypeId,
                BM.BillingProviderID = BTM.BillingProviderID,
                BM.ClientAccNum = BTM.ClientAccNum,
                BM.MemberID = BTM.MemberID,
                BM.BeginDOS = BTM.BeginDOS,
                BM.EndDOS = BTM.EndDOS,
                BM.ChargeEntryDate = BTM.ChargeEntryDate,
                BM.BillingFrequency = BTM.BillingFrequency,
                BM.ChargeEnteredBy = BTM.ChargeEnteredBy,
                BM.POS = BTM.POS,
                BM.TOS = BTM.TOS,
                BM.Modifier = BTM.Modifier,
                BM.ICD10Code = BTM.ICD10Code,
                BM.BilledAmount = BTM.BilledAmount,
                BM.AllowedAmount = BTM.AllowedAmount,
                BM.InsurancePayment = BTM.InsurancePayments,
                BM.InsuranceAdjustment = BTM.InsuranceAdjustments,
                BM.PatientPaidAmount = BTM.PatientPayments,
                BM.PatientAdjustment = BTM.PatientAdjustments,
                BM.InsuranceBalance = BTM.InsuranceBalance,
                BM.PatientBalance = BTM.PatientBalance,
                BM.TotalBalance = BTM.TotalBalance,
                BM.UpdatedOn = GETDATE(),
				BM.Units = BTM.Units 
				FROM BillingMaster BM 
				JOIN #BillingMaster_Deduped BTM
			  ON BTM.CPTCode = BM.CPTCode
			  AND ISNULL(BTM.FirstBillDate, '1900-01-01') = ISNULL(BM.FirstBillDate, '1900-01-01')
			  AND BTM.VisitNumber = BM.VisitNumber
			  AND ISNULL(BTM.Units, 999) = ISNULL(BM.Units, 999)
			  AND BTM.BilledAmount = BM.BilledAmount
			  AND ISNULL(BTM.Modifier, 9999) = ISNULL(BM.Modifier, 9999)

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
WHEN BilledAmount > 0 AND InsurancePayment = 0 AND PatientPaidAmount = 0 AND InsuranceAdjustment = 0 AND InsuranceBalance = BilledAmount AND PatientBalance = 0 AND PatientAdjustment = 0 AND DenailCode IS NOT NULL THEN 'Fully Denied'
-----------------Rule Id : 5
WHEN BilledAmount > 0 AND InsurancePayment = 0 AND PatientPaidAmount = 0 AND InsuranceAdjustment > 0 AND InsuranceBalance > 0 AND PatientBalance = 0 AND PatientAdjustment = 0 AND DenailCode IS NOT NULL THEN 'Fully Denied'
-----------------Rule Id : 6
WHEN BilledAmount > 0 AND InsurancePayment = BilledAmount AND PatientPaidAmount = 0 AND InsuranceAdjustment = 0 AND InsuranceBalance = 0 AND PatientBalance = 0 AND PatientAdjustment = 0 AND CPTCode NOT LIKE '%99999%'  THEN 'Fully Paid'
-----------------Rule Id : 7
WHEN BilledAmount > 0 AND InsurancePayment > 0 AND PatientPaidAmount = 0 AND InsuranceAdjustment = 0 AND InsuranceBalance = 0 AND PatientBalance = 0 AND PatientAdjustment > 0 THEN 'Fully Paid'
-----------------Rule Id : 8
WHEN BilledAmount > 0 AND InsurancePayment > 0 AND PatientPaidAmount = 0 AND InsuranceAdjustment > 0 AND InsuranceBalance = 0 AND PatientBalance = 0 AND PatientAdjustment = 0 THEN 'Fully Paid'
-----------------Rule Id : 9
WHEN BilledAmount > 0 AND InsurancePayment > 0 AND PatientPaidAmount = 0 AND InsuranceAdjustment > 0 AND InsuranceBalance = 0 AND PatientBalance = 0 AND PatientAdjustment > 0 THEN 'Fully Paid'
-----------------Rule Id : 10
WHEN BilledAmount > 0 AND InsurancePayment > 0 AND PatientPaidAmount = 0 AND InsuranceAdjustment = 0 AND InsuranceBalance = 0 AND PatientBalance> 0 AND PatientAdjustment = 0 THEN 'Partially Paid'
-----------------Rule Id : 11
WHEN BilledAmount > 0 AND InsurancePayment > 0 AND PatientPaidAmount = 0 AND InsuranceAdjustment > 0 AND InsuranceBalance = 0 AND PatientBalance > 0 AND PatientAdjustment = 0 THEN 'Partially Paid'
-----------------Rule Id : 12
WHEN BilledAmount > 0 AND InsurancePayment > 0 AND PatientPaidAmount = 0 AND InsuranceAdjustment > 0 AND InsuranceBalance = 0 AND PatientBalance > 0 AND PatientAdjustment > 0 THEN 'Fully Paid'
-----------------Rule Id : 13
WHEN BilledAmount > 0 AND InsurancePayment = 0 AND PatientPaidAmount = 0 AND InsuranceAdjustment = 0 AND InsuranceBalance = BilledAmount AND PatientBalance = 0 AND PatientAdjustment = 0 THEN 'No Response'
-----------------Rule Id : 14
WHEN BilledAmount > 0 AND InsurancePayment = 0 AND PatientPaidAmount = 0 AND InsuranceAdjustment = 0 AND InsuranceBalance = BilledAmount AND PatientBalance = 0 AND PatientAdjustment = 0 AND DenailCode IS NULL AND CPTCode LIKE '%99999%' AND FirstBillDate IS NULL THEN 'No Response - Client'
-----------------Rule Id : 15
WHEN BilledAmount > 0 AND InsurancePayment = BilledAmount AND PatientPaidAmount = 0 AND InsuranceAdjustment = 0 AND InsuranceBalance = 0 AND PatientBalance = 0 AND PatientAdjustment = 0 AND DenailCode IS NULL AND CPTCode LIKE '%99999%' AND FirstBillDate IS NOT NULL THEN 'Paid To Client'
-----------------Rule Id : 16
WHEN BilledAmount > 0 AND InsurancePayment = 0 AND PatientPaidAmount = 0 AND InsuranceAdjustment > 0 AND InsuranceBalance > 0 AND PatientBalance > 0 AND PatientAdjustment = 0 AND DenailCode IS NULL THEN 'No Response'
-----------------Rule Id : 17
WHEN BilledAmount > 0 AND InsurancePayment = 0 AND PatientPaidAmount = 0 AND InsuranceAdjustment = 0 AND InsuranceBalance > 0 AND PatientBalance > 0 AND PatientAdjustment = 0 AND DenailCode IS NOT NULL THEN 'Partially Denied'
-----------------Rule Id : 18
WHEN BilledAmount > 0 AND InsurancePayment = 0 AND PatientPaidAmount = 0 AND InsuranceAdjustment > 0 AND InsuranceBalance > 0 AND PatientBalance > 0 AND PatientAdjustment = 0 AND DenailCode IS NOT NULL THEN 'Partially Denied'
-----------------Rule Id : 19
WHEN BilledAmount > 0 AND InsurancePayment = 0 AND PatientPaidAmount = 0 AND InsuranceAdjustment > 0 AND InsuranceBalance > 0 AND PatientBalance > 0 AND PatientAdjustment > 0 AND DenailCode IS NOT NULL THEN 'Partially Denied'
-----------------Rule Id : 20
WHEN BilledAmount > 0 AND InsurancePayment = 0 AND PatientPaidAmount = 0 AND InsuranceAdjustment > 0 AND InsuranceBalance > 0 AND PatientBalance = 0 AND PatientAdjustment > 0 AND DenailCode IS NOT NULL THEN 'Partially Denied'
-----------------Rule Id : 21
WHEN BilledAmount > 0 AND InsurancePayment > 0 AND PatientPaidAmount = 0 AND InsuranceAdjustment = 0 AND InsuranceBalance > 0 AND PatientBalance = 0 AND PatientAdjustment = 0 THEN 'Partially Paid'
-----------------Rule Id : 22
WHEN BilledAmount > 0 AND InsurancePayment > 0 AND PatientPaidAmount = 0 AND InsuranceAdjustment = 0 AND InsuranceBalance > 0 AND PatientBalance > 0 AND PatientAdjustment = 0 THEN 'Partially Paid'
-----------------Rule Id : 23
WHEN BilledAmount > 0 AND InsurancePayment > 0 AND PatientPaidAmount = 0 AND InsuranceAdjustment > 0 AND InsuranceBalance > 0 AND PatientBalance = 0 AND PatientAdjustment = 0 THEN 'Partially Paid'
-----------------Rule Id : 24
WHEN BilledAmount > 0 AND InsurancePayment > 0 AND PatientPaidAmount = 0 AND InsuranceAdjustment > 0 AND InsuranceBalance > 0 AND PatientBalance > 0 AND PatientAdjustment = 0 THEN 'Partially Paid'
-----------------Rule Id : 25
WHEN BilledAmount > 0 AND InsurancePayment = 0 AND PatientPaidAmount > 0 AND InsuranceAdjustment > 0 AND InsuranceBalance = 0 AND PatientBalance = 0 AND PatientAdjustment = 0 THEN 'Patient Payment'
-----------------Rule Id : 26
WHEN BilledAmount > 0 AND InsurancePayment = 0 AND PatientPaidAmount = BilledAmount AND InsuranceAdjustment = 0 AND InsuranceBalance = 0 AND PatientBalance = 0 AND PatientAdjustment = 0 THEN 'Patient Payment'
-----------------Rule Id : 27
WHEN BilledAmount > 0 AND InsurancePayment = 0 AND PatientPaidAmount = 0 AND InsuranceAdjustment = 0 AND InsuranceBalance = 0 AND PatientBalance = BilledAmount AND PatientAdjustment = 0 AND CPTCode NOT LIKE '%99999%' THEN 'Patient Responsibility'
-----------------Rule Id : 28
WHEN BilledAmount > 0 AND InsurancePayment = 0 AND PatientPaidAmount = 0 AND InsuranceAdjustment = 0 AND InsuranceBalance = 0 AND PatientBalance > 0 AND PatientAdjustment > 0 THEN 'Patient Responsibility'
-----------------Rule Id : 29
WHEN BilledAmount > 0 AND InsurancePayment = 0 AND PatientPaidAmount = 0 AND InsuranceAdjustment > 0 AND InsuranceBalance = 0 AND PatientBalance > 0 AND PatientAdjustment = 0 THEN 'Patient Responsibility'
-----------------Rule Id : 30
WHEN BilledAmount > 0 AND InsurancePayment = 0 AND PatientPaidAmount = 0 AND InsuranceAdjustment > 0 AND InsuranceBalance = 0 AND PatientBalance > 0 AND PatientAdjustment > 0 THEN 'Patient Responsibility'
-----------------Rule Id : 31
WHEN BilledAmount > 0 AND InsurancePayment = 0 AND PatientPaidAmount = 0 AND InsuranceAdjustment = 0 AND InsuranceBalance = 0 AND PatientBalance = BilledAmount AND PatientAdjustment = 0  AND CPTCode LIKE '%99999%' THEN 'Patient Responsibility - Client'
-----------------Rule Id : 32
WHEN BilledAmount > 0 AND InsurancePayment = 0 AND PatientPaidAmount = 0 AND InsuranceAdjustment = 0 AND InsuranceBalance = BilledAmount AND PatientBalance = 0 AND PatientAdjustment = 0 AND FirstBillDate IS NULL AND CPTCode NOT LIKE '%99999%'  THEN 'Unbilled'
-----------------Rule Id : 33
WHEN BilledAmount > 0 AND InsurancePayment = 0 AND PatientPaidAmount = 0 AND InsuranceAdjustment = 0 AND InsuranceBalance = BilledAmount AND PatientBalance = 0 AND PatientAdjustment = 0 AND FirstBillDate IS NULL  AND CPTCode LIKE '%99999%' THEN 'Unbilled - Client'
-----------------Rule Id : 34
WHEN BilledAmount > 0 AND InsurancePayment = 0 AND PatientPaidAmount = 0 AND InsuranceAdjustment > 0 AND InsuranceBalance > 0 AND PatientBalance = 0 AND PatientAdjustment = 0 AND DenailCode IS NOT NULL THEN 'Partially Denied'
-----------------Rule Id : 35
WHEN BilledAmount > 0 AND InsurancePayment = 0 AND PatientPaidAmount = 0 AND InsuranceAdjustment = 0 AND InsuranceBalance > 0 AND PatientBalance > 0 AND PatientAdjustment > 0 AND DenailCode IS NOT NULL THEN 'Partially Denied'
-----------------Rule Id : 36
WHEN BilledAmount > 0 AND InsurancePayment = 0 AND PatientPaidAmount = 0 AND InsuranceAdjustment = 0 AND InsuranceBalance > 0 AND PatientBalance = 0 AND PatientAdjustment > 0 AND DenailCode IS NOT NULL THEN 'Partially Denied'
-----------------Rule Id : 37
WHEN BilledAmount > 0 AND InsurancePayment > 0 AND PatientPaidAmount > 0 AND InsuranceAdjustment = 0 AND InsuranceBalance > 0 AND PatientBalance = 0 AND PatientAdjustment = 0 THEN 'Partially Paid'
-----------------Rule Id : 38
WHEN BilledAmount > 0 AND InsurancePayment > 0 AND PatientPaidAmount > 0 AND InsuranceAdjustment > 0 AND InsuranceBalance > 0 AND PatientBalance = 0 AND PatientAdjustment = 0 THEN 'Partially Paid'
-----------------Rule Id : 39
WHEN BilledAmount > 0 AND InsurancePayment > 0 AND PatientPaidAmount > 0 AND InsuranceAdjustment > 0 AND InsuranceBalance > 0 AND PatientBalance = 0 AND PatientAdjustment > 0 THEN 'Partially Paid'
-----------------Rule Id : 40
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
    SELECT DISTINCT 
        ISNULL(UPPER(b.AccessionNo),'Missing LIS Info') AccessionNo,
        b.VisitNumber,
        b.CPTCode,
        PatientName,
        l.PatientID,
		CONVERT(VARCHAR, PatientDOB, 101)  PatientDOB, 
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
		CONVERT(VARCHAR, dt.PaymentDate, 101)	    DenialPostedDate,
        b.CheckNumber,
        b.Modifier,
        PaymentReasonCode as DenialCode,
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
		pg.PanelCategory PanelGroup,
		b.ClaimSubStatus,
		CASE WHEN b.AccessionNo is null then 'Missing LIS Data' else '' end LISMissingRecord 
    FROM BillingMaster b
    LEFT JOIN LISMaster l ON b.AccessionNo = l.AccessionNo
    LEFT JOIN InsurancePayerMaster i ON b.PrimaryPayerID = i.InsurancePayerId
    LEFT JOIN PayerTypeMaster p ON b.PayerTypeId = p.PayerTypeId
    LEFT JOIN BillingProviderMaster bp ON b.BillingProviderID = bp.BillingProviderID
    LEFT JOIN DenialTrackingMaster dt ON b.VisitNumber = dt.VisitNumber AND b.CPTCode = dt.CPTCodes
    LEFT JOIN PanelGroup pg ON l.OrderInfo = pg.OrderInfo 
	
	LEFT JOIN LabMaster LAB ON l.LabId = LAB.LabID
    LEFT JOIN ClinicMaster CM ON l.ClinicId = CM.ClinicId
    LEFT JOIN OperationsGroupMaster OG ON l.OperationalGroupId = OG.OperationGroupID 
    LEFT JOIN TestTypeMaster TT ON l.TestTypeId = TT.TestTypeId
    LEFT JOIN ReferringProviderMaster RP ON l.ReferringProviderId = RP.ReferingProviderId

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
            LIS.PatientName,
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
    SELECT DISTINCT 
        ISNULL(UPPER(b.AccessionNo),'Missing LIS Info') AccessionNo,
        b.VisitNumber,
        b.CPTCode,
        PatientName,
        PatientID,
		CONVERT(VARCHAR, PatientDOB, 101)  PatientDOB, 
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
		CONVERT(VARCHAR, dt.PaymentDate, 101)	    DenialPostedDate,
        b.CheckNumber,
        b.Modifier,
        PaymentReasonCode as DenialCode,
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
    LEFT JOIN DenialTrackingMaster dt ON b.VisitNumber = dt.VisitNumber AND b.CPTCode = dt.CPTCodes
    LEFT JOIN PanelGroup pg ON l.OrderInfo = pg.OrderInfo 
	
	LEFT JOIN LabMaster LAB ON l.LabId = LAB.LabID
    LEFT JOIN ClinicMaster CM ON l.ClinicId = CM.ClinicId
    LEFT JOIN OperationsGroupMaster OG ON l.OperationalGroupId = OG.OperationGroupID 
    LEFT JOIN TestTypeMaster TT ON l.TestTypeId = TT.TestTypeId
    LEFT JOIN ReferringProviderMaster RP ON l.ReferringProviderId = RP.ReferingProviderId

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

    SELECT DISTINCT VisitNo, ChartNumber 
    INTO #TransactionMaster  
    FROM TransactionMaster 
    WHERE VisitNo IS NOT NULL;

    CREATE NONCLUSTERED INDEX IX_VisitNumber_BM ON #BillingMasterTemp (VisitNumber);

    DROP TABLE IF EXISTS #DenialCode;
    SELECT DISTINCT VisitNumber, DBO.GetDenailCodeByVisitNumber(VisitNumber) AS DenialCode 
    INTO #DenialCode 
    FROM DenialTrackingMaster
    WHERE PaymentReasonCode IS NOT NULL;

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
            BM.BeginDOS,
            BM.FirstBillDate,
            BM.TOS,
            BM.ICD10Code,
            LIS.LISMasterId,
            LIS.AccessionNo,
            LIS.PatientName,
			TT.TestTypeName TestType,
			CM.ClinicName,
			LIS.SampleCollectedDate,
			PG.PanelCategory,
            ISNULL(LIS.ReferringProviderId, 0) AS ReferringProviderId,
            PG.PanelName,
            ISNULL(LIS.LabId, 0) AS LabId,
            ISNULL(LIS.PanelId, 0) AS PanelId,
            ROW_NUMBER() OVER (PARTITION BY BM.VisitNumber ORDER BY BM.FirstBillDate DESC) AS rn
        FROM #BillingMasterTemp BM
        LEFT JOIN LISMaster LIS WITH (NOLOCK) ON BM.LISMasterId = LIS.LISMasterId
        LEFT JOIN PanelGroup PG WITH (NOLOCK) ON LIS.PanelId = PG.PanelGroupId
		LEFT JOIN TestTypeMaster TT ON LIS.TestTypeId = TT.TestTypeId
		LEFT JOIN ClinicMaster CM ON LIS.ClinicId = CM.ClinicId
    )
    SELECT DISTINCT
        md.VisitNumber,
        ISNULL(md.AccessionNo,'Missing LIS Data') AS AccessionNo,
        ISNULL(md.PanelName,'Missing LIS Data') AS PanelName,
        ISNULL(IPM.PayerName,'Missing Payer Info') AS Carrier,
        FC.PayerType AS FinancialClass,
        BP.BillingProvider,
        RF.ReferringProviderName,
        TM.ChartNumber,
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
		CONVERT(VARCHAR, EC.ChargeEntryDate, 101)   AS LatestPostDate,
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
    LEFT JOIN #TransactionMaster TM ON md.VisitNumber = TM.VisitNo
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

Create Procedure [dbo].[sp_InsertClaimDenialCode]
AS BEGIN


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


INSERT INTO [dbo].[ClinicMaster]([ClinicName],[ClinicStatus])
SELECT DISTINCT LTRIM(RTRIM(ClinicName)),1 FROM LISStaging 
WHERE LTRIM(RTRIM(ClinicName)) NOT IN (SELECT DISTINCT ClinicName FROM [ClinicMaster]) AND ClinicName IS NOT NULL

PRINT '[ClinicMaster] Inserted Completed'



INSERT INTO [dbo].[OperationsGroupMaster]([OperationsGroup],[IsActive])
SELECT DISTINCT LTRIM(RTRIM(OperationsGroup)),1 FROM LISStaging 
WHERE LTRIM(RTRIM(OperationsGroup)) NOT IN (SELECT DISTINCT [OperationsGroup] FROM [OperationsGroupMaster]) AND OperationsGroup IS NOT NULL

PRINT '[OperationsGroupMaster] Inserted Completed'



INSERT INTO [dbo].[SpecimenStatus]([SpecimenStatusName],[IsActive])
SELECT DISTINCT LTRIM(RTRIM(SpecimenStatus)),1 FROM LISStaging 
WHERE LTRIM(RTRIM(SpecimenStatus)) NOT IN (SELECT DISTINCT [SpecimenStatusName] FROM [SpecimenStatus]) AND SpecimenStatus IS NOT NULL

PRINT '[SpecimenStatu] Inserted Completed'



INSERT INTO [dbo].[TestTypeMaster]([TestTypeName],[IsActive])
SELECT DISTINCT LTRIM(RTRIM(TestType)),1 FROM LISStaging 
WHERE LTRIM(RTRIM(TestType)) NOT IN (SELECT DISTINCT [TestTypeName] FROM [TestTypeMaster]) AND TestType IS NOT NULL

PRINT '[TestTypeMaster] Inserted Completed'

 


INSERT INTO [dbo].[InsurancePayerMaster]([PayerName],[IsActive])
SELECT DISTINCT LTRIM(RTRIM(PayerName)),1 FROM LISStaging 
WHERE LTRIM(RTRIM(PayerName)) NOT IN (SELECT DISTINCT [PayerName] FROM [InsurancePayerMaster]) AND PayerName IS NOT NULL



INSERT INTO [dbo].[InsurancePayerMaster]([PayerName],[IsActive])
SELECT DISTINCT LTRIM(RTRIM(PayerName)),1 FROM CustomCollectionStaging 
WHERE LTRIM(RTRIM(PayerName)) NOT IN (SELECT DISTINCT [PayerName] FROM [InsurancePayerMaster]) AND PayerName IS NOT NULL

PRINT '[InsurancePayerMaster] Inserted Completed'

 

INSERT INTO [dbo].PayerTypeMaster([PayerType],[IsActive])
SELECT DISTINCT LTRIM(RTRIM(PayerType)),1 FROM CustomCollectionStaging 
WHERE LTRIM(RTRIM(PayerType)) NOT IN (SELECT DISTINCT [PayerType] FROM PayerTypeMaster) AND PayerType IS NOT NULL

PRINT '[PayerTypeMaster] Inserted Completed'

 

INSERT INTO [dbo].BillingProviderMaster([BillingProvider],[IsActive])
SELECT DISTINCT LTRIM(RTRIM(BillingProvider)),1 FROM CustomCollectionStaging 
WHERE LTRIM(RTRIM(BillingProvider)) NOT IN (SELECT DISTINCT [BillingProvider] FROM BillingProviderMaster) AND BillingProvider IS NOT NULL

PRINT '[BillingProviderMaster] Inserted Completed'

 

INSERT INTO [dbo].ReferringProviderMaster([ReferringProviderName],[IsActive])
SELECT DISTINCT LTRIM(RTRIM(ReferringProvider)),1 FROM CustomCollectionStaging 
WHERE LTRIM(RTRIM(ReferringProvider)) NOT IN (SELECT DISTINCT [ReferringProviderName] FROM ReferringProviderMaster) AND ReferringProvider IS NOT NULL

PRINT '[ReferringProviderMaster] Inserted Completed'

 

INSERT INTO [dbo].LabMaster(LabName,[IsActive])
SELECT DISTINCT LTRIM(RTRIM(PerformingLab)),1 FROM CustomCollectionStaging 
WHERE LTRIM(RTRIM(PerformingLab)) NOT IN (SELECT DISTINCT LabName FROM LabMaster) AND PerformingLab IS NOT NULL

PRINT '[LabMaster] Inserted Completed'

 

DROP TABLE IF EXISTS #CPTCodes;
SELECT DISTINCT LTRIM(RTRIM(SUBSTRING(BilledCPTCode, 0, 6))) CPTCode,LTRIM(RTRIM(SUBSTRING(BilledCPTCode, 6, LEN(BilledCPTCode)))) CodeDescription,
BilledCPTCode OriginalCode INTO #CPTCodes FROM CustomCollectionStaging WHERE BilledCPTCode IS NOT NULL

INSERT INTO [dbo].CPTCodeMaster(CPTCode,CodeDescription,OriginalCode,[IsActive])
SELECT CPTCode,CodeDescription,OriginalCode,1 FROM #CPTCodes
WHERE CPTCode NOT IN (SELECT DISTINCT CPTCode FROM CPTCodeMaster) 

PRINT '[CPTCodeMaster] Inserted Completed'



DROP TABLE IF EXISTS #ICD10Codes;
SELECT DISTINCT   LTRIM(RTRIM(LEFT(ICD10Code, CHARINDEX('-', ICD10Code) - 1))) ICD10Code,
LTRIM(RTRIM(SUBSTRING(ICD10Code, CHARINDEX('-', ICD10Code) + 1, LEN(ICD10Code)))) CodeDescription , ICD10Code AS [OriginalCode]
INTO #ICD10Codes FROM CustomCollectionStaging WHERE  LTRIM(RTRIM(ICD10Code)) IS NOT NULL


INSERT INTO [dbo].ICDCodeMaster(ICD10Code,CodeDescription,OriginalCode)
SELECT ICD10Code,CodeDescription,[OriginalCode] FROM #ICD10Codes WHERE ICD10Code NOT IN (SELECT DISTINCT ICD10Code FROM ICDCodeMaster)

PRINT '[ICDCodeMaster] Inserted Completed'

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
		SELECT d.PanelName,LTRIM(RTRIM(d.OrderInfo)),LTRIM(RTRIM(d.PanelCategory))
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

        -- Prepare temp data with distinct AccessionNo
        WITH CTE_VAA AS
        (
            SELECT 
                VisitNumber,
                AccessionNo,
                EntryDate AS DateOfEntry,
                ServiceDate,
                ROW_NUMBER() OVER (PARTITION BY AccessionNo ORDER BY EntryDate) AS RowNum
            FROM VisitAgaistAccessionStaging  
            WHERE (ImportedFileID = @FileId OR @FileId is Null) and AccessionNo is not null AND VisitNumber is not null
        )
        SELECT 
            VisitNumber,
            AccessionNo,
            DateOfEntry,
            ServiceDate
        INTO #VAATemp 
        FROM CTE_VAA 
        WHERE RowNum = 1;

        -- Insert new records into VAAMaster if not exists
        INSERT INTO VAAMaster (VisitNumber, AccessionNo, DateOfEntry, ServiceDate)
        SELECT 
            t.VisitNumber,
            t.AccessionNo,
            t.DateOfEntry,
            t.ServiceDate
        FROM #VAATemp t
        WHERE NOT EXISTS (
            SELECT 1 
            FROM VAAMaster v
            WHERE 
                v.VisitNumber = t.VisitNumber AND 
                v.AccessionNo = t.AccessionNo AND
                v.DateOfEntry = t.DateOfEntry AND
                v.ServiceDate = t.ServiceDate
        );

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
        JOIN #AggregatedTemp AT 
            ON TM.VisitNo = AT.VisitNo AND TM.CPTCode = AT.ChargeCode and ISNULL(TM.Units,999) =  ISNULL(AT.Units,999) 
			and ISNULL(TM.Modifiers,999) =  ISNULL(AT.Modifiers,999)   and TM.TotalBilledAmount =  AT.TotalBilledAmount;

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
		WHERE NOT EXISTS (
			SELECT 1
			FROM TransactionMaster TM
			WHERE TM.VisitNo = AT.VisitNo
			  AND TM.CPTCode = AT.ChargeCode
			  AND ISNULL(TM.Units, 999) = ISNULL(AT.Units, 999)
			  AND ISNULL(TM.Modifiers, 'NA') = ISNULL(AT.Modifiers, 'NA')
			  AND TM.TotalBilledAmount = AT.TotalBilledAmount
		) ORDER BY TransactionType ;

		

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
