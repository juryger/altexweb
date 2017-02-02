namespace Altech.DAL.Migrations
{
    using System;
    using System.Data.Entity.Migrations;
    
    public partial class MerchandiseTitleMaxLength : DbMigration
    {
        public override void Up()
        {
            AlterColumn("dbo.Merchandises", "Title", c => c.String(maxLength: 100));
        }
        
        public override void Down()
        {
            AlterColumn("dbo.Merchandises", "Title", c => c.String());
        }
    }
}
