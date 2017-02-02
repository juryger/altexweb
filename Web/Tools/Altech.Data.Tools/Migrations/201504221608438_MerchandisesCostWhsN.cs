namespace Altech.DAL.Migrations
{
    using System;
    using System.Data.Entity.Migrations;
    
    public partial class MerchandisesCostWhsN : DbMigration
    {
        public override void Up()
        {
            AddColumn("dbo.Merchandises", "CostWhs1", c => c.Double(nullable: false));
            AddColumn("dbo.Merchandises", "CostWhs2", c => c.Double(nullable: false));
            AddColumn("dbo.Merchandises", "CostWhs3", c => c.Double(nullable: false));

            AddColumn("dbo.Orders", "Comment", c => c.String(maxLength: 100));
        }
        
        public override void Down()
        {
            DropColumn("dbo.Merchandises", "CostWhs1");
            DropColumn("dbo.Merchandises", "CostWhs2");
            DropColumn("dbo.Merchandises", "CostWhs3");

            DropColumn("dbo.Orders", "Comment");
        }
    }
}
