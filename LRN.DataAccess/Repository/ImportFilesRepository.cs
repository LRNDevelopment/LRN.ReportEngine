using AutoMapper;
using LRN.DataAccess.Context;
using LRN.DataAccess.Models;
using LRN.DataAccess.Repository.Interfaces;
using LRN.ExcelToSqlETL.Core.DtoModels;
using LRN.ExcelToSqlETL.Core.Models;
using Microsoft.Data.SqlClient;
using Microsoft.EntityFrameworkCore;
using Microsoft.Extensions.Logging;
using System.Data;
using static LRN.ExcelToSqlETL.Core.Constants.CommonConst;

namespace LRN.DataAccess.Repository
{
    public class ImportFilesRepository : IImportFilesRepository
    {
        private readonly LRNDbContext _dbContext;
        private readonly ILogger<ImportFilesRepository> _logger;
        private readonly IMapper _mapper;

        public ImportFilesRepository(LRNDbContext dbContext, ILogger<ImportFilesRepository> logger, IMapper mapper)
        {
            _dbContext = dbContext;
            _logger = logger;
            _mapper = mapper;
        }

        public async Task<List<ImportFileDto>> InsertImportFilesDataAsync(List<ImportFileDto> files)
        {
            try
            {
                if (files == null || !files.Any())
                    return new List<ImportFileDto>();

                var entities = _mapper.Map<List<ImportedFile>>(files);
                _dbContext.ImportedFiles.AddRange(entities);
                await _dbContext.SaveChangesAsync();

                _mapper.Map(entities, files); // update DTOs with DB-generated values
                return files;
            }
            catch (Exception ex)
            {
                _logger.LogError(ex, "An error occurred while inserting import files.");
                throw new ApplicationException("An error occurred while inserting import files.", ex);
            }
        }

        public async Task<ImportFileDto> AddImportFileAync(ImportFileDto file)
        {
            try
            {
                var entity = _mapper.Map<ImportedFile>(file);
                _dbContext.ImportedFiles.Add(entity);
                await _dbContext.SaveChangesAsync();

                _mapper.Map(entity, file); // update DTO with DB-generated values
                return file;
            }
            catch (Exception ex)
            {
                _logger.LogError(ex, "An error occurred while inserting an import file.");
                throw new ApplicationException("An error occurred while inserting an import file.", ex);
            }
        }

        public async Task UpdateImportFilesAsync(List<ImportFileDto> files)
        {
            try
            {
                foreach (var fileDto in files)
                {
                    var existingEntity = await _dbContext.ImportedFiles
                        .FirstOrDefaultAsync(e => e.ImportedFileId == fileDto.ImportedFileId);

                    if (existingEntity != null)
                    {
                        _mapper.Map(fileDto, existingEntity);
                    }
                    else
                    {
                        var newEntity = _mapper.Map<ImportedFile>(fileDto);
                        _dbContext.ImportedFiles.Add(newEntity);
                    }
                }

                await _dbContext.SaveChangesAsync();
            }
            catch (Exception ex)
            {
                _logger.LogError(ex, "An error occurred while updating import files.");
                throw new ApplicationException("An error occurred while updating import files.", ex);
            }
        }

        public async Task UpdateFileAsync(ImportFileDto file)
        {
            try
            {
                var existingEntity = await _dbContext.ImportedFiles
                    .FirstOrDefaultAsync(e => e.ImportedFileId == file.ImportedFileId);

                if (existingEntity == null)
                    throw new Exception($"File with ID {file.ImportedFileId} not found.");

                _mapper.Map(file, existingEntity);
                await _dbContext.SaveChangesAsync();
            }
            catch (Exception ex)
            {
                _logger.LogError(ex, "An error occurred while updating an import file.");
                throw new ApplicationException("An error occurred while updating an import file.", ex);
            }
        }

