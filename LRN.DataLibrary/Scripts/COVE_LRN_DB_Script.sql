USE [CoveLRN]
GO
/****** Object:  StoredProcedure [dbo].[SP_UpdateLIS_Statuses]******/
DROP PROCEDURE [dbo].[SP_UpdateLIS_Statuses]
GO
/****** Object:  StoredProcedure [dbo].[Sp_ProcessTransactionDetails]******/
DROP PROCEDURE [dbo].[Sp_ProcessTransactionDetails]
GO
/****** Object:  StoredProcedure [dbo].[SP_ProcessLISvsBilling]******/
DROP PROCEDURE [dbo].[SP_ProcessLISvsBilling]
GO
/****** Object:  StoredProcedure [dbo].[Sp_ProcessDenialTrackingMaster]******/
DROP PROCEDURE [dbo].[Sp_ProcessDenialTrackingMaster]
GO
/****** Object:  StoredProcedure [dbo].[Sp_ProcessBillingMasterData]******/
DROP PROCEDURE [dbo].[Sp_ProcessBillingMasterData]
GO
/****** Object:  StoredProcedure [dbo].[Sp_ProcessAccessionPaymentReport]******/
DROP PROCEDURE [dbo].[Sp_ProcessAccessionPaymentReport]
GO
/****** Object:  StoredProcedure [dbo].[SP_Process_LISMaster_ByFileId]******/
DROP PROCEDURE [dbo].[SP_Process_LISMaster_ByFileId]
GO
/****** Object:  StoredProcedure [dbo].[sp_Process_FinalCalimStatus]******/
DROP PROCEDURE [dbo].[sp_Process_FinalCalimStatus]
GO
/****** Object:  StoredProcedure [dbo].[Sp_Process_BillingSheet_ByFileId]******/
DROP PROCEDURE [dbo].[Sp_Process_BillingSheet_ByFileId]
GO
/****** Object:  StoredProcedure [dbo].[sp_LIS_PanelUpdate]******/
DROP PROCEDURE [dbo].[sp_LIS_PanelUpdate]
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
ALTER TABLE [dbo].[BillingMaster] DROP CONSTRAINT [FK__BillingMa__Prima__7F179FED]
GO
ALTER TABLE [dbo].[BillingMaster] DROP CONSTRAINT [FK__BillingMa__Prima__07ACE5EE]
GO
ALTER TABLE [dbo].[BillingMaster] DROP CONSTRAINT [FK__BillingMa__Prima__06B8C1B5]
GO
ALTER TABLE [dbo].[BillingMaster] DROP CONSTRAINT [FK__BillingMa__Prima__05C49D7C]
GO
ALTER TABLE [dbo].[BillingMaster] DROP CONSTRAINT [FK__BillingMa__Prima__04D07943]
GO
ALTER TABLE [dbo].[BillingMaster] DROP CONSTRAINT [FK__BillingMa__Prima__03DC550A]
GO
ALTER TABLE [dbo].[BillingMaster] DROP CONSTRAINT [FK__BillingMa__Prima__02E830D1]
GO
ALTER TABLE [dbo].[BillingMaster] DROP CONSTRAINT [FK__BillingMa__Prima__01F40C98]
GO
ALTER TABLE [dbo].[BillingMaster] DROP CONSTRAINT [FK__BillingMa__Prima__00FFE85F]
GO
ALTER TABLE [dbo].[BillingMaster] DROP CONSTRAINT [FK__BillingMa__Prima__000BC426]
GO
ALTER TABLE [dbo].[BillingMaster] DROP CONSTRAINT [FK__BillingMa__Payer__7E237BB4]
GO
ALTER TABLE [dbo].[BillingMaster] DROP CONSTRAINT [FK__BillingMa__Payer__7D2F577B]
GO
ALTER TABLE [dbo].[BillingMaster] DROP CONSTRAINT [FK__BillingMa__Payer__7C3B3342]
GO
ALTER TABLE [dbo].[BillingMaster] DROP CONSTRAINT [FK__BillingMa__Payer__7B470F09]
GO
ALTER TABLE [dbo].[BillingMaster] DROP CONSTRAINT [FK__BillingMa__Payer__7A52EAD0]
GO
ALTER TABLE [dbo].[BillingMaster] DROP CONSTRAINT [FK__BillingMa__Payer__795EC697]
GO
ALTER TABLE [dbo].[BillingMaster] DROP CONSTRAINT [FK__BillingMa__Payer__786AA25E]
GO
ALTER TABLE [dbo].[BillingMaster] DROP CONSTRAINT [FK__BillingMa__Payer__77767E25]
GO
ALTER TABLE [dbo].[BillingMaster] DROP CONSTRAINT [FK__BillingMa__Payer__768259EC]
GO
ALTER TABLE [dbo].[BillingMaster] DROP CONSTRAINT [FK__BillingMa__Payer__758E35B3]
GO
ALTER TABLE [dbo].[BillingMaster] DROP CONSTRAINT [FK__BillingMa__Billi__749A117A]
GO
ALTER TABLE [dbo].[BillingMaster] DROP CONSTRAINT [FK__BillingMa__Billi__73A5ED41]
GO
ALTER TABLE [dbo].[BillingMaster] DROP CONSTRAINT [FK__BillingMa__Billi__72B1C908]
GO
ALTER TABLE [dbo].[BillingMaster] DROP CONSTRAINT [FK__BillingMa__Billi__71BDA4CF]
GO
ALTER TABLE [dbo].[BillingMaster] DROP CONSTRAINT [FK__BillingMa__Billi__70C98096]
GO
ALTER TABLE [dbo].[BillingMaster] DROP CONSTRAINT [FK__BillingMa__Billi__6FD55C5D]
GO
ALTER TABLE [dbo].[BillingMaster] DROP CONSTRAINT [FK__BillingMa__Billi__6EE13824]
GO
ALTER TABLE [dbo].[BillingMaster] DROP CONSTRAINT [FK__BillingMa__Billi__6DED13EB]
GO
ALTER TABLE [dbo].[BillingMaster] DROP CONSTRAINT [FK__BillingMa__Billi__6CF8EFB2]
GO
ALTER TABLE [dbo].[BillingMaster] DROP CONSTRAINT [FK__BillingMa__Billi__6C04CB79]
GO
ALTER TABLE [dbo].[VisitAgaistAccessionStaging] DROP CONSTRAINT [DF__VisitAgai__Impor__1CBC4616]
GO
ALTER TABLE [dbo].[VAAMaster] DROP CONSTRAINT [DF__VAAMaster__Creat__37661AB1]
GO
ALTER TABLE [dbo].[Users] DROP CONSTRAINT [DF__Users__CreatedOn__652CE561]
GO
ALTER TABLE [dbo].[Users] DROP CONSTRAINT [DF__Users__IsActive__6438C128]
GO
ALTER TABLE [dbo].[UserRole] DROP CONSTRAINT [DF__UserRole__Create__69F19A7E]
GO
ALTER TABLE [dbo].[UserRole] DROP CONSTRAINT [DF__UserRole__IsActi__68FD7645]
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
ALTER TABLE [dbo].[TransactionMaster] DROP CONSTRAINT [DF__Transacti__Creat__2AF6222B]
GO
ALTER TABLE [dbo].[TransactionDetailStaging] DROP CONSTRAINT [DF__Transacti__Impor__7C9A5A9E]
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
ALTER TABLE [dbo].[PanelGroup] DROP CONSTRAINT [DF__PanelGrou__Creat__6932806F]
GO
ALTER TABLE [dbo].[PanelGroup] DROP CONSTRAINT [DF__PanelGrou__IsAct__683E5C36]
GO
ALTER TABLE [dbo].[OperationsGroupMaster] DROP CONSTRAINT [DF__Operation__Creat__787EE5A0]
GO
ALTER TABLE [dbo].[OperationsGroupMaster] DROP CONSTRAINT [DF__Operation__IsAct__2DE6D218]
GO
ALTER TABLE [dbo].[LISStaging] DROP CONSTRAINT [DF__LISStagin__Impor__10174366]
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
ALTER TABLE [dbo].[DenialTrackingStaging] DROP CONSTRAINT [DF__DenialTra__Impor__7E82A310]
GO
ALTER TABLE [dbo].[DenialTrackingMaster] DROP CONSTRAINT [DF__DenialTra__Updat__290DD9B9]
GO
ALTER TABLE [dbo].[DenialTrackingMaster] DROP CONSTRAINT [DF__DenialTra__Creat__2819B580]
GO
ALTER TABLE [dbo].[CustomCollectionStaging] DROP CONSTRAINT [DF__CustomCol__Impot__125F7E8B]
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
ALTER TABLE [dbo].[ClaimsLevelStatus] DROP CONSTRAINT [DF__ClaimsLev__Creat__2863CE43]
GO
ALTER TABLE [dbo].[ClaimsLevelStatus] DROP CONSTRAINT [DF__ClaimsLev__Total__276FAA0A]
GO
ALTER TABLE [dbo].[ClaimsLevelStatus] DROP CONSTRAINT [DF__ClaimsLev__Patie__267B85D1]
GO
ALTER TABLE [dbo].[ClaimsLevelStatus] DROP CONSTRAINT [DF__ClaimsLev__Insur__25876198]
GO
ALTER TABLE [dbo].[ClaimsLevelStatus] DROP CONSTRAINT [DF__ClaimsLev__Patie__24933D5F]
GO
ALTER TABLE [dbo].[ClaimsLevelStatus] DROP CONSTRAINT [DF__ClaimsLev__Patie__239F1926]
GO
ALTER TABLE [dbo].[ClaimsLevelStatus] DROP CONSTRAINT [DF__ClaimsLev__Insur__22AAF4ED]
GO
ALTER TABLE [dbo].[ClaimsLevelStatus] DROP CONSTRAINT [DF__ClaimsLev__Insur__21B6D0B4]
GO
ALTER TABLE [dbo].[ClaimsLevelStatus] DROP CONSTRAINT [DF__ClaimsLev__Allow__20C2AC7B]
GO
ALTER TABLE [dbo].[ClaimsLevelStatus] DROP CONSTRAINT [DF__ClaimsLev__Bille__1FCE8842]
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
ALTER TABLE [dbo].[BillingMaster] DROP CONSTRAINT [DF__BillingMa__Updat__6B10A740]
GO
ALTER TABLE [dbo].[BillingMaster] DROP CONSTRAINT [DF__BillingMa__Creat__6A1C8307]
GO
ALTER TABLE [dbo].[AccPaymentReportStaging] DROP CONSTRAINT [DF__AccPaymen__Impor__006AEB82]
GO
/****** Object:  Table [dbo].[VisitAgaistAccessionStaging]******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[VisitAgaistAccessionStaging]') AND type in (N'U'))
DROP TABLE [dbo].[VisitAgaistAccessionStaging]
GO
/****** Object:  Table [dbo].[VAAMaster]******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[VAAMaster]') AND type in (N'U'))
DROP TABLE [dbo].[VAAMaster]
GO
/****** Object:  Table [dbo].[Users]******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Users]') AND type in (N'U'))
DROP TABLE [dbo].[Users]
GO
/****** Object:  Table [dbo].[UserRole]******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[UserRole]') AND type in (N'U'))
DROP TABLE [dbo].[UserRole]
GO
/****** Object:  Table [dbo].[TransactionSummary]******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[TransactionSummary]') AND type in (N'U'))
DROP TABLE [dbo].[TransactionSummary]
GO
/****** Object:  Table [dbo].[TransactionDetailStaging]******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[TransactionDetailStaging]') AND type in (N'U'))
DROP TABLE [dbo].[TransactionDetailStaging]
GO
/****** Object:  Table [dbo].[TestTypeMaster]******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[TestTypeMaster]') AND type in (N'U'))
DROP TABLE [dbo].[TestTypeMaster]
GO
/****** Object:  Table [dbo].[States]******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[States]') AND type in (N'U'))
DROP TABLE [dbo].[States]
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
/****** Object:  Table [dbo].[RequisitionTypes]******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[RequisitionTypes]') AND type in (N'U'))
DROP TABLE [dbo].[RequisitionTypes]
GO
/****** Object:  Table [dbo].[ReportDownloadSts]******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ReportDownloadSts]') AND type in (N'U'))
DROP TABLE [dbo].[ReportDownloadSts]
GO
/****** Object:  Table [dbo].[ReferringProviderMaster]******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ReferringProviderMaster]') AND type in (N'U'))
DROP TABLE [dbo].[ReferringProviderMaster]
GO
/****** Object:  Table [dbo].[Races]******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Races]') AND type in (N'U'))
DROP TABLE [dbo].[Races]
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
/****** Object:  Table [dbo].[Panels]******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Panels]') AND type in (N'U'))
DROP TABLE [dbo].[Panels]
GO
/****** Object:  Table [dbo].[PanelGroup]******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[PanelGroup]') AND type in (N'U'))
DROP TABLE [dbo].[PanelGroup]
GO
/****** Object:  Table [dbo].[OperationsGroupMaster]******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[OperationsGroupMaster]') AND type in (N'U'))
DROP TABLE [dbo].[OperationsGroupMaster]
GO
/****** Object:  Table [dbo].[Medications]******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Medications]') AND type in (N'U'))
DROP TABLE [dbo].[Medications]
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
/****** Object:  Table [dbo].[InsuranceRelationships]******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[InsuranceRelationships]') AND type in (N'U'))
DROP TABLE [dbo].[InsuranceRelationships]
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
/****** Object:  Table [dbo].[Genders]******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Genders]') AND type in (N'U'))
DROP TABLE [dbo].[Genders]
GO
/****** Object:  Table [dbo].[FileStatuses]******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[FileStatuses]') AND type in (N'U'))
DROP TABLE [dbo].[FileStatuses]
GO
/****** Object:  Table [dbo].[DownloadReportTypes]******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[DownloadReportTypes]') AND type in (N'U'))
DROP TABLE [dbo].[DownloadReportTypes]
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
/****** Object:  Table [dbo].[Cities]******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Cities]') AND type in (N'U'))
DROP TABLE [dbo].[Cities]
GO
/****** Object:  Table [dbo].[BillingProviderMaster]******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[BillingProviderMaster]') AND type in (N'U'))
DROP TABLE [dbo].[BillingProviderMaster]
GO
/****** Object:  Table [dbo].[AccPaymentReportStaging]******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[AccPaymentReportStaging]') AND type in (N'U'))
DROP TABLE [dbo].[AccPaymentReportStaging]
GO
/****** Object:  UserDefinedFunction [dbo].[tvf_GetDenialCodesByVisit]******/
DROP FUNCTION [dbo].[tvf_GetDenialCodesByVisit]
GO
/****** Object:  Table [dbo].[DenialTrackingMaster]******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[DenialTrackingMaster]') AND type in (N'U'))
DROP TABLE [dbo].[DenialTrackingMaster]
GO
/****** Object:  UserDefinedFunction [dbo].[GetPaymentDetails]******/
DROP FUNCTION [dbo].[GetPaymentDetails]
GO
/****** Object:  Table [dbo].[TransactionMaster]******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[TransactionMaster]') AND type in (N'U'))
DROP TABLE [dbo].[TransactionMaster]
GO
/****** Object:  UserDefinedFunction [dbo].[fn_GetClaimStatusByVisitAndCPT]******/
DROP FUNCTION [dbo].[fn_GetClaimStatusByVisitAndCPT]
GO
/****** Object:  Table [dbo].[BillingMaster]******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[BillingMaster]') AND type in (N'U'))
DROP TABLE [dbo].[BillingMaster]
GO
/****** Object:  Table [dbo].[ClaimDenialCodes]******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ClaimDenialCodes]') AND type in (N'U'))
DROP TABLE [dbo].[ClaimDenialCodes]
GO
/****** Object:  UserDefinedFunction [dbo].[GetUniqueICD10Codes]******/
DROP FUNCTION [dbo].[GetUniqueICD10Codes]
GO
/****** Object:  UserDefinedFunction [dbo].[GetDenailCodeByVisitNumber]******/
DROP FUNCTION [dbo].[GetDenailCodeByVisitNumber]
GO
/****** Object:  UserDefinedFunction [dbo].[GetDenailCodeByVisitCPT]******/
DROP FUNCTION [dbo].[GetDenailCodeByVisitCPT]
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
 
    SELECT @Result = STRING_AGG(CPTCode, ',') WITHIN GROUP (ORDER BY CPTCode)
    FROM (
        SELECT DISTINCT CPTCode
        FROM BillingMaster WITH (NOLOCK)
        WHERE VisitNumber = @visitno 
          AND CPTCode IS NOT NULL 
          AND CPTCode != ''
    ) AS DistinctCodes;
 
    RETURN ISNULL(@Result, '');
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

    WITH CTE_DenailMaster AS
    (
        SELECT
            VisitNumber,
            CPTCodes,
            -- Use normalized date if you created it; otherwise keep PaymentDate
            PaymentDate = ISNULL(PaymentDate, TRY_CONVERT(date, PaymentDate)),
            STRING_AGG(PaymentReasonCode, ';') AS PaymentReasonCode
        FROM dbo.DenialTrackingMaster
        WHERE VisitNumber = @visitno and CPTCodes = @cptCode
          AND PaymentReasonCode IS NOT NULL
        GROUP BY VisitNumber, CPTCodes,
                 ISNULL(PaymentDate, TRY_CONVERT(date, PaymentDate))
    ),
    CTE_Denial AS
    (
        SELECT VisitNumber, CPTCodes, PaymentReasonCode, PaymentDate,
               ROW_NUMBER() OVER (PARTITION BY VisitNumber, CPTCodes
                                  ORDER BY PaymentDate DESC) AS RowNumByLatestPayment
        FROM CTE_DenailMaster
    ),
    Tokenized AS
    (
        SELECT DISTINCT TRIM(s.value) AS Code, PaymentDate
        FROM CTE_Denial d
        CROSS APPLY STRING_SPLIT(d.PaymentReasonCode, ';') AS s
        WHERE d.RowNumByLatestPayment = 1
          AND TRIM(s.value) <> ''
    ),
    Filtered AS
    (
        SELECT Code, MAX(PaymentDate) AS PaymentDate
        FROM Tokenized
        WHERE Code NOT IN ('CO45','CO253','CO1','CO2','CO3','PR1','PR2','PR3','PR45','PR253','PI45','PI1','PI2','PI3',
							'PI253','CO 45','CO 253','CO 1','CO 2','CO 3','PR 1','PR 2','PR 3','PR 45','PR 253','PI 253','PI 45','PI 1','PI 2','PI 3')
        GROUP BY Code
    )
    SELECT @Result = STRING_AGG(Code, ';') WITHIN GROUP (ORDER BY Code)
    FROM Filtered;

    RETURN @Result;
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

    WITH CTE_DenailMaster AS
    (
        SELECT
            VisitNumber,
            CPTCodes,
            -- Use normalized date if you created it; otherwise keep PaymentDate
            PaymentDate = ISNULL(PaymentDate, TRY_CONVERT(date, PaymentDate)),
            STRING_AGG(PaymentReasonCode, ';') AS PaymentReasonCode
        FROM dbo.DenialTrackingMaster
        WHERE VisitNumber = @visitno
          AND PaymentReasonCode IS NOT NULL
        GROUP BY VisitNumber, CPTCodes,
                 ISNULL(PaymentDate, TRY_CONVERT(date, PaymentDate))
    ),
    CTE_Denial AS
    (
        SELECT VisitNumber, CPTCodes, PaymentReasonCode, PaymentDate,
               ROW_NUMBER() OVER (PARTITION BY VisitNumber, CPTCodes
                                  ORDER BY PaymentDate DESC) AS RowNumByLatestPayment
        FROM CTE_DenailMaster
    ),
    Tokenized AS
    (
        SELECT DISTINCT TRIM(s.value) AS Code, PaymentDate
        FROM CTE_Denial d
        CROSS APPLY STRING_SPLIT(d.PaymentReasonCode, ';') AS s
        WHERE d.RowNumByLatestPayment = 1
          AND TRIM(s.value) <> ''
    ),
    Filtered AS
    (
        SELECT Code, MAX(PaymentDate) AS PaymentDate
        FROM Tokenized
            WHERE Code NOT IN ('CO45','CO253','CO1','CO2','CO3','PR1','PR2','PR3','PR45','PR253','PI45','PI1','PI2','PI3',
							'PI253','CO 45','CO 253','CO 1','CO 2','CO 3','PR 1','PR 2','PR 3','PR 45','PR 253','PI 253','PI 45','PI 1','PI 2','PI 3')
        GROUP BY Code
    )
    SELECT @Result = STRING_AGG(Code, ';') WITHIN GROUP (ORDER BY Code)
    FROM Filtered;

    RETURN @Result;
