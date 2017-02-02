using Altech.Core.Models;
using Altech.WebSite.Consts;
using Altech.WebSite.Models;
using Altech.WebSite.Tests.Mocks;
using NSubstitute;
using NUnit.Framework;
using System;
using System.Collections.Generic;
using System.Data.Entity;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using Altech.Core.Interfaces;
using Altech.DAL.Consts;
using Altech.DAL.Services;
using Altech.DAL.Interfaces;
using Altech.DAL;

namespace Altech.WebSite.Tests
{
    [TestFixture]
    public class OrderTest
    {
        EnumerableQuery<Discount> discounts = new EnumerableQuery<Discount>(new List<Discount>() 
            {
                new Discount { ID = 1, StartSumm = 0 },
                new Discount { ID = 2, StartSumm = 30000 },
                new Discount { ID = 3, StartSumm = 100000 }
            });

        [TestCase("9F8B3A4C-A2ED-4CD1-BD83-3739BCFBA5AA", 1, true)]
        [TestCase("00000000-0000-0000-0000-000000000000", -1, true)]
        [TestCase("70FCF05A-ACC2-4CEB-A5D0-C19B40D6533E", 5, true)]
        [TestCase("70FCF05A-ACC2-4CEB-A5D0-C19B40D6533E", 2, false)]
        public void OrderModel_GetActiveOrderId_Check(string customerId, int expectedOrderId, bool expected)
        {
            // Arrange
            var orderModel = PrepareTestOrderRepository();

            // Act
            var orderId = orderModel.GetActiveOrderId(customerId);

            // Assert
            if (expected)
                Assert.AreEqual(orderId, expectedOrderId);
            else
                Assert.AreNotEqual(orderId, expectedOrderId);
        }

        [TestCase(1, 4)]
        [TestCase(2, 0)]
        public void OrderModel_GetActiveOrderDetails_Check(int orderId, int num)
        {
            // Arrange
            var orderModel = PrepareTestOrderRepository();

            // Act
            var result = orderModel.GetActiveOrderItems(orderId);

            // Assert
            Assert.IsNotNull(result);
            Assert.AreEqual(result.Count(), num);
        }

        [TestCase(1, 4)]
        [TestCase(2, 0)]
        public void OrderModel_GetMerchandisesFromActiveOrder_Check(int orderId, int num)
        {
            // Arrange
            var orderModel = PrepareTestOrderRepository();

            // Act
            var result = orderModel.GetActiveOrderMerchandises(orderId);

            // Assert
            Assert.IsNotNull(result);
            Assert.AreEqual(result.Count(), num);
        }

        [TestCase(1, "1255", 1)]
        [TestCase(1, "1256", 0)]
        [TestCase(1, "полукруглый", 2)]
        [TestCase(1, "100", 2)]
        [TestCase(2, "петля", 0)]
        public void OrderModel_Search_Check(int orderId, string text, int num)
        {
            // Arrange
            var orderModel = PrepareTestOrderRepository();

            // Act
            var merchandises = orderModel.Search(orderId, text);

            // Assert
            Assert.AreEqual(merchandises.Count(), num);
        }

        [TestCase(1, 34903, 29059.5)]
        [TestCase(3, 300000, 200000)]
        [TestCase(5, 260, 260)]
        public void OrderModel_CalculateOrderOverallCost_Check(int orderId, double sum, double discount)
        {
            // Arrange
            var orderModel = PrepareTestOrderRepository();

            // Act
            double realSum = 0;
            double realSumDiscount = 0;
            orderModel.CalculateOrderOverallCost(orderId, out realSum, out realSumDiscount);

            // Assert
            Assert.AreNotEqual(0, realSum);
            Assert.AreNotEqual(0, realSumDiscount);
            Assert.AreEqual(sum, realSum);
            Assert.AreEqual(discount, realSumDiscount);
        }
       
