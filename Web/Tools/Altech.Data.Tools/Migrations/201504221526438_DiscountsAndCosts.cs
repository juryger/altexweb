namespace Altech.DAL.Migrations
{
    using System;
    using System.Data.Entity.Migrations;
    
    public partial class DiscountsAndCosts : DbMigration
    {
        public override void Up()
        {
            CreateTable(
                "dbo.Discounts",
                c => new
                {
                    ID = c.Int(nullable: false),
                    StartSumm = c.Double(nullable: false),
                })
                .PrimaryKey(t => t.ID);
        }
        
        public override void Down()
        {
            DropTable("dbo.Discounts");
        }
    }
}
