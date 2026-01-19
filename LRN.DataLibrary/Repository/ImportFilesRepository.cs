using Dapper;
using LRN.DataLibrary.Models;
using LRN.DataLibrary.Repository.Interfaces;
using LRN.ExcelToSqlETL.Core.Constants;
using LRN.ExcelToSqlETL.Core.DtoModels;
using LRN.ExcelToSqlETL.Core.Models;
using Microsoft.Data.SqlClient;
using Microsoft.EntityFrameworkCore;
using Microsoft.VisualBasic.FileIO;
using System.Data;
using System.Linq;
using System.Net.NetworkInformation;
using static LRN.ExcelToSqlETL.Core.Constants.CommonConst;
using static Microsoft.EntityFrameworkCore.DbLoggerCategory.Database;

namespace LRN.DataLibrary.Repository;

public class ImportFilesRepository : IImportFilesRepository
{
	private readonly DapperContext _context;

	public ImportFilesRepository(DapperContext context)
	{
		_context = context;
	}

	public async Task<List<ImportFileDto>> InsertImportFilesDataAsync(List<ImportFileDto> files)
	{
		if (files == null || files.Count == 0)
			return new List<ImportFileDto>();

		const string sql = @"INSERT INTO ImportedFiles (ImportFileName, ExcelRowCount, ImportedRowCount, FileStatus, ImportedOn, FileType, ProcessedOn, LabId,ImportFilePath)
                             VALUES (@ImportFileName, @ExcelRowCount, @ImportedRowCount, @FileStatus, @ImportedOn, @FileType, @ProcessedOn, @LabId,@ImportFilePath);
                             SELECT CAST(SCOPE_IDENTITY() as int);";
		using var connection = _context.CreateConnection();
		foreach (var file in files)
		{
			var id = await connection.ExecuteScalarAsync<int>(sql, file);
			file.ImportedFileId = id;
		}
		return files;
	}

	public async Task<ImportFileDto> AddImportFileAync(ImportFileDto file)
	{
		var list = await InsertImportFilesDataAsync(new List<ImportFileDto> { file });
		return list.First();
	}

	public async Task UpdateImportFilesAsync(List<ImportFileDto> files)
	{
		const string sql = @"UPDATE ImportedFiles SET  ExcelRowCount=@ExcelRowCount, ImportedRowCount=@ImportedRowCount, FileStatus=@FileStatus,  ProcessedOn=GETDATE()  WHERE ImportedFileID = @ImportedFileId";
		using var connection = _context.CreateConnection();
		await connection.ExecuteAsync(sql, files);
	}

	public async Task UpdateFileAsync(ImportFileDto file)
	{
		await UpdateImportFilesAsync(new List<ImportFileDto> { file });
	}

    //// map file type -> staging table
    //private static readonly IReadOnlyDictionary<int, string> StagingByType = new Dictionary<int, string>
    //{
    //    [(int)CommonConst.ImportFileType.LIS_Report] = "dbo.LISStaging",
    //    [(int)CommonConst.ImportFileType.Custom_Collection] = "dbo.CustomCollectionStaging",
    //    [(int)CommonConst.ImportFileType.Visit_Against_Accession] = "dbo.VisitAgaistAccessionStaging",
    //    [(int)CommonConst.ImportFileType.Transaction_Detail_Report] = "dbo.TransactionDetailStaging",
    //    [(int)CommonConst.ImportFileType.Denial_Tracking_Report] = "dbo.DenialTrackingStaging",
    //    [(int)CommonConst.ImportFileType.Prism_Billing_Sheet] = "dbo.PrismBillingStaging",
    //    [(int)CommonConst.ImportFileType.Accession_Payment_Report] = "dbo.AccPaymentReportStaging",
    //    [(int)CommonConst.ImportFileType.Order_LIS] = "dbo.DiagnoseLISStaging",
    //    [(int)CommonConst.ImportFileType.Diagnos_SampleLIS] = "dbo.DiagnoseLISStaging",
    //    [(int)CommonConst.ImportFileType.Panel_Group] = "dbo.PanelMasterStaging",
    //    [(int)CommonConst.ImportFileType.Client_Billing_Sheet] = "dbo.ClientBillingSheet"
    //};

