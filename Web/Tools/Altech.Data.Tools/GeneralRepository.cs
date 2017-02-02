using Altech.Core.Interfaces;
using Altech.Core.Models;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Data.Entity;
using System.Data.Entity.Migrations;

namespace Altech.DAL
{
    public class GeneralRepository : IGeneralRepository
    {
        private AltechContext db;

        public GeneralRepository()
        {
            this.db = new AltechContext();
        }

        public void AddOrUpdateGroup(Group g)
        {
            if (g == null)
                return;

            this.db.Groups.AddOrUpdate(p => p.ID, new Group[] { g });
        }

        public void AddOrUpdateSubgroup(Subgroup s)
        {
            if (s == null)
                return;

            this.db.Subgroups.AddOrUpdate(p => p.ID, new Subgroup[] { s });
        }

        public void AddOrUpdateMerchandise(Merchandise m)
        {
            if (m == null)
                return;

            this.db.Merchandises.AddOrUpdate(p => p.ID, new Merchandise[] { m });
        }

        public void AddOrUpdateDiscount(Discount d)
        {
            if (d == null)
                return;

            this.db.Discounts.AddOrUpdate(p => p.ID, new Discount[] { d });
        }

        public void DeleteGroup(int id)
        {
            var g = db.Groups.Find(id);
            if (g == null)
                return;

            this.db.Groups.Remove(g);
        }

        public void DeleteSubgroup(int id)
        {
            var s = db.Subgroups.Find(id);
            if (s == null)
                return;

            db.Subgroups.Remove(s);
        }

        public void DeleteMerchandise(int id)
        {
            // delete merchandise from DB
            var m = db.Merchandises.Find(id);
            if (m == null)
                return;

            db.Merchandises.Remove(m);          
        }

        public void DeleteDiscount(int id)
        {
            var d = db.Discounts.Find(id);
            if (d == null)
                return;

            this.db.Discounts.Remove(d);
        }

        public void Dispose()
        {
            this.db.Dispose();
        }
    }
}
