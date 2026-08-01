/* Master deployment script. Run in SSMS with SQLCMD Mode ON (Query > SQLCMD Mode),
   or via: sqlcmd -S <server> -i sql/00_DeployAll.sql
   Every referenced script is idempotent and safe to re-run. */

:setvar Path "."

PRINT '== LRNMaster ==';
:r $(Path)\LRNMaster\01_ReportRunIdInfoLog.sql
:r $(Path)\LRNMaster\02_ReportsWorkflowTracker.sql
:r $(Path)\LRNMaster\03_ReportTypeMaster.sql
:r $(Path)\LRNMaster\04_AddColumns_RunLog_StepLog_InfoLog.sql
:r $(Path)\LRNMaster\05_usp_ReportRunIdInfoLog_Insert.sql
:r $(Path)\LRNMaster\06_usp_ReportsWorkflowTracker_Upsert.sql

PRINT '== Per-lab: LineClaimFileLogs (create or migrate) ==';
USE [NWL_LRN];
GO
:r $(Path)\Labs\_Common\02_LineClaimFileLogs.sql
USE [BeechTree_LRN];
GO
:r $(Path)\Labs\_Common\02_LineClaimFileLogs.sql
USE [RisingTides];
GO
:r $(Path)\Labs\_Common\02_LineClaimFileLogs.sql
USE [LRN_PCRLOA];
GO
:r $(Path)\Labs\_Common\02_LineClaimFileLogs.sql
USE [CertusLRN];
GO
:r $(Path)\Labs\_Common\02_LineClaimFileLogs.sql
USE [Augustus_LRN];
GO
:r $(Path)\Labs\_Common\02_LineClaimFileLogs.sql
USE [Elixir_LRN];
GO
:r $(Path)\Labs\_Common\02_LineClaimFileLogs.sql

PRINT '== Per-lab data tables ==';
:r $(Path)\Labs\NWL_LRN\01_LineLevelData.sql
:r $(Path)\Labs\NWL_LRN\02_ClaimLevelData.sql
:r $(Path)\Labs\BeechTree_LRN\01_LineLevelData.sql
:r $(Path)\Labs\BeechTree_LRN\02_ClaimLevelData.sql
:r $(Path)\Labs\RisingTides\01_LineLevelData.sql
:r $(Path)\Labs\RisingTides\02_ClaimLevelData.sql
:r $(Path)\Labs\LRN_PCRLOA\01_LineLevelData.sql
:r $(Path)\Labs\LRN_PCRLOA\02_ClaimLevelData.sql
:r $(Path)\Labs\CertusLRN\01_LineLevelData.sql
:r $(Path)\Labs\CertusLRN\02_ClaimLevelData.sql
:r $(Path)\Labs\Augustus_LRN\01_LineLevelData.sql
:r $(Path)\Labs\Augustus_LRN\02_ClaimLevelData.sql
:r $(Path)\Labs\Elixir_LRN\01_LineLevelData.sql
:r $(Path)\Labs\Elixir_LRN\02_ClaimLevelData.sql
