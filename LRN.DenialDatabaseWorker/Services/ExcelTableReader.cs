using System.Data;
using ExcelDataReader;

namespace DenialDatabaseProcessorWorker.Services
{
	public sealed class ExcelTableReader
	{
		public List<Dictionary<string, string>> Read(
			string filePath,
			string? sheetName = null,
			bool isPayerPolicy = false)
		{
			var rows = new List<Dictionary<string, string>>();

			System.Text.Encoding.RegisterProvider(System.Text.CodePagesEncodingProvider.Instance);

			using var stream = File.Open(filePath, FileMode.Open, FileAccess.Read, FileShare.ReadWrite);
			using var reader = ExcelReaderFactory.CreateReader(stream);

			var result = reader.AsDataSet(new ExcelDataSetConfiguration
			{
				ConfigureDataTable = _ => new ExcelDataTableConfiguration
				{
					UseHeaderRow = false
				}
			});

			if (result == null || result.Tables.Count == 0)
				return rows;

			DataTable table;

			if (!string.IsNullOrWhiteSpace(sheetName))
			{
				table = result.Tables.Cast<DataTable>()
					.FirstOrDefault(t => t.TableName.Equals(sheetName, StringComparison.OrdinalIgnoreCase))
					?? throw new InvalidOperationException($"Sheet '{sheetName}' not found.");
			}
			else
			{
				table = result.Tables[0];
			}

			if (table.Rows.Count == 0)
				return rows;

			int headerRowIndex = isPayerPolicy
				? FindPayerPolicyHeaderRow(table)
				: FindSimpleHeaderRow(table);

			var headers = new List<string>();
			for (int i = 0; i < table.Columns.Count; i++)
			{
				var header = table.Rows[headerRowIndex][i]?.ToString()?.Trim() ?? $"Column{i}";
				headers.Add(header);
			}

			for (int r = headerRowIndex + 1; r < table.Rows.Count; r++)
			{
				var dr = table.Rows[r];
				var dict = new Dictionary<string, string>(StringComparer.OrdinalIgnoreCase);

				for (int c = 0; c < headers.Count; c++)
				{
					object cellObj = c < dr.ItemArray.Length ? dr[c] : null;
					string raw;

					if (cellObj is double d)
					{
						try
						{
							var dt = DateTime.FromOADate(d);
							raw = dt.ToString("MM/dd/yyyy");
						}
						catch
						{
							raw = d.ToString();
						}
					}
					else if (cellObj is DateTime dt)
					{
						raw = dt.ToString("MM/dd/yyyy");
					}
					else
					{
						raw = cellObj?.ToString()?.Trim() ?? "";
					}

					dict[headers[c]] = raw;
				}

				rows.Add(dict);
			}

			return rows;
		}

		// For Claim Mapper and simple sheets
		private int FindSimpleHeaderRow(DataTable table)
		{
			for (int r = 0; r < Math.Min(10, table.Rows.Count); r++)
			{
				int nonEmpty = 0;
				for (int c = 0; c < table.Columns.Count; c++)
				{
					var cell = table.Rows[r][c]?.ToString();
					if (!string.IsNullOrWhiteSpace(cell))
						nonEmpty++;
				}

				if (nonEmpty >= 3)
					return r;
			}

			return 0;
		}

		// For Payer Policy (uses known Excel headers)
		private int FindPayerPolicyHeaderRow(DataTable table)
		{
			var knownHeaders = new HashSet<string>(StringComparer.OrdinalIgnoreCase)
			{
				"Accession No", "Allowed Amount", "Visit Number", "Insurance Payment",
				"CPTCode", "Insurance Adjustment", "Patient DOB", "Patient Paid Amount",
				"Payer Code", "Patient Adjustment", "Payer Name", "Insurance Balance",
				"PayerName Normalized", "Patient Balance", "Pay Status", "Total Balance",
				"Historical Payment", "Medicare Fee", "Historical Paid Line-Item Count",
				"Final Claim Status", "Historical Payment Confidence Score",
				"Covered ICD 10 Codes Billed", "Total Line-Item Count",
				"Non Covered ICD 10 Codes Billed", "Paid Line-Item Count",
				"Billed ICD codes not available in Payer Policy",
				"% Paid Line-Item Count", "Coverage Status", "Payer Type",
				"Final Coverage Status", "PayerFound in Policy",
				"Covered ICD 10 codes as per Payer Policy", "Date of Service",
				"Non Covered ICD 10 Codes as per Payer Policy", "First Billed Date",
				"Action Comment", "Panel Name", "Resolution", "LIS ICD 10 Codes",
				"Lab Name", "CCW ICD10Code", "Coding Validation",
				"Units", "Coding Validation Sub-Status", "Modifier",
				"ICD Compliance Status", "DenialCode", "ICD Compliance Substatus",
				"Denial Description", "ICD Primary Indicator Available",
				"Billed Amount", "Covered ICD Presence", "ICD Validation Confidence",
				"Frequency Condition Met", "Gender Condition Met", "Payability",
				"Forecasting Payability", "Policy Coverage Expectation",
				"Denial Validity", "Coverage Expectation Remarks",
				"Expected Average Allowed Amount", "Expected Average Insurance Payment",
				"Expected Allowed Amount - Same Lab",
				"Expected Insurance Payment - Same Lab",
				"Mode Allowed Amount - Same Lab",
				"Mode Insurance Paid - Same Lab",
				"Mode Allowed Amount- Peer", "Mode Insurance Paid - Peer",
				"Median Allowed Amount- Same Lab",
				"Median Insurance Paid - Same Lab",
				"Median Allowed Amount- Peer",
				"Median Insurance Paid - Peer",
				"Mode Allowed Amount Difference",
				"Mode Insurance Paid Difference",
				"Median Allowed Amount Difference",
				"Median Insurance Paid Difference",
				"Denial Rate", "Adjustment Rate", "Payment Days",
				"Expected Payment Date", "Expected Payment Month",
				"BillingProvider", "ReferringProvider", "ClinicName",
				"SalesRepname", "PatientID", "ChargeEnteredDate",
				"POS", "TOS", "CheckDate", "DaystoDOS", "RollingDays",
				"DaystoBill", "DaystoPost", "Denial Date"
			};

			for (int r = 0; r < Math.Min(20, table.Rows.Count); r++)
			{
				int matches = 0;

				for (int c = 0; c < table.Columns.Count; c++)
				{
					var cell = table.Rows[r][c]?.ToString()?.Trim();
					if (!string.IsNullOrWhiteSpace(cell) && knownHeaders.Contains(cell))
						matches++;
				}

				if (matches >= 10) // enough headers to be confident
					return r;
			}

			return 0;
		}
	}
}