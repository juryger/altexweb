using Altech.Core.Interfaces;
using Altech.DAL.Interfaces;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Altech.DAL.Services
{
    /// <summary>
    /// Выполняет вычисление стоимости заказа с учетом скидки.
    /// </summary>
    internal class OrderCostCalculation : IOrderCostCalculation
    {
        private bool disposed;
        private IDbGeneralContext db;
        private Dictionary<int, int> orderDiscountMap  = new Dictionary<int, int>();

        #region Ctr & dstr

        public OrderCostCalculation()
        {
            this.db = new AltechContext();
        }

        public IDbGeneralContext Db
        {
            set
            {
                if (value != null)
                    this.db = value;
            }
        }

        public void Dispose()
        {
            if (this.disposed)
                return;
            
            this.db.Dispose();
            this.orderDiscountMap.Clear();

            this.orderDiscountMap = null;
            this.db = null;

            this.disposed = true;
        }

        #endregion

        /// <summary>
        /// Возвращает сумму заказа без учета возможной скидки.
        /// </summary>
        /// <param name="orderId">идентификатор заказа</param>
        /// <param name="cost">полная стоимость заказа</param>
        /// <param name="costDiscount">стоимость заказа с учетом скидки</param>
        public void GetOrderCostWithDiscount(int orderId, out double cost, out double costDiscount)
        {
            if (orderId <= 0)
                throw new ArgumentOutOfRangeException("orderId");

            cost = default(double);
            costDiscount = default(double);

            #region Расчет полной стоимости заказа

            var orderDetails = this.db.OrderDetails.Where(od => od.OrderID == orderId);

            var mIdList = orderDetails.Select(od => od.GoodsID);
            var merchandises = db.Merchandises.Where(m => mIdList.Contains(m.ID));

            var merchandiseOrder =
                orderDetails.Join(merchandises, od => od.GoodsID, g => g.ID, (od, g) => new
                {
                    ID = g.ID,
                    CostWhs1 = g.CostWhs1,
                    CostWhs2 = g.CostWhs2,
                    CostWhs3 = g.CostWhs3,
                    Quantity = od.Quantity
                });

            var sumCostWhs1 = merchandiseOrder.Sum(mo => mo.CostWhs1 * mo.Quantity);
            cost = sumCostWhs1;

            #endregion

            #region Расчет стоимости с учетом скидки

            var discountId = -1;
            var suitableDiscounts = this.db.Discounts.Where(d => d.StartSumm <= sumCostWhs1);
            if (suitableDiscounts != null && suitableDiscounts.Any())
            {
                discountId = suitableDiscounts.OrderByDescending(d => d.StartSumm).First().ID;

                if (!this.orderDiscountMap.ContainsKey(orderId))
                    this.orderDiscountMap.Add(orderId, discountId);
                else
                    this.orderDiscountMap[orderId] = discountId;
            }

            foreach (var mo in merchandiseOrder)
                costDiscount += MapDiscountToPrice(orderId, mo.ID, discountId) * mo.Quantity;

            #endregion
        }

        /// <summary>
        /// Возвращает стоимость товара с учетом скидки.
        /// </summary>
        /// <param name="orderId">идентификатор заказа</param>
        /// <param name="merchandiseId">идентификатор товара</param>
        /// <returns>стоимость товара</returns>
        public double GetMerchandisePriceWithDiscount(int orderId, int merchandiseId)
        {
            if (orderId <= 0)
                throw new ArgumentOutOfRangeException("orderId");
            if (merchandiseId <= 0)
                throw new ArgumentOutOfRangeException("merchandiseId");

            // Если для указанного заказа еще не был произведен рассчет возможной скидки, сделать это
            if (!this.orderDiscountMap.ContainsKey(orderId))
            {
                double sum, sumDiscount;
                GetOrderCostWithDiscount(orderId, out sum, out sumDiscount);
            }

            var discountId = this.orderDiscountMap[orderId];

            return MapDiscountToPrice(orderId, merchandiseId, discountId);
        }

        private double MapDiscountToPrice(int orderId, int merchandiseId, int discountId)
        {
            if (orderId <= 0)
                throw new ArgumentOutOfRangeException("orderId");
            if (merchandiseId <= 0)
                throw new ArgumentOutOfRangeException("merchandiseId");
            if (discountId <= 0)
                throw new ArgumentOutOfRangeException("discountId");

            double result = 0;
            var item = this.db.Merchandises.Single(m => m.ID == merchandiseId);

            switch (discountId)
            {
                case 1:
                    result = item.CostWhs1;
                    break;
                case 2:
                    result = item.CostWhs2;
                    break;
                case 3:
                    result = item.CostWhs3;
                    break;
                default:
                    throw new ApplicationException(String.Format("Для указанного заказ '{0}' используется неизвестный идентификатор скидки '{1}'.", orderId, discountId));
            }

            return result;
        }
    }
}
