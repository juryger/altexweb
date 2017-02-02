using Altech.Core.Models;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Altech.Core.Interfaces
{
    public interface IOrderCostCalculation : IDisposable
    {
        void GetOrderCostWithDiscount(int orderId, out double cost, out double costDiscount);
        double GetMerchandisePriceWithDiscount(int orderId, int merchandiseId);
    }
}
