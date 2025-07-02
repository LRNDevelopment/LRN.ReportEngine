using LRN.DataLibrary.Models;
using LRN.ExcelToSqlETL.Core.Models;
using Microsoft.EntityFrameworkCore;
using System;
using System.Collections.Generic;

namespace LRN.DataLibrary;

public partial class LRNDbContext : DbContext
{
    public LRNDbContext()
    {
    }

    public LRNDbContext(DbContextOptions<LRNDbContext> options)
        : base(options)
    {
    }

    public virtual DbSet<BillingMaster> BillingMasters { get; set; }

    public virtual DbSet<BillingProviderMaster> BillingProviderMasters { get; set; }

    public virtual DbSet<ClaimBillingDetail> ClaimBillingDetails { get; set; }

    public virtual DbSet<ClaimsProdStatus> ClaimsProdStatuses { get; set; }

    public virtual DbSet<ClinicMaster> ClinicMasters { get; set; }

    public virtual DbSet<CptcodeMaster> CptcodeMasters { get; set; }

    public virtual DbSet<CustomCollectionStaging> CustomCollectionStagings { get; set; }

    public virtual DbSet<DenialTrackingMaster> DenialTrackingMasters { get; set; }

    public virtual DbSet<DenialTrackingStaging> DenialTrackingStagings { get; set; }

    public virtual DbSet<DownloadReportType> DownloadReportTypes { get; set; }

    public virtual DbSet<FileStatus> FileStatuses { get; set; }

    public virtual DbSet<IcdcodeMaster> IcdcodeMasters { get; set; }

    public virtual DbSet<ImportFilType> ImportFilTypes { get; set; }

    public virtual DbSet<ImportedFile> ImportedFiles { get; set; }

    public virtual DbSet<InsurancePayerMaster> InsurancePayerMasters { get; set; }

    public virtual DbSet<LabMaster> LabMasters { get; set; }

    public virtual DbSet<Lismaster> Lismasters { get; set; }

    public virtual DbSet<Lisstaging> Lisstagings { get; set; }

    public virtual DbSet<OperationsGroupMaster> OperationsGroupMasters { get; set; }

    public virtual DbSet<PanelGroup> PanelGroups { get; set; }

    public virtual DbSet<PayerTypeMaster> PayerTypeMasters { get; set; }

    public virtual DbSet<PrismBillingStaging> PrismBillingStagings { get; set; }

    public virtual DbSet<ProdStatusRuleEngine> ProdStatusRuleEngines { get; set; }

    public virtual DbSet<ReferringProviderMaster> ReferringProviderMasters { get; set; }

    public virtual DbSet<SalesPerson> SalesPeople { get; set; }

    public virtual DbSet<SampleFinalStatus> SampleFinalStatuses { get; set; }

    public virtual DbSet<SpecimenStatus> SpecimenStatuses { get; set; }

    public virtual DbSet<TestTypeMaster> TestTypeMasters { get; set; }

    public virtual DbSet<TransactionDetailStaging> TransactionDetailStagings { get; set; }

    public virtual DbSet<TransactionMaster> TransactionMasters { get; set; }

    public virtual DbSet<TransactionSummary> TransactionSummaries { get; set; }

    public virtual DbSet<VisitAgaistAccessionStaging> VisitAgaistAccessionStagings { get; set; }

    public DbSet<ProdBillingData> ProdData { get; set; } // Not a real table, just used for SP mapping

    public DbSet<LISMasterData> LabResults { get; set; } // Not a real table, just used for SP mapping

    public DbSet<ClaimDetailDto> ClaimDetailDto { get; set; } // Not a real table, just used for SP mapping

    public DbSet<CollectionData> CollectionData { get; set; } // Not a real table, just used for SP mapping
    protected override void OnConfiguring(DbContextOptionsBuilder optionsBuilder)
#warning To protect potentially sensitive information in your connection string, you should move it out of source code. You can avoid scaffolding the connection string by using the Name= syntax to read it from configuration - see https://go.microsoft.com/fwlink/?linkid=2131148. For more guidance on storing connection strings, see https://go.microsoft.com/fwlink/?LinkId=723263.
        => optionsBuilder.UseSqlServer("data source=Jameel;initial catalog=PrismLRN;trusted_connection=true;TrustServerCertificate=True;");