    //private static readonly IReadOnlyDictionary<int, string> ProcByType = new Dictionary<int, string>
    //{
    //	#region Cove Files
    //	[(int)CommonConst.ImportFileType.Cove_LIS_Report] = "SP_Process_LISMaster_ByFileId",
    //	[(int)CommonConst.ImportFileType.Cove_Custom_Collection] = "SProcessImportFilesAsyncp_ProcessBillingMasterData",
    //	[(int)CommonConst.ImportFileType.Cove_Transaction_Detail_Report] = "Sp_ProcessTransactionDetails",
    //	[(int)CommonConst.ImportFileType.Cove_Denial_Tracking_Report] = "Sp_ProcessDenialTrackingMaster",
    //	[(int)CommonConst.ImportFileType.Cove_Accession_Payment_Report] = "Sp_ProcessAccessionPaymentReport",
    //	[(int)CommonConst.ImportFileType.Commit_Denial_Report] = "sp_ProcessCommitDenialStaging",
    //	[(int)CommonConst.ImportFileType.Commit_Transaction_Report] = "sp_ProcessCommitTransactionReport",
    //	#endregion

    //	#region InHealth_DTR FILES
    //	[(int)CommonConst.ImportFileType.InHealthDTR_LIS_Master] = "SP_Process_LISMaster_ByFileId",
    //	[(int)CommonConst.ImportFileType.InHealth_CCW] = "Sp_ProcessBillingMasterData",
    //	[(int)CommonConst.ImportFileType.DTR_CCW] = "Sp_ProcessBillingMasterData",
    //	[(int)CommonConst.ImportFileType.VISIT_AGAINST_ACCESSION_IHDTR] = "Sp_Process_VAA_ByFileId",
    //	[(int)CommonConst.ImportFileType.Transaction_Detail_Report_IHDTR] = "Sp_ProcessTransactionDetails",
    //	[(int)CommonConst.ImportFileType.InHealth_Denial_Tracking] = "Sp_ProcessDenialTrackingMaster",
    //	[(int)CommonConst.ImportFileType.DTR_Denail_Tracking] = "Sp_ProcessDenialTrackingMaster",
    //	[(int)CommonConst.ImportFileType.Nexum_Claim_Scrubbing_DTR] = "Sp_ProcessNexusClaimDTRIH",
    //	[(int)CommonConst.ImportFileType.Nexum_Claim_Scrubbing_IH] = "Sp_ProcessNexusClaimDTRIH",
    //	[(int)CommonConst.ImportFileType.Nexum_Preprocessing_DTR] = "Sp_ProcessNexusClaimDTRIH",
    //	[(int)CommonConst.ImportFileType.Nexum_Preprocessing_IH] = "Sp_ProcessNexusClaimDTRIH",
    //       #endregion



    //       #region PCRCOandPCRAL FILES
    //       [(int)CommonConst.ImportFileType.PCRCO_LIS] = "SP_Process_LISPCRCO",
    //       [(int)CommonConst.ImportFileType.Custom_Collection] = "BillingMasterProcess_Proc,Sp_PopulateBillingSummary",
    //       [(int)CommonConst.ImportFileType.Visit_Against_Accession] = "Sp_Process_VAA_ByFileId",
    //       [(int)CommonConst.ImportFileType.Denial_Tracking_Report] = "Sp_ProcessDenialTrackingMaster",
    //       [(int)CommonConst.ImportFileType.Transaction_Detail_Report] = "Sp_ProcessTransactionDetails",


    //       [(int)CommonConst.ImportFileType.IATLISFile] = "SP_Process_PCRAL",
    //       [(int)CommonConst.ImportFileType.Supplement_LIS_Stagging] = "Sp_Process_SupplementLIS",
    //       [(int)CommonConst.ImportFileType.Supplement_Visit_Against_Accession] = "Sp_Process_VAA_ByFileId",
    //       [(int)CommonConst.ImportFileType.Suppliment_Custom_Collection] = "SP_ProcessSuppliments",
    //       [(int)CommonConst.ImportFileType.NexumPreprocessingData_CO] = "SP_ProcessSuppliments",
    //       [(int)CommonConst.ImportFileType.NexumPreprocessingData_AL] = "SP_ProcessSuppliments",
    //       [(int)CommonConst.ImportFileType.NexumClaimScrubblingData_CO] = "SP_ProcessSuppliments",
    //       [(int)CommonConst.ImportFileType.NexumClaimScrubblingData_AL] = "SP_ProcessSuppliments",