END
GO
/****** Object:  UserDefinedFunction [dbo].[GetUniqueICD10Codes]******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
 
CREATE FUNCTION [dbo].[GetUniqueICD10Codes] 

(

    @VisitNumber VARCHAR(50)

)

RETURNS VARCHAR(1000)

AS

BEGIN

    DECLARE @Result VARCHAR(1000) = '';
 
    SELECT @Result = 

           CASE 

               WHEN @Result = '' THEN 

                   CASE 

                       WHEN CHARINDEX(' - ', ICD10Code) > 0 

                       THEN LEFT(ICD10Code, CHARINDEX(' - ', ICD10Code) - 1)

                       ELSE ICD10Code 

                   END

               ELSE @Result + ', ' + 

                   CASE 

                       WHEN CHARINDEX(' - ', ICD10Code) > 0 

                       THEN LEFT(ICD10Code, CHARINDEX(' - ', ICD10Code) - 1)

                       ELSE ICD10Code 

                   END

           END

    FROM (

        SELECT DISTINCT ICD10Code

        FROM BillingMaster 

        WHERE VisitNumber = @VisitNumber

          AND ICD10Code IS NOT NULL

          AND LTRIM(RTRIM(ICD10Code)) != ''

    ) AS DistinctICDCodes

    ORDER BY ICD10Code;
 
    RETURN @Result;

END

 
GO
/****** Object:  Table [dbo].[ClaimDenialCodes]******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ClaimDenialCodes](
	[VisitNumber] [int] NOT NULL,
	[CPTCode] [nvarchar](20) NOT NULL,
	[DenialCode] [nvarchar](150) NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[BillingMaster]******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[BillingMaster](
	[BillingMasterID] [bigint] IDENTITY(1,1) NOT NULL,
	[AccessionNo] [varchar](50) NULL,
	[VisitNumber] [nvarchar](250) NULL,
	[PrimaryPayerID] [int] NULL,
	[SecondaryPayerId] [int] NULL,
	[PayerTypeId] [int] NULL,
	[BillingProviderID] [int] NOT NULL,
	[PanelName] [nvarchar](50) NULL,
	[PanelCarrier] [nvarchar](250) NULL,
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
	[BillingSubStatus] [varchar](50) NULL,
	[PatientName] [nvarchar](255) NULL,
	[ReferringProviderId] [int] NULL,
	[FacilityId] [int] NULL,
	[PatientDOB] [date] NULL,
	[ResponsibleParty] [nvarchar](250) NULL,
	[ImportFileId] [int] NOT NULL,
	[AccessionIdentity] [varchar](250) NULL,
	[CPTCodeDescription] [nvarchar](500) NULL,
	[PayerType] [nvarchar](500) NULL,
	[BillingProvider] [nvarchar](500) NULL,
	[PerformingLab] [nvarchar](500) NULL,
	[ReferringProvider] [nvarchar](500) NULL,
PRIMARY KEY CLUSTERED 
(
	[BillingMasterID] ASC
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

WHEN BilledAmount > 0 AND AllowedAmount = BilledAmount AND InsurancePayment = 0 AND InsuranceAdjustment = BilledAmount AND PatientPaidAmount = 0 AND PatientAdjustment = 0 AND InsuranceBalance = 0 AND PatientBalance = 0 AND a.TotalBalance = 0 AND (DenialCode IS NULL OR DenialCode IS NOT NULL) THEN 'Adjusted'
WHEN BilledAmount > 0 AND AllowedAmount > 0 AND InsurancePayment = AllowedAmount AND InsuranceAdjustment > 0 AND PatientPaidAmount = 0 AND PatientAdjustment = 0 AND InsuranceBalance = 0 AND PatientBalance = 0 AND a.TotalBalance = 0 AND (DenialCode IS NULL OR DenialCode IS NOT NULL) THEN 'Paid'
WHEN BilledAmount > 0 AND AllowedAmount = BilledAmount AND InsurancePayment = 0 AND InsuranceAdjustment = 0 AND PatientPaidAmount = 0 AND PatientAdjustment = 0 AND InsuranceBalance = BilledAmount AND PatientBalance = 0 AND a.TotalBalance = BilledAmount AND DenialCode IS NOT NULL THEN 'Denied'
WHEN BilledAmount > 0 AND AllowedAmount = BilledAmount AND InsurancePayment = 0 AND InsuranceAdjustment = 0 AND PatientPaidAmount = 0 AND PatientAdjustment = 0 AND InsuranceBalance = BilledAmount AND PatientBalance = 0 AND a.TotalBalance = BilledAmount AND DenialCode IS NULL THEN 'No Response'
WHEN BilledAmount > 0 AND AllowedAmount > 0 AND InsurancePayment = 0 AND InsuranceAdjustment > 0 AND PatientPaidAmount = 0 AND PatientAdjustment = 0 AND InsuranceBalance = AllowedAmount AND PatientBalance = 0 AND a.TotalBalance = InsuranceBalance AND (DenialCode IS NULL OR DenialCode IS NOT NULL) THEN 'Paid'
WHEN BilledAmount > 0 AND AllowedAmount > 0 AND InsurancePayment = 0 AND InsuranceAdjustment = BilledAmount AND PatientPaidAmount = 0 AND PatientAdjustment = 0 AND InsuranceBalance = 0 AND PatientBalance = 0 AND a.TotalBalance = 0 AND (DenialCode IS NULL OR DenialCode IS NOT NULL) THEN 'Adjusted'
WHEN BilledAmount > 0 AND AllowedAmount > 0 AND InsurancePayment = 0 AND InsuranceAdjustment = 0 AND PatientPaidAmount = 0 AND PatientAdjustment = 0 AND InsuranceBalance = BilledAmount AND PatientBalance = 0 AND a.TotalBalance = BilledAmount AND DenialCode IS NULL THEN 'No Response'
WHEN BilledAmount > 0 AND AllowedAmount > 0 AND InsurancePayment = AllowedAmount AND InsuranceAdjustment = 0 AND PatientPaidAmount = 0 AND PatientAdjustment = 0 AND InsuranceBalance = 0 AND PatientBalance > 0 AND a.TotalBalance = PatientBalance AND (DenialCode IS NULL OR DenialCode IS NOT NULL) THEN 'Paid'
WHEN BilledAmount > 0 AND AllowedAmount > 0 AND InsurancePayment = AllowedAmount AND InsuranceAdjustment > 0 AND PatientPaidAmount = 0 AND PatientAdjustment = 0 AND InsuranceBalance = 0 AND PatientBalance = 0 AND a.TotalBalance = 0 AND (DenialCode IS NULL OR DenialCode IS NOT NULL) THEN 'Paid'
WHEN BilledAmount > 0 AND AllowedAmount > 0 AND InsurancePayment > 0 AND InsuranceAdjustment > 0 AND PatientPaidAmount = 0 AND PatientAdjustment = 0 AND InsuranceBalance = 0 AND PatientBalance = AllowedAmount - InsurancePayment AND a.TotalBalance = PatientBalance AND (DenialCode IS NULL OR DenialCode IS NOT NULL) THEN 'Paid'
WHEN BilledAmount > 0 AND AllowedAmount = BilledAmount AND InsurancePayment > 0 AND InsuranceAdjustment > 0 AND PatientPaidAmount = 0 AND PatientAdjustment = 0 AND InsuranceBalance = 0 AND PatientBalance = 0 AND a.TotalBalance = 0 AND (DenialCode IS NULL OR DenialCode IS NOT NULL) THEN 'Paid'
WHEN BilledAmount > 0 AND AllowedAmount > 0 AND InsurancePayment = AllowedAmount AND InsuranceAdjustment = 0 AND PatientPaidAmount = 0 AND PatientAdjustment = 0 AND InsuranceBalance = BilledAmount AND PatientBalance = 0 AND a.TotalBalance = BilledAmount AND (DenialCode IS NULL OR DenialCode IS NOT NULL) THEN 'Paid'
WHEN BilledAmount > 0 AND AllowedAmount > 0 AND InsurancePayment = AllowedAmount AND InsuranceAdjustment = 0 AND PatientPaidAmount = 0 AND PatientAdjustment = 0 AND InsuranceBalance = BilledAmount AND PatientBalance = 0 AND a.TotalBalance = BilledAmount AND (DenialCode IS NULL OR DenialCode IS NOT NULL) THEN 'Paid'
WHEN BilledAmount > 0 AND AllowedAmount = 0 AND InsurancePayment = 0 AND InsuranceAdjustment = BilledAmount AND PatientPaidAmount = 0 AND PatientAdjustment = 0 AND InsuranceBalance = 0 AND PatientBalance = 0 AND a.TotalBalance = 0 AND (DenialCode IS NULL OR DenialCode IS NOT NULL) THEN 'Adjusted'
WHEN BilledAmount > 0 AND AllowedAmount > 0 AND InsurancePayment > 0 AND InsuranceAdjustment > 0 AND PatientPaidAmount = 0 AND PatientAdjustment = 0 AND InsuranceBalance = 0 AND PatientBalance = 0 AND a.TotalBalance = 0 AND (DenialCode IS NULL OR DenialCode IS NOT NULL) THEN 'Paid'
WHEN BilledAmount > 0 AND AllowedAmount = 0 AND InsurancePayment = 0 AND InsuranceAdjustment = 0 AND PatientPaidAmount = 0 AND PatientAdjustment = 0 AND InsuranceBalance = BilledAmount AND PatientBalance = 0 AND a.TotalBalance = BilledAmount AND DenialCode IS NULL THEN 'No Response'
WHEN BilledAmount > 0 AND AllowedAmount > 0 AND InsurancePayment = AllowedAmount AND InsuranceAdjustment = 0 AND PatientPaidAmount = 0 AND PatientAdjustment = 0 AND InsuranceBalance = BilledAmount AND PatientBalance = 0 AND a.TotalBalance = BilledAmount AND (DenialCode IS NULL OR DenialCode IS NOT NULL) THEN 'Paid'
WHEN BilledAmount > 0 AND AllowedAmount > 0 AND InsurancePayment = AllowedAmount AND InsuranceAdjustment > 0 AND PatientPaidAmount = 0 AND PatientAdjustment = 0 AND InsuranceBalance = BilledAmount AND PatientBalance = 0 AND a.TotalBalance = BilledAmount AND (DenialCode IS NULL OR DenialCode IS NOT NULL) THEN 'Paid'
WHEN BilledAmount > 0 AND AllowedAmount > 0 AND InsurancePayment > 0 AND InsuranceAdjustment > 0 AND PatientPaidAmount = 0 AND PatientAdjustment = 0 AND InsuranceBalance = BilledAmount AND PatientBalance = 0 AND a.TotalBalance = BilledAmount AND (DenialCode IS NULL OR DenialCode IS NOT NULL) THEN 'Paid'
WHEN BilledAmount > 0 AND AllowedAmount = BilledAmount AND InsurancePayment = AllowedAmount AND InsuranceAdjustment = 0 AND PatientPaidAmount = 0 AND PatientAdjustment = 0 AND InsuranceBalance = 0 AND PatientBalance = 0 AND a.TotalBalance = 0 AND (DenialCode IS NULL OR DenialCode IS NOT NULL) THEN 'Paid'
WHEN BilledAmount > 0 AND AllowedAmount > 0 AND InsurancePayment = 0 AND InsuranceAdjustment = 0 AND PatientPaidAmount = 0 AND PatientAdjustment = 0 AND InsuranceBalance = BilledAmount AND PatientBalance = 0 AND a.TotalBalance = BilledAmount AND DenialCode IS NOT NULL THEN 'Denied'
WHEN BilledAmount > 0 AND AllowedAmount > 0 AND InsurancePayment > 0 AND InsuranceAdjustment > 0 AND PatientPaidAmount = 0 AND PatientAdjustment = 0 AND InsuranceBalance = BilledAmount AND PatientBalance = 0 AND a.TotalBalance = BilledAmount AND (DenialCode IS NULL OR DenialCode IS NOT NULL) THEN 'Paid'
WHEN BilledAmount > 0 AND AllowedAmount > 0 AND InsurancePayment = AllowedAmount AND InsuranceAdjustment > 0 AND PatientPaidAmount = 0 AND PatientAdjustment = 0 AND InsuranceBalance = AllowedAmount AND PatientBalance = 0 AND a.TotalBalance = InsuranceBalance AND (DenialCode IS NULL OR DenialCode IS NOT NULL) THEN 'Paid'
WHEN BilledAmount > 0 AND AllowedAmount > 0 AND InsurancePayment = AllowedAmount AND InsuranceAdjustment > 0 AND PatientPaidAmount = 0 AND PatientAdjustment = 0 AND InsuranceBalance = BilledAmount AND PatientBalance = 0 AND a.TotalBalance = BilledAmount AND (DenialCode IS NULL OR DenialCode IS NOT NULL) THEN 'Paid'
WHEN BilledAmount > 0 AND AllowedAmount = BilledAmount AND InsurancePayment > 0 AND InsuranceAdjustment > 0 AND PatientPaidAmount = 0 AND PatientAdjustment = 0 AND InsuranceBalance = 0 AND PatientBalance = 0 AND a.TotalBalance = 0 AND (DenialCode IS NULL OR DenialCode IS NOT NULL) THEN 'Paid'
WHEN BilledAmount > 0 AND AllowedAmount = 0 AND InsurancePayment = 0 AND InsuranceAdjustment = 0 AND PatientPaidAmount = 0 AND PatientAdjustment = 0 AND InsuranceBalance = BilledAmount AND PatientBalance = 0 AND a.TotalBalance = BilledAmount AND DenialCode IS NOT NULL THEN 'Denied'
WHEN BilledAmount > 0 AND AllowedAmount > 0 AND InsurancePayment = 0 AND InsuranceAdjustment > 0 AND PatientPaidAmount = 0 AND PatientAdjustment = 0 AND InsuranceBalance = BilledAmount AND PatientBalance = 0 AND a.TotalBalance = BilledAmount AND (DenialCode IS NULL OR DenialCode IS NOT NULL) THEN 'Paid'
WHEN BilledAmount > 0 AND AllowedAmount = BilledAmount AND InsurancePayment = 0 AND InsuranceAdjustment = 0 AND PatientPaidAmount = 0 AND PatientAdjustment = 0 AND InsuranceBalance = 0 AND PatientBalance = AllowedAmount AND a.TotalBalance = AllowedAmount AND (DenialCode IS NULL OR DenialCode IS NOT NULL) THEN 'Patient Responsibility'
WHEN BilledAmount > 0 AND AllowedAmount = 0 AND InsurancePayment = 0 AND InsuranceAdjustment = 0 AND PatientPaidAmount = 0 AND PatientAdjustment = 0 AND InsuranceBalance = 0 AND PatientBalance = BilledAmount AND a.TotalBalance = BilledAmount AND (DenialCode IS NULL OR DenialCode IS NOT NULL) THEN 'Patient Responsibility'
WHEN BilledAmount > 0 AND AllowedAmount = BilledAmount AND InsurancePayment > 0 AND InsuranceAdjustment = 0 AND PatientPaidAmount = 0 AND PatientAdjustment = 0 AND InsuranceBalance = BilledAmount AND PatientBalance = 0 AND a.TotalBalance = BilledAmount AND (DenialCode IS NULL OR DenialCode IS NOT NULL) THEN 'Paid'
WHEN BilledAmount > 0 AND AllowedAmount > 0 AND InsurancePayment = AllowedAmount AND InsuranceAdjustment > 0 AND PatientPaidAmount = 0 AND PatientAdjustment > 0 AND InsuranceBalance = 0 AND PatientBalance = 0 AND a.TotalBalance = 0 AND (DenialCode IS NULL OR DenialCode IS NOT NULL) THEN 'Paid'
WHEN BilledAmount > 0 AND AllowedAmount > 0 AND InsurancePayment = 0 AND InsuranceAdjustment > 0 AND PatientPaidAmount = 0 AND PatientAdjustment = 0 AND InsuranceBalance = 0 AND PatientBalance = AllowedAmount AND a.TotalBalance = AllowedAmount AND (DenialCode IS NULL OR DenialCode IS NOT NULL) THEN 'Patient Responsibility'
WHEN BilledAmount > 0 AND AllowedAmount = BilledAmount AND InsurancePayment = 0 AND InsuranceAdjustment > 0 AND PatientPaidAmount = 0 AND PatientAdjustment = 0 AND InsuranceBalance = BilledAmount AND PatientBalance = 0 AND a.TotalBalance = BilledAmount AND (DenialCode IS NULL OR DenialCode IS NOT NULL) THEN 'Adjusted'
WHEN BilledAmount > 0 AND AllowedAmount = BilledAmount AND InsurancePayment = 0 AND InsuranceAdjustment = BilledAmount AND PatientPaidAmount = 0 AND PatientAdjustment = 0 AND InsuranceBalance = 0 AND PatientBalance = 0 AND a.TotalBalance = 0 AND (DenialCode IS NULL OR DenialCode IS NOT NULL) THEN 'Adjusted'
WHEN BilledAmount > 0 AND AllowedAmount = BilledAmount AND InsurancePayment = 0 AND InsuranceAdjustment > 0 AND PatientPaidAmount = 0 AND PatientAdjustment = 0 AND InsuranceBalance = BilledAmount AND PatientBalance = 0 AND a.TotalBalance = BilledAmount AND (DenialCode IS NULL OR DenialCode IS NOT NULL) THEN 'Paid'
WHEN BilledAmount > 0 AND AllowedAmount > 0 AND InsurancePayment = 0 AND InsuranceAdjustment > 0 AND PatientPaidAmount = 0 AND PatientAdjustment = 0 AND InsuranceBalance = AllowedAmount AND PatientBalance = 0 AND a.TotalBalance = InsuranceBalance AND (DenialCode IS NULL OR DenialCode IS NOT NULL) THEN 'Paid'
WHEN BilledAmount > 0 AND AllowedAmount > 0 AND InsurancePayment > 0 AND InsuranceAdjustment = 0 AND PatientPaidAmount = 0 AND PatientAdjustment = 0 AND InsuranceBalance = BilledAmount AND PatientBalance = 0 AND a.TotalBalance = BilledAmount AND (DenialCode IS NULL OR DenialCode IS NOT NULL) THEN 'Paid'
WHEN BilledAmount > 0 AND AllowedAmount > 0 AND InsurancePayment > 0 AND InsuranceAdjustment > 0 AND PatientPaidAmount = 0 AND PatientAdjustment = 0 AND InsuranceBalance = 0 AND PatientBalance = AllowedAmount - InsurancePayment AND a.TotalBalance = PatientBalance AND (DenialCode IS NULL OR DenialCode IS NOT NULL) THEN 'Paid'
WHEN BilledAmount > 0 AND AllowedAmount > 0 AND AllowedAmount <> BilledAmount AND InsurancePayment = 0 AND InsuranceAdjustment > 0 AND PatientPaidAmount = 0 AND PatientAdjustment = 0 AND InsuranceBalance = AllowedAmount AND PatientBalance = 0 AND a.TotalBalance = InsuranceBalance AND (DenialCode IS NULL OR DenialCode IS NOT NULL) THEN 'Paid'
WHEN BilledAmount > 0 AND AllowedAmount = BilledAmount AND InsurancePayment > 0 AND InsuranceAdjustment = 0 AND PatientPaidAmount = 0 AND PatientAdjustment = 0 AND InsuranceBalance = 0 AND PatientBalance = AllowedAmount - InsurancePayment AND a.TotalBalance = PatientBalance AND (DenialCode IS NULL OR DenialCode IS NOT NULL) THEN 'Paid'
WHEN BilledAmount > 0 AND AllowedAmount > 0 AND InsurancePayment > 0 AND InsuranceAdjustment > 0 AND PatientPaidAmount = 0 AND PatientAdjustment = 0 AND InsuranceBalance > 0 AND PatientBalance = 0 AND a.TotalBalance = InsuranceBalance AND (DenialCode IS NULL OR DenialCode IS NOT NULL) THEN 'Paid'
WHEN BilledAmount > 0 AND AllowedAmount = BilledAmount AND InsurancePayment = 0 AND InsuranceAdjustment > 0 AND InsuranceAdjustment < AllowedAmount AND PatientPaidAmount = 0 AND PatientAdjustment = 0 AND InsuranceBalance = (BilledAmount - InsuranceAdjustment) AND PatientBalance = 0 AND a.TotalBalance = InsuranceBalance AND (DenialCode IS NULL OR DenialCode IS NOT NULL) THEN 'Paid'
WHEN BilledAmount > 0 AND AllowedAmount = BilledAmount AND InsurancePayment > 0 AND InsurancePayment < AllowedAmount AND InsuranceAdjustment = 0 AND PatientPaidAmount = 0 AND PatientAdjustment = 0 AND InsuranceBalance = (BilledAmount - InsurancePayment) AND PatientBalance = 0 AND a.TotalBalance = InsuranceBalance AND (DenialCode IS NULL OR DenialCode IS NOT NULL) THEN 'Paid'
WHEN BilledAmount > 0 AND AllowedAmount > 0 AND AllowedAmount < BilledAmount AND InsurancePayment = AllowedAmount AND InsuranceAdjustment = 0 AND PatientPaidAmount = 0 AND PatientAdjustment = 0 AND InsuranceBalance = (BilledAmount - InsurancePayment) AND PatientBalance = 0 AND a.TotalBalance = InsuranceBalance AND (DenialCode IS NULL OR DenialCode IS NOT NULL) THEN 'Paid'
WHEN BilledAmount > 0 AND AllowedAmount > 0 AND AllowedAmount < BilledAmount AND InsurancePayment > AllowedAmount AND InsuranceAdjustment = 0 AND PatientPaidAmount = 0 AND PatientAdjustment = 0 AND InsuranceBalance = (BilledAmount - InsurancePayment) AND PatientBalance = 0 AND a.TotalBalance = InsuranceBalance AND (DenialCode IS NULL OR DenialCode IS NOT NULL) THEN 'Paid'
WHEN BilledAmount > 0 AND AllowedAmount = BilledAmount AND InsurancePayment = 0 AND InsuranceAdjustment > 0 AND InsuranceAdjustment < AllowedAmount AND PatientPaidAmount = 0 AND PatientAdjustment = 0 AND InsuranceBalance = (BilledAmount - InsuranceAdjustment) AND PatientBalance = 0 AND a.TotalBalance = InsuranceBalance AND (DenialCode IS NULL OR DenialCode IS NOT NULL) THEN 'Adjusted'
WHEN BilledAmount > 0 AND AllowedAmount = BilledAmount AND InsurancePayment = 0 AND InsuranceAdjustment = 0 AND InsuranceAdjustment = 0 AND PatientPaidAmount = 0 AND PatientAdjustment = BilledAmount AND InsuranceBalance = 0 AND PatientBalance = 0 AND a.TotalBalance = 0 AND (DenialCode IS NOT NULL) THEN 'Adjusted'
WHEN BilledAmount > 0 AND AllowedAmount > BilledAmount AND InsurancePayment > 0 AND InsuranceAdjustment = 0 AND InsuranceAdjustment > 0 AND PatientPaidAmount = 0 AND PatientAdjustment > 0 AND InsuranceBalance = 0 AND PatientBalance = 0 AND a.TotalBalance = 0 AND (DenialCode IS NULL) THEN 'Paid'
WHEN BilledAmount > 0 AND AllowedAmount > BilledAmount AND InsurancePayment = 0 AND InsuranceAdjustment = 0 AND InsuranceAdjustment > 0 AND PatientPaidAmount > 0 AND PatientAdjustment = 0 AND InsuranceBalance = 0 AND PatientBalance = 0 AND a.TotalBalance = 0 AND (DenialCode IS NULL OR DenialCode IS NOT NULL) THEN 'Patient Payment'
WHEN BilledAmount > 0 AND AllowedAmount > BilledAmount AND InsurancePayment = 0 AND InsuranceAdjustment = 0 AND InsuranceAdjustment > 0 AND PatientPaidAmount = 0 AND PatientAdjustment = 0 AND InsuranceBalance = 0 AND PatientBalance = 0 AND a.TotalBalance > 0 AND (DenialCode IS NULL) THEN 'Patient Responsibility'

ELSE 'No Response' END AS FinalStatus, 
CASE
WHEN BilledAmount > 0 AND AllowedAmount = BilledAmount AND InsurancePayment = 0 AND InsuranceAdjustment = BilledAmount AND  PatientPaidAmount = 0 AND  PatientAdjustment = 0 AND  InsuranceBalance = 0 AND PatientBalance = 0 AND  a.TotalBalance = 0 AND (DenialCode IS NULL OR DenialCode IS NOT NULL) THEN 'Fully Written Off'
WHEN BilledAmount > 0 AND AllowedAmount > 0 AND InsurancePayment = AllowedAmount AND InsuranceAdjustment > 0 AND  PatientPaidAmount = 0 AND  PatientAdjustment = 0 AND  InsuranceBalance = 0 AND PatientBalance = 0 AND  a.TotalBalance = 0 AND (DenialCode IS NULL OR DenialCode IS NOT NULL) THEN 'Insurance Payment'
WHEN BilledAmount > 0 AND AllowedAmount = BilledAmount AND InsurancePayment = 0 AND InsuranceAdjustment = 0 AND  PatientPaidAmount = 0 AND  PatientAdjustment = 0 AND  InsuranceBalance = BilledAmount AND PatientBalance = 0 AND  a.TotalBalance = BilledAmount AND DenialCode IS NOT NULL THEN 'Insurance Denial'
WHEN BilledAmount > 0 AND AllowedAmount = BilledAmount AND InsurancePayment = 0 AND InsuranceAdjustment = 0 AND  PatientPaidAmount = 0 AND  PatientAdjustment = 0 AND  InsuranceBalance = BilledAmount AND PatientBalance = 0 AND  a.TotalBalance = BilledAmount AND DenialCode IS NULL THEN 'No Response from Payer Yet'
WHEN BilledAmount > 0 AND AllowedAmount > 0 AND InsurancePayment = 0 AND InsuranceAdjustment > 0 AND  PatientPaidAmount = 0 AND  PatientAdjustment = 0 AND  InsuranceBalance = AllowedAmount AND PatientBalance = 0 AND  a.TotalBalance = InsuranceBalance AND DenialCode IS NOT NULL THEN 'Posting Pending'
WHEN BilledAmount > 0 AND AllowedAmount > 0 AND InsurancePayment = 0 AND InsuranceAdjustment = BilledAmount AND  PatientPaidAmount = 0 AND  PatientAdjustment = 0 AND  InsuranceBalance = 0 AND PatientBalance = 0 AND  a.TotalBalance = 0 AND (DenialCode IS NULL OR DenialCode IS NOT NULL) THEN 'Fully Written Off'
WHEN BilledAmount > 0 AND AllowedAmount > 0 AND InsurancePayment = 0 AND InsuranceAdjustment = 0 AND  PatientPaidAmount = 0 AND  PatientAdjustment = 0 AND  InsuranceBalance = BilledAmount AND PatientBalance = 0 AND  a.TotalBalance = BilledAmount AND DenialCode IS NULL THEN 'No Response from Payer Yet'
WHEN BilledAmount > 0 AND AllowedAmount > 0 AND InsurancePayment = AllowedAmount AND InsuranceAdjustment = 0 AND  PatientPaidAmount = 0 AND  PatientAdjustment = 0 AND  InsuranceBalance = 0 AND PatientBalance > 0 AND  a.TotalBalance = PatientBalance AND (DenialCode IS NULL OR DenialCode IS NOT NULL) THEN 'Balance Billed to Patient'
WHEN BilledAmount > 0 AND AllowedAmount > 0 AND InsurancePayment = AllowedAmount AND InsuranceAdjustment > 0 AND  PatientPaidAmount = 0 AND  PatientAdjustment = 0 AND  InsuranceBalance = 0 AND PatientBalance = 0 AND  a.TotalBalance = 0 AND DenialCode IS NOT NULL THEN 'Insurance Payment'
WHEN BilledAmount > 0 AND AllowedAmount > 0 AND InsurancePayment > 0 AND InsuranceAdjustment > 0 AND  PatientPaidAmount = 0 AND  PatientAdjustment = 0 AND  InsuranceBalance = 0 AND PatientBalance = AllowedAmount - InsurancePayment AND  a.TotalBalance = PatientBalance AND (DenialCode IS NULL OR DenialCode IS NOT NULL) THEN 'Insurance Payment'
WHEN BilledAmount > 0 AND AllowedAmount = BilledAmount AND InsurancePayment > 0 AND InsuranceAdjustment > 0 AND  PatientPaidAmount = 0 AND  PatientAdjustment = 0 AND  InsuranceBalance = 0 AND PatientBalance = 0 AND  a.TotalBalance = 0 AND (DenialCode IS NULL OR DenialCode IS NOT NULL) THEN 'Posting Error'
WHEN BilledAmount > 0 AND AllowedAmount > 0 AND InsurancePayment = AllowedAmount AND InsuranceAdjustment = 0 AND  PatientPaidAmount = 0 AND  PatientAdjustment = 0 AND  InsuranceBalance = BilledAmount AND PatientBalance = 0 AND  a.TotalBalance = BilledAmount AND (DenialCode IS NULL OR DenialCode IS NOT NULL) THEN 'Insurance Adjustment not posted'
WHEN BilledAmount > 0 AND AllowedAmount > 0 AND InsurancePayment = AllowedAmount AND InsuranceAdjustment = 0 AND  PatientPaidAmount = 0 AND  PatientAdjustment = 0 AND  InsuranceBalance = BilledAmount AND PatientBalance = 0 AND  a.TotalBalance = BilledAmount AND (DenialCode IS NULL OR DenialCode IS NOT NULL) THEN 'Adjustment not posted'
WHEN BilledAmount > 0 AND AllowedAmount = 0 AND InsurancePayment = 0 AND InsuranceAdjustment = BilledAmount AND  PatientPaidAmount = 0 AND  PatientAdjustment = 0 AND  InsuranceBalance = 0 AND PatientBalance = 0 AND  a.TotalBalance = 0 AND (DenialCode IS NULL OR DenialCode IS NOT NULL) THEN 'Fully Written Off'
WHEN BilledAmount > 0 AND AllowedAmount > 0 AND InsurancePayment > 0 AND InsuranceAdjustment > 0 AND  PatientPaidAmount = 0 AND  PatientAdjustment = 0 AND  InsuranceBalance = 0 AND PatientBalance = 0 AND  a.TotalBalance = 0 AND (DenialCode IS NULL OR DenialCode IS NOT NULL) THEN 'Posting Error'
WHEN BilledAmount > 0 AND AllowedAmount = 0 AND InsurancePayment = 0 AND InsuranceAdjustment = 0 AND  PatientPaidAmount = 0 AND  PatientAdjustment = 0 AND  InsuranceBalance = BilledAmount AND PatientBalance = 0 AND  a.TotalBalance = BilledAmount AND DenialCode IS NULL THEN 'No Response from Payer Yet'
WHEN BilledAmount > 0 AND AllowedAmount > 0 AND InsurancePayment = AllowedAmount AND InsuranceAdjustment = 0 AND  PatientPaidAmount = 0 AND  PatientAdjustment = 0 AND  InsuranceBalance = BilledAmount AND PatientBalance = 0 AND  a.TotalBalance = BilledAmount AND DenialCode IS NOT NULL THEN 'Adjustment not posted'
WHEN BilledAmount > 0 AND AllowedAmount > 0 AND InsurancePayment = AllowedAmount AND InsuranceAdjustment > 0 AND  PatientPaidAmount = 0 AND  PatientAdjustment = 0 AND  InsuranceBalance = BilledAmount AND PatientBalance = 0 AND  a.TotalBalance = BilledAmount AND DenialCode IS NOT NULL THEN 'Insurance Payment'
WHEN BilledAmount > 0 AND AllowedAmount > 0 AND InsurancePayment > 0 AND InsuranceAdjustment > 0 AND  PatientPaidAmount = 0 AND  PatientAdjustment = 0 AND  InsuranceBalance = BilledAmount AND PatientBalance = 0 AND  a.TotalBalance = BilledAmount AND DenialCode IS NOT NULL THEN ' BilledAmount not equal to Allowed + Adjustment'
WHEN BilledAmount > 0 AND AllowedAmount = BilledAmount AND InsurancePayment = AllowedAmount AND InsuranceAdjustment = 0 AND  PatientPaidAmount = 0 AND  PatientAdjustment = 0 AND  InsuranceBalance = 0 AND PatientBalance = 0 AND  a.TotalBalance = 0 AND (DenialCode IS NULL OR DenialCode IS NOT NULL) THEN 'Insurance Payment'
WHEN BilledAmount > 0 AND AllowedAmount > 0 AND InsurancePayment = 0 AND InsuranceAdjustment = 0 AND  PatientPaidAmount = 0 AND  PatientAdjustment = 0 AND  InsuranceBalance = BilledAmount AND PatientBalance = 0 AND  a.TotalBalance = BilledAmount AND DenialCode IS NOT NULL THEN 'Insurance Denial'
WHEN BilledAmount > 0 AND AllowedAmount > 0 AND InsurancePayment > 0 AND InsuranceAdjustment > 0 AND  PatientPaidAmount = 0 AND  PatientAdjustment = 0 AND  InsuranceBalance = BilledAmount AND PatientBalance = 0 AND  a.TotalBalance = BilledAmount AND (DenialCode IS NULL OR DenialCode IS NOT NULL) THEN 'Posting Error'
WHEN BilledAmount > 0 AND AllowedAmount > 0 AND InsurancePayment = AllowedAmount AND InsuranceAdjustment > 0 AND  PatientPaidAmount = 0 AND  PatientAdjustment = 0 AND  InsuranceBalance = AllowedAmount AND PatientBalance = 0 AND  a.TotalBalance = InsuranceBalance AND DenialCode IS NOT NULL THEN 'Posting Pending'
WHEN BilledAmount > 0 AND AllowedAmount > 0 AND InsurancePayment = AllowedAmount AND InsuranceAdjustment > 0 AND  PatientPaidAmount = 0 AND  PatientAdjustment = 0 AND  InsuranceBalance = BilledAmount AND PatientBalance = 0 AND  a.TotalBalance = BilledAmount AND (DenialCode IS NULL OR DenialCode IS NOT NULL) THEN 'Insurance Payment'
WHEN BilledAmount > 0 AND AllowedAmount = BilledAmount AND InsurancePayment > 0 AND InsuranceAdjustment > 0 AND  PatientPaidAmount = 0 AND  PatientAdjustment = 0 AND  InsuranceBalance = 0 AND PatientBalance = 0 AND  a.TotalBalance = 0 AND (DenialCode IS NULL OR DenialCode IS NOT NULL) THEN 'Insurance Payment'
WHEN BilledAmount > 0 AND AllowedAmount = 0 AND InsurancePayment = 0 AND InsuranceAdjustment = 0 AND  PatientPaidAmount = 0 AND  PatientAdjustment = 0 AND  InsuranceBalance = BilledAmount AND PatientBalance = 0 AND  a.TotalBalance = BilledAmount AND DenialCode IS NOT NULL THEN 'Insurance Denial'
WHEN BilledAmount > 0 AND AllowedAmount > 0 AND InsurancePayment = 0 AND InsuranceAdjustment > 0 AND  PatientPaidAmount = 0 AND  PatientAdjustment = 0 AND  InsuranceBalance = BilledAmount AND PatientBalance = 0 AND  a.TotalBalance = BilledAmount AND DenialCode IS NOT NULL THEN 'Posting Pending'
WHEN BilledAmount > 0 AND AllowedAmount = BilledAmount AND InsurancePayment = 0 AND InsuranceAdjustment = 0 AND  PatientPaidAmount = 0 AND  PatientAdjustment = 0 AND  InsuranceBalance = 0 AND PatientBalance = AllowedAmount AND  a.TotalBalance = AllowedAmount AND (DenialCode IS NULL OR DenialCode IS NOT NULL) THEN 'Adjudicated towards Patient Responsibility'
WHEN BilledAmount > 0 AND AllowedAmount = 0 AND InsurancePayment = 0 AND InsuranceAdjustment = 0 AND  PatientPaidAmount = 0 AND  PatientAdjustment = 0 AND  InsuranceBalance = 0 AND PatientBalance = BilledAmount AND  a.TotalBalance = BilledAmount AND (DenialCode IS NULL OR DenialCode IS NOT NULL) THEN 'Moved to Patient Responsibility'
WHEN BilledAmount > 0 AND AllowedAmount = BilledAmount AND InsurancePayment > 0 AND InsuranceAdjustment = 0 AND  PatientPaidAmount = 0 AND  PatientAdjustment = 0 AND  InsuranceBalance = BilledAmount AND PatientBalance = 0 AND  a.TotalBalance = BilledAmount AND DenialCode IS NOT NULL THEN 'Posting Pending'
WHEN BilledAmount > 0 AND AllowedAmount > 0 AND InsurancePayment = AllowedAmount AND InsuranceAdjustment > 0 AND  PatientPaidAmount = 0 AND  PatientAdjustment  > 0 AND  InsuranceBalance = 0 AND PatientBalance = 0 AND  a.TotalBalance = 0 AND (DenialCode IS NULL OR DenialCode IS NOT NULL) THEN 'Insurance Payment'
WHEN BilledAmount > 0 AND AllowedAmount > 0 AND InsurancePayment = 0 AND InsuranceAdjustment > 0 AND  PatientPaidAmount = 0 AND  PatientAdjustment = 0 AND  InsuranceBalance = 0 AND PatientBalance = AllowedAmount AND  a.TotalBalance = AllowedAmount AND (DenialCode IS NULL OR DenialCode IS NOT NULL) THEN 'Adjudicated towards Patient Responsibility'
WHEN BilledAmount > 0 AND AllowedAmount = BilledAmount AND InsurancePayment = 0 AND InsuranceAdjustment > 0 AND  PatientPaidAmount = 0 AND  PatientAdjustment = 0 AND  InsuranceBalance = BilledAmount AND PatientBalance = 0 AND  a.TotalBalance = BilledAmount AND (DenialCode IS NULL OR DenialCode IS NOT NULL) THEN 'Posting Error'
WHEN BilledAmount > 0 AND AllowedAmount = BilledAmount AND InsurancePayment = 0 AND InsuranceAdjustment = BilledAmount AND  PatientPaidAmount = 0 AND  PatientAdjustment = 0 AND  InsuranceBalance = 0 AND PatientBalance = 0 AND  a.TotalBalance = 0 AND DenialCode IS NOT NULL THEN 'Fully Written Off'
WHEN BilledAmount > 0 AND AllowedAmount = BilledAmount AND InsurancePayment = 0 AND InsuranceAdjustment > 0 AND  PatientPaidAmount = 0 AND  PatientAdjustment = 0 AND  InsuranceBalance = BilledAmount AND PatientBalance = 0 AND  a.TotalBalance = BilledAmount AND DenialCode IS NOT NULL THEN 'Posting Pending'
WHEN BilledAmount > 0 AND AllowedAmount > 0 AND InsurancePayment = 0 AND InsuranceAdjustment > 0 AND  PatientPaidAmount = 0 AND  PatientAdjustment = 0 AND  InsuranceBalance = AllowedAmount AND PatientBalance = 0 AND  a.TotalBalance = InsuranceBalance AND (DenialCode IS NULL OR DenialCode IS NOT NULL) THEN 'Posting Pending'
WHEN BilledAmount > 0 AND AllowedAmount > 0 AND InsurancePayment > 0 AND InsuranceAdjustment = 0 AND  PatientPaidAmount = 0 AND  PatientAdjustment = 0 AND  InsuranceBalance = BilledAmount AND PatientBalance = 0 AND  a.TotalBalance = BilledAmount AND (DenialCode IS NULL OR DenialCode IS NOT NULL) THEN 'Insurance Adjustment not posted'
WHEN BilledAmount > 0 AND AllowedAmount > 0 AND InsurancePayment > 0 AND InsuranceAdjustment > 0 AND  PatientPaidAmount = 0 AND  PatientAdjustment = 0 AND  InsuranceBalance = 0 AND PatientBalance = AllowedAmount - InsurancePayment AND  a.TotalBalance = PatientBalance AND DenialCode IS NOT NULL THEN 'Insurance Payment'
WHEN BilledAmount > 0 AND AllowedAmount > 0 AND AllowedAmount <> BilledAmount AND InsurancePayment = 0 AND InsuranceAdjustment > 0 AND  PatientPaidAmount = 0 AND  PatientAdjustment = 0 AND  InsuranceBalance = AllowedAmount AND PatientBalance = 0 AND  a.TotalBalance = InsuranceBalance AND DenialCode IS NOT NULL THEN 'Posting Pending'
WHEN BilledAmount > 0 AND AllowedAmount = BilledAmount AND InsurancePayment > 0 AND InsuranceAdjustment = 0 AND  PatientPaidAmount = 0 AND  PatientAdjustment = 0 AND  InsuranceBalance = 0 AND PatientBalance = AllowedAmount - InsurancePayment AND  a.TotalBalance = PatientBalance AND (DenialCode IS NULL OR DenialCode IS NOT NULL) THEN 'Balance Billed to Patient'
WHEN BilledAmount > 0 AND AllowedAmount > 0 AND InsurancePayment > 0 AND InsuranceAdjustment > 0 AND  PatientPaidAmount = 0 AND  PatientAdjustment = 0 AND InsuranceBalance > 0 AND PatientBalance = 0 AND  a.TotalBalance = InsuranceBalance AND DenialCode IS NOT NULL THEN 'Insurance Payment'
WHEN BilledAmount > 0 AND AllowedAmount = BilledAmount AND InsurancePayment = 0 AND InsuranceAdjustment > 0 AND InsuranceAdjustment < AllowedAmount AND  PatientPaidAmount = 0 AND  PatientAdjustment = 0 AND InsuranceBalance = (BilledAmount - InsuranceAdjustment) AND PatientBalance = 0 AND  a.TotalBalance = InsuranceBalance AND DenialCode IS NOT NULL THEN 'Posting Error'
WHEN BilledAmount > 0 AND AllowedAmount = BilledAmount AND InsurancePayment > 0 AND InsurancePayment < AllowedAmount AND InsuranceAdjustment = 0 AND  PatientPaidAmount = 0 AND  PatientAdjustment = 0 AND InsuranceBalance = (BilledAmount - InsurancePayment) AND PatientBalance = 0 AND  a.TotalBalance = InsuranceBalance AND DenialCode IS NOT NULL THEN 'Posting Error'
WHEN BilledAmount > 0 AND AllowedAmount > 0 AND AllowedAmount < BilledAmount AND InsurancePayment = AllowedAmount AND InsuranceAdjustment = 0 AND  PatientPaidAmount = 0 AND  PatientAdjustment = 0 AND InsuranceBalance = (BilledAmount - InsurancePayment) AND PatientBalance = 0 AND  a.TotalBalance = InsuranceBalance and (DenialCode IS NULL OR DenialCode IS NOT NULL) THEN 'Posting Error'
WHEN BilledAmount > 0 AND AllowedAmount > 0 AND AllowedAmount < BilledAmount AND InsurancePayment > AllowedAmount AND InsuranceAdjustment = 0 AND  PatientPaidAmount = 0 AND  PatientAdjustment = 0 AND InsuranceBalance = (BilledAmount - InsurancePayment) AND PatientBalance = 0 AND  a.TotalBalance = InsuranceBalance and (DenialCode IS NULL OR DenialCode IS NOT NULL) THEN 'Posting Error'
WHEN BilledAmount > 0 AND AllowedAmount = BilledAmount AND InsurancePayment = 0 AND InsuranceAdjustment > 0 AND InsuranceAdjustment < AllowedAmount AND  PatientPaidAmount = 0 AND  PatientAdjustment = 0 AND InsuranceBalance = (BilledAmount - InsuranceAdjustment) AND PatientBalance = 0 AND  a.TotalBalance = InsuranceBalance and (DenialCode IS NULL OR DenialCode IS NOT NULL) THEN 'Posting Error'
WHEN BilledAmount > 0 AND AllowedAmount = BilledAmount AND InsurancePayment = 0 AND InsuranceAdjustment = 0 AND InsuranceAdjustment = 0 AND PatientPaidAmount = 0 AND PatientAdjustment = BilledAmount AND InsuranceBalance = 0 AND PatientBalance = 0 AND a.TotalBalance = 0 AND (DenialCode IS NULL OR DenialCode IS NOT NULL) THEN 'Adjusted'
WHEN BilledAmount > 0 AND AllowedAmount > BilledAmount AND InsurancePayment > 0 AND InsuranceAdjustment = 0 AND InsuranceAdjustment > 0 AND PatientPaidAmount = 0 AND PatientAdjustment > 0 AND InsuranceBalance = 0 AND PatientBalance = 0 AND a.TotalBalance = 0 AND (DenialCode IS NULL) THEN 'Insurance Payment'
WHEN BilledAmount > 0 AND AllowedAmount > BilledAmount AND InsurancePayment = 0 AND InsuranceAdjustment = 0 AND InsuranceAdjustment > 0 AND PatientPaidAmount > 0 AND PatientAdjustment = 0 AND InsuranceBalance = 0 AND PatientBalance = 0 AND a.TotalBalance = 0 AND (DenialCode IS NULL OR DenialCode IS NOT NULL) THEN 'Paid by Patient'
WHEN BilledAmount > 0 AND AllowedAmount > BilledAmount AND InsurancePayment = 0 AND InsuranceAdjustment = 0 AND InsuranceAdjustment > 0 AND PatientPaidAmount = 0 AND PatientAdjustment = 0 AND InsuranceBalance = 0 AND PatientBalance = 0 AND a.TotalBalance > 0 AND (DenialCode IS NULL) THEN 'Adjudicated towards Patient Responsibility'


ELSE 'No Response'
END AS ClaimSubStatus FROM BillingMaster a
 LEFT JOIN ClaimDenialCodes b 
 ON a.VisitNumber = b.VisitNumber AND a.CPTCode = b.CPTCode 
  WHERE a.VisitNumber = @VisitNumber AND a.CPTCode = @CPTCode 
	 AND ISNULL(a.FirstBillDate, '1900-01-01') = ISNULL(@FirstBillDate, '1900-01-01')
		  AND ISNULL(a.Units,999) = ISNULL(@Units,999)
		  AND ABS(a.BilledAmount - @BilledAmount) < 0.01
		  AND ISNULL(a.Modifier,9999) = ISNULL(@Modifier,9999)
);
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
/****** Object:  UserDefinedFunction [dbo].[GetPaymentDetails]******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create FUNCTION [dbo].[GetPaymentDetails](
    @VisitNo VARCHAR(50),
    @CPTCode VARCHAR(20)
)
RETURNS TABLE
AS
RETURN
    SELECT TOP 1
        CheckNumber,
        CheckDate,
        LastPostedDate
    FROM (
        SELECT
            VisitNo,
            CPTCode,
            ChartNumber,
            CheckNumber,
            DateofDeposit AS CheckDate,
            DateofEntry AS LastPostedDate,
            PatientPaidAmount,
            InsurancePaidAmount,
            PaymentMethod
        FROM TransactionMaster
        WHERE VisitNo = @VisitNo 
          AND CPTCode = @CPTCode
          AND (PatientPaidAmount > 0 OR InsurancePaidAmount > 0)
    ) AS SubQuery
    ORDER BY 
        CASE 
            WHEN CheckNumber IS NOT NULL AND CheckDate IS NOT NULL THEN 1
            ELSE 2
        END,
        LastPostedDate DESC;
GO
/****** Object:  Table [dbo].[DenialTrackingMaster]******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[DenialTrackingMaster](
	[DenailTrackID] [int] IDENTITY(1,1) NOT NULL,
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
/****** Object:  UserDefinedFunction [dbo].[tvf_GetDenialCodesByVisit]******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- Latest, de-duplicated denial codes for a visit (across all CPTs)
-- Returns 0 or 1 row per VisitNumber with LatestPaymentDate + aggregated codes
CREATE   FUNCTION [dbo].[tvf_GetDenialCodesByVisit]
(
    @VisitNumber VARCHAR(100)
)
RETURNS TABLE
AS
RETURN
WITH Base AS
(
    SELECT
        d.VisitNumber,
        d.CPTCodes,
        /* Normalize date from datetime or text (dd/MM/yyyy -> 103, MM/dd/yyyy -> 101) */
        COALESCE(
            TRY_CONVERT(date, d.PaymentDate),
            TRY_CONVERT(date, CONVERT(varchar(50), d.PaymentDate), 103),
            TRY_CONVERT(date, CONVERT(varchar(50), d.PaymentDate), 101)
        ) AS PayDate,
        LTRIM(RTRIM(d.PaymentReasonCode)) AS PaymentReasonCode
    FROM dbo.DenialTrackingMaster d
    WHERE d.VisitNumber = @VisitNumber
      AND d.PaymentReasonCode IS NOT NULL AND PaymentReasonCode NOT IN
    ('CO45','CO253','CO1','CO2','CO3','PR1','PR2','PR3','PR45','PR253')
      AND LTRIM(RTRIM(d.PaymentReasonCode)) <> ''
),
-- Drop standard codes up front
BaseFiltered AS
(
    SELECT *
    FROM Base
    WHERE PaymentReasonCode NOT IN
    ('CO45','CO253','CO1','CO2','CO3','PR1','PR2','PR3','PR45','PR253')
),
-- Aggregate any multiple rows on the same day per CPT
AggPerDay AS
(
    SELECT
        VisitNumber,
        CPTCodes,
        PayDate,
        STRING_AGG(PaymentReasonCode, ';') AS CodesPerDay
    FROM BaseFiltered   WHERE PaymentReasonCode NOT IN
    ('CO45','CO253','CO1','CO2','CO3','PR1','PR2','PR3','PR45','PR253')
    GROUP BY VisitNumber, CPTCodes, PayDate
),
-- Rank dates to take the latest per CPT
Ranked AS
(
    SELECT
        a.*,
        ROW_NUMBER() OVER (PARTITION BY VisitNumber, CPTCodes ORDER BY PayDate DESC) AS rn
    FROM AggPerDay a
),
Latest AS
(
    SELECT VisitNumber, CPTCodes, PayDate, CodesPerDay
    FROM Ranked
    WHERE rn = 1
),
-- Tokenize and trim codes from the latest-day-per-CPT rows
Tokens AS
(
    SELECT
        l.VisitNumber,
        l.PayDate,
        LTRIM(RTRIM(s.value)) AS Code
    FROM Latest l
    CROSS APPLY STRING_SPLIT(l.CodesPerDay, ';') AS s
    WHERE LTRIM(RTRIM(s.value)) <> ''
),
-- Distinct across CPTs, keep the max date (latest among the latest-per-CPT set)
DistinctCodes AS
(
    SELECT DISTINCT VisitNumber, Code, PayDate
    FROM Tokens
)
SELECT
    VisitNumber,
    MAX(PayDate) AS LatestPaymentDate,
    STRING_AGG(Code, ';') WITHIN GROUP (ORDER BY Code) AS DenialCodes
