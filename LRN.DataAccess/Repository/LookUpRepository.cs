using AutoMapper;
using LRN.DataAccess.Context;
using LRN.DataAccess.Models;
using LRN.DataAccess.Repository.InterFaces;
using LRN.ExcelToSqlETL.Core.DtoModels;
using Microsoft.Extensions.Logging;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace LRN.DataAccess.Repository
{
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
        public Task<List<ImportFileTypesDto>> GetImportFileTypes()
        {
            throw new NotImplementedException();
        }
    }
}
