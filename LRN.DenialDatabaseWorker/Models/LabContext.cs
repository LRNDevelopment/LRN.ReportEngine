public sealed class LabContext
{
	public int LabId { get; }
	public string LabName { get; }
	public string RunId { get; }
	public DateTime CreatedOn { get; }

	public LabContext(int labId, string labName, string runId)
	{
		LabId = labId;
		LabName = labName;
		RunId = runId;
		CreatedOn = DateTime.UtcNow;
	}
}