FROM DistinctCodes
GROUP BY VisitNumber;
GO
/****** Object:  Table [dbo].[AccPaymentReportStaging]******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[AccPaymentReportStaging](
	[RecordId] [nvarchar](max) NULL,
	[AccessionNo] [nvarchar](max) NULL,
	[Category] [nvarchar](max) NULL,
	[BillingStatus] [nvarchar](max) NULL,
	[VisitNumber] [int] NULL,
	[AMD_Insurance] [nvarchar](max) NULL,
	[BilledAmount] [int] NULL,
	[PaidAmount] [float] NULL,
	[PatientBalance] [int] NULL,
	[Case_Type] [nvarchar](max) NULL,
	[Paid_Status] [nvarchar](max) NULL,
	[Requistion_Type] [nvarchar](max) NULL,
	[PhysicianName] [nvarchar](max) NULL,
	[Panel] [nvarchar](max) NULL,
	[Validated_Date] [datetime] NULL,
	[FacilityName] [nvarchar](max) NULL,
	[DateOfCollection] [datetime] NULL,
	[SaleRepName] [float] NULL,
	[SpecimenStatus] [nvarchar](max) NULL,
	[Insurance_Type] [float] NULL,
	[ImportedFileID] [int] NULL,
	[ImportedOn] [datetime] NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
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
	[BillingProvider_Trim]  AS (ltrim(rtrim([BillingProvider]))) PERSISTED,
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
/****** Object:  Table [dbo].[Cities]******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Cities](
	[CityId] [int] IDENTITY(1,1) NOT NULL,
	[CityName] [nvarchar](150) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[CityId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY],
UNIQUE NONCLUSTERED 
(
	[CityName] ASC
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
/****** Object:  Table [dbo].[Genders]******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Genders](
	[GenderId] [int] IDENTITY(1,1) NOT NULL,
	[GenderName] [nvarchar](150) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[GenderId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY],
UNIQUE NONCLUSTERED 
(
	[GenderName] ASC
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
	[LogMessage] [nvarchar](500) NOT NULL,
	[RowNo] [int] NULL,
	[ColumnName] [varchar](30) NULL,
	[CreatedOn] [datetime] NULL,
PRIMARY KEY CLUSTERED 
(
	[LogID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
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
	[SeqNo] [int] NULL,
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
	[PayerName_Trim]  AS (ltrim(rtrim([PayerName]))) PERSISTED,
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
/****** Object:  Table [dbo].[InsuranceRelationships]******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[InsuranceRelationships](
	[InsuranceRelationshipId] [int] IDENTITY(1,1) NOT NULL,
	[RelationshipName] [nvarchar](150) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[InsuranceRelationshipId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY],
UNIQUE NONCLUSTERED 
(
	[RelationshipName] ASC
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
	[LabName_Trim]  AS (ltrim(rtrim([LabName]))) PERSISTED,
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
	[AccessionNo] [nvarchar](150) NULL,
	[LabId] [int] NULL,
	[RecordId] [nvarchar](150) NULL,
	[RequistionTypeId] [int] NULL,
	[RelationshipToInsurance] [nvarchar](250) NULL,
	[FacilityState] [nvarchar](150) NULL,
	[ReferringProviderId] [int] NULL,
	[SampleReceivedDate] [date] NULL,
	[FacilityCity] [nvarchar](150) NULL,
	[FacilityZipcode] [nvarchar](150) NULL,
	[Time] [nvarchar](150) NULL,
	[FacilityAddress] [nvarchar](150) NULL,
	[Panel] [nvarchar](max) NULL,
	[ReferenceId] [nvarchar](150) NULL,
	[SampleResultedDate] [date] NULL,
	[PolicyHolderDOB] [nvarchar](150) NULL,
	[Address] [nvarchar](250) NULL,
	[Medications] [nvarchar](max) NULL,
	[ClinicId] [int] NULL,
	[ICD10Code] [nvarchar](250) NULL,
	[Email] [nvarchar](150) NULL,
	[City] [nvarchar](150) NULL,
	[Gender] [nvarchar](150) NULL,
	[SampleCollectedDate] [date] NULL,
	[NPI] [varchar](50) NULL,
	[State] [nvarchar](150) NULL,
	[PatientDOB] [nvarchar](250) NULL,
	[DateLabCollected] [date] NULL,
	[TransferToLab] [nvarchar](150) NULL,
	[PatientEthnicity] [nvarchar](150) NULL,
	[SalesPersonId] [int] NULL,
	[FirstName] [nvarchar](150) NULL,
	[SampleStatusId] [int] NULL,
	[PrimaryPayerName] [varchar](250) NULL,
	[PrimaryMemberId] [varchar](250) NULL,
	[PrimaryGroupNo] [varchar](250) NULL,
	[ZipCode] [nvarchar](150) NULL,
	[Race] [nvarchar](150) NULL,
	[LastName] [nvarchar](150) NULL,
	[LabCode] [nvarchar](150) NULL,
	[PayerTypeId] [int] NULL,
	[BillingProviderID] [int] NULL,
	[PatientName] [nvarchar](250) NULL,
	[SampleAccessionedDate] [date] NULL,
	[BilledTo] [varchar](250) NULL,
	[OperationalGroupId] [int] NULL,
	[TestCode] [nvarchar](250) NULL,
	[TestTypeId] [int] NULL,
	[OrderInfo] [nvarchar](500) NULL,
	[PanelId] [int] NULL,
	[PanelCode] [nvarchar](1500) NULL,
	[PanelName] [nvarchar](1500) NULL,
	[ResultedStatus] [varchar](100) NULL,
	[DaystoReceive] [int] NULL,
	[DaystoResult] [int] NULL,
	[DaystoBill] [int] NULL,
	[ClientStatus] [nvarchar](250) NULL,
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
	[NewStatus] [varchar](50) NULL,
	[StatusCode] [varchar](50) NULL,
	[InsuranceType] [varchar](50) NULL,
	[ReferringProviderName] [varchar](250) NULL,
	[AccessionIdentity] [varchar](250) NULL,
	[AccessionUnique] [nvarchar](50) NULL,
	[FacilityName] [nvarchar](250) NULL,
	[SalesPersonName] [nvarchar](255) NULL,
	[RequistionType] [nvarchar](255) NULL,
PRIMARY KEY CLUSTERED 
(
	[LISMasterId] ASC
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
	[RecordId] [nvarchar](150) NULL,
	[AccessionNo] [nvarchar](150) NULL,
	[RequistionType] [nvarchar](150) NULL,
	[FacilityState] [nvarchar](150) NULL,
	[RelationshipToInsured] [nvarchar](150) NULL,
	[PhysicianName] [nvarchar](150) NULL,
	[ReceivedDate] [date] NULL,
	[FacilityCity] [nvarchar](150) NULL,
	[FacilityZipcode] [nvarchar](150) NULL,
	[Time] [nvarchar](150) NULL,
	[FacilityAddress] [nvarchar](150) NULL,
	[PolicyId] [nvarchar](150) NULL,
	[GroupId] [nvarchar](150) NULL,
	[Panel] [nvarchar](max) NULL,
	[ReferenceId] [nvarchar](150) NULL,
	[Validated_Date] [date] NULL,
	[PolicyHolderDOB] [nvarchar](150) NULL,
	[Address] [nvarchar](250) NULL,
	[Medications] [nvarchar](max) NULL,
	[FacilityName] [nvarchar](150) NULL,
	[ICDCodes] [nvarchar](250) NULL,
	[Email] [nvarchar](150) NULL,
	[City] [nvarchar](150) NULL,
	[Gender] [nvarchar](150) NULL,
	[DateOfCollection] [date] NULL,
	[NPI] [date] NULL,
	[State] [nvarchar](150) NULL,
	[DOB] [date] NULL,
	[DateofService] [nvarchar](150) NULL,
	[TransferTo] [nvarchar](150) NULL,
	[PatientEthnicity] [nvarchar](150) NULL,
	[SaleRepName] [nvarchar](150) NULL,
	[FirstName] [nvarchar](150) NULL,
	[Status] [nvarchar](150) NULL,
	[PrimaryInsuranceProvider] [nvarchar](150) NULL,
	[ZipCode] [nvarchar](150) NULL,
	[Race] [nvarchar](150) NULL,
	[LastName] [nvarchar](150) NULL,
	[LabCode] [nvarchar](150) NULL,
	[Insurance_Type] [nvarchar](150) NULL,
	[ProviderName] [nvarchar](150) NULL,
	[ImportedFileID] [int] NOT NULL,
	[ImportedOn] [datetime] NOT NULL,
	[ImportedBy] [nvarchar](150) NULL,
PRIMARY KEY CLUSTERED 
(
	[LISStagingId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Medications]******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Medications](
	[MedicationId] [int] IDENTITY(1,1) NOT NULL,
	[MedicationName] [nvarchar](500) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[MedicationId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY],
UNIQUE NONCLUSTERED 
(
	[MedicationName] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
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
/****** Object:  Table [dbo].[Panels]******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Panels](
	[PanelId] [int] IDENTITY(1,1) NOT NULL,
	[PanelName] [nvarchar](500) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[PanelId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY],
UNIQUE NONCLUSTERED 
(
	[PanelName] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
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
	[PayerType_Trim]  AS (ltrim(rtrim([PayerType]))) PERSISTED,
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
/****** Object:  Table [dbo].[Races]******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Races](
	[RaceId] [int] IDENTITY(1,1) NOT NULL,
	[RaceName] [nvarchar](150) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[RaceId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY],
UNIQUE NONCLUSTERED 
(
	[RaceName] ASC
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
	[RefProvName_Trim]  AS (ltrim(rtrim([ReferringProviderName]))) PERSISTED,
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
	[CreatedOn] [datetime] NULL,
	[LogString] [nvarchar](max) NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[RequisitionTypes]******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[RequisitionTypes](
	[RequisitionTypeId] [int] IDENTITY(1,1) NOT NULL,
	[RequisitionTypeName] [nvarchar](150) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[RequisitionTypeId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY],
UNIQUE NONCLUSTERED 
(
	[RequisitionTypeName] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
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
/****** Object:  Table [dbo].[States]******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[States](
	[StateId] [int] IDENTITY(1,1) NOT NULL,
	[StateName] [nvarchar](150) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[StateId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY],
UNIQUE NONCLUSTERED 
(
	[StateName] ASC
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
/****** Object:  Table [dbo].[UserRole]******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[UserRole](
	[UserRoleId] [int] IDENTITY(1,1) NOT NULL,
	[RoleName] [nvarchar](100) NOT NULL,
	[IsActive] [bit] NULL,
	[CreatedOn] [datetime] NULL,
PRIMARY KEY CLUSTERED 
(
	[UserRoleId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY],
UNIQUE NONCLUSTERED 
(
	[RoleName] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Users]******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Users](
	[UserId] [int] IDENTITY(1,1) NOT NULL,
	[Username] [nvarchar](100) NOT NULL,
	[PasswordHash] [nvarchar](256) NOT NULL,
	[PasswordSalt] [nvarchar](256) NOT NULL,
	[UserRoleId] [int] NULL,
	[IsActive] [bit] NULL,
	[CreatedOn] [datetime] NULL,
PRIMARY KEY CLUSTERED 
(
	[UserId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY],
UNIQUE NONCLUSTERED 
(
	[Username] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
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
ALTER TABLE [dbo].[AccPaymentReportStaging] ADD  DEFAULT (getdate()) FOR [ImportedOn]
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
ALTER TABLE [dbo].[UserRole] ADD  DEFAULT ((1)) FOR [IsActive]
GO
ALTER TABLE [dbo].[UserRole] ADD  DEFAULT (getdate()) FOR [CreatedOn]
GO
ALTER TABLE [dbo].[Users] ADD  DEFAULT ((1)) FOR [IsActive]
GO
ALTER TABLE [dbo].[Users] ADD  DEFAULT (getdate()) FOR [CreatedOn]
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
	DROP TABLE IF EXISTS #CollectionFiles;
	DROP TABLE IF EXISTS #TransData
	DROP TABLE IF EXISTS #FinalBillingMaster

	IF @FileId IS NULL
		SET @FileId = (SELECT TOP 1 ImportedFileID FROM CustomCollectionStaging ORDER BY ImportedFileID DESC)

    -- Step 1: Load distinct staging data
    SELECT 
        VisitNumber,
        LTRIM(RTRIM(SUBSTRING(BilledCPTCode, 1, 5))) AS CPTCode,
		LTRIM(RTRIM(SUBSTRING(BilledCPTCode, 8, LEN(BilledCPTCode)))) AS CPTCodeDescription,
		AccessionNo,
        LastBillDate,
        ChargeEntryDate,
        PayerName,
        PayerType,
		BillingProvider,
        ReferringProvider,
        PerformingLab,
        PatientName,
		PatientID ChartNum,
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
        TotalBalance,ImportedFileID,
		 -- Accession part before first slash
    CASE 
        WHEN CHARINDEX('/', AccessionNo) > 0 
        THEN LEFT(AccessionNo, CHARINDEX('/', AccessionNo) - 1)
        ELSE AccessionNo
    END AS AccessionPart,

    -- Panel between first and second slash
    CASE 
        WHEN CHARINDEX('/', AccessionNo) > 0 AND CHARINDEX('/', AccessionNo, CHARINDEX('/', AccessionNo) + 1) > 0
        THEN SUBSTRING(
            AccessionNo,
            CHARINDEX('/', AccessionNo) + 1,
            CHARINDEX('/', AccessionNo, CHARINDEX('/', AccessionNo) + 1) - CHARINDEX('/', AccessionNo) - 1
        )
        ELSE NULL
    END AS PanelName,

    -- Career after second slash
    CASE 
        WHEN CHARINDEX('/', AccessionNo, CHARINDEX('/', AccessionNo) + 1) > 0
        THEN RIGHT(
            AccessionNo,
            LEN(AccessionNo) - CHARINDEX('/', AccessionNo, CHARINDEX('/', AccessionNo) + 1)
        )
        ELSE NULL
    END AS Career

    INTO #CustomCollectionData
    FROM CustomCollectionStaging WHERE (ImportedFileID = @FileId OR @FileId is null);

	select VisitNo,CPTCode,Units,TotalBilledAmount INTO #TransData from TransactionMaster 
	where TransactionType = 'Charge'  and void is null 



	-- After INTO #CustomCollectionData
CREATE CLUSTERED INDEX CX_CustomCollectionData
ON #CustomCollectionData(VisitNumber, CPTCode, BilledAmount);

-- After INTO #TransData
CREATE CLUSTERED INDEX CX_TransData
ON #TransData(VisitNo, CPTCode, TotalBilledAmount);
   
   SELECT
        CC.AccessionPart,
        CC.VisitNumber,
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
		CC.PanelName,
		ChartNum,
        CC.PatientName,
		RF.ReferingProviderId,
		ImportedFileID,
		ResponsibleParty,
		DOB PatientDOB,
		Lab.LabId FacilityId,CC.PayerName,
		--SUM(ISNULL(cc.UNITS,0)) UNITS,
		--ISNULL(CC.Modifier,0) Modifier,
  --      SUM(CC.BilledAmount) AS BilledAmount,
  --      SUM(CC.AllowedAmount) AS AllowedAmount,
  --      SUM(CC.InsurancePayments) AS InsurancePayments,
  --      SUM(CC.InsuranceAdjustments) AS InsuranceAdjustments,
  --      SUM(CC.PatientPayments) AS PatientPayments,
  --      SUM(CC.PatientAdjustments) AS PatientAdjustments,
  --      SUM(CC.InsuranceBalance) AS InsuranceBalance,
  --      SUM(CC.PatientBalance) AS PatientBalance,
  --      SUM(CC.TotalBalance) AS TotalBalance
		--cc.UNITS UNITS,
		CC.Modifier Modifier,
        CC.BilledAmount BilledAmount,
        CC.AllowedAmount AllowedAmount,
        CC.InsurancePayments InsurancePayments,
        CC.InsuranceAdjustments InsuranceAdjustments,
        CC.PatientPayments PatientPayments,
        CC.PatientAdjustments PatientAdjustments,
        CC.InsuranceBalance InsuranceBalance,
        CC.PatientBalance PatientBalance,
        CC.TotalBalance TotalBalance,
		CC.PayerType,CC.BillingProvider,CC.PerformingLab,cc.ReferringProvider,
		CC.CPTCodeDescription
    INTO #BillingMaster
    FROM #CustomCollectionData CC
    LEFT JOIN InsurancePayerMaster IPM ON TRIM(CC.PayerName) = TRIM(IPM.PayerName)
    LEFT JOIN PayerTypeMaster PT ON TRIM(CC.PayerType) = TRIM(PT.PayerType)
    LEFT JOIN BillingProviderMaster BP ON TRIM(CC.BillingProvider) = TRIM(BP.BillingProvider)

	LEFT JOIN LabMaster Lab on TRIM(CC.PerformingLab) = TRIM(Lab.LabName)
	LEFT JOIN ReferringProviderMaster RF on cc.ReferringProvider = rf.ReferringProviderName 
  

		-- After INTO #BillingMaster (if it gets big before the insert)
		CREATE CLUSTERED INDEX CX_BillingMaster_Temp
		ON #BillingMaster(VisitNumber, CPTCode);

    -- Step 4: Merge
    BEGIN TRY
        BEGIN TRANSACTION;

				CREATE TABLE #ToDelete(VisitNumber BIGINT PRIMARY KEY);
				INSERT INTO #ToDelete(VisitNumber)
				SELECT DISTINCT VisitNumber FROM #BillingMaster;

				WHILE 1=1
				BEGIN
				  DELETE TOP (20000) BM
				  FROM dbo.BillingMaster BM
				  JOIN #ToDelete D ON D.VisitNumber = BM.VisitNumber;

				  IF @@ROWCOUNT = 0 BREAK;
				END

				DECLARE @mx bigint;
				SELECT @mx = ISNULL(MAX(BillingMasterId), 0) FROM dbo.BillingMaster WITH (TABLOCKX);
				DBCC CHECKIDENT ('dbo.BillingMaster', RESEED, @mx);
				
	            INSERT into BillingMaster(
                VisitNumber,
				AccessionNo,
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
				PanelName,
				PanelCarrier,
				PatientName,
				ReferringProviderID,
				FacilityId,
				PatientDOB,
				ResponsibleParty,
				ImportFileId,
				ChartNumber,CPTCodeDescription,PayerType,BillingProvider,PerformingLab,ReferringProvider
            )
			SELECT VisitNumber,AccessionPart,InsurancePayerId,PayerTypeId,BillingProviderID,ClientAccNum,MemberID,BeginDOS,EndDOS,
			ChargeEntryDate,FirstBillDate,BillingFrequency,ChargeEnteredBy,CPTCode,POS,TOS,Modifier,ICD10Code,BilledAmount,AllowedAmount,InsurancePayments,
			InsuranceAdjustments,PatientPayments,PatientAdjustments,InsuranceBalance,PatientBalance,TotalBalance,PanelName,PayerName,PatientName,
			ReferingProviderId,FacilityId,PatientDOB,ResponsibleParty,ImportedFileID,ChartNum,CPTCodeDescription,PayerType,BillingProvider,PerformingLab,ReferringProvider FROM #BillingMaster BM 
			

		UPDATE BillingMaster SET PanelName = 'Neurocognitive' Where LTRIM(RTRIM(CPTCodeDescription)) LIKE 'NEURO%'

		UPDATE BM SET BM.AccessionNo = LISD.AccessionNo FROM BillingMaster BM 
		JOIN LISMaster LISD ON LTRIM(RTRIM(LISD.PatientName)) = LTRIM(RTRIM(BM.PatientName)) AND 
		LISD.SampleCollectedDate = BM.BeginDOS AND LISD.PanelName = 'Neurocognitive' WHERE BM.AccessionNo IS NULL 

		UPDATE BM SET BM.AccessionNo = CASE WHEN BM.AccessionNo IS NULL THEN ISNULL(LIS.AccessionNo,LISD.AccessionNo) 
		ELSE BM.AccessionNo END FROM BillingMaster BM 
		LEFT JOIN LISMaster LIS ON  BM.AccessionNo = LIS.AccessionNo  AND BM.AccessionNo IS NULL
		LEFT JOIN LISMaster LISD ON LTRIM(RTRIM(LISD.PatientName)) = LTRIM(RTRIM(BM.PatientName)) AND 
		LISD.SampleCollectedDate = BM.BeginDOS AND BM.AccessionNo IS NULL WHERE BM.AccessionNo IS NULL

		UPDATE 	BillingMaster SET CheckDate = NULL ,PaymentPostedDate = NULL,CheckNumber = NULL;

	
		------ Create clustered index after populating #TransData
		----CREATE CLUSTERED INDEX TX_TransDataUQ_IX
		----ON #TransData (VisitNo, CPTCode, TotalBilledAmount);

			Update BM SET BM.Units = TD.Units  FROM BillingMaster BM 
			JOIN #TransData TD  ON BM.VisitNumber = TD.VisitNo and BM.CPTCode = TD.CPTCode and BM.BilledAmount = TD.TotalBilledAmount;
		
 		UPDATE BM SET 
			CheckDate = COALESCE(PD.CheckDate, BM.CheckDate),
			PaymentPostedDate = COALESCE(PD.LastPostedDate, BM.PaymentPostedDate),
			CheckNumber = COALESCE(PD.CheckNumber, BM.CheckNumber)
		FROM BillingMaster BM
		OUTER APPLY (
			SELECT TOP 1 
				CheckDate,
				LastPostedDate,
				CheckNumber
			FROM GetPaymentDetails(BM.VisitNumber, BM.CPTCode)
		) PD

		EXEC sp_ClaimLevelStatusUpdate;
		EXEC SP_ProcessLISvsBilling;
		EXEC sp_Process_FinalCalimStatus;
		EXEC [sp_ClaimBillingDetails];
		EXEC sp_LIS_PanelUpdate;

		WITH Tokens AS (
			SELECT
				bm.PanelName,
				LOWER(LTRIM(RTRIM(s.value))) AS token
			FROM BillingMaster bm
			CROSS APPLY STRING_SPLIT(
				REPLACE(REPLACE(bm.PanelName, '&', ' '), ',', ' '), ' '
			) AS s
			WHERE bm.PanelName LIKE '%WOUND%'
		),
		Clean AS (
			SELECT PanelName, token
			FROM Tokens
			WHERE token <> '' AND token <> 'and' -- drop filler if present
		),
		Dedup AS (
			SELECT PanelName, token
			FROM Clean
			GROUP BY PanelName, token
		),
		Canonical AS (
			SELECT
				PanelName,
				-- Proper case each token, aggregate as NVARCHAR(MAX)
				STRING_AGG(
					CAST( UPPER(LEFT(token, 1)) + SUBSTRING(token, 2, 4000) AS NVARCHAR(MAX) ),
					N' & '
				) WITHIN GROUP (ORDER BY token) AS NormalizedName
			FROM Dedup
			GROUP BY PanelName
		)
		UPDATE bm
		SET bm.PanelName = c.NormalizedName
		FROM BillingMaster bm
		JOIN Canonical c
		  ON c.PanelName = bm.PanelName;

		  UPDATE BillingMaster SET PanelName = 'CGX' WHERE PanelName in ('Immunodeficiency','Neurocognitive')

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
    SET c.FinalStatus = e.Final_Output_Status
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
AS
BEGIN
    SET NOCOUNT ON;

    -- Drop temp tables if they exist
	TRUNCATE TABLE [ClaimBillingDetails];

    -- Load distinct claim billing data into temp table
  

    -- Insert new records
    INSERT INTO [dbo].[ClaimBillingDetails]
    (
        [AccessionNo], [VisitNumber], [CPTCode], [FirstBillDate], [BilledAmount],
        [AllowedAmount], [InsurancePaidAmount], [InsuranceAdjustmentAmount],
        [PatientPaidAmount], [PatientAdjustmentAmount], [InsuranceBalance],
        [PatientBalance], [TotalBalance]
    )
  SELECT DISTINCT 
        UPPER(LTRIM(RTRIM(ISNULL(AccessionNo,'LIS INFO MISSING')))) AccessionNo,
        CCW.VisitNumber,
        LTRIM(RTRIM(SUBSTRING(CCW.CPTCode, 0, 6))) AS CPTCode,
        CCW.FirstBillDate,
        CCW.BilledAmount,
        CCW.AllowedAmount,
        CCW.InsurancePayment,
        CCW.InsuranceAdjustment,
        CCW.PatientPaidAmount,
        CCW.PatientAdjustment,
        CCW.InsuranceBalance,
        CCW.PatientBalance,
        CCW.TotalBalance
    FROM BillingMaster CCW
   
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
-------Rule Id : 1 Fully Adjusted: Total Charge = Carrier WO No denial code
WHEN FirstBillDate IS NOT NULL and BilledAmount = InsuranceAdjustment or BilledAmount = (InsuranceAdjustment + PatientAdjustment) Or BilledAmount = PatientAdjustment  and DenailCode IS NULL THEN 'Fully Adjusted' 

-------Rule Id : 2 Fully Denied: First Billed Date = Date AND Denial Code = Code AND Total Charge = Carrier Balance
WHEN FirstBillDate IS NOT NULL and DenailCode is not null and BilledAmount = InsuranceBalance  THEN 'Fully Denied' 

-------Rule Id : 3 Fully Paid: First Billed Date = Date AND Carrier Payment > 0 AND Carrier Balance = 0 AND CPT not equal to 99999
WHEN FirstBillDate IS NOT NULL and InsurancePayment > 0 and InsuranceBalance = 0 and CPTCode NOT LIKE '%99999%' THEN 'Fully Paid'

-------Rule Id : 4 Partially Paid: First Billed Date = Date AND CPT code is not equal to 99999 AND Carrier Payment > 0 AND Carrier Balance > 0
WHEN FirstBillDate IS NOT NULL and CPTCode NOT LIKE '%99999%' and InsurancePayment > 0 and InsuranceBalance > 0 THEN 'Partially Paid'

-------Rule Id : 5 No Response: First Billed Date = Date AND CPT Code is not Equal to 99999 AND Denial Code = Blank AND Total Charge = Carrier Balance
WHEN FirstBillDate IS NOT NULL and CPTCode NOT LIKE '%99999%' and DenailCode is null and BilledAmount = InsuranceBalance THEN 'No Response'

-------Rule Id : 6 No Response - Client- Total Charge = Carrier Balance AND Denial Code = Blank AND CPT = 99999
WHEN FirstBillDate IS NOT NULL and CPTCode LIKE '%99999%' and DenailCode is null and BilledAmount = InsuranceBalance THEN 'No Response - Client'

-------Rule Id : 7 Paid To Client: Carrier Payment > 0 AND Carrier Balance = 0 AND CPT = 99999
WHEN InsurancePayment > 0 and InsuranceBalance = 0 and CPTCode LIKE '%99999%'  THEN 'Paid To Client'

-------Rule Id : 8 Patient Responsibility: First Billed = Date AND Carrier Payment = 0 AND Patient Payment = 0 AND Carrier Balance = 0  AND Patient Balance > 0
WHEN FirstBillDate IS NOT NULL and  InsurancePayment = 0 and PatientPaidAmount = 0 and InsuranceBalance = 0 and PatientBalance > 0  and CPTCode NOT LIKE '%99999%' THEN 'Patient Responsibility'

-------Rule Id : 9 Patient Responsibility : Client: First Billed = Date AND Carrier Payment = 0 AND Patient Payment = 0 AND Carrier Balance = 0  AND Patient Balance > 0 AND CPT Code = 99999
WHEN FirstBillDate IS NOT NULL and  InsurancePayment = 0 and PatientPaidAmount = 0 and InsuranceBalance = 0 and PatientBalance > 0 and CPTCode LIKE '%99999%'  THEN 'Patient Responsibility - Client'

-------Rule Id : 10 Partially Denied: FIRST Billed = Date AND Denial Code = Denied AND Carrier Payment = 0 AND Carrier Balance > 0  AND Total Charge > Carrier Balance AND Total Balance is equal to Carrier Balance
WHEN FirstBillDate IS NOT NULL and DenailCode is not null and  InsurancePayment = 0 and InsuranceBalance > 0 and BilledAmount > InsuranceBalance 
and TotalBalance = InsuranceBalance THEN 'Partially Denied'

-------Rule Id : 11 Patient Payment: First Billed = Date AND Carrier Payment = 0 AND Patient Payment > 0 AND Carrier Balance = 0
WHEN FirstBillDate IS NOT NULL and InsurancePayment = 0 and PatientPaidAmount > 0 and InsuranceBalance = 0 THEN 'Patient Payment'

-------Rule Id : 12 Unbilled: First Billed = Blank AND Total Charge = Carrier Balance 
WHEN FirstBillDate IS NULL and BilledAmount = InsuranceBalance  and  CPTCode NOT LIKE '%99999%' THEN 'Unbilled'

-------Rule Id : 13 Unbilled: Fully Adjusted: First Billed = Blank AND Total Charge = Carrier WO
WHEN FirstBillDate IS NULL and BilledAmount = InsuranceAdjustment  THEN 'Unbilled - Fully Adjusted'

-------Rule Id : 14 Unbilled - Client: First Billed = Blank  AND CPT code = 99999 AND Total Charge = Carrier Balance
WHEN FirstBillDate IS NULL and  CPTCode LIKE '%99999%' and BilledAmount = InsuranceBalance  THEN 'Unbilled - Client'

-------Rule Id : 15 Partially Adjusted: First Billed = Date AND Carrier Payment = 0 AND Patient Payment = 0 AND  Carrier WO > 0 AND Carrier Balance > 0 AND Denial Code = Blank
WHEN FirstBillDate IS NOT NULL AND InsurancePayment = 0 AND PatientPaidAmount = 0 AND InsuranceAdjustment > 0 AND InsuranceBalance > 0 AND DenailCode IS NULL THEN 'Partially Adjusted'

-------Rule Id : 16 Unbilled - Patient Payment: First Billed Date = Blank AND Carrier Payment = 0 AND Patient Payment > 0 AND Patient WO > = 0
WHEN FirstBillDate IS NULL AND InsurancePayment = 0 AND PatientPaidAmount > 0 AND PatientAdjustment >= 0 THEN 'Unbilled - Patient Payment'


-------Rule Id : 17 Unbilled - Patient Balance: First Billed Date = Blank AND Carrier Payment = 0 AND Patient Balance > 0 AND Patient WO > = 0
WHEN FirstBillDate IS NULL AND InsurancePayment = 0 AND PatientBalance > 0 AND PatientAdjustment >= 0 THEN 'Unbilled - Patient Balance'

-------Rule Id : 18	Partial Patient Payment:	First Billed = Date AND Carrier Payment = 0 AND Patient Payment > 0 AND Carrier Balance > 0 and Patient Balance=0
WHEN FirstBillDate IS NOT NULL AND InsurancePayment = 0 AND PatientPaidAmount > 0 and PatientBalance = 0 AND InsuranceBalance > 0 THEN 'Partial Partial Payment'

-------Rule Id : 19	Unbilled - Patient WO	First Billed Date = Blank AND Carrier Payment = 0 AND TotalCharge=Patient WO
WHEN FirstBillDate IS NULL AND InsurancePayment = 0 AND BilledAmount =  PatientAdjustment  THEN 'Unbilled - Patient WO'

-------Rule Id :20	Partial Patient Responsibility:	First Billed = Date AND Carrier Payment = 0 AND Patient Payment = 0 AND Carrier Balance > 0  and Patient Balance > 0 
WHEN FirstBillDate IS NOT NULL AND InsurancePayment = 0 AND PatientPaidAmount = 0 and InsuranceBalance > 0 and PatientBalance > 0   THEN 'Partial Patient Responsibility'



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

DROP TABLE IF EXISTS #DenialCodeMaster;
SELECT 
    VisitNumber,CPTCodes,DBO.[GetDenailCodeByVisitCPT](VisitNumber,CPTCodes) AS PaymentReasonCodes,MAX(PaymentDate) AS MostRecentDenialPostingDate
	INTO #DenialCodeMaster
FROM DenialTrackingMaster
WHERE PaymentReasonCode IS NOT NULL
GROUP BY VisitNumber,CPTCodes ORDER BY VisitNumber

CREATE NONCLUSTERED INDEX IX_VisitNumber ON #DenialCodeMaster (VisitNumber,CPTCodes);

    SELECT  
        ISNULL(UPPER(b.AccessionNo),'Missing LIS Info') AccessionNo,
        b.VisitNumber,
        b.CPTCode,
        b.PatientName,
		RT.RequisitionTypeName,
		CAST(B.PatientDOB AS DATE) AS  PatientDOB, 
        PanelCarrier PayerName,
        PayerType,
        BillingProvider,
		CAST(BeginDOS AS DATE) AS   BeginDOS,
		CAST(EndDOS AS DATE) AS   EndDOS,
		CAST(b.ChargeEntryDate AS DATE) AS    ChargeEntryDate,
		CAST(FirstBillDate AS DATE) AS      FirstBillDate,
		COALESCE(b.PanelName, l.PanelCode, 'No Panel Located') AS PanelGroup,
		POS,TOS,
        b.ICD10Code,
        b.Units,
		CAST(CheckDate AS DATE) AS      CheckDate,
		CAST(PaymentPostedDate AS DATE) AS    PaymentPostedDate,
		CAST(dt.MostRecentDenialPostingDate AS DATE) AS     DenialPostedDate,
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
		PerformingLab Facility,
		cm.ClinicName,
		SP.SalesPersonName,
		--og.OperationsGroup,
		--tt.TestTypeName TestType,
		ReferringProvider ReferringProviderName,
		b.BillingSubStatus,
		CASE WHEN b.AccessionNo is null then 'Missing LIS Data' else '' end LISMissingRecord 
    FROM BillingMaster b
    LEFT JOIN LISMaster l ON b.AccessionNo = l.AccessionNo AND l.StatusCode <> 'DELETED'
	LEFT JOIN #DenialCodeMaster dt on b.VisitNumber = dt.VisitNumber AND b.CPTCode = dt.CPTCodes
	LEFT JOIN RequisitionTypes RT on l.RequistionTypeId = RT.RequisitionTypeId
    --LEFT JOIN OperationsGroupMaster OG ON l.OperationalGroupId = OG.OperationGroupID 
    --LEFT JOIN TestTypeMaster TT ON l.TestTypeId = TT.TestTypeId
	LEFT JOIN SalesPerson SP ON L.SalesPersonId = SP.SalesPersonID
	LEFT JOIN ClinicMaster CM ON l.ClinicId = CM.ClinicId

    WHERE 
        (@FromDate IS NULL OR TRY_CONVERT(date, b.FirstBillDate) >= @FromDate)
        AND
        (@ToDate IS NULL OR TRY_CONVERT(date, b.FirstBillDate) <= @ToDate)
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

			WITH CTE_TransDate AS(
		SELECT VisitNumber,ROW_NUMBER() OVER (
					PARTITION BY VisitNumber
					ORDER BY CheckDate DESC, PaymentPostedDate DESC
				) AS rn,
				CheckDate,PaymentPostedDate,CheckNumber FROM BillingMaster where CheckDate is not null
				) SELECT VisitNumber,CheckDate,PaymentPostedDate,CheckNumber INTO #TransData FROM CTE_TransDate Where rn = 1 ;

				  CREATE NONCLUSTERED INDEX IX_VisitNumber_TR ON #TransData (VisitNumber);
    -- Temp tables
    SELECT * INTO #BillingMasterTemp 
    FROM BillingMaster WITH (NOLOCK)
    WHERE (@FromDate IS NULL OR FirstBillDate >= @FromDate) 
      AND (@ToDate IS NULL OR FirstBillDate <= @ToDate);

	  Select distinct VisitNumber,DBO.GetUniqueICD10Codes(VisitNumber) ICD10Code INTO #ICDCode from BillingMaster 

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
    CREATE NONCLUSTERED INDEX IX_VisitNumber_ICD ON #ICDCode (VisitNumber);  

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
        BM.PanelCarrier PayerName,
        BM.PayerType,
        BM.BillingProvider,
		BM.AccessionNo,
        -- Window function instead of MIN()
        MIN(BM.BeginDOS) OVER (PARTITION BY BM.VisitNumber) AS BeginDOS,
		MIN(BM.ChargeEntryDate) OVER (PARTITION BY BM.VisitNumber) AS ChargeEntryDate,
		--MAX(BM.CheckDate) OVER (PARTITION BY BM.VisitNumber) AS CheckDate,
		--MAX(BM.PaymentPostedDate) OVER (PARTITION BY BM.VisitNumber) AS PaymentPostedDate,
		BM.PatientDOB,
		BM.PatientName,
		BM.ChartNumber,
		BM.ResponsibleParty,
        BM.FirstBillDate,
        BM.TOS,
        TT.TestTypeName AS TestType,
        CM.ClinicName,
        LIS.SampleCollectedDate,
        BM.ReferringProvider,
       	COALESCE(BM.PanelName, LIS.PanelCode, 'No Panel Located') AS PanelName,
		BM.PerformingLab,SP.SalesPersonName,	rt.RequisitionTypeName,
        ROW_NUMBER() OVER (
            PARTITION BY BM.VisitNumber 
              ORDER BY 
                CASE WHEN BM.FirstBillDate IS NULL THEN 1 ELSE 0 END,  -- push NULLs last
                BM.FirstBillDate
        ) AS rn
    FROM BillingMaster BM
    LEFT JOIN LISMaster LIS WITH (NOLOCK) 
        ON BM.AccessionNo = LIS.AccessionNo
    LEFT JOIN TestTypeMaster TT 
        ON LIS.TestTypeId = TT.TestTypeId
   		LEFT JOIN RequisitionTypes rt ON LIS.RequistionTypeId = rt.RequisitionTypeId
		LEFT JOIN ClinicMaster CM ON LIS.ClinicId = CM.ClinicId
		LEFT JOIN SalesPerson SP ON LIS.SalesPersonId = SP.SalesPersonID
    )
    SELECT DISTINCT
        md.VisitNumber,
        ISNULL(md.AccessionNo,'Missing LIS Data') AS AccessionNo,
        --ISNULL(md.PanelName,'No Panel Info') AS PanelName,
		ISNULL(md.PanelName,'No Panel Info') AS PanelGroup,
        ISNULL(PayerName,'No Payer Info') AS Carrier,
        md.PayerType AS FinancialClass,
        md.BillingProvider,
        md.ReferringProvider ReferringProviderName,
        md.ChartNumber,
        md.PatientName,
		CONVERT(VARCHAR, md.PatientDOB, 101)  AS PatientDOB,	
		md.RequisitionTypeName,
		md.SalesPersonName,
		md.ClinicName,
        md.PerformingLab AS Facility,
        CONVERT(VARCHAR, md.BeginDOS, 101)  AS BeginDOS,
        DATEDIFF(DAY, md.SampleCollectedDate, GETDATE()) AS Aging,
        CASE 
            WHEN DATEDIFF(DAY, md.SampleCollectedDate, GETDATE()) <= 30 THEN 'Current'
            WHEN DATEDIFF(DAY, md.SampleCollectedDate, GETDATE()) <= 60 THEN '30 +'
            WHEN DATEDIFF(DAY, md.SampleCollectedDate, GETDATE()) <= 90 THEN '60 +'
            WHEN DATEDIFF(DAY, md.SampleCollectedDate, GETDATE()) <= 120 THEN '90 +'
            ELSE '120 +'
        END AS AgingBucket,
		CONVERT(VARCHAR, MD.ChargeEntryDate, 101)   AS AMDDOE,
		CONVERT(VARCHAR, md.FirstBillDate, 101)  AS FirstBillDate,
		CONVERT(VARCHAR, MD.ChargeEntryDate, 101)   AS ChargeEntryDate,
		CONVERT(VARCHAR, DC.DenialDate, 101)	DenialPostedDate,
		CONVERT(VARCHAR, TD.CheckDate, 101)	CheckDate,
		CONVERT(VARCHAR, TD.PaymentPostedDate, 101)	PaymentPostedDate,
		TD.CheckNumber,
        CASE WHEN md.FirstBillDate IS NOT NULL THEN 'Billed' ELSE 'Not Billed' END AS BilledNotBilled,
        POS.POS,
        TOS.TOS,
        AG.CPTCode,
        ICD.ICD10Code AS PrimaryDiagnosis,
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
		(ISNULL(BA.InsuranceAdjustment, 0.0) + ISNULL(BA.PatientAdjustment, 0.0)) TotalAdjustment,
		CASE WHEN CPS.FinalStatus = 'Fully Paid' THEN (BA.InsurancePayment + BA.PatientPaidAmount) ELSE NULL END AS FullyPaid,
        CASE WHEN CPS.FinalStatus = 'Fully Paid' THEN 'Fully Paid Count' ELSE NULL END AS FullyPaidCount,
        CASE WHEN DATEDIFF(DAY, md.SampleCollectedDate, md.FirstBillDate) <= 30 THEN '30 Days Count' ELSE NULL END AS T30DaysCount,
        CASE WHEN DATEDIFF(DAY, md.SampleCollectedDate, md.FirstBillDate) <= 30 THEN (BA.InsurancePayment + BA.PatientPaidAmount) ELSE NULL END AS T30Amount,
        CASE WHEN DATEDIFF(DAY, md.SampleCollectedDate, md.FirstBillDate) BETWEEN 31 AND 60 THEN '60 Days Count' ELSE NULL END AS T60DaysCount,
        CASE WHEN DATEDIFF(DAY, md.SampleCollectedDate, md.FirstBillDate) BETWEEN 31 AND 60 THEN (BA.InsurancePayment + BA.PatientPaidAmount) ELSE NULL END AS T60Amount,
    -- Conditionally return AdjudicatedAmount
		CASE 
			WHEN CPS.FinalStatus IN ('No Response','Unbilled','Unbilled - Client','Unbilled - Patient Balance','No Response - Client') THEN NULL
			WHEN CPS.FinalStatus = 'Fully Adjusted' AND DC.DenialCode IS NULL THEN NULL
			ELSE (BA.InsurancePayment)
		END AS AdjudicatedAmount,

		-- Conditionally return AdjudicatedCount
		CASE 
			WHEN CPS.FinalStatus IN ('No Response','Unbilled','Unbilled - Client','Unbilled - Patient Balance','No Response - Client') THEN NULL
			WHEN CPS.FinalStatus = 'Fully Adjusted' AND DC.DenialCode IS NULL THEN NULL
			ELSE 'Adjudicated Count' END
			 AdjudicatedCount,

        CPS.FinalStatus,
		CASE WHEN md.AccessionNo is null then 'Missing LIS Data' else '' end LISMissingRecord 
    FROM MainData md
	LEFT JOIN #ICDCode ICD ON md.VisitNumber = ICD.VisitNumber
    ----LEFT JOIN #TransactionMaster TM ON md.VisitNumber = TM.VisitNo
	LEFT JOIN #TransData TD ON md.VisitNumber = TD.VisitNumber
    LEFT JOIN MostFrequentFinancialClass FC ON md.VisitNumber = FC.VisitNumber AND FC.rn = 1
    LEFT JOIN MostFrequentPOS POS ON md.VisitNumber = POS.VisitNumber AND POS.rn = 1
    LEFT JOIN MostFrequentTOS TOS ON md.VisitNumber = TOS.VisitNumber AND TOS.rn = 1
    LEFT JOIN BillingAgg BA ON md.VisitNumber = BA.VisitNumber
    LEFT JOIN AggregatedCPT AG ON md.VisitNumber = AG.VisitNumber
    LEFT JOIN ClaimsLevelStatus CPS ON md.VisitNumber = CPS.VisitNumber
    LEFT JOIN #DenialCode DC ON md.VisitNumber = DC.VisitNumber AND DC.DenialCode IS NOT NULL
    WHERE md.rn = 1 order by FirstBillDate 

    DROP TABLE IF EXISTS #BillingMasterTemp, #TransactionMaster, #DenialCode;
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
		RecordId,
		ISNULL(AccessionNo,'MISSING ACCESSION#') AccessionNo,
		RequistionType RequisitionType,
		FacilityState,
		RelationshipToInsurance,
		ReferringProviderName ReferringProviderName,
		FacilityCity,
		FacilityZipcode,
		[Time],
		FacilityAddress ClinicAddress,
		FacilityName ClinicName,
		StatusCode SampleStatus,
		PrimaryMemberId PolicyId,
		PrimaryGroupNo GroupId,
		CASE WHEN TRIM(UPPER(PanelCode)) = 'TOX' THEN 'Toxicology' ELSE PanelCode END PanelGroup,
		--Panel PanelName,
		ReferenceId,
		LabCode,
		[Address] PatientAddress,
		Medications,
		ICD10Code,
		Email,City,Gender,
		[FacilityState] ClinicState,
		TransferToLab,
		PatientEthnicity,
		lis.FirstName,
		lis.LastName,
		PatientName,
		PatientDOB,
		Race,
		SalesPersonName,
		CONVERT(varchar(10), SampleReceivedDate, 101) SampleReceivedDate,
		CONVERT(varchar(10), SampleCollectedDate, 101) SampleCollectedDate,
		CONVERT(varchar(10), SampleResultedDate, 101) SampleResultedDate,
		PrimaryPayerName,
		InsuranceType BilledTo,
		CASE WHEN DaystoReceive = 0 THEN 1 ELSE DaystoReceive END DaystoReceive ,
        CASE WHEN DaystoResult = 0 THEN 1 ELSE DaystoResult END DaystoResult  ,
        CASE WHEN DaystoBill = 0 THEN 1 ELSE DaystoBill END DaystoBill ,
        VisitNumber,
       CASE 
		WHEN ResultedStatus = 'Resulted' AND BillingStatus = 'Not Billed' 
        AND BillingSubStatus = 'Resulted Yet to Billed' AND ISNULL(ClientStatus,'') <> '' 
		THEN ClientStatus  ELSE BillingSubStatus END AS BillingSubStatus,
        LIS.BillingStatus,
		CONVERT(VARCHAR, LIS.[FirstBilledDate], 101) [FirstBilledDate],
		CONVERT(VARCHAR, LIS.ChargeEntryDate, 101) ChargeEntryDate,
		ClientStatus,
		ResultedStatus,
		NewStatus
       
    FROM LISMaster LIS
	--LEFT JOIN RequisitionTypes RT on Lis.RequistionTypeId = rt.RequisitionTypeId
	--LEFT JOIN ReferringProviderMaster rpm on lis.ReferringProviderId = rpm.ReferingProviderId
	LEFT JOIN BillingProviderMaster bpm on lis.BillingProviderID = bpm.BillingProviderID
	--LEFT JOIN SalesPerson sp on lis.SalesPersonId = sp.SalesPersonID
    --LEFT JOIN SpecimenStatus SS ON LIS.SampleStatusId = SS.SpecimenStatusId 
    --LEFT JOIN ClinicMaster CM ON LIS.ClinicId = CM.ClinicId
    --LEFT JOIN PayerTypeMaster PT ON LIS.PayerTypeId = PT.PayerTypeId

    --LEFT JOIN OperationsGroupMaster OG ON LIS.OperationalGroupId = OG.OperationGroupID 
    --LEFT JOIN TestTypeMaster TT ON LIS.TestTypeId = TT.TestTypeId
    --LEFT JOIN PanelGroup PG ON LIS.PanelId = PG.PanelGroupId
    WHERE 
        CAST(SampleCollectedDate AS DATE) BETWEEN @ActualStartDate AND @ActualEndDate
		;
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

DROP TABLE IF EXISTS #DenialCodeMaster;
SELECT 
    VisitNumber,CPTCodes,DBO.[GetDenailCodeByVisitCPT](VisitNumber,CPTCodes) AS PaymentReasonCodes,MAX(PaymentDate) AS MostRecentDenialPostingDate
	INTO #DenialCodeMaster
FROM DenialTrackingMaster
WHERE PaymentReasonCode IS NOT NULL
GROUP BY VisitNumber,CPTCodes ORDER BY VisitNumber

CREATE NONCLUSTERED INDEX IX_VisitNumber ON #DenialCodeMaster (VisitNumber,CPTCodes);

    SELECT  
        ISNULL(UPPER(b.AccessionNo),'Missing LIS Info') AccessionNo,
        b.VisitNumber,
        b.CPTCode,
        b.PatientName,
		RT.RequisitionTypeName,
		CAST(B.PatientDOB AS DATE) AS  PatientDOB, 
        PanelCarrier PayerName,
        PayerType,
        BillingProvider,
		CAST(BeginDOS AS DATE) AS   BeginDOS,
		CAST(EndDOS AS DATE) AS   EndDOS,
		CAST(b.ChargeEntryDate AS DATE) AS    ChargeEntryDate,
		CAST(FirstBillDate AS DATE) AS      FirstBillDate,
		COALESCE(b.PanelName, l.PanelCode, 'No Panel Located') AS PanelGroup,
		POS,TOS,
        b.ICD10Code,
        b.Units,
		CAST(CheckDate AS DATE) AS      CheckDate,
		CAST(PaymentPostedDate AS DATE) AS    PaymentPostedDate,
		CAST(dt.MostRecentDenialPostingDate AS DATE) AS     DenialPostedDate,
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
		PerformingLab Facility,
		cm.ClinicName,
		SP.SalesPersonName,
		--og.OperationsGroup,
		--tt.TestTypeName TestType,
		ReferringProvider ReferringProviderName,
		b.BillingSubStatus,
		CASE WHEN b.AccessionNo is null then 'Missing LIS Data' else '' end LISMissingRecord 
    FROM BillingMaster b
    LEFT JOIN LISMaster l ON b.AccessionNo = l.AccessionNo AND l.StatusCode <> 'DELETED'
	LEFT JOIN #DenialCodeMaster dt on b.VisitNumber = dt.VisitNumber AND b.CPTCode = dt.CPTCodes
	LEFT JOIN RequisitionTypes RT on l.RequistionTypeId = RT.RequisitionTypeId
    --LEFT JOIN OperationsGroupMaster OG ON l.OperationalGroupId = OG.OperationGroupID 
    --LEFT JOIN TestTypeMaster TT ON l.TestTypeId = TT.TestTypeId
	LEFT JOIN SalesPerson SP ON L.SalesPersonId = SP.SalesPersonID
	LEFT JOIN ClinicMaster CM ON l.ClinicId = CM.ClinicId

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

			WITH CTE_TransDate AS(
		SELECT VisitNumber,ROW_NUMBER() OVER (
					PARTITION BY VisitNumber
					ORDER BY CheckDate DESC, PaymentPostedDate DESC
				) AS rn,
				CheckDate,PaymentPostedDate,CheckNumber FROM BillingMaster where CheckDate is not null
				) SELECT VisitNumber,CheckDate,PaymentPostedDate,CheckNumber INTO #TransData FROM CTE_TransDate Where rn = 1 ;

				  CREATE NONCLUSTERED INDEX IX_VisitNumber_TR ON #TransData (VisitNumber);
    -- Temp tables
    SELECT * INTO #BillingMasterTemp 
    FROM BillingMaster WITH (NOLOCK)
    WHERE (@FromDate IS NULL OR FirstBillDate >= @FromDate) 
      AND (@ToDate IS NULL OR FirstBillDate <= @ToDate);

	  Select distinct VisitNumber,DBO.GetUniqueICD10Codes(VisitNumber) ICD10Code INTO #ICDCode from BillingMaster 

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
    CREATE NONCLUSTERED INDEX IX_VisitNumber_ICD ON #ICDCode (VisitNumber);  

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
        BM.PanelCarrier PayerName,
        BM.PayerType,
        BM.BillingProvider,
		BM.AccessionNo,
        -- Window function instead of MIN()
        MIN(BM.BeginDOS) OVER (PARTITION BY BM.VisitNumber) AS BeginDOS,
		MIN(BM.ChargeEntryDate) OVER (PARTITION BY BM.VisitNumber) AS ChargeEntryDate,
		--MAX(BM.CheckDate) OVER (PARTITION BY BM.VisitNumber) AS CheckDate,
		--MAX(BM.PaymentPostedDate) OVER (PARTITION BY BM.VisitNumber) AS PaymentPostedDate,
		BM.PatientDOB,
		BM.PatientName,
		BM.ChartNumber,
		BM.ResponsibleParty,
        BM.FirstBillDate,
        BM.TOS,
        TT.TestTypeName AS TestType,
        CM.ClinicName,
        LIS.SampleCollectedDate,
        BM.ReferringProvider,
       	COALESCE(BM.PanelName, LIS.PanelCode, 'No Panel Located') AS PanelName,
		BM.PerformingLab,SP.SalesPersonName,	rt.RequisitionTypeName,
        ROW_NUMBER() OVER (
            PARTITION BY BM.VisitNumber 
              ORDER BY 
                CASE WHEN BM.FirstBillDate IS NULL THEN 1 ELSE 0 END,  -- push NULLs last
                BM.FirstBillDate
        ) AS rn
    FROM BillingMaster BM
    LEFT JOIN LISMaster LIS WITH (NOLOCK) 
        ON BM.AccessionNo = LIS.AccessionNo
    LEFT JOIN TestTypeMaster TT 
        ON LIS.TestTypeId = TT.TestTypeId
   		LEFT JOIN RequisitionTypes rt ON LIS.RequistionTypeId = rt.RequisitionTypeId
		LEFT JOIN ClinicMaster CM ON LIS.ClinicId = CM.ClinicId
		LEFT JOIN SalesPerson SP ON LIS.SalesPersonId = SP.SalesPersonID
    )
    SELECT DISTINCT
        md.VisitNumber,
        ISNULL(md.AccessionNo,'Missing LIS Data') AS AccessionNo,
        --ISNULL(md.PanelName,'No Panel Info') AS PanelName,
		ISNULL(md.PanelName,'No Panel Info') AS PanelGroup,
        ISNULL(PayerName,'No Payer Info') AS Carrier,
        md.PayerType AS FinancialClass,
        md.BillingProvider,
        md.ReferringProvider ReferringProviderName,
        md.ChartNumber,
        md.PatientName,
		CONVERT(VARCHAR, md.PatientDOB, 101)  AS PatientDOB,	
		md.RequisitionTypeName,
		md.SalesPersonName,
		md.ClinicName,
        md.PerformingLab AS Facility,
        CONVERT(VARCHAR, md.BeginDOS, 101)  AS BeginDOS,
        DATEDIFF(DAY, md.SampleCollectedDate, GETDATE()) AS Aging,
        CASE 
            WHEN DATEDIFF(DAY, md.SampleCollectedDate, GETDATE()) <= 30 THEN 'Current'
            WHEN DATEDIFF(DAY, md.SampleCollectedDate, GETDATE()) <= 60 THEN '30 +'
            WHEN DATEDIFF(DAY, md.SampleCollectedDate, GETDATE()) <= 90 THEN '60 +'
            WHEN DATEDIFF(DAY, md.SampleCollectedDate, GETDATE()) <= 120 THEN '90 +'
            ELSE '120 +'
        END AS AgingBucket,
		CONVERT(VARCHAR, MD.ChargeEntryDate, 101)   AS AMDDOE,
		CONVERT(VARCHAR, md.FirstBillDate, 101)  AS FirstBillDate,
		CONVERT(VARCHAR, MD.ChargeEntryDate, 101)   AS ChargeEntryDate,
		CONVERT(VARCHAR, DC.DenialDate, 101)	DenialPostedDate,
		CONVERT(VARCHAR, TD.CheckDate, 101)	CheckDate,
		CONVERT(VARCHAR, TD.PaymentPostedDate, 101)	PaymentPostedDate,
		TD.CheckNumber,
        CASE WHEN md.FirstBillDate IS NOT NULL THEN 'Billed' ELSE 'Not Billed' END AS BilledNotBilled,
        POS.POS,
        TOS.TOS,
        AG.CPTCode,
        ICD.ICD10Code AS PrimaryDiagnosis,
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
		(ISNULL(BA.InsuranceAdjustment, 0.0) + ISNULL(BA.PatientAdjustment, 0.0)) TotalAdjustment,
		CASE WHEN CPS.FinalStatus = 'Fully Paid' THEN (BA.InsurancePayment + BA.PatientPaidAmount) ELSE NULL END AS FullyPaid,
        CASE WHEN CPS.FinalStatus = 'Fully Paid' THEN 'Fully Paid Count' ELSE NULL END AS FullyPaidCount,
        CASE WHEN DATEDIFF(DAY, md.SampleCollectedDate, md.FirstBillDate) <= 30 THEN '30 Days Count' ELSE NULL END AS T30DaysCount,
        CASE WHEN DATEDIFF(DAY, md.SampleCollectedDate, md.FirstBillDate) <= 30 THEN (BA.InsurancePayment + BA.PatientPaidAmount) ELSE NULL END AS T30Amount,
        CASE WHEN DATEDIFF(DAY, md.SampleCollectedDate, md.FirstBillDate) BETWEEN 31 AND 60 THEN '60 Days Count' ELSE NULL END AS T60DaysCount,
        CASE WHEN DATEDIFF(DAY, md.SampleCollectedDate, md.FirstBillDate) BETWEEN 31 AND 60 THEN (BA.InsurancePayment + BA.PatientPaidAmount) ELSE NULL END AS T60Amount,
    -- Conditionally return AdjudicatedAmount
		CASE 
			WHEN CPS.FinalStatus IN ('No Response','Unbilled','Unbilled - Client','Unbilled - Patient Balance','No Response - Client') THEN NULL
			WHEN CPS.FinalStatus = 'Fully Adjusted' AND DC.DenialCode IS NULL THEN NULL
			ELSE (BA.InsurancePayment)
		END AS AdjudicatedAmount,

		-- Conditionally return AdjudicatedCount
		CASE 
			WHEN CPS.FinalStatus IN ('No Response','Unbilled','Unbilled - Client','Unbilled - Patient Balance','No Response - Client') THEN NULL
			WHEN CPS.FinalStatus = 'Fully Adjusted' AND DC.DenialCode IS NULL THEN NULL
			ELSE 'Adjudicated Count' END
			 AdjudicatedCount,

        CPS.FinalStatus,
		CASE WHEN md.AccessionNo is null then 'Missing LIS Data' else '' end LISMissingRecord 
    FROM MainData md
	LEFT JOIN #ICDCode ICD ON md.VisitNumber = ICD.VisitNumber
    ----LEFT JOIN #TransactionMaster TM ON md.VisitNumber = TM.VisitNo
	LEFT JOIN #TransData TD ON md.VisitNumber = TD.VisitNumber
    LEFT JOIN MostFrequentFinancialClass FC ON md.VisitNumber = FC.VisitNumber AND FC.rn = 1
    LEFT JOIN MostFrequentPOS POS ON md.VisitNumber = POS.VisitNumber AND POS.rn = 1
    LEFT JOIN MostFrequentTOS TOS ON md.VisitNumber = TOS.VisitNumber AND TOS.rn = 1
    LEFT JOIN BillingAgg BA ON md.VisitNumber = BA.VisitNumber
    LEFT JOIN AggregatedCPT AG ON md.VisitNumber = AG.VisitNumber
    LEFT JOIN ClaimsLevelStatus CPS ON md.VisitNumber = CPS.VisitNumber
    LEFT JOIN #DenialCode DC ON md.VisitNumber = DC.VisitNumber AND DC.DenialCode IS NOT NULL
    WHERE md.rn = 1 order by FirstBillDate 

    DROP TABLE IF EXISTS #BillingMasterTemp, #TransactionMaster, #DenialCode;
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
SELECT DISTINCT UPPER(LTRIM(RTRIM(FacilityName))),1 FROM LISStaging 
WHERE UPPER(LTRIM(RTRIM(FacilityName))) NOT IN (SELECT DISTINCT ClinicName FROM [ClinicMaster]) AND FacilityName	 IS NOT NULL

PRINT '[ClinicMaster] Inserted Completed'


INSERT INTO [dbo].RequisitionTypes(RequisitionTypeName)
SELECT DISTINCT LTRIM(RTRIM(RequistionType)) FROM LISStaging 
WHERE LTRIM(RTRIM(RequistionType)) NOT IN (SELECT DISTINCT RequisitionTypeName FROM RequisitionTypes) AND RequistionType IS NOT NULL

PRINT '[RequistionType] Inserted Completed'



INSERT INTO [dbo].States(StateName)
SELECT DISTINCT LTRIM(RTRIM(FacilityState)) FROM LISStaging 
WHERE UPPER(LTRIM(RTRIM(FacilityState))) NOT IN (SELECT DISTINCT StateName FROM States) AND FacilityState IS NOT NULL

PRINT '[States] Inserted Completed'


INSERT INTO [dbo].Cities(CityName)
SELECT DISTINCT LTRIM(RTRIM(FacilityCity)) FROM LISStaging 
WHERE UPPER(LTRIM(RTRIM(FacilityCity))) NOT IN (SELECT DISTINCT CityName FROM Cities) AND FacilityCity IS NOT NULL

PRINT '[Cities] Inserted Completed'


INSERT INTO [dbo].InsuranceRelationships(RelationshipName)
SELECT DISTINCT LTRIM(RTRIM(RelationshipToInsured)) FROM LISStaging 
WHERE LTRIM(RTRIM(RelationshipToInsured)) NOT IN (SELECT DISTINCT RelationshipName FROM InsuranceRelationships) AND RelationshipToInsured IS NOT NULL

PRINT '[InsuranceRelationships] Inserted Completed'

 
 INSERT INTO [dbo].Panels(PanelName)
SELECT DISTINCT LTRIM(RTRIM(Panel)) FROM LISStaging 
WHERE LTRIM(RTRIM(Panel)) NOT IN (SELECT DISTINCT PanelName FROM Panels) AND Panel IS NOT NULL

PRINT '[Panels] Inserted Completed'


 INSERT INTO [dbo].Medications(MedicationName)
SELECT DISTINCT LTRIM(RTRIM(Medications)) FROM LISStaging 
WHERE LTRIM(RTRIM(Medications)) NOT IN (SELECT DISTINCT MedicationName FROM Medications) AND Medications IS NOT NULL

PRINT '[Medications] Inserted Completed'

 INSERT INTO [dbo].Genders(GenderName)
SELECT DISTINCT LTRIM(RTRIM(Gender)) FROM LISStaging 
WHERE LTRIM(RTRIM(Gender)) NOT IN (SELECT DISTINCT GenderName FROM Genders) AND Gender IS NOT NULL

PRINT '[Genders] Inserted Completed'


 INSERT INTO [dbo].SpecimenStatus(SpecimenStatusName)
SELECT DISTINCT LTRIM(RTRIM(Status)) FROM LISStaging 
WHERE LTRIM(RTRIM(Status)) NOT IN (SELECT DISTINCT SpecimenStatusName FROM SpecimenStatus) AND Status IS NOT NULL

PRINT '[SpecimenStatus] Inserted Completed'


 INSERT INTO [dbo].Races(RaceName)
SELECT DISTINCT LTRIM(RTRIM(Race)) FROM LISStaging 
WHERE LTRIM(RTRIM(Race)) NOT IN (SELECT DISTINCT RaceName FROM Races) AND Race IS NOT NULL

PRINT '[Races] Inserted Completed'

INSERT INTO [dbo].ReferringProviderMaster([ReferringProviderName],IsActive)
SELECT DISTINCT UPPER(LTRIM(RTRIM(PhysicianName))),1 FROM LISStaging 
WHERE UPPER(LTRIM(RTRIM(PhysicianName))) NOT IN (SELECT DISTINCT [ReferringProviderName] FROM ReferringProviderMaster) AND PhysicianName IS NOT NULL

PRINT '[ReferringProviderMaster] Inserted Completed'


INSERT INTO [dbo].ICDCodeMaster([ICD10Code],IsActive)
SELECT DISTINCT UPPER(LTRIM(RTRIM(ICDCodes))),1 FROM LISStaging 
WHERE UPPER(LTRIM(RTRIM(ICDCodes))) NOT IN (SELECT DISTINCT [ICD10Code] FROM ICDCodeMaster) AND ICDCodes IS NOT NULL

PRINT '[ICDCodeMaster] Inserted Completed'


INSERT INTO [dbo].SalesPerson([FirstName],LastName,SalesPersonName,Status,ReportingLevelTop)
SELECT DISTINCT UPPER(LTRIM(RTRIM(SaleRepName))),UPPER(LTRIM(RTRIM(SaleRepName))),UPPER(LTRIM(RTRIM(SaleRepName))),1,1 FROM LISStaging 
WHERE UPPER(LTRIM(RTRIM(SaleRepName))) NOT IN (SELECT DISTINCT SalesPersonName FROM SalesPerson) AND SaleRepName IS NOT NULL

PRINT '[SaleRepName] Inserted Completed'


INSERT INTO [dbo].PayerTypeMaster(PayerType)
SELECT DISTINCT UPPER(LTRIM(RTRIM(Insurance_Type))) FROM LISStaging 
WHERE UPPER(LTRIM(RTRIM(Insurance_Type))) NOT IN (SELECT DISTINCT PayerType FROM PayerTypeMaster) AND Insurance_Type IS NOT NULL

PRINT '[PayerTypeMaster] Inserted Completed'


INSERT INTO [dbo].[InsurancePayerMaster]([PayerName],[IsActive])
SELECT DISTINCT LTRIM(RTRIM(PrimaryInsuranceProvider)),1 FROM LISStaging 
WHERE UPPER(LTRIM(RTRIM(PrimaryInsuranceProvider))) NOT IN (SELECT DISTINCT [PayerName] FROM [InsurancePayerMaster]) AND PrimaryInsuranceProvider IS NOT NULL

PRINT '[InsurancePayerMaster] Inserted Completed'


INSERT INTO [dbo].[InsurancePayerMaster]([PayerName],[IsActive])
SELECT DISTINCT LTRIM(RTRIM(PayerName)),1 FROM CustomCollectionStaging 
WHERE UPPER(LTRIM(RTRIM(PayerName))) NOT IN (SELECT DISTINCT [PayerName] FROM [InsurancePayerMaster]) AND PayerName IS NOT NULL

PRINT '[InsurancePayerMaster] Inserted Completed'

 
 INSERT INTO [dbo].PayerTypeMaster([PayerType],[IsActive])
SELECT DISTINCT LTRIM(RTRIM(PayerType)),1 FROM CustomCollectionStaging 
WHERE UPPER(LTRIM(RTRIM(PayerType))) NOT IN (SELECT DISTINCT [PayerType] FROM PayerTypeMaster) AND PayerType IS NOT NULL

PRINT '[InsurancePayerMaster] Inserted Completed'

 INSERT INTO [dbo].ReferringProviderMaster([ReferringProviderName],[IsActive])
SELECT DISTINCT LTRIM(RTRIM(ReferringProvider)),1 FROM CustomCollectionStaging 
WHERE UPPER(LTRIM(RTRIM(ReferringProvider))) NOT IN (SELECT DISTINCT [ReferringProviderName] FROM ReferringProviderMaster) AND ReferringProvider IS NOT NULL

PRINT '[InsurancePayerMaster] Inserted Completed'

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

--PRINT '[LabMaster] Inserted Completed'

 

--DROP TABLE IF EXISTS #CPTCodes;
--SELECT DISTINCT LTRIM(RTRIM(SUBSTRING(BilledCPTCode, 0, 6))) CPTCode,LTRIM(RTRIM(SUBSTRING(BilledCPTCode, 6, LEN(BilledCPTCode)))) CodeDescription,
--BilledCPTCode OriginalCode INTO #CPTCodes FROM CustomCollectionStaging WHERE BilledCPTCode IS NOT NULL

--INSERT INTO [dbo].CPTCodeMaster(CPTCode,CodeDescription,OriginalCode,[IsActive])
--SELECT CPTCode,CodeDescription,OriginalCode,1 FROM #CPTCodes
--WHERE CPTCode NOT IN (SELECT DISTINCT CPTCode FROM CPTCodeMaster) 

--PRINT '[CPTCodeMaster] Inserted Completed'



--DROP TABLE IF EXISTS #ICD10Codes;
--SELECT DISTINCT   LTRIM(RTRIM(LEFT(ICD10Code, CHARINDEX('-', ICD10Code) - 1))) ICD10Code,
--LTRIM(RTRIM(SUBSTRING(ICD10Code, CHARINDEX('-', ICD10Code) + 1, LEN(ICD10Code)))) CodeDescription , ICD10Code AS [OriginalCode]
--INTO #ICD10Codes FROM CustomCollectionStaging WHERE  LTRIM(RTRIM(ICD10Code)) IS NOT NULL


--INSERT INTO [dbo].ICDCodeMaster(ICD10Code,CodeDescription,OriginalCode)
--SELECT ICD10Code,CodeDescription,[OriginalCode] FROM #ICD10Codes WHERE ICD10Code NOT IN (SELECT DISTINCT ICD10Code FROM ICDCodeMaster)

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
/****** Object:  StoredProcedure [dbo].[sp_LIS_PanelUpdate]******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[sp_LIS_PanelUpdate]
AS
BEGIN
    SET NOCOUNT ON;
    SET XACT_ABORT ON;

    ----------------------------------------------------------------
    -- 1) Build a cleaned, de-duped PanelCode from LISMaster.Panel
    --    - removes literal "(Specimen Source)"
    --    - trims each token
    --    - removes empty tokens
    --    - de-dupes while preserving first-seen order
    ----------------------------------------------------------------
    ;WITH Split AS
    (
        SELECT
            t.LISMasterId,
            CleanValue = NULLIF(LTRIM(RTRIM(REPLACE(s.value, '(Specimen Source)', ''))), ''),
            s.ordinal
        FROM dbo.LISMaster AS t
        CROSS APPLY STRING_SPLIT(t.Panel, ',', 1) AS s   -- 1 => with ordinal
    ),
    Dedup AS
    (
        SELECT
            LISMasterId,
            CleanValue,
            MinOrd = MIN(ordinal)
        FROM Split
        WHERE CleanValue IS NOT NULL
        GROUP BY LISMasterId, CleanValue
    ),
    Agg AS
    (
        SELECT
            LISMasterId,
            CleanedPanel = STRING_AGG(CleanValue, ',') WITHIN GROUP (ORDER BY MinOrd)
        FROM Dedup
        GROUP BY LISMasterId
    )
    UPDATE t
    SET t.PanelCode = a.CleanedPanel
    FROM dbo.LISMaster AS t
    INNER JOIN Agg AS a
        ON a.LISMasterId = t.LISMasterId;

    ----------------------------------------------------------------
    -- 2) Temp tables for Infectious Disease rules
    ----------------------------------------------------------------
    DROP TABLE IF EXISTS #LISTemp;
    DROP TABLE IF EXISTS #PanelList;
    DROP TABLE IF EXISTS #PanelChange;

    -- Accession + raw panel string (only rows that have Panel)
    SELECT DISTINCT
        AccessionNo,
        PanelCode AS OriginalPanel
    INTO #LISTemp
    FROM dbo.LISMaster
    WHERE Panel IS NOT NULL;

    -- Split panel into multiple rows (trim and drop empties)
    SELECT
        ls.AccessionNo,
        PanelName   = TRIM(s.value),
        ls.OriginalPanel
    INTO #PanelList
    FROM #LISTemp AS ls
    CROSS APPLY STRING_SPLIT(ls.OriginalPanel, ',') AS s
    WHERE TRIM(s.value) <> '';

    -- Count number of split panels per accession/original panel
    SELECT
        AccessionNo,
        OriginalPanel,
        PanelCount = COUNT(*)
    INTO #PanelChange
    FROM #PanelList
    GROUP BY AccessionNo, OriginalPanel;

    ----------------------------------------------------------------
    -- 3) Requisition-type based overrides
    ----------------------------------------------------------------
    -- Map Hereditary groups to CGX (but not Infectious Disease)
    UPDATE lis
    SET lis.PanelCode =
        CASE WHEN rt.RequisitionTypeName IN ('Hereditary Cancer', 'Hereditary Metabolic Disorders')
             THEN 'CGX'
             ELSE rt.RequisitionTypeName
        END
    FROM dbo.LISMaster AS lis
    INNER JOIN dbo.RequisitionTypes AS rt
        ON lis.RequistionTypeId = rt.RequisitionTypeId
    WHERE rt.RequisitionTypeName <> 'Infectious Disease';

    -- Infectious Disease: set UTI explicitly, otherwise keep existing / mark Unable to Locate for NULL
    UPDATE lis
    SET lis.PanelCode =
        CASE
            WHEN lis.Panel = 'UTI' THEN 'UTI'
            WHEN lis.Panel IS NULL THEN 'Unable to Locate'
            ELSE lis.PanelCode
        END
    FROM dbo.LISMaster AS lis
    INNER JOIN dbo.RequisitionTypes AS rt
        ON lis.RequistionTypeId = rt.RequisitionTypeId
    WHERE rt.RequisitionTypeName = 'Infectious Disease';

    -- Infectious Disease: if more than 3 components after split, force 'Infectious Disease'
    UPDATE lis
    SET lis.PanelCode = 'Infectious Disease'
    FROM dbo.LISMaster AS lis
    INNER JOIN #PanelChange AS pc
        ON pc.AccessionNo = lis.AccessionNo
       AND pc.PanelCount > 3
    INNER JOIN dbo.RequisitionTypes AS rt
        ON lis.RequistionTypeId = rt.RequisitionTypeId
    WHERE rt.RequisitionTypeName = 'Infectious Disease';

    ----------------------------------------------------------------
    -- 4) Final normalization pass on PanelCode
    ----------------------------------------------------------------
    -- Common synonyms / abbreviations
    UPDATE dbo.LISMaster
    SET PanelCode = CASE
        WHEN LTRIM(RTRIM(PanelCode)) = 'Respiratory Pathogen Panel (RPP)' THEN 'RPP'
        WHEN LTRIM(RTRIM(PanelCode)) = 'Women''s Health qPCR Panel'        THEN 'Womens Health'
        WHEN LTRIM(RTRIM(PanelCode)) IN ('QA', 'QA Test Add Panel Functionality') THEN 'Test Panel'
        WHEN LTRIM(RTRIM(PanelCode)) = 'Gastrointestinal GI'               THEN 'GI'
		--WHEN LTRIM(RTRIM(PanelCode)) = 'Neurocognitive'               THEN 'CGX'
        ELSE PanelCode
    END;

    UPDATE dbo.LISMaster
    SET PanelCode = 'Toxicology'
    WHERE TRIM(UPPER(PanelCode)) = 'TOX';
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
                AND LTRIM(RTRIM(SheetName)) IN (
                    'To Bill', 'Medicare On Hold', 'MO Medicaid On Hold', 
                    'Missing Info', 'PGX', 'Paid', 'Billed'
                )
                AND ImportedFileID = @FileId
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
			AND PaymentReasonCode IS NOT NULL
			AND NOT (
			';' + PaymentReasonCode + ';' LIKE '%;CO45;%'
			OR	';' + PaymentReasonCode + ';' LIKE '%;CO253;%'
			OR	';' + PaymentReasonCode + ';' LIKE '%;PR1;%'
			OR	';' + PaymentReasonCode + ';' LIKE '%;PR2;%'
			OR	';' + PaymentReasonCode + ';' LIKE '%;PR3;%');

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
		BillingSubStatus = ClaimSubStatus
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
	
	IF @FileId IS NULL
		SET @FileId = (SELECT TOP 1 ImportedFileID FROM LISStaging ORDER BY ImportedFileID DESC)

		 update ImportedFiles set FileStatus = 3,ProcessedOn = GETDATE() where ImportedFileID = @FileId; 

drop table if exists #LISmaster;

SELECT DISTINCT [RecordId]
      ,UPPER(LTRIM(RTRIM([AccessionNo]))) [AccessionNo]
      ,RT.RequisitionTypeId
      ,[FacilityState]
      ,[RelationshipToInsured]
	  ,RP.ReferingProviderId
      ,[ReceivedDate]
      ,[FacilityCity]
      ,[FacilityZipcode]
      ,[Time]
      ,[FacilityAddress]
      ,[PolicyId]
      ,[GroupId]
      ,[Panel]
      ,[ReferenceId]
      ,[Validated_Date]
      ,[PolicyHolderDOB]
      ,[Address]
      ,[Medications]
	  ,CM.ClinicId
      ,[ICDCodes]
      ,[Email]
      ,[City]
      ,[Gender]
      ,[DateOfCollection]
      ,[NPI]
      ,[State]
      ,[DOB]
      ,[DateofService]
      ,[TransferTo]
      ,[PatientEthnicity]
	  ,SP.SalesPersonID
      ,LIS.[FirstName]
      ,SS.SpecimenStatusId
      ,LIS.[PrimaryInsuranceProvider]
      ,[ZipCode]
      ,[Race]
	  ,RequistionType
      ,LIS.[LastName]
      ,[LabCode]
      ,pt.PayerTypeId
	  ,Insurance_Type,LIS.[Status],PhysicianName,FacilityName,SaleRepName,
	 TRIM((LIS.[LastName]+LIS.[FirstName]+'_'+ CAST(FORMAT([DateOfCollection], 'MMddyyyy')AS VARCHAR)))+'/'+LIS.[Status]+'_'+ISNULL(RecordId,AccessionNo)  IdentityValue
	  INTO #LISmaster
    FROM LISStaging LIS
	LEFT JOIN RequisitionTypes RT ON LTRIM(RTRIM(LIS.RequistionType)) = RT.RequisitionTypeName
	LEFT JOIN ReferringProviderMaster RP ON UPPER(LTRIM(RTRIM(LIS.PhysicianName))) = RP.ReferringProviderName
	LEFT JOIN ClinicMaster CM ON UPPER(LTRIM(RTRIM(LIS.FacilityName))) = CM.ClinicName

	LEFT JOIN SalesPerson SP ON UPPER(LTRIM(RTRIM(LIS.SaleRepName))) = SP.SalesPersonName
    LEFT JOIN SpecimenStatus SS  ON LIS.Status   = SS.SpecimenStatusName
	LEFT JOIN PayerTypeMaster PT ON UPPER(LTRIM(RTRIM(LIS.Insurance_Type))) = PT.PayerType

	WHERE (LIS.ImportedFileID = @FileId OR @FileId IS NULL);




        /*******************************************************************************************
         Step 1: Insert new records from LISStaging to LISMaster 
         - Only insert records where AccessionNo doesn't already exist in LISMaster
         - Filter out records with status 'Cancelled' or 'Rejected'
        ********************************************************************************************/
		Truncate table [LISMaster];

		INSERT INTO [dbo].[LISMaster]
		([AccessionNo],[LabId],[RecordId],[RequistionTypeId],[RelationshipToInsurance],[FacilityState],[ReferringProviderId],[SampleReceivedDate],[FacilityCity]
		,[FacilityZipcode],[Time],[FacilityAddress],[Panel],[ReferenceId],[SampleResultedDate],[PolicyHolderDOB],[Address],[Medications],[ClinicId],[ICD10Code]
		,[Email],[City],[Gender],[SampleCollectedDate],[NPI],[State],[PatientDOB],[TransferToLab],[PatientEthnicity],[SalesPersonId]
		,[FirstName],[SampleStatusId],[PrimaryPayerName],[PrimaryMemberId],[PrimaryGroupNo],[ZipCode],[Race],[LastName],[LabCode],[PayerTypeId]
		,[PatientName],[BilledTo],[PanelName],[CreatedOn],[CreatedBy],StatusCode,InsuranceType,ReferringProviderName,AccessionIdentity,FacilityName,
		SalesPersonName,RequistionType)
	
		SELECT AccessionNo,4,RecordId,RequisitionTypeId,RelationshipToInsured,FacilityState,ReferingProviderId,ReceivedDate,FacilityCity,
		FacilityZipcode,Time,FacilityAddress,Panel,ReferenceId,Validated_Date,PolicyHolderDOB,Address,Medications,ClinicId,ICDCodes,
		Email,City,Gender,DateOfCollection,NPI,SpecimenStatusId,DOB,TransferTo,PatientEthnicity,SalesPersonID,
		UPPER(LTRIM(RTRIM(FirstName))),SpecimenStatusId,PrimaryInsuranceProvider,PolicyId,GroupId,ZipCode,Race,UPPER(LTRIM(RTRIM(LastName))),LabCode,PayerTypeId,
		UPPER(LTRIM(RTRIM(LastName + ',' + FirstName))),Insurance_Type,Panel,GETDATE(),'SYSTEM_USER',TRIM(UPPER([Status])),
		TRIM(UPPER(Insurance_Type)),TRIM(UPPER(PhysicianName)),IdentityValue,FacilityName,SaleRepName,RequistionType
		FROM #LISmaster LIS 

		
		/* 1) Example insert from your staging/raw table (rename columns/tables as needed) */
		-- INSERT INTO dbo.LISMaster (AccessionNo, SampleCollectedDate, SampleResultedDate, SampleReceivedDate, StatusCode, ...other cols...)
		-- SELECT AccessionNo, SampleCollectedDate, SampleResultedDate, SampleReceivedDate, StatusCode, ...other cols...
		-- FROM dbo.LIS_RawImport
		-- WHERE <your filters, e.g., current file batch, etc.>;

		-- If you already inserted, skip step 1.

		/* 2) Compute "latest" per (AccessionNo, StatusCode)
			  MaxSampleDate = greatest of Resulted / Received / Collected
			  Then rank descending and mark duplicates.
		*/

		/*
		if there are identical accession numbers within the raw report with same order status
		Insert both the line items in the LIS master report
		Mark the latest sample by collection date or received date or resulted date mark the second line item as duplicate in the billing sub status
		*/

		;WITH Ranked AS
		(
			SELECT
				LMId   = lm.LISMasterId,          
				lm.StatusCode,
				-- Greatest-of-3 using VALUES + MAX
				MaxSampleDate = (
					SELECT MAX(v.d)
					FROM (VALUES (lm.SampleResultedDate),
								 (lm.SampleReceivedDate),
								 (lm.SampleCollectedDate)) AS v(d)
				),
				lm.SampleResultedDate,
				lm.SampleReceivedDate,
				lm.SampleCollectedDate
			FROM dbo.LISMaster lm
		),
		R AS
		(
			SELECT
				LMId,
				StatusCode,
				MaxSampleDate,
				rn = ROW_NUMBER() OVER (
						PARTITION BY LMId,StatusCode
						ORDER BY
							MaxSampleDate DESC,                 -- newest first
							ISNULL(SampleResultedDate,'1900-01-01') DESC,  -- stable tie-breakers
							ISNULL(SampleReceivedDate,'1900-01-01') DESC,
							ISNULL(SampleCollectedDate,'1900-01-01') DESC,
							LMId DESC                            -- final deterministic tie-breaker
				)
			FROM Ranked
		)
		UPDATE lm
		   SET lm.BillingSubStatus = CASE WHEN r.rn = 1 THEN '' ELSE 'Duplicate' END
		FROM dbo.LISMaster lm
		JOIN R ON R.LMId = lm.LISMasterId;


