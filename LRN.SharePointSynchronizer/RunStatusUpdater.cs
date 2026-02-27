using LRN.DataLibrary.Abstractions;
using LRN.DataLibrary.Entities;

namespace LRN.SharePointSynchronizer;

/// <summary>
/// Minimal helper for the peer pipeline to update run status columns.
/// </summary>
public sealed class RunStatusUpdater
{
    private readonly ILrnLogRepository _repo;

    public RunStatusUpdater(ILrnLogRepository repo)
    {
        _repo = repo;
    }

    public async Task UpdatePeerStatusesAsync(LrnRunLog run, string payerPolicyStatus, string codingStatus, string averagesStatus, CancellationToken ct)
    {
        run.PayerPolicyValidationStatus = payerPolicyStatus;
        run.CodingValidationStatus = codingStatus;
        run.AveragesProcessStatus = averagesStatus;
        await _repo.UpdateRunAsync(run, ct);
    }
}
