using LRN.ExcelToSqlETL.Core.Interface;
using LRN.ExcelToSqlETL.Core.Models;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Text.Json;
using System.Threading.Tasks;

namespace LRN.ExcelETL.Service.Services
{
    public class JsonExcelMapperLoader : IExcelMapperLoader
    {
        public ExcelSheetMapping LoadMapping(string path)
        {
            try
            {
                var json = File.ReadAllText(path);
                return JsonSerializer.Deserialize<ExcelSheetMapping>(json);
            }
            catch (Exception)
            {
                throw;
            }
         
        }
    }
}
