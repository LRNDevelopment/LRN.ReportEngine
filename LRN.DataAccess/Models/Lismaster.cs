using System;
using System.Collections.Generic;

namespace LRN.DataAccess.Models;

public partial class Lismaster
{
    public long LismasterId { get; set; }

    public string AccessionNo { get; set; } = null!;

    public int? LabId { get; set; }

    public int? BillingProviderId { get; set; }

    public string? PatientName { get; set; }

    public string? PatientId { get; set; }

    public string? PatientDob { get; set; }

    public string? ResponsibleParty { get; set; }

    public string? PrimaryPayerName { get; set; }

    public string? PrimaryMemberId { get; set; }

    public string? PrimaryGroupNo { get; set; }

    public DateOnly? PrimaryEffectiveDate { get; set; }

    public string? RelationshipToInsurance { get; set; }

    public int? SecondaryPayerId { get; set; }

    public string? SecondaryMemberId { get; set; }

    public string? SecondaryGroupNo { get; set; }

    public DateOnly? SecondaryEffectiveDate { get; set; }

    public DateOnly? SampleCollectedDate { get; set; }

    public DateOnly? SampleReceivedDate { get; set; }

    public DateOnly? SampleAccessionedDate { get; set; }

    public DateOnly? SampleResultedDate { get; set; }

    public DateOnly? SampleRunDate { get; set; }

    public int? SampleStatusId { get; set; }

    public string? BilledTo { get; set; }

    public int? ReferringProviderId { get; set; }

    public int? ClinicId { get; set; }

    public int? SalesPersonId { get; set; }

    public int? OperationalGroupId { get; set; }

    public string? Icd10code { get; set; }

    public string? TestCode { get; set; }

    public int? TestTypeId { get; set; }

    public string? Sendouts { get; set; }

    public int? TurnAround { get; set; }

    public int? OutStanding { get; set; }

    public string? OrderInfo { get; set; }

    public int? PanelId { get; set; }

    public string? PanelCode { get; set; }

    public string? PanelName { get; set; }

    public string? ResultedStatus { get; set; }

    public int? DaystoReceive { get; set; }

    public int? DaystoResult { get; set; }

    public int? DaystoBill { get; set; }

    public string? ClientStatus { get; set; }

    public int? PayerTypeId { get; set; }

    public string? SpecimenType { get; set; }

    public string? BillingSubStatus { get; set; }

    public string? BillingStatus { get; set; }

    public DateOnly? FirstBilledDate { get; set; }

    public DateOnly? ChargeEntryDate { get; set; }

    public string? VisitNumber { get; set; }

    public string? SelfPay { get; set; }

    public string? AccountPay { get; set; }

    public string? ContractPay { get; set; }

    public string? Analtyics { get; set; }

    public string? ScrubSettings { get; set; }

    public string? Actions { get; set; }

    public DateTime? CreatedOn { get; set; }

    public string? CreatedBy { get; set; }

    public virtual ICollection<BillingMaster> BillingMasters { get; set; } = new List<BillingMaster>();

    public virtual BillingProviderMaster? BillingProvider { get; set; }

    public virtual ClinicMaster? Clinic { get; set; }

    public virtual LabMaster? Lab { get; set; }

    public virtual OperationsGroupMaster? OperationalGroup { get; set; }

    public virtual PanelGroup? Panel { get; set; }

    public virtual PayerTypeMaster? PayerType { get; set; }

    public virtual ReferringProviderMaster? ReferringProvider { get; set; }

    public virtual SpecimenStatus? SampleStatus { get; set; }

    public virtual TestTypeMaster? TestType { get; set; }
}