        [Test]
        [Ignore]
        public void OrderModel_AddSameMerchandiseToOrder_Success()
        {
            // Arrange
            var orderModel = PrepareTestOrderRepository();

            // Act
            string customerId = "9F8B3A4C-A2ED-4CD1-BD83-3739BCFBA5AA";
            int merchandiseId = 465;
            int amount = 10;
            string comment = "только без брака";
            var response = orderModel.AddMerchandiseToOrder(customerId, merchandiseId, amount, comment);

            amount = 5;
            response = orderModel.AddMerchandiseToOrder(customerId, merchandiseId, amount, comment);

            // Assert
            Assert.AreEqual("Товар с артикулем '465' уже имеется в заказе. Обновленное количество данного товара составляет '15' шт.", response);
        }

        [Test]
        [Ignore]
        public void OrderModel_AddNewMerchandiseToNewOrder_Success()
        {
            // Arrange
            var orderModel = PrepareTestOrderRepository();

            // Act
            string customerId = "6F7FB446-6CAC-4F14-BC93-1AA3DFE945AF";
            int merchandiseId = 465;
            int amount = 10;
            string comment = "только без брака";
            var response = orderModel.AddMerchandiseToOrder(customerId, merchandiseId, amount, comment);

            // Assert
            Assert.AreEqual("Товар с артикулем '465' успешно добавлен в заказ.", response);
        }

        [Test]
        public void OrderModel_AddNewMerchandiseToOrder_Success()
        {
            // Arrange
            var orderModel = PrepareTestOrderRepository();

            // Act
            string customerId = "9F8B3A4C-A2ED-4CD1-BD83-3739BCFBA5AA";
            int merchandiseId = 465;
            int amount = 10;
            string comment = "только без брака";
            var response = orderModel.AddMerchandiseToOrder(customerId, merchandiseId, amount, comment);

            // Assert
            Assert.AreEqual("Товар с артикулем '465' успешно добавлен в заказ.", response);
        }

        [Test]
        public void OrderModel_UpdateMerchandiseInOrder_Success()
        {
            // Arrange
            var orderModel = PrepareTestOrderRepository();

            // Act
            string customerId = "9F8B3A4C-A2ED-4CD1-BD83-3739BCFBA5AA";
            int merchandiseId = 1255;
            int amount = 10;
            string comment = "";
            var response = orderModel.UpdateMerchandiseInOrder(customerId, merchandiseId, amount, comment);

            // Assert
            Assert.IsTrue(response.Contains("Заказ успешно обновлен."));
        }

        [Test]
        public void OrderModel_UpdateMerchandiseInOrder_UnknownMerchandise_Fail()
        {
            // Arrange
            var orderModel = PrepareTestOrderRepository();

            // Act
            string customerId = "9F8B3A4C-A2ED-4CD1-BD83-3739BCFBA5AA";
            int merchandiseId = 465;
            int amount = 10;
            string comment = "только без брака";
            string response = "";

            // Assert
            Assert.Catch<ApplicationException>(
                () => response = orderModel.UpdateMerchandiseInOrder(customerId, merchandiseId, amount, comment),
                String.Format(ExceptionNames.NoMerchandiseById, "465"));
        }

        [Test]
        public void OrderModel_UpdateMerchandiseInOrder_NoActiveOrder_Fail()
        {
            // Arrange
            var orderModel = PrepareTestOrderRepository();

            // Act
            string customerId = "07E4E230-7F80-482D-9B1A-CB37C078A025";
            int merchandiseId = 465;
            int amount = 10;
            string comment = "только без брака";
            string response = "";

            // Assert
            Assert.Throws<ApplicationException>(
                () => response = orderModel.UpdateMerchandiseInOrder(customerId, merchandiseId, amount, comment),
                String.Format(ExceptionNames.NoActiveOrder, "07E4E230-7F80-482D-9B1A-CB37C078A025"));
        }

        [Test]
        public void OrderModel_DeleteMerchandiseFromOrder_NoActiveOrder_Fail()
        {
            // Arrange
            var orderModel = PrepareTestOrderRepository();

            // Act
            string customerId = "07E4E230-7F80-482D-9B1A-CB37C078A025";
            int merchandiseId = 465;
            string response = "";

            // Assert
            Assert.Throws<ApplicationException>(
                () => response = orderModel.DeleteMerchandiseFromOrder(customerId, merchandiseId),
                String.Format(ExceptionNames.NoActiveOrder, "07E4E230-7F80-482D-9B1A-CB37C078A025"));
        }
        