        public async Task ProcessImportFilesAsync(List<ImportFileDto> files)
        {
            if (files == null || !files.Any())
                throw new ArgumentException("File list is empty or null.");

            using var transaction = await _dbContext.Database.BeginTransactionAsync();

            try
            {
                await _dbContext.Database.ExecuteSqlInterpolatedAsync($"EXEC sp_InsertMasterData");

                var fileGroups = files
                    .Where(f => f.ImportedFileId != 0)
                    .GroupBy(f => (ImportFileType)f.FileType)
                    .ToDictionary(g => g.Key, g => string.Join(",", g.Select(f => f.ImportedFileId)));

                fileGroups.TryGetValue(ImportFileType.LIS_Report, out string lisFileId);
                fileGroups.TryGetValue(ImportFileType.Visit_Against_Accession, out string vaaFileId);
                fileGroups.TryGetValue(ImportFileType.Custom_Collection, out string customCollectionFileId);
                fileGroups.TryGetValue(ImportFileType.Prism_Billing_Sheet, out string billingSheetFileId);
                fileGroups.TryGetValue(ImportFileType.Denial_Tracking_Report, out string denialFileId);
                fileGroups.TryGetValue(ImportFileType.Transaction_Detail_Report, out string transFileId);

                await _dbContext.Database.ExecuteSqlInterpolatedAsync(
                    $"EXEC SP_Process_LISMaster_From_Staging {lisFileId}, {vaaFileId}, {customCollectionFileId}, {billingSheetFileId}");

                await _dbContext.Database.ExecuteSqlInterpolatedAsync(
                    $"EXEC Sp_ProcessBillingMasterData {customCollectionFileId}");

                await _dbContext.Database.ExecuteSqlInterpolatedAsync(
                    $"EXEC Sp_ProcessDenialTrackingMaster {denialFileId}");

                await _dbContext.Database.ExecuteSqlInterpolatedAsync(
                    $"EXEC Sp_ProcessTransactionDetails {transFileId}");

                foreach (var file in files)
                {
                    file.ProcessedOn = DateTime.Now;
                    file.FileStatus = (int)FileStatusEnum.ImportSuccess;
                }

                await UpdateImportFilesAsync(files);
                await transaction.CommitAsync();
            }
            catch (Exception ex)
            {
                await transaction.RollbackAsync();
                _logger.LogError(ex, "An error occurred while processing import files.");
                throw new ApplicationException("An error occurred while processing import files.", ex);
            }
        }

        public async Task<List<ImportFileDto>> GetImportFilesAsync()
        {
            var results = new List<ImportFileDto>();
            using var conn = _dbContext.Database.GetDbConnection();
            using var cmd = conn.CreateCommand();

            cmd.CommandText = @"
        SELECT ImportedFileID, ImportFileName, FileTypeName, c.FileStatus AS FileStatusName, 
               ExcelRowCount, ImportedRowCount, ImportedOn, ProcessedOn,a.LabId,l.LabName 
        FROM ImportedFiles a
        JOIN ImportFilTypes b ON a.FileType = b.FileTypeId
        JOIN FileStatuses c ON a.FileStatus = c.FileStatusId
        JOIN LabMaster l on a.LabId = l.LabID";
            cmd.CommandType = System.Data.CommandType.Text;

            await conn.OpenAsync();
            using var reader = await cmd.ExecuteReaderAsync();

            while (await reader.ReadAsync())
            {
                results.Add(new ImportFileDto
                {
                    ImportedFileId = reader["ImportedFileID"] != DBNull.Value ? Convert.ToInt32(reader["ImportedFileID"]) : (int?)null,
                    ImportFileName = reader["ImportFileName"]?.ToString(),
                    FileTypeName = reader["FileTypeName"]?.ToString(),
                    FileStatusName = reader["FileStatusName"]?.ToString(),
                    ExcelRowCount = reader["ExcelRowCount"] != DBNull.Value ? Convert.ToInt32(reader["ExcelRowCount"]) : (int?)null,
                    ImportedRowCount = reader["ImportedRowCount"] != DBNull.Value ? Convert.ToInt32(reader["ImportedRowCount"]) : (int?)null,
                    ImportedOn = reader["ImportedOn"] != DBNull.Value ? Convert.ToDateTime(reader["ImportedOn"]) : (DateTime?)null,
                    ProcessedOn = reader["ProcessedOn"] != DBNull.Value ? Convert.ToDateTime(reader["ProcessedOn"]) : (DateTime?)null,
                    LabName = reader["LabName"]?.ToString()
                });
            }

            return results;
        }

        public async Task<List<ImportFileTypesDto>> GetImportFilesTypesAsync()
        {
            var results = await _dbContext.ImportFilTypes
                .Select(c => new ImportFileTypesDto
                {
                    FileTypeId = c.FileTypeId,
                    FileTypeName = c.FileTypeName
                })
                .ToListAsync();

            return results;
        }

    }
}
