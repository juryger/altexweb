namespace Altech.DAL.Migrations
{
    using System;
    using System.Data.Entity.Migrations;
    
    public partial class CommulativeChanges : DbMigration
    {
        public override void Up()
        {
            DropColumn("dbo.Merchandises", "Cost");
            DropColumn("dbo.Merchandises", "CostDiscount");
        }
        
        public override void Down()
        {
            AddColumn("dbo.Merchandises", "Cost", c => c.Double(nullable: false));
            AddColumn("dbo.Merchandises", "CostDiscount", c => c.Double(nullable: false));
        }
    }
}
