using AutoMapper;
using LRN.DataAccess.Models;
using LRN.ExcelToSqlETL.Core.DtoModels;
using LRN.ExcelToSqlETL.Core.Models;

public class MappingProfile : Profile
{
    public MappingProfile()
    {
        CreateMap<ImportFileDto, ImportedFile>().ReverseMap();
        CreateMap<ImportedFile, ImportFileDto>().ReverseMap();

        CreateMap<ImportFileTypesDto, ImportFilType>().ReverseMap();
        CreateMap<ImportFilType, ImportFileTypesDto>().ReverseMap();
    }
}
