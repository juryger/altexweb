namespace Altech.DAL.Migrations
{
    using System;
    using System.Data.Entity.Migrations;
    
    public partial class OrderCustomerId : DbMigration
    {
        public override void Up()
        {
            RenameColumn(table: "dbo.Orders", name: "Customer_ID", newName: "CustomerID");
            RenameIndex(table: "dbo.Orders", name: "IX_Customer_ID", newName: "IX_CustomerID");
        }
        
        public override void Down()
        {
            RenameIndex(table: "dbo.Orders", name: "IX_CustomerID", newName: "IX_Customer_ID");
            RenameColumn(table: "dbo.Orders", name: "CustomerID", newName: "Customer_ID");
        }
    }
}
