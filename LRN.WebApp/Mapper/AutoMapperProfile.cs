using AutoMapper;
using LRN.DataAccess.Models;
using LRN.ExcelToSqlETL.Core.DtoModels;

namespace LRN.WebApp.Mapper
{
    public class AutoMapperProfile : Profile
    {
        public AutoMapperProfile()
        {
            // Map ImportedFile <--> ImportFileDto
            CreateMap<ImportedFile, ImportFileDto>().ReverseMap();

            // Add other mappings if needed
        }
    }
}
