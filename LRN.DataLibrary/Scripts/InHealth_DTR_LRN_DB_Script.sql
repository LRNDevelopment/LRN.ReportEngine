USE [InHealthDTRLRN]
GO
/****** Object:  StoredProcedure [dbo].[SP_UpdatePanelDetail_Billing]******/
DROP PROCEDURE [dbo].[SP_UpdatePanelDetail_Billing]
GO
/****** Object:  StoredProcedure [dbo].[sp_UpdateDenialMasterTable]******/
DROP PROCEDURE [dbo].[sp_UpdateDenialMasterTable]
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
/****** Object:  StoredProcedure [dbo].[sp_ProcessBillingAccession]******/
DROP PROCEDURE [dbo].[sp_ProcessBillingAccession]
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
/****** Object:  StoredProcedure [dbo].[sp_GetDenialLineLevelReport]******/
DROP PROCEDURE [dbo].[sp_GetDenialLineLevelReport]
GO
/****** Object:  StoredProcedure [dbo].[sp_GetDenialClaimLevelReport]******/
DROP PROCEDURE [dbo].[sp_GetDenialClaimLevelReport]
GO
/****** Object:  StoredProcedure [dbo].[sp_GETDenialClaimLevel]******/
DROP PROCEDURE [dbo].[sp_GETDenialClaimLevel]
GO
/****** Object:  StoredProcedure [dbo].[sp_GetCollectionReport]******/
DROP PROCEDURE [dbo].[sp_GetCollectionReport]
GO
/****** Object:  StoredProcedure [dbo].[sp_GetCollectionLineLevelReport]******/
DROP PROCEDURE [dbo].[sp_GetCollectionLineLevelReport]
GO
/****** Object:  StoredProcedure [dbo].[sp_DenailDescrpUpdateByVisitCPT]******/
DROP PROCEDURE [dbo].[sp_DenailDescrpUpdateByVisitCPT]
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
ALTER TABLE [dbo].[LISMaster] DROP CONSTRAINT [FK__LISMaster__TestT__79B497A9]
GO
ALTER TABLE [dbo].[LISMaster] DROP CONSTRAINT [FK__LISMaster__TestT__78C07370]
GO
ALTER TABLE [dbo].[LISMaster] DROP CONSTRAINT [FK__LISMaster__TestT__77CC4F37]
GO
ALTER TABLE [dbo].[LISMaster] DROP CONSTRAINT [FK__LISMaster__TestT__76D82AFE]
GO
ALTER TABLE [dbo].[LISMaster] DROP CONSTRAINT [FK__LISMaster__TestT__75E406C5]
GO
ALTER TABLE [dbo].[LISMaster] DROP CONSTRAINT [FK__LISMaster__TestT__74EFE28C]
GO
ALTER TABLE [dbo].[LISMaster] DROP CONSTRAINT [FK__LISMaster__TestT__73FBBE53]
GO
ALTER TABLE [dbo].[LISMaster] DROP CONSTRAINT [FK__LISMaster__TestT__73079A1A]
GO
ALTER TABLE [dbo].[LISMaster] DROP CONSTRAINT [FK__LISMaster__TestT__721375E1]
GO
ALTER TABLE [dbo].[LISMaster] DROP CONSTRAINT [FK__LISMaster__TestT__711F51A8]
GO
ALTER TABLE [dbo].[LISMaster] DROP CONSTRAINT [FK__LISMaster__TestT__702B2D6F]
GO
ALTER TABLE [dbo].[LISMaster] DROP CONSTRAINT [FK__LISMaster__TestT__6F370936]
GO
ALTER TABLE [dbo].[LISMaster] DROP CONSTRAINT [FK__LISMaster__TestT__6E42E4FD]
GO
ALTER TABLE [dbo].[LISMaster] DROP CONSTRAINT [FK__LISMaster__TestT__6D4EC0C4]
GO
ALTER TABLE [dbo].[LISMaster] DROP CONSTRAINT [FK__LISMaster__TestT__6C5A9C8B]
GO
ALTER TABLE [dbo].[LISMaster] DROP CONSTRAINT [FK__LISMaster__Sampl__6B667852]
GO
ALTER TABLE [dbo].[LISMaster] DROP CONSTRAINT [FK__LISMaster__Sampl__6A725419]
GO
ALTER TABLE [dbo].[LISMaster] DROP CONSTRAINT [FK__LISMaster__Sampl__697E2FE0]
GO
ALTER TABLE [dbo].[LISMaster] DROP CONSTRAINT [FK__LISMaster__Sampl__688A0BA7]
GO
ALTER TABLE [dbo].[LISMaster] DROP CONSTRAINT [FK__LISMaster__Sampl__6795E76E]
GO
ALTER TABLE [dbo].[LISMaster] DROP CONSTRAINT [FK__LISMaster__Sampl__66A1C335]
GO
ALTER TABLE [dbo].[LISMaster] DROP CONSTRAINT [FK__LISMaster__Sampl__65AD9EFC]
GO
ALTER TABLE [dbo].[LISMaster] DROP CONSTRAINT [FK__LISMaster__Sampl__64B97AC3]
GO
ALTER TABLE [dbo].[LISMaster] DROP CONSTRAINT [FK__LISMaster__Sampl__63C5568A]
GO
ALTER TABLE [dbo].[LISMaster] DROP CONSTRAINT [FK__LISMaster__Sampl__62D13251]
GO
ALTER TABLE [dbo].[LISMaster] DROP CONSTRAINT [FK__LISMaster__Sampl__61DD0E18]
GO
ALTER TABLE [dbo].[LISMaster] DROP CONSTRAINT [FK__LISMaster__Sampl__60E8E9DF]
GO
ALTER TABLE [dbo].[LISMaster] DROP CONSTRAINT [FK__LISMaster__Sampl__5FF4C5A6]
GO
ALTER TABLE [dbo].[LISMaster] DROP CONSTRAINT [FK__LISMaster__Sampl__5F00A16D]
GO
ALTER TABLE [dbo].[LISMaster] DROP CONSTRAINT [FK__LISMaster__Sampl__5E0C7D34]
GO
ALTER TABLE [dbo].[LISMaster] DROP CONSTRAINT [FK__LISMaster__Refer__5D1858FB]
GO
ALTER TABLE [dbo].[LISMaster] DROP CONSTRAINT [FK__LISMaster__Refer__5C2434C2]
GO
ALTER TABLE [dbo].[LISMaster] DROP CONSTRAINT [FK__LISMaster__Refer__5B301089]
GO
ALTER TABLE [dbo].[LISMaster] DROP CONSTRAINT [FK__LISMaster__Refer__5A3BEC50]
GO
ALTER TABLE [dbo].[LISMaster] DROP CONSTRAINT [FK__LISMaster__Refer__5947C817]
GO
ALTER TABLE [dbo].[LISMaster] DROP CONSTRAINT [FK__LISMaster__Refer__5853A3DE]
GO
ALTER TABLE [dbo].[LISMaster] DROP CONSTRAINT [FK__LISMaster__Refer__575F7FA5]
GO
ALTER TABLE [dbo].[LISMaster] DROP CONSTRAINT [FK__LISMaster__Refer__566B5B6C]
GO
ALTER TABLE [dbo].[LISMaster] DROP CONSTRAINT [FK__LISMaster__Refer__55773733]
GO
ALTER TABLE [dbo].[LISMaster] DROP CONSTRAINT [FK__LISMaster__Refer__548312FA]
GO
ALTER TABLE [dbo].[LISMaster] DROP CONSTRAINT [FK__LISMaster__Refer__538EEEC1]
GO
ALTER TABLE [dbo].[LISMaster] DROP CONSTRAINT [FK__LISMaster__Refer__529ACA88]
GO
ALTER TABLE [dbo].[LISMaster] DROP CONSTRAINT [FK__LISMaster__Refer__51A6A64F]
GO
ALTER TABLE [dbo].[LISMaster] DROP CONSTRAINT [FK__LISMaster__Refer__50B28216]
GO
ALTER TABLE [dbo].[LISMaster] DROP CONSTRAINT [FK__LISMaster__Refer__4FBE5DDD]
GO
ALTER TABLE [dbo].[LISMaster] DROP CONSTRAINT [FK__LISMaster__Payer__4ECA39A4]
GO
ALTER TABLE [dbo].[LISMaster] DROP CONSTRAINT [FK__LISMaster__Payer__4DD6156B]
GO
ALTER TABLE [dbo].[LISMaster] DROP CONSTRAINT [FK__LISMaster__Payer__4CE1F132]
GO
ALTER TABLE [dbo].[LISMaster] DROP CONSTRAINT [FK__LISMaster__Payer__4BEDCCF9]
GO
ALTER TABLE [dbo].[LISMaster] DROP CONSTRAINT [FK__LISMaster__Payer__4AF9A8C0]
GO
ALTER TABLE [dbo].[LISMaster] DROP CONSTRAINT [FK__LISMaster__Payer__4A058487]
GO
ALTER TABLE [dbo].[LISMaster] DROP CONSTRAINT [FK__LISMaster__Payer__4911604E]
GO
ALTER TABLE [dbo].[LISMaster] DROP CONSTRAINT [FK__LISMaster__Payer__481D3C15]
GO
ALTER TABLE [dbo].[LISMaster] DROP CONSTRAINT [FK__LISMaster__Payer__472917DC]
GO
ALTER TABLE [dbo].[LISMaster] DROP CONSTRAINT [FK__LISMaster__Payer__4634F3A3]
GO
ALTER TABLE [dbo].[LISMaster] DROP CONSTRAINT [FK__LISMaster__Payer__4540CF6A]
GO
ALTER TABLE [dbo].[LISMaster] DROP CONSTRAINT [FK__LISMaster__Payer__444CAB31]
GO
ALTER TABLE [dbo].[LISMaster] DROP CONSTRAINT [FK__LISMaster__Payer__435886F8]
GO
ALTER TABLE [dbo].[LISMaster] DROP CONSTRAINT [FK__LISMaster__Payer__426462BF]
GO
ALTER TABLE [dbo].[LISMaster] DROP CONSTRAINT [FK__LISMaster__Payer__41703E86]
GO
ALTER TABLE [dbo].[LISMaster] DROP CONSTRAINT [FK__LISMaster__Panel__407C1A4D]
GO
ALTER TABLE [dbo].[LISMaster] DROP CONSTRAINT [FK__LISMaster__Panel__3F87F614]
GO
ALTER TABLE [dbo].[LISMaster] DROP CONSTRAINT [FK__LISMaster__Panel__3E93D1DB]
GO
ALTER TABLE [dbo].[LISMaster] DROP CONSTRAINT [FK__LISMaster__Panel__3D9FADA2]
GO
ALTER TABLE [dbo].[LISMaster] DROP CONSTRAINT [FK__LISMaster__Panel__3CAB8969]
GO
ALTER TABLE [dbo].[LISMaster] DROP CONSTRAINT [FK__LISMaster__Panel__3BB76530]
GO
ALTER TABLE [dbo].[LISMaster] DROP CONSTRAINT [FK__LISMaster__Panel__3AC340F7]
GO
ALTER TABLE [dbo].[LISMaster] DROP CONSTRAINT [FK__LISMaster__Panel__39CF1CBE]
GO
ALTER TABLE [dbo].[LISMaster] DROP CONSTRAINT [FK__LISMaster__Panel__38DAF885]
GO
ALTER TABLE [dbo].[LISMaster] DROP CONSTRAINT [FK__LISMaster__Panel__37E6D44C]
GO
ALTER TABLE [dbo].[LISMaster] DROP CONSTRAINT [FK__LISMaster__Panel__36F2B013]
GO
ALTER TABLE [dbo].[LISMaster] DROP CONSTRAINT [FK__LISMaster__Panel__35FE8BDA]
GO
ALTER TABLE [dbo].[LISMaster] DROP CONSTRAINT [FK__LISMaster__Panel__350A67A1]
GO
ALTER TABLE [dbo].[LISMaster] DROP CONSTRAINT [FK__LISMaster__Panel__34164368]
GO
ALTER TABLE [dbo].[LISMaster] DROP CONSTRAINT [FK__LISMaster__Panel__33221F2F]
GO
ALTER TABLE [dbo].[LISMaster] DROP CONSTRAINT [FK__LISMaster__Opera__322DFAF6]
GO
ALTER TABLE [dbo].[LISMaster] DROP CONSTRAINT [FK__LISMaster__Opera__3139D6BD]
GO
ALTER TABLE [dbo].[LISMaster] DROP CONSTRAINT [FK__LISMaster__Opera__3045B284]
GO
ALTER TABLE [dbo].[LISMaster] DROP CONSTRAINT [FK__LISMaster__Opera__2F518E4B]
GO
ALTER TABLE [dbo].[LISMaster] DROP CONSTRAINT [FK__LISMaster__Opera__2E5D6A12]
GO
ALTER TABLE [dbo].[LISMaster] DROP CONSTRAINT [FK__LISMaster__Opera__2D6945D9]
GO
ALTER TABLE [dbo].[LISMaster] DROP CONSTRAINT [FK__LISMaster__Opera__2C7521A0]
GO
ALTER TABLE [dbo].[LISMaster] DROP CONSTRAINT [FK__LISMaster__Opera__2B80FD67]
GO
ALTER TABLE [dbo].[LISMaster] DROP CONSTRAINT [FK__LISMaster__Opera__2A8CD92E]
GO
ALTER TABLE [dbo].[LISMaster] DROP CONSTRAINT [FK__LISMaster__Opera__2998B4F5]
GO
ALTER TABLE [dbo].[LISMaster] DROP CONSTRAINT [FK__LISMaster__Opera__28A490BC]
GO
ALTER TABLE [dbo].[LISMaster] DROP CONSTRAINT [FK__LISMaster__Opera__27B06C83]
GO
ALTER TABLE [dbo].[LISMaster] DROP CONSTRAINT [FK__LISMaster__Opera__26BC484A]
GO
ALTER TABLE [dbo].[LISMaster] DROP CONSTRAINT [FK__LISMaster__Opera__25C82411]
GO
ALTER TABLE [dbo].[LISMaster] DROP CONSTRAINT [FK__LISMaster__Opera__24D3FFD8]
GO
ALTER TABLE [dbo].[LISMaster] DROP CONSTRAINT [FK__LISMaster__LabId__23DFDB9F]
GO
ALTER TABLE [dbo].[LISMaster] DROP CONSTRAINT [FK__LISMaster__LabId__22EBB766]
GO
ALTER TABLE [dbo].[LISMaster] DROP CONSTRAINT [FK__LISMaster__LabId__21F7932D]
GO
ALTER TABLE [dbo].[LISMaster] DROP CONSTRAINT [FK__LISMaster__LabId__21036EF4]
GO
ALTER TABLE [dbo].[LISMaster] DROP CONSTRAINT [FK__LISMaster__LabId__200F4ABB]
GO
ALTER TABLE [dbo].[LISMaster] DROP CONSTRAINT [FK__LISMaster__LabId__1F1B2682]
GO
ALTER TABLE [dbo].[LISMaster] DROP CONSTRAINT [FK__LISMaster__LabId__1E270249]
GO
ALTER TABLE [dbo].[LISMaster] DROP CONSTRAINT [FK__LISMaster__LabId__1D32DE10]
GO
ALTER TABLE [dbo].[LISMaster] DROP CONSTRAINT [FK__LISMaster__LabId__1C3EB9D7]
GO
ALTER TABLE [dbo].[LISMaster] DROP CONSTRAINT [FK__LISMaster__LabId__1B4A959E]
GO
ALTER TABLE [dbo].[LISMaster] DROP CONSTRAINT [FK__LISMaster__LabId__1A567165]
GO
ALTER TABLE [dbo].[LISMaster] DROP CONSTRAINT [FK__LISMaster__LabId__19624D2C]
GO
ALTER TABLE [dbo].[LISMaster] DROP CONSTRAINT [FK__LISMaster__LabId__186E28F3]
GO
ALTER TABLE [dbo].[LISMaster] DROP CONSTRAINT [FK__LISMaster__LabId__177A04BA]
GO
ALTER TABLE [dbo].[LISMaster] DROP CONSTRAINT [FK__LISMaster__LabId__1685E081]
GO
ALTER TABLE [dbo].[LISMaster] DROP CONSTRAINT [FK__LISMaster__Clini__1591BC48]
GO
ALTER TABLE [dbo].[LISMaster] DROP CONSTRAINT [FK__LISMaster__Clini__149D980F]
GO
ALTER TABLE [dbo].[LISMaster] DROP CONSTRAINT [FK__LISMaster__Clini__13A973D6]
GO
ALTER TABLE [dbo].[LISMaster] DROP CONSTRAINT [FK__LISMaster__Clini__12B54F9D]
GO
ALTER TABLE [dbo].[LISMaster] DROP CONSTRAINT [FK__LISMaster__Clini__11C12B64]
GO
ALTER TABLE [dbo].[LISMaster] DROP CONSTRAINT [FK__LISMaster__Clini__10CD072B]
GO
ALTER TABLE [dbo].[LISMaster] DROP CONSTRAINT [FK__LISMaster__Clini__0FD8E2F2]
GO
ALTER TABLE [dbo].[LISMaster] DROP CONSTRAINT [FK__LISMaster__Clini__0EE4BEB9]
GO
ALTER TABLE [dbo].[LISMaster] DROP CONSTRAINT [FK__LISMaster__Clini__0DF09A80]
GO
ALTER TABLE [dbo].[LISMaster] DROP CONSTRAINT [FK__LISMaster__Clini__0CFC7647]
GO
ALTER TABLE [dbo].[LISMaster] DROP CONSTRAINT [FK__LISMaster__Clini__0C08520E]
GO
ALTER TABLE [dbo].[LISMaster] DROP CONSTRAINT [FK__LISMaster__Clini__0B142DD5]
GO
ALTER TABLE [dbo].[LISMaster] DROP CONSTRAINT [FK__LISMaster__Clini__0A20099C]
GO
ALTER TABLE [dbo].[LISMaster] DROP CONSTRAINT [FK__LISMaster__Clini__092BE563]
GO
ALTER TABLE [dbo].[LISMaster] DROP CONSTRAINT [FK__LISMaster__Clini__0837C12A]
GO
ALTER TABLE [dbo].[LISMaster] DROP CONSTRAINT [FK__LISMaster__Billi__7FA27B29]
GO
ALTER TABLE [dbo].[LISMaster] DROP CONSTRAINT [FK__LISMaster__Billi__7EAE56F0]
GO
ALTER TABLE [dbo].[LISMaster] DROP CONSTRAINT [FK__LISMaster__Billi__7DBA32B7]
GO
ALTER TABLE [dbo].[LISMaster] DROP CONSTRAINT [FK__LISMaster__Billi__7CC60E7E]
GO
ALTER TABLE [dbo].[LISMaster] DROP CONSTRAINT [FK__LISMaster__Billi__7BD1EA45]
GO
ALTER TABLE [dbo].[LISMaster] DROP CONSTRAINT [FK__LISMaster__Billi__7ADDC60C]
GO
ALTER TABLE [dbo].[LISMaster] DROP CONSTRAINT [FK__LISMaster__Billi__79E9A1D3]
GO
ALTER TABLE [dbo].[LISMaster] DROP CONSTRAINT [FK__LISMaster__Billi__07439CF1]
GO
ALTER TABLE [dbo].[LISMaster] DROP CONSTRAINT [FK__LISMaster__Billi__064F78B8]
GO
ALTER TABLE [dbo].[LISMaster] DROP CONSTRAINT [FK__LISMaster__Billi__055B547F]
GO
ALTER TABLE [dbo].[LISMaster] DROP CONSTRAINT [FK__LISMaster__Billi__04673046]
GO
ALTER TABLE [dbo].[LISMaster] DROP CONSTRAINT [FK__LISMaster__Billi__03730C0D]
GO
ALTER TABLE [dbo].[LISMaster] DROP CONSTRAINT [FK__LISMaster__Billi__027EE7D4]
GO
ALTER TABLE [dbo].[LISMaster] DROP CONSTRAINT [FK__LISMaster__Billi__018AC39B]
GO
ALTER TABLE [dbo].[LISMaster] DROP CONSTRAINT [FK__LISMaster__Billi__00969F62]
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
ALTER TABLE [dbo].[LISMaster] DROP CONSTRAINT [DF__LISMaster__Updat__761910EF]
GO
ALTER TABLE [dbo].[LISMaster] DROP CONSTRAINT [DF__LISMaster__Creat__7524ECB6]
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
ALTER TABLE [dbo].[DownloadReportTypes] DROP CONSTRAINT [DF__DownloadR__IsAct__36D2B482]
GO
ALTER TABLE [dbo].[DiagnoseLISStaging] DROP CONSTRAINT [DF__DiagnoseL__Impor__09E968C4]
GO
ALTER TABLE [dbo].[DenialTrackingStaging] DROP CONSTRAINT [DF__DenialTra__Impor__08F5448B]
GO
ALTER TABLE [dbo].[DenialTrackingMaster] DROP CONSTRAINT [DF__DenialTra__Updat__7430C87D]
GO
ALTER TABLE [dbo].[DenialTrackingMaster] DROP CONSTRAINT [DF__DenialTra__Creat__733CA444]
GO
ALTER TABLE [dbo].[DenialMasterTable] DROP CONSTRAINT [DF__DenialMas__Creat__7248800B]
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
ALTER TABLE [dbo].[ClaimsLevelStatus] DROP CONSTRAINT [DF__ClaimsLev__Creat__71545BD2]
GO
ALTER TABLE [dbo].[ClaimsLevelStatus] DROP CONSTRAINT [DF__ClaimsLev__Total__70603799]
GO
ALTER TABLE [dbo].[ClaimsLevelStatus] DROP CONSTRAINT [DF__ClaimsLev__Patie__6F6C1360]
GO
ALTER TABLE [dbo].[ClaimsLevelStatus] DROP CONSTRAINT [DF__ClaimsLev__Insur__6E77EF27]
GO
ALTER TABLE [dbo].[ClaimsLevelStatus] DROP CONSTRAINT [DF__ClaimsLev__Patie__6D83CAEE]
GO
ALTER TABLE [dbo].[ClaimsLevelStatus] DROP CONSTRAINT [DF__ClaimsLev__Patie__6C8FA6B5]
GO
ALTER TABLE [dbo].[ClaimsLevelStatus] DROP CONSTRAINT [DF__ClaimsLev__Insur__6B9B827C]
GO
ALTER TABLE [dbo].[ClaimsLevelStatus] DROP CONSTRAINT [DF__ClaimsLev__Insur__6AA75E43]
GO
ALTER TABLE [dbo].[ClaimsLevelStatus] DROP CONSTRAINT [DF__ClaimsLev__Allow__69B33A0A]
GO
ALTER TABLE [dbo].[ClaimsLevelStatus] DROP CONSTRAINT [DF__ClaimsLev__Bille__68BF15D1]
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
/****** Object:  Table [dbo].[DenialMasterTable]******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[DenialMasterTable]') AND type in (N'U'))
DROP TABLE [dbo].[DenialMasterTable]
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
/****** Object:  Table [dbo].[BillingAccessions]******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[BillingAccessions]') AND type in (N'U'))
DROP TABLE [dbo].[BillingAccessions]
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
/****** Object:  UserDefinedFunction [dbo].[SplitString]******/
DROP FUNCTION [dbo].[SplitString]
GO
/****** Object:  UserDefinedFunction [dbo].[GetUniqueICD10Codes]******/
DROP FUNCTION [dbo].[GetUniqueICD10Codes]
GO
/****** Object:  UserDefinedFunction [dbo].[GetOrignaltDenailCodeByVisitNumber]******/
DROP FUNCTION [dbo].[GetOrignaltDenailCodeByVisitNumber]
GO
/****** Object:  UserDefinedFunction [dbo].[GetOriginalDenailCodeByVisitCPT]******/
DROP FUNCTION [dbo].[GetOriginalDenailCodeByVisitCPT]
GO
/****** Object:  UserDefinedFunction [dbo].[GetDenialDescription]******/
DROP FUNCTION [dbo].[GetDenialDescription]
GO
/****** Object:  UserDefinedFunction [dbo].[GetDenialCodeDescByVisitCPT]******/
DROP FUNCTION [dbo].[GetDenialCodeDescByVisitCPT]
GO
/****** Object:  UserDefinedFunction [dbo].[GetDenialCodeDescByVisit]******/
DROP FUNCTION [dbo].[GetDenialCodeDescByVisit]
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
							'PI253','CO 45','CO 253','CO 1','CO 2','CO 3','PR 1','PR 2','PR 3','PR 45','PR 253','PI 253','PI 45','PI 1','PI 2','PI 3',
							'CO045','CO0253','CO01','CO02','CO03',
							'PR01','PR02','PR03','PR045','PR0253',
							'PI045','PI01','PI02','PI03','PI0253')
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
							'PI253','CO 45','CO 253','CO 1','CO 2','CO 3','PR 1','PR 2','PR 3','PR 45','PR 253','PI 253','PI 45','PI 1','PI 2','PI 3',
							'CO045','CO0253','CO01','CO02','CO03',
							'PR01','PR02','PR03','PR045','PR0253',
							'PI045','PI01','PI02','PI03','PI0253')
        GROUP BY Code
    )
    SELECT @Result = STRING_AGG(Code, ';') WITHIN GROUP (ORDER BY Code)
    FROM Filtered;

    RETURN @Result;
