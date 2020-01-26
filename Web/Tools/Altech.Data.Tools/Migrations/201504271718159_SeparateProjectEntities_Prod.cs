namespace Altech.DAL.Migrations
{
    using System;
    using System.Data.Entity.Migrations;
    
    public partial class SeparateProjectEntities_Prod : DbMigration
    {
        public override void Up()
        {
            CreateTable(
                "dbo.Customers",
                c => new
                    {
                        ID = c.String(nullable: false, maxLength: 128),
                        Company = c.String(),
                        ContactName = c.String(),
                        PhoneNumber = c.String(),
                        EmailAddress = c.String(),
                        Address = c.String(),
                        INN = c.String(),
                    })
                .PrimaryKey(t => t.ID);
            
            CreateTable(
                "dbo.Orders",
                c => new
                    {
                        ID = c.Int(nullable: false, identity: true),
                        CustomerID = c.String(maxLength: 128),
                        Created = c.DateTime(nullable: false),
                        Completed = c.Boolean(nullable: false),
                        Comment = c.String(maxLength: 100),
                    })
                .PrimaryKey(t => t.ID)
                .ForeignKey("dbo.Customers", t => t.CustomerID)
                .Index(t => t.CustomerID);
            
            CreateTable(
                "dbo.OrderDetails",
                c => new
                    {
                        ID = c.Int(nullable: false, identity: true),
                        OrderID = c.Int(nullable: false),
                        GoodsID = c.Int(nullable: false),
                        Quantity = c.Int(nullable: false),
                        Comment = c.String(maxLength: 100),
                    })
                .PrimaryKey(t => t.ID)
                .ForeignKey("dbo.Orders", t => t.OrderID, cascadeDelete: true)
                .Index(t => t.OrderID);
            
            CreateTable(
                "dbo.Discounts",
                c => new
                    {
                        ID = c.Int(nullable: false),
                        StartSumm = c.Double(nullable: false),
                        IsDeleted = c.Boolean(nullable: false),
                    })
                .PrimaryKey(t => t.ID);
            
            CreateTable(
                "dbo.Groups",
                c => new
                    {
                        ID = c.Int(nullable: false),
                        Title = c.String(),
                        IsDeleted = c.Boolean(nullable: false),
                    })
                .PrimaryKey(t => t.ID);
            
            CreateTable(
                "dbo.Subgroups",
                c => new
                    {
                        ID = c.Int(nullable: false),
                        GroupID = c.Int(nullable: false),
                        Title = c.String(),
                        IsDeleted = c.Boolean(nullable: false),
                    })
                .PrimaryKey(t => t.ID)
                .ForeignKey("dbo.Groups", t => t.GroupID, cascadeDelete: true)
                .Index(t => t.GroupID);
            
            CreateTable(
                "dbo.Merchandises",
                c => new
                    {
                        ID = c.Int(nullable: false),
                        SubgroupID = c.Int(nullable: false),
                        Title = c.String(maxLength: 100),
                        UnitMeasure = c.String(),
                        Pack = c.Int(nullable: false),
                        PackMin = c.Int(nullable: false),
                        CostWhs1 = c.Double(nullable: false),
                        CostWhs2 = c.Double(nullable: false),
                        CostWhs3 = c.Double(nullable: false),
                        ImageName = c.String(),
                        IsDeleted = c.Boolean(nullable: false),
                    })
                .PrimaryKey(t => t.ID)
                .ForeignKey("dbo.Subgroups", t => t.SubgroupID, cascadeDelete: true)
                .Index(t => t.SubgroupID);
            
        }
        
        public override void Down()
        {
            DropForeignKey("dbo.Merchandises", "SubgroupID", "dbo.Subgroups");
            DropForeignKey("dbo.Subgroups", "GroupID", "dbo.Groups");
            DropForeignKey("dbo.OrderDetails", "OrderID", "dbo.Orders");
            DropForeignKey("dbo.Orders", "CustomerID", "dbo.Customers");
            DropIndex("dbo.Merchandises", new[] { "SubgroupID" });
            DropIndex("dbo.Subgroups", new[] { "GroupID" });
            DropIndex("dbo.OrderDetails", new[] { "OrderID" });
            DropIndex("dbo.Orders", new[] { "CustomerID" });
            DropTable("dbo.Merchandises");
            DropTable("dbo.Subgroups");
            DropTable("dbo.Groups");
            DropTable("dbo.Discounts");
            DropTable("dbo.OrderDetails");
            DropTable("dbo.Orders");
            DropTable("dbo.Customers");
        }
    }
}
