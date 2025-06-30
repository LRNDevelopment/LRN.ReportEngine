using Common.Logging;
using LRN.DataAccess.Repository.Interfaces;
using LRN.ExcelToSqlETL.Core.Constants;
using LRN.ExcelToSqlETL.Core.DtoModels;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;
using System;
using System.Collections.Generic;
using System.IO;
using System.Threading.Tasks;

[Authorize]
public class UploadController : Controller
{
    private readonly ILoggerService _logger;
    private readonly IConfiguration _config;
    private readonly IImportFilesRepository _importRepo;

    public UploadController(
       ILoggerService logger,
       IConfiguration config,
       IImportFilesRepository importRepo)
    {
        _logger = logger;
        _config = config;
        _importRepo = importRepo;
    }

    public async Task<IActionResult> Index()
    {
        var result = await _importRepo.GetImportFilesAsync();
        var files = new List<FileUpload>();
        
        foreach (var file in result)
        {
            var _file = new FileUpload();
            _file.FileType = file.FileType;
            _file.ProcessedOn = file.ProcessedOn;
            _file.ImportedOn = file.ImportedOn;
            _file.ImportedRowCount = file.ImportedRowCount;
            _file.ExcelRowCount = file.ExcelRowCount;
            _file.FileStatus = file.FileStatus;
            _file.FileStatusName = file.FileStatusName;
            _file.FileTypeName = file.FileTypeName;
            _file.ImportFileName = file.ImportFileName;
            files.Add(_file);
        }
        return View(files); // Pass List<ImportFileDto> to view
    }

    [HttpPost]
    public async Task<IActionResult> UploadFile(string lab, string fileType, IFormFile file)
    {
        if (file != null && file.Length > 0)
        {
            var uploadsFolder = Path.Combine(CommonConst.ImportFilePath);


            if (!Directory.Exists(uploadsFolder))
                Directory.CreateDirectory(uploadsFolder);

            var uniqueFileName = $"{Guid.NewGuid()}_{Path.GetFileName(file.FileName)}";
            var filePath = Path.Combine(uploadsFolder, uniqueFileName);

            using (var stream = new FileStream(filePath, FileMode.Create))
            {
                await file.CopyToAsync(stream);
            }

            ImportFileDto fileDto = new ImportFileDto();
            fileDto.ImportFileName = Path.GetFileName(file.FileName);
            //fileDto.FileType = fileType;
            // TODO: Insert file metadata into database here via _importRepo

            _logger.Info($"File uploaded: {file.FileName}, Lab: {lab}, Type: {fileType}");
        }

        return RedirectToAction("Index");
    }
}