    protected override void OnModelCreating(ModelBuilder modelBuilder)
    {
        modelBuilder.Entity<ProdBillingData>().HasNoKey();

        modelBuilder.Entity<LISMasterData>().HasNoKey();

        modelBuilder.Entity<ClaimDetailDto>().HasNoKey();

        modelBuilder.Entity<CollectionData>().HasNoKey();

        modelBuilder.Entity<BillingMaster>(entity =>
        {
            entity.HasKey(e => e.BillingMasterId).HasName("PK__BillingM__4D6560C1F23F6975");

            entity.ToTable("BillingMaster");

            entity.HasIndex(e => new { e.VisitNumber, e.ChargeEntryDate, e.FirstBillDate, e.LismasterId, e.PrimaryPayerId, e.PayerTypeId, e.BillingProviderId, e.Modifier }, "IX_BillingMaster_VisitNumber");

            entity.HasIndex(e => new { e.VisitNumber, e.Cptcode, e.FirstBillDate, e.Units, e.Modifier, e.BilledAmount }, "UQ_BillingMaster_ACC").IsUnique();

            entity.Property(e => e.BillingMasterId).HasColumnName("BillingMasterID");
            entity.Property(e => e.AccessionNo)
                .HasMaxLength(50)
                .IsUnicode(false);
            entity.Property(e => e.AllowedAmount).HasColumnType("decimal(10, 2)");
            entity.Property(e => e.BeginDos).HasColumnName("BeginDOS");
            entity.Property(e => e.BilledAmount).HasColumnType("decimal(10, 2)");
            entity.Property(e => e.BillingFrequency).HasMaxLength(250);
            entity.Property(e => e.BillingProviderId).HasColumnName("BillingProviderID");
            entity.Property(e => e.ChargeEnteredBy).HasMaxLength(250);
            entity.Property(e => e.ChartNumber)
                .HasMaxLength(25)
                .IsUnicode(false);
            entity.Property(e => e.CheckNumber)
                .HasMaxLength(150)
                .IsUnicode(false);
            entity.Property(e => e.ClientAccNum).HasMaxLength(250);
            entity.Property(e => e.Cptcode)
                .HasMaxLength(25)
                .IsUnicode(false)
                .HasColumnName("CPTCode");
            entity.Property(e => e.CreatedOn)
                .HasDefaultValueSql("(getdate())")
                .HasColumnType("datetime");
            entity.Property(e => e.EndDos).HasColumnName("EndDOS");
            entity.Property(e => e.FinalClaimStatus)
                .HasMaxLength(50)
                .IsUnicode(false);
            entity.Property(e => e.Icd10code)
                .HasMaxLength(250)
                .HasColumnName("ICD10Code");
            entity.Property(e => e.InsuranceAdjustment).HasColumnType("decimal(10, 2)");
            entity.Property(e => e.InsuranceBalance).HasColumnType("decimal(10, 2)");
            entity.Property(e => e.InsurancePayment).HasColumnType("decimal(10, 2)");
            entity.Property(e => e.LismasterId).HasColumnName("LISMasterId");
            entity.Property(e => e.MemberId)
                .HasMaxLength(25)
                .IsUnicode(false)
                .HasColumnName("MemberID");
            entity.Property(e => e.Modifier)
                .HasMaxLength(50)
                .IsUnicode(false);
            entity.Property(e => e.PatientAdjustment).HasColumnType("decimal(10, 2)");
            entity.Property(e => e.PatientBalance).HasColumnType("decimal(10, 2)");
            entity.Property(e => e.PatientPaidAmount).HasColumnType("decimal(10, 2)");
            entity.Property(e => e.Pos)
                .HasMaxLength(250)
                .HasColumnName("POS");
            entity.Property(e => e.PrimaryPayerId).HasColumnName("PrimaryPayerID");
            entity.Property(e => e.Tos)
                .HasMaxLength(250)
                .HasColumnName("TOS");
            entity.Property(e => e.TotalBalance).HasColumnType("decimal(10, 2)");
            entity.Property(e => e.UpdatedOn)
                .HasDefaultValueSql("(getdate())")
                .HasColumnType("datetime");
            entity.Property(e => e.VisitNumber).HasMaxLength(250);

            entity.HasOne(d => d.BillingProvider).WithMany(p => p.BillingMasters)
                .HasForeignKey(d => d.BillingProviderId)
                .OnDelete(DeleteBehavior.ClientSetNull)
                .HasConstraintName("FK__BillingMa__Billi__2E11BAA1");

            entity.HasOne(d => d.Lismaster).WithMany(p => p.BillingMasters)
                .HasForeignKey(d => d.LismasterId)
                .HasConstraintName("FK__BillingMa__LISMa__32D66FBE");

            entity.HasOne(d => d.PayerType).WithMany(p => p.BillingMasters)
                .HasForeignKey(d => d.PayerTypeId)
                .HasConstraintName("FK__BillingMa__Payer__379B24DB");

            entity.HasOne(d => d.PrimaryPayer).WithMany(p => p.BillingMasters)
                .HasForeignKey(d => d.PrimaryPayerId)
                .HasConstraintName("FK__BillingMa__Prima__3C5FD9F8");
        });

        modelBuilder.Entity<BillingProviderMaster>(entity =>
        {
            entity.HasKey(e => e.BillingProviderId).HasName("PK__BillingP__CB08769B09F9495F");

            entity.ToTable("BillingProviderMaster");

            entity.HasIndex(e => e.BillingProvider, "IX_BillingProviderMaster_BillingProvider");

            entity.HasIndex(e => e.BillingProviderId, "IX_BillingProviderMaster_BillingProviderID");

            entity.HasIndex(e => e.BillingProvider, "IX_BillingProviderMaster_Name");

            entity.HasIndex(e => e.BillingProvider, "UQ__BillingP__D9A75BBA99EAECBF").IsUnique();

            entity.Property(e => e.BillingProviderId).HasColumnName("BillingProviderID");
            entity.Property(e => e.BillingProvider).HasMaxLength(500);
            entity.Property(e => e.CreatedOn)
                .HasDefaultValueSql("(getdate())")
                .HasColumnType("datetime");
            entity.Property(e => e.IsActive).HasDefaultValue(true);
        });

        modelBuilder.Entity<ClaimBillingDetail>(entity =>
        {
            entity.HasKey(e => e.BillingDetailId).HasName("PK__ClaimBil__77F5CCC484805559");

            entity.Property(e => e.BillingDetailId).HasColumnName("BillingDetailID");
            entity.Property(e => e.AccessionNo)
                .HasMaxLength(25)
                .IsUnicode(false);
            entity.Property(e => e.AllowedAmount)
                .HasDefaultValue(0.0m)
                .HasColumnType("decimal(18, 2)");
            entity.Property(e => e.BilledAmount)
                .HasDefaultValue(0.0m)
                .HasColumnType("decimal(18, 2)");
            entity.Property(e => e.Cptcode)
                .HasMaxLength(25)
                .IsUnicode(false)
                .HasColumnName("CPTCode");
            entity.Property(e => e.CreatedOn)
                .HasDefaultValueSql("(getdate())")
                .HasColumnType("datetime");
            entity.Property(e => e.InsuranceAdjustmentAmount)
                .HasDefaultValue(0.0m)
                .HasColumnType("decimal(18, 2)");
            entity.Property(e => e.InsuranceBalance)
                .HasDefaultValue(0.0m)
                .HasColumnType("decimal(18, 2)");
            entity.Property(e => e.InsurancePaidAmount)
                .HasDefaultValue(0.0m)
                .HasColumnType("decimal(18, 2)");
            entity.Property(e => e.PatientAdjustmentAmount)
                .HasDefaultValue(0.0m)
                .HasColumnType("decimal(18, 2)");
            entity.Property(e => e.PatientBalance)
                .HasDefaultValue(0.0m)
                .HasColumnType("decimal(18, 2)");
            entity.Property(e => e.PatientPaidAmount)
                .HasDefaultValue(0.0m)
                .HasColumnType("decimal(18, 2)");
            entity.Property(e => e.TotalBalance)
                .HasDefaultValue(0.0m)
                .HasColumnType("decimal(18, 2)");
            entity.Property(e => e.VisitNumber)
                .HasMaxLength(25)
                .IsUnicode(false);
        });

        modelBuilder.Entity<ClaimsProdStatus>(entity =>
        {
            entity
                .HasNoKey()
                .ToTable("ClaimsProdStatus");

            entity.Property(e => e.ClaimSubStatus).HasMaxLength(500);
            entity.Property(e => e.Cptcode)
                .HasMaxLength(20)
                .IsUnicode(false)
                .HasColumnName("CPTCode");
            entity.Property(e => e.CreatedOn)
                .HasDefaultValueSql("(getdate())")
                .HasColumnType("datetime");
            entity.Property(e => e.DenialCode).HasMaxLength(50);
            entity.Property(e => e.FinalStatus).HasMaxLength(50);
        });

        modelBuilder.Entity<ClinicMaster>(entity =>
        {
            entity.HasKey(e => e.ClinicId).HasName("PK__ClinicMa__3347C2DDF2A4949E");

            entity.ToTable("ClinicMaster");

            entity.HasIndex(e => e.ClinicName, "IX_ClinicMaster_Name");

            entity.HasIndex(e => e.ClinicName, "UQ__ClinicMa__A6FA56918E55D7B8").IsUnique();

            entity.Property(e => e.ClinicName).HasMaxLength(500);
            entity.Property(e => e.ClinicStatus).HasDefaultValue(true);
            entity.Property(e => e.CreatedOn)
                .HasDefaultValueSql("(getdate())")
                .HasColumnType("datetime");
        });

        modelBuilder.Entity<CptcodeMaster>(entity =>
        {
            entity.HasKey(e => e.CptcodeId).HasName("PK__CPTCodeM__E8517A8032449589");

            entity.ToTable("CPTCodeMaster");

            entity.Property(e => e.CptcodeId).HasColumnName("CPTCodeID");
            entity.Property(e => e.CodeDescription).HasMaxLength(500);
            entity.Property(e => e.Cptcode)
                .HasMaxLength(20)
                .IsUnicode(false)
                .HasColumnName("CPTCode");
            entity.Property(e => e.CreatedOn)
                .HasDefaultValueSql("(getdate())")
                .HasColumnType("datetime");
            entity.Property(e => e.IsActive).HasDefaultValue(true);
            entity.Property(e => e.OriginalCode).HasMaxLength(500);
        });

        modelBuilder.Entity<CustomCollectionStaging>(entity =>
        {
            entity.HasKey(e => e.Ccwid).HasName("PK__CustomCo__A0D17AB1AEBEB393");

            entity.ToTable("CustomCollectionStaging");

            entity.HasIndex(e => new { e.VisitNumber, e.BilledCptcode, e.LastBillDate, e.ChargeEntryDate, e.PayerName, e.PayerType, e.BillingProvider, e.MemberId, e.ClientAccNum, e.BeginDos, e.EndDos, e.BillingFrequency, e.ChargeEnteredBy, e.Pos, e.Tos, e.Modifier, e.Icd10code }, "IX_CustomCollectionData_Grouping");

            entity.HasIndex(e => e.BillingProvider, "IX_CustomCollectionStaging_BillingProvider");

            entity.HasIndex(e => e.VisitNumber, "IX_CustomCollectionStaging_ClaimID");

            entity.HasIndex(e => e.ImportedFileId, "IX_CustomCollectionStaging_ImportedFileID");

            entity.HasIndex(e => e.PerformingLab, "IX_CustomCollectionStaging_PerformingLab");

            entity.HasIndex(e => e.ReferringProvider, "IX_CustomCollectionStaging_ReferringProvider");

            entity.HasIndex(e => e.VisitNumber, "IX_CustomCollectionStaging_VisitNumber");

            entity.Property(e => e.Ccwid).HasColumnName("CCWId");
            entity.Property(e => e.AccessionNo).HasMaxLength(500);
            entity.Property(e => e.AllowedAmount).HasColumnType("decimal(10, 2)");
            entity.Property(e => e.BeginDos).HasColumnName("BeginDOS");
            entity.Property(e => e.BilledAmount).HasColumnType("decimal(10, 2)");
            entity.Property(e => e.BilledCptcode)
                .HasMaxLength(500)
                .HasColumnName("BilledCPTCode");
            entity.Property(e => e.BillingFrequency).HasMaxLength(500);
            entity.Property(e => e.BillingProvider).HasMaxLength(500);
            entity.Property(e => e.ChargeEnteredBy).HasMaxLength(500);
            entity.Property(e => e.ClientAccNum).HasMaxLength(500);
            entity.Property(e => e.Dob).HasColumnName("DOB");
            entity.Property(e => e.EndDos).HasColumnName("EndDOS");
            entity.Property(e => e.Icd10code)
                .HasMaxLength(500)
                .HasColumnName("ICD10Code");
            entity.Property(e => e.ImportedFileId).HasColumnName("ImportedFileID");
            entity.Property(e => e.ImpotedOn)
                .HasDefaultValueSql("(getdate())")
                .HasColumnType("datetime");
            entity.Property(e => e.InsuranceAdjustments).HasColumnType("decimal(10, 2)");
            entity.Property(e => e.InsuranceBalance).HasColumnType("decimal(10, 2)");
            entity.Property(e => e.InsurancePayments).HasColumnType("decimal(10, 2)");
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

        modelBuilder.Entity<DenialTrackingMaster>(entity =>
        {
            entity.HasKey(e => e.DenailTrackId).HasName("PK__DenialTr__0E1933581FF7BCC1");

            entity.ToTable("DenialTrackingMaster");

            entity.HasIndex(e => e.VisitNumber, "IX_DenialTrackingMaster_VisitNumber");

            entity.Property(e => e.DenailTrackId).HasColumnName("DenailTrackID");
            entity.Property(e => e.ChargeAmount).HasColumnType("decimal(18, 2)");
            entity.Property(e => e.Cptcodes)
                .HasMaxLength(25)
                .IsUnicode(false)
                .HasColumnName("CPTCodes");
            entity.Property(e => e.CreateOn)
                .HasDefaultValueSql("(getdate())")
                .HasColumnType("datetime");
            entity.Property(e => e.DenailUser)
                .HasMaxLength(50)
                .IsUnicode(false);
            entity.Property(e => e.DenialCategoryCode)
                .HasMaxLength(50)
                .IsUnicode(false);
            entity.Property(e => e.DenialCategoryDescription)
                .HasMaxLength(250)
                .IsUnicode(false)
                .HasColumnName("DenialCategoryDEscription");
            entity.Property(e => e.LastAction)
                .HasMaxLength(50)
                .IsUnicode(false);
            entity.Property(e => e.LismasterId).HasColumnName("LISMasterID");
            entity.Property(e => e.NextAction)
                .HasMaxLength(50)
                .IsUnicode(false);
            entity.Property(e => e.Note)
                .HasMaxLength(250)
                .IsUnicode(false);
            entity.Property(e => e.PaymentReasonCode)
                .HasMaxLength(50)
                .IsUnicode(false);
            entity.Property(e => e.ReasonAmount).HasColumnType("decimal(18, 2)");
            entity.Property(e => e.TotalAdjustment).HasColumnType("decimal(18, 2)");
            entity.Property(e => e.TotalBalance).HasColumnType("decimal(18, 2)");
            entity.Property(e => e.TransactionCarrierCode)
                .HasMaxLength(50)
                .IsUnicode(false);
            entity.Property(e => e.UpdatedOn)
                .HasDefaultValueSql("(getdate())")
                .HasColumnType("datetime");
            entity.Property(e => e.VisitNumber)
                .HasMaxLength(50)
                .IsUnicode(false);
        });

        modelBuilder.Entity<DenialTrackingStaging>(entity =>
        {
            entity
                .HasNoKey()
                .ToTable("DenialTrackingStaging");

            entity.Property(e => e.Charge).HasColumnType("decimal(18, 2)");
            entity.Property(e => e.ChargeCode).HasMaxLength(500);
            entity.Property(e => e.DenialCategoryCode).HasMaxLength(500);
            entity.Property(e => e.DenialCategoryDescription).HasMaxLength(500);
            entity.Property(e => e.DenialUser).HasMaxLength(500);
            entity.Property(e => e.FinancialClass).HasMaxLength(500);
            entity.Property(e => e.ImportedFileId).HasColumnName("ImportedFileID");
            entity.Property(e => e.ImportedOn)
                .HasDefaultValueSql("(getdate())")
                .HasColumnType("datetime");
            entity.Property(e => e.LastAction).HasMaxLength(500);
            entity.Property(e => e.NextAction).HasMaxLength(500);
            entity.Property(e => e.Note).HasMaxLength(500);
            entity.Property(e => e.PatientName).HasMaxLength(500);
            entity.Property(e => e.PaymentReasonCode).HasMaxLength(500);
            entity.Property(e => e.PaymentReasonDescription).HasMaxLength(500);
            entity.Property(e => e.Provider).HasMaxLength(500);
            entity.Property(e => e.ReasonAmount).HasColumnType("decimal(18, 2)");
            entity.Property(e => e.TotalAdjustment).HasColumnType("decimal(18, 2)");
            entity.Property(e => e.TotalBalance).HasColumnType("decimal(18, 2)");
            entity.Property(e => e.TransactionCarrierCode).HasMaxLength(500);
            entity.Property(e => e.VisitNumber).HasMaxLength(500);
        });

        modelBuilder.Entity<DownloadReportType>(entity =>
        {
            entity.HasKey(e => e.ReportTypeId).HasName("PK__Download__78CF8CE3DA7DDB8B");

            entity.HasIndex(e => e.ReportName, "UQ__Download__930D5CE77131F912").IsUnique();

            entity.Property(e => e.ReportTypeId).ValueGeneratedNever();
            entity.Property(e => e.IsActive).HasDefaultValue(true);
            entity.Property(e => e.ReportName)
                .HasMaxLength(50)
                .IsUnicode(false);
        });

        modelBuilder.Entity<FileStatus>(entity =>
        {
            entity.HasKey(e => e.FileStatusId).HasName("PK__FileStat__1F998CA979E02A25");

            entity.HasIndex(e => e.FileStatus1, "UQ__FileStat__26A5E152CC3F125B").IsUnique();

            entity.Property(e => e.FileStatusId).ValueGeneratedNever();
            entity.Property(e => e.FileStatus1)
                .HasMaxLength(30)
                .IsUnicode(false)
                .HasColumnName("FileStatus");
        });

        modelBuilder.Entity<IcdcodeMaster>(entity =>
        {
            entity.HasKey(e => e.IcdcodeId).HasName("PK__ICDCodeM__3145FF4EBAF39980");

            entity.ToTable("ICDCodeMaster");

            entity.HasIndex(e => e.Icd10code, "UQ__ICDCodeM__1712921F81EADCA1").IsUnique();

            entity.Property(e => e.IcdcodeId).HasColumnName("ICDCodeID");
            entity.Property(e => e.CodeDescription).HasMaxLength(500);
            entity.Property(e => e.CreatedOn)
                .HasDefaultValueSql("(getdate())")
                .HasColumnType("datetime");
            entity.Property(e => e.Icd10code)
                .HasMaxLength(500)
                .HasColumnName("ICD10Code");
            entity.Property(e => e.IsActive).HasDefaultValue(true);
            entity.Property(e => e.OriginalCode).HasMaxLength(500);
        });

        modelBuilder.Entity<ImportFilType>(entity =>
        {
            entity.HasKey(e => e.FileTypeId).HasName("PK__ImportFi__0896759E441CB9CC");

            entity.HasIndex(e => e.FileTypeName, "UQ__ImportFi__2A63AD84D2FAAFC0").IsUnique();

            entity.Property(e => e.FileTypeId).ValueGeneratedNever();
            entity.Property(e => e.FileTypeName)
                .HasMaxLength(50)
                .IsUnicode(false);
            entity.Property(e => e.IsActive).HasDefaultValue(true);
        });

        modelBuilder.Entity<ImportedFile>(entity =>
        {
            entity.HasKey(e => e.ImportedFileId).HasName("PK__Imported__0000074947B7CF78");

            entity.Property(e => e.ImportedFileId).HasColumnName("ImportedFileID");
            entity.Property(e => e.ImportFileName).HasMaxLength(500);
            entity.Property(e => e.ImportedOn)
                .HasDefaultValueSql("(getdate())")
                .HasColumnType("datetime");
            entity.Property(e => e.LabId).HasDefaultValue(3);
            entity.Property(e => e.ProcessedOn).HasColumnType("datetime");
        });

        modelBuilder.Entity<InsurancePayerMaster>(entity =>
        {
            entity.HasKey(e => e.InsurancePayerId).HasName("PK__Insuranc__10CDEBF726C1BCF6");

            entity.ToTable("InsurancePayerMaster");

            entity.HasIndex(e => e.InsurancePayerId, "IX_InsurancePayerMaster_InsurancePayerId");

            entity.HasIndex(e => e.PayerName, "IX_InsurancePayerMaster_PayerName");

            entity.HasIndex(e => e.PayerName, "UQ__Insuranc__F1989D97E7262137").IsUnique();

            entity.Property(e => e.CreatedOn)
                .HasDefaultValueSql("(getdate())")
                .HasColumnType("datetime");
            entity.Property(e => e.IsActive).HasDefaultValue(true);
            entity.Property(e => e.PayerName).HasMaxLength(500);
        });

        modelBuilder.Entity<LabMaster>(entity =>
        {
            entity.HasKey(e => e.LabId).HasName("PK__LabMaste__EDBD773A0C0B6A27");

            entity.ToTable("LabMaster");

            entity.HasIndex(e => e.LabName, "IX_LabMaster_Name");

            entity.HasIndex(e => e.LabName, "UQ__LabMaste__63D5613042B128D5").IsUnique();

            entity.Property(e => e.LabId).HasColumnName("LabID");
            entity.Property(e => e.CreatedOn)
                .HasDefaultValueSql("(getdate())")
                .HasColumnType("datetime");
            entity.Property(e => e.IsActive).HasDefaultValue(true);
            entity.Property(e => e.LabName).HasMaxLength(500);
        });

        modelBuilder.Entity<Lismaster>(entity =>
        {
            entity.HasKey(e => e.LismasterId).HasName("PK__LISMaste__0E87FAE76AB07069");

            entity.ToTable("LISMaster");

            entity.HasIndex(e => new { e.LismasterId, e.PanelId, e.ReferringProviderId, e.LabId }, "IX_LISMaster_LISMasterId");

            entity.HasIndex(e => e.VisitNumber, "IX_LISMaster_VisitNumber");

            entity.HasIndex(e => new { e.AccessionNo, e.LabId }, "UQ_LISMaster_ACC").IsUnique();

            entity.HasIndex(e => e.AccessionNo, "UQ__LISMaste__B4B23BD77C30ACE2").IsUnique();

            entity.Property(e => e.LismasterId).HasColumnName("LISMasterId");
            entity.Property(e => e.AccessionNo).HasMaxLength(150);
            entity.Property(e => e.AccountPay)
                .HasMaxLength(100)
                .IsUnicode(false);
            entity.Property(e => e.Actions)
                .HasMaxLength(200)
                .IsUnicode(false);
            entity.Property(e => e.Analtyics)
                .HasMaxLength(100)
                .IsUnicode(false);
            entity.Property(e => e.BilledTo)
                .HasMaxLength(250)
                .IsUnicode(false);
            entity.Property(e => e.BillingProviderId).HasColumnName("BillingProviderID");
            entity.Property(e => e.BillingStatus)
                .HasMaxLength(50)
                .IsUnicode(false);
            entity.Property(e => e.BillingSubStatus)
                .HasMaxLength(50)
                .IsUnicode(false);
            entity.Property(e => e.ClientStatus).HasMaxLength(250);
            entity.Property(e => e.ContractPay)
                .HasMaxLength(100)
                .IsUnicode(false);
            entity.Property(e => e.CreatedBy)
                .HasMaxLength(20)
                .IsUnicode(false)
                .HasDefaultValue("SYSTEM");
            entity.Property(e => e.CreatedOn)
                .HasDefaultValueSql("(getdate())")
                .HasColumnType("datetime");
            entity.Property(e => e.Icd10code)
                .HasMaxLength(250)
                .HasColumnName("ICD10Code");
            entity.Property(e => e.OrderInfo).HasMaxLength(500);
            entity.Property(e => e.PanelCode).HasMaxLength(250);
            entity.Property(e => e.PanelName).HasMaxLength(250);
            entity.Property(e => e.PatientDob)
                .HasMaxLength(250)
                .HasColumnName("PatientDOB");
            entity.Property(e => e.PatientId)
                .HasMaxLength(250)
                .HasColumnName("PatientID");
            entity.Property(e => e.PatientName).HasMaxLength(250);
            entity.Property(e => e.PrimaryGroupNo)
                .HasMaxLength(250)
                .IsUnicode(false);
            entity.Property(e => e.PrimaryMemberId)
                .HasMaxLength(250)
                .IsUnicode(false);
            entity.Property(e => e.PrimaryPayerName)
                .HasMaxLength(250)
                .IsUnicode(false);
            entity.Property(e => e.RelationshipToInsurance).HasMaxLength(250);
            entity.Property(e => e.ResponsibleParty).HasMaxLength(250);
            entity.Property(e => e.ResultedStatus)
                .HasMaxLength(100)
                .IsUnicode(false);
            entity.Property(e => e.ScrubSettings)
                .HasMaxLength(500)
                .IsUnicode(false);
            entity.Property(e => e.SecondaryGroupNo)
                .HasMaxLength(250)
                .IsUnicode(false);
            entity.Property(e => e.SecondaryMemberId)
                .HasMaxLength(250)
                .IsUnicode(false)
                .HasColumnName("SecondaryMemberID");
            entity.Property(e => e.SelfPay)
                .HasMaxLength(100)
                .IsUnicode(false);
            entity.Property(e => e.Sendouts).HasMaxLength(250);
            entity.Property(e => e.SpecimenType)
                .HasMaxLength(200)
                .IsUnicode(false);
            entity.Property(e => e.TestCode).HasMaxLength(250);
            entity.Property(e => e.VisitNumber)
                .HasMaxLength(100)
                .IsUnicode(false);

            entity.HasOne(d => d.BillingProvider).WithMany(p => p.Lismasters)
                .HasForeignKey(d => d.BillingProviderId)
                .HasConstraintName("FK__LISMaster__Billi__004AEFF1");

            entity.HasOne(d => d.Clinic).WithMany(p => p.Lismasters)
                .HasForeignKey(d => d.ClinicId)
                .HasConstraintName("FK__LISMaster__Clini__03275C9C");

            entity.HasOne(d => d.Lab).WithMany(p => p.Lismasters)
                .HasForeignKey(d => d.LabId)
                .HasConstraintName("FK__LISMaster__LabId__07EC11B9");

            entity.HasOne(d => d.OperationalGroup).WithMany(p => p.Lismasters)
                .HasForeignKey(d => d.OperationalGroupId)
                .HasConstraintName("FK__LISMaster__Opera__0CB0C6D6");

            entity.HasOne(d => d.Panel).WithMany(p => p.Lismasters)
                .HasForeignKey(d => d.PanelId)
                .HasConstraintName("FK__LISMaster__Panel__11757BF3");

            entity.HasOne(d => d.PayerType).WithMany(p => p.Lismasters)
                .HasForeignKey(d => d.PayerTypeId)
                .HasConstraintName("FK__LISMaster__Payer__163A3110");

            entity.HasOne(d => d.ReferringProvider).WithMany(p => p.Lismasters)
                .HasForeignKey(d => d.ReferringProviderId)
                .HasConstraintName("FK__LISMaster__Refer__1AFEE62D");

            entity.HasOne(d => d.SampleStatus).WithMany(p => p.Lismasters)
                .HasForeignKey(d => d.SampleStatusId)
                .HasConstraintName("FK__LISMaster__Sampl__1FC39B4A");

            entity.HasOne(d => d.TestType).WithMany(p => p.Lismasters)
                .HasForeignKey(d => d.TestTypeId)
                .HasConstraintName("FK__LISMaster__TestT__24885067");
        });

        modelBuilder.Entity<Lisstaging>(entity =>
        {
            entity.HasKey(e => e.LisstagingId).HasName("PK__LISStagi__B4312D054FF75456");

            entity.ToTable("LISStaging");

            entity.HasIndex(e => e.AccessionNo, "IX_LISStaging_AccessionNo");

            entity.HasIndex(e => e.ClinicName, "IX_LISStaging_ClinicName");

            entity.HasIndex(e => e.OperationsGroup, "IX_LISStaging_OperationsGroup");

            entity.HasIndex(e => e.AccessionNo, "IX_LISStaging_OrderInfo");

            entity.HasIndex(e => e.SpecimenStatus, "IX_LISStaging_SpecimenStatus");

            entity.HasIndex(e => e.TestType, "IX_LISStaging_TestType");

            entity.Property(e => e.LisstagingId).HasColumnName("LISStagingId");
            entity.Property(e => e.AccessionNo).HasMaxLength(500);
            entity.Property(e => e.AccountPay).HasMaxLength(500);
            entity.Property(e => e.Actions).HasMaxLength(500);
            entity.Property(e => e.Analtyics).HasMaxLength(500);
            entity.Property(e => e.ClinicName).HasMaxLength(500);
            entity.Property(e => e.ContractPay).HasMaxLength(500);
            entity.Property(e => e.ImportedFileId).HasColumnName("ImportedFileID");
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
            entity.Property(e => e.Reference).HasMaxLength(500);
            entity.Property(e => e.RelToInsured).HasMaxLength(500);
            entity.Property(e => e.SalesRep).HasMaxLength(500);
            entity.Property(e => e.ScrubSettings).HasMaxLength(500);
            entity.Property(e => e.SelfPay).HasMaxLength(500);
            entity.Property(e => e.SpecimenStatus).HasMaxLength(500);
            entity.Property(e => e.TestType).HasMaxLength(500);
            entity.Property(e => e.Turnaround).HasMaxLength(50);
        });

        modelBuilder.Entity<OperationsGroupMaster>(entity =>
        {
            entity.HasKey(e => e.OperationGroupId).HasName("PK__Operatio__238426D1458D022E");

            entity.ToTable("OperationsGroupMaster");

            entity.HasIndex(e => e.OperationsGroup, "IX_OperationsGroupMaster_Name");

            entity.HasIndex(e => e.OperationsGroup, "UQ__Operatio__50488EDA877469A5").IsUnique();

            entity.Property(e => e.OperationGroupId).HasColumnName("OperationGroupID");
            entity.Property(e => e.CreatedOn)
                .HasDefaultValueSql("(getdate())")
                .HasColumnType("datetime");
            entity.Property(e => e.IsActive).HasDefaultValue(true);
            entity.Property(e => e.OperationsGroup).HasMaxLength(500);
        });

        modelBuilder.Entity<PanelGroup>(entity =>
        {
            entity.HasKey(e => e.PanelGroupId).HasName("PK__PanelGro__E6B1A9B94AE36347");

            entity.ToTable("PanelGroup");

            entity.HasIndex(e => e.OrderInfo, "IX_PanelGroup_OrderInfo");

            entity.HasIndex(e => e.PanelGroupId, "IX_PanelGroup_PanelGroupId");

            entity.Property(e => e.CreatedOn)
                .HasDefaultValueSql("(getdate())")
                .HasColumnType("datetime");
            entity.Property(e => e.IsActive).HasDefaultValue(true);
            entity.Property(e => e.OrderInfo)
                .HasMaxLength(1000)
                .IsUnicode(false);
            entity.Property(e => e.PanelName)
                .HasMaxLength(250)
                .IsUnicode(false);
        });

        modelBuilder.Entity<PayerTypeMaster>(entity =>
        {
            entity.HasKey(e => e.PayerTypeId).HasName("PK__PayerTyp__E34E46DC72306FB6");

            entity.ToTable("PayerTypeMaster");

            entity.HasIndex(e => e.PayerType, "IX_PayerTypeMaster_Name");

            entity.HasIndex(e => e.PayerType, "IX_PayerTypeMaster_PayerType");

            entity.HasIndex(e => e.PayerTypeId, "IX_PayerTypeMaster_PayerTypeId");

            entity.HasIndex(e => e.PayerType, "UQ__PayerTyp__04488EE037972016").IsUnique();

            entity.Property(e => e.CreatedOn)
                .HasDefaultValueSql("(getdate())")
                .HasColumnType("datetime");
            entity.Property(e => e.IsActive).HasDefaultValue(true);
            entity.Property(e => e.PayerType).HasMaxLength(500);
        });

        modelBuilder.Entity<PrismBillingStaging>(entity =>
        {
            entity
                .HasNoKey()
                .ToTable("PrismBillingStaging");

            entity.HasIndex(e => e.SpecimenId, "IX_PrismBillingStaging_SpecimenID");

            entity.Property(e => e.Customer).HasMaxLength(1500);
            entity.Property(e => e.ImportedFileId).HasColumnName("ImportedFileID");
            entity.Property(e => e.ImportedOn)
                .HasDefaultValueSql("(getdate())")
                .HasColumnType("datetime");
            entity.Property(e => e.Lab)
                .HasMaxLength(250)
                .IsUnicode(false)
                .HasColumnName("LAB");
            entity.Property(e => e.Meds)
                .HasMaxLength(2500)
                .HasColumnName("MEDS");
            entity.Property(e => e.Notes).HasMaxLength(2500);
            entity.Property(e => e.Paid).HasColumnType("decimal(8, 2)");
            entity.Property(e => e.Payments)
                .HasMaxLength(250)
                .IsUnicode(false);
            entity.Property(e => e.SheetName)
                .HasMaxLength(250)
                .IsUnicode(false);
            entity.Property(e => e.SpecimenId)
                .HasMaxLength(250)
                .IsUnicode(false)
                .HasColumnName("SpecimenID");
            entity.Property(e => e.TestInfo).HasMaxLength(2500);
        });

        modelBuilder.Entity<ProdStatusRuleEngine>(entity =>
        {
            entity.HasKey(e => e.RuleId).HasName("PK__ProdStat__110458C26026BCA9");

            entity.ToTable("ProdStatusRuleEngine");

            entity.HasIndex(e => new { e.ResultedDateCondition, e.BilledDateCondition, e.TotalChargeCondition, e.TotalAllowedCondition, e.CarrierPaymentCondition, e.CarrierWoCondition, e.PatientPaymentCondition, e.PatientWoCondition, e.CarrierBalanceCondition, e.PatientBalanceCondition, e.TotalBalanceCondition, e.DenialCodeCondition }, "UQ_RuleEngine_Conditions").IsUnique();

            entity.Property(e => e.RuleId).HasColumnName("RuleID");
            entity.Property(e => e.BilledDateCondition)
                .HasMaxLength(50)
                .HasColumnName("Billed_Date_Condition");
            entity.Property(e => e.CarrierBalanceCondition)
                .HasMaxLength(50)
                .HasColumnName("CarrierBalance_Condition");
            entity.Property(e => e.CarrierPaymentCondition)
                .HasMaxLength(50)
                .HasColumnName("CarrierPayment_Condition");
            entity.Property(e => e.CarrierWoCondition)
                .HasMaxLength(50)
                .HasColumnName("CarrierWO_Condition");
            entity.Property(e => e.DenialCodeCondition)
                .HasMaxLength(50)
                .HasColumnName("Denial_Code_Condition");
            entity.Property(e => e.FinalOutputStatus)
                .HasMaxLength(100)
                .HasColumnName("Final_Output_Status");
            entity.Property(e => e.PatientBalanceCondition)
                .HasMaxLength(50)
                .HasColumnName("PatientBalance_Condition");
            entity.Property(e => e.PatientPaymentCondition)
                .HasMaxLength(50)
                .HasColumnName("PatientPayment_Condition");
            entity.Property(e => e.PatientWoCondition)
                .HasMaxLength(50)
                .HasColumnName("PatientWO_Condition");
            entity.Property(e => e.ResultedDateCondition)
                .HasMaxLength(50)
                .HasColumnName("Resulted_Date_Condition");
            entity.Property(e => e.TotalAllowedCondition)
                .HasMaxLength(50)
                .HasColumnName("TotalAllowed_Condition");
            entity.Property(e => e.TotalBalanceCondition)
                .HasMaxLength(50)
                .HasColumnName("TotalBalance_Condition");
            entity.Property(e => e.TotalChargeCondition)
                .HasMaxLength(50)
                .HasColumnName("TotalCharge_Condition");
        });

        modelBuilder.Entity<ReferringProviderMaster>(entity =>
        {
            entity.HasKey(e => e.ReferingProviderId).HasName("PK__Referrin__2A5C69B5086E186B");

            entity.ToTable("ReferringProviderMaster");

            entity.HasIndex(e => e.ReferringProviderName, "IX_ReferringProviderMaster_Name");

            entity.HasIndex(e => e.ReferingProviderId, "IX_ReferringProviderMaster_ReferingProviderId");

            entity.HasIndex(e => e.ReferringProviderName, "UQ__Referrin__08359E04D954DAD8").IsUnique();

            entity.Property(e => e.CreatedOn)
                .HasDefaultValueSql("(getdate())")
                .HasColumnType("datetime");
            entity.Property(e => e.IsActive).HasDefaultValue(true);
            entity.Property(e => e.ReferringProviderName).HasMaxLength(500);
        });

        modelBuilder.Entity<SalesPerson>(entity =>
        {
            entity.HasKey(e => e.SalesPersonId).HasName("PK__SalesPer__7A591C18ED657D35");

            entity.ToTable("SalesPerson");

            entity.HasIndex(e => e.SalesPersonName, "UQ__SalesPer__AB543E2031B8FD45").IsUnique();

            entity.Property(e => e.SalesPersonId).HasColumnName("SalesPersonID");
            entity.Property(e => e.CreatedDate)
                .HasDefaultValueSql("(getdate())")
                .HasColumnType("datetime");
            entity.Property(e => e.FirstName).HasMaxLength(200);
            entity.Property(e => e.LastName).HasMaxLength(200);
            entity.Property(e => e.SalesPersonName).HasMaxLength(250);
        });

        modelBuilder.Entity<SampleFinalStatus>(entity =>
        {
            entity.HasKey(e => new { e.VisitNumber, e.FinalStatus });

            entity.ToTable("SampleFinalStatus");

            entity.Property(e => e.VisitNumber)
                .HasMaxLength(20)
                .IsUnicode(false);
            entity.Property(e => e.FinalStatus)
                .HasMaxLength(50)
                .IsUnicode(false);
            entity.Property(e => e.ClaimSubStatus)
                .HasMaxLength(250)
                .IsUnicode(false);
        });

        modelBuilder.Entity<SpecimenStatus>(entity =>
        {
            entity.HasKey(e => e.SpecimenStatusId).HasName("PK__Specimen__58A06263038CB44C");

            entity.ToTable("SpecimenStatus");

            entity.HasIndex(e => e.SpecimenStatusName, "IX_SpecimenStatus_Name");

            entity.HasIndex(e => e.SpecimenStatusName, "UQ__Specimen__E60BFA8A292DA923").IsUnique();

            entity.Property(e => e.CreatedOn)
                .HasDefaultValueSql("(getdate())")
                .HasColumnType("datetime");
            entity.Property(e => e.IsActive).HasDefaultValue(true);
            entity.Property(e => e.SpecimenStatusName).HasMaxLength(500);
        });

        modelBuilder.Entity<TestTypeMaster>(entity =>
        {
            entity.HasKey(e => e.TestTypeId).HasName("PK__TestType__9BB876A6D6495ED4");

            entity.ToTable("TestTypeMaster");

            entity.HasIndex(e => e.TestTypeName, "IX_TestTypeMaster_Name");

            entity.HasIndex(e => e.TestTypeName, "UQ__TestType__662362AA8E438A7C").IsUnique();

            entity.Property(e => e.CreatedOn)
                .HasDefaultValueSql("(getdate())")
                .HasColumnType("datetime");
            entity.Property(e => e.IsActive).HasDefaultValue(true);
            entity.Property(e => e.TestTypeName).HasMaxLength(500);
        });

        modelBuilder.Entity<TransactionDetailStaging>(entity =>
        {
            entity.HasKey(e => e.TransactionDetailId).HasName("PK__Transact__F2B27FC653DFAB82");

            entity.ToTable("TransactionDetailStaging");

            entity.Property(e => e.AdjustmentAmount).HasColumnType("decimal(10, 2)");
            entity.Property(e => e.ChargeCode).HasMaxLength(150);
            entity.Property(e => e.ChartNumber).HasMaxLength(150);
            entity.Property(e => e.CheckNumber).HasMaxLength(150);
            entity.Property(e => e.FacilityName).HasMaxLength(150);
            entity.Property(e => e.FinancialClass).HasMaxLength(150);
            entity.Property(e => e.ImportedFileId).HasColumnName("ImportedFileID");
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

        modelBuilder.Entity<TransactionMaster>(entity =>
        {
            entity
                .HasNoKey()
                .ToTable("TransactionMaster");

            entity.HasIndex(e => e.VisitNo, "IX_TransactionMaster_VisitNo");

            entity.HasIndex(e => new { e.VisitNo, e.Cptcode }, "IX_TransactionMaster_VisitNo_CPTCode");

            entity.Property(e => e.AdjustmentAmount).HasColumnType("decimal(18, 2)");
            entity.Property(e => e.ChartNumber)
                .HasMaxLength(50)
                .IsUnicode(false);
            entity.Property(e => e.CheckNumber)
                .HasMaxLength(50)
                .IsUnicode(false);
            entity.Property(e => e.Cptcode)
                .HasMaxLength(50)
                .IsUnicode(false)
                .HasColumnName("CPTCode");
            entity.Property(e => e.CreatedOn)
                .HasDefaultValueSql("(getdate())")
                .HasColumnType("datetime");
            entity.Property(e => e.InsurancePaidAmount).HasColumnType("decimal(18, 2)");
            entity.Property(e => e.LismasterId).HasColumnName("LISMasterID");
            entity.Property(e => e.Modifiers)
                .HasMaxLength(50)
                .IsUnicode(false);
            entity.Property(e => e.PatientPaidAmount).HasColumnType("decimal(18, 2)");
            entity.Property(e => e.PaymentMethod)
                .HasMaxLength(50)
                .IsUnicode(false);
            entity.Property(e => e.PrimaryDxIcd10)
                .HasMaxLength(100)
                .IsUnicode(false)
                .HasColumnName("PrimaryDxICD10");
            entity.Property(e => e.PrimaryDxIcd9)
                .HasMaxLength(50)
                .IsUnicode(false)
                .HasColumnName("PrimaryDxICD9");
            entity.Property(e => e.TotalBilledAmount).HasColumnType("decimal(18, 2)");
            entity.Property(e => e.TotalPaidAmount).HasColumnType("decimal(18, 2)");
            entity.Property(e => e.TransactionCarrier)
                .HasMaxLength(50)
                .IsUnicode(false);
            entity.Property(e => e.TransactionCodeDesc)
                .HasMaxLength(250)
                .IsUnicode(false);
            entity.Property(e => e.TransactionDetailId)
                .ValueGeneratedOnAdd()
                .HasColumnName("TransactionDetailID");
            entity.Property(e => e.TransactionType)
                .HasMaxLength(50)
                .IsUnicode(false);
            entity.Property(e => e.UpdatedOn).HasColumnType("datetime");
            entity.Property(e => e.VisitNo)
                .HasMaxLength(50)
                .IsUnicode(false);
            entity.Property(e => e.VisitPrimaryCarrier)
                .HasMaxLength(50)
                .IsUnicode(false);
            entity.Property(e => e.VisitSecondaryCarrier)
                .HasMaxLength(50)
                .IsUnicode(false);
            entity.Property(e => e.Void)
                .HasMaxLength(50)
                .IsUnicode(false);
        });

        modelBuilder.Entity<TransactionSummary>(entity =>
        {
            entity
                .HasNoKey()
                .ToTable("TransactionSummary");

            entity.Property(e => e.AdjustmentAmount).HasColumnType("decimal(18, 2)");
            entity.Property(e => e.CheckNumber)
                .HasMaxLength(50)
                .IsUnicode(false);
            entity.Property(e => e.Cptcode)
                .HasMaxLength(25)
                .IsUnicode(false)
                .HasColumnName("CPTCode");
            entity.Property(e => e.CreatedOn)
                .HasDefaultValueSql("(getdate())")
                .HasColumnType("datetime");
            entity.Property(e => e.InsurancePaidAmount).HasColumnType("decimal(18, 2)");
            entity.Property(e => e.PatientPaidAmount).HasColumnType("decimal(18, 2)");
            entity.Property(e => e.TotalBilledAmount).HasColumnType("decimal(18, 2)");
            entity.Property(e => e.TotalPaidAmount).HasColumnType("decimal(18, 2)");
            entity.Property(e => e.TransactionType)
                .HasMaxLength(30)
                .IsUnicode(false);
        });

        modelBuilder.Entity<VisitAgaistAccessionStaging>(entity =>
        {
            entity.HasKey(e => e.Vaaid).HasName("PK__VisitAga__8A17DE035DBB7EE7");

            entity.ToTable("VisitAgaistAccessionStaging");

            entity.HasIndex(e => e.AccessionNo, "IX_VisitAgaistAccessionStaging_AccessionNo");

            entity.Property(e => e.Vaaid).HasColumnName("VAAId");
            entity.Property(e => e.AccessionNo).HasMaxLength(250);
            entity.Property(e => e.ImportedFileId).HasColumnName("ImportedFileID");
            entity.Property(e => e.ImportedOn)
                .HasDefaultValueSql("(getdate())")
                .HasColumnType("datetime");
            entity.Property(e => e.OfficeKey).HasMaxLength(250);
            entity.Property(e => e.VisitNumber).HasMaxLength(250);
            entity.Property(e => e.Void).HasMaxLength(50);
        });

        OnModelCreatingPartial(modelBuilder);
    }

    partial void OnModelCreatingPartial(ModelBuilder modelBuilder);
}
