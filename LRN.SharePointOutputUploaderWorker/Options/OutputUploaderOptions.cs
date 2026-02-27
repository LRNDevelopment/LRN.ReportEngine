namespace LRN.SharePointOutputUploaderWorker.Options;

public sealed class OutputUploaderOptions
{
    public int PollingIntervalSeconds { get; set; } = 300;

    /// <summary>
    /// Where the peer pipeline writes payer policy / coding master outputs locally.
    /// Example: C:\LRN\Outputs
    /// </summary>
    public string ServerOutputsRoot { get; set; } = "outputs";

    public string SourceSystem { get; set; } = "LRN.SharePointOutputUploader";
}
