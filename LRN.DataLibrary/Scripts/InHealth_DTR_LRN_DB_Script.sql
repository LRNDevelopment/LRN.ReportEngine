USE [InHealthLRN]
GO
/****** Object:  StoredProcedure [dbo].[sp_RebuildNewIndexes]******/
DROP PROCEDURE [dbo].[sp_RebuildNewIndexes]
GO
/****** Object:  StoredProcedure [dbo].[SP_ProcessVAAvsLIS]******/
DROP PROCEDURE [dbo].[SP_ProcessVAAvsLIS]
GO
/****** Object:  StoredProcedure [dbo].[Sp_ProcessTransactionDetails]******/
DROP PROCEDURE [dbo].[Sp_ProcessTransactionDetails]
GO
/****** Object:  StoredProcedure [dbo].[Sp_ProcessNexusClaimDTRIH]******/
DROP PROCEDURE [dbo].[Sp_ProcessNexusClaimDTRIH]
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
/****** Object:  StoredProcedure [dbo].[Sp_Process_VAA_ByFileId]******/
DROP PROCEDURE [dbo].[Sp_Process_VAA_ByFileId]
GO
/****** Object:  StoredProcedure [dbo].[Sp_Process_PanelMasterStaging]******/
DROP PROCEDURE [dbo].[Sp_Process_PanelMasterStaging]
GO
/****** Object:  StoredProcedure [dbo].[SP_Process_LISMaster_ByFileId]******/
DROP PROCEDURE [dbo].[SP_Process_LISMaster_ByFileId]
GO
/****** Object:  StoredProcedure [dbo].[sp_Process_FinalCalimStatus]******/
DROP PROCEDURE [dbo].[sp_Process_FinalCalimStatus]
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
/****** Object:  StoredProcedure [dbo].[BillingMasterProcess_Proc]******/
DROP PROCEDURE [dbo].[BillingMasterProcess_Proc]
GO
ALTER TABLE [dbo].[BillingMaster] DROP CONSTRAINT [CK_BillingMaster_NonNegativeAmounts]
GO
ALTER TABLE [dbo].[LISMaster] DROP CONSTRAINT [FK__LISMaster__TestT__530F007D]
GO
ALTER TABLE [dbo].[LISMaster] DROP CONSTRAINT [FK__LISMaster__TestT__521ADC44]
GO
ALTER TABLE [dbo].[LISMaster] DROP CONSTRAINT [FK__LISMaster__TestT__5126B80B]
GO
ALTER TABLE [dbo].[LISMaster] DROP CONSTRAINT [FK__LISMaster__TestT__503293D2]
GO
ALTER TABLE [dbo].[LISMaster] DROP CONSTRAINT [FK__LISMaster__TestT__4F3E6F99]
GO
ALTER TABLE [dbo].[LISMaster] DROP CONSTRAINT [FK__LISMaster__TestT__4E4A4B60]
GO
ALTER TABLE [dbo].[LISMaster] DROP CONSTRAINT [FK__LISMaster__TestT__4D562727]
GO
ALTER TABLE [dbo].[LISMaster] DROP CONSTRAINT [FK__LISMaster__TestT__4C6202EE]
GO
ALTER TABLE [dbo].[LISMaster] DROP CONSTRAINT [FK__LISMaster__TestT__4B6DDEB5]
GO
ALTER TABLE [dbo].[LISMaster] DROP CONSTRAINT [FK__LISMaster__TestT__4A79BA7C]
GO
ALTER TABLE [dbo].[LISMaster] DROP CONSTRAINT [FK__LISMaster__TestT__49859643]
GO
ALTER TABLE [dbo].[LISMaster] DROP CONSTRAINT [FK__LISMaster__TestT__4891720A]
GO
ALTER TABLE [dbo].[LISMaster] DROP CONSTRAINT [FK__LISMaster__TestT__479D4DD1]
GO
ALTER TABLE [dbo].[LISMaster] DROP CONSTRAINT [FK__LISMaster__TestT__46A92998]
GO
ALTER TABLE [dbo].[LISMaster] DROP CONSTRAINT [FK__LISMaster__TestT__45B5055F]
GO
ALTER TABLE [dbo].[LISMaster] DROP CONSTRAINT [FK__LISMaster__Sampl__44C0E126]
GO
ALTER TABLE [dbo].[LISMaster] DROP CONSTRAINT [FK__LISMaster__Sampl__43CCBCED]
GO
ALTER TABLE [dbo].[LISMaster] DROP CONSTRAINT [FK__LISMaster__Sampl__42D898B4]
GO
ALTER TABLE [dbo].[LISMaster] DROP CONSTRAINT [FK__LISMaster__Sampl__41E4747B]
GO
ALTER TABLE [dbo].[LISMaster] DROP CONSTRAINT [FK__LISMaster__Sampl__40F05042]
GO
ALTER TABLE [dbo].[LISMaster] DROP CONSTRAINT [FK__LISMaster__Sampl__3FFC2C09]
GO
ALTER TABLE [dbo].[LISMaster] DROP CONSTRAINT [FK__LISMaster__Sampl__3F0807D0]
GO
ALTER TABLE [dbo].[LISMaster] DROP CONSTRAINT [FK__LISMaster__Sampl__3E13E397]
GO
ALTER TABLE [dbo].[LISMaster] DROP CONSTRAINT [FK__LISMaster__Sampl__3D1FBF5E]
GO
ALTER TABLE [dbo].[LISMaster] DROP CONSTRAINT [FK__LISMaster__Sampl__3C2B9B25]
GO
ALTER TABLE [dbo].[LISMaster] DROP CONSTRAINT [FK__LISMaster__Sampl__3B3776EC]
GO
ALTER TABLE [dbo].[LISMaster] DROP CONSTRAINT [FK__LISMaster__Sampl__3A4352B3]
GO
ALTER TABLE [dbo].[LISMaster] DROP CONSTRAINT [FK__LISMaster__Sampl__394F2E7A]
GO
ALTER TABLE [dbo].[LISMaster] DROP CONSTRAINT [FK__LISMaster__Sampl__385B0A41]
GO
ALTER TABLE [dbo].[LISMaster] DROP CONSTRAINT [FK__LISMaster__Sampl__3766E608]
GO
ALTER TABLE [dbo].[LISMaster] DROP CONSTRAINT [FK__LISMaster__Refer__3672C1CF]
GO
ALTER TABLE [dbo].[LISMaster] DROP CONSTRAINT [FK__LISMaster__Refer__357E9D96]
GO
ALTER TABLE [dbo].[LISMaster] DROP CONSTRAINT [FK__LISMaster__Refer__348A795D]
GO
ALTER TABLE [dbo].[LISMaster] DROP CONSTRAINT [FK__LISMaster__Refer__33965524]
GO
ALTER TABLE [dbo].[LISMaster] DROP CONSTRAINT [FK__LISMaster__Refer__32A230EB]
GO
ALTER TABLE [dbo].[LISMaster] DROP CONSTRAINT [FK__LISMaster__Refer__31AE0CB2]
GO
ALTER TABLE [dbo].[LISMaster] DROP CONSTRAINT [FK__LISMaster__Refer__30B9E879]
GO
ALTER TABLE [dbo].[LISMaster] DROP CONSTRAINT [FK__LISMaster__Refer__2FC5C440]
GO
ALTER TABLE [dbo].[LISMaster] DROP CONSTRAINT [FK__LISMaster__Refer__2ED1A007]
GO
ALTER TABLE [dbo].[LISMaster] DROP CONSTRAINT [FK__LISMaster__Refer__2DDD7BCE]
GO
ALTER TABLE [dbo].[LISMaster] DROP CONSTRAINT [FK__LISMaster__Refer__2CE95795]
GO
ALTER TABLE [dbo].[LISMaster] DROP CONSTRAINT [FK__LISMaster__Refer__2BF5335C]
GO
ALTER TABLE [dbo].[LISMaster] DROP CONSTRAINT [FK__LISMaster__Refer__2B010F23]
GO
ALTER TABLE [dbo].[LISMaster] DROP CONSTRAINT [FK__LISMaster__Refer__2A0CEAEA]
GO
ALTER TABLE [dbo].[LISMaster] DROP CONSTRAINT [FK__LISMaster__Refer__2918C6B1]
GO
ALTER TABLE [dbo].[LISMaster] DROP CONSTRAINT [FK__LISMaster__Payer__2824A278]
GO
ALTER TABLE [dbo].[LISMaster] DROP CONSTRAINT [FK__LISMaster__Payer__27307E3F]
GO
ALTER TABLE [dbo].[LISMaster] DROP CONSTRAINT [FK__LISMaster__Payer__263C5A06]
GO
ALTER TABLE [dbo].[LISMaster] DROP CONSTRAINT [FK__LISMaster__Payer__254835CD]
GO
ALTER TABLE [dbo].[LISMaster] DROP CONSTRAINT [FK__LISMaster__Payer__24541194]
GO
ALTER TABLE [dbo].[LISMaster] DROP CONSTRAINT [FK__LISMaster__Payer__235FED5B]
GO
ALTER TABLE [dbo].[LISMaster] DROP CONSTRAINT [FK__LISMaster__Payer__226BC922]
GO
ALTER TABLE [dbo].[LISMaster] DROP CONSTRAINT [FK__LISMaster__Payer__2177A4E9]
GO
ALTER TABLE [dbo].[LISMaster] DROP CONSTRAINT [FK__LISMaster__Payer__208380B0]
GO
ALTER TABLE [dbo].[LISMaster] DROP CONSTRAINT [FK__LISMaster__Payer__1F8F5C77]
GO
ALTER TABLE [dbo].[LISMaster] DROP CONSTRAINT [FK__LISMaster__Payer__1E9B383E]
GO
ALTER TABLE [dbo].[LISMaster] DROP CONSTRAINT [FK__LISMaster__Payer__1DA71405]
GO
ALTER TABLE [dbo].[LISMaster] DROP CONSTRAINT [FK__LISMaster__Payer__1CB2EFCC]
GO
ALTER TABLE [dbo].[LISMaster] DROP CONSTRAINT [FK__LISMaster__Payer__1BBECB93]
GO
ALTER TABLE [dbo].[LISMaster] DROP CONSTRAINT [FK__LISMaster__Payer__1ACAA75A]
GO
ALTER TABLE [dbo].[LISMaster] DROP CONSTRAINT [FK__LISMaster__Panel__19D68321]
GO
ALTER TABLE [dbo].[LISMaster] DROP CONSTRAINT [FK__LISMaster__Panel__18E25EE8]
GO
ALTER TABLE [dbo].[LISMaster] DROP CONSTRAINT [FK__LISMaster__Panel__17EE3AAF]
GO
ALTER TABLE [dbo].[LISMaster] DROP CONSTRAINT [FK__LISMaster__Panel__16FA1676]
GO
ALTER TABLE [dbo].[LISMaster] DROP CONSTRAINT [FK__LISMaster__Panel__1605F23D]
GO
ALTER TABLE [dbo].[LISMaster] DROP CONSTRAINT [FK__LISMaster__Panel__1511CE04]
GO
ALTER TABLE [dbo].[LISMaster] DROP CONSTRAINT [FK__LISMaster__Panel__141DA9CB]
GO
ALTER TABLE [dbo].[LISMaster] DROP CONSTRAINT [FK__LISMaster__Panel__13298592]
GO
ALTER TABLE [dbo].[LISMaster] DROP CONSTRAINT [FK__LISMaster__Panel__12356159]
GO
ALTER TABLE [dbo].[LISMaster] DROP CONSTRAINT [FK__LISMaster__Panel__11413D20]
GO
ALTER TABLE [dbo].[LISMaster] DROP CONSTRAINT [FK__LISMaster__Panel__104D18E7]
GO
ALTER TABLE [dbo].[LISMaster] DROP CONSTRAINT [FK__LISMaster__Panel__0F58F4AE]
GO
ALTER TABLE [dbo].[LISMaster] DROP CONSTRAINT [FK__LISMaster__Panel__0E64D075]
GO
ALTER TABLE [dbo].[LISMaster] DROP CONSTRAINT [FK__LISMaster__Panel__0D70AC3C]
GO
ALTER TABLE [dbo].[LISMaster] DROP CONSTRAINT [FK__LISMaster__Panel__0C7C8803]
GO
ALTER TABLE [dbo].[LISMaster] DROP CONSTRAINT [FK__LISMaster__Opera__7F228CE5]
GO
ALTER TABLE [dbo].[LISMaster] DROP CONSTRAINT [FK__LISMaster__Opera__7E2E68AC]
GO
ALTER TABLE [dbo].[LISMaster] DROP CONSTRAINT [FK__LISMaster__Opera__0B8863CA]
GO
ALTER TABLE [dbo].[LISMaster] DROP CONSTRAINT [FK__LISMaster__Opera__0A943F91]
GO
ALTER TABLE [dbo].[LISMaster] DROP CONSTRAINT [FK__LISMaster__Opera__09A01B58]
GO
ALTER TABLE [dbo].[LISMaster] DROP CONSTRAINT [FK__LISMaster__Opera__08ABF71F]
GO
ALTER TABLE [dbo].[LISMaster] DROP CONSTRAINT [FK__LISMaster__Opera__07B7D2E6]
GO
ALTER TABLE [dbo].[LISMaster] DROP CONSTRAINT [FK__LISMaster__Opera__06C3AEAD]
GO
ALTER TABLE [dbo].[LISMaster] DROP CONSTRAINT [FK__LISMaster__Opera__05CF8A74]
GO
ALTER TABLE [dbo].[LISMaster] DROP CONSTRAINT [FK__LISMaster__Opera__04DB663B]
GO
ALTER TABLE [dbo].[LISMaster] DROP CONSTRAINT [FK__LISMaster__Opera__03E74202]
GO
ALTER TABLE [dbo].[LISMaster] DROP CONSTRAINT [FK__LISMaster__Opera__02F31DC9]
GO
ALTER TABLE [dbo].[LISMaster] DROP CONSTRAINT [FK__LISMaster__Opera__01FEF990]
GO
ALTER TABLE [dbo].[LISMaster] DROP CONSTRAINT [FK__LISMaster__Opera__010AD557]
GO
ALTER TABLE [dbo].[LISMaster] DROP CONSTRAINT [FK__LISMaster__Opera__0016B11E]
GO
ALTER TABLE [dbo].[LISMaster] DROP CONSTRAINT [FK__LISMaster__LabId__7D3A4473]
GO
ALTER TABLE [dbo].[LISMaster] DROP CONSTRAINT [FK__LISMaster__LabId__7C46203A]
GO
ALTER TABLE [dbo].[LISMaster] DROP CONSTRAINT [FK__LISMaster__LabId__7B51FC01]
GO
ALTER TABLE [dbo].[LISMaster] DROP CONSTRAINT [FK__LISMaster__LabId__7A5DD7C8]
GO
ALTER TABLE [dbo].[LISMaster] DROP CONSTRAINT [FK__LISMaster__LabId__7969B38F]
GO
ALTER TABLE [dbo].[LISMaster] DROP CONSTRAINT [FK__LISMaster__LabId__78758F56]
GO
ALTER TABLE [dbo].[LISMaster] DROP CONSTRAINT [FK__LISMaster__LabId__77816B1D]
GO
ALTER TABLE [dbo].[LISMaster] DROP CONSTRAINT [FK__LISMaster__LabId__768D46E4]
GO
ALTER TABLE [dbo].[LISMaster] DROP CONSTRAINT [FK__LISMaster__LabId__759922AB]
GO
ALTER TABLE [dbo].[LISMaster] DROP CONSTRAINT [FK__LISMaster__LabId__74A4FE72]
GO
ALTER TABLE [dbo].[LISMaster] DROP CONSTRAINT [FK__LISMaster__LabId__73B0DA39]
GO
ALTER TABLE [dbo].[LISMaster] DROP CONSTRAINT [FK__LISMaster__LabId__72BCB600]
GO
ALTER TABLE [dbo].[LISMaster] DROP CONSTRAINT [FK__LISMaster__LabId__71C891C7]
GO
ALTER TABLE [dbo].[LISMaster] DROP CONSTRAINT [FK__LISMaster__LabId__70D46D8E]
GO
ALTER TABLE [dbo].[LISMaster] DROP CONSTRAINT [FK__LISMaster__LabId__6FE04955]
GO
ALTER TABLE [dbo].[LISMaster] DROP CONSTRAINT [FK__LISMaster__Clini__6EEC251C]
GO
ALTER TABLE [dbo].[LISMaster] DROP CONSTRAINT [FK__LISMaster__Clini__6DF800E3]
GO
ALTER TABLE [dbo].[LISMaster] DROP CONSTRAINT [FK__LISMaster__Clini__6D03DCAA]
GO
ALTER TABLE [dbo].[LISMaster] DROP CONSTRAINT [FK__LISMaster__Clini__6C0FB871]
GO
ALTER TABLE [dbo].[LISMaster] DROP CONSTRAINT [FK__LISMaster__Clini__6B1B9438]
GO
ALTER TABLE [dbo].[LISMaster] DROP CONSTRAINT [FK__LISMaster__Clini__6A276FFF]
GO
ALTER TABLE [dbo].[LISMaster] DROP CONSTRAINT [FK__LISMaster__Clini__69334BC6]
GO
ALTER TABLE [dbo].[LISMaster] DROP CONSTRAINT [FK__LISMaster__Clini__683F278D]
GO
ALTER TABLE [dbo].[LISMaster] DROP CONSTRAINT [FK__LISMaster__Clini__674B0354]
GO
ALTER TABLE [dbo].[LISMaster] DROP CONSTRAINT [FK__LISMaster__Clini__6656DF1B]
GO
ALTER TABLE [dbo].[LISMaster] DROP CONSTRAINT [FK__LISMaster__Clini__6562BAE2]
GO
ALTER TABLE [dbo].[LISMaster] DROP CONSTRAINT [FK__LISMaster__Clini__646E96A9]
GO
ALTER TABLE [dbo].[LISMaster] DROP CONSTRAINT [FK__LISMaster__Clini__637A7270]
GO
ALTER TABLE [dbo].[LISMaster] DROP CONSTRAINT [FK__LISMaster__Clini__62864E37]
GO
ALTER TABLE [dbo].[LISMaster] DROP CONSTRAINT [FK__LISMaster__Clini__619229FE]
GO
ALTER TABLE [dbo].[LISMaster] DROP CONSTRAINT [FK__LISMaster__Billi__609E05C5]
GO
ALTER TABLE [dbo].[LISMaster] DROP CONSTRAINT [FK__LISMaster__Billi__5FA9E18C]
GO
ALTER TABLE [dbo].[LISMaster] DROP CONSTRAINT [FK__LISMaster__Billi__5EB5BD53]
GO
ALTER TABLE [dbo].[LISMaster] DROP CONSTRAINT [FK__LISMaster__Billi__5DC1991A]
GO
ALTER TABLE [dbo].[LISMaster] DROP CONSTRAINT [FK__LISMaster__Billi__5CCD74E1]
GO
ALTER TABLE [dbo].[LISMaster] DROP CONSTRAINT [FK__LISMaster__Billi__5BD950A8]
GO
ALTER TABLE [dbo].[LISMaster] DROP CONSTRAINT [FK__LISMaster__Billi__5AE52C6F]
GO
ALTER TABLE [dbo].[LISMaster] DROP CONSTRAINT [FK__LISMaster__Billi__59F10836]
GO
ALTER TABLE [dbo].[LISMaster] DROP CONSTRAINT [FK__LISMaster__Billi__58FCE3FD]
GO
ALTER TABLE [dbo].[LISMaster] DROP CONSTRAINT [FK__LISMaster__Billi__5808BFC4]
GO
ALTER TABLE [dbo].[LISMaster] DROP CONSTRAINT [FK__LISMaster__Billi__57149B8B]
GO
ALTER TABLE [dbo].[LISMaster] DROP CONSTRAINT [FK__LISMaster__Billi__56207752]
GO
ALTER TABLE [dbo].[LISMaster] DROP CONSTRAINT [FK__LISMaster__Billi__552C5319]
GO
ALTER TABLE [dbo].[LISMaster] DROP CONSTRAINT [FK__LISMaster__Billi__54382EE0]
GO
ALTER TABLE [dbo].[LISMaster] DROP CONSTRAINT [FK__LISMaster__Billi__53440AA7]
GO
ALTER TABLE [dbo].[BillingMaster] DROP CONSTRAINT [FK_BillingMaster_PrimaryPayer]
GO
ALTER TABLE [dbo].[BillingMaster] DROP CONSTRAINT [FK_BillingMaster_PayerType]
GO
ALTER TABLE [dbo].[BillingMaster] DROP CONSTRAINT [FK_BillingMaster_BillingProvider]
GO
ALTER TABLE [dbo].[VisitAgaistAccessionStaging] DROP CONSTRAINT [DF__VisitAgai__Impor__249D5F00]
GO
ALTER TABLE [dbo].[VAAMaster] DROP CONSTRAINT [DF__VAAMaster__Creat__23A93AC7]
GO
ALTER TABLE [dbo].[TransactionSummary] DROP CONSTRAINT [DF__Transacti__Creat__22B5168E]
GO
ALTER TABLE [dbo].[TransactionSummary] DROP CONSTRAINT [DF__Transacti__Insur__21C0F255]
GO
ALTER TABLE [dbo].[TransactionSummary] DROP CONSTRAINT [DF__Transacti__Total__20CCCE1C]
GO
ALTER TABLE [dbo].[TransactionSummary] DROP CONSTRAINT [DF__Transacti__Patie__1FD8A9E3]
GO
ALTER TABLE [dbo].[TransactionSummary] DROP CONSTRAINT [DF__Transacti__Adjus__1EE485AA]
GO
ALTER TABLE [dbo].[TransactionSummary] DROP CONSTRAINT [DF__Transacti__Total__1DF06171]
GO
ALTER TABLE [dbo].[TransactionSummary] DROP CONSTRAINT [DF__Transacti__Units__1CFC3D38]
GO
ALTER TABLE [dbo].[TransactionMaster] DROP CONSTRAINT [DF__Transacti__Creat__1C0818FF]
GO
ALTER TABLE [dbo].[TransactionDetailStaging] DROP CONSTRAINT [DF__Transacti__Impor__1B13F4C6]
GO
ALTER TABLE [dbo].[TestTypeMaster] DROP CONSTRAINT [DF__TestTypeM__Creat__51300E55]
GO
ALTER TABLE [dbo].[TestTypeMaster] DROP CONSTRAINT [DF__TestTypeM__IsAct__503BEA1C]
GO
ALTER TABLE [dbo].[SpecimenStatus] DROP CONSTRAINT [DF__SpecimenS__Creat__4F47C5E3]
GO
ALTER TABLE [dbo].[SpecimenStatus] DROP CONSTRAINT [DF__SpecimenS__IsAct__4E53A1AA]
GO
ALTER TABLE [dbo].[SalesPerson] DROP CONSTRAINT [DF__SalesPers__Creat__1A1FD08D]
GO
ALTER TABLE [dbo].[ReferringProviderMaster] DROP CONSTRAINT [DF__Referring__Creat__4C6B5938]
GO
ALTER TABLE [dbo].[ReferringProviderMaster] DROP CONSTRAINT [DF__Referring__IsAct__4B7734FF]
GO
ALTER TABLE [dbo].[PrismBillingStaging] DROP CONSTRAINT [DF__PrismBill__Impor__192BAC54]
GO
ALTER TABLE [dbo].[PolicyStatuses] DROP CONSTRAINT [DF__PolicySta__Creat__2161CAF9]
GO
ALTER TABLE [dbo].[PolicyStatuses] DROP CONSTRAINT [DF__PolicySta__IsAct__206DA6C0]
GO
ALTER TABLE [dbo].[PayerTypeMaster] DROP CONSTRAINT [DF__PayerType__Creat__498EEC8D]
GO
ALTER TABLE [dbo].[PayerTypeMaster] DROP CONSTRAINT [DF__PayerType__IsAct__489AC854]
GO
ALTER TABLE [dbo].[PanelMasterStaging] DROP CONSTRAINT [DF__PanelMast__Impor__1837881B]
GO
ALTER TABLE [dbo].[PanelGroup] DROP CONSTRAINT [DF__PanelGrou__Creat__46B27FE2]
GO
ALTER TABLE [dbo].[PanelGroup] DROP CONSTRAINT [DF__PanelGrou__IsAct__45BE5BA9]
GO
ALTER TABLE [dbo].[OperationsGroupMaster] DROP CONSTRAINT [DF__Operation__Creat__44CA3770]
GO
ALTER TABLE [dbo].[OperationsGroupMaster] DROP CONSTRAINT [DF__Operation__IsAct__43D61337]
GO
ALTER TABLE [dbo].[NexusStaging] DROP CONSTRAINT [DF__NexusStag__Impor__2FFACE6A]
GO
ALTER TABLE [dbo].[LISStaging] DROP CONSTRAINT [DF__LISStagin__Impor__6A90B8FC]
GO
ALTER TABLE [dbo].[LISMaster] DROP CONSTRAINT [DF__LISMaster__Updat__524FE66E]
GO
ALTER TABLE [dbo].[LISMaster] DROP CONSTRAINT [DF__LISMaster__Creat__515BC235]
GO
ALTER TABLE [dbo].[LabMaster] DROP CONSTRAINT [DF__LabMaster__Creat__1466F737]
GO
ALTER TABLE [dbo].[LabMaster] DROP CONSTRAINT [DF__LabMaster__IsAct__1372D2FE]
GO
ALTER TABLE [dbo].[InsurancePayerMaster] DROP CONSTRAINT [DF__Insurance__Creat__127EAEC5]
GO
ALTER TABLE [dbo].[InsurancePayerMaster] DROP CONSTRAINT [DF__Insurance__IsAct__118A8A8C]
GO
ALTER TABLE [dbo].[ImportFilTypes] DROP CONSTRAINT [DF__ImportFil__IsAct__10966653]
GO
ALTER TABLE [dbo].[ImportFileLogs] DROP CONSTRAINT [DF__ImportFil__Creat__0FA2421A]
GO
ALTER TABLE [dbo].[ImportedFiles] DROP CONSTRAINT [DF__ImportedF__LabId__0EAE1DE1]
GO
ALTER TABLE [dbo].[ImportedFiles] DROP CONSTRAINT [DF__ImportedF__Impor__0DB9F9A8]
GO
ALTER TABLE [dbo].[ICDCodeMaster] DROP CONSTRAINT [DF__ICDCodeMa__Creat__0CC5D56F]
GO
ALTER TABLE [dbo].[ICDCodeMaster] DROP CONSTRAINT [DF__ICDCodeMa__IsAct__0BD1B136]
GO
ALTER TABLE [dbo].[DownloadReportTypes] DROP CONSTRAINT [DF__DownloadR__IsAct__0ADD8CFD]
GO
ALTER TABLE [dbo].[DiagnoseLISStaging] DROP CONSTRAINT [DF__DiagnoseL__Impor__09E968C4]
GO
ALTER TABLE [dbo].[DenialTrackingStaging] DROP CONSTRAINT [DF__DenialTra__Impor__08F5448B]
GO
ALTER TABLE [dbo].[DenialTrackingMaster] DROP CONSTRAINT [DF__DenialTra__Updat__45DF2291]
GO
ALTER TABLE [dbo].[DenialTrackingMaster] DROP CONSTRAINT [DF__DenialTra__Creat__44EAFE58]
GO
ALTER TABLE [dbo].[CustomCollectionStaging] DROP CONSTRAINT [DF__CustomCol__Impot__0618D7E0]
GO
ALTER TABLE [dbo].[CPTCodeMaster] DROP CONSTRAINT [DF__CPTCodeMa__Creat__0524B3A7]
GO
ALTER TABLE [dbo].[CPTCodeMaster] DROP CONSTRAINT [DF__CPTCodeMa__IsAct__04308F6E]
GO
ALTER TABLE [dbo].[ClinicTypes] DROP CONSTRAINT [DF__ClinicTyp__Creat__1C9D15DC]
GO
ALTER TABLE [dbo].[ClinicTypes] DROP CONSTRAINT [DF__ClinicTyp__IsAct__1BA8F1A3]
GO
ALTER TABLE [dbo].[ClinicMaster] DROP CONSTRAINT [DF__ClinicMas__Creat__033C6B35]
GO
ALTER TABLE [dbo].[ClinicMaster] DROP CONSTRAINT [DF__ClinicMas__Clini__024846FC]
GO
ALTER TABLE [dbo].[ClientBillingSheet] DROP CONSTRAINT [DF__ClientBil__Impor__015422C3]
GO
ALTER TABLE [dbo].[ClaimsProdStatus] DROP CONSTRAINT [DF__ClaimsPro__Creat__005FFE8A]
GO
ALTER TABLE [dbo].[ClaimsLevelStatus] DROP CONSTRAINT [DF__ClaimsLev__Creat__7F6BDA51]
GO
ALTER TABLE [dbo].[ClaimsLevelStatus] DROP CONSTRAINT [DF__ClaimsLev__Total__7E77B618]
GO
ALTER TABLE [dbo].[ClaimsLevelStatus] DROP CONSTRAINT [DF__ClaimsLev__Patie__7D8391DF]
GO
ALTER TABLE [dbo].[ClaimsLevelStatus] DROP CONSTRAINT [DF__ClaimsLev__Insur__7C8F6DA6]
GO
ALTER TABLE [dbo].[ClaimsLevelStatus] DROP CONSTRAINT [DF__ClaimsLev__Patie__7B9B496D]
GO
ALTER TABLE [dbo].[ClaimsLevelStatus] DROP CONSTRAINT [DF__ClaimsLev__Patie__7AA72534]
GO
ALTER TABLE [dbo].[ClaimsLevelStatus] DROP CONSTRAINT [DF__ClaimsLev__Insur__79B300FB]
GO
ALTER TABLE [dbo].[ClaimsLevelStatus] DROP CONSTRAINT [DF__ClaimsLev__Insur__78BEDCC2]
GO
ALTER TABLE [dbo].[ClaimsLevelStatus] DROP CONSTRAINT [DF__ClaimsLev__Allow__77CAB889]
GO
ALTER TABLE [dbo].[ClaimsLevelStatus] DROP CONSTRAINT [DF__ClaimsLev__Bille__76D69450]
GO
ALTER TABLE [dbo].[ClaimBillingDetails] DROP CONSTRAINT [DF__ClaimBill__Creat__75E27017]
GO
ALTER TABLE [dbo].[ClaimBillingDetails] DROP CONSTRAINT [DF__ClaimBill__Total__74EE4BDE]
GO
ALTER TABLE [dbo].[ClaimBillingDetails] DROP CONSTRAINT [DF__ClaimBill__Patie__73FA27A5]
GO
ALTER TABLE [dbo].[ClaimBillingDetails] DROP CONSTRAINT [DF__ClaimBill__Insur__7306036C]
GO
ALTER TABLE [dbo].[ClaimBillingDetails] DROP CONSTRAINT [DF__ClaimBill__Patie__7211DF33]
GO
ALTER TABLE [dbo].[ClaimBillingDetails] DROP CONSTRAINT [DF__ClaimBill__Patie__711DBAFA]
GO
ALTER TABLE [dbo].[ClaimBillingDetails] DROP CONSTRAINT [DF__ClaimBill__Insur__702996C1]
GO
ALTER TABLE [dbo].[ClaimBillingDetails] DROP CONSTRAINT [DF__ClaimBill__Insur__6F357288]
GO
ALTER TABLE [dbo].[ClaimBillingDetails] DROP CONSTRAINT [DF__ClaimBill__Allow__6E414E4F]
GO
ALTER TABLE [dbo].[ClaimBillingDetails] DROP CONSTRAINT [DF__ClaimBill__Bille__6D4D2A16]
GO
ALTER TABLE [dbo].[BillingProviderMaster] DROP CONSTRAINT [DF__BillingPr__Creat__6C5905DD]
GO
ALTER TABLE [dbo].[BillingProviderMaster] DROP CONSTRAINT [DF__BillingPr__IsAct__6B64E1A4]
GO
ALTER TABLE [dbo].[BillingMaster] DROP CONSTRAINT [DF_BillingMaster_UpdatedOn]
GO
ALTER TABLE [dbo].[BillingMaster] DROP CONSTRAINT [DF_BillingMaster_CreatedOn]
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
/****** Object:  Table [dbo].[PolicyStatuses]******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[PolicyStatuses]') AND type in (N'U'))
DROP TABLE [dbo].[PolicyStatuses]
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
/****** Object:  Table [dbo].[NexusStaging]******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[NexusStaging]') AND type in (N'U'))
DROP TABLE [dbo].[NexusStaging]
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
/****** Object:  Table [dbo].[ClinicTypes]******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ClinicTypes]') AND type in (N'U'))
DROP TABLE [dbo].[ClinicTypes]
GO
/****** Object:  Table [dbo].[ClinicMaster]******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ClinicMaster]') AND type in (N'U'))
DROP TABLE [dbo].[ClinicMaster]
GO
/****** Object:  Table [dbo].[ClientBillingSheet]******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ClientBillingSheet]') AND type in (N'U'))
DROP TABLE [dbo].[ClientBillingSheet]
GO
/****** Object:  Table [dbo].[ClaimsProdStatus]******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ClaimsProdStatus]') AND type in (N'U'))
DROP TABLE [dbo].[ClaimsProdStatus]
GO
/****** Object:  Table [dbo].[ClaimsLevelStatus]******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ClaimsLevelStatus]') AND type in (N'U'))
DROP TABLE [dbo].[ClaimsLevelStatus]
GO
/****** Object:  Table [dbo].[ClaimDenialCodes]******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ClaimDenialCodes]') AND type in (N'U'))
DROP TABLE [dbo].[ClaimDenialCodes]
GO
/****** Object:  Table [dbo].[ClaimBillingDetails]******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ClaimBillingDetails]') AND type in (N'U'))
DROP TABLE [dbo].[ClaimBillingDetails]
GO
/****** Object:  Table [dbo].[BillingProviderMaster]******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[BillingProviderMaster]') AND type in (N'U'))
DROP TABLE [dbo].[BillingProviderMaster]
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
/****** Object:  Table [dbo].[DenialTrackingMaster]******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[DenialTrackingMaster]') AND type in (N'U'))
DROP TABLE [dbo].[DenialTrackingMaster]
GO
/****** Object:  Table [dbo].[BillingMaster]******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[BillingMaster]') AND type in (N'U'))
DROP TABLE [dbo].[BillingMaster]
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
    JOIN VisitAgaistAccessionStaging VS ON LIS.SampleID = VS.AccessionNo
    JOIN CustomCollectionStaging CCS ON VS.VisitNumber = CCS.VisitNumber
    WHERE LIS.SampleID = @AccessionNo
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
	[CreatedOn] [datetime] NOT NULL,
	[UpdatedOn] [datetime] NOT NULL,
	[ClaimSubStatus] [varchar](50) NULL,
	[PatientName] [nvarchar](255) NULL,
	[ReferringProviderId] [int] NULL,
	[FacilityId] [int] NULL,
	[PatientDOB] [date] NULL,
	[ResponsibleParty] [nvarchar](250) NULL,
	[ImportFileId] [int] NOT NULL,
	[BillingLab] [nvarchar](50) NULL,
	[CPTCodeDescription] [nvarchar](500) NULL,
	[PayerType] [nvarchar](500) NULL,
	[BillingProvider] [nvarchar](500) NULL,
	[PerformingLab] [nvarchar](500) NULL,
	[ReferringProvider] [nvarchar](500) NULL,
	[PanelCarrier] [nvarchar](255) NULL,
 CONSTRAINT [PK_BillingMaster] PRIMARY KEY CLUSTERED 
(
	[BillingMasterID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = ON) ON [PRIMARY]
) ON [PRIMARY]
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
	[BillingLab] [nvarchar](30) NULL,
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
	[BillingProvider_Trim]  AS (Trim([BillingProvider])) PERSISTED,
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
/****** Object:  Table [dbo].[ClaimDenialCodes]******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ClaimDenialCodes](
	[VisitNumber] [int] NOT NULL,
	[CPTCode] [nvarchar](20) NOT NULL,
	[DenialCode] [nvarchar](30) NOT NULL
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
/****** Object:  Table [dbo].[ClientBillingSheet]******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ClientBillingSheet](
	[CBSId] [int] IDENTITY(1,1) NOT NULL,
	[AccessionNo] [nvarchar](50) NOT NULL,
	[PerformingFacility] [nvarchar](150) NULL,
	[SheetName] [nvarchar](150) NULL,
	[ImportedFileID] [int] NULL,
	[ImportedOn] [datetime] NULL,
PRIMARY KEY CLUSTERED 
(
	[CBSId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
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
/****** Object:  Table [dbo].[ClinicTypes]******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ClinicTypes](
	[ClinicTypeId] [int] IDENTITY(1,1) NOT NULL,
	[ClinicTypeName] [nvarchar](500) NOT NULL,
	[IsActive] [bit] NOT NULL,
	[CreatedOn] [datetime] NULL,
PRIMARY KEY CLUSTERED 
(
	[ClinicTypeId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY],
UNIQUE NONCLUSTERED 
(
	[ClinicTypeName] ASC
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
	[PayerName_Trim]  AS (Trim([PayerName])) PERSISTED,
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
	[TestOrderHistoryId] [nvarchar](50) NULL,
	[AccessionNo] [nvarchar](50) NOT NULL,
	[CalimNote] [nvarchar](255) NULL,
	[VerificationStatus] [nvarchar](255) NULL,
	[ICDCodes] [nvarchar](1500) NULL,
	[ClinicType] [nvarchar](255) NULL,
	[Insurance] [nvarchar](255) NULL,
	[PrimaryInsurancePayer] [nvarchar](255) NULL,
	[BillingLab] [nvarchar](255) NULL,
	[PatientFirstName] [nvarchar](255) NULL,
	[PatientLastName] [nvarchar](255) NULL,
	[PatientDateOfBirth] [date] NULL,
	[PatientGender] [nvarchar](255) NULL,
	[PtRace] [nvarchar](255) NULL,
	[PtEthnicity] [nvarchar](255) NULL,
	[PatientID] [nvarchar](255) NULL,
	[PtStreetAddress] [nvarchar](255) NULL,
	[PtCity] [nvarchar](255) NULL,
	[PtState] [nvarchar](255) NULL,
	[PtZip] [nvarchar](255) NULL,
	[OrderInfo] [nvarchar](max) NULL,
	[TestCategory] [nvarchar](255) NULL,
	[CollectorName] [nvarchar](255) NULL,
	[Medications] [nvarchar](255) NULL,
	[SpecimenType] [nvarchar](255) NULL,
	[TestsOrdered] [nvarchar](max) NULL,
	[ClinicName] [nvarchar](255) NULL,
	[ClinicReferenceID] [nvarchar](255) NULL,
	[RPLastName] [nvarchar](255) NULL,
	[RPFirstName] [nvarchar](255) NULL,
	[RPNPI] [nvarchar](255) NULL,
	[SalesRepEmail] [nvarchar](255) NULL,
	[PerformingLab] [nvarchar](255) NULL,
	[InsuranceCode] [nvarchar](255) NULL,
	[BillingLab2] [nvarchar](255) NULL,
	[Entry_Status] [nvarchar](255) NULL,
	[SampleCollectionDate] [date] NULL,
	[SampleAccessionedDate] [date] NULL,
	[SampleSubmittedDate] [date] NULL,
	[LabId] [int] NULL,
	[BillingProviderID] [int] NULL,
	[ClinicId] [int] NULL,
	[SalesPersonId] [int] NULL,
	[OperationalGroupId] [int] NULL,
	[TestTypeId] [int] NULL,
	[PanelId] [int] NULL,
	[PanelCode] [nvarchar](255) NULL,
	[PanelName] [nvarchar](255) NULL,
	[ResultedStatus] [nvarchar](100) NULL,
	[DaystoReceive] [int] NULL,
	[DaystoResult] [int] NULL,
	[DaystoBill] [int] NULL,
	[ClientStatus] [nvarchar](250) NULL,
	[PayerTypeId] [int] NULL,
	[BillingSubStatus] [varchar](50) NULL,
	[BillingStatus] [varchar](50) NULL,
	[FirstBilledDateIH] [date] NULL,
	[ChargeEntryDateIH] [date] NULL,
	[FirstBilledDateDTR] [date] NULL,
	[ChargeEntryDateDTR] [date] NULL,
	[VisitNumberIH] [varchar](100) NULL,
	[VisitNumberDTR] [varchar](100) NULL,
	[FacilityId] [int] NULL,
	[ReferringProviderId] [int] NULL,
	[SampleStatusId] [int] NULL,
	[ImportedFileId] [int] NULL,
	[CreatedOn] [datetime] NULL,
	[UpdatedOn] [datetime] NULL,
	[LRNNoInsuranceInfo] [nvarchar](255) NULL,
	[TestName] [nvarchar](255) NULL,
	[BilledInHealthAMD] [nvarchar](255) NULL,
	[BilledDTRAMD] [nvarchar](255) NULL,
	[ChargeEnteredDTR] [nvarchar](255) NULL,
	[ChargeEnteredIH] [nvarchar](255) NULL,
	[NexumStatusIH] [nvarchar](255) NULL,
	[NexumStatusDTR] [nvarchar](255) NULL,
	[IsBilled] [nvarchar](50) NULL,
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
	[DiagnoseLISStagingId] [bigint] IDENTITY(1,1) NOT NULL,
	[ImportedFileID] [int] NULL,
	[TestOrderHistory82Id] [nvarchar](255) NULL,
	[Name] [nvarchar](255) NULL,
	[SampleID] [nvarchar](255) NULL,
	[DocRequest] [nvarchar](255) NULL,
	[InAppeals] [nvarchar](255) NULL,
	[ClaimDenied] [nvarchar](255) NULL,
	[UpdateDate] [nvarchar](255) NULL,
	[ClaimNote] [nvarchar](max) NULL,
	[Verified] [nvarchar](255) NULL,
	[ReverifyBy] [nvarchar](255) NULL,
	[PrimaryInsurance] [nvarchar](255) NULL,
	[InsuranceCode2] [nvarchar](255) NULL,
	[PayerCodeLookup] [nvarchar](255) NULL,
	[PayerCodeLookupLabel] [nvarchar](255) NULL,
	[PrimaryPolicyInformation] [nvarchar](255) NULL,
	[Note] [nvarchar](255) NULL,
	[BenefitsVerified] [nvarchar](255) NULL,
	[PVerifyCode] [nvarchar](255) NULL,
	[RequestBillingInfo] [nvarchar](255) NULL,
	[NoteToOfficeContact] [nvarchar](max) NULL,
	[Discovery] [nvarchar](255) NULL,
	[EligibilityPortal] [nvarchar](255) NULL,
	[ClearinghouseName] [nvarchar](255) NULL,
	[PortalName] [nvarchar](255) NULL,
	[HCPCS] [nvarchar](max) NULL,
	[ICD10] [nvarchar](max) NULL,
	[PracticeType] [nvarchar](255) NULL,
	[NonCoveredToxCodes] [nvarchar](max) NULL,
	[SendToBilling] [nvarchar](255) NULL,
	[HCPCS2] [nvarchar](max) NULL,
	[Insurance] [nvarchar](255) NULL,
	[BillingLab2] [nvarchar](255) NULL,
	[RegistrationID] [nvarchar](255) NULL,
	[WTHold] [nvarchar](255) NULL,
	[Rejected] [nvarchar](255) NULL,
	[PARRequired] [nvarchar](255) NULL,
	[AnnualTestCount] [nvarchar](255) NULL,
	[RegisteredDate] [nvarchar](255) NULL,
	[FirstName] [nvarchar](255) NULL,
	[LastName] [nvarchar](255) NULL,
	[DateOfBirth] [nvarchar](255) NULL,
	[Gender] [nvarchar](10) NULL,
	[Race] [nvarchar](255) NULL,
	[Ethnicity] [nvarchar](255) NULL,
	[PatientID] [nvarchar](255) NULL,
	[StreetAddress] [nvarchar](255) NULL,
	[City] [nvarchar](255) NULL,
	[State] [nvarchar](255) NULL,
	[Zip] [nvarchar](255) NULL,
	[PatientIDEntry] [nvarchar](255) NULL,
	[SecondaryInsurance] [nvarchar](255) NULL,
	[SecondaryPolicyInformation] [nvarchar](255) NULL,
	[VerifiedDate] [nvarchar](255) NULL,
	[NewPatient] [nvarchar](10) NULL,
	[EditPatient] [nvarchar](10) NULL,
	[LastTest] [nvarchar](255) NULL,
	[Order1] [nvarchar](max) NULL,
	[Reflex] [nvarchar](max) NULL,
	[TestCategory] [nvarchar](255) NULL,
	[EntryNumber] [nvarchar](255) NULL,
	[CollectionMedia] [nvarchar](255) NULL,
	[CollectedBy] [nvarchar](255) NULL,
	[Medications] [nvarchar](max) NULL,
	[OrderReason] [nvarchar](max) NULL,
	[SpecimenType] [nvarchar](255) NULL,
	[Components] [nvarchar](max) NULL,
	[OrderFormEntryNumber] [nvarchar](255) NULL,
	[CollectedTime] [nvarchar](255) NULL,
	[ElectronicSignature] [nvarchar](max) NULL,
	[Account] [nvarchar](255) NULL,
	[AccountID] [nvarchar](255) NULL,
	[ProviderLast] [nvarchar](255) NULL,
	[ProviderFirst] [nvarchar](255) NULL,
	[NPI] [nvarchar](255) NULL,
	[ParentCompany] [nvarchar](255) NULL,
	[ParentAccountID] [nvarchar](255) NULL,
	[AccountContactEmail] [nvarchar](255) NULL,
	[RepEmail] [nvarchar](255) NULL,
	[OrderIPAddress] [nvarchar](255) NULL,
	[PerformingLab] [nvarchar](255) NULL,
	[PerformingLabAddress] [nvarchar](500) NULL,
	[PerformingLabCLIA] [nvarchar](255) NULL,
	[BillingLabCLIA] [nvarchar](255) NULL,
	[ResultsPortal] [nvarchar](255) NULL,
	[BillingLabAddress] [nvarchar](500) NULL,
	[Division] [nvarchar](255) NULL,
	[IHBillingForDTR] [nvarchar](255) NULL,
	[EditLink] [nvarchar](255) NULL,
	[UploadToQbench] [nvarchar](10) NULL,
	[InsuranceCode] [nvarchar](255) NULL,
	[BillingLab] [nvarchar](255) NULL,
	[CPT] [nvarchar](max) NULL,
	[PatientRegisterLink] [nvarchar](1024) NULL,
	[ReqLink] [nvarchar](1024) NULL,
	[ResultLink] [nvarchar](1024) NULL,
	[ToxRules1] [nvarchar](255) NULL,
	[ToxRules2] [nvarchar](255) NULL,
	[ToxRules3] [nvarchar](255) NULL,
	[ToxRules4] [nvarchar](255) NULL,
	[ToxRules5] [nvarchar](255) NULL,
	[ToxGate1] [nvarchar](255) NULL,
	[ToxGate2] [nvarchar](255) NULL,
	[ToxApproved] [nvarchar](255) NULL,
	[PolicyNumberCharacteristics] [nvarchar](255) NULL,
	[ResultMatched] [nvarchar](255) NULL,
	[EntryStatus] [nvarchar](255) NULL,
	[EntryDatecreated] [nvarchar](255) NULL,
	[EntryDatesubmitted] [nvarchar](255) NULL,
	[EntryDateupdated] [nvarchar](255) NULL,
	[ImportedOn] [nvarchar](255) NULL,
PRIMARY KEY CLUSTERED 
(
	[DiagnoseLISStagingId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[NexusStaging]******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[NexusStaging](
	[NexusStagingID] [int] IDENTITY(1,1) NOT NULL,
	[NexusID] [int] NULL,
	[Created] [nvarchar](255) NULL,
	[Accession] [nvarchar](255) NULL,
	[TestTypes] [nvarchar](255) NULL,
	[DateOfService] [nvarchar](255) NULL,
	[Stage] [nvarchar](255) NULL,
	[NexusStatus] [nvarchar](255) NULL,
	[Detail] [nvarchar](255) NULL,
	[Assigned] [nvarchar](255) NULL,
	[PerformingLab] [nvarchar](255) NULL,
	[Client] [nvarchar](255) NULL,
	[Account] [nvarchar](255) NULL,
	[RFProvider] [nvarchar](255) NULL,
	[ProviderNPI] [nvarchar](255) NULL,
	[Patient] [nvarchar](255) NULL,
	[Insurance] [nvarchar](255) NULL,
	[Edit] [nvarchar](255) NULL,
	[ProcedureCPT] [nvarchar](255) NULL,
	[PatientFirstName] [nvarchar](255) NULL,
	[PatientLastName] [nvarchar](255) NULL,
	[PatientSex] [nvarchar](255) NULL,
	[PatientDOB] [nvarchar](255) NULL,
	[ICD10Codes] [nvarchar](255) NULL,
	[InsuranceID] [nvarchar](255) NULL,
	[ImportedFileID] [int] NULL,
	[ImportedOn] [datetime] NULL,
PRIMARY KEY CLUSTERED 
(
	[NexusStagingID] ASC
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
	[PanelCategory] [nvarchar](250) NULL,
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
	[PayerType_Trim]  AS (Trim([PayerType])) PERSISTED,
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
/****** Object:  Table [dbo].[PolicyStatuses]******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[PolicyStatuses](
	[PolicyStatusId] [int] IDENTITY(1,1) NOT NULL,
	[PolicyStatus] [nvarchar](500) NOT NULL,
	[IsActive] [bit] NOT NULL,
	[CreatedOn] [datetime] NULL,
PRIMARY KEY CLUSTERED 
(
	[PolicyStatusId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY],
UNIQUE NONCLUSTERED 
(
	[PolicyStatus] ASC
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
	[ReferringProviderName_Trim]  AS (Trim([ReferringProviderName])) PERSISTED,
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
ALTER TABLE [dbo].[BillingMaster] ADD  CONSTRAINT [DF_BillingMaster_CreatedOn]  DEFAULT (getdate()) FOR [CreatedOn]
GO
ALTER TABLE [dbo].[BillingMaster] ADD  CONSTRAINT [DF_BillingMaster_UpdatedOn]  DEFAULT (getdate()) FOR [UpdatedOn]
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
ALTER TABLE [dbo].[ClientBillingSheet] ADD  DEFAULT (getdate()) FOR [ImportedOn]
GO
ALTER TABLE [dbo].[ClinicMaster] ADD  DEFAULT ((1)) FOR [ClinicStatus]
GO
ALTER TABLE [dbo].[ClinicMaster] ADD  DEFAULT (getdate()) FOR [CreatedOn]
GO
ALTER TABLE [dbo].[ClinicTypes] ADD  DEFAULT ((1)) FOR [IsActive]
GO
ALTER TABLE [dbo].[ClinicTypes] ADD  DEFAULT (getdate()) FOR [CreatedOn]
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
ALTER TABLE [dbo].[LISMaster] ADD  DEFAULT (getdate()) FOR [UpdatedOn]
GO
ALTER TABLE [dbo].[LISStaging] ADD  DEFAULT (getdate()) FOR [ImportedOn]
GO
ALTER TABLE [dbo].[NexusStaging] ADD  DEFAULT (getdate()) FOR [ImportedOn]
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
ALTER TABLE [dbo].[PolicyStatuses] ADD  DEFAULT ((1)) FOR [IsActive]
GO
ALTER TABLE [dbo].[PolicyStatuses] ADD  DEFAULT (getdate()) FOR [CreatedOn]
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
ALTER TABLE [dbo].[BillingMaster]  WITH CHECK ADD  CONSTRAINT [FK_BillingMaster_BillingProvider] FOREIGN KEY([BillingProviderID])
REFERENCES [dbo].[BillingProviderMaster] ([BillingProviderID])
GO
ALTER TABLE [dbo].[BillingMaster] CHECK CONSTRAINT [FK_BillingMaster_BillingProvider]
GO
ALTER TABLE [dbo].[BillingMaster]  WITH CHECK ADD  CONSTRAINT [FK_BillingMaster_PayerType] FOREIGN KEY([PayerTypeId])
REFERENCES [dbo].[PayerTypeMaster] ([PayerTypeId])
GO
ALTER TABLE [dbo].[BillingMaster] CHECK CONSTRAINT [FK_BillingMaster_PayerType]
GO
ALTER TABLE [dbo].[BillingMaster]  WITH CHECK ADD  CONSTRAINT [FK_BillingMaster_PrimaryPayer] FOREIGN KEY([PrimaryPayerID])
REFERENCES [dbo].[InsurancePayerMaster] ([InsurancePayerId])
GO
ALTER TABLE [dbo].[BillingMaster] CHECK CONSTRAINT [FK_BillingMaster_PrimaryPayer]
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
ALTER TABLE [dbo].[BillingMaster]  WITH CHECK ADD  CONSTRAINT [CK_BillingMaster_NonNegativeAmounts] CHECK  ((isnull([BilledAmount],(0))>=(0) AND isnull([AllowedAmount],(0))>=(0) AND isnull([InsurancePayment],(0))>=(0) AND isnull([InsuranceAdjustment],(0))>=(0) AND isnull([PatientPaidAmount],(0))>=(0) AND isnull([PatientAdjustment],(0))>=(0) AND isnull([InsuranceBalance],(0))>=(0) AND isnull([PatientBalance],(0))>=(0) AND isnull([TotalBalance],(0))>=(0)))
GO
ALTER TABLE [dbo].[BillingMaster] CHECK CONSTRAINT [CK_BillingMaster_NonNegativeAmounts]
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
        PatientID ChartNum,
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
        TotalBalance,ImportedFileID,
		LTRIM(RTRIM(SUBSTRING(BilledCPTCode, 8, LEN(BilledCPTCode)))) AS CPTCodeDescription
		
    INTO #CustomCollectionData
    FROM CustomCollectionStaging WHERE (ImportedFileID = @FileId OR @FileId IS NULL);

	  select distinct VisitNo,CPTCode,Units,TotalBilledAmount INTO #TransData from TransactionMaster 
	where TransactionType = 'Charge' and TotalBilledAmount > 0 and void is null 


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
		ChartNum,
        PatientName,
		RP.ReferingProviderId,
		ImportedFileID,
		ResponsibleParty,
		DOB PatientDOB,
		Lab.LabId FacilityId,
		ISNULL(CC.Modifier,0) Modifier,
        CC.BilledAmount AS BilledAmount,
        CC.AllowedAmount AS AllowedAmount,
        CC.InsurancePayments AS InsurancePayments,
        CC.InsuranceAdjustments AS InsuranceAdjustments,
        CC.PatientPayments AS PatientPayments,
        CC.PatientAdjustments AS PatientAdjustments,
        CC.InsuranceBalance AS InsuranceBalance,
        CC.PatientBalance AS PatientBalance,
        CC.TotalBalance AS TotalBalance,
		CC.PayerType,CC.BillingProvider,CC.PerformingLab,cc.ReferringProvider,
		CC.CPTCodeDescription,CC.PayerName PanelCarrier
    INTO #BillingMaster
    FROM #CustomCollectionData CC
	--LEFT JOIN #VAATemp vaa ON CC.VisitNumber = vaa.VisitNumber
    LEFT JOIN InsurancePayerMaster IPM ON TRIM(CC.PayerName) = TRIM(IPM.PayerName)
    LEFT JOIN PayerTypeMaster PT ON TRIM(CC.PayerType) = TRIM(PT.PayerType)
    LEFT JOIN BillingProviderMaster BP ON TRIM(CC.BillingProvider) = TRIM(BP.BillingProvider)
	LEFT JOIN ReferringProviderMaster RP on TRIM(CC.ReferringProvider) = TRIM(RP.ReferringProviderName)
	LEFT JOIN LabMaster Lab on TRIM(CC.PerformingLab) = TRIM(Lab.LabName)
  
    -- Step 4: Merge
	Declare @LabName NVARCHAR(50);

	IF (Select FileType from ImportedFiles Where ImportedFileID = @FileId) = 202
		SET @LabName = 'In Health'
	ELSE IF (Select FileType from ImportedFiles Where ImportedFileID = @FileId) = 203
		SET @LabName = 'DTR'

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
				PatientName,
				ReferringProviderId,
				FacilityId,
				PatientDOB,
				ResponsibleParty,
				ImportFileId,
				ChartNumber,
				BillingLab,
				CPTCodeDescription,PayerType,BillingProvider,PerformingLab,ReferringProvider,PanelCarrier
            )
			SELECT VisitNumber,InsurancePayerId,PayerTypeId,BillingProviderID,ClientAccNum,MemberID,BeginDOS,EndDOS,
			ChargeEntryDate,FirstBillDate,BillingFrequency,ChargeEnteredBy,CPTCode,POS,TOS,Modifier,ICD10Code,BilledAmount,AllowedAmount,InsurancePayments,
			InsuranceAdjustments,PatientPayments,PatientAdjustments,InsuranceBalance,PatientBalance,TotalBalance,
			PatientName,ReferingProviderId,FacilityId,PatientDOB,ResponsibleParty,ImportedFileID,ChartNum,@LabName,
			CPTCodeDescription,PayerType,BillingProvider,PerformingLab,ReferringProvider,PanelCarrier FROM #BillingMaster BM 

			UPDATE BM SET BM.AccessionNo = vaa.AccessionNo FROM BillingMaster BM 
			JOIN VAAMaster vaa ON BM.VisitNumber = VAA.VisitNumber

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

        COMMIT TRANSACTION;

		EXEC sp_ClaimLevelStatusUpdate;
		EXEC SP_ProcessVAAvsLIS;
		EXEC SP_ProcessLISvsBilling;
		EXEC sp_Process_FinalCalimStatus;
		EXEC sp_ClaimBillingDetails @FileId;

    END TRY
    BEGIN CATCH
        ROLLBACK TRANSACTION;
        PRINT 'Error during MERGE: ' + ERROR_MESSAGE();
     	 DECLARE @ErrorMessage NVARCHAR(MAX) = ERROR_MESSAGE();
       
        INSERT INTO ImportFileLogs (ImportFileId, LogType, LogMessage, CreatedOn)
        VALUES (@FileId, 'ERROR', @ErrorMessage, GETDATE());
			update ImportedFiles set FileStatus = 2,ProcessedOn = GETDATE() where ImportedFileID = @FileId;
    END CATCH;
END;
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
-------Rule Id : 1 Fully Adjusted: Total Charge = Carrier WO No denial code
WHEN FirstBillDate IS NOT NULL and BilledAmount = InsuranceAdjustment and DenailCode IS NULL THEN 'Fully Adjusted' 

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
WHEN FirstBillDate IS NOT NULL AND InsurancePayment = 0 AND PatientPaidAmount > 0 and PatientBalance = 0 AND InsuranceBalance > 0 THEN 'Partial Payment'

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
		--RT.RequisitionTypeName,
		CAST(B.PatientDOB AS DATE) AS  PatientDOB, 
        PanelCarrier PayerName,
        PayerType,
        BillingProvider,
		CAST(BeginDOS AS DATE) AS   BeginDOS,
		CAST(EndDOS AS DATE) AS   EndDOS,
		CAST(b.ChargeEntryDate AS DATE) AS    ChargeEntryDate,
		CAST(FirstBillDate AS DATE) AS      FirstBillDate,
		ISNULL(l.PanelCode, 'No Panel Located') AS PanelGroup,
		POS,
		TOS,
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
		l.BillingLab Facility,
		cm.ClinicName,
		l.SalesRepEmail SalesPersonName,
		--og.OperationsGroup,
		--tt.TestTypeName TestType,
		ReferringProvider ReferringProviderName,
		b.ClaimSubStatus BillingSubStatus,
		CASE WHEN b.AccessionNo is null then 'Missing LIS Data' else '' end LISMissingRecord,
		b.BillingLab

    FROM BillingMaster b
    LEFT JOIN LISMaster l ON b.AccessionNo = l.AccessionNo AND l.Entry_Status <> 'Incomplete'
	LEFT JOIN #DenialCodeMaster dt on b.VisitNumber = dt.VisitNumber AND b.CPTCode = dt.CPTCodes
	--LEFT JOIN RequisitionTypes RT on l.RequistionTypeId = RT.RequisitionTypeId
    --LEFT JOIN OperationsGroupMaster OG ON l.OperationalGroupId = OG.OperationGroupID 
    --LEFT JOIN TestTypeMaster TT ON l.TestTypeId = TT.TestTypeId
	--LEFT JOIN SalesPerson SP ON L.SalesPersonId = SP.SalesPersonID
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
        LIS.SampleCollectionDate,
        BM.ReferringProvider,
       	isnull(LIS.PanelCode, 'No Panel Located') AS PanelName,
		BM.PerformingLab,lis.SalesRepEmail SalesPersonName,BM.BillingLab,
        ROW_NUMBER() OVER (
            PARTITION BY BM.VisitNumber 
              ORDER BY 
                CASE WHEN BM.FirstBillDate IS NULL THEN 1 ELSE 0 END,  -- push NULLs last
                BM.FirstBillDate
        ) AS rn
    FROM BillingMaster BM
    LEFT JOIN LISMaster LIS WITH (NOLOCK) 
        ON BM.AccessionNo = LIS.AccessionNo AND LIS.Entry_Status <> 'Incomplete'
    LEFT JOIN TestTypeMaster TT 
        ON LIS.TestTypeId = TT.TestTypeId
   		--LEFT JOIN RequisitionTypes rt ON LIS.RequistionTypeId = rt.RequisitionTypeId
		LEFT JOIN ClinicMaster CM ON LIS.ClinicId = CM.ClinicId
		--LEFT JOIN SalesPerson SP ON LIS.SalesPersonId = SP.SalesPersonID
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
		--md.RequisitionTypeName,
		md.SalesPersonName,
		md.ClinicName,
        md.PerformingLab AS Facility,
        CONVERT(VARCHAR, md.BeginDOS, 101)  AS BeginDOS,
        DATEDIFF(DAY, md.SampleCollectionDate, GETDATE()) AS Aging,
        CASE 
            WHEN DATEDIFF(DAY, md.SampleCollectionDate, GETDATE()) <= 30 THEN 'Current'
            WHEN DATEDIFF(DAY, md.SampleCollectionDate, GETDATE()) <= 60 THEN '30 +'
            WHEN DATEDIFF(DAY, md.SampleCollectionDate, GETDATE()) <= 90 THEN '60 +'
            WHEN DATEDIFF(DAY, md.SampleCollectionDate, GETDATE()) <= 120 THEN '90 +'
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
        CASE WHEN DATEDIFF(DAY, md.SampleCollectionDate, md.FirstBillDate) <= 30 THEN '30 Days Count' ELSE NULL END AS T30DaysCount,
        CASE WHEN DATEDIFF(DAY, md.SampleCollectionDate, md.FirstBillDate) <= 30 THEN (BA.InsurancePayment + BA.PatientPaidAmount) ELSE NULL END AS T30Amount,
        CASE WHEN DATEDIFF(DAY, md.SampleCollectionDate, md.FirstBillDate) BETWEEN 31 AND 60 THEN '60 Days Count' ELSE NULL END AS T60DaysCount,
        CASE WHEN DATEDIFF(DAY, md.SampleCollectionDate, md.FirstBillDate) BETWEEN 31 AND 60 THEN (BA.InsurancePayment + BA.PatientPaidAmount) ELSE NULL END AS T60Amount,
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
		CASE WHEN md.AccessionNo is null then 'Missing LIS Data' else '' end LISMissingRecord,
		Md.BillingLab
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
        @ActualStartDate = ISNULL(@StartDate, MIN(SampleCollectionDate)),
        @ActualEndDate = ISNULL(@EndDate, MAX(SampleCollectionDate))
    FROM LISMaster;

    -- Main query with date filtering
    SELECT 
        AccessionNo,
        --Note ClaimNote,
		VerificationStatus,
		ICDCodes ICD10Codes,
		ClinicType,
		PrimaryInsurancePayer [PrimaryPayerName],
		Insurance,
		InsuranceCode,
        --PrimaryPolicyInformation PrimaryMemberId,
		LAB.LabName BillingLab,
        (LIS.PatientLastName+', '+LIS.PatientFirstName) PatientName,
		CONVERT(VARCHAR, PatientDateOfBirth, 101)   PatientDateOfBirth,	
		PtStreetAddress PatientAddress,
		PtCity PatientCity,
		PtState PatientState,
		PtZip PatientZip,
		CONVERT(VARCHAR, SampleCollectionDate, 101)   SampleCollectedDate,
		CONVERT(VARCHAR, SampleAccessionedDate, 101) AS SampleAccessionedDate,
		CONVERT(VARCHAR, SampleSubmittedDate, 101)   AS SampleSubmittedDate,
		PanelCode PanelGroup,
		--TestName,
		--LIS.PanelName,
		TestName TestCategory,
		CollectorName,
		Medications,
		SpecimenType,
		TestsOrdered,
		OrderInfo,
		LIS.ClinicName,
		LIS.ClinicReferenceID ClinicId,
		ReferringProviderName,
		RPNPI ReferringProviderNPI,
		SalesRepEmail SalesRep,
		BP.BillingProvider,
		PerformingLab,
		ResultedStatus,
		IsBilled [Billed / Un-Billed],
        SS.SpecimenStatusName,
  --      OG.OperationsGroup,
		--pg.PanelCategory PanelGroup,
        CASE WHEN DaystoReceive = 0 THEN 1 ELSE DaystoReceive END DaystoReceive ,
        CASE WHEN DaystoResult = 0 THEN 1 ELSE DaystoResult END DaystoResult  ,
        CASE WHEN DaystoBill = 0 THEN 1 ELSE DaystoBill END DaystoBill ,
        ClientStatus,
        VisitNumberIH [Billed - Inhealth AMD],
		VisitNumberDTR [Billed - DTR AMD],
		BillingSubStatus,
        LIS.BillingStatus,
		CONVERT(VARCHAR, LIS.FirstBilledDateIH, 101) [Billed Date-IH AMD],
		CONVERT(VARCHAR, LIS.FirstBilledDateDTR, 101) [Billed Date-DTR AMD],
		CONVERT(VARCHAR, LIS.ChargeEntryDateIH, 101) ChargeEntryDateIH,
		CONVERT(VARCHAR, LIS.ChargeEntryDateDTR, 101) ChargeEntryDateDTR,
		LRNNoInsuranceInfo,
		--TestName,
		--BilledInHealthAMD,
		--BilledDTRAMD,
		--ChargeEnteredDTR,
		--ChargeEnteredIH,
		NexumStatusIH,
		NexumStatusDTR
    FROM LISMaster LIS
    LEFT JOIN LabMaster LAB ON LIS.LabId = LAB.LabID
    LEFT JOIN BillingProviderMaster BP ON LIS.BillingProviderID = BP.BillingProviderID 
    LEFT JOIN SpecimenStatus SS ON LIS.SampleStatusId = SS.SpecimenStatusId 
    --LEFT JOIN OperationsGroupMaster OG ON LIS.OperationalGroupId = OG.OperationGroupID 
    --LEFT JOIN PanelGroup PG ON LIS.PanelId = PG.PanelGroupId
    LEFT JOIN ReferringProviderMaster RP ON LIS.ReferringProviderId = RP.ReferingProviderId
    --LEFT JOIN PayerTypeMaster PT ON LIS.PayerTypeId = PT.PayerTypeId
	--LEFT JOIN InsurancePayerMaster IPM ON LIS.PrimaryInsuranceId = IPM.InsurancePayerId
    WHERE 
        CAST(SampleCollectionDate AS DATE) BETWEEN @ActualStartDate AND @ActualEndDate;
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
		--RT.RequisitionTypeName,
		CAST(B.PatientDOB AS DATE) AS  PatientDOB, 
        PanelCarrier PayerName,
        PayerType,
        BillingProvider,
		CAST(BeginDOS AS DATE) AS   BeginDOS,
		CAST(EndDOS AS DATE) AS   EndDOS,
		CAST(b.ChargeEntryDate AS DATE) AS    ChargeEntryDate,
		CAST(FirstBillDate AS DATE) AS      FirstBillDate,
		ISNULL(l.PanelCode, 'No Panel Located') AS PanelGroup,
		POS,
		TOS,
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
		l.BillingLab Facility,
		cm.ClinicName,
		l.SalesRepEmail SalesPersonName,
		--og.OperationsGroup,
		--tt.TestTypeName TestType,
		ReferringProvider ReferringProviderName,
		b.ClaimSubStatus BillingSubStatus,
		CASE WHEN b.AccessionNo is null then 'Missing LIS Data' else '' end LISMissingRecord,
		b.BillingLab

    FROM BillingMaster b
    LEFT JOIN LISMaster l ON b.AccessionNo = l.AccessionNo AND l.Entry_Status <> 'Incomplete'
	LEFT JOIN #DenialCodeMaster dt on b.VisitNumber = dt.VisitNumber AND b.CPTCode = dt.CPTCodes
	--LEFT JOIN RequisitionTypes RT on l.RequistionTypeId = RT.RequisitionTypeId
    --LEFT JOIN OperationsGroupMaster OG ON l.OperationalGroupId = OG.OperationGroupID 
    --LEFT JOIN TestTypeMaster TT ON l.TestTypeId = TT.TestTypeId
	--LEFT JOIN SalesPerson SP ON L.SalesPersonId = SP.SalesPersonID
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
        LIS.SampleCollectionDate,
        BM.ReferringProvider,
       	isnull(LIS.PanelCode, 'No Panel Located') AS PanelName,
		BM.PerformingLab,lis.SalesRepEmail SalesPersonName,BM.BillingLab,
        ROW_NUMBER() OVER (
            PARTITION BY BM.VisitNumber 
              ORDER BY 
                CASE WHEN BM.FirstBillDate IS NULL THEN 1 ELSE 0 END,  -- push NULLs last
                BM.FirstBillDate
        ) AS rn
    FROM BillingMaster BM
    LEFT JOIN LISMaster LIS WITH (NOLOCK) 
        ON BM.AccessionNo = LIS.AccessionNo AND LIS.Entry_Status <> 'Incomplete'
    LEFT JOIN TestTypeMaster TT 
        ON LIS.TestTypeId = TT.TestTypeId
   		--LEFT JOIN RequisitionTypes rt ON LIS.RequistionTypeId = rt.RequisitionTypeId
		LEFT JOIN ClinicMaster CM ON LIS.ClinicId = CM.ClinicId
		--LEFT JOIN SalesPerson SP ON LIS.SalesPersonId = SP.SalesPersonID
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
		--md.RequisitionTypeName,
		md.SalesPersonName,
		md.ClinicName,
        md.PerformingLab AS Facility,
        CONVERT(VARCHAR, md.BeginDOS, 101)  AS BeginDOS,
        DATEDIFF(DAY, md.SampleCollectionDate, GETDATE()) AS Aging,
        CASE 
            WHEN DATEDIFF(DAY, md.SampleCollectionDate, GETDATE()) <= 30 THEN 'Current'
            WHEN DATEDIFF(DAY, md.SampleCollectionDate, GETDATE()) <= 60 THEN '30 +'
            WHEN DATEDIFF(DAY, md.SampleCollectionDate, GETDATE()) <= 90 THEN '60 +'
            WHEN DATEDIFF(DAY, md.SampleCollectionDate, GETDATE()) <= 120 THEN '90 +'
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
        CASE WHEN DATEDIFF(DAY, md.SampleCollectionDate, md.FirstBillDate) <= 30 THEN '30 Days Count' ELSE NULL END AS T30DaysCount,
        CASE WHEN DATEDIFF(DAY, md.SampleCollectionDate, md.FirstBillDate) <= 30 THEN (BA.InsurancePayment + BA.PatientPaidAmount) ELSE NULL END AS T30Amount,
        CASE WHEN DATEDIFF(DAY, md.SampleCollectionDate, md.FirstBillDate) BETWEEN 31 AND 60 THEN '60 Days Count' ELSE NULL END AS T60DaysCount,
        CASE WHEN DATEDIFF(DAY, md.SampleCollectionDate, md.FirstBillDate) BETWEEN 31 AND 60 THEN (BA.InsurancePayment + BA.PatientPaidAmount) ELSE NULL END AS T60Amount,
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
		CASE WHEN md.AccessionNo is null then 'Missing LIS Data' else '' end LISMissingRecord,
		Md.BillingLab
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
SELECT DISTINCT LTRIM(RTRIM(Account)),1 FROM LISStaging 
WHERE LTRIM(RTRIM(Account)) NOT IN (SELECT DISTINCT ClinicName FROM [ClinicMaster]) AND Account IS NOT NULL

--PRINT '[ClinicMaster] Inserted Completed'

INSERT INTO [dbo].[SpecimenStatus]([SpecimenStatusName],[IsActive])
SELECT DISTINCT LTRIM(RTRIM(EntryStatus)),1 FROM LISStaging 
WHERE LTRIM(RTRIM(EntryStatus)) NOT IN (SELECT DISTINCT [SpecimenStatusName] FROM [SpecimenStatus]) AND EntryStatus IS NOT NULL

--PRINT '[SpecimenStatu] Inserted Completed'



INSERT INTO [dbo].[TestTypeMaster]([TestTypeName],[IsActive])
SELECT DISTINCT LTRIM(RTRIM(TestCategory)),1 FROM LISStaging 
WHERE LTRIM(RTRIM(TestCategory)) NOT IN (SELECT DISTINCT [TestTypeName] FROM [TestTypeMaster]) AND TestCategory IS NOT NULL

--PRINT '[TestTypeMaster] Inserted Completed'

 


INSERT INTO [dbo].[InsurancePayerMaster]([PayerName],[IsActive])
SELECT DISTINCT LTRIM(RTRIM(Insurance)),1 FROM LISStaging 
WHERE LTRIM(RTRIM(Insurance)) NOT IN (SELECT DISTINCT [PayerName] FROM [InsurancePayerMaster]) AND Insurance IS NOT NULL



INSERT INTO [dbo].LabMaster(LabName,[IsActive])
SELECT DISTINCT LTRIM(RTRIM(BillingLab2)),1 FROM LISStaging 
WHERE LTRIM(RTRIM(BillingLab2)) NOT IN (SELECT DISTINCT LabName FROM LabMaster) AND BillingLab2 IS NOT NULL
UNION 
SELECT DISTINCT LTRIM(RTRIM(PerformingLab)),1 FROM LISStaging 
WHERE LTRIM(RTRIM(PerformingLab)) NOT IN (SELECT DISTINCT LabName FROM LabMaster) AND PerformingLab IS NOT NULL

INSERT INTO [dbo].ReferringProviderMaster(ReferringProviderName,[IsActive])
SELECT DISTINCT LTRIM(RTRIM((ProviderLast+', '+ ProviderFirst))),1 FROM LISStaging 
WHERE LTRIM(RTRIM((ProviderLast+', '+ ProviderFirst))) NOT IN (SELECT DISTINCT ReferringProviderName FROM ReferringProviderMaster) AND  LTRIM(RTRIM((ProviderLast+', '+ ProviderFirst)))  IS NOT NULL


INSERT INTO [dbo].[ClinicTypes]
           ([ClinicTypeName],[IsActive],[CreatedOn])
SELECT DISTINCT LTRIM(RTRIM(PracticeType)),1,GETDATE() FROM LISStaging 
WHERE LTRIM(RTRIM(PracticeType)) NOT IN (SELECT DISTINCT [ClinicTypeName] FROM [ClinicTypes]) AND PracticeType IS NOT NULL 


INSERT INTO [dbo].[InsurancePayerMaster]([PayerName],[IsActive])
SELECT DISTINCT LTRIM(RTRIM(PayerName)),1 FROM CustomCollectionStaging 
WHERE LTRIM(RTRIM(PayerName)) NOT IN (SELECT DISTINCT [PayerName] FROM [InsurancePayerMaster]) AND PayerName IS NOT NULL

INSERT INTO [dbo].[PolicyStatuses]
           ([PolicyStatus],[IsActive],[CreatedOn])
SELECT DISTINCT LTRIM(RTRIM(BenefitsVerified)),1,GETDATE() FROM LISStaging 
WHERE LTRIM(RTRIM(BenefitsVerified)) NOT IN (SELECT DISTINCT [PolicyStatus] FROM [PolicyStatuses]) AND BenefitsVerified IS NOT NULL 


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

		
	DROP TABLE IF EXISTS #LISMaster;

		SELECT [TestOrderHistory82Id],[SampleID],[ClaimNote],[BenefitsVerified],[ICD10],[PracticeType],PrimaryInsurance,[Insurance],[BillingLab2],LIS.[FirstName] PFirstName,
		LIS.[LastName] PLastName, TRY_CONVERT(date, NULLIF([DateOfBirth], '')) AS DateOfBirth,[Gender],[Race],[Ethnicity],[PatientID],[StreetAddress],
		[City],[State],[Zip],[Order1] [OrderInfo],[TestCategory],[CollectedBy],[Medications],[SpecimenType],[Components],[Account],[AccountID],
		[ProviderLast],[ProviderFirst],[NPI],[RepEmail],[PerformingLab],[InsuranceCode],BillingLab,EntryStatus,
		  COALESCE(
			TRY_CONVERT(date, NULLIF([LastTest], ''), 23),  -- yyyy-mm-dd
			TRY_CONVERT(date, NULLIF([LastTest], ''), 121), -- ODBC canonical w/ ms
			TRY_CONVERT(date, NULLIF([LastTest], ''), 120), -- ODBC canonical
			TRY_CONVERT(date, NULLIF([LastTest], ''), 101), -- mm/dd/yyyy
			TRY_CONVERT(date, NULLIF([LastTest], ''), 103)  -- dd/MM/yyyy
		  ) AS LastTestDate,

		  COALESCE(
			TRY_CONVERT(date, NULLIF([EntryDatecreated], ''), 23),
			TRY_CONVERT(date, NULLIF([EntryDatecreated], ''), 121),
			TRY_CONVERT(date, NULLIF([EntryDatecreated], ''), 120),
			TRY_CONVERT(date, NULLIF([EntryDatecreated], ''), 101),
			TRY_CONVERT(date, NULLIF([EntryDatecreated], ''), 103)
		  ) AS EntryDateCreated,

		  COALESCE(
			TRY_CONVERT(date, NULLIF([EntryDatesubmitted], ''), 23),
			TRY_CONVERT(date, NULLIF([EntryDatesubmitted], ''), 121),
			TRY_CONVERT(date, NULLIF([EntryDatesubmitted], ''), 120),
			TRY_CONVERT(date, NULLIF([EntryDatesubmitted], ''), 101),
			TRY_CONVERT(date, NULLIF([EntryDatesubmitted], ''), 103)
		  ) AS EntryDateSubmitted,

		  COALESCE(
			TRY_CONVERT(date, NULLIF([EntryDateupdated], ''), 23),
			TRY_CONVERT(date, NULLIF([EntryDateupdated], ''), 121),
			TRY_CONVERT(date, NULLIF([EntryDateupdated], ''), 120),
			TRY_CONVERT(date, NULLIF([EntryDateupdated], ''), 101),
			TRY_CONVERT(date, NULLIF([EntryDateupdated], ''), 103)
		  ) AS EntryDateUpdated,

		  Lab.LabID, CM.ClinicId, SP.SalesPersonID, TTM.TestTypeId, RPM.ReferingProviderId, SS.SpecimenStatusId, LIS.ImportedFileID,
		  GETDATE() AS CreatedAt, GETDATE() AS UpdatedAt,
		  CASE WHEN PrimaryInsurance IS NULL THEN 'No Insurance Info' ELSE NULL END [LRNNoInsuranceInfo]
		  INTO #LISMaster
		FROM [dbo].[LISStaging] AS LIS
		LEFT JOIN InsurancePayerMaster IPM ON LTRIM(RTRIM(LIS.PrimaryInsurance)) = IPM.PayerName
		LEFT JOIN LabMaster Lab         ON LTRIM(RTRIM(LIS.BillingLab))     = Lab.LabName
		LEFT JOIN ClinicMaster CM       ON LTRIM(RTRIM(LIS.Account))        = CM.ClinicName
		LEFT JOIN SalesPerson SP        ON LTRIM(RTRIM(LIS.[RepEmail]))     = SP.SalesPersonName
		LEFT JOIN [TestTypeMaster] TTM  ON LTRIM(RTRIM(LIS.TestCategory))   = TTM.TestTypeName
		LEFT JOIN ReferringProviderMaster RPM
			   ON LTRIM(RTRIM(LIS.ProviderLast + ', ' + LIS.ProviderFirst)) = RPM.ReferringProviderName
		LEFT JOIN SpecimenStatus SS     ON LTRIM(RTRIM(LIS.EntryStatus))    = SS.SpecimenStatusName
		WHERE LIS.ImportedFileID = @FileID;


		TRUNCATE TABLE LISMaster;

		INSERT INTO [dbo].[LISMaster]
		([TestOrderHistoryId],[AccessionNo],[CalimNote],[VerificationStatus],[ICDCodes],[ClinicType],Insurance,[BillingLab],[PatientFirstName],[PatientLastName]
		,[PatientDateOfBirth],[PatientGender],[PtRace],[PtEthnicity],[PatientID],[PtStreetAddress],[PtCity],[PtState],[PtZip],[OrderInfo],[TestCategory],[CollectorName]
		,[Medications],[SpecimenType],[TestsOrdered],[ClinicName],[ClinicReferenceID],[RPLastName],[RPFirstName],[RPNPI],[SalesRepEmail],[PerformingLab]
		,[InsuranceCode],[BillingLab2],[Entry_Status],[SampleCollectionDate],[SampleAccessionedDate],[SampleSubmittedDate],[LabId]
		,[ClinicId],[SalesPersonId],[TestTypeId],[FacilityId],[ReferringProviderId],[SampleStatusId],[ImportedFileId],[CreatedOn]
		,[UpdatedOn],[LRNNoInsuranceInfo],PrimaryInsurancePayer)

		SELECT TestOrderHistory82Id,SampleID,ClaimNote,[BenefitsVerified],ICD10,[PracticeType],Insurance,BillingLab,PFirstName,PLastName,
		DateOfBirth,Gender,Race,Ethnicity,PatientID,StreetAddress,City,[State],Zip,OrderInfo,TestCategory,CollectedBy,
		Medications,SpecimenType,[Components],Account,AccountID,ProviderFirst,ProviderLast,NPI,RepEmail,PerformingLab,
		InsuranceCode,BillingLab2,EntryStatus,LastTestDate,EntryDateCreated,EntryDateSubmitted,LabID,
		ClinicId,SalesPersonID,TestTypeId,LabID,ReferingProviderId,SpecimenStatusId,ImportedFileID,GETDATE(),GETDATE(),LRNNoInsuranceInfo,PrimaryInsurance
		FROM #LISMaster WHERE LastTestDate >= '2025-01-01'


		UPDATE LIS SET LIS.PanelId = PG.PanelGroupId,LIS.PanelName = PG.OrderInfo from LISMaster LIS
		Join PanelGroup PG on LIS.OrderInfo = PG.OrderInfo

		
--EXEC sp_GetLISMasterReportByDateRange 

		UPDATE LISMaster SET TestName = CASE 
		WHEN LTRIM(RTRIM(OrderInfo)) = 'VDX Screening + inSight Confirmation' THEN 'Clinical Toxicology' 
		WHEN LTRIM(RTRIM(OrderInfo)) = 'Urine Drug Screen + inSight Confirmation' THEN 'Clinical Toxicology' 
		WHEN LTRIM(RTRIM(OrderInfo)) = 'PO Urine Drug Screening + inSight Confirmation' THEN 'Clinical Toxicology' 
		WHEN LTRIM(RTRIM(OrderInfo)) = 'Wound Panel' THEN 'Molecular' 
		WHEN LTRIM(RTRIM(OrderInfo)) = 'Oral Drug Screen + inSight Confirmation' THEN 'Clinical Toxicology' 
		WHEN LTRIM(RTRIM(OrderInfo)) = 'inSight Urine Drug Confirmation Only' THEN 'Clinical Toxicology' 
		WHEN LTRIM(RTRIM(OrderInfo)) = 'UTI Panel' THEN 'Molecular' 
		WHEN LTRIM(RTRIM(OrderInfo)) = 'STI Panel' THEN 'Molecular' 
		WHEN LTRIM(RTRIM(OrderInfo)) = 'Respiratory Panel' THEN 'Molecular' 
		WHEN LTRIM(RTRIM(OrderInfo)) = 'Screening w/o THC' THEN 'Clinical Toxicology' 
		WHEN LTRIM(RTRIM(OrderInfo)) = 'PO Urine Drug Screening' THEN 'Clinical Toxicology' 
		WHEN LTRIM(RTRIM(OrderInfo)) = 'Keele Oral inSight Confirmation Only' THEN 'Clinical Toxicology' 
		WHEN LTRIM(RTRIM(OrderInfo)) = 'Oral Drug Screen and inSight Confirmation' THEN 'Clinical Toxicology' 
		ELSE 'No Test Located' END,PanelCode =  CASE
		WHEN LTRIM(RTRIM(OrderInfo)) = 'VDX Screening + inSight Confirmation' THEN 'Toxicology' 
		WHEN LTRIM(RTRIM(OrderInfo)) = 'Urine Drug Screen + inSight Confirmation' THEN 'Toxicology' 
		WHEN LTRIM(RTRIM(OrderInfo)) = 'PO Urine Drug Screening + inSight Confirmation' THEN 'Toxicology' 
		WHEN LTRIM(RTRIM(OrderInfo)) = 'Wound Panel' THEN 'Wound Panel' 
		WHEN LTRIM(RTRIM(OrderInfo)) = 'Oral Drug Screen + inSight Confirmation' THEN 'Toxicology' 
		WHEN LTRIM(RTRIM(OrderInfo)) = 'inSight Urine Drug Confirmation Only' THEN 'Toxicology' 
		WHEN LTRIM(RTRIM(OrderInfo)) = 'UTI Panel' THEN 'UTI Panel' 
		WHEN LTRIM(RTRIM(OrderInfo)) = 'STI Panel' THEN 'STI Panel' 
		WHEN LTRIM(RTRIM(OrderInfo)) = 'Respiratory Panel' THEN 'Respiratory Panel' 
		WHEN LTRIM(RTRIM(OrderInfo)) = 'Screening w/o THC' THEN 'Toxicology' 
		WHEN LTRIM(RTRIM(OrderInfo)) = 'PO Urine Drug Screening' THEN 'Toxicology' 
		WHEN LTRIM(RTRIM(OrderInfo)) = 'Keele Oral inSight Confirmation Only' THEN 'Toxicology' 
		WHEN LTRIM(RTRIM(OrderInfo)) = 'Oral Drug Screen and inSight Confirmation' THEN 'Toxicology' 
		ELSE 'No Panel Located' END
		FROM LISMaster 



	 update ImportedFiles set FileStatus = 1,ProcessedOn = GETDATE() where ImportedFileID = @FileId; 

        -- Commit the transaction if all steps succeed
        COMMIT TRANSACTION;

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

		

        -- Update the file status
        UPDATE ImportedFiles
        SET FileStatus = 1,ProcessedOn = GETDATE()   -- Adjust value to your desired status
        WHERE ImportedFileID = @FileId;



        COMMIT TRANSACTION;
		EXEC SP_ProcessVAAvsLIS;
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

	Declare @LabName NVARCHAR(50);

	IF (Select FileType from ImportedFiles Where ImportedFileID = @FileId) = 206
		SET @LabName = 'In Health'
	ELSE IF (Select FileType from ImportedFiles Where ImportedFileID = @FileId) = 206
		SET @LabName = 'DTR'

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

        
        
		DELETE FROM  DenialTrackingMaster WHERE BillingLab = @LabName;
       
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
                [DenialCategoryDEscription],
				BillingLab
            )
         SELECT dt.VisitNumber,CPTCode,TransactionCarrierCode,PaymentDate,PaymentReasonCode,ServiceDate,dt.Charge,TotalBalance,
		 TotalAdjustment,ReasonAmount,DenialUser,LastAction,LastActionDate,NextAction,NextActionDate,dt.Note,DenialCategoryCode,DenialCategoryDescription,@LabName
		 From #DenialTrackingDetail dt


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
        ;WITH CTE_BillingIH AS (
            SELECT
                VisitNumber,
                FirstBillDate,
                ChargeEntryDate,
                AccessionNo,
                ROW_NUMBER() OVER (
                    PARTITION BY VisitNumber, PayerTypeId, PrimaryPayerID, FirstBillDate, ChargeEntryDate
                    ORDER BY FirstBillDate
                ) AS RowNum
            FROM BillingMaster
            WHERE LTRIM(RTRIM(BillingLab)) = 'In Health'
        )
        UPDATE LIS
        SET
            VisitNumberIH     = SCD.VisitNumber,
            FirstBilledDateIH = SCD.FirstBillDate,
            ChargeEntryDateIH = SCD.ChargeEntryDate,
			BilledInHealthAMD = SCD.VisitNumber
        
		FROM [dbo].[LISMaster] LIS
        JOIN CTE_BillingIH SCD
          ON LTRIM(RTRIM(LIS.AccessionNo)) = LTRIM(RTRIM(SCD.AccessionNo));

        ;WITH CTE_BillingDTR AS (
            SELECT
                VisitNumber,
                FirstBillDate,
                ChargeEntryDate,
                AccessionNo,
                ROW_NUMBER() OVER (
                    PARTITION BY VisitNumber, PayerTypeId, PrimaryPayerID, FirstBillDate, ChargeEntryDate
                    ORDER BY FirstBillDate
                ) AS RowNum
            FROM BillingMaster
            WHERE LTRIM(RTRIM(BillingLab)) = 'DTR'
        )
        UPDATE LIS
        SET
            VisitNumberDTR     = SCD.VisitNumber,
            FirstBilledDateDTR = SCD.FirstBillDate,
            ChargeEntryDateDTR = SCD.ChargeEntryDate,
			BilledDTRAMD = SCD.VisitNumber
        FROM [dbo].[LISMaster] LIS
        JOIN CTE_BillingDTR SCD
          ON LTRIM(RTRIM(LIS.AccessionNo)) = LTRIM(RTRIM(SCD.AccessionNo));

        /*******************************************************************************************
         Step 4b: Derive ResultedStatus, BillingStatus, SubStatus, etc.
        ********************************************************************************************/
        UPDATE [dbo].[LISMaster]
        SET 
            ResultedStatus = CASE 
                WHEN LTRIM(RTRIM(Entry_Status)) = 'Sent to Billing' THEN 'Resulted'
                ELSE 'Not Resulted'
            END,
            BillingStatus = CASE 
                WHEN FirstBilledDateDTR IS NOT NULL OR FirstBilledDateIH IS NOT NULL THEN 'Billed' 
            END,
            BilledInHealthAMD = CASE WHEN VisitNumberIH IS NOT NULL THEN 'Billed In-Health AMD' ELSE NULL END,
            BilledDTRAMD      = CASE WHEN VisitNumberDTR IS NOT NULL THEN 'Billed DTR AMD' ELSE NULL END,
            ChargeEnteredIH   = CASE WHEN ChargeEntryDateIH IS NOT NULL THEN 'Charge Entered Date In-Health AMD' ELSE NULL END,
            ChargeEnteredDTR  = CASE WHEN ChargeEntryDateDTR IS NOT NULL THEN 'Charge Entered Date - DTR AMD' ELSE NULL END;

        -------------------------------------------------------------------------------
        -- 1) Billable vs Other Samples (baseline)
        -------------------------------------------------------------------------------
        UPDATE L
        SET BillingStatus =
            CASE 
                WHEN LTRIM(RTRIM(L.Entry_Status)) = 'Sent to Billing' THEN 'Billable'
                ELSE 'Other Samples'
            END
        FROM dbo.LISMaster AS L;

        -------------------------------------------------------------------------------
        -- 2) Duplicate
        --    If BillingStatus = 'Other Samples' AND Accession is duplicated anywhere,
        --    overwrite to 'Duplicate'. (Logic unchanged)
        -------------------------------------------------------------------------------
     
		-- Only flip rows that are currently "Other Samples"
		UPDATE LM
		   SET BillingStatus    = 'Duplicate',
			   BillingSubStatus = 'Requires Review'
		FROM dbo.LISMaster AS LM
		WHERE LTRIM(RTRIM(LM.BillingStatus)) = 'Other Samples'
		  AND LM.LISMasterId IN
		  (
			  SELECT LISMasterId
			  FROM dbo.LISMaster AS X
			  WHERE LTRIM(RTRIM(X.AccessionNo)) = LTRIM(RTRIM(LM.AccessionNo))
				AND (
					  LTRIM(RTRIM(X.BillingStatus)) <> 'Other Samples'
					  OR LTRIM(RTRIM(X.Entry_Status)) = 'Incomplete'
					)
		  );


        -------------------------------------------------------------------------------
        -- 3) System Test (logic unchanged; only added LTRIM/RTRIM around text checks)
        -------------------------------------------------------------------------------
        UPDATE OS
        SET BillingStatus = 'System Test'
        FROM dbo.LISMaster AS OS
        WHERE LTRIM(RTRIM(OS.BillingStatus)) = 'Other Samples'
          AND (
                -- PatientName contains 'TEST' or 'DEMO'
                 UPPER(LTRIM(RTRIM(OS.PatientLastName)) +', ' + LTRIM(RTRIM(OS.PatientFirstName))) LIKE '%TEST%'
                OR UPPER(LTRIM(RTRIM(OS.PatientLastName)) +', ' + LTRIM(RTRIM(OS.PatientFirstName))) LIKE '%DEMO%'

                OR UPPER(LTRIM(RTRIM(OS.PatientLastName)) + LTRIM(RTRIM(OS.PatientFirstName))) LIKE '%TRAIN%'

                -- Provider exactly equals 'TEST'
                OR UPPER(LTRIM(RTRIM(OS.RPFirstName))) = 'TEST'
                OR UPPER(LTRIM(RTRIM(OS.RPLastName)))  = 'TEST'

				OR UPPER(LTRIM(RTRIM(OS.PatientFirstName))+' '+LTRIM(RTRIM(OS.PatientLastName))) LIKE 'Mickey Mouse'
                -- Specific fake names
                OR UPPER(LTRIM(RTRIM(OS.PatientFirstName)) + ', ' + LTRIM(RTRIM(OS.PatientLastName))) IN ('JOHN, DOE', 'DONALD, DUCK')
              );

        -------------------------------------------------------------------------------
        -- 4) Self-Pay (logic unchanged; only added LTRIM/RTRIM)
        -------------------------------------------------------------------------------
        UPDATE OS
        SET BillingStatus = 'Self-Pay'
        FROM dbo.LISMaster AS OS
        WHERE LTRIM(RTRIM(OS.BillingStatus)) = 'Other Samples'
          AND (
                LTRIM(RTRIM(UPPER(OS.PrimaryInsurancePayer))) IN ('SELF','SELF PAY','PRIVATE PAY','PAY')
                OR LTRIM(RTRIM(UPPER(OS.InsuranceCode))) = 'SELF PAY'
              );

        -------------------------------------------------------------------------------
        -- Billing Sub Status (logic unchanged; only added LTRIM/RTRIM on text checks)
        -------------------------------------------------------------------------------
        UPDATE LISMaster
        SET BillingSubStatus = CASE 
            WHEN FirstBilledDateIH IS NOT NULL AND FirstBilledDateDTR IS NULL THEN 'Billed Via IH AMD'
            WHEN FirstBilledDateIH IS NULL AND FirstBilledDateDTR IS NOT NULL THEN 'Billed Via DTR AMD'
            WHEN FirstBilledDateIH IS NOT NULL AND FirstBilledDateDTR IS NOT NULL THEN 'Billed Via DTR & IH AMD'
            WHEN ChargeEnteredIH IS NOT NULL AND FirstBilledDateIH IS NULL THEN 'Entered in IH AMD but not billed'
            WHEN ChargeEnteredDTR IS NOT NULL AND FirstBilledDateDTR IS NULL THEN 'Entered in DTR AMD but not billed'
            WHEN LTRIM(RTRIM(BillingStatus)) = 'Billable'
                 AND LTRIM(RTRIM(NexumStatusDTR)) IN ('Invalid Diagnosis','Invalid Provider','Invalid Client Procedure','Invalid Payer')
                 THEN 'Nexum Pre Processing Queue - DTR'
            WHEN LTRIM(RTRIM(BillingStatus)) = 'Billable'
                 AND LTRIM(RTRIM(NexumStatusIH)) = 'Eligibility'
                 THEN 'Nexum Eligibility - IH'
            WHEN LTRIM(RTRIM(BillingStatus)) = 'Billable'
                 AND LTRIM(RTRIM(NexumStatusIH)) = 'Diagnosis Validity'
                 THEN 'Nexum Diagnosis Validity - IH'
            WHEN LTRIM(RTRIM(BillingStatus)) = 'Billable'
                 AND LTRIM(RTRIM(NexumStatusIH)) = 'AMD Output'
                 THEN 'Nexum Scrubber Queue - IH'
            WHEN LTRIM(RTRIM(BillingStatus)) = 'Billable'
                 AND LTRIM(RTRIM(NexumStatusIH)) IN ('Invalid Diagnosis','Invalid Provider','Invalid Client Procedure','Invalid Payer')
                 THEN 'Nexum Pre Processing Queue - IH'
            ELSE 'Requires Review'
        END;

		UPDATE LISMaster SET IsBilled = CASE 
										WHEN BilledDTRAMD IS NOT NULL OR BilledInHealthAMD IS NOT NULL THEN 'Billed'
										ELSE 'Un Billed' END

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
/****** Object:  StoredProcedure [dbo].[Sp_ProcessNexusClaimDTRIH]******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE PROCEDURE [dbo].[Sp_ProcessNexusClaimDTRIH]
@FileId INT = NULL
AS
BEGIN
    SET NOCOUNT ON;

	update ImportedFiles set FileStatus = 3,ProcessedOn = GETDATE() where ImportedFileID = @FileId;

	    BEGIN TRY
        BEGIN TRANSACTION;

		
			Declare @FileType INT 

			SET @FileType = (SELECT Top 1 FileType FROM ImportedFiles WHERE ImportedFileID = @FileId)


			IF @FileType = 208 --Nexum Claim Scrubbing - DTR
				BEGIN 
				PRINT 'Nexum Claim Scrubbing - DTR'
				UPDATE LIS SET LIS.NexumStatusDTR = NX.Stage FROM LISMaster LIS
				JOIN NexusStaging NX ON LIS.AccessionNo = NX.Accession AND NX.ImportedFileID = @FileId

				END
			ELSE IF @FileType = 209 --Nexum Claim Scrubbing - IH
				BEGIN 
				PRINT 'Nexum Claim Scrubbing - IH'
				UPDATE LIS SET LIS.NexumStatusIH = NX.Stage FROM LISMaster LIS
				JOIN NexusStaging NX ON LIS.AccessionNo = NX.Accession AND NX.ImportedFileID = @FileId

				END
			ELSE IF @FileType = 210 --Nexum Preprocessing - DTR
				BEGIN 
				PRINT 'Nexum Preprocessing - DTR'
				UPDATE LIS SET LIS.NexumStatusDTR = NX.NexusStatus FROM LISMaster LIS
				JOIN NexusStaging NX ON LIS.AccessionNo = NX.Accession AND NX.ImportedFileID = @FileId

				END
			ELSE IF @FileType = 211 --Nexum Preprocessing - IH
				BEGIN 
				PRINT 'Nexum Preprocessing - IH'
				UPDATE LIS SET LIS.NexumStatusIH = NX.NexusStatus FROM LISMaster LIS
				JOIN NexusStaging NX ON LIS.AccessionNo = NX.Accession AND NX.ImportedFileID = @FileId

				END


		update ImportedFiles set FileStatus = 1,ProcessedOn = GETDATE() where ImportedFileID = @FileId;

        COMMIT TRANSACTION;

		EXEC SP_ProcessLISvsBilling;
    END TRY
    BEGIN CATCH
        ROLLBACK TRANSACTION;
        PRINT 'Error during MERGE: ' + ERROR_MESSAGE();
			update ImportedFiles set FileStatus = 2,ProcessedOn = GETDATE() where ImportedFileID = @FileId;
    END CATCH;
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
		

	select VisitNo,CPTCode,SUM(Units) Units INTO #TransData from TransactionMaster 
	where TransactionType = 'Charge' and TotalBilledAmount > 0 and void is null  
	GROUP BY  VisitNo,CPTCode;

	UPDATE BM SET BM.Units = TD.Units FROM BillingMaster BM 
	JOIN #TransData TD ON BM.VisitNumber = TD.VisitNo and BM.CPTCode = TD.CPTCode

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

		--EXEC [BillingMasterProcess_Proc];

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
            FirstBillDate,
            VisitNumber,
            ChargeEntryDate,
			BillingLab
        INTO #CCSTemp
        FROM BillingMaster;
        

        WITH RankedData AS (
            SELECT 
                LIS.AccessionNo,
                CCS.BillingLab,
                VAA.VisitNumber,
                CCS.FirstBillDate,
                CCS.ChargeEntryDate,
                ROW_NUMBER() OVER (PARTITION BY LIS.AccessionNo ORDER BY CCS.FirstBillDate) AS RowNum
            FROM [dbo].[LISMaster] LIS
            LEFT JOIN VAAMaster VAA                   ON LIS.AccessionNo = VAA.AccessionNo  
            LEFT JOIN #CCSTemp CCS                   ON VAA.VisitNumber = CCS.VisitNumber 
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
            VisitNumberIH         = SCD.VisitNumber,
            FirstBilledDateIH      = SCD.FirstBillDate,
            ChargeEntryDateIH    = SCD.ChargeEntryDate
        FROM [dbo].[LISMaster] LIS
        JOIN #SampleCollectionData SCD ON LIS.AccessionNo = SCD.AccessionNo
		WHERE SCD.BillingLab = 'In Health';

		   UPDATE LIS
        SET 
            VisitNumberDTR         = SCD.VisitNumber,
            FirstBilledDateDTR      = SCD.FirstBillDate,
            ChargeEntryDateDTR    = SCD.ChargeEntryDate
        FROM [dbo].[LISMaster] LIS
        JOIN #SampleCollectionData SCD ON LIS.AccessionNo = SCD.AccessionNo
		WHERE SCD.BillingLab = 'DTR';

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
/****** Object:  StoredProcedure [dbo].[sp_RebuildNewIndexes]******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE   PROCEDURE [dbo].[sp_RebuildNewIndexes]
(
      @MinFragReorganize  float = 5.0      -- >5% -> REORGANIZE
    , @MinFragRebuild     float = 30.0     -- >30% -> REBUILD
    , @MaxDOP             int   = NULL     -- NULL = server default; else 1..n
    , @SortInTempdb       bit   = 1        -- 1 = SORT_IN_TEMPDB = ON for rebuilds
    , @Verbose            bit   = 1        -- prints actions
    , @IgnoreFrag         bit   = 0        -- 1 = rebuild all target indexes regardless of frag
)
AS
BEGIN
    SET NOCOUNT ON;

    ---------------------------------------------------------------------------
    -- 1) Target list: ONLY the “new indexes” we created in your previous script
    --    (schema, table, index). If you add more later, append them here.
    ---------------------------------------------------------------------------
    DECLARE @Targets TABLE
    (
        schemaname sysname NOT NULL,
        tablename  sysname NOT NULL,
        indexname  sysname NOT NULL,
        PRIMARY KEY (schemaname, tablename, indexname)
    );

    INSERT INTO @Targets (schemaname, tablename, indexname)
    VALUES
    -- CustomCollectionStaging
    (N'dbo', N'CustomCollectionStaging', N'IX_CustomCollectionStaging_ImportedFileID'),

    -- VisitAgaistAccessionStaging
    (N'dbo', N'VisitAgaistAccessionStaging', N'IX_VisitAgaistAccessionStaging_AccessionNo'),

    -- LISMaster
    (N'dbo', N'LISMaster', N'IX_LISMaster_AccessionNo'),
    (N'dbo', N'LISMaster', N'IX_LISMaster_SampleCollectedDate'),
    (N'dbo', N'LISMaster', N'IX_LISMaster_Panel'),

    -- Masters with persisted TRIM columns
    (N'dbo', N'InsurancePayerMaster',   N'IX_InsurancePayerMaster_PayerName_Trim'),
    (N'dbo', N'PayerTypeMaster',        N'IX_PayerTypeMaster_PayerType_Trim'),
    (N'dbo', N'BillingProviderMaster',  N'IX_BillingProviderMaster_BillingProvider_Trim'),
    (N'dbo', N'ReferringProviderMaster',N'IX_RefProvMaster_Name_Trim'),

    -- TransactionMaster (filtered)
    (N'dbo', N'TransactionMaster', N'IX_TransactionMaster_Charge_Visit_CPT_Amount'),
    (N'dbo', N'TransactionMaster', N'IX_TransactionMaster_CheckDetails'),

    -- BillingMaster
    (N'dbo', N'BillingMaster', N'IX_BillingMaster_VisitNumber'),
    (N'dbo', N'BillingMaster', N'IX_BillingMaster_Visit_CPT'),
    (N'dbo', N'BillingMaster', N'IX_BillingMaster_FirstBillDate'),
    (N'dbo', N'BillingMaster', N'IX_BillingMaster_PaymentPostedDate'),
    (N'dbo', N'BillingMaster', N'IX_BillingMaster_AccessionNo'),
    (N'dbo', N'BillingMaster', N'IX_BillingMaster_LISMasterId'),

    -- DenialTrackingMaster
    (N'dbo', N'DenialTrackingMaster', N'IX_DenialTrackingMaster_Visit_CPT'),
    (N'dbo', N'DenialTrackingMaster', N'IX_DenialTrackingMaster_PaymentReasonDate'),

    -- Status / details
    (N'dbo', N'ClaimsLevelStatus',  N'IX_ClaimsLevelStatus_VisitNumber'),
    (N'dbo', N'ClaimsProdStatus',   N'IX_ClaimsProdStatus_VisitNumber'),
    (N'dbo', N'ClaimBillingDetails',N'IX_ClaimBillingDetails_Key'),

    -- ImportedFiles
    (N'dbo', N'ImportedFiles', N'IX_ImportedFiles_ImportedFileID');

    ---------------------------------------------------------------------------
    -- 2) Gather live fragmentation for target indexes (skip heaps, PK/UC)
    ---------------------------------------------------------------------------
    IF OBJECT_ID('tempdb..#ix') IS NOT NULL DROP TABLE #ix;
    CREATE TABLE #ix
    (
        schemaname sysname,
        tablename  sysname,
        indexname  sysname,
        object_id  int,
        index_id   int,
        avg_fragmentation_in_percent float,
        page_count bigint
    );

    INSERT INTO #ix (schemaname, tablename, indexname, object_id, index_id, avg_fragmentation_in_percent, page_count)
    SELECT
        s.name,
        o.name,
        i.name,
        i.object_id,
        i.index_id,
        ips.avg_fragmentation_in_percent,
        ips.page_count
    FROM @Targets t
    JOIN sys.schemas s ON s.name = t.schemaname
    JOIN sys.objects o ON o.schema_id = s.schema_id AND o.name = t.tablename AND o.type = 'U'
    JOIN sys.indexes i ON i.object_id = o.object_id AND i.name = t.indexname
    CROSS APPLY sys.dm_db_index_physical_stats(DB_ID(), i.object_id, i.index_id, NULL, 'SAMPLED') ips;

    ---------------------------------------------------------------------------
    -- 3) Build and execute ALTER INDEX commands
    ---------------------------------------------------------------------------
    DECLARE
          @schemaname sysname
        , @tablename  sysname
        , @indexname  sysname
        , @frag       float
        , @pages      bigint
        , @sql        nvarchar(max)
        , @opt        nvarchar(400)
        , @onlineTry  bit = 1;

    DECLARE cur CURSOR LOCAL FAST_FORWARD FOR
        SELECT schemaname, tablename, indexname, avg_fragmentation_in_percent, page_count
        FROM #ix
        WHERE (@IgnoreFrag = 1)
           OR (avg_fragmentation_in_percent >= @MinFragReorganize);

    OPEN cur;
    FETCH NEXT FROM cur INTO @schemaname, @tablename, @indexname, @frag, @pages;

    WHILE @@FETCH_STATUS = 0
    BEGIN
        -- Decide action: REORGANIZE vs REBUILD
        IF @IgnoreFrag = 1 OR @frag >= @MinFragRebuild
        BEGIN
            -- REBUILD
            SET @opt = N' WITH ('
                       + CASE WHEN @SortInTempdb = 1 THEN N'SORT_IN_TEMPDB = ON, ' ELSE N'' END
                       + CASE WHEN @MaxDOP IS NOT NULL THEN N'MAXDOP = ' + CAST(@MaxDOP AS nvarchar(10)) + N', ' ELSE N'' END
                       + N'ONLINE = ON)';

            SET @sql = N'ALTER INDEX ' + QUOTENAME(@indexname) + N' ON '
                     + QUOTENAME(@schemaname) + N'.' + QUOTENAME(@tablename)
                     + N' REBUILD' + @opt + N';';

            BEGIN TRY
                IF @Verbose = 1
                    PRINT CONCAT('REBUILD (ONLINE): ', @schemaname, '.', @tablename, ' -> ', @indexname,
                                 ' | frag=', FORMAT(@frag, 'N2'), ' | pages=', @pages);
                EXEC sp_executesql @sql;
            END TRY
            BEGIN CATCH
                -- If ONLINE not supported (e.g., Standard Edition), retry OFFLINE
                SET @opt = N' WITH ('
                           + CASE WHEN @SortInTempdb = 1 THEN N'SORT_IN_TEMPDB = ON, ' ELSE N'' END
                           + CASE WHEN @MaxDOP IS NOT NULL THEN N'MAXDOP = ' + CAST(@MaxDOP AS nvarchar(10)) + N', ' ELSE N'' END
                           + N'ONLINE = OFF)';

                SET @sql = N'ALTER INDEX ' + QUOTENAME(@indexname) + N' ON '
                         + QUOTENAME(@schemaname) + N'.' + QUOTENAME(@tablename)
                         + N' REBUILD' + @opt + N';';

                IF @Verbose = 1
                    PRINT CONCAT('REBUILD (OFFLINE RETRY): ', @schemaname, '.', @tablename, ' -> ', @indexname,
                                 ' | frag=', FORMAT(@frag, 'N2'), ' | pages=', @pages,
                                 ' | note=', ERROR_MESSAGE());
                EXEC sp_executesql @sql;
            END CATCH
        END
        ELSE
        BEGIN
            -- REORGANIZE
            SET @sql = N'ALTER INDEX ' + QUOTENAME(@indexname) + N' ON '
                     + QUOTENAME(@schemaname) + N'.' + QUOTENAME(@tablename) + N' REORGANIZE;';
            IF @Verbose = 1
                PRINT CONCAT('REORGANIZE: ', @schemaname, '.', @tablename, ' -> ', @indexname,
                             ' | frag=', FORMAT(@frag, 'N2'), ' | pages=', @pages);
            EXEC sp_executesql @sql;
        END

        FETCH NEXT FROM cur INTO @schemaname, @tablename, @indexname, @frag, @pages;
    END

    CLOSE cur; DEALLOCATE cur;

    IF @Verbose = 1
        PRINT 'Completed sp_RebuildNewIndexes.';
END
GO