    //       [(int)CommonConst.ImportFileType.InHealth_Denial_Tracking] = "Sp_ProcessDenialTrackingMaster",
    //       [(int)CommonConst.ImportFileType.DTR_Denail_Tracking] = "Sp_ProcessDenialTrackingMaster",
    //       [(int)CommonConst.ImportFileType.Nexum_Claim_Scrubbing_DTR] = "Sp_ProcessNexusClaimDTRIH",
    //       [(int)CommonConst.ImportFileType.Nexum_Claim_Scrubbing_IH] = "Sp_ProcessNexusClaimDTRIH",
    //       [(int)CommonConst.ImportFileType.Nexum_Preprocessing_DTR] = "Sp_ProcessNexusClaimDTRIH",
    //       [(int)CommonConst.ImportFileType.Nexum_Preprocessing_IH] = "Sp_ProcessNexusClaimDTRIH",
    //       #endregion


    //       #region LRN MASTER FILES
    //       [(int)CommonConst.ImportFileType.Denial_Code_Mapper] = "sp_ProcessDenailCodeMapper",
    //	#endregion
    //};

    //public async Task ProcessImportFilesAsync(ImportFileDto file)
    //{
    //	using var connection = _context.CreateConnection();

    //	// Cast to SqlConnection to access OpenAsync
    //	if (connection is SqlConnection sqlConnection)
    //	{
    //		await sqlConnection.OpenAsync();
    //	}
    //	else
    //	{
    //		connection.Open(); // Fallback for other providers
    //	}

    //	using var transaction = connection.BeginTransaction();

    //	try
    //	{
    //		int commandTimeout = 2500;
    //		if (file.FileType != (int)CommonConst.ImportFileType.Denial_Code_Mapper)
    //			await connection.ExecuteAsync("sp_InsertMasterData", transaction: transaction, commandType: CommandType.StoredProcedure, commandTimeout: commandTimeout);

    //		if (file != null)
    //		{
    //			////// 1) get ALL related import file ids safely (await, no .Result)
    //			////var ids = (await GetImportFilesByFileType(file.FileType, (int)file.ImportedFileId))
    //			////          ?.Distinct().ToList() ?? new List<int>();

    //			////// 2) purge staging inside the SAME transaction, parameterized, batched
    //			////if (ids.Count > 0 && StagingByType.TryGetValue(file.FileType, out var table))
    //			////{
    //			////    const int batchSize = 1000; // under 2100-param limit headroom
    //			////    var sql = $"DELETE t FROM {table} AS t WHERE t.ImportedFileID IN @Ids";

    //			////    foreach (var chunk in ids.Chunk(batchSize))
    //			////    {
    //			////        var delCmd = new CommandDefinition(
    //			////            sql,
    //			////            new { Ids = chunk },
    //			////            transaction: transaction,
    //			////            commandTimeout: commandTimeout,          // consider 0 = infinite if you expect long runs
    //			////            commandType: CommandType.Text);

    //			////        await connection.ExecuteAsync(delCmd);
    //			////    }
    //			////}

    //			// 3) run the processing proc, still inside the SAME transaction & explicit timeout
    //			if (ProcByType.TryGetValue(file.FileType, out var proc))
    //			{
    //				var p = new DynamicParameters();
    //				p.Add("@FileId", file.ImportedFileId, DbType.Int32);

    //				var procCmd = new CommandDefinition(
    //					proc,
    //					parameters: p,
    //					transaction: transaction,
    //					commandTimeout: commandTimeout,             // or 0 for infinite
    //					commandType: CommandType.StoredProcedure);

    //				await connection.ExecuteAsync(procCmd);
    //			}
    //		}

    //		transaction.Commit();
    //	}
    //	catch (Exception ex)
    //	{
    //		transaction.Rollback();
    //		throw ex;
    //	}
    //}


    //public async Task ProcessImportFilesGroupAsync(List<ImportFileDto> files)
    //{
    //    if (files == null || !files.Any())
    //        throw new ArgumentException("File list is empty or null.");

