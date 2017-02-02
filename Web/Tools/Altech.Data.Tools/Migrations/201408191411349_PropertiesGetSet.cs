namespace Altech.DAL.Migrations
{
    using System;
    using System.Data.Entity.Migrations;
    
    public partial class PropertiesGetSet : DbMigration
    {
        public override void Up()
        {
            AddColumn("dbo.Customers", "Company", c => c.String());
            AddColumn("dbo.Customers", "ContactName", c => c.String());
            AddColumn("dbo.Customers", "PhoneNumber", c => c.String());
            AddColumn("dbo.Customers", "EmailAddress", c => c.String());
            AddColumn("dbo.Customers", "Address", c => c.String());
            AddColumn("dbo.Customers", "INN", c => c.String());
            AddColumn("dbo.OrderDetails", "GoodsID", c => c.Int(nullable: false));
        }
        
        public override void Down()
        {
            DropColumn("dbo.OrderDetails", "GoodsID");
            DropColumn("dbo.Customers", "INN");
            DropColumn("dbo.Customers", "Address");
            DropColumn("dbo.Customers", "EmailAddress");
            DropColumn("dbo.Customers", "PhoneNumber");
            DropColumn("dbo.Customers", "ContactName");
            DropColumn("dbo.Customers", "Company");
        }
    }
}
