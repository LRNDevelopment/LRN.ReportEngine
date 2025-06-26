//using Microsoft.EntityFrameworkCore;
//using System.Collections.Generic;
//using System.Reflection.Emit;

//public class PrismLrnContext : DbContext
//{
//    public PrismLrnContext(DbContextOptions<PrismLrnContext> options) : base(options) { }

//    public DbSet<BillingMaster> BillingMasters { get; set; }
//    public DbSet<BillingProviderMaster> BillingProviderMasters { get; set; }
//    public DbSet<ClinicMaster> ClinicMasters { get; set; }
//    public DbSet<CPTCodeMaster> CPTCodeMasters { get; set; }
//    public DbSet<CustomCollectionStaging> CustomCollectionStagings { get; set; }
//    public DbSet<DenialTrackingMaster> DenialTrackingMasters { get; set; }
//    public DbSet<DenialTrackingStaging> DenialTrackingStagings { get; set; }
//    public DbSet<ICDCodeMaster> ICDCodeMasters { get; set; }
//    public DbSet<ImportedFile> ImportedFiles { get; set; }
//    public DbSet<InsurancePayerMaster> InsurancePayerMasters { get; set; }
//    public DbSet<LabMaster> LabMasters { get; set; }
//    public DbSet<LISMaster> LISMasters { get; set; }
//    public DbSet<LISStaging> LISStagings { get; set; }
//    public DbSet<OperationsGroupMaster> OperationsGroupMasters { get; set; }
//    public DbSet<PanelGroup> PanelGroups { get; set; }
//    public DbSet<PayerTypeMaster> PayerTypeMasters { get; set; }
//    public DbSet<PrismBillingStaging> PrismBillingStagings { get; set; }
//    public DbSet<ReferringProviderMaster> ReferringProviderMasters { get; set; }
//    public DbSet<SalesPerson> SalesPersons { get; set; }
//    public DbSet<SpecimenStatus> SpecimenStatuses { get; set; }
//    public DbSet<TestTypeMaster> TestTypeMasters { get; set; }
//    public DbSet<TransactionDetailStaging> TransactionDetailStagings { get; set; }
//    public DbSet<TrasactionMaster> TrasactionMasters { get; set; }
//    public DbSet<VisitAgaistAccessionStaging> VisitAgaistAccessionStagings { get; set; }

//    protected override void OnModelCreating(ModelBuilder modelBuilder)
//    {
//        modelBuilder.Entity<BillingMaster>()
//            .HasKey(b => b.BillingMasterID);

//        modelBuilder.Entity<BillingProviderMaster>()
//            .HasKey(b => b.BillingProviderID);

//        modelBuilder.Entity<ClinicMaster>()
//            .HasKey(c => c.ClinicId);

//        // Define other keys, relationships, column types, etc.
//    }
//}//using Microsoft.EntityFrameworkCore;
//using System.Collections.Generic;
//using System.Reflection.Emit;

//public class PrismLrnContext : DbContext
//{
//    public PrismLrnContext(DbContextOptions<PrismLrnContext> options) : base(options) { }

//    public DbSet<BillingMaster> BillingMasters { get; set; }
//    public DbSet<BillingProviderMaster> BillingProviderMasters { get; set; }
//    public DbSet<ClinicMaster> ClinicMasters { get; set; }
//    public DbSet<CPTCodeMaster> CPTCodeMasters { get; set; }
//    public DbSet<CustomCollectionStaging> CustomCollectionStagings { get; set; }
//    public DbSet<DenialTrackingMaster> DenialTrackingMasters { get; set; }
//    public DbSet<DenialTrackingStaging> DenialTrackingStagings { get; set; }
//    public DbSet<ICDCodeMaster> ICDCodeMasters { get; set; }
//    public DbSet<ImportedFile> ImportedFiles { get; set; }
//    public DbSet<InsurancePayerMaster> InsurancePayerMasters { get; set; }
//    public DbSet<LabMaster> LabMasters { get; set; }
//    public DbSet<LISMaster> LISMasters { get; set; }
//    public DbSet<LISStaging> LISStagings { get; set; }
//    public DbSet<OperationsGroupMaster> OperationsGroupMasters { get; set; }
//    public DbSet<PanelGroup> PanelGroups { get; set; }
//    public DbSet<PayerTypeMaster> PayerTypeMasters { get; set; }
//    public DbSet<PrismBillingStaging> PrismBillingStagings { get; set; }
//    public DbSet<ReferringProviderMaster> ReferringProviderMasters { get; set; }
//    public DbSet<SalesPerson> SalesPersons { get; set; }
//    public DbSet<SpecimenStatus> SpecimenStatuses { get; set; }
//    public DbSet<TestTypeMaster> TestTypeMasters { get; set; }
//    public DbSet<TransactionDetailStaging> TransactionDetailStagings { get; set; }
//    public DbSet<TrasactionMaster> TrasactionMasters { get; set; }
//    public DbSet<VisitAgaistAccessionStaging> VisitAgaistAccessionStagings { get; set; }

//    protected override void OnModelCreating(ModelBuilder modelBuilder)
//    {
//        modelBuilder.Entity<BillingMaster>()
//            .HasKey(b => b.BillingMasterID);

//        modelBuilder.Entity<BillingProviderMaster>()
//            .HasKey(b => b.BillingProviderID);

//        modelBuilder.Entity<ClinicMaster>()
//            .HasKey(c => c.ClinicId);

//        // Define other keys, relationships, column types, etc.
//    }
//}