    //    using var transaction = await _dbContext.Database.BeginTransactionAsync();

    //    try
    //    {
    //        await _dbContext.Database.ExecuteSqlInterpolatedAsync($"EXEC sp_InsertMasterData");

    //        var fileGroups = files
    //            .Where(f => f.ImportedFileId != 0)
    //            .GroupBy(f => (ImportFileType)f.FileType)
    //            .ToDictionary(g => g.Key, g => string.Join(",", g.Select(f => f.ImportedFileId)));

    //        fileGroups.TryGetValue(ImportFileType.LIS_Report, out string lisFileId);
    //        fileGroups.TryGetValue(ImportFileType.Visit_Against_Accession, out string vaaFileId);
    //        fileGroups.TryGetValue(ImportFileType.Custom_Collection, out string customCollectionFileId);
    //        fileGroups.TryGetValue(ImportFileType.Prism_Billing_Sheet, out string billingSheetFileId);
    //        fileGroups.TryGetValue(ImportFileType.Denial_Tracking_Report, out string denialFileId);
    //        fileGroups.TryGetValue(ImportFileType.Transaction_Detail_Report, out string transFileId);

    //        await _dbContext.Database.ExecuteSqlInterpolatedAsync(
    //            $"EXEC SP_Process_LISMaster_From_Staging {lisFileId}, {vaaFileId}, {customCollectionFileId}, {billingSheetFileId}");

    //        await _dbContext.Database.ExecuteSqlInterpolatedAsync(
    //            $"EXEC Sp_ProcessBillingMasterData {customCollectionFileId}");

    //        await _dbContext.Database.ExecuteSqlInterpolatedAsync(
    //            $"EXEC Sp_ProcessDenialTrackingMaster {denialFileId}");

    //        await _dbContext.Database.ExecuteSqlInterpolatedAsync(
    //            $"EXEC Sp_ProcessTransactionDetails {transFileId}");

    //        foreach (var file in files)
    //        {
    //            file.ProcessedOn = DateTime.Now;
    //            file.FileStatus = (int)CommonConst.FileStatusEnum.ImportSuccess;
    //        }

    //        await UpdateImportFilesAsync(files);
    //        await transaction.CommitAsync();
    //    }
    //    catch (Exception ex)
    //    {
    //        await transaction.RollbackAsync();
    //        //.LogError(ex, "An error occurred while processing import files.");
    //        throw new ApplicationException("An error occurred while processing import files.", ex);
    //    }
    //}


