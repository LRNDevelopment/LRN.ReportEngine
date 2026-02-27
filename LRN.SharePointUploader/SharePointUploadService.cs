using LRN.SharePointClient.Abstractions;
using LRN.SharePointClient.Models;

namespace LRN.SharePointUploader;

public sealed class SharePointUploadService
{
    private readonly ISharePointClient _sp;

    public SharePointUploadService(ISharePointClient sp)
    {
        _sp = sp;
    }

    public Task UploadAsync(SharePointLocation location, string localFilePath, string targetFileName, CancellationToken ct)
        => _sp.UploadFileAsync(location, targetFileName, localFilePath, overwrite: true, ct);
}
