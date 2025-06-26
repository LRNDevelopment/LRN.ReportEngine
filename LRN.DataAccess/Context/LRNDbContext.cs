using LRN.DataAccess.Models;
using LRN.ExcelToSqlETL.Core.Models;
using Microsoft.EntityFrameworkCore;

namespace LRN.DataAccess.Context;

public partial class LRNDbContext : DbContext
{
    public LRNDbContext()
    {
    }

    public LRNDbContext(DbContextOptions<LRNDbContext> options)
        : base(options)
    {
    }

    public virtual DbSet<BillingProviderMaster> BillingProviderMasters { get; set; }

    public virtual DbSet<ClinicMaster> ClinicMasters { get; set; }

    public virtual DbSet<CptcodeMaster> CptcodeMasters { get; set; }

    public virtual DbSet<CustomCollectionStaging> CustomCollectionStagings { get; set; }

    public virtual DbSet<IcdcodeMaster> ICDCodeMaster { get; set; }

    public virtual DbSet<ImportedFile> ImportedFiles { get; set; }

    public virtual DbSet<InsurancePayerMaster> InsurancePayerMasters { get; set; }

    public virtual DbSet<LabMaster> LabMasters { get; set; }

    public virtual DbSet<Lisstaging> Lisstagings { get; set; }

    public virtual DbSet<OperationsGroupMaster> OperationsGroupMasters { get; set; }

    public virtual DbSet<PayerTypeMaster> PayerTypeMasters { get; set; }

    public virtual DbSet<ReferringProviderMaster> ReferringProviderMasters { get; set; }

    public virtual DbSet<SpecimenStatus> SpecimenStatuses { get; set; }

    public virtual DbSet<TestTypeMaster> TestTypeMasters { get; set; }

    public virtual DbSet<TransactionDetailStaging> TransactionDetailStagings { get; set; }

    public virtual DbSet<VisitAgaistAccessionStaging> VisitAgaistAccessionStagings { get; set; }

    public DbSet<ProdBillingData> ProdData { get; set; } // Not a real table, just used for SP mapping

    public DbSet<LISMasterData> LabResults { get; set; } // Not a real table, just used for SP mapping

    protected override void OnConfiguring(DbContextOptionsBuilder optionsBuilder)
#warning To protect potentially sensitive information in your connection string, you should move it out of source code. You can avoid scaffolding the connection string by using the Name= syntax to read it from configuration - see https://go.microsoft.com/fwlink/?linkid=2131148. For more guidance on storing connection strings, see https://go.microsoft.com/fwlink/?LinkId=723263.
        => optionsBuilder.UseSqlServer("data source=Jameel;initial catalog=PrismLRN;trusted_connection=true;TrustServerCertificate=True;");