        [Test]
        public void OrderModel_DeleteMerchandiseFromOrder_UnknownMerchandise_Fail()
        {
            // Arrange
            var orderModel = PrepareTestOrderRepository();

            // Act
            string customerId = "9F8B3A4C-A2ED-4CD1-BD83-3739BCFBA5AA";
            int merchandiseId = 465;
            string response = "";

            // Assert
            Assert.Catch<ApplicationException>(
                () => response = orderModel.DeleteMerchandiseFromOrder(customerId, merchandiseId),
                String.Format(ExceptionNames.NoMerchandiseById, "465"));
        }

        [Test]
        public void OrderModel_DeleteMerchandiseFromOrder_Success()
        {
            // Arrange
            var orderModel = PrepareTestOrderRepository();

            // Act
            string customerId = "9F8B3A4C-A2ED-4CD1-BD83-3739BCFBA5AA";
            int merchandiseId = 1255;
            var response = orderModel.DeleteMerchandiseFromOrder(customerId, merchandiseId);

            // Assert
            Assert.IsTrue(response.Contains("Товар удален из заказа."));
        }

        [Test]
        public void OrderModel_CancelActiveOrder_NoActiveOrder_Fail()
        {
            // Arrange
            var orderModel = PrepareTestOrderRepository();

            // Act
            string customerId = "07E4E230-7F80-482D-9B1A-CB37C078A025";

            // Assert
            Assert.Throws<ApplicationException>(
                () => orderModel.CancelActiveOrder(customerId),
                String.Format(ExceptionNames.NoActiveOrder, "07E4E230-7F80-482D-9B1A-CB37C078A025"));
        }

        [Test]
        [Ignore]
        public void OrderModel_CancelActiveOrder_Success()
        {
            // Arrange
            var orderModel = PrepareTestOrderRepository();

            // Act
            string customerId = "9F8B3A4C-A2ED-4CD1-BD83-3739BCFBA5AA";
            int orderId = orderModel.GetActiveOrderId(customerId);
            orderModel.CancelActiveOrder(customerId);

            // Assert
            var testId = orderModel.GetActiveOrderId(customerId);
            Assert.IsTrue(orderId != testId);
        }

        [Test]
        public void OrderModel_ConfirmOrder_NoActiveOrder_Fail()
        {
            // Arrange
            var orderModel = PrepareTestOrderRepository();

            // Act
            string customerId = "07E4E230-7F80-482D-9B1A-CB37C078A025";
            string company = "ЗАО Хозком";
            string contactName = "Сергей";
            string phoneNumber = "+79045634899";
            string email = "sergeyv@hoskom.ru";
            string address = "г. Москва, Новокуркинское шоссе, 35-1";
            string inn = "";

            // Assert
            Assert.Throws<ApplicationException>(
                () => orderModel.ConfirmOrder(customerId, company, contactName, phoneNumber, email, address, inn),
                String.Format(ExceptionNames.NoActiveOrder, "07E4E230-7F80-482D-9B1A-CB37C078A025"));
        }

        [Test]
        public void OrderModel_ConfirmOrder_NoCustomer_Fail()
        {
            // Arrange
            var orderModel = PrepareTestOrderRepository();

            // Act
            string customerId = "D6952DEA-236C-4716-AE53-822D8D77033B";
            string company = "ЗАО Хозком";
            string contactName = "Сергей";
            string phoneNumber = "+79045634899";
            string email = "sergeyv@hoskom.ru";
            string address = "г. Москва, Новокуркинское шоссе, 35-1";
            string inn = "";

            // Assert
            Assert.Throws<ApplicationException>(
                () => orderModel.ConfirmOrder(customerId, company, contactName, phoneNumber, email, address, inn),
                String.Format(ExceptionNames.NoCustomer, "D6952DEA-236C-4716-AE53-822D8D77033B"));
        }

