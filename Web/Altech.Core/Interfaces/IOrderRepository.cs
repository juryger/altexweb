using Altech.Core.Models;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Altech.Core.Interfaces
{
    public interface IOrderRepository: IDisposable
    {
        ///
        /// Propeties 
        INewOrderNotifier NewOrderNotifier { set; }
        IOrderCostCalculation OrderCostCalculation { set; }

        ///
        /// Methods
        int GetActiveOrderId(string customerId);
        string GetDiscountsInfo();
        Customer GetCustomer(string customerId);
        IEnumerable<OrderDetail> GetActiveOrderItems(int orderId);
        IEnumerable<Merchandise> GetActiveOrderMerchandises(int orderId);
        IEnumerable<Merchandise> Search(int orderId, string searchText);
        void CalculateOrderOverallCost(int orderId, out double cost, out double costDiscount);
        string AddMerchandiseToOrder(string customerId, int merchandiseId, int amount, string comment);
        string UpdateMerchandiseInOrder(string customerId, int merchandiseId, int amount, string comment);
        string DeleteMerchandiseFromOrder(string customerId, int merchandiseId);
        void CancelActiveOrder(string customerId);
        void ConfirmOrder(string customerId, string company, string contactName, string phoneNumber, string email, string address, string inn);
    }
}
