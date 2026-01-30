using System.Data;

public static class BillingGrouper
{
	public static DataTable BuildBillingCounts(IEnumerable<BillingLineRow> source, int labId)
	{
		var result = new DataTable();
		result.Columns.Add("LabId", typeof(int));
		result.Columns.Add("ChartNumber", typeof(string));
		result.Columns.Add("PanelCarrier", typeof(string));
		result.Columns.Add("CPTCode", typeof(string));
		result.Columns.Add("PeriodType", typeof(string));
		result.Columns.Add("PeriodStart", typeof(DateTime));
		result.Columns.Add("UniqueBillingCount", typeof(int));

		// Deduplicate unique billing by Patient + Payer + CPT + Billing#
		// If duplicates exist, keep earliest DOS
		var uniqueBillings = source
			.Where(x => !string.IsNullOrWhiteSpace(x.ChartNumber) && !string.IsNullOrWhiteSpace(x.VisitNumber))
			.GroupBy(x => new { x.ChartNumber, x.PanelCarrier, x.CPTCode, x.VisitNumber })
			.Select(g => g.OrderBy(x => x.BeginDOS).First());

		// Expand to 4 buckets
		var expanded = uniqueBillings.SelectMany(x => new[]
		{
			new { x.ChartNumber, x.PanelCarrier, x.CPTCode, PeriodType="DAY",   PeriodStart=x.BeginDOS.Date },
			new { x.ChartNumber, x.PanelCarrier, x.CPTCode, PeriodType="WEEK",  PeriodStart=GetWeekStartMonday(x.BeginDOS.Date) },
			new { x.ChartNumber, x.PanelCarrier, x.CPTCode, PeriodType="MONTH", PeriodStart=new DateTime(x.BeginDOS.Year, x.BeginDOS.Month, 1) },
			new { x.ChartNumber, x.PanelCarrier, x.CPTCode, PeriodType="YEAR",  PeriodStart=new DateTime(x.BeginDOS.Year, 1, 1) },
		});

		var grouped = expanded
			.GroupBy(x => new { x.ChartNumber, x.PanelCarrier, x.CPTCode, x.PeriodType, x.PeriodStart })
			.Select(g => new { g.Key.ChartNumber, g.Key.PanelCarrier, g.Key.CPTCode, g.Key.PeriodType, g.Key.PeriodStart, Cnt = g.Count() });

		foreach (var g in grouped)
			result.Rows.Add(labId, g.ChartNumber, g.PanelCarrier, g.CPTCode, g.PeriodType, g.PeriodStart, g.Cnt);

		return result;
	}

	private static DateTime GetWeekStartMonday(DateTime d)
	{
		int diff = ((int)d.DayOfWeek - (int)DayOfWeek.Monday + 7) % 7;
		return d.AddDays(-diff).Date;
	}
}
