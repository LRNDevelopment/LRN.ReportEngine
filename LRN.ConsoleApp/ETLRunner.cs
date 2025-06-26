using LRN.ExcelToSqlETL.Core.Interface;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace LRN.ConsoleApp
{
    public class ETLRunner
    {
        private readonly IFileReader _reader;
        private readonly IDataValidator _validator;
        private readonly IDataImporter _importer;
        private readonly IExcelMapperLoader _mapper;

        public ETLRunner(IFileReader reader, IDataValidator validator, IDataImporter importer, IExcelMapperLoader mapper)
        {
            _reader = reader;
            _validator = validator;
            _importer = importer;
            _mapper = mapper;
        }

        public async Task RunAsync()
        {
            var mapping = _mapper.LoadMapping("MapperJSON/LISFile.json");
            using var stream = File.OpenRead("SampleFiles/transactions.xlsx");

            var tables = await _reader.ReadAsync(stream, mapping);

            foreach (var table in tables)
            {
                var result = _validator.Validate(table, mapping);
                if (!result.IsValid)
                {
                    foreach (var err in result.Errors)
                        Console.WriteLine("Validation error: " + err);
                    continue;
                }

                await _importer.ImportAsync(table, mapping.TargetTable);
                Console.WriteLine($"Imported {table.Rows.Count} rows to {mapping.TargetTable}");
            }
        }
    }

}
