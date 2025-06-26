using LRN.DataAccess.Models;
using LRN.ExcelToSqlETL.Core.DtoModels;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace LRN.DataAccess.Repository.InterFaces
{
    public interface ILookUpRepository
    {
        Task<List<ImportFileTypesDto>> GetImportFileTypes();
    }
}