    private static readonly IReadOnlyDictionary<int, string[]> ProcByType = new Dictionary<int, string[]>
    {
        #region Cove Files
        [(int)CommonConst.ImportFileType.Cove_LIS_Report] = new[] { "SP_Process_LISMaster_ByFileId" },
        [(int)CommonConst.ImportFileType.Cove_Custom_Collection] = new[] { "SProcessImportFilesAsyncp_ProcessBillingMasterData" },
        [(int)CommonConst.ImportFileType.Cove_Transaction_Detail_Report] = new[] { "Sp_ProcessTransactionDetails" },
        [(int)CommonConst.ImportFileType.Cove_Denial_Tracking_Report] = new[] { "Sp_ProcessDenialTrackingMaster" },
        [(int)CommonConst.ImportFileType.Cove_Accession_Payment_Report] = new[] { "Sp_ProcessAccessionPaymentReport" },
        [(int)CommonConst.ImportFileType.Commit_Denial_Report] = new[] { "sp_ProcessCommitDenialStaging" },
        [(int)CommonConst.ImportFileType.Commit_Transaction_Report] = new[] { "sp_ProcessCommitTransactionReport" },
        #endregion

        #region InHealth_DTR FILES
        [(int)CommonConst.ImportFileType.InHealthDTR_LIS_Master] = new[] { "SP_Process_LISMaster_ByFileId" },
        [(int)CommonConst.ImportFileType.InHealth_CCW] = new[] { "Sp_ProcessBillingMasterData" },
        [(int)CommonConst.ImportFileType.DTR_CCW] = new[] { "Sp_ProcessBillingMasterData" },
        [(int)CommonConst.ImportFileType.VISIT_AGAINST_ACCESSION_IHDTR] = new[] { "Sp_Process_VAA_ByFileId" },
        [(int)CommonConst.ImportFileType.Transaction_Detail_Report_IHDTR] = new[] { "Sp_ProcessTransactionDetails" },
        [(int)CommonConst.ImportFileType.InHealth_Denial_Tracking] = new[] { "Sp_ProcessDenialTrackingMaster" },
        [(int)CommonConst.ImportFileType.DTR_Denail_Tracking] = new[] { "Sp_ProcessDenialTrackingMaster" },
        [(int)CommonConst.ImportFileType.Nexum_Claim_Scrubbing_DTR] = new[] { "Sp_ProcessNexusClaimDTRIH" },
        [(int)CommonConst.ImportFileType.Nexum_Claim_Scrubbing_IH] = new[] { "Sp_ProcessNexusClaimDTRIH" },
        [(int)CommonConst.ImportFileType.Nexum_Preprocessing_DTR] = new[] { "Sp_ProcessNexusClaimDTRIH" },
        [(int)CommonConst.ImportFileType.Nexum_Preprocessing_IH] = new[] { "Sp_ProcessNexusClaimDTRIH" },
        #endregion

        #region PCRCOandPCRAL FILES
        [(int)CommonConst.ImportFileType.PCRCO_LIS] = new[] { "SP_Process_LISPCRCO" },
        // Custom_Collection now runs two stored procedures
        [(int)CommonConst.ImportFileType.Custom_Collection] = new[] { "BillingMasterProcess_Proc", "Sp_PopulateBillingSummary" },
        [(int)CommonConst.ImportFileType.Visit_Against_Accession] = new[] { "Sp_Process_VAA_ByFileId" },
        [(int)CommonConst.ImportFileType.Denial_Tracking_Report] = new[] { "Sp_ProcessDenialTrackingMaster" },
        [(int)CommonConst.ImportFileType.Transaction_Detail_Report] = new[] { "Sp_ProcessTransactionDetails" },
        [(int)CommonConst.ImportFileType.IATLISFile] = new[] { "SP_Process_PCRAL" },
        [(int)CommonConst.ImportFileType.Supplement_LIS_Stagging] = new[] { "Sp_Process_SupplementLIS" },
        [(int)CommonConst.ImportFileType.Supplement_Visit_Against_Accession] = new[] { "Sp_Process_VAA_ByFileId" },
        [(int)CommonConst.ImportFileType.Suppliment_Custom_Collection] = new[] { "SP_ProcessSuppliments" },
        [(int)CommonConst.ImportFileType.NexumPreprocessingData_CO] = new[] { "SP_ProcessSuppliments" },
        [(int)CommonConst.ImportFileType.NexumPreprocessingData_AL] = new[] { "SP_ProcessSuppliments" },
        [(int)CommonConst.ImportFileType.NexumClaimScrubblingData_CO] = new[] { "SP_ProcessSuppliments" },
        [(int)CommonConst.ImportFileType.NexumClaimScrubblingData_AL] = new[] { "SP_ProcessSuppliments" },
        #endregion

        #region LRN MASTER FILES
        [(int)CommonConst.ImportFileType.Denial_Code_Mapper] = new[] { "sp_ProcessDenailCodeMapper" },
        [(int)CommonConst.ImportFileType.CPTFeeSchedule] = new[] { "SP_UpdateMasterProcess" },
        [(int)CommonConst.ImportFileType.InsuranceMaster] = new[] { "SP_UpdateMasterProcess" },
        #endregion
    };

