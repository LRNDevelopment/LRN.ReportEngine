using System;
using System.Collections.Generic;

namespace LRN.DataAccess.Models;

public partial class ProdStatusRuleEngine
{
    public int RuleId { get; set; }

    public string? ResultedDateCondition { get; set; }

    public string? BilledDateCondition { get; set; }

    public string? TotalChargeCondition { get; set; }

    public string? TotalAllowedCondition { get; set; }

    public string? CarrierPaymentCondition { get; set; }

    public string? CarrierWoCondition { get; set; }

    public string? PatientPaymentCondition { get; set; }

    public string? PatientWoCondition { get; set; }

    public string? CarrierBalanceCondition { get; set; }

    public string? PatientBalanceCondition { get; set; }

    public string? TotalBalanceCondition { get; set; }

    public string? DenialCodeCondition { get; set; }

    public string? FinalOutputStatus { get; set; }
}