    protected override void OnModelCreating(ModelBuilder modelBuilder)
    {
        modelBuilder.Entity<ProdBillingData>().HasNoKey();

        modelBuilder.Entity<LISMasterData>().HasNoKey();

        modelBuilder.Entity<BillingProviderMaster>(entity =>
        {
            entity.HasKey(e => e.BillingProviderId).HasName("PK__BillingP__B54C689DCB7BA376");

            entity.ToTable("BillingProviderMaster");

            entity.HasIndex(e => e.BillingProvider, "UQ__BillingP__D9A75BBA46313002").IsUnique();

            entity.Property(e => e.BillingProviderId).HasColumnName("ProviderID");
            entity.Property(e => e.BillingProvider).HasMaxLength(500);
            entity.Property(e => e.CreatedOn)
                .HasDefaultValueSql("(getdate())")
                .HasColumnType("datetime");
            entity.Property(e => e.IsActive).HasDefaultValue(true);
        });

        modelBuilder.Entity<ClinicMaster>(entity =>
        {
            entity.HasKey(e => e.ClinicId).HasName("PK__ClinicMa__3347C2DD43DFB12E");

            entity.ToTable("ClinicMaster");

            entity.HasIndex(e => e.ClinicName, "UQ__ClinicMa__A6FA569149B31111").IsUnique();

            entity.Property(e => e.ClinicName).HasMaxLength(500);
            entity.Property(e => e.ClinicStatus).HasDefaultValue(true);
            entity.Property(e => e.CreatedOn)
                .HasDefaultValueSql("(getdate())")
                .HasColumnType("datetime");
        });

        modelBuilder.Entity<CptcodeMaster>(entity =>
        {
            entity.HasKey(e => e.CptcodeId).HasName("PK__CPTCodeM__E8517A8055692435");

            entity.ToTable("CPTCodeMaster");

            entity.HasIndex(e => e.Cptcode, "UQ__CPTCodeM__44DA3F2F8FE0AD36").IsUnique();

            entity.Property(e => e.CptcodeId).HasColumnName("CPTCodeID");
            entity.Property(e => e.CodeDescription).HasMaxLength(500);
            entity.Property(e => e.Cptcode)
                .HasMaxLength(500)
                .HasColumnName("CPTCode");
            entity.Property(e => e.CreatedOn)
                .HasDefaultValueSql("(getdate())")
                .HasColumnType("datetime");
            entity.Property(e => e.IsActive).HasDefaultValue(true);
        });

        modelBuilder.Entity<CustomCollectionStaging>(entity =>
        {
            entity.HasKey(e => e.MemberId).HasName("PK__CustomCo__3214EC07A19D8053");

            entity.ToTable("CustomCollectionStaging");

            entity.Property(e => e.AccessionNo).HasMaxLength(500);
            entity.Property(e => e.AllowedAmount).HasColumnType("decimal(10, 2)");
            entity.Property(e => e.BeginDos)
                .HasColumnType("datetime")
                .HasColumnName("BeginDOS");
            entity.Property(e => e.BilledAmount).HasColumnType("decimal(10, 2)");
            entity.Property(e => e.BilledCptcode)
                .HasMaxLength(500)
                .HasColumnName("BilledCPTCode");
            entity.Property(e => e.BillingFrequency).HasMaxLength(500);
            entity.Property(e => e.BillingProvider).HasMaxLength(500);
            entity.Property(e => e.ChargeEnteredBy).HasMaxLength(500);
            entity.Property(e => e.ChargeEntryDate).HasColumnType("datetime");
            entity.Property(e => e.ClaimId).HasColumnName("ClaimID");
            entity.Property(e => e.ClientAccNum).HasMaxLength(500);
            entity.Property(e => e.Dob)
                .HasColumnType("datetime")
                .HasColumnName("DOB");
            entity.Property(e => e.EndDos)
                .HasColumnType("datetime")
                .HasColumnName("EndDOS");
            entity.Property(e => e.Icd10code)
                .HasMaxLength(500)
                .HasColumnName("ICD10Code");
            entity.Property(e => e.ImpotedOn)
                .HasDefaultValueSql("(getdate())")
                .HasColumnType("datetime");
            entity.Property(e => e.InsuranceAdjustments).HasColumnType("decimal(10, 2)");
            entity.Property(e => e.InsuranceBalance).HasColumnType("decimal(10, 2)");
            entity.Property(e => e.InsurancePayments).HasColumnType("decimal(10, 2)");
            entity.Property(e => e.LastBillDate).HasColumnType("datetime");
            entity.Property(e => e.MemberId)
                .HasMaxLength(500)
                .HasColumnName("MemberID");
            entity.Property(e => e.Modifier).HasMaxLength(500);
            entity.Property(e => e.PatientAdjustments).HasColumnType("decimal(10, 2)");
            entity.Property(e => e.PatientBalance).HasColumnType("decimal(10, 2)");
            entity.Property(e => e.PatientId).HasColumnName("PatientID");
            entity.Property(e => e.PatientName).HasMaxLength(500);
            entity.Property(e => e.PatientPayments).HasColumnType("decimal(10, 2)");
            entity.Property(e => e.PayerName).HasMaxLength(500);
            entity.Property(e => e.PayerType).HasMaxLength(500);
            entity.Property(e => e.PerformingLab).HasMaxLength(500);
            entity.Property(e => e.Pos)
                .HasMaxLength(500)
                .HasColumnName("POS");
            entity.Property(e => e.ReferringProvider).HasMaxLength(500);
            entity.Property(e => e.ResponsibleParty).HasMaxLength(500);
            entity.Property(e => e.Tos)
                .HasMaxLength(500)
                .HasColumnName("TOS");
            entity.Property(e => e.TotalBalance).HasColumnType("decimal(10, 2)");
        });

        modelBuilder.Entity<IcdcodeMaster>(entity =>
        {
            entity.HasKey(e => e.IcdcodeId).HasName("PK__ICDCodeM__3145FF4E4969FA02");

            entity.ToTable("ICDCodeMaster");

            entity.HasIndex(e => e.Icd10code, "UQ__ICDCodeM__1712921F3C423F7C").IsUnique();

            entity.Property(e => e.IcdcodeId).HasColumnName("ICDCodeID");
            entity.Property(e => e.CodeDescription).HasMaxLength(500);
            entity.Property(e => e.CreatedOn)
                .HasDefaultValueSql("(getdate())")
                .HasColumnType("datetime");
            entity.Property(e => e.Icd10code)
                .HasMaxLength(500)
                .HasColumnName("ICD10Code");
            entity.Property(e => e.IsActive).HasDefaultValue(true);
        });

        modelBuilder.Entity<ImportedFile>(entity =>
        {
            entity.HasKey(e => e.ImportedFileId).HasName("PK__Imported__6F0F98BF915435DD");

            entity.Property(e => e.ImportFileName).HasMaxLength(500);
            entity.Property(e => e.ImportedOn)
                .HasDefaultValueSql("(getdate())")
                .HasColumnType("datetime");
        });

        modelBuilder.Entity<InsurancePayerMaster>(entity =>
        {
            entity.HasKey(e => e.InsurancePayerId).HasName("PK__Insuranc__10CDEBF7C85841DF");

            entity.ToTable("InsurancePayerMaster");

            entity.HasIndex(e => e.PayerName, "UQ__Insuranc__F1989D975710A166").IsUnique();

            entity.Property(e => e.CreatedOn)
                .HasDefaultValueSql("(getdate())")
                .HasColumnType("datetime");
            entity.Property(e => e.IsActive).HasDefaultValue(true);
            entity.Property(e => e.PayerName).HasMaxLength(500);
        });

        modelBuilder.Entity<LabMaster>(entity =>
        {
            entity.HasKey(e => e.LabId).HasName("PK__LabMaste__EDBD773A6EC2571C");

            entity.ToTable("LabMaster");

            entity.HasIndex(e => e.LabName, "UQ__LabMaste__63D561307A40E4E3").IsUnique();

            entity.Property(e => e.LabId).HasColumnName("LabID");
            entity.Property(e => e.CreatedOn)
                .HasDefaultValueSql("(getdate())")
                .HasColumnType("datetime");
            entity.Property(e => e.IsActive).HasDefaultValue(true);
            entity.Property(e => e.LabName).HasMaxLength(500);
        });

        modelBuilder.Entity<Lisstaging>(entity =>
        {
            entity.HasKey(e => e.LisstagingId).HasName("PK__LISStagi__3214EC07FA8F91D2");

            entity.ToTable("LISStaging");

            entity.Property(e => e.AccessionNo).HasMaxLength(500);
            entity.Property(e => e.AccessionedDate).HasColumnType("datetime");
            entity.Property(e => e.AccountPay).HasMaxLength(500);
            entity.Property(e => e.Actions).HasMaxLength(500);
            entity.Property(e => e.Analtyics).HasMaxLength(500);
            entity.Property(e => e.ClinicName).HasMaxLength(500);
            entity.Property(e => e.CollectedDate).HasColumnType("datetime");
            entity.Property(e => e.ContractPay).HasMaxLength(500);
            entity.Property(e => e.ImportedOn)
                .HasDefaultValueSql("(getdate())")
                .HasColumnType("datetime");
            entity.Property(e => e.MemberId)
                .HasMaxLength(500)
                .HasColumnName("MemberID");
            entity.Property(e => e.OperationsGroup).HasMaxLength(500);
            entity.Property(e => e.Outstanding).HasMaxLength(50);
            entity.Property(e => e.PatientName).HasMaxLength(500);
            entity.Property(e => e.PayerName).HasMaxLength(500);
            entity.Property(e => e.PerformingLab).HasMaxLength(500);
            entity.Property(e => e.ReceivedDate).HasColumnType("datetime");
            entity.Property(e => e.Reference).HasMaxLength(500);
            entity.Property(e => e.RelToInsured).HasMaxLength(500);
            entity.Property(e => e.ResultedDate).HasColumnType("datetime");
            entity.Property(e => e.SalesRep).HasMaxLength(500);
            entity.Property(e => e.ScrubSettings).HasMaxLength(500);
            entity.Property(e => e.SelfPay).HasMaxLength(500);
            entity.Property(e => e.SpecimenStatus).HasMaxLength(500);
            entity.Property(e => e.TestType).HasMaxLength(500);
            entity.Property(e => e.Turnaround).HasMaxLength(50);
        });

        modelBuilder.Entity<OperationsGroupMaster>(entity =>
        {
            entity.HasKey(e => e.OperationGroupId).HasName("PK__Operatio__149AF30A883230E1");

            entity.ToTable("OperationsGroupMaster");

            entity.HasIndex(e => e.OperationsGroup, "UQ__Operatio__50488EDA071C772B").IsUnique();

            entity.Property(e => e.OperationGroupId).HasColumnName("GroupID");
            entity.Property(e => e.CreatedOn)
                .HasDefaultValueSql("(getdate())")
                .HasColumnType("datetime");
            entity.Property(e => e.IsActive).HasDefaultValue(true);
            entity.Property(e => e.OperationsGroup).HasMaxLength(500);
        });

        modelBuilder.Entity<PayerTypeMaster>(entity =>
        {
            entity.HasKey(e => e.PayerTypeId).HasName("PK__PayerTyp__E34E46DCCED64EBB");

            entity.ToTable("PayerTypeMaster");

            entity.HasIndex(e => e.PayerType, "UQ__PayerTyp__04488EE0B136EAFE").IsUnique();

            entity.Property(e => e.CreatedOn)
                .HasDefaultValueSql("(getdate())")
                .HasColumnType("datetime");
            entity.Property(e => e.IsActive).HasDefaultValue(true);
            entity.Property(e => e.PayerType).HasMaxLength(500);
        });

        modelBuilder.Entity<ReferringProviderMaster>(entity =>
        {
            entity.HasKey(e => e.ReferingProviderId).HasName("PK__Referrin__2A5C69B5259B199F");

            entity.ToTable("ReferringProviderMaster");

            entity.HasIndex(e => e.ReferringProviderName, "UQ__Referrin__08359E0496BB386B").IsUnique();

            entity.Property(e => e.CreatedOn)
                .HasDefaultValueSql("(getdate())")
                .HasColumnType("datetime");
            entity.Property(e => e.IsActive).HasDefaultValue(true);
            entity.Property(e => e.ReferringProviderName).HasMaxLength(500);
        });

        modelBuilder.Entity<SpecimenStatus>(entity =>
        {
            entity.HasKey(e => e.SpecimenStatusId).HasName("PK__Specimen__C8EE2063181FD731");

            entity.ToTable("SpecimenStatus");

            entity.HasIndex(e => e.SpecimenStatusName, "UQ__Specimen__E60BFA8A11DF8030").IsUnique();

            entity.Property(e => e.CreatedOn)
                .HasDefaultValueSql("(getdate())")
                .HasColumnType("datetime");
            entity.Property(e => e.IsActive).HasDefaultValue(true);
            entity.Property(e => e.SpecimenStatusName).HasMaxLength(500);
        });

        modelBuilder.Entity<TestTypeMaster>(entity =>
        {
            entity.HasKey(e => e.TestTypeId).HasName("PK__TestType__9BB876A6CC7508E3");

            entity.ToTable("TestTypeMaster");

            entity.HasIndex(e => e.TestTypeName, "UQ__TestType__662362AABB494C38").IsUnique();

            entity.Property(e => e.CreatedOn)
                .HasDefaultValueSql("(getdate())")
                .HasColumnType("datetime");
            entity.Property(e => e.IsActive).HasDefaultValue(true);
            entity.Property(e => e.TestTypeName).HasMaxLength(500);
        });

        modelBuilder.Entity<TransactionDetailStaging>(entity =>
        {
            entity.HasKey(e => e.TransactionDetailId).HasName("PK__Transact__3214EC07D84A1D2E");

            entity.ToTable("TransactionDetailStaging");

            entity.Property(e => e.AdjustmentAmount).HasColumnType("decimal(10, 2)");
            entity.Property(e => e.ChargeCode).HasMaxLength(150);
            entity.Property(e => e.ChartNumber).HasMaxLength(150);
            entity.Property(e => e.CheckNumber).HasMaxLength(150);
            entity.Property(e => e.DateofDeposit).HasColumnType("datetime");
            entity.Property(e => e.DateofEntry).HasColumnType("datetime");
            entity.Property(e => e.DateofService).HasColumnType("datetime");
            entity.Property(e => e.FacilityName).HasMaxLength(150);
            entity.Property(e => e.FinancialClass).HasMaxLength(150);
            entity.Property(e => e.ImportedOn)
                .HasDefaultValueSql("(getdate())")
                .HasColumnType("datetime");
            entity.Property(e => e.InsurancePaidAmount).HasColumnType("decimal(10, 2)");
            entity.Property(e => e.LabIdentityKey).HasMaxLength(150);
            entity.Property(e => e.Modifiers).HasMaxLength(150);
            entity.Property(e => e.PatientName).HasMaxLength(150);
            entity.Property(e => e.PatientPaidAmount).HasColumnType("decimal(10, 2)");
            entity.Property(e => e.PaymentMethod).HasMaxLength(150);
            entity.Property(e => e.PrimaryDxIcd10)
                .HasMaxLength(150)
                .HasColumnName("PrimaryDxICD10");
            entity.Property(e => e.PrimaryDxIcd9)
                .HasMaxLength(150)
                .HasColumnName("PrimaryDxICD9");
            entity.Property(e => e.ProviderProfile).HasMaxLength(150);
            entity.Property(e => e.TotalBilledAmount).HasColumnType("decimal(10, 2)");
            entity.Property(e => e.TotalPaidAmount).HasColumnType("decimal(10, 2)");
            entity.Property(e => e.TransactionCarrier).HasMaxLength(150);
            entity.Property(e => e.TransactionCode).HasMaxLength(150);
            entity.Property(e => e.TransactionCodeDesc).HasMaxLength(150);
            entity.Property(e => e.TransactionType).HasMaxLength(150);
            entity.Property(e => e.VisitNo).HasMaxLength(150);
            entity.Property(e => e.VisitPrimaryCarrier).HasMaxLength(150);
            entity.Property(e => e.VisitSecondaryCarrier).HasMaxLength(150);
            entity.Property(e => e.Void).HasMaxLength(150);
        });

        modelBuilder.Entity<VisitAgaistAccessionStaging>(entity =>
        {
            entity.HasKey(e => e.Vaaid).HasName("PK__VisitAga__3214EC07DAA9E39E");

            entity.ToTable("VisitAgaistAccessionStaging");

            entity.Property(e => e.AccessionNo).HasMaxLength(250);
            entity.Property(e => e.EntryDate).HasColumnType("datetime");
            entity.Property(e => e.ImportedOn)
                .HasDefaultValueSql("(getdate())")
                .HasColumnType("datetime");
            entity.Property(e => e.OfficeKey).HasMaxLength(250);
            entity.Property(e => e.ServiceDate).HasColumnType("datetime");
            entity.Property(e => e.VisitNumber).HasMaxLength(250);
            entity.Property(e => e.Void).HasMaxLength(50);
        });

        OnModelCreatingPartial(modelBuilder);
    }

    partial void OnModelCreatingPartial(ModelBuilder modelBuilder);
}
