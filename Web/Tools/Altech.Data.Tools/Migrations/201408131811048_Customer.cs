namespace Altech.DAL.Migrations
{
    using System;
    using System.Data.Entity.Migrations;
    
    public partial class Customer : DbMigration
    {
        public override void Up()
        {
            CreateTable(
                "dbo.Customers",
                c => new
                    {
                        ID = c.String(nullable: false, maxLength: 128),
                    })
                .PrimaryKey(t => t.ID);
            
            CreateTable(
                "dbo.Orders",
                c => new
                    {
                        ID = c.Int(nullable: false, identity: true),
                        Created = c.DateTime(nullable: false),
                        Completed = c.Boolean(nullable: false),
                        Customer_ID = c.String(maxLength: 128),
                    })
                .PrimaryKey(t => t.ID)
                .ForeignKey("dbo.Customers", t => t.Customer_ID)
                .Index(t => t.Customer_ID);
            
            CreateTable(
                "dbo.OrderDetails",
                c => new
                    {
                        ID = c.Int(nullable: false, identity: true),
                        OrderID = c.Int(nullable: false),
                        Cost = c.Double(nullable: false),
                        Quantity = c.Int(nullable: false),
                        Comment = c.String(),
                    })
                .PrimaryKey(t => t.ID)
                .ForeignKey("dbo.Orders", t => t.OrderID, cascadeDelete: true)
                .Index(t => t.OrderID);
            
            CreateTable(
                "dbo.Groups",
                c => new
                    {
                        ID = c.Int(nullable: false),
                        Title = c.String(),
                    })
                .PrimaryKey(t => t.ID);
            
            CreateTable(
                "dbo.Subgroups",
                c => new
                    {
                        ID = c.Int(nullable: false),
                        GroupID = c.Int(nullable: false),
                        Title = c.String(),
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
                        Title = c.String(),
                        UnitMeasure = c.String(),
                        Pack = c.Int(nullable: false),
                        Cost = c.Double(nullable: false),
                        ImageName = c.String(),
                    })
                .PrimaryKey(t => t.ID)
                .ForeignKey("dbo.Subgroups", t => t.SubgroupID, cascadeDelete: true)
                .Index(t => t.SubgroupID);
            
        }
        
        public override void Down()
        {
            DropForeignKey("dbo.Subgroups", "GroupID", "dbo.Groups");
            DropForeignKey("dbo.Merchandises", "SubgroupID", "dbo.Subgroups");
            DropForeignKey("dbo.Orders", "Customer_ID", "dbo.Customers");
            DropForeignKey("dbo.OrderDetails", "OrderID", "dbo.Orders");
            DropIndex("dbo.Merchandises", new[] { "SubgroupID" });
            DropIndex("dbo.Subgroups", new[] { "GroupID" });
            DropIndex("dbo.OrderDetails", new[] { "OrderID" });
            DropIndex("dbo.Orders", new[] { "Customer_ID" });
            DropTable("dbo.Merchandises");
            DropTable("dbo.Subgroups");
            DropTable("dbo.Groups");
            DropTable("dbo.OrderDetails");
            DropTable("dbo.Orders");
            DropTable("dbo.Customers");
        }
    }
}
