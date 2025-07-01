using AutoMapper;
using LRN.DataAccess.Context;
using LRN.DataAccess.Repository;
using LRN.DataAccess.Repository.InterFaces;
using LRN.ExcelToSqlETL.Core.DtoModels;
using Microsoft.EntityFrameworkCore;
using Microsoft.Extensions.Logging;

public class LookUpRepository : ILookUpRepository
{
    private readonly LRNDbContext _dbContext;

    private readonly ILogger<ImportFilesRepository> _logger;
    private readonly IMapper _mapper;

    public LookUpRepository(LRNDbContext dbContext, ILogger<ImportFilesRepository> logger, IMapper mapper)
    {
        _dbContext = dbContext;
        _logger = logger;
        _mapper = mapper;
    }


    public async Task<List<ImportFileTypesDto>> GetImportFileTypesAsync()
    {
        var result = await _dbContext.ImportFilTypes.ToListAsync();
        var importFiles = _mapper.Map<List<ImportFileTypesDto>>(result);
        return importFiles;
    }
}
