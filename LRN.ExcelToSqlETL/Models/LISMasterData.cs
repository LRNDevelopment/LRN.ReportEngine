using System.ComponentModel.DataAnnotations.Schema;

namespace LRN.ExcelToSqlETL.Core.Models
{
    public class LISMasterData
    {
        [PropertyName(ColumnName = "Specimen ID")]
        public string? AccessionNo { get; set; }

        [PropertyName(ColumnName = "LabName")]
        public string? LabName { get; set; }

        [PropertyName(ColumnName = "BillingProvider")]
        public string? BillingProvider { get; set; }

        [PropertyName(ColumnName = "Patient")]
        public string? PatientName { get; set; }

        [PropertyName(ColumnName = "PatientID")]
        public string? PatientID { get; set; }

        [PropertyName(ColumnName = "PatientDOB")]
        public DateOnly? PatientDOB { get; set; }

        [PropertyName(ColumnName = "Payer")]
        public string? PrimaryPayerName { get; set; }

        [PropertyName(ColumnName = "PayerType")]
        public string? PayerType { get; set; }

        [PropertyName(ColumnName = "Member ID")]
        public string? PrimaryMemberId { get; set; }

        [PropertyName(ColumnName = "PrimaryGroupNo")]
        public string? PrimaryGroupNo { get; set; }

        [PropertyName(ColumnName = "PrimaryEffectiveDate")]
        public DateOnly? PrimaryEffectiveDate { get; set; }

        [PropertyName(ColumnName = "RelationshipToInsurance")]
        public string? RelationshipToInsurance { get; set; }

        [PropertyName(ColumnName = "SecondaryPayerId")]
        public int? SecondaryPayerId { get; set; }

        [PropertyName(ColumnName = "SecondaryMemberID")]
        public string? SecondaryMemberID { get; set; }

        [PropertyName(ColumnName = "SecondaryGroupNo")]
        public string? SecondaryGroupNo { get; set; }

        [PropertyName(ColumnName = "SecondaryEffectiveDate")]
        public DateOnly? SecondaryEffectiveDate { get; set; }

        [PropertyName(ColumnName = "Collected")]
        public DateOnly? SampleCollectedDate { get; set; }

        [PropertyName(ColumnName = "Received")]
        public DateOnly? SampleReceivedDate { get; set; }

        [PropertyName(ColumnName = "Accessioned")]
        public DateOnly? SampleAccessionedDate { get; set; }

        [PropertyName(ColumnName = "Resulted")]
        public DateOnly? SampleResultedDate { get; set; }

        [PropertyName(ColumnName = "SampleRunDate")]
        public DateOnly? SampleRunDate { get; set; }

        [PropertyName(ColumnName = "Status")]
        public string? SpecimenStatusName { get; set; }

        [PropertyName(ColumnName = "Bill to")]
        public string? BilledTo { get; set; }

        [PropertyName(ColumnName = "ReferringProviderName")]
        public string? ReferringProviderName { get; set; }

        [PropertyName(ColumnName = "SpecimenType")]
        public string? SpecimenType { get; set; }

        [PropertyName(ColumnName = "Customer")]
        public string? ClinicName { get; set; }

        [PropertyName(ColumnName = "SalesPersonId")]
        public int? SalesPersonId { get; set; }

        [PropertyName(ColumnName = "OperationsGroup")]
        public string? OperationsGroup { get; set; }

        [PropertyName(ColumnName = "ICD10Code")]
        public string? ICD10Code { get; set; }

        [PropertyName(ColumnName = "CPTCodes")]
        public string? CPTCodes { get; set; }

        [PropertyName(ColumnName = "TestCode")]
        public string? TestCode { get; set; }

        [PropertyName(ColumnName = "Test Type")]
        public string? TestTypeName { get; set; }

        [PropertyName(ColumnName = "Sendouts")]
        public string? Sendouts { get; set; }

        [PropertyName(ColumnName = "TurnAround")]
        public int? TurnAround { get; set; }

        [PropertyName(ColumnName = "OutStanding")]
        public int? OutStanding { get; set; }

        [PropertyName(ColumnName = "Order Info")]
        public string? OrderInfo { get; set; }

        [PropertyName(ColumnName = "Panel Category")]
        public string? PanelName { get; set; }

        [PropertyName(ColumnName = "PanelCode")]
        public string? PanelCode { get; set; }

        [PropertyName(ColumnName = "Resulted / Not")]
        public string? ResultedStatus { get; set; }

        [PropertyName(ColumnName = "DaystoReceive")]
        public int? DaystoReceive { get; set; }

        [PropertyName(ColumnName = "Time to Result (E - C)")]
        public int? DaystoResult { get; set; }

        [PropertyName(ColumnName = "Time to Bill (M - E)")]
        public int? DaystoBill { get; set; }

        [PropertyName(ColumnName = "Client Status")]
        public string? ClientStatus { get; set; }

        [PropertyName(ColumnName = "Visit #")]
        public string? VisitNumber { get; set; }

        [PropertyName(ColumnName = "BillingSubStatus")]
        public string? BillingSubStatus { get; set; }

        [PropertyName(ColumnName = "Billed / Not")]
        public string? BillingStatus { get; set; }

        [PropertyName(ColumnName = "AMD LBD")]
        public DateOnly? FirstBilledDate { get; set; }

        [PropertyName(ColumnName = "AMD DOE")]
        public DateOnly? ChargeEntryDate { get; set; }

        [PropertyName(ColumnName = "Self Pay")]
        public string? SelfPay { get; set; }

        [PropertyName(ColumnName = "Account Pay")]
        public string? AccountPay { get; set; }

        [PropertyName(ColumnName = "Contract Pay")]
        public string? ContractPay { get; set; }

        [PropertyName(ColumnName = "Analtyics")]
        public string? Analtyics { get; set; }

        [PropertyName(ColumnName = "ScrubSettings")]
        public string? ScrubSettings { get; set; }

        [PropertyName(ColumnName = "Actions")]
        public string? Actions { get; set; }

        [PropertyName(ColumnName = "PanelGroup")]
        public string? PanelGroup { get; set; }
    }
}