    public async Task ProcessImportFilesAsync(ImportFileDto file)
    {
        using var connection = _context.CreateConnection();

        // Cast to SqlConnection to access OpenAsync
        if (connection is SqlConnection sqlConnection)
        {
            await sqlConnection.OpenAsync();
        }
        else
        {
            connection.Open(); // Fallback for other providers
        }

        using var transaction = connection.BeginTransaction();

        try
        {
            int commandTimeout = 2500;
            if (file.FileType != (int)CommonConst.ImportFileType.Denial_Code_Mapper)
                await connection.ExecuteAsync("sp_InsertMasterData", transaction: transaction, commandType: CommandType.StoredProcedure, commandTimeout: commandTimeout);

            if (file != null && ProcByType.TryGetValue(file.FileType, out var procedures))
            {
                // Run all stored procedures for this file type
                foreach (var proc in procedures)
                {
                    var p = new DynamicParameters();
                    p.Add("@FileId", file.ImportedFileId, DbType.Int32);

                    var procCmd = new CommandDefinition(
                        proc,
                        parameters: p,
                        transaction: transaction,
                        commandTimeout: commandTimeout,
                        commandType: CommandType.StoredProcedure);

                    await connection.ExecuteAsync(procCmd);
                }
            }

            transaction.Commit();
        }
        catch (Exception ex)
        {
            transaction.Rollback();
            throw; // Fixed: use throw instead of throw ex to preserve stack trace
        }
    }
    public async Task<List<ImportFileDto>> GetImportFilesAsync(bool isMasterImport = false)
	{
		const string sql = @"
				SELECT
					a.ImportedFileID     AS ImportedFileId,
					a.ImportFileName,
					b.FileTypeName,
					c.FileStatus         AS FileStatusName,
					a.ExcelRowCount,
					a.ImportedRowCount,
					a.ImportedOn,
					a.ProcessedOn,
					a.LabId,
					a.ImportFilePath,
					c.FileStatusId,
                    b.IsMasterImport
				FROM dbo.ImportedFiles a WITH (NOLOCK)
				JOIN dbo.ImportFilTypes b WITH (NOLOCK) ON a.FileType  = b.FileTypeId
				JOIN dbo.FileStatuses  c WITH (NOLOCK) ON a.FileStatus = c.FileStatusId
				WHERE b.IsMasterImport = @IsMasterImport
				ORDER BY a.ImportedOn DESC;";

		using var connection = _context.CreateConnection();
		var results = await connection.QueryAsync<ImportFileDto>(sql, new { IsMasterImport = isMasterImport });
		return results.AsList(); // slightly faster than ToList()
	}


	public async Task<List<ImportFileDto>> GetImportFilesAsync()
	{
		const string sql = @"
				SELECT
					a.ImportedFileID     AS ImportedFileId,
					a.ImportFileName,
					b.FileTypeName,
					c.FileStatus         AS FileStatusName,
					a.ExcelRowCount,
					a.ImportedRowCount,
					a.ImportedOn,
					a.ProcessedOn,
					a.LabId,
					a.ImportFilePath,
                    b.IsMasterImport,
					c.FileStatusId
				FROM dbo.ImportedFiles a WITH (NOLOCK)
				JOIN dbo.ImportFilTypes b WITH (NOLOCK) ON a.FileType  = b.FileTypeId
				JOIN dbo.FileStatuses  c WITH (NOLOCK) ON a.FileStatus = c.FileStatusId
				ORDER BY a.ImportedOn DESC;";

		using var connection = _context.CreateConnection();
		var results = await connection.QueryAsync<ImportFileDto>(sql);
		return results.AsList(); // slightly faster than ToList()
	}

	public async Task<List<ImportFileTypesDto>> GetImportFilesTypesAsync()
	{
		const string query = "Select FileTypeId,(CAST(SeqNo AS VARCHAR)+' . ' + FileTypeName) FileTypeName from ImportFilTypes WITH (NOLOCK)  WHERE IsActive = 1  ORDER BY SeqNo";
		using var connection = _context.CreateConnection();
		var results = await connection.QueryAsync<ImportFileTypesDto>(query);
		return results.ToList();
	}

	public async Task<List<int>> GetImportFilesByFileType(int fileType, int fileId)
	{
		const string sql = @"
        SELECT ImportedFileID
        FROM dbo.ImportedFiles WITH (NOLOCK)
        WHERE FileType = @fileType AND ImportedFileID = @fileId;";

		using var connection = _context.CreateConnection();
		var results = await connection.QueryAsync<int>(sql, new { fileType, fileId });
		return results.ToList();
	}

	public async Task<List<ReportDownloadSts>> GetReportDownloadStslst()
	{
		const string query = "SELECT a.[ReportID],a.[ReportName],a.[ReportType],a.[ReportServerPath],a.[ReportStatus],a.[CreatedOn]," +
			 "b.FileStatus, a.LogString,CompletedOn FROM [dbo].[ReportDownloadSts] a WITH (NOLOCK) join FileStatuses b WITH (NOLOCK) on a.ReportStatus = b.FileStatusId";

		using var connection = _context.CreateConnection();
		var results = await connection.QueryAsync<ReportDownloadSts>(query);
		return results.ToList();
	}