        [Test]
        public void OrderModel_ConfirmOrder_Success()
        {
            // Arrange
            var orderModel = PrepareTestOrderRepository();

            // Act
            string customerId = "9F8B3A4C-A2ED-4CD1-BD83-3739BCFBA5AA";
            string company = "ЗАО Хозком";
            string contactName = "Сергей";
            string phoneNumber = "+79045634899";
            string email = "sergeyv@hoskom.ru";
            string address = "г. Москва, Новокуркинское шоссе, 35-1";
            string inn = "";
            
            var orderId = orderModel.GetActiveOrderId(customerId);

            var mockNotifier = new FakeNewOrderNotifier();
            
            orderModel.NewOrderNotifier = mockNotifier;
            orderModel.ConfirmOrder(customerId, company, contactName, phoneNumber, email, address, inn);
            
            var testOrderId = orderModel.GetActiveOrderId(customerId);

            // Assert
            Assert.AreNotEqual(orderId, testOrderId);
            Assert.AreEqual(String.Format("Заказ '{0}' направлен в обработку.", orderId), mockNotifier.Response);
        }

        [Test]
        public void OrderModel_ConfirmOrderSubstitute_Success()
        {
            // Arrange
            var orderModel = PrepareTestOrderRepository();

            // Act
            string customerId = "9F8B3A4C-A2ED-4CD1-BD83-3739BCFBA5AA";
            string company = "ЗАО Хозком";
            string contactName = "Сергей";
            string phoneNumber = "+79045634899";
            string email = "sergeyv@hoskom.ru";
            string address = "г. Москва, Новокуркинское шоссе, 35-1";
            string inn = "";

            var orderId = orderModel.GetActiveOrderId(customerId);

            var mockNotifier = Substitute.For<FakeNewOrderNotifier>();            
            orderModel.NewOrderNotifier = mockNotifier;

            orderModel.ConfirmOrder(customerId, company, contactName, phoneNumber, email, address, inn);

            var testOrderId = orderModel.GetActiveOrderId(customerId);

            // Assert
            Assert.AreNotEqual(orderId, testOrderId);
            mockNotifier.Received().Notify(orderId);
        }

        #region Internals