---------------------------------------------------------------------------------------


		WITH AccessionSummary AS
		(
			SELECT
				LISMasterId,
				HasNonRejected = MAX(CASE WHEN UPPER(LTRIM(RTRIM(StatusCode))) NOT IN ('REJECTED','RJ') THEN 1 ELSE 0 END),
				HasRejected    = MAX(CASE WHEN UPPER(LTRIM(RTRIM(StatusCode)))      IN ('REJECTED','RJ') THEN 1 ELSE 0 END)
			FROM dbo.LISMaster
			GROUP BY LISMasterId
		)
		UPDATE lm
		   SET lm.BillingSubStatus = 'Duplicate'
		FROM dbo.LISMaster lm
		JOIN AccessionSummary a
		  ON a.LISMasterId = lm.LISMasterId
		WHERE a.HasNonRejected = 1
		  AND UPPER(LTRIM(RTRIM(lm.StatusCode))) IN ('REJECTED','RJ');
		  
		UPDATE LISMaster SET BillingSubStatus = 'Deleted' Where StatusCode = 'Deleted'

		DECLARE @AccPayReportId INT

		SET @AccPayReportId = (SELECT TOP 1 ImportedFileID FROM AccPaymentReportStaging ORDER BY ImportedFileID DESC);

	Update LIS SET ClientStatus = Acc.BillingStatus FROM LISMaster LIS 
	JOIN AccPaymentReportStaging Acc on LIS.AccessionNo = Acc.AccessionNo Where (ImportedFileID = @AccPayReportId)
       
	 update ImportedFiles set FileStatus = 1,ProcessedOn = GETDATE() where ImportedFileID = @FileId; 

        -- Commit the transaction if all steps succeed
        COMMIT TRANSACTION;

	EXEC sp_LIS_PanelUpdate;			
	EXEC SP_ProcessLISvsBilling;

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
/****** Object:  StoredProcedure [dbo].[Sp_ProcessAccessionPaymentReport]******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE Proc [dbo].[Sp_ProcessAccessionPaymentReport]
@FileId INT = NULL
AS BEGIN 
   SET NOCOUNT ON;

	update ImportedFiles set FileStatus = 3,ProcessedOn = GETDATE() where ImportedFileID = @FileId;
	BEGIN TRY
    BEGIN TRANSACTION;
	
	Update LIS SET ClientStatus = Acc.BillingStatus FROM LISMaster LIS 
	JOIN AccPaymentReportStaging Acc on LIS.AccessionNo = Acc.AccessionNo Where (ImportedFileID = @FileId OR  @FileId IS NULL)

	EXEC [SP_ProcessLISvsBilling];
	EXEC SP_UpdateLIS_Statuses;
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
    -- Drop temp tables if they exist
	
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
         SELECT dt.VisitNumber,CPTCode,TransactionCarrierCode,PaymentDate,PaymentReasonCode,ServiceDate,dt.Charge,TotalBalance,
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
/****** Object:  StoredProcedure [dbo].[SP_ProcessLISvsBilling]******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[SP_ProcessLISvsBilling]
AS
BEGIN
    SET NOCOUNT ON;

    BEGIN TRY
        BEGIN TRANSACTION;
    /*******************************************************************************************
         Step 1: Update LISMaster with enriched patient/billing data
        ********************************************************************************************/
		WITH CTE_Billing AS(
		Select VisitNumber,FirstBillDate,ChargeEntryDate,AccessionNo,
		  ROW_NUMBER() OVER (
                PARTITION BY 
        VisitNumber,PayerTypeId,PrimaryPayerID,FirstBillDate,ChargeEntryDate order by FirstBillDate
            ) AS RowNum From  BillingMaster)
        UPDATE LIS
        SET 
            VisitNumber          = SCD.VisitNumber,
            FirstBilledDate      = SCD.FirstBillDate,
            ChargeEntryDate      = SCD.ChargeEntryDate
        FROM [dbo].[LISMaster] LIS
        JOIN CTE_Billing SCD ON LIS.AccessionNo = SCD.AccessionNo;



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

    BilledTo = CASE 
        WHEN SelfPay = 'TRUE' AND ISNULL(LTRIM(RTRIM(PrimaryPayerName)), '') = '' THEN 'Self Pay'
        WHEN AccountPay = 'TRUE' THEN 'Client Bill'
        ELSE 'Insurance'
    END,

    DaystoReceive = DATEDIFF(DAY, SampleCollectedDate, SampleReceivedDate),
    DaystoResult  = DATEDIFF(DAY, SampleCollectedDate, SampleResultedDate),
    DaystoBill    = DATEDIFF(DAY, SampleResultedDate, FirstBilledDate);

	

	UPDATE LIS
	SET LIS.PanelCode = 
		CASE 
			WHEN BM.PanelName IS NULL AND RT.RequisitionTypeName = 'Infectious Disease' THEN LIS.PanelCode 
			WHEN BM.PanelName IS NULL AND RT.RequisitionTypeName <> 'Infectious Disease' THEN RT.RequisitionTypeName 
			WHEN BM.AccessionNo IS NULL THEN 'Panel Not Listed' 
			ELSE LIS.PanelCode 
		END
	FROM LISMaster LIS
	LEFT JOIN BillingMaster BM ON LIS.AccessionNo = BM.AccessionNo 
	LEFT JOIN RequisitionTypes RT ON LIS.RequistionTypeId = RT.RequisitionTypeId;


	
		UPDATE LISMaster
