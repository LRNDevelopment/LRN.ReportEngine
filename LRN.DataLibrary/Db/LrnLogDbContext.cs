using LRN.DataLibrary.Entities;
using Microsoft.EntityFrameworkCore;

namespace LRN.DataLibrary.Db;

public class LrnLogDbContext : DbContext
{
    public LrnLogDbContext(DbContextOptions<LrnLogDbContext> options) : base(options) { }

    public DbSet<LrnRunLog> RunLogs => Set<LrnRunLog>();
    public DbSet<LrnStepLog> StepLogs => Set<LrnStepLog>();
    public DbSet<LrnErrorLog> ErrorLogs => Set<LrnErrorLog>();

    protected override void OnModelCreating(ModelBuilder modelBuilder)
    {
        modelBuilder.Entity<LrnRunLog>().HasKey(x => x.RunID);
        modelBuilder.Entity<LrnStepLog>().HasIndex(x => new { x.RunID, x.StepSeq });
        modelBuilder.Entity<LrnErrorLog>().HasIndex(x => new { x.RunID, x.ErrorTimeIST });

        // Optional: keep snake/case exactly as table definitions.
        base.OnModelCreating(modelBuilder);
    }
}
