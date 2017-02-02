using Altech.Core.Models;
using System;
using System.Collections.Generic;
using System.Data.Entity;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Altech.DAL.Interfaces
{
    public interface IDbGeneralContext: IDisposable
    {
        IDbSet<Discount> Discounts { get; set; }
        IDbSet<Group> Groups { get; set; }
        IDbSet<Subgroup> Subgroups { get; set; }
        IDbSet<Merchandise> Merchandises { get; set; }
        IDbSet<Customer> Customers { get; set; }
        IDbSet<Order> Orders { get; set; }
        IDbSet<OrderDetail> OrderDetails { get; set; }

        int SaveChanges();
    }
}