        private IOrderRepository PrepareTestOrderRepository()
        {
            var merchandises = new EnumerableQuery<Merchandise>(new List<Merchandise>
            {
                new Merchandise { ID = 1255, SubgroupID = 30, ImageName = "1255.jpg", Title = "Шпингалет автомат 100 мм латунь", Pack = 20, UnitMeasure = "шт", CostWhs1 = 30, CostWhs2 = 25, CostWhs3 = 20 },
                new Merchandise { ID = 1257, SubgroupID = 30, ImageName = "1257.jpg", Title = "Шпингалет полукруглый 60 см хром", Pack = 60, UnitMeasure = "шт", CostWhs1 = 26, CostWhs2 = 22, CostWhs3 = 19 },
                new Merchandise { ID = 1577, SubgroupID = 30, ImageName = "1577.jpg", Title = "Шпингалет полукруглый 100 см латунь", Pack = 40, UnitMeasure = "шт", CostWhs1 = 30, CostWhs2 = 24, CostWhs3 = 20 },
                new Merchandise { ID = 1530, SubgroupID = 5, ImageName = "1530.jpg", Title = "Хомут (12-20 мм) нерж ЗЕТ", Pack = 100, UnitMeasure = "шт", CostWhs1 = 9, CostWhs2 = 7.5, CostWhs3 = 6 },
                new Merchandise { ID = 1776, SubgroupID = 28, ImageName = "1776.jpg", Title = "Петля ПН-5 60 мм бел. цинк Н", Pack = 200, UnitMeasure = "шт", CostWhs1 = 10, CostWhs2 = 8.3, CostWhs3 = 6.1 },
            });

            var orderDetails = new EnumerableQuery<OrderDetail>(new List<OrderDetail>
            {
                new OrderDetail { ID = 1, OrderID = 1, GoodsID = 1255, Quantity = 1090, Comment = "Нужен только белый цвет" },
                new OrderDetail { ID = 2, OrderID = 1, GoodsID = 1577, Quantity = 23, Comment = "Шпингалеты только без брака!!!" },
                new OrderDetail { ID = 3, OrderID = 1, GoodsID = 1530, Quantity = 57, Comment = "пластиковые" },
                new OrderDetail { ID = 4, OrderID = 1, GoodsID = 1776, Quantity = 100, Comment = "" },
                new OrderDetail { ID = 5, OrderID = 3, GoodsID = 1255, Quantity = 10000, Comment = "" },
                new OrderDetail { ID = 6, OrderID = 5, GoodsID = 1257, Quantity = 10, Comment = "" }
            });

            var orders = new EnumerableQuery<Order>(new List<Order>
            {
                new Order { ID = 1, CustomerID = "9F8B3A4C-A2ED-4CD1-BD83-3739BCFBA5AA", Completed = false, Created = DateTime.Now, Details = orderDetails.Where(od => od.OrderID == 1).ToArray() },
                new Order { ID = 3, CustomerID = "9F8B3A4C-A2ED-4CD1-BD83-3739BCFBA5AA", Completed = false, Created = DateTime.Now },
                new Order { ID = 4, CustomerID = "9F8B3A4C-A2ED-4CD1-BD83-3739BCFBA5AA", Completed = true, Created = DateTime.Now },
                new Order { ID = 2, CustomerID = "70FCF05A-ACC2-4CEB-A5D0-C19B40D6533E", Completed = true, Created = DateTime.Now, Details = orderDetails.Where(od => od.OrderID == 1).ToArray() },
                new Order { ID = 5, CustomerID = "70FCF05A-ACC2-4CEB-A5D0-C19B40D6533E", Completed = false, Created = DateTime.Now }
            });

            var customers = new EnumerableQuery<Customer>(new List<Customer>() 
            {
                new Customer { ID = "9F8B3A4C-A2ED-4CD1-BD83-3739BCFBA5AA", Address = "г. Москва, Новокуркинское шоссе, 35-1", Company = "ЗАО Хозком", ContactName = "Сергей", EmailAddress = "sergeyv@hoskom.ru", PhoneNumber = "+79045634899", INN="", Orders =  orders.Where(o => o.CustomerID.Equals("9F8B3A4C-A2ED-4CD1-BD83-3739BCFBA5AA")).ToArray() },
                new Customer { ID = "70FCF05A-ACC2-4CEB-A5D0-C19B40D6533E", Address = "г. Москва, Пятницкая улица, 11/2", Company = "ОАО Луна", ContactName = "Георгий", EmailAddress = "georges@luna.com", PhoneNumber = "+79155634190", INN="", Orders =  orders.Where(o => o.CustomerID.Equals("70FCF05A-ACC2-4CEB-A5D0-C19B40D6533E")).ToArray() },
                new Customer { ID = "07E4E230-7F80-482D-9B1A-CB37C078A025", Address = "г. Москва, Новокузнецкая улица, 1/2", Company = "ОАО Мапс", ContactName = "Гоша", EmailAddress = "gesha@maps.com", PhoneNumber = "+79055434109", INN="" },
            });

            var mockSetDiscounts = Substitute.For<IDbSet<Discount>>().Initialise(discounts);
            var mockSetCustomers = Substitute.For<IDbSet<Customer>>().Initialise(customers);
            var mockSetOrders = Substitute.For<IDbSet<Order>>().Initialise(orders);
            var mockSetOrderDetails = Substitute.For<IDbSet<OrderDetail>>().Initialise(orderDetails);
            var mockSetMerchandises = Substitute.For<IDbSet<Merchandise>>().Initialise(merchandises);

            var mockDbContext = Substitute.For<IDbGeneralContext>();
            mockDbContext.Discounts.Returns(mockSetDiscounts);
            mockDbContext.Customers.Returns(mockSetCustomers);
            mockDbContext.Orders.Returns(mockSetOrders);
            mockDbContext.OrderDetails.Returns(mockSetOrderDetails);
            mockDbContext.Merchandises.Returns(mockSetMerchandises);

            return
                new OrderRepository()
                {
                    Db = mockDbContext,
                    OrderCostCalculation = new OrderCostCalculation() { Db = mockDbContext }
                };
        }

        #endregion
    }
}
