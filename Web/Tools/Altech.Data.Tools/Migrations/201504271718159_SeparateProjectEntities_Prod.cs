namespace Altech.DAL.Migrations
{
    using System;
    using System.Data.Entity.Migrations;
    
    public partial class SeparateProjectEntities_Prod : DbMigration
    {
        public override void Up()
        {
            DropIndex("dbo.Merchandises", new[] { "Title" });
        }

        public override void Down()
        {
            CreateIndex("dbo.Merchandises", "Title");
        }
    }
}