SET NewStatus = 
		CASE 
        WHEN ((ReferringProviderName LIKE '%TEST%' ) AND ReferringProviderName NOT IN ('DR MARK TESTA DO')) OR PatientName LIKE '%TEST%' 
		OR (PatientName =  'DEV,DEV') OR (PatientName LIKE  '%Patient%') OR PatientName LIKE '%[0-9]%' THEN 'System Test'
		WHEN FacilityName = 'Environmental Testing' THEN 'System Test'
        WHEN TRIM(StatusCode) IN ('Rejected','Deleted') THEN 'Deleted / Rejected'
		WHEN InsuranceType = 'CLIENT BILL' THEN 'Client Bill'
		WHEN InsuranceType = 'SELF PAY' THEN 'Self-Pay'
		WHEN AccessionNo IS NULL THEN 'Missing Accession'
		WHEN InsuranceType = 'REF LAB - BILL PATIENT' THEN 'Ref Lab - Bill Patient'
		WHEN SampleResultedDate IS NOT NULL AND TRIM(StatusCode) IN ('Validated','Completed','RESULTS AVAILABLE') 
		AND (InsuranceType IS NULL OR InsuranceType IN ('COMMERCIAL','MEDICAID','MEDICARE','MISSING INSURANCE','OTHER INS.')) THEN 'Billable'
        WHEN SampleResultedDate IS NULL AND InsuranceType NOT IN ('SELF PAY','REF LAB - BILL PATIENT','CLIENT BILL') THEN 'Yet to be validated'
        ELSE NULL
    END;

	
		UPDATE LISMaster SET BillingSubStatus = 
					CASE 
					WHEN NewStatus = 'Billable' and BillingStatus = 'Billed' THEN 'Claim Submitted'
					WHEN NewStatus = 'Billable' and BillingStatus = 'Not Billed' AND ClientStatus = 'Aetna Hold' THEN 'Aetna Hold'
					WHEN NewStatus = 'Billable' and BillingStatus = 'Not Billed' AND ClientStatus = 'CGS/NGS Panel' THEN 'CGS/NGS Panel'
					WHEN NewStatus = 'Billable' and BillingStatus = 'Not Billed' AND ClientStatus = 'Client Bill' THEN 'Client Bill'
					WHEN NewStatus = 'Billable' and BillingStatus = 'Not Billed' AND ClientStatus = 'Coding exception' THEN 'Coding Exception'
					WHEN NewStatus = 'Billable' and BillingStatus = 'Not Billed' AND ClientStatus = 'CP Exception' THEN 'CP Exception'
					WHEN NewStatus = 'Billable' and BillingStatus = 'Not Billed' AND ClientStatus = 'Do Not Bill' THEN 'Do Not Bill'
					WHEN NewStatus = 'Billable' and BillingStatus = 'Not Billed' AND ClientStatus = 'Duplicate' THEN 'Duplicate'
					WHEN NewStatus = 'Billable' and BillingStatus = 'Not Billed' AND ClientStatus = 'In process' THEN 'In Process'
					WHEN NewStatus = 'Billable' and BillingStatus = 'Not Billed' AND ClientStatus = 'Medicaid AK/Hold' THEN 'Medicaid AK/Hold'
					WHEN NewStatus = 'Billable' and BillingStatus = 'Not Billed' AND ClientStatus = 'Medicaid NC/Hold' THEN 'Medicaid NC/Hold'
					WHEN NewStatus = 'Billable' and BillingStatus = 'Not Billed' AND ClientStatus = 'Pure Selfpay' THEN 'Pure Selfpay'
					WHEN NewStatus = 'Billable' and BillingStatus = 'Not Billed' AND ClientStatus IS NULL THEN 'Ready To Bill'
					WHEN NewStatus = 'Billable' and BillingStatus = 'Not Billed' AND ClientStatus = 'Ref Lab - Bill Patient' THEN 'Ref Lab - Bill Patient'
					WHEN NewStatus = 'Billable' and BillingStatus = 'Not Billed' AND ClientStatus = 'Selfpay' THEN 'Selfpay'
					ELSE ClientStatus END


	UPDATE LISMaster SET PanelCode = CASE WHEN TRIM(UPPER(PanelCode)) = 'TOX' THEN 'Toxicology' ELSE PanelCode END

	--UPDATE LIS SET LIS.AccessionNo = BM.AccessionNo FROM LISMaster LIS JOIN BillingMaster BM on LIS.PatientName = BM.PatientName 
	--AND LIS.SampleCollectedDate = BM.BeginDOS WHERE LIS.AccessionNo IS NULL AND BM.AccessionNo NOT IN (SELECT DISTINCT AccessionNo FROM LISMaster WHERE AccessionNo IS NULL)

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

	IF @FileId IS NULL
		SET @FileId = (SELECT TOP 1 ImportedFileID FROM TransactionDetailStaging ORDER BY ImportedFileID DESC)

        -- Step 1: Create temp table from staging and LISMaster
        SELECT 
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
                TT.TotalBilledAmount AS TotalBilledAmount,
                TT.PatientPaidAmount AS PatientPaidAmount,
                TT.InsurancePaidAmount AS InsurancePaidAmount,
                TT.TotalPaidAmount AS TotalPaidAmount,
                TT.AdjustmentAmount AS AdjustmentAmount
				into #AggregatedTemp
            FROM #TransacionnDetailTemp TT  
    --        GROUP BY 
    --            TT.LabIdentityKey,
    --            TT.TransactionType,
    --            TT.ChartNumber,
    --            TT.VisitNo,
    --            TT.ChargeCode,
    --            TT.TransactionCodeDesc,
    --            TT.Modifiers,
    --            TT.VisitPrimaryCarrier,
    --            TT.VisitSecondaryCarrier,
    --            TT.PrimaryDxICD10,
    --            TT.PrimaryDxICD9,
    --            TT.PaymentMethod,
    --            TT.CheckNumber,
    --            TT.Void,
				--TT.DateofDeposit,
				--TT.DateofEntry,
				--TT.DateofService,TT.Units
      
		
  		DELETE FROM TransactionMaster WHERE [VisitNo] IN (SELECT DISTINCT VisitNo FROM #AggregatedTemp) AND TransactionType IN  (SELECT DISTINCT TransactionType FROM #AggregatedTemp) 
		
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
		--WHERE NOT EXISTS (
		--	SELECT 1
		--	FROM TransactionMaster TM
		--	WHERE TM.VisitNo = AT.VisitNo
		--	  AND TM.CPTCode = AT.ChargeCode
		--	  AND ISNULL(TM.Units, 999) = ISNULL(AT.Units, 999)
		--	  AND ISNULL(TM.Modifiers, 'NA') = ISNULL(AT.Modifiers, 'NA')
		--	  AND TM.TotalBilledAmount = AT.TotalBilledAmount
		--) ORDER BY TransactionType ;

		

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


	select VisitNo,CPTCode,SUM(Units) Units INTO #TransData from TransactionMaster 
	where TransactionType = 'Charge' and TotalBilledAmount > 0 and void is null  
	GROUP BY  VisitNo,CPTCode;

	UPDATE BM SET BM.Units = TD.Units FROM BillingMaster BM 
	JOIN #TransData TD ON BM.VisitNumber = TD.VisitNo and BM.CPTCode = TD.CPTCode

		update ImportedFiles set FileStatus = 1,ProcessedOn = GETDATE()  where ImportedFileID = @FileId;



		--EXEC [BillingMasterProcess_Proc];

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

    --BillingSubStatus = CASE 
    --    WHEN FirstBilledDate IS NOT NULL THEN 'Claim Submitted'
    --    WHEN FirstBilledDate IS NULL AND ChargeEntryDate IS NOT NULL THEN 'Charge Entered in AMD'
    --    WHEN SampleResultedDate IS NOT NULL AND FirstBilledDate IS NULL AND ChargeEntryDate IS NULL THEN 'Resulted Yet to Billed'
    --    WHEN SampleResultedDate IS NULL AND FirstBilledDate IS NULL AND ChargeEntryDate IS NULL THEN 'Yet to be Resulted'
    --    ELSE ''
    --END,

    BilledTo = CASE 
        WHEN SelfPay = 'TRUE' AND ISNULL(LTRIM(RTRIM(PrimaryPayerName)), '') = '' THEN 'Self Pay'
        WHEN AccountPay = 'TRUE' THEN 'Client Bill'
        ELSE 'Insurance'
    END,

    DaystoReceive = DATEDIFF(DAY, SampleCollectedDate, SampleReceivedDate),
    DaystoResult  = DATEDIFF(DAY, SampleReceivedDate, SampleResultedDate),
    DaystoBill    = DATEDIFF(DAY, SampleResultedDate, FirstBilledDate);



	
		/* 1) Example insert from your staging/raw table (rename columns/tables as needed) */
		-- INSERT INTO dbo.LISMaster (AccessionNo, SampleCollectedDate, SampleResultedDate, SampleReceivedDate, StatusCode, ...other cols...)
		-- SELECT AccessionNo, SampleCollectedDate, SampleResultedDate, SampleReceivedDate, StatusCode, ...other cols...
		-- FROM dbo.LIS_RawImport
		-- WHERE <your filters, e.g., current file batch, etc.>;

		-- If you already inserted, skip step 1.

		/* 2) Compute "latest" per (AccessionNo, StatusCode)
			  MaxSampleDate = greatest of Resulted / Received / Collected
			  Then rank descending and mark duplicates.
		*/

		/*
		if there are identical accession numbers within the raw report with same order status
		Insert both the line items in the LIS master report
		Mark the latest sample by collection date or received date or resulted date mark the second line item as duplicate in the billing sub status
		*/

		WITH Ranked AS
		(
			SELECT
				LMId   = lm.LISMasterId,          
				lm.StatusCode,
				-- Greatest-of-3 using VALUES + MAX
				MaxSampleDate = (
					SELECT MAX(v.d)
					FROM (VALUES (lm.SampleResultedDate),
								 (lm.SampleReceivedDate),
								 (lm.SampleCollectedDate)) AS v(d)
				),
				lm.SampleResultedDate,
				lm.SampleReceivedDate,
				lm.SampleCollectedDate
			FROM dbo.LISMaster lm
		),
		R AS
		(
			SELECT
				LMId,
				StatusCode,
				MaxSampleDate,
				rn = ROW_NUMBER() OVER (
						PARTITION BY LMId,StatusCode
						ORDER BY
							MaxSampleDate DESC,                 -- newest first
							ISNULL(SampleResultedDate,'1900-01-01') DESC,  -- stable tie-breakers
							ISNULL(SampleReceivedDate,'1900-01-01') DESC,
							ISNULL(SampleCollectedDate,'1900-01-01') DESC,
							LMId DESC                            -- final deterministic tie-breaker
				)
			FROM Ranked
		)
		UPDATE lm
		   SET lm.BillingSubStatus = CASE WHEN r.rn = 1 THEN BillingSubStatus ELSE 'Duplicate' END
		FROM dbo.LISMaster lm
		JOIN R ON R.LMId = lm.LISMasterId;


---------------------------------------------------------------------------------------


		WITH AccessionSummary AS
		(
			SELECT
				LISMasterId,
				HasNonRejected = MAX(CASE WHEN UPPER(LTRIM(RTRIM(StatusCode))) NOT IN ('REJECTED','RJ') THEN 1 ELSE 0 END),
				HasRejected    = MAX(CASE WHEN UPPER(LTRIM(RTRIM(StatusCode)))      IN ('REJECTED','RJ') THEN 1 ELSE 0 END)
			FROM dbo.LISMaster
			GROUP BY LISMasterId
		)
		UPDATE lm
		   SET lm.BillingSubStatus = 'Duplicate'
		FROM dbo.LISMaster lm
		JOIN AccessionSummary a
		  ON a.LISMasterId = lm.LISMasterId
		WHERE a.HasNonRejected = 1
		  AND UPPER(LTRIM(RTRIM(lm.StatusCode))) IN ('REJECTED','RJ');
		  
		--UPDATE LISMaster SET BillingSubStatus = 'Deleted' Where StatusCode = 'Deleted'
	END
GO