END
GO
/****** Object:  UserDefinedFunction [dbo].[GetDenialCodeDescByVisit]******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE   FUNCTION [dbo].[GetDenialCodeDescByVisit]
(
    @visitno VARCHAR(100)
)
RETURNS NVARCHAR(MAX)
AS
BEGIN
    DECLARE @Result NVARCHAR(MAX);

		;WITH SplitDenials AS
		(
			SELECT
				cls.VisitNumber,
				d.DenialCode,
				d.DenialDescription,
				-- Normalize description so CO171 / PR171 collapse into same bucket
				DenialDescriptionKey =
					LOWER(
						CASE
							WHEN RIGHT(RTRIM(d.DenialDescription), 1) = '.'
								 THEN LEFT(RTRIM(d.DenialDescription),
										   LEN(RTRIM(d.DenialDescription)) - 1)
							ELSE RTRIM(d.DenialDescription)
						END
					)
			FROM ClaimsLevelStatus cls
			CROSS APPLY STRING_SPLIT(cls.DenailCode, ';') s
			INNER JOIN DenialMasterTable d
				ON d.DenialCode = LTRIM(RTRIM(s.value))
				Where VisitNumber = @visitno
		),
		CodesPerDescription AS
		(
			SELECT
				VisitNumber,
				DenialDescriptionKey,
				-- pick one “real” description to display (e.g. MIN)
				DisplayDescription = MIN(DenialDescription),
				Codes = STRING_AGG(DenialCode, ' , ')
						WITHIN GROUP (ORDER BY DenialCode)
			FROM SplitDenials
			GROUP BY VisitNumber, DenialDescriptionKey
		),
		Chunks AS
		(
			SELECT
				VisitNumber,
				Chunk = CONCAT(Codes, ' - ', DisplayDescription)
			FROM CodesPerDescription
		)
		SELECT
			@Result =
				STRING_AGG(Chunk, ' , ')
				WITHIN GROUP (ORDER BY Chunk)
				--INTO #DenialDesc
		FROM Chunks
		GROUP BY VisitNumber;
   
    RETURN @Result;
END
GO
/****** Object:  UserDefinedFunction [dbo].[GetDenialCodeDescByVisitCPT]******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE  FUNCTION [dbo].[GetDenialCodeDescByVisitCPT]
(
    @visitno VARCHAR(100),
	@CPTCode VARCHAR(50)
)
RETURNS NVARCHAR(MAX)
AS
BEGIN
    DECLARE @Result NVARCHAR(MAX);

   ;WITH ActualCode AS
   (	SELECT VisitNumber,CPTCode,DenialCode
			FROM BillingMaster 
				Where VisitNumber = @visitno AND CPTCode = @CPTCode),
				SplitDenials AS
		(
			SELECT
				cls.VisitNumber,CPTCode,
				d.DenialCode,
				d.DenialDescription,
				-- Normalize description so CO171 / PR171 collapse into same bucket
				DenialDescriptionKey =
					LOWER(
						CASE
							WHEN RIGHT(RTRIM(d.DenialDescription), 1) = '.'
								 THEN LEFT(RTRIM(d.DenialDescription),
										   LEN(RTRIM(d.DenialDescription)) - 1)
							ELSE RTRIM(d.DenialDescription)
						END
					)
			FROM ActualCode cls
			CROSS APPLY STRING_SPLIT(cls.DenialCode, ';') s
			INNER JOIN DenialMasterTable d
				ON d.DenialCode = LTRIM(RTRIM(s.value))
		),
		CodesPerDescription AS
		(
			SELECT
				VisitNumber,CPTCode,
				DenialDescriptionKey,
				-- pick one “real” description to display (e.g. MIN)
				DisplayDescription = MIN(DenialDescription),
				Codes = STRING_AGG(DenialCode, ' , ')
						WITHIN GROUP (ORDER BY DenialCode)
			FROM SplitDenials
			GROUP BY VisitNumber, DenialDescriptionKey,CPTCode
		),
		Chunks AS
		(
			SELECT
				VisitNumber,CPTCode,
				Chunk = CONCAT(Codes, ' - ', DisplayDescription)
			FROM CodesPerDescription
		)
		SELECT
			@Result =
				STRING_AGG(Chunk, ' , ')
				WITHIN GROUP (ORDER BY Chunk)
				--INTO #DenialDesc
		FROM Chunks
		GROUP BY VisitNumber,CPTCode;

    RETURN @Result;
END
GO
/****** Object:  UserDefinedFunction [dbo].[GetDenialDescription]******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE   FUNCTION [dbo].[GetDenialDescription]  
(  
    @DenialCodes NVARCHAR(MAX)  
)  
RETURNS NVARCHAR(MAX)  
AS  
BEGIN  
    DECLARE @Result NVARCHAR(MAX) = N'';  
  
    -- Normalize ; to ,  
    IF @DenialCodes IS NOT NULL  
        SET @DenialCodes = REPLACE(@DenialCodes, ';', ',');  
  
    IF @DenialCodes IS NULL OR LTRIM(RTRIM(@DenialCodes)) = N''  
        RETURN @Result;  
  
    ;WITH NormalizedCodes AS  
    (  
        SELECT DISTINCT  
            REPLACE(REPLACE(LTRIM(RTRIM(value)), 'PR', 'CO'), 'PI', 'CO') AS Code  
        FROM STRING_SPLIT(@DenialCodes, ',')  
        WHERE LTRIM(RTRIM(value)) <> ''  
    ),  
    Descs AS  
    (  
        SELECT    
            nc.Code,  
            CASE   
                WHEN d.DenialDescription IS NOT NULL   
                    THEN nc.Code + N' - ' + d.DenialDescription  
                ELSE nc.Code + N' - Description not found'  
            END AS FullText  
        FROM NormalizedCodes nc  
        LEFT JOIN DenialMasterTable d  
            ON d.DenialCode = nc.Code  
    )  
    SELECT @Result = STRING_AGG(FullText, ', ')   
    FROM Descs;  
  
    RETURN @Result;  
END;
GO
/****** Object:  UserDefinedFunction [dbo].[GetOriginalDenailCodeByVisitCPT]******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE FUNCTION [dbo].[GetOriginalDenailCodeByVisitCPT] (@visitno VARCHAR(100),@cptCode VARCHAR(30))
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
            STRING_AGG(OrginalDenialCode, ';') AS PaymentReasonCode
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
       -- WHERE Code NOT IN ('CO45','CO253','CO1','CO2','CO3','PR1','PR2','PR3','PR45','PR253','PI45','PI1','PI2','PI3',
							--'PI253','CO 45','CO 253','CO 1','CO 2','CO 3','PR 1','PR 2','PR 3','PR 45','PR 253','PI 253','PI 45','PI 1','PI 2','PI 3')
        GROUP BY Code
    )
    SELECT @Result = STRING_AGG(Code, ';') WITHIN GROUP (ORDER BY Code)
    FROM Filtered;

    RETURN @Result;
END
GO
/****** Object:  UserDefinedFunction [dbo].[GetOrignaltDenailCodeByVisitNumber]******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE FUNCTION [dbo].[GetOrignaltDenailCodeByVisitNumber] (@visitno VARCHAR(100))
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
            STRING_AGG(OrginalDenialCode, ';') AS PaymentReasonCode
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
       --     WHERE Code NOT IN ('CO45','CO253','CO1','CO2','CO3','PR1','PR2','PR3','PR45','PR253','PI45','PI1','PI2','PI3',
							--'PI253','CO 45','CO 253','CO 1','CO 2','CO 3','PR 1','PR 2','PR 3','PR 45','PR 253','PI 253','PI 45','PI 1','PI 2','PI 3')
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
/****** Object:  UserDefinedFunction [dbo].[SplitString]******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

	CREATE FUNCTION [dbo].[SplitString]
    (
        @String NVARCHAR(MAX),
        @Delimiter CHAR(1)
    )
    RETURNS @Output TABLE (
        Item NVARCHAR(1000),
        ItemIndex INT
    )
    AS
    BEGIN
        DECLARE @StartIndex INT, @EndIndex INT, @Index INT = 0
        
        SET @StartIndex = 1
        IF SUBSTRING(@String, LEN(@String) - 1, LEN(@String)) <> @Delimiter
        BEGIN
            SET @String = @String + @Delimiter
        END
        
        WHILE CHARINDEX(@Delimiter, @String) > 0
        BEGIN
            SET @EndIndex = CHARINDEX(@Delimiter, @String)
            
            INSERT INTO @Output(Item, ItemIndex)
            VALUES(SUBSTRING(@String, @StartIndex, @EndIndex - 1), @Index)
            
            SET @Index = @Index + 1
            SET @String = SUBSTRING(@String, @EndIndex + 1, LEN(@String))
        END
        
        RETURN
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
	[PanelName] [nvarchar](255) NULL,
	[PanelCode] [nvarchar](50) NULL,
	[OrginalDenialCode] [nvarchar](255) NULL,
	[DenialCode] [nvarchar](50) NULL,
	[DenialPostedDate] [date] NULL,
	[LISPanel] [nvarchar](255) NULL,
	[DenialDescription] [nvarchar](max) NULL,
 CONSTRAINT [PK_BillingMaster] PRIMARY KEY CLUSTERED 
(
	[BillingMasterID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
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
	[BillingLab] [nvarchar](30) NULL,
	[DenialDescription] [nvarchar](max) NULL,
	[OrginalDenialCode] [nvarchar](50) NULL,
PRIMARY KEY CLUSTERED 
(
	[DenailTrackID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
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
/****** Object:  Table [dbo].[BillingAccessions]******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[BillingAccessions](
	[VisitNumber] [int] NULL,
	[PatientName] [nvarchar](255) NOT NULL,
	[BeginDOS] [date] NULL,
	[LastBillDate] [date] NULL,
	[DOE] [date] NULL,
	[AccessionNo] [nvarchar](50) NULL
) ON [PRIMARY]
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
	[OrginalDenailCode] [nvarchar](255) NULL,
	[ICDCodes] [nvarchar](500) NULL,
	[CPTWithUnits] [nvarchar](500) NULL,
	[DenialPostedDate] [date] NULL,
	[PanelCode] [nvarchar](50) NULL,
	[LISPanel] [nvarchar](255) NULL,
	[AccessionNo] [nvarchar](50) NULL,
	[DenialDescription] [nvarchar](max) NULL,
	[CheckDate] [date] NULL,
	[PaymentPostedDate] [date] NULL,
	[CheckNumber] [nvarchar](255) NULL,
	[CPTCodeWithUnits] [nvarchar](1000) NULL,
PRIMARY KEY CLUSTERED 
(
	[VisitNumber] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
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
/****** Object:  Table [dbo].[DenialMasterTable]******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[DenialMasterTable](
	[DenialMasterID] [int] IDENTITY(1,1) NOT NULL,
	[DenialCode] [varchar](50) NOT NULL,
	[DenialDescription] [nvarchar](1000) NULL,
	[CreatedDate] [datetime] NOT NULL,
	[ModifiedDate] [datetime] NULL,
	[DenialCodeWoPrefix] [nvarchar](50) NULL,
 CONSTRAINT [PK_DenialMasterTable] PRIMARY KEY CLUSTERED 
(
	[DenialMasterID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY],
 CONSTRAINT [UQ_DenialCode] UNIQUE NONCLUSTERED 
(
	[DenialCode] ASC
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
	[SeqNo] [int] NULL,
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
	[TemplateFileName] [nvarchar](255) NULL,
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
	[Medications] [nvarchar](4000) NULL,
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
	[TestOrderHistory82Id] [nvarchar](500) NULL,
	[Name] [nvarchar](500) NULL,
	[SampleID] [nvarchar](500) NULL,
	[DocRequest] [nvarchar](500) NULL,
	[InAppeals] [nvarchar](500) NULL,
	[ClaimDenied] [nvarchar](500) NULL,
	[UpdateDate] [nvarchar](500) NULL,
	[ClaimNote] [nvarchar](max) NULL,
	[Verified] [nvarchar](500) NULL,
	[ReverifyBy] [nvarchar](500) NULL,
	[PrimaryInsurance] [nvarchar](500) NULL,
	[InsuranceCode2] [nvarchar](500) NULL,
	[PayerCodeLookup] [nvarchar](500) NULL,
	[PayerCodeLookupLabel] [nvarchar](500) NULL,
	[PrimaryPolicyInformation] [nvarchar](500) NULL,
	[Note] [nvarchar](2000) NULL,
	[BenefitsVerified] [nvarchar](500) NULL,
	[PVerifyCode] [nvarchar](500) NULL,
	[RequestBillingInfo] [nvarchar](500) NULL,
	[NoteToOfficeContact] [nvarchar](max) NULL,
	[Discovery] [nvarchar](500) NULL,
	[EligibilityPortal] [nvarchar](4000) NULL,
	[ClearinghouseName] [nvarchar](4000) NULL,
	[PortalName] [nvarchar](4000) NULL,
	[HCPCS] [nvarchar](max) NULL,
	[ICD10] [nvarchar](max) NULL,
	[PracticeType] [nvarchar](500) NULL,
	[NonCoveredToxCodes] [nvarchar](max) NULL,
	[SendToBilling] [nvarchar](500) NULL,
	[HCPCS2] [nvarchar](max) NULL,
	[Insurance] [nvarchar](500) NULL,
	[BillingLab2] [nvarchar](500) NULL,
	[RegistrationID] [nvarchar](500) NULL,
	[WTHold] [nvarchar](500) NULL,
	[Rejected] [nvarchar](500) NULL,
	[PARRequired] [nvarchar](500) NULL,
	[AnnualTestCount] [nvarchar](500) NULL,
	[RegisteredDate] [nvarchar](500) NULL,
	[FirstName] [nvarchar](500) NULL,
	[LastName] [nvarchar](500) NULL,
	[DateOfBirth] [nvarchar](500) NULL,
	[Gender] [nvarchar](10) NULL,
	[Race] [nvarchar](500) NULL,
	[Ethnicity] [nvarchar](500) NULL,
	[PatientID] [nvarchar](500) NULL,
	[StreetAddress] [nvarchar](500) NULL,
	[City] [nvarchar](500) NULL,
	[State] [nvarchar](500) NULL,
	[Zip] [nvarchar](500) NULL,
	[PatientIDEntry] [nvarchar](500) NULL,
	[SecondaryInsurance] [nvarchar](500) NULL,
	[SecondaryPolicyInformation] [nvarchar](500) NULL,
	[VerifiedDate] [nvarchar](500) NULL,
	[NewPatient] [nvarchar](10) NULL,
	[EditPatient] [nvarchar](10) NULL,
	[LastTest] [nvarchar](500) NULL,
	[Order1] [nvarchar](max) NULL,
	[Reflex] [nvarchar](max) NULL,
	[TestCategory] [nvarchar](500) NULL,
	[EntryNumber] [nvarchar](500) NULL,
	[CollectionMedia] [nvarchar](500) NULL,
	[CollectedBy] [nvarchar](500) NULL,
	[Medications] [nvarchar](max) NULL,
	[OrderReason] [nvarchar](max) NULL,
	[SpecimenType] [nvarchar](500) NULL,
	[Components] [nvarchar](max) NULL,
	[OrderFormEntryNumber] [nvarchar](500) NULL,
	[CollectedTime] [nvarchar](500) NULL,
	[ElectronicSignature] [nvarchar](max) NULL,
	[Account] [nvarchar](500) NULL,
	[AccountID] [nvarchar](500) NULL,
	[ProviderLast] [nvarchar](500) NULL,
	[ProviderFirst] [nvarchar](500) NULL,
	[NPI] [nvarchar](500) NULL,
	[ParentCompany] [nvarchar](500) NULL,
	[ParentAccountID] [nvarchar](500) NULL,
	[AccountContactEmail] [nvarchar](500) NULL,
	[RepEmail] [nvarchar](500) NULL,
	[OrderIPAddress] [nvarchar](500) NULL,
	[PerformingLab] [nvarchar](500) NULL,
	[PerformingLabAddress] [nvarchar](500) NULL,
	[PerformingLabCLIA] [nvarchar](500) NULL,
	[BillingLabCLIA] [nvarchar](500) NULL,
	[ResultsPortal] [nvarchar](500) NULL,
	[BillingLabAddress] [nvarchar](500) NULL,
	[Division] [nvarchar](500) NULL,
	[IHBillingForDTR] [nvarchar](500) NULL,
	[EditLink] [nvarchar](500) NULL,
	[UploadToQbench] [nvarchar](10) NULL,
	[InsuranceCode] [nvarchar](500) NULL,
	[BillingLab] [nvarchar](500) NULL,
	[CPT] [nvarchar](max) NULL,
	[PatientRegisterLink] [nvarchar](1024) NULL,
	[ReqLink] [nvarchar](1024) NULL,
	[ResultLink] [nvarchar](1024) NULL,
	[ToxRules1] [nvarchar](max) NULL,
	[ToxRules2] [nvarchar](max) NULL,
	[ToxRules3] [nvarchar](max) NULL,
	[ToxRules4] [nvarchar](max) NULL,
	[ToxRules5] [nvarchar](max) NULL,
	[ToxGate1] [nvarchar](max) NULL,
	[ToxGate2] [nvarchar](max) NULL,
	[ToxApproved] [nvarchar](500) NULL,
	[PolicyNumberCharacteristics] [nvarchar](500) NULL,
	[ResultMatched] [nvarchar](500) NULL,
	[EntryStatus] [nvarchar](500) NULL,
	[EntryDatecreated] [nvarchar](500) NULL,
	[EntryDatesubmitted] [nvarchar](500) NULL,
	[EntryDateupdated] [nvarchar](500) NULL,
	[ImportedOn] [nvarchar](500) NULL,
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
ALTER TABLE [dbo].[DenialMasterTable] ADD  DEFAULT (getdate()) FOR [CreatedDate]
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

				Truncate table BillingMaster;
     
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

		UPDATE BillingMaster SET AccessionNo = LTRIM(RTRIM(REPLACE(AccessionNo,'.1','')))

        COMMIT TRANSACTION;

		EXEC sp_ProcessBillingAccession;
		EXEC sp_ClaimLevelStatusUpdate;
		----EXEC SP_ProcessVAAvsLIS;
		EXEC SP_ProcessLISvsBilling;
		EXEC [SP_UpdatePanelDetail_Billing];

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
            DBO.[GetDenailCodeByVisitNumber](VisitNumber) AS ClaimDenailCode,
			DBO.[GetOrignaltDenailCodeByVisitNumber](VisitNumber) AS OriginalDenailCode,
			MAX(PaymentDate) DenialDate
        INTO #DenailTracker
        FROM DenialTrackingMaster GROUP BY  VisitNumber, DBO.GetDenailCodeByVisitNumber(VisitNumber),DBO.[GetOrignaltDenailCodeByVisitNumber](VisitNumber);

        -- Reset ClaimsLevelStatus
        TRUNCATE TABLE [ClaimsLevelStatus];

        -- CPT Codes
        SELECT DISTINCT 
            VisitNumber,
            DBO.GETCPTCodeCombined(VisitNumber) AS CPTCode
        INTO #CptCodes
        FROM BillingMaster;

	  Select distinct VisitNumber,DBO.GetUniqueICD10Codes(VisitNumber) ICD10Code INTO #ICDCode from BillingMaster 

		CREATE NONCLUSTERED INDEX IX_VisitNumber_DC ON #DenailTracker (VisitNumber);
		CREATE NONCLUSTERED INDEX IX_VisitNumber_ICD ON #ICDCode (VisitNumber);  

        -- Insert processed claims status
        INSERT INTO [dbo].[ClaimsLevelStatus]
            ([VisitNumber],[CPTCodes],FirstBillDate,[BilledAmount],[AllowedAmount],[InsurancePayment],
             [InsuranceAdjustment],[PatientPaidAmount],[PatientAdjustment],[InsuranceBalance],
             [PatientBalance],[TotalBalance],[DenailCode],[FinalStatus],[CreatedOn],OrginalDenailCode,ICDCodes,DenialPostedDate)
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
            ClaimDenailCode,
		CASE
		-------Rule Id : 1 Fully Adjusted	First Billed Date = Date AND Total Charge = Carrier WO or Total Charge = Carrier WO + Patient WO or Total Charge = Patient WO AND Denial Code = Blank
		WHEN FirstBillDate IS NOT NULL and (BilledAmount = InsuranceAdjustment OR BilledAmount = (InsuranceAdjustment + PatientAdjustment) OR BilledAmount = PatientAdjustment) and ClaimDenailCode IS NULL THEN 'Fully Adjusted' 

		-------Rule Id : 2 Fully Denied	First Billed Date = Date AND Denial Code = Code AND Total Charge = Carrier Balance
		WHEN FirstBillDate IS NOT NULL and ClaimDenailCode is not null and BilledAmount = InsuranceBalance  THEN 'Fully Denied' 

		-------Rule Id : 3 Fully Paid	First Billed Date = Date AND Carrier Payment > 0 AND Carrier Balance = 0 AND CPT not equal to 99999
		WHEN FirstBillDate IS NOT NULL and InsurancePayment > 0 and InsuranceBalance = 0 and CPTCode NOT LIKE '%99999%' THEN 'Fully Paid'

		-------Rule Id : 4 Partially Paid	First Billed Date = Date AND CPT code is not equal to 99999 AND Carrier Payment > 0 AND Carrier Balance > 0
		WHEN FirstBillDate IS NOT NULL and CPTCode NOT LIKE '%99999%' and InsurancePayment > 0 and InsuranceBalance > 0 THEN 'Partially Paid'

		-------Rule Id : 5 No Response	First Billed Date = Date AND CPT Code is not Equal to 99999 AND Denial Code = Blank AND Total Charge = Carrier Balance
		WHEN FirstBillDate IS NOT NULL and CPTCode NOT LIKE '%99999%' and ClaimDenailCode is null and BilledAmount = InsuranceBalance THEN 'No Response'

		-------Rule Id : 6 No Response - Client	Total Charge = Carrier Balance AND Denial Code = Blank AND CPT = 99999
		WHEN  CPTCode LIKE '%99999%' and ClaimDenailCode is null and BilledAmount = InsuranceBalance THEN 'No Response - Client'

		-------Rule Id : 7 Paid To Client	Carrier Payment > 0 AND Carrier Balance = 0 AND CPT = 99999
		WHEN InsurancePayment > 0 and InsuranceBalance = 0 and CPTCode LIKE '%99999%'  THEN 'Paid To Client'

		-------Rule Id : 8 Patient Responsibility	First Billed = Date AND Carrier Payment = 0 AND Patient Payment = 0 AND Carrier Balance = 0  AND Patient Balance > 0
		WHEN FirstBillDate IS NOT NULL and  InsurancePayment = 0 and PatientPaidAmount = 0 and InsuranceBalance = 0 and PatientBalance > 0  and CPTCode NOT LIKE '%99999%' THEN 'Patient Responsibility'

		-------Rule Id : 9 Patient Responsibility - Client	First Billed = Date AND Carrier Payment = 0 AND Patient Payment = 0 AND Carrier Balance = 0  AND Patient Balance > 0 AND CPT Code = 99999
		WHEN FirstBillDate IS NOT NULL and  InsurancePayment = 0 and PatientPaidAmount = 0 and InsuranceBalance = 0 and PatientBalance > 0 and CPTCode LIKE '%99999%'  THEN 'Patient Responsibility - Client'

		-------Rule Id : 10 Partially Denied   FIRST Billed = Date AND Denial Code = Code AND Carrier Payment = 0 AND Patient Payment = 0 AND Carrier Balance > 0  AND Total Charge > Carrier Balance 
		-------AND Total Balance =Carrier Balance
		WHEN FirstBillDate IS NOT NULL and ClaimDenailCode is not null and  InsurancePayment = 0 and PatientPaidAmount = 0 AND InsuranceBalance > 0 and BilledAmount > InsuranceBalance 
		and TotalBalance = InsuranceBalance THEN 'Partially Denied'

		-------Rule Id : 11 Patient Payment	First Billed = Date AND Carrier Payment = 0 AND Patient Payment > 0 AND Carrier Balance = 0
		WHEN FirstBillDate IS NOT NULL and InsurancePayment = 0 and PatientPaidAmount > 0 and InsuranceBalance = 0 THEN 'Patient Payment'

		-------Rule Id : 12 Unbilled	First Billed = Blank AND Total Charge = Carrier Balance or Total Charge = Carrier Balance + Patient WO AND CPT Code not equal to 99999
		WHEN FirstBillDate IS NULL and (BilledAmount = InsuranceBalance OR BilledAmount = (InsuranceBalance + PatientAdjustment)) and  CPTCode NOT LIKE '%99999%' THEN 'Unbilled'

		-------Rule Id : 13 Fully Adjusted	First Billed = Blank AND Total Charge = Carrier WO or Total Charge = Patient WO or Total Charge = Carrier WO + Patient WO AND CPT Code not equal to 99999
		WHEN FirstBillDate IS NULL and (BilledAmount = InsuranceAdjustment OR BilledAmount = PatientAdjustment  OR BilledAmount = (InsuranceAdjustment + PatientAdjustment)) AND CPTCode NOT LIKE '%99999%' 
		THEN 'Fully Adjusted'

		-------Rule Id : 14 Unbilled - Client	First Billed = Blank  AND CPT code = 99999 AND Total Charge = Carrier Balance
		WHEN FirstBillDate IS NULL and  CPTCode LIKE '%99999%' and BilledAmount = InsuranceBalance  THEN 'Unbilled - Client'

		-------Rule Id : 15  Partially Adjusted	First Billed = Date AND Carrier Payment = 0 AND Patient Payment = 0 AND  Carrier WO > 0 AND Carrier Balance > 0 AND Denial Code = Blank
		WHEN FirstBillDate IS NOT NULL AND InsurancePayment = 0 AND PatientPaidAmount = 0 AND InsuranceAdjustment > 0 AND InsuranceBalance > 0 AND ClaimDenailCode IS NULL THEN 'Partially Adjusted'

		-------Rule Id : 16 Patient Payment	First Billed Date = Blank AND Carrier Payment = 0 AND Patient Payment > 0 AND Patient WO > = 0
		WHEN FirstBillDate IS NULL AND InsurancePayment = 0 AND PatientPaidAmount > 0 AND PatientAdjustment >= 0 THEN 'Patient Payment'

		-------Rule Id : 17 Unbilled - Patient Balance	First Billed Date = Blank AND Carrier Payment = 0 AND Patient Balance > 0 AND Patient WO > = 0
		WHEN FirstBillDate IS NULL AND InsurancePayment = 0 AND PatientBalance > 0 AND PatientAdjustment >= 0 THEN 'Unbilled - Patient Balance'

		-------Rule Id : 18	Partial Patient Payment	First Billed = Date AND Carrier Payment = 0 AND Patient Payment > 0 AND Carrier Balance > 0  and Patient Balance = 0
		WHEN FirstBillDate IS NOT NULL AND InsurancePayment = 0 AND PatientPaidAmount > 0 AND InsuranceBalance > 0 AND PatientBalance = 0 THEN 'Partial Patient Payment'

		-------Rule Id : 19 Unbilled - Patient WO	First Billed Date = Blank AND Carrier Payment = 0 AND TotalCharge=Patient WO
		WHEN FirstBillDate IS NULL AND InsurancePayment = 0 AND BilledAmount =  PatientAdjustment  THEN 'Unbilled - Patient WO'

		-------Rule Id :20	Partially Denied	First Billed = Date AND Denial Code = Code AND Carrier Payment = 0 AND Patient Payment = 0 AND Carrier Balance > 0  and Patient Balance > 0 
		WHEN FirstBillDate IS NOT NULL AND ClaimDenailCode IS NOT NULL AND InsurancePayment = 0 AND PatientPaidAmount = 0 and InsuranceBalance > 0 and PatientBalance > 0 THEN 'Partially Denied'

		-------Rule Id :21	Partially Paid	First Billed Date = Date AND CPT code is not equal to 99999 AND Carrier Payment > 0 AND Carrier Balance = 0 AND Patient Balance > 0
		WHEN FirstBillDate IS NOT NULL AND CPTCode NOT LIKE '%99999%' AND InsurancePayment > 0 AND InsuranceBalance = 0 AND PatientBalance > 0  THEN 'Partially Paid'

		-------Rule Id :22	Patient Payment	First Billed = Date AND Carrier Payment = 0 AND Patient Payment > 0 AND Carrier Balance > 0
		WHEN FirstBillDate IS NOT NULL AND InsurancePayment = 0 AND PatientPaidAmount > 0 AND InsuranceBalance > 0 THEN 'Patient Payment'

		-------Rule Id :23	Partial Patient Responsibility	First Billed = Date AND Carrier Payment = 0 AND Patient Payment = 0 AND Carrier Balance = 0 or >0 AND Patient Balance > 0 No Denial code
		WHEN FirstBillDate IS NOT NULL AND InsurancePayment = 0 AND PatientPaidAmount = 0 AND InsuranceBalance >= 0 AND PatientBalance > 0 AND ClaimDenailCode IS NULL  THEN 'Partial Patient Responsibility'

		ELSE 'Un Categorized' END ClaimStatus,
            GETDATE(),OriginalDenailCode,ICD.ICD10Code,DT.DenialDate
        FROM #BillingMaster BM
        LEFT JOIN #DenailTracker DT ON BM.VisitNumber = DT.VisitNumber
        LEFT JOIN #CptCodes CPT ON BM.VisitNumber = CPT.VisitNumber
		LEFT JOIN #ICDCode ICD ON BM.VisitNumber = ICD.VisitNumber;



		
		;WITH SplitDenials AS
		(
			SELECT
				cls.VisitNumber,
				d.DenialCode,
				d.DenialDescription,
				-- Normalize description so CO171 / PR171 collapse into same bucket
				DenialDescriptionKey =
					LOWER(
						CASE
							WHEN RIGHT(RTRIM(d.DenialDescription), 1) = '.'
								 THEN LEFT(RTRIM(d.DenialDescription),
										   LEN(RTRIM(d.DenialDescription)) - 1)
							ELSE RTRIM(d.DenialDescription)
						END
					)
			FROM ClaimsLevelStatus cls
			CROSS APPLY STRING_SPLIT(cls.DenailCode, ';') s
			INNER JOIN DenialMasterTable d
				ON d.DenialCode = LTRIM(RTRIM(s.value))
		),
		CodesPerDescription AS
		(
			SELECT
				VisitNumber,
				DenialDescriptionKey,
				-- pick one “real” description to display (e.g. MIN)
				DisplayDescription = MIN(DenialDescription),
				Codes = STRING_AGG(DenialCode, ' , ')
						WITHIN GROUP (ORDER BY DenialCode)
			FROM SplitDenials
			GROUP BY VisitNumber, DenialDescriptionKey
		),
		Chunks AS
		(
			SELECT
				VisitNumber,
				Chunk = CONCAT(Codes, ' - ', DisplayDescription)
			FROM CodesPerDescription
		)
		SELECT
			VisitNumber,
			DenialSummary =
				STRING_AGG(Chunk, ' , ')
				WITHIN GROUP (ORDER BY Chunk)
				INTO #DenialDesc
		FROM Chunks
		GROUP BY VisitNumber;


		CREATE NONCLUSTERED INDEX IX_VisitNumber_DC ON #DenialDesc (VisitNumber);


		UPDATE CLS SET CLS.DenialDescription = DC.DenialSummary  FROM ClaimsLevelStatus CLS
		JOIN #DenialDesc DC ON CLS.VisitNumber = DC.VisitNumber 

		;WITH CTE_TransDate AS(SELECT VisitNumber,ROW_NUMBER() OVER (PARTITION BY VisitNumber ORDER BY CheckDate DESC, PaymentPostedDate DESC) AS rn,
		CheckDate,PaymentPostedDate,CheckNumber FROM BillingMaster where CheckDate is not null) SELECT VisitNumber,CheckDate,PaymentPostedDate,CheckNumber 
		INTO #TransData FROM CTE_TransDate Where rn = 1 ;

		CREATE NONCLUSTERED INDEX IX_VisitNumber_TR ON #TransData (VisitNumber);


		UPDATE CLS SET CLS.CheckDate = DC.CheckDate,CLS.CheckNumber = DC.CheckNumber,CLS.PaymentPostedDate = DC.PaymentPostedDate  FROM ClaimsLevelStatus CLS
		JOIN #TransData DC ON CLS.VisitNumber = DC.VisitNumber 


		 ;WITH GroupedCPT AS (
        SELECT VisitNumber, CPTCode, Units,Modifier
        FROM BillingMaster bm 
		),
		AggregatedCPT AS (
			SELECT VisitNumber,
				STRING_AGG(CAST(CPTCode AS VARCHAR(20)) + REPLACE((CASE WHEN Modifier IS NULL OR Modifier = '0' THEN '' ELSE ' - '  + Modifier END ),' ','')+
					(CASE WHEN ISNULL(Units,0) = 0 THEN '' ELSE ' * ' + CAST(ISNULL(Units,0) AS VARCHAR(10)) END), ', ') AS CPTCode
			FROM GroupedCPT
			GROUP BY VisitNumber
		) SELECT * INTO #CPTCodesUnits
		FROM AggregatedCPT

		CREATE NONCLUSTERED INDEX IX_VisitNumber_DC ON #CPTCodesUnits (VisitNumber);

		UPDATE CLS SET CLS.CPTCodeWithUnits = DC.CPTCode  FROM ClaimsLevelStatus CLS
		JOIN #CPTCodesUnits DC ON CLS.VisitNumber = DC.VisitNumber 

		UPDATE CBD SET CBD.AccessionNo = BM.AccessionNo FROM ClaimsLevelStatus CBD
		JOIN LISMaster BM ON CBD.VisitNumber = BM.VisitNumberIH;

		UPDATE CBD SET CBD.AccessionNo = BM.AccessionNo FROM ClaimsLevelStatus CBD
		JOIN BillingMaster BM ON CBD.VisitNumber = BM.VisitNumber;

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
/****** Object:  StoredProcedure [dbo].[sp_DenailDescrpUpdateByVisitCPT]******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE Proc [dbo].[sp_DenailDescrpUpdateByVisitCPT]
AS BEGIN

;WITH SplitDenials AS
(
    SELECT
        cls.VisitNumber,CPTCode,
        d.DenialCode,
        d.DenialDescription,
        -- Normalize description so CO171 / PR171 collapse into same bucket
        DenialDescriptionKey =
            LOWER(
                CASE
                    WHEN RIGHT(RTRIM(d.DenialDescription), 1) = '.'
                         THEN LEFT(RTRIM(d.DenialDescription),
                                   LEN(RTRIM(d.DenialDescription)) - 1)
                    ELSE RTRIM(d.DenialDescription)
                END
            )
    FROM Billingmaster cls
    CROSS APPLY STRING_SPLIT(cls.DenialCode, ';') s
    INNER JOIN DenialMasterTable d
        ON d.DenialCode = LTRIM(RTRIM(s.value))
),
CodesPerDescription AS
(
    SELECT
        VisitNumber,CPTCode,
        DenialDescriptionKey,
        -- pick one “real” description to display (e.g. MIN)
        DisplayDescription = MIN(DenialDescription),
        Codes = STRING_AGG(DenialCode, ' , ')
                WITHIN GROUP (ORDER BY DenialCode)
    FROM SplitDenials
    GROUP BY VisitNumber, DenialDescriptionKey,CPTCode
),
Chunks AS
(
    SELECT
        VisitNumber,CPTCode,
        Chunk = CONCAT(Codes, ' - ', DisplayDescription)
    FROM CodesPerDescription
)
SELECT
    VisitNumber,CPTCode,
    DenialSummary =
        STRING_AGG(Chunk, ' , ')
        WITHIN GROUP (ORDER BY Chunk)
		INTO #DenialDecription
FROM Chunks
GROUP BY VisitNumber,CPTCode;


CREATE NONCLUSTERED INDEX IX_VisitNumber_DC ON #DenialDecription (VisitNumber);

UPDATE BM SET BM.DenialDescription = DC.DenialSummary  FROM BillingMaster BM
JOIN #DenialDecription DC ON BM.VisitNumber = DC.VisitNumber  AND BM.CPTCode = DC.CPTCode;

END
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

    SELECT  
        ISNULL(UPPER(b.AccessionNo),'Missing LIS Info') AccessionNo,
        b.VisitNumber,
        b.CPTCode,
        b.PatientName,
		--CAST(B.PatientDOB AS DATE) AS  PatientDOB, 
        CONVERT(VARCHAR, B.PatientDOB, 101) AS  PatientDOB,
		PanelCarrier PayerName,
        PayerType,
        BillingProvider,
		CAST(BeginDOS AS DATE) AS   BeginDOS,
		CAST(EndDOS AS DATE) AS   EndDOS,
		CAST(b.ChargeEntryDate AS DATE) AS    ChargeEntryDate,
		CAST(FirstBillDate AS DATE) AS      FirstBillDate,
		ISNULL(b.PanelCode, 'No Panel Located') AS PanelGroup,
		ISNULL(b.LISPanel, 'No Panel Located') AS LISPanel,
		POS,
		TOS,
        b.ICD10Code,
        b.Units,
		CAST(CheckDate AS DATE) AS      CheckDate,
		CAST(PaymentPostedDate AS DATE) AS    PaymentPostedDate,
		CAST(DenialPostedDate AS DATE) AS     DenialPostedDate,
        b.CheckNumber,
        CASE WHEN b.Modifier = '0' then '' else b.Modifier end Modifier,
        DenialCode as DenialCode,
		OrginalDenialCode AS [Orginal Denial Code],
		DenialDescription,
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
		ReferringProvider ReferringProviderName,
		b.ClaimSubStatus BillingSubStatus,
		CASE WHEN b.AccessionNo is null then 'Missing LIS Data' else '' end LISMissingRecord,
		b.BillingLab

    FROM BillingMaster b
    LEFT JOIN LISMaster l ON b.AccessionNo = l.AccessionNo AND l.Entry_Status <> 'Incomplete'
	LEFT JOIN ClinicMaster CM ON l.ClinicId = CM.ClinicId

    WHERE 
        --(@FromDate IS NULL OR TRY_CONVERT(date, b.FirstBillDate) >= @FromDate)
        --AND
        --(@ToDate IS NULL OR TRY_CONVERT(date, b.FirstBillDate) <= @ToDate)		and
		LTRIM(RTRIM(b.BillingLab)) NOT IN ('DTR') order by FirstBillDate 
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

	
    SELECT * INTO #BillingMasterTemp 
    FROM BillingMaster WITH (NOLOCK)
    --WHERE (@FromDate IS NULL OR FirstBillDate >= @FromDate) 
    --  AND (@ToDate IS NULL OR FirstBillDate <= @ToDate);



    CREATE NONCLUSTERED INDEX IX_VisitNumber_BM ON #BillingMasterTemp (VisitNumber);

    
    ;WITH MostFrequentFinancialClass AS (
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
    MainData AS (
        SELECT 
        BM.VisitNumber,
        BM.PanelCarrier PayerName,
        BM.PayerType,
        BM.BillingProvider,
		BM.AccessionNo,
        MIN(BM.BeginDOS) OVER (PARTITION BY BM.VisitNumber) AS BeginDOS,
		MIN(BM.ChargeEntryDate) OVER (PARTITION BY BM.VisitNumber) AS ChargeEntryDate,
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
		ISNULL(BM.PanelName,'No Panel Info') AS OrderInfo,
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
		LEFT JOIN ClinicMaster CM ON LIS.ClinicId = CM.ClinicId
    )
    SELECT DISTINCT
        md.VisitNumber,
        ISNULL(md.AccessionNo,'Missing LIS Data') AS AccessionNo,
		ISNULL(CPS.PanelCode,'No Panel Info') AS PanelName,
		ISNULL(CPS.LISPanel,'No Panel Info') AS LISPanel,
		OrderInfo OrderInfo,
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
		CONVERT(VARCHAR, CPS.DenialPostedDate, 101)	DenialPostedDate,
		CONVERT(VARCHAR, CPS.CheckDate, 101)	CheckDate,
		CONVERT(VARCHAR, CPS.PaymentPostedDate, 101)	PaymentPostedDate,
		CPS.CheckNumber,
        CASE 
		WHEN FinalStatus IN ('Patient Payment','Partial Patient Payment') THEN 'Billed' 
		WHEN md.FirstBillDate IS NOT NULL THEN 'Billed' ELSE 'Not Billed' END AS BilledNotBilled,
        POS.POS,
        TOS.TOS,
        CPS.CPTCodeWithUnits CPTCode,
        CPS.ICDCodes AS PrimaryDiagnosis,
        CPS.DenailCode DenialCode,
		CPS.OrginalDenailCode [Orignal Denial Code],
		CPS.DenialDescription,
        ISNULL(CPS.BilledAmount, 0.0) AS TotalCharge,
        ISNULL(CPS.AllowedAmount, 0.0) AS TotalAllowed,
        ISNULL(CPS.InsurancePayment, 0.0) AS CarrierPayment,
        CAST(ROUND(CASE WHEN CPS.BilledAmount > 0 THEN CPS.InsurancePayment * 100.0 / CPS.BilledAmount ELSE 0 END, 1) AS DECIMAL(8,2)) AS PaymentPercentage,
        ISNULL(CPS.InsuranceAdjustment, 0.0) AS CarrierWO,
        ISNULL(CPS.PatientPaidAmount, 0.0) AS PatientPaidAmount,
        ISNULL(CPS.PatientAdjustment, 0.0) AS PatientWO,
        ISNULL(CPS.InsuranceBalance, 0.0) AS CarrierBalance,
        ISNULL(CPS.PatientBalance, 0.0) AS PatientBalance,
        ISNULL(CPS.TotalBalance, 0.0) AS TotalBalance,
		(ISNULL(CPS.InsuranceAdjustment, 0.0) + ISNULL(CPS.PatientAdjustment, 0.0)) TotalAdjustment,
		CASE WHEN CPS.FinalStatus = 'Fully Paid' THEN (CPS.InsurancePayment + CPS.PatientPaidAmount) ELSE NULL END AS FullyPaid,
        CASE WHEN CPS.FinalStatus = 'Fully Paid' THEN 'Fully Paid Count' ELSE NULL END AS FullyPaidCount,
        CASE WHEN DATEDIFF(DAY, md.SampleCollectionDate, md.FirstBillDate) <= 30 THEN '30 Days Count' ELSE NULL END AS T30DaysCount,
        CASE WHEN DATEDIFF(DAY, md.SampleCollectionDate, md.FirstBillDate) <= 30 THEN (CPS.InsurancePayment + CPS.PatientPaidAmount) ELSE NULL END AS T30Amount,
        CASE WHEN DATEDIFF(DAY, md.SampleCollectionDate, md.FirstBillDate) BETWEEN 31 AND 60 THEN '60 Days Count' ELSE NULL END AS T60DaysCount,
        CASE WHEN DATEDIFF(DAY, md.SampleCollectionDate, md.FirstBillDate) BETWEEN 31 AND 60 THEN (CPS.InsurancePayment + CPS.PatientPaidAmount) ELSE NULL END AS T60Amount,
    -- Conditionally return AdjudicatedAmount
		CASE 
			WHEN CPS.FinalStatus IN ('No Response','Unbilled','Unbilled - Client','Unbilled - Patient Balance','No Response - Client') THEN NULL
			WHEN CPS.FinalStatus = 'Fully Adjusted' AND CPS.DenailCode IS NULL THEN NULL
			ELSE (CPS.InsurancePayment)
		END AS AdjudicatedAmount,

		-- Conditionally return AdjudicatedCount
		CASE 
			WHEN CPS.FinalStatus IN ('No Response','Unbilled','Unbilled - Client','Unbilled - Patient Balance','No Response - Client') THEN NULL
			WHEN CPS.FinalStatus = 'Fully Adjusted' AND CPS.DenailCode IS NULL THEN NULL
			ELSE 'Adjudicated' END
			 AdjudicatedCount,

        CPS.FinalStatus,
		CASE WHEN md.AccessionNo is null then 'Missing LIS Data' else '' end LISMissingRecord,
		Md.BillingLab
    FROM MainData md
    LEFT JOIN MostFrequentFinancialClass FC ON md.VisitNumber = FC.VisitNumber AND FC.rn = 1
    LEFT JOIN MostFrequentPOS POS ON md.VisitNumber = POS.VisitNumber AND POS.rn = 1
    LEFT JOIN MostFrequentTOS TOS ON md.VisitNumber = TOS.VisitNumber AND TOS.rn = 1
    LEFT JOIN ClaimsLevelStatus CPS ON md.VisitNumber = CPS.VisitNumber
    WHERE md.rn = 1 and LTRIM(RTRIM(md.BillingLab)) NOT IN ('DTR') order by FirstBillDate 

    DROP TABLE IF EXISTS #BillingMasterTemp, #TransactionMaster, #DenialCode;
END
GO
/****** Object:  StoredProcedure [dbo].[sp_GETDenialClaimLevel]******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE   Procedure [dbo].[sp_GETDenialClaimLevel]
AS BEGIN 

SELECT VisitNumber,PatientName,PatientDOB,PanelCarrier,PanelName,ReferringProvider,BeginDOS,
ChargeEntryDate,FirstBillDate, ROW_NUMBER() OVER (PARTITION BY VisitNumber ORDER BY 
CASE WHEN FirstBillDate IS NULL THEN 1 ELSE 0 END,FirstBillDate) AS rn INTO #BillingMaster FROM BillingMaster 


Select BM.VisitNumber,CBD.AccessionNo,PatientName,PatientDOB,PanelCarrier,ReferringProvider,BeginDOS,ChargeEntryDate,CBD.FirstBillDate,
CPTCodeWithUnits CPTCode,ICDCodes,DenailCode DenialCode,OrginalDenailCode,DenialDescription,DenialPostedDate,BilledAmount,AllowedAmount,InsurancePayment,
PatientPaidAmount,InsuranceAdjustment,PatientAdjustment,InsuranceBalance,PatientBalance,TotalBalance
From ClaimsLevelStatus CBD 
JOIN #BillingMaster BM ON CBD.VisitNumber = BM.VisitNumber 
WHERE rn = 1 and CBD.DenailCode IS NOT NULL

END
GO
/****** Object:  StoredProcedure [dbo].[sp_GetDenialClaimLevelReport]******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
  
  
CREATE   Procedure [dbo].[sp_GetDenialClaimLevelReport]  
AS BEGIN   
  
SELECT VisitNumber,PatientName,PatientDOB,PanelCarrier,PanelName,ReferringProvider,BeginDOS,  
ChargeEntryDate,FirstBillDate, ROW_NUMBER() OVER (PARTITION BY VisitNumber ORDER BY   
CASE WHEN FirstBillDate IS NULL THEN 1 ELSE 0 END,FirstBillDate) AS rn INTO #BillingMaster FROM BillingMaster   
  
  
Select BM.VisitNumber,CBD.AccessionNo,PatientName,PatientDOB,PanelCarrier,ReferringProvider,BeginDOS,ChargeEntryDate,CBD.FirstBillDate,  
CPTCodeWithUnits CPTCode,ICDCodes,DenailCode DenialCode,OrginalDenailCode,DenialDescription,DenialPostedDate,BilledAmount,AllowedAmount,InsurancePayment,  
PatientPaidAmount,InsuranceAdjustment,PatientAdjustment,InsuranceBalance,PatientBalance,TotalBalance  
From ClaimsLevelStatus CBD   
JOIN #BillingMaster BM ON CBD.VisitNumber = BM.VisitNumber   
WHERE rn = 1 and CBD.DenailCode IS NOT NULL  
  
END  
GO
/****** Object:  StoredProcedure [dbo].[sp_GetDenialLineLevelReport]******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

create Procedure [dbo].[sp_GetDenialLineLevelReport]
AS BEGIN

Select VisitNumber,AccessionNo,PatientName,PatientDOB,PanelCarrier Carrier,PayerType,PanelName,BillingProvider,ReferringProvider,BeginDOS,ChargeEntryDate,
FirstBillDate,CPTCode,Modifier,ICD10Code,Units,DenialPostedDate,DenialCode,DenialDescription,BilledAmount,AllowedAmount,InsurancePayment,InsuranceAdjustment,
PatientPaidAmount,PatientAdjustment,InsuranceBalance,PatientBalance,TotalBalance
from BillingMaster Where DenialCode IS NOT NULL

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
		TestOrderHistoryId,
        CalimNote ClaimNote,
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
		PtRace [Patient Race],
		PatientID,
		PatientGender [Patient Gender],
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
		--IsBilled [BillingStatus],
		Replace(IsBilled,'Un Billed','Not Billed') [BillingStatus],

        SS.SpecimenStatusName,
  --      OG.OperationsGroup,
		--pg.PanelCategory PanelGroup,
        CASE WHEN DaystoReceive = 0 THEN 1 ELSE DaystoReceive END DaystoReceive ,
        CASE WHEN DaystoResult = 0 THEN 1 ELSE DaystoResult END DaystoResult  ,
        CASE WHEN DaystoBill = 0 THEN 1 ELSE DaystoBill END DaystoBill ,
       -- ClientStatus,
        VisitNumberIH VisitNumber,
		--VisitNumberDTR [Billed - DTR AMD],
		--CASE WHEN BillingSubStatus = 'Billed Via DTR AMD' THEN 'DTR'
		--WHEN BillingSubStatus IN ('Billed Via DTR & IH AMD','Billed Via IH AMD') THEN 'Billed'
		--ELSE 'UnBilled' END AS [Billed / UnBilled],
        LIS.BillingStatus [NewStatus],
		BillingSubStatus,
		CONVERT(VARCHAR, LIS.FirstBilledDateIH, 101) [FirstBilledDate],
		--CONVERT(VARCHAR, LIS.FirstBilledDateDTR, 101) [Billed Date-DTR AMD],
		CONVERT(VARCHAR, LIS.ChargeEntryDateIH, 101) ChargeEntryDate,
		--CONVERT(VARCHAR, LIS.ChargeEntryDateDTR, 101) ChargeEntryDateDTR,
		LRNNoInsuranceInfo,
		--TestName,
		--BilledInHealthAMD,
		--BilledDTRAMD,
		--ChargeEnteredDTR,
		--ChargeEnteredIH,
		NexumStatusIH
		--NexumStatusDTR
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

    SELECT  
        ISNULL(UPPER(b.AccessionNo),'Missing LIS Info') AccessionNo,
        b.VisitNumber,
        b.CPTCode,
        b.PatientName,
		--CAST(B.PatientDOB AS DATE) AS  PatientDOB, 
        CONVERT(VARCHAR, B.PatientDOB, 101) AS  PatientDOB,
		PanelCarrier PayerName,
        PayerType,
        BillingProvider,
		CAST(BeginDOS AS DATE) AS   BeginDOS,
		CAST(EndDOS AS DATE) AS   EndDOS,
		CAST(b.ChargeEntryDate AS DATE) AS    ChargeEntryDate,
		CAST(FirstBillDate AS DATE) AS      FirstBillDate,
		ISNULL(b.PanelCode, 'No Panel Located') AS PanelGroup,
		ISNULL(b.LISPanel, 'No Panel Located') AS LISPanel,
		POS,
		TOS,
        b.ICD10Code,
        b.Units,
		CAST(CheckDate AS DATE) AS      CheckDate,
		CAST(PaymentPostedDate AS DATE) AS    PaymentPostedDate,
		CAST(DenialPostedDate AS DATE) AS     DenialPostedDate,
        b.CheckNumber,
        CASE WHEN b.Modifier = '0' then '' else b.Modifier end Modifier,
        DenialCode as DenialCode,
		OrginalDenialCode AS [Orginal Denial Code],
		DenialDescription,
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
		ReferringProvider ReferringProviderName,
		b.ClaimSubStatus BillingSubStatus,
		CASE WHEN b.AccessionNo is null then 'Missing LIS Data' else '' end LISMissingRecord,
		b.BillingLab

    FROM BillingMaster b
    LEFT JOIN LISMaster l ON b.AccessionNo = l.AccessionNo AND l.Entry_Status <> 'Incomplete'
	LEFT JOIN ClinicMaster CM ON l.ClinicId = CM.ClinicId

    WHERE 
        --(@FromDate IS NULL OR TRY_CONVERT(date, b.FirstBillDate) >= @FromDate)
        --AND
        --(@ToDate IS NULL OR TRY_CONVERT(date, b.FirstBillDate) <= @ToDate)		and
		LTRIM(RTRIM(b.BillingLab)) NOT IN ('DTR') order by FirstBillDate 
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

	
    SELECT * INTO #BillingMasterTemp 
    FROM BillingMaster WITH (NOLOCK)
    --WHERE (@FromDate IS NULL OR FirstBillDate >= @FromDate) 
    --  AND (@ToDate IS NULL OR FirstBillDate <= @ToDate);



    CREATE NONCLUSTERED INDEX IX_VisitNumber_BM ON #BillingMasterTemp (VisitNumber);

    
    ;WITH MostFrequentFinancialClass AS (
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
    MainData AS (
        SELECT 
        BM.VisitNumber,
        BM.PanelCarrier PayerName,
        BM.PayerType,
        BM.BillingProvider,
		BM.AccessionNo,
        MIN(BM.BeginDOS) OVER (PARTITION BY BM.VisitNumber) AS BeginDOS,
		MIN(BM.ChargeEntryDate) OVER (PARTITION BY BM.VisitNumber) AS ChargeEntryDate,
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
		ISNULL(BM.PanelName,'No Panel Info') AS OrderInfo,
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
		LEFT JOIN ClinicMaster CM ON LIS.ClinicId = CM.ClinicId
    )
    SELECT DISTINCT
        md.VisitNumber,
        ISNULL(md.AccessionNo,'Missing LIS Data') AS AccessionNo,
		ISNULL(CPS.PanelCode,'No Panel Info') AS PanelName,
		ISNULL(CPS.LISPanel,'No Panel Info') AS LISPanel,
		OrderInfo OrderInfo,
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
		CONVERT(VARCHAR, CPS.DenialPostedDate, 101)	DenialPostedDate,
		CONVERT(VARCHAR, CPS.CheckDate, 101)	CheckDate,
		CONVERT(VARCHAR, CPS.PaymentPostedDate, 101)	PaymentPostedDate,
		CPS.CheckNumber,
        CASE 
		WHEN FinalStatus IN ('Patient Payment','Partial Patient Payment') THEN 'Billed' 
		WHEN md.FirstBillDate IS NOT NULL THEN 'Billed' ELSE 'Not Billed' END AS BilledNotBilled,
        POS.POS,
        TOS.TOS,
        CPS.CPTCodeWithUnits CPTCode,
        CPS.ICDCodes AS PrimaryDiagnosis,
        CPS.DenailCode DenialCode,
		CPS.OrginalDenailCode [Orignal Denial Code],
		CPS.DenialDescription,
        ISNULL(CPS.BilledAmount, 0.0) AS TotalCharge,
        ISNULL(CPS.AllowedAmount, 0.0) AS TotalAllowed,
        ISNULL(CPS.InsurancePayment, 0.0) AS CarrierPayment,
        CAST(ROUND(CASE WHEN CPS.BilledAmount > 0 THEN CPS.InsurancePayment * 100.0 / CPS.BilledAmount ELSE 0 END, 1) AS DECIMAL(8,2)) AS PaymentPercentage,
        ISNULL(CPS.InsuranceAdjustment, 0.0) AS CarrierWO,
        ISNULL(CPS.PatientPaidAmount, 0.0) AS PatientPaidAmount,
        ISNULL(CPS.PatientAdjustment, 0.0) AS PatientWO,
        ISNULL(CPS.InsuranceBalance, 0.0) AS CarrierBalance,
        ISNULL(CPS.PatientBalance, 0.0) AS PatientBalance,
        ISNULL(CPS.TotalBalance, 0.0) AS TotalBalance,
		(ISNULL(CPS.InsuranceAdjustment, 0.0) + ISNULL(CPS.PatientAdjustment, 0.0)) TotalAdjustment,
		CASE WHEN CPS.FinalStatus = 'Fully Paid' THEN (CPS.InsurancePayment + CPS.PatientPaidAmount) ELSE NULL END AS FullyPaid,
        CASE WHEN CPS.FinalStatus = 'Fully Paid' THEN 'Fully Paid Count' ELSE NULL END AS FullyPaidCount,
        CASE WHEN DATEDIFF(DAY, md.SampleCollectionDate, md.FirstBillDate) <= 30 THEN '30 Days Count' ELSE NULL END AS T30DaysCount,
        CASE WHEN DATEDIFF(DAY, md.SampleCollectionDate, md.FirstBillDate) <= 30 THEN (CPS.InsurancePayment + CPS.PatientPaidAmount) ELSE NULL END AS T30Amount,
        CASE WHEN DATEDIFF(DAY, md.SampleCollectionDate, md.FirstBillDate) BETWEEN 31 AND 60 THEN '60 Days Count' ELSE NULL END AS T60DaysCount,
        CASE WHEN DATEDIFF(DAY, md.SampleCollectionDate, md.FirstBillDate) BETWEEN 31 AND 60 THEN (CPS.InsurancePayment + CPS.PatientPaidAmount) ELSE NULL END AS T60Amount,
    -- Conditionally return AdjudicatedAmount
		CASE 
			WHEN CPS.FinalStatus IN ('No Response','Unbilled','Unbilled - Client','Unbilled - Patient Balance','No Response - Client') THEN NULL
			WHEN CPS.FinalStatus = 'Fully Adjusted' AND CPS.DenailCode IS NULL THEN NULL
			ELSE (CPS.InsurancePayment)
		END AS AdjudicatedAmount,

		-- Conditionally return AdjudicatedCount
		CASE 
			WHEN CPS.FinalStatus IN ('No Response','Unbilled','Unbilled - Client','Unbilled - Patient Balance','No Response - Client') THEN NULL
			WHEN CPS.FinalStatus = 'Fully Adjusted' AND CPS.DenailCode IS NULL THEN NULL
			ELSE 'Adjudicated' END
			 AdjudicatedCount,

        CPS.FinalStatus,
		CASE WHEN md.AccessionNo is null then 'Missing LIS Data' else '' end LISMissingRecord,
		Md.BillingLab
    FROM MainData md
    LEFT JOIN MostFrequentFinancialClass FC ON md.VisitNumber = FC.VisitNumber AND FC.rn = 1
    LEFT JOIN MostFrequentPOS POS ON md.VisitNumber = POS.VisitNumber AND POS.rn = 1
    LEFT JOIN MostFrequentTOS TOS ON md.VisitNumber = TOS.VisitNumber AND TOS.rn = 1
    LEFT JOIN ClaimsLevelStatus CPS ON md.VisitNumber = CPS.VisitNumber
    WHERE md.rn = 1 and LTRIM(RTRIM(md.BillingLab)) NOT IN ('DTR') order by FirstBillDate 

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
		WHERE LIS.ImportedFileID = @FileID AND LTRIM(RTRIM(ISNULL(LIS.BillingLab,''))) NOT IN ('DTR','ATI','APath2');


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
		WHEN LTRIM(RTRIM(OrderInfo)) = 'Oral inSight Confirmation Only' THEN 'Clinical Toxicology' 
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
		WHEN LTRIM(RTRIM(OrderInfo)) = 'Oral inSight Confirmation Only' THEN 'Toxicology' 
		ELSE 'No Panel Located' END
		FROM LISMaster 



	 update ImportedFiles set FileStatus = 1,ProcessedOn = GETDATE() where ImportedFileID = @FileId; 

        -- Commit the transaction if all steps succeed
        COMMIT TRANSACTION;

		EXEC SP_ProcessLISvsBilling;
		EXEC [sp_ProcessBillingAccession];

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

		TRUNCATE TABLE VAAMaster;
		
		--DBCC CHECKIDENT ('VAAMaster', RESEED, 0);

        -- Insert new records into VAAMaster if not exists
        INSERT INTO VAAMaster (VisitNumber, AccessionNo, DateOfEntry, ServiceDate)
		SELECT DISTINCT VisitNumber,REPLACE(AccessionNo,'.1',''),EntryDate,ServiceDate FROM VisitAgaistAccessionStaging
		WHERE  ImportedFileID = @FileId AND VisitNumber IS NOT NULL;
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

		UPDATE BM SET BM.AccessionNo = VAA.AccessionNo FROM BillingMaster BM
		JOIN VAAMaster VAA ON BM.VisitNumber = VAA.VisitNumber
		

        -- Update the file status
        UPDATE ImportedFiles
        SET FileStatus = 1,ProcessedOn = GETDATE()   -- Adjust value to your desired status
        WHERE ImportedFileID = @FileId;



        COMMIT TRANSACTION;
		EXEC SP_ProcessVAAvsLIS;
		EXEC sp_ProcessBillingAccession;
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
/****** Object:  StoredProcedure [dbo].[sp_ProcessBillingAccession]******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE   PROCEDURE [dbo].[sp_ProcessBillingAccession]
AS BEGIN
		 SET NOCOUNT ON;

		TRUNCATE TABLE BillingAccessions

		INSERT INTO BillingAccessions (VisitNumber,PatientName,BeginDOS,LastBillDate,DOE)
		Select VisitNumber,PatientName,BeginDOS,MIN(FirstBillDate),MAX(ChargeEntryDate) from BillingMaster 
		Where VisitNumber IS NOT NULL
		GROUP BY VisitNumber,PatientName,BeginDOS

		UPDATE BA SET BA.AccessionNo = REPLACE(VAA.AccessionNo,'.1','') FROM BillingAccessions BA 
		JOIN VAAMaster VAA ON BA.VisitNumber = VAA.VisitNumber WHERE VAA.AccessionNo NOT LIKE '%[_]%'

		UPDATE BA SET BA.AccessionNo = LIS.AccessionNo FROM BillingAccessions BA 
		JOIN LISMaster LIS ON BA.BeginDOS = LIS.SampleCollectionDate AND Ba.PatientName = (LIS.PatientLastName+','+LIS.PatientFirstName) 
		WHERE BA.AccessionNo IS NULL

		--UPDATE BA SET BA.AccessionNo = LIS.AccessionNo FROM BillingAccessions BA 
		--JOIN LISMaster LIS ON BA.BeginDOS = LIS.SampleCollectionDate AND Ba.PatientName = (LIS.PatientFirstName+','+LIS.PatientLastName ) 
		--WHERE BA.AccessionNo IS NULL

			;WITH LISChoice AS
			(
				SELECT
					LIS.SampleCollectionDate,
					LIS.PatientFirstName,
					LIS.PatientLastName,
					LIS.AccessionNo,
					LTRIM(RTRIM(LIS.Entry_Status)) AS Entry_Status,
					ROW_NUMBER() OVER
					(
						PARTITION BY LIS.SampleCollectionDate,
									 LIS.PatientFirstName,
									 LIS.PatientLastName
						ORDER BY 
							CASE 
								WHEN LTRIM(RTRIM(LIS.Entry_Status)) = 'Sent to Billing' THEN 0 
								ELSE 1 
							END,
							LIS.AccessionNo   -- tie-breaker if needed
					) AS rn
				FROM LISMaster LIS
			)
			UPDATE BA
			SET BA.AccessionNo = L.AccessionNo
			FROM BillingAccessions BA
			JOIN LISChoice L
				ON  BA.BeginDOS    = L.SampleCollectionDate
				AND BA.PatientName = L.PatientFirstName + ',' + L.PatientLastName
			WHERE BA.AccessionNo IS NULL
			  AND L.rn = 1;   -- only 1 LIS row per patient/DOS


		UPDATE BillingAccessions SET AccessionNo = 'Unable to Locate' WHERE AccessionNo IS NULL

		UPDATE BM SET BM.AccessionNo = BA.AccessionNo From BillingMaster BM 
		Join BillingAccessions BA ON Bm.VisitNumber = BA.VisitNumber

		;WITH BA_Chosen AS
			(
				SELECT
					BA.*,
					ROW_NUMBER() OVER (
						PARTITION BY BA.AccessionNo
						ORDER BY
							CASE 
								WHEN BA.LastBillDate IS NULL THEN 1 
								ELSE 0 
							END,             -- 0 = has date, 1 = no date → rows WITH dates first
							BA.LastBillDate, -- among dated rows, earliest date first
							BA.DOE           -- tie-breaker when all dates are NULL
					) AS rn
				FROM BillingAccessions BA
			)
			UPDATE LIS
			SET
				LIS.VisitNumberIH     = BA.VisitNumber,
				LIS.FirstBilledDateIH = BA.LastBillDate,
				LIS.ChargeEntryDateIH = BA.DOE
			FROM LISMaster LIS
			JOIN BA_Chosen BA
				ON LIS.AccessionNo = BA.AccessionNo
			   AND BA.rn = 1;


   END
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

	IF @FileId IS NULL
		SET @FileId = (SELECT TOP 1 ImportedFileID FROM DenialTrackingStaging ORDER BY ImportedFileID DESC)

        -- Drop temp table if exists
        DROP TABLE IF EXISTS #DenialTrackingDetail;

		
	IF (Select FileType from ImportedFiles Where ImportedFileID = @FileId) = 206
		SET @LabName = 'In Health'
	ELSE IF (Select FileType from ImportedFiles Where ImportedFileID = @FileId) = 207
		SET @LabName = 'DTR'

        -- Load unique records into a temp table
        SELECT DISTINCT  
			DTM.VisitNumber,
			LTRIM(RTRIM(SUBSTRING(DTM.ChargeCode, 1, 5))) AS CPTCode,
			DTM.TransactionCarrierCode,
			DTM.PaymentDate,

			REPLACE(REPLACE(PaymentReasonCode,'PI','CO'),'PR','CO')      PaymentReasonCode,          -- fixed code(s)
			DTM.PaymentReasonCode AS OrginalDenialCode,  -- original code(s)

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
			DTM.DenialCategoryDescription,
			DTM.PaymentReasonDescription
		INTO #DenialTrackingDetail
		FROM DenialTrackingStaging DTM
		--CROSS APPLY
		--(
  --  SELECT
  --      PaymentReasonCode =
  --      CASE
  --          WHEN DTM.PaymentReasonCode IS NULL THEN NULL
  --          ELSE
  --              STUFF((
  --                  SELECT ';' +
  --                         CASE
  --                             WHEN token LIKE 'PI%' THEN 'CO' + SUBSTRING(token, 3, 8000)
  --                             WHEN token LIKE 'PR%' THEN 'CO' + SUBSTRING(token, 3, 8000)
  --                             ELSE token
  --                         END
  --                  FROM (
  --                      SELECT
  --                          LTRIM(RTRIM(j.[value])) AS token,
  --                          TRY_CONVERT(int, j.[key]) AS ord
  --                      FROM OPENJSON(
  --                          '["' + REPLACE(STRING_ESCAPE(DTM.PaymentReasonCode, 'json'), ';', '","') + '"]'
  --                      ) j
  --                  ) s
  --                  ORDER BY s.ord
  --                  FOR XML PATH(''), TYPE
  --              ).value('.', 'nvarchar(max)'), 1, 1, '')
		--		END
		--) pr
		WHERE (DTM.ImportedFileID = @FileId OR @FileId IS NULL);


        
        
		DELETE FROM DenialTrackingMaster WHERE BillingLab = @LabName;
       
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
				DenialDescription,BillingLab,OrginalDenialCode
            )
         SELECT dt.VisitNumber,CPTCode,TransactionCarrierCode,PaymentDate,PaymentReasonCode,ServiceDate,dt.Charge,TotalBalance,
		 TotalAdjustment,ReasonAmount,DenialUser,LastAction,LastActionDate,NextAction,NextActionDate,Note,DenialCategoryCode,
		 DenialCategoryDescription,PaymentReasonDescription,@LabName,OrginalDenialCode
		 From #DenialTrackingDetail dt left join LISMaster lis on dt.VisitNumber = lis.VisitNumberIH


		 SELECT VisitNumber,CPTCodes,DBO.GetDenailCodeByVisitCPT(VisitNumber,CPTCodes) DenialCode,
		 DBO.GetOriginalDenailCodeByVisitCPT(VisitNumber,CPTCodes) OriginlDenialCode,MAX(PaymentDate) PaymentDate
		 INTO #DenialDescription FROM DenialTrackingMaster
		 GROUP BY VisitNumber,CPTCodes,DBO.GetDenailCodeByVisitCPT(VisitNumber,CPTCodes),
		 DBO.GetOriginalDenailCodeByVisitCPT(VisitNumber,CPTCodes),
		 DBO.[GetDenialCodeDescByVisitCPT](VisitNumber,CPTCodes);

		 UPDATE BM SET BM.DenialCode = DXC.DenialCode, BM.OrginalDenialCode = DXC.OriginlDenialCode, 
		 DenialPostedDate = CASE WHEN DXC.DenialCode IS NOT NULL THEN PaymentDate ELSE NULL END
		 FROM BillingMaster BM
		 JOIN #DenialDescription DXC ON BM.VisitNumber = DXC.VisitNumber AND BM.CPTCode = DXC.CPTCodes

		 SELECT DISTINCT VisitNumber,CPTCode,DenialCode,DBO.GetDenialCodeDescByVisitCPT(VisitNumber,CPTCode) DenialDescription 
		 INTO #DenialDescrp FROM BillingMaster Where DenialCode IS NOT NULL

		 UPDATE BM SET  BM.DenialDescription =  REPLACE(REPLACE(DXC.DenialDescription,';',' , '),':',' -')
		 FROM BillingMaster BM
		 JOIN #DenialDescrp DXC ON BM.VisitNumber = DXC.VisitNumber AND BM.CPTCode = DXC.CPTCode
		
		EXEC sp_ClaimLevelStatusUpdate;

		 EXEC LRNMaster.dbo.sp_SyncDenialCodes_FromLabTrackingMaster
		 @SourceDb  = N'InHealthDTRLRN',
		 @SinceDate = NULL;  -- full scan (safe, but heavier)

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
            --BilledDTRAMD      = CASE WHEN VisitNumberDTR IS NOT NULL THEN 'Billed DTR AMD' ELSE NULL END,
            ChargeEnteredIH   = CASE WHEN ChargeEntryDateIH IS NOT NULL THEN 'Charge Entered Date In-Health AMD' ELSE NULL END;
            --ChargeEnteredDTR  = CASE WHEN ChargeEntryDateDTR IS NOT NULL THEN 'Charge Entered Date - DTR AMD' ELSE NULL END;

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
     
			;WITH cte AS
		(
			SELECT  s.*,
					rn = ROW_NUMBER() OVER
						 (
							 PARTITION BY AccessionNo      -- put your grouping columns here
							 ORDER BY CASE 
										 WHEN Entry_Status NOT IN ('Incomplete')    THEN 1  -- keep this as main
										 WHEN Entry_Status = 'Incomplete' THEN 2  -- treat this as duplicate
										 ELSE 3
									  END
						 )
						 
			FROM    LISMaster s
		)
		UPDATE cte
		SET    BillingStatus = CASE WHEN rn > 1 THEN 'Duplicate' ELSE 'Other Samples' END;

		-- Only flip rows that are currently "Other Samples"
		;WITH DuplicatedAccessions AS
		(
			SELECT 
				AccessionNo = LTRIM(RTRIM(AccessionNo))
			FROM dbo.LISMaster
			WHERE LTRIM(RTRIM(BillingStatus)) IN ('Other Samples', 'Billable') 
			AND AccessionNo NOT IN (Select DISTINCT AccessionNo FROM LISMaster WHERE BillingStatus = 'Duplicate')
			GROUP BY LTRIM(RTRIM(AccessionNo))
			HAVING COUNT(*) > 1
		)
		UPDATE LM
		SET BillingStatus = 'Duplicate'
		FROM dbo.LISMaster AS LM
		JOIN DuplicatedAccessions AS DA
			ON LTRIM(RTRIM(LM.AccessionNo)) = DA.AccessionNo
		WHERE LTRIM(RTRIM(LM.BillingStatus)) = 'Other Samples';
		     
			 

        -------------------------------------------------------------------------------
        -- 1) Billable vs Other Samples (baseline)
        -------------------------------------------------------------------------------
   
		     UPDATE L
        SET BillingStatus =
            CASE 
                WHEN LTRIM(RTRIM(L.Entry_Status)) = 'Sent to Billing' THEN 'Billable'
                ELSE BillingStatus
            END
        FROM dbo.LISMaster AS L;

        -------------------------------------------------------------------------------
        -- 4) Self-Pay (logic unchanged; only added LTRIM/RTRIM)
        -------------------------------------------------------------------------------
        UPDATE OS
        SET BillingStatus = 'Self-Pay'
        FROM dbo.LISMaster AS OS
        WHERE (
                LTRIM(RTRIM(UPPER(OS.PrimaryInsurancePayer))) IN ('SELF','SELF PAY','PRIVATE PAY','PAY','SELF PA')
              ) AND BillingStatus IN ('Other Samples','Billable');

			UPDATE LISMaster SET BillingStatus = 'Self-Pay' WHERE (LTRIM(RTRIM(UPPER(PrimaryInsurancePayer))) IN ('SEL','SE'))
			AND LTRIM(RTRIM(UPPER(PrimaryInsurancePayer))) NOT IN ('SELECT HEALTH') AND LTRIM(RTRIM(UPPER(Insurance))) NOT IN ('SELECT HEALTH')
			AND Entry_Status NOT IN ('Incomplete')

			UPDATE LISMaster SET BillingStatus = 'Self-Pay' WHERE (LTRIM(RTRIM(UPPER(Insurance))) IN ('SELF PAY')) 
			AND LTRIM(RTRIM(UPPER(Insurance))) NOT IN ('SELECT HEALTH') AND LTRIM(RTRIM(UPPER(PrimaryInsurancePayer))) NOT IN ('SELECT HEALTH')
			AND Entry_Status NOT IN ('Incomplete')

		;WITH cte AS
		(
			SELECT  s.*,
					rn = ROW_NUMBER() OVER
						 (
							 PARTITION BY AccessionNo      -- put your grouping columns here
							 ORDER BY PrimaryInsurancePayer,Insurance DESC
						 )
			FROM    LISMaster s WHERE  
			LTRIM(RTRIM(UPPER(PrimaryInsurancePayer))) IN ('SELF','SELF PAY','PRIVATE PAY','PAY','SELF PA') 
			OR LTRIM(RTRIM(UPPER(Insurance))) IN ('SELF PAY')
		)
		UPDATE cte
		SET    BillingStatus = CASE WHEN rn > 1 THEN 'Duplicate' ELSE 'Self-Pay' END;

        -------------------------------------------------------------------------------
        -- Billing Sub Status (logic unchanged; only added LTRIM/RTRIM on text checks)
        -------------------------------------------------------------------------------
        UPDATE LISMaster
        SET BillingSubStatus = CASE 
            WHEN FirstBilledDateIH IS NOT NULL THEN 'Billed Via IH AMD'
            --WHEN FirstBilledDateIH IS NULL AND FirstBilledDateDTR IS NOT NULL THEN 'Billed Via DTR AMD'
            --WHEN FirstBilledDateIH IS NOT NULL AND FirstBilledDateDTR IS NOT NULL THEN 'Billed Via DTR & IH AMD'
            WHEN ChargeEnteredIH IS NOT NULL AND FirstBilledDateIH IS NULL THEN 'Entered in IH AMD but not billed'
            --WHEN ChargeEnteredDTR IS NOT NULL AND FirstBilledDateDTR IS NULL THEN 'Entered in DTR AMD but not billed'
            --WHEN LTRIM(RTRIM(BillingStatus)) = 'Billable' AND IsBilled = 'Un Billed' 
            --     AND LTRIM(RTRIM(NexumStatusDTR)) IN ('Eligibility')
            --     THEN 'Nexum Eligibility - DTR'

			--WHEN LTRIM(RTRIM(BillingStatus)) = 'Billable' AND IsBilled = 'Un Billed' 
   --              AND LTRIM(RTRIM(NexumStatusDTR)) IN ('Diagnosis Validity')
   --              THEN 'Nexum Diagnosis Validity - DTR'
			--WHEN LTRIM(RTRIM(BillingStatus)) = 'Billable' AND IsBilled = 'Un Billed' 
   --              AND LTRIM(RTRIM(NexumStatusDTR)) IN ('AMD Output')
   --              THEN 'Nexum Scrubber Queue - DTR'

			--WHEN LTRIM(RTRIM(BillingStatus)) = 'Billable' AND IsBilled = 'Un Billed' 
   --              AND LTRIM(RTRIM(NexumStatusDTR)) IN ('Invalid Diagnosis','Invalid Provider','Invalid Client Procedure','Invalid Payer')
   --              THEN 'Nexum Pre Processing Queue - DTR'

            WHEN LTRIM(RTRIM(BillingStatus)) = 'Billable' AND IsBilled = 'Un Billed' 
                 AND LTRIM(RTRIM(NexumStatusIH)) = 'Eligibility'
                 THEN 'Nexum Eligibility - IH'
            WHEN LTRIM(RTRIM(BillingStatus)) = 'Billable' AND IsBilled = 'Un Billed' 
                 AND LTRIM(RTRIM(NexumStatusIH)) = 'Diagnosis Validity'
                 THEN 'Nexum Diagnosis Validity - IH' 
            WHEN LTRIM(RTRIM(BillingStatus)) = 'Billable' AND IsBilled = 'Un Billed' 
                 AND LTRIM(RTRIM(NexumStatusIH)) = 'AMD Output'
                 THEN 'Nexum Scrubber Queue - IH'
            WHEN LTRIM(RTRIM(BillingStatus)) = 'Billable' AND IsBilled = 'Un Billed' 
                 AND LTRIM(RTRIM(NexumStatusIH)) IN ('Invalid Diagnosis','Invalid Provider','Invalid Client Procedure','Invalid Payer')
                 THEN 'Nexum Pre Processing Queue - IH'
            ELSE ''
        END;

		UPDATE LISMaster SET IsBilled = CASE 
										WHEN FirstBilledDateIH IS NOT NULL THEN 'Billed'
										ELSE 'Un Billed' END

		
        -------------------------------------------------------------------------------
        -- 3) System Test (logic unchanged; only added LTRIM/RTRIM around text checks)
        -------------------------------------------------------------------------------
        UPDATE OS
        SET BillingStatus = 'System Test'
        FROM dbo.LISMaster AS OS
        WHERE (
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
              ) AND PatientLastName <> 'DEMOREST' 
			  AND UPPER(LTRIM(RTRIM(OS.PatientFirstName)) + ' ' + LTRIM(RTRIM(OS.PatientLastName))) <> 'TARA TRAINOR';

		UPDATE LISMaster SET BillingSubStatus = 'Requires Review' Where BillingStatus = 'Billable' AND IsBilled = 'Un Billed' AND ISNULL(BillingSubStatus,'') = ''  
		
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
		



		--EXEC sp_ClaimLevelStatusUpdate;

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
  ----      UPDATE LIS
  ----      SET 
  ----          VisitNumberIH         = SCD.VisitNumber,
  ----          FirstBilledDateIH      = SCD.FirstBillDate,
  ----          ChargeEntryDateIH    = SCD.ChargeEntryDate
  ----      FROM [dbo].[LISMaster] LIS
  ----      JOIN #SampleCollectionData SCD ON LIS.AccessionNo = SCD.AccessionNo
		----WHERE SCD.BillingLab = 'In Health';

		----   UPDATE LIS
  ----      SET 
  ----          VisitNumberDTR         = SCD.VisitNumber,
  ----          FirstBilledDateDTR      = SCD.FirstBillDate,
  ----          ChargeEntryDateDTR    = SCD.ChargeEntryDate
  ----      FROM [dbo].[LISMaster] LIS
  ----      JOIN #SampleCollectionData SCD ON LIS.AccessionNo = SCD.AccessionNo
		----WHERE SCD.BillingLab = 'DTR';

		UPDATE BM SET 
           BM.AccessionNo = LIS.AccessionNo 
        FROM [dbo].BillingMaster BM
        JOIN [LISMaster] LIS ON BM.BeginDOS = LIS.SampleCollectionDate AND BM.PatientName = (LIS.PatientLastName+','+LIS.PatientFirstName) 
		WHERE BM.AccessionNo IS NULL OR BM.AccessionNo LIKE '%[_]%'

		--	UPDATE BM SET BM.AccessionNo =  LIS.AccessionNo FROM BillingMaster BM 
		--JOIN LISMaster LIS ON  BM.BeginDOS = LIS.SampleCollectionDate AND BM.PatientName = (LIS.PatientLastName+','+LIS.PatientFirstName) 
		--Where 

		UPDATE LIS SET VisitNumberDTR = BM.VisitNumber,
            FirstBilledDateDTR = BM.FirstBillDate,
            ChargeEntryDateDTR = BM.ChargeEntryDate FROM LISMaster LIS
		JOIN BillingMaster BM ON LIS.SampleCollectionDate = BM.BeginDOS AND  (LIS.PatientLastName+','+LIS.PatientFirstName) = BM.PatientName
		WHERE ISNULL(LIS.VisitNumberIH,'') = ''

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
/****** Object:  StoredProcedure [dbo].[sp_UpdateDenialMasterTable]******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- Procedure to populate/update DenialMasterTable
CREATE     PROCEDURE [dbo].[sp_UpdateDenialMasterTable]
AS
BEGIN
    SET NOCOUNT ON;
    
      -- Temporary table to hold parsed denial data with explicit collation
    CREATE TABLE #TempDenials (
        DenialCode VARCHAR(50) COLLATE SQL_Latin1_General_CP1_CI_AS,
        DenialDescription NVARCHAR(1000) COLLATE SQL_Latin1_General_CP1_CI_AS
    )
    
    -- Parse the data from DenialTrackingStaging
    ;WITH SplitDenials AS (
        SELECT 
            -- Split PaymentReasonCode by ';'
            Code.Item AS ParsedCode,
            -- Split PaymentReasonDescription by ';'
            [Desc].Item AS ParsedDescription,
            Code.ItemIndex
        FROM DenialTrackingMaster DTS
        CROSS APPLY dbo.SplitString(DTS.PaymentReasonCode, ';') Code
        CROSS APPLY dbo.SplitString(DTS.DenialDescription, ';') [Desc]
        WHERE Code.ItemIndex = [Desc].ItemIndex
            AND DTS.PaymentReasonCode IS NOT NULL
            AND DTS.DenialDescription IS NOT NULL
    ),
    CleanedDenials AS (
        SELECT 
            LTRIM(RTRIM(ParsedCode)) COLLATE SQL_Latin1_General_CP1_CI_AS AS DenialCode,
            -- Clean the description: remove the code prefix (e.g., "CO131: ")
            CASE 
                WHEN CHARINDEX(':', ParsedDescription) > 0 
                THEN LTRIM(RTRIM(SUBSTRING(ParsedDescription, CHARINDEX(':', ParsedDescription) + 1, LEN(ParsedDescription))))
                ELSE LTRIM(RTRIM(ParsedDescription))
            END COLLATE SQL_Latin1_General_CP1_CI_AS AS DenialDescription
        FROM SplitDenials
        WHERE LTRIM(RTRIM(ParsedCode)) <> ''
    )
    INSERT INTO #TempDenials (DenialCode, DenialDescription)
    SELECT DISTINCT 
        DenialCode,
        MAX(DenialDescription) AS DenialDescription -- Use MAX to get one description if multiple exist
    FROM CleanedDenials
    GROUP BY DenialCode
    
    -- Debug: Check what we parsed
    --SELECT * FROM #TempDenials ORDER BY DenialCode
    
    -- Insert new denial codes
    INSERT INTO DenialMasterTable (DenialCode, DenialDescription)
    SELECT 
        TD.DenialCode,
        TD.DenialDescription
    FROM #TempDenials TD
    LEFT JOIN DenialMasterTable DMT ON TD.DenialCode = DMT.DenialCode COLLATE SQL_Latin1_General_CP1_CI_AS
    WHERE DMT.DenialMasterID IS NULL -- Not exists
    

    DROP TABLE #TempDenials
    
    -- Show final result
 --   SELECT * FROM DenialMasterTable ORDER BY DenialCode
END
GO
/****** Object:  StoredProcedure [dbo].[SP_UpdatePanelDetail_Billing]******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE    PROCEDURE [dbo].[SP_UpdatePanelDetail_Billing]
AS
BEGIN
    SET NOCOUNT ON;
	
	UPDATE ClaimsLevelStatus SET PanelCode = CASE 
    WHEN CPTCodes IN ('80307,G0480', '80307,G0481', '80307', 'G0480','G0481','80307, G0482','G0482') THEN 'Toxicology'
    WHEN CPTCodes IN ('87486,87541,87563,87631,87640,87798') THEN 'Wound Panel'
	WHEN CPTCodes IN ('87481,87563,87640,87651,87798', '87481,87640,87651,87653,87798', 
	'87481,87500,87640,87641,87651,87653,87798') THEN 'UTI Panel'
    ELSE NULL END;

	UPDATE CLS SET CLS.PanelCode = LIS.PanelCode FROM ClaimsLevelStatus CLS
	JOIN LISMaster LIS ON CLS.VisitNumber = LIS.VisitNumberIH WHERE CLS.PanelCode IS NULL


	UPDATE CLS SET CLS.LISPanel = LIS.PanelCode FROM ClaimsLevelStatus CLS
	JOIN LISMaster LIS ON CLS.VisitNumber = LIS.VisitNumberIH

	UPDATE BM SET BM.PanelCode = CLS.PanelCode FROM BillingMaster BM
	JOIN ClaimsLevelStatus CLS ON Bm.VisitNumber = CLS.VisitNumber 

	Update ClaimsLevelStatus SET PanelCode = 'Unable to Locate' WHERE PanelCode IS NULL;

	Update BillingMaster SET PanelCode = 'Unable to Locate' WHERE PanelCode IS NULL;

    /*========================================================
      1) Direct AccessionNo match: cheap and highly selective
    ========================================================*/
   
    UPDATE BM
       SET BM.PanelName = CD.OrderInfo,
           BM.LISPanel = ISNULL(CD.PanelCode,'Unable to Locate')
    FROM dbo.BillingMaster AS BM
    JOIN LISMaster AS CD
        ON BM.VisitNumber = CD.VisitNumberIH
    --WHERE BM.PanelCode IS NULL

END
GO
