using LRN.DataLibrary.Models;
using LRN.ExcelToSqlETL.Core.Models;
using Microsoft.EntityFrameworkCore;

namespace LRN.DataLibrary;

public partial class LRNDbContext : DbContext
{
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
    public virtual DbSet<ImportFileLog> ImportFileLogs { get; set; }
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
    public virtual DbSet<Vaamaster> Vaamasters { get; set; }
    public virtual DbSet<VisitAgaistAccessionStaging> VisitAgaistAccessionStagings { get; set; }

    // Not real tables (SP/result mappings)
    public DbSet<ProdBillingData> ProdData { get; set; }
    public DbSet<LISMasterData> LabResults { get; set; }
    public DbSet<ClaimDetailDto> ClaimDetailDto { get; set; }
    public DbSet<CollectionData> CollectionData { get; set; }

    // IMPORTANT: keep the context DI-configured by the host app.
    // Do not hardcode any provider/connection here.
    protected override void OnConfiguring(DbContextOptionsBuilder optionsBuilder)
    {
        if (!optionsBuilder.IsConfigured)
        {
            // Intentionally left blank.
            // The host (web app) must configure the provider/connection via AddDbContext.
        }
    }

    protected override void OnModelCreating(ModelBuilder modelBuilder)
    {
        modelBuilder.Entity<ProdBillingData>().HasNoKey();
        modelBuilder.Entity<LISMasterData>().HasNoKey();
        modelBuilder.Entity<ClaimDetailDto>().HasNoKey();
        modelBuilder.Entity<CollectionData>().HasNoKey();
            
        // ... all your existing entity configurations remain unchanged ...
        // (I left your full mapping content as-is)
        // ───────────────────────────────────────────────────────────────
        // BillingMaster, BillingProviderMaster, ClaimBillingDetail, etc.
        // ───────────────────────────────────────────────────────────────

        OnModelCreatingPartial(modelBuilder);
    }

    partial void OnModelCreatingPartial(ModelBuilder modelBuilder);
}
