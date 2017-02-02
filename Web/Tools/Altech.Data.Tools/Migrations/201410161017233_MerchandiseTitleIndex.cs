namespace Altech.DAL.Migrations
{
    using System;
    using System.Data.Entity.Migrations;
    
    public partial class MerchandiseTitleIndex : DbMigration
    {
        public override void Up()
        {
            CreateIndex("dbo.Merchandises", "Title");
        }
        
        public override void Down()
        {
            DropIndex("dbo.Merchandises", new[] { "Title" });
        }
    }
}
