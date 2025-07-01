using Common.Logging;
using LRN.DataAccess.Repository.Interfaces;
using LRN.DataAccess.Repository.InterFaces;
using LRN.ExcelToSqlETL.Core.Constants;
using LRN.ExcelToSqlETL.Core.DtoModels;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;
using Microsoft.AspNetCore.Mvc.Rendering;
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

        // Labs dropdown
        ViewBag.Labs = new List<SelectListItem>
        {
            new SelectListItem { Text = "Select Lab", Value = "" },
            new SelectListItem { Text = "Prism", Value = "3" }
        };

        // FileTypes dropdown
        var importfile = await _importRepo.GetImportFilesTypesAsync(); // Make sure GetImportFileTypes() is async
        ViewBag.FileTypes = new List<SelectListItem>
        {
            new SelectListItem { Text = "Select Report Type", Value = "" }
        };

        ViewBag.FileTypes.AddRange(importfile.Select(l => new SelectListItem
        {
            Text = l.FileTypeName,
            Value = l.FileTypeId.ToString()
        }));

        // Build FileUpload view model list
        foreach (var file in result)
        {
            files.Add(new FileUpload
            {
                FileType = file.FileType,
                ProcessedOn = file.ProcessedOn,
                ImportedOn = file.ImportedOn,
                ImportedRowCount = file.ImportedRowCount,
                ExcelRowCount = file.ExcelRowCount,
                FileStatus = file.FileStatus,
                FileStatusName = file.FileStatusName,
                FileTypeName = file.FileTypeName,
                ImportFileName = file.ImportFileName
            });
        }

        return View(files);
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
