/* Master deployment script. Run in SSMS with SQLCMD Mode ON (Query > SQLCMD Mode),
   or via: sqlcmd -S <server> -i sql/00_DeployAll.sql
   Every referenced script is idempotent and safe to re-run. */

:setvar Path "."

PRINT '== LRNMaster ==';
:r $(Path)\LRNMaster\01_ReportRunIdInfoLog.sql
:r $(Path)\LRNMaster\02_ReportsWorkflowTracker.sql

PRINT '== Per-lab: LineClaimFileLogs additive migration ==';
USE [NWL_LRN];
GO
:r $(Path)\Labs\_Common\03_LineClaimFileLogs_AddStatusColumns.sql
USE [BeechTree_LRN];
GO
:r $(Path)\Labs\_Common\03_LineClaimFileLogs_AddStatusColumns.sql
USE [RisingTides];
GO
:r $(Path)\Labs\_Common\03_LineClaimFileLogs_AddStatusColumns.sql
USE [LRN_PCRLOA];
GO
:r $(Path)\Labs\_Common\03_LineClaimFileLogs_AddStatusColumns.sql
USE [Certus_LRN];
GO
:r $(Path)\Labs\_Common\03_LineClaimFileLogs_AddStatusColumns.sql
USE [Augustus_LRN];
GO
:r $(Path)\Labs\_Common\03_LineClaimFileLogs_AddStatusColumns.sql
USE [Elixir_LRN];
GO
:r $(Path)\Labs\_Common\03_LineClaimFileLogs_AddStatusColumns.sql

PRINT '== Per-lab data tables ==';
:r $(Path)\Labs\NWL_LRN\01_LineLevelData.sql
:r $(Path)\Labs\NWL_LRN\02_ClaimLevelData.sql
:r $(Path)\Labs\BeechTree_LRN\01_LineLevelData.sql
:r $(Path)\Labs\BeechTree_LRN\02_ClaimLevelData.sql
:r $(Path)\Labs\RisingTides\01_LineLevelData.sql
:r $(Path)\Labs\RisingTides\02_ClaimLevelData.sql
:r $(Path)\Labs\LRN_PCRLOA\01_LineLevelData.sql
:r $(Path)\Labs\LRN_PCRLOA\02_ClaimLevelData.sql
:r $(Path)\Labs\Certus_LRN\01_LineLevelData.sql
:r $(Path)\Labs\Certus_LRN\02_ClaimLevelData.sql
:r $(Path)\Labs\Augustus_LRN\01_LineLevelData.sql
:r $(Path)\Labs\Augustus_LRN\02_ClaimLevelData.sql
:r $(Path)\Labs\Elixir_LRN\01_LineLevelData.sql
:r $(Path)\Labs\Elixir_LRN\02_ClaimLevelData.sql
