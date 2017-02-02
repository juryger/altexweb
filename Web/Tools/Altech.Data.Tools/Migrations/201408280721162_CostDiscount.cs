namespace Altech.DAL.Migrations
{
    using System;
    using System.Data.Entity.Migrations;
    
    public partial class CostDiscount : DbMigration
    {
        public override void Up()
        {
            AddColumn("dbo.Merchandises", "CostDiscount", c => c.Double(nullable: false));
            DropColumn("dbo.OrderDetails", "GoodsTitle");
        }
        
        public override void Down()
        {
            AddColumn("dbo.OrderDetails", "GoodsTitle", c => c.String());
            DropColumn("dbo.Merchandises", "CostDiscount");
        }
    }
}
