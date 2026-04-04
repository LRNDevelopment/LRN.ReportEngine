public sealed class LabContext
{
	public int LabId { get; }
	public string LabName { get; }
	public string RunId { get; }
	public string ConnectionString { get; }

	public LabContext(int labId, string labName, string runId, string connectionString)
	{
		LabId = labId;
		LabName = labName;
		RunId = runId;
		ConnectionString = connectionString;
	}
}