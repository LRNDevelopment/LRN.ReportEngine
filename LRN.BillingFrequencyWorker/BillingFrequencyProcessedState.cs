
using System.Text.Json;

public sealed class BillingFrequencyProcessedState
{
    public Dictionary<int, ProcessedLabEntry> Labs { get; set; } = new();

    public bool IsProcessed(int labId, string inputPath, DateTime inputLastWriteUtc)
    {
        if (!Labs.TryGetValue(labId, out var entry)) return false;

        return string.Equals(entry.InputPath, inputPath, StringComparison.OrdinalIgnoreCase)
               && entry.InputLastWriteUtcTicks == inputLastWriteUtc.Ticks;
    }

    public void MarkProcessed(int labId, string inputPath, DateTime inputLastWriteUtc, string outputPath)
    {
        Labs[labId] = new ProcessedLabEntry
        {
            InputPath = inputPath,
            InputLastWriteUtcTicks = inputLastWriteUtc.Ticks,
            OutputPath = outputPath,
            ProcessedUtcTicks = DateTime.UtcNow.Ticks
        };
    }

    public static BillingFrequencyProcessedState Load(string path)
    {
        try
        {
            if (!File.Exists(path)) return new BillingFrequencyProcessedState();
            var json = File.ReadAllText(path);
            return JsonSerializer.Deserialize<BillingFrequencyProcessedState>(json) ?? new BillingFrequencyProcessedState();
        }
        catch
        {
            return new BillingFrequencyProcessedState();
        }
    }

    public static void Save(string path, BillingFrequencyProcessedState state)
    {
        Directory.CreateDirectory(Path.GetDirectoryName(path)!);
        var json = JsonSerializer.Serialize(state, new JsonSerializerOptions { WriteIndented = true });
        File.WriteAllText(path, json);
    }
}

public sealed class ProcessedLabEntry
{
    public string InputPath { get; set; } = "";
    public long InputLastWriteUtcTicks { get; set; }
    public string OutputPath { get; set; } = "";
    public long ProcessedUtcTicks { get; set; }
}