	public async Task<ImportFileDto> GetImportFileById(int fileId)
	{
		const string query = @"
        SELECT [ImportedFileID], [ImportFileName], [ExcelRowCount], [ImportedRowCount], 
               [FileStatus], [FileType], [ImportedOn], [ProcessedOn], [LabId], [ImportFilePath]
        FROM [dbo].[ImportedFiles] WITH (NOLOCK)
        WHERE ImportedFileID = @FileId";  // parameterized


		using var connection = _context.CreateConnection();
		// Use parameterized query to avoid SQL Injection
		var result = await connection.QuerySingleOrDefaultAsync<ImportFileDto>(query, new { FileId = fileId });

		return result;
	}

	public async Task<List<FileLog>> InsertFileLog(List<FileLog> fileLogs)
	{
		if (!fileLogs.Any())
			return new List<FileLog>();

		const string sql = @"INSERT INTO [dbo].[ImportFileLogs] ([ImportFileId],[LogType],[LogMessage],[RowNo],[ColumnName],[CreatedOn])
                                     VALUES (@ImportFileId,@LogType,@LogMessage,@RowNo,@ColumnName,GETDATE());";
		using var connection = _context.CreateConnection();
		foreach (var log in fileLogs)
		{
			await connection.ExecuteAsync(sql, log);
		}
		return fileLogs;
	}

	public async Task<ReportDownloadSts> InsertReportDownloadSts(ReportDownloadSts reportDownloadSts)
	{
		const string sql = @"INSERT INTO [dbo].[ReportDownloadSts]([ReportName],[ReportType],[ReportStatus],[CreatedOn])
                                     VALUES (@ReportName,@ReportType,@ReportStatus,GETDATE());";
		using var connection = _context.CreateConnection();
		await connection.ExecuteAsync(sql, reportDownloadSts);
		return reportDownloadSts;
	}

	public async Task<List<FileLog>> GetFileLogsById(int fileId)
	{
		const string query = @"SELECT LogType, LogMessage, RowNo, ColumnName, CreatedOn 
                           FROM ImportFileLogs WITH (NOLOCK)
                           WHERE ImportFileId = @FileId 
                           ORDER BY CreatedOn";


		using var connection = _context.CreateConnection();
		var results = await connection.QueryAsync<FileLog>(query, new { FileId = fileId });
		return results.ToList();
	}

	public async Task<ReportDownloadSts> GetDownloadReportById(int fileId)
	{
		const string query = "select * from ReportDownloadSts WITH (NOLOCK) Where ReportID = @FileId";  // parameterized

		using var connection = _context.CreateConnection();
		// Use parameterized query to avoid SQL Injection
		var result = await connection.QuerySingleOrDefaultAsync<ReportDownloadSts>(query, new { FileId = fileId });

		return result;
	}

	public async Task<List<LabMaster>> GetLabMaster()
	{
		const string query = "SELECT LabId, LabName, ConnectionKey FROM Labs WITH (NOLOCK) WHERE IsActive = 1";
		using var connection = _context.CreateConnection();

		var result = await connection.QueryAsync<LabMaster>(query);
		return result.ToList();
	}

	public async Task<ImportFilType> GetImportFileType(int fileTypeId)
	{
		const string query = "SELECT FileTypeId,FileTypeName,LabId,IsActive,SeqNo,TemplateFileName FROM ImportFilTypes Where FileTypeId = @FileTypeId";

		using var connection = _context.CreateConnection();
		// Use parameterized query to avoid SQL Injection
		var result = await connection.QuerySingleOrDefaultAsync<ImportFilType>(query, new { FileTypeId = fileTypeId });

		return result;
	}

	public async Task<List<Models.DownloadReportType>> GetDownloadReportTypes()
	{
		const string query = "Select ReportTypeId,ReportName from DownloadReportTypes Where IsActive = 1 ORDER BY SeqNo";

		using var connection = _context.CreateConnection();
		// Use parameterized query to avoid SQL Injection
		var result = await connection.QueryAsync<Models.DownloadReportType>(query);
		return result.ToList();
	}


}
