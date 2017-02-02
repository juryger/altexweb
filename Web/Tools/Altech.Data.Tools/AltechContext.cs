using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using Altech.Core.Models;
using System.Data.Entity;
using System.Data.Entity.ModelConfiguration.Conventions;
using Altech.DAL.Interfaces;

namespace Altech.DAL
{
    internal class AltechContext : DbContext, IDbGeneralContext
    {
        public AltechContext()
            : base("AltechConnection")
        {
        }

        public virtual IDbSet<Discount> Discounts { get; set; }
        public virtual IDbSet<Group> Groups { get; set; }
        public virtual IDbSet<Subgroup> Subgroups { get; set; }
        public virtual IDbSet<Merchandise> Merchandises { get; set; }
        public virtual IDbSet<Customer> Customers { get; set; }
        public virtual IDbSet<Order> Orders { get; set; }
        public virtual IDbSet<OrderDetail> OrderDetails { get; set; }

        public override int SaveChanges()
        {
            return base.SaveChanges();
        }
    }
}