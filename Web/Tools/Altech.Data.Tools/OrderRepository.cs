using Altech.Core.Interfaces;
using Altech.Core.Models;
using Altech.DAL.Consts;
using Altech.DAL.Interfaces;
using Altech.DAL.Utilities;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Altech.DAL
{
    internal sealed class OrderRepository: IOrderRepository
    {
        #region Fields

        private bool disposed;
        private IDbGeneralContext db;
        private INewOrderNotifier newOrderNotifier;
        private IOrderCostCalculation orderCostCalculation;

        #endregion

        #region Properties

        public INewOrderNotifier NewOrderNotifier
        {
            set { this.newOrderNotifier = value; }
        }

        public IOrderCostCalculation OrderCostCalculation
        {
            set { this.orderCostCalculation = value; }
        }

        public IDbGeneralContext Db
        {
            set
            {
                if (value != null)
                    this.db = value;
            }
        }

        #endregion

        #region Ctr & dstr
        
        public OrderRepository()
        {
            this.db = new AltechContext();
        }

        public void Dispose()
        {
            if (this.disposed)
                return;

            this.db.Dispose();

            this.db = null;
            this.newOrderNotifier = null;
            this.orderCostCalculation = null;

            this.disposed = true;
        }
        
        #endregion
        
        #region Public operations

        public string GetDiscountsInfo()
        {
            return DiscountsInfo.GetDescription(this.db.Discounts);
        }

        public int GetActiveOrderId(string customerId)
        {
            if (String.IsNullOrWhiteSpace(customerId))
                throw new ArgumentNullException("customerId");

            // Выбрать первый незавершенный заказ
            var activeOrder = this.db.Orders.FirstOrDefault(o => String.Compare(o.CustomerID, customerId, true) == 0 && !o.Completed);

            return activeOrder != null ? activeOrder.ID : -1;
        }

        public Customer GetCustomer(string customerId)
        {
            return this.db.Customers.SingleOrDefault<Customer>(c => String.Compare(c.ID, customerId, true) == 0);
        }

        public IEnumerable<OrderDetail> GetActiveOrderItems(int orderId)
        {
            var order = this.db.Orders.FirstOrDefault(o => o.ID == orderId);
            if (order == null || order.Completed)
                return new List<OrderDetail>();

            return this.db.OrderDetails.Where(od => od.OrderID == orderId);
        }

        public IEnumerable<Merchandise> GetActiveOrderMerchandises(int orderId)
        {
            var order = this.db.Orders.FirstOrDefault(o => o.ID == orderId);
            if (order == null || order.Completed)
                return new List<Merchandise>();

            var mIdList = db.OrderDetails.Where(od => od.OrderID == orderId).Select(od => od.GoodsID);
            if (mIdList == null || !mIdList.Any())
                return new List<Merchandise>();

            return (from m in db.Merchandises where mIdList.Contains(m.ID) select m).ToList();
        }

        public IEnumerable<Merchandise> Search(int orderId, string searchText)
        {
            if (String.IsNullOrEmpty(searchText))
                throw new ArgumentNullException("searchText");

            var order = this.db.Orders.FirstOrDefault(o => o.ID == orderId);
            if (order == null || order.Completed)
                return new List<Merchandise>();

            int id = 0;
            Int32.TryParse(searchText, out id);

            return db.Merchandises.Where(m => m.ID == id || m.Title.ToUpper().Contains(searchText.ToUpper())).ToList();
        }

        public void CalculateOrderOverallCost(int orderId, out double cost, out double costDiscount)
        {
            cost = 0;
            costDiscount = 0;

            var order = this.db.Orders.FirstOrDefault(o => o.ID == orderId);
            if (order == null || order.Completed)
                return;

            var orderDetails = db.OrderDetails.Where(od => od.OrderID == orderId);
            if (orderDetails == null || !orderDetails.Any())
                return;

            this.orderCostCalculation.GetOrderCostWithDiscount(orderId, out cost, out costDiscount);
        }

        public string AddMerchandiseToOrder(string customerId, int merchandiseId, int amount, string comment)
        {
            #region Input parameters check

            if (String.IsNullOrWhiteSpace(customerId))
                throw new ArgumentNullException("customerId");
            if (merchandiseId <= 0)
                throw new ArgumentOutOfRangeException("merchandiseId");
            if (amount <= 0)
                throw new ArgumentOutOfRangeException("amount");

            #endregion

            // Проверка что клиент зарегистрирован в БД
            RegisterCustomer(customerId);

            // Проверка наличия открытого заказа (при отсутствии создание нового)
            var orderId = GetActiveOrCreateNewOrder(customerId);

            // Добавление товара в заказ (обновление при наличии)
            var responseText = UpdateOrderItem(orderId, merchandiseId, amount, comment);

            // Фикасация изменений в БД 
            db.SaveChanges();

            return responseText;
        }

        public string UpdateMerchandiseInOrder(string customerId, int merchandiseId, int amount, string comment)
        {
            #region Input parameters check

            if (String.IsNullOrWhiteSpace(customerId))
                throw new ArgumentNullException("customerId");
            if (merchandiseId <= 0)
                throw new ArgumentOutOfRangeException("merchandiseId");
            if (amount <= 0)
                throw new ArgumentOutOfRangeException("amount");

            #endregion

            // Проверка что клиент зарегистрирован в БД
            RegisterCustomer(customerId);

            // Проверка наличия открытого заказа
            var orderId = GetActiveOrderId(customerId);

            // если открытого заказа нет, необходимо сообщить об ошибке
            if (orderId <= 0)
                throw new ApplicationException(String.Format(ExceptionNames.NoActiveOrder, customerId));

            // Проверка что позиция уже имеется в заказе
            var orderDetail = db.OrderDetails.FirstOrDefault(od => od.OrderID == orderId && od.GoodsID == merchandiseId);
            if (orderDetail == null)
                throw new ApplicationException(String.Format(ExceptionNames.NoMerchandiseById, merchandiseId));

            // замещение количества товара в заказе новым значением
            orderDetail.Quantity = amount;
            orderDetail.Comment = comment;
            
            // Фикасация изменений в БД 
            db.SaveChanges();

            double sum, sumDiscount;
            CalculateOrderOverallCost(orderId, out sum, out sumDiscount);

            return String.Format("Заказ успешно обновлен. sum={0};{1}", sum, sumDiscount);
        }

        public string DeleteMerchandiseFromOrder(string customerId, int merchandiseId)
        {
            #region Input variables check

            if (String.IsNullOrWhiteSpace(customerId))
                throw new ArgumentNullException("customerId");
            if (merchandiseId <= 0)
                throw new ArgumentOutOfRangeException("merchandiseId");

            #endregion

            // Проверка наличия открытого заказа
            var orderId = GetActiveOrderId(customerId);

            // если открытого заказа нет, необходимо сообщить об ошибке
            if (orderId <= 0)
                throw new ApplicationException(String.Format(ExceptionNames.NoActiveOrder, customerId));

            // Удаление позиции из заказа
            var item = db.OrderDetails.SingleOrDefault(od => od.OrderID == orderId && od.GoodsID == merchandiseId);
            if (item == null)
                throw new ApplicationException(String.Format(ExceptionNames.NoMerchandiseById, merchandiseId));

            db.OrderDetails.Remove(item);
            db.SaveChanges();

            double sum = 0, sumDiscount = 0;
            CalculateOrderOverallCost(orderId, out sum, out sumDiscount);

            return String.Format("Товар удален из заказа. sum={0};{1}", sum, sumDiscount);
        }

        public void CancelActiveOrder(string customerId)
        {
            if (String.IsNullOrWhiteSpace(customerId))
                throw new ArgumentNullException("customerId");

            // Проверка наличия открытого заказа
            var orderId = GetActiveOrderId(customerId);

            // если открытого заказа нет, необходимо сообщить об ошибке
            if (orderId <= 0)
                throw new ApplicationException(String.Format(ExceptionNames.NoActiveOrder, customerId));

            // удаление открытого заказа из БД
            var order = this.db.Orders.Single(o => o.ID == orderId);
            this.db.Orders.Remove(order);

            this.db.SaveChanges();
        }

        public void ConfirmOrder(string customerId, string company, string contactName, string phoneNumber, string email, string address, string inn)
        {
            #region Required parameters check

            if (String.IsNullOrEmpty(company))
                throw new ArgumentNullException("company");
            if (String.IsNullOrEmpty(phoneNumber))
                throw new ArgumentNullException("phoneNumber");
            if (String.IsNullOrEmpty(email))
                throw new ArgumentNullException("email");

            #endregion

            // Проверка наличия клиента
            var customer = GetCustomer(customerId);
            if (customer == null)
                throw new ApplicationException(String.Format(ExceptionNames.NoCustomer, customerId));

            // Проверка наличия открытого заказа
            var orderId = GetActiveOrderId(customerId);
            if (orderId <= 0)
                throw new ApplicationException(String.Format(ExceptionNames.NoActiveOrder, customerId));

            customer.Company = company;
            customer.ContactName = contactName ?? String.Empty;
            customer.PhoneNumber = phoneNumber;
            customer.EmailAddress = email;
            customer.Address = address ?? String.Empty;
            customer.INN = inn ?? string.Empty;

            // Пометить заказ как завершенный
            var order = this.db.Orders.Single(o => o.ID == orderId);
            order.Completed = true;

            db.SaveChanges();

            // Отправить сообщение о новом заказе в очередь (для последующей обработки - рассылка писем)
            this.newOrderNotifier.Notify(orderId);
        }

        #endregion

        #region Private operations

        private string UpdateOrderItem(int orderId, int merchandiseId, int amount, string comment)
        {
            #region Input parameters check

            if (orderId <= 0)
                throw new ArgumentOutOfRangeException("orderId");

            if (merchandiseId <= 0)
                throw new ArgumentOutOfRangeException("merchandiseId");

            if (amount < 0)
                throw new ArgumentOutOfRangeException("amount");

            #endregion

            var result = String.Empty;

            // Проверка что позиция уже имеется в заказе
            var orderDetail = db.OrderDetails.SingleOrDefault<OrderDetail>(od => od.OrderID == orderId && od.GoodsID == merchandiseId);
            if (orderDetail != null)
            {
                // увеличение количества товара в заказе
                orderDetail.Quantity += amount;

                if (!String.IsNullOrWhiteSpace(comment))
                    orderDetail.Comment = comment;

                var merchandise = db.Merchandises.Single(m => m.ID == merchandiseId);

                result =
                    String.Format("Товар с артикулем '{0}' уже имеется в заказе. Обновленное количество данного товара составляет '{1}' {2}.",
                        merchandiseId, orderDetail.Quantity, merchandise.UnitMeasure);
            }
            else
            {
                // Товар отсутсвует в заказе, добавление новой позиции
                db.OrderDetails.Add(
                    new OrderDetail()
                    {
                        OrderID = orderId,
                        GoodsID = merchandiseId,
                        Quantity = amount,
                        Comment = comment
                    });

                result = String.Format("Товар с артикулем '{0}' успешно добавлен в заказ.", merchandiseId);
            }

            db.SaveChanges();
            return result;
        }

        private void RegisterCustomer(string customerId)
        {
            if (String.IsNullOrWhiteSpace(customerId))
                throw new ArgumentNullException("customerId");

            var customer = this.db.Customers.SingleOrDefault<Customer>(c => String.Compare(c.ID, customerId, true) == 0);
            if (customer == null)
            {
                // зарегистрировать клиента
                db.Customers.Add(new Customer() { ID = customerId });
                db.SaveChanges();
            }
        }

        private int GetActiveOrCreateNewOrder(string customerId)
        {
            /* NOTE: В текущей реализации поддерживается только один активный заказ на клиента */

            if (String.IsNullOrWhiteSpace(customerId))
                throw new ArgumentNullException("customerId");

            // Проверить наличие активного заказа
            var orderId = GetActiveOrderId(customerId);            

            if (orderId > 0)
                return orderId;

            // Если открытого заказа нет, необходимо его создать
            var newOrder = db.Orders.Add(new Order { CustomerID = customerId, Created = DateTime.Now, Completed = false });
            db.SaveChanges();

            return newOrder.ID;
        }

        #endregion
    }
}
