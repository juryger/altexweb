using Altech.Core.Interfaces;
using Altech.Core.Models;
using Altech.WebSite.Consts;
using Altech.WebSite.Models;
using Altech.WebSite.Utilities;
using System;
using System.Collections.Generic;
using System.Web.Mvc;

namespace Altech.WebSite.Controllers
{
    public class OrderController : Controller
    {
        #region Fields

        private IOrderRepository service; 
        
        #endregion

        #region Ctr & dstr

        public OrderController(IOrderRepository service, INewOrderNotifier orderNotifier, IOrderCostCalculation orderCalc)
        {
            this.service = service;

            this.service.NewOrderNotifier = orderNotifier;
            this.service.OrderCostCalculation = orderCalc;
        }

        protected override void Dispose(bool disposing)
        {
            if (disposing)
            {
                this.service = null;
            }

            base.Dispose(disposing);
        }

        #endregion

        // GET: /Order
        public ActionResult Main()
        {
            return View(PrepareOrderDetails());
        }

        // POST: /Order/Search
        // To protect from overposting attacks, please enable the specific properties you want to bind to, for 
        // more details see http://go.microsoft.com/fwlink/?LinkId=317598.
        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult Search()
        {
            var searchText = RequestParametersHandler.GetRequestParameter<String>(this.Request.Params, WebRequestParamNames.SearchText) ?? String.Empty;
            return View("Main", PrepareOrderDetailsBySearch(searchText));
        }

        // POST: /Order/Add
        // To protect from overposting attacks, please enable the specific properties you want to bind to, for 
        // more details see http://go.microsoft.com/fwlink/?LinkId=317598.
        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult Add()
        {
            int merchandiseId, orderAmount;
            string orderComment;

            #region Прочитать параметры POST-запроса

            if (this.Request.Params.Count == 0)
            {
                ViewBag.ResponseMessage = "error: В запросе не переданы обязательные параметры заказа.";
                return View();
            }

            merchandiseId = RequestParametersHandler.GetRequestParameter<int>(this.Request.Params, WebRequestParamNames.MerchandiseId);
            orderAmount = RequestParametersHandler.GetRequestParameter<int>(this.Request.Params, WebRequestParamNames.OrderAmount);
            orderComment = RequestParametersHandler.GetRequestParameter<string>(this.Request.Params, WebRequestParamNames.OrderComment) ?? String.Empty;

            #endregion

            // Прочитать из Cookie идентификатор клиента
            var customerId = CookieHandler.GetCookieValue<String>(this.Request.Cookies, this.Response, CookieNames.CustomerId, Guid.NewGuid().ToString(), DateTime.Now.AddYears(1));

            // Обновить заказ в БД
            ViewBag.ResponseMessage = this.service.AddMerchandiseToOrder(customerId, merchandiseId, orderAmount, orderComment);

            return View();
        }

        // POST: /Order/Update
        // To protect from overposting attacks, please enable the specific properties you want to bind to, for 
        // more details see http://go.microsoft.com/fwlink/?LinkId=317598.
        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult Update()
        {
            int merchandiseId, orderAmount;
            string orderComment;

            // прочитать из Cookie идентификатор клиента
            var customerId = CookieHandler.GetCookieValue<String>(this.Request.Cookies, this.Response, CookieNames.CustomerId, Guid.NewGuid().ToString(), DateTime.Now.AddYears(1));

            #region Прочитать параметры POST-запроса
            
            if (this.Request.Params.Count == 0)
            {
                ViewBag.ResponseMessage = "error: В запросе не переданы обязательные параметры заказа.";
                return View();
            }

            merchandiseId = RequestParametersHandler.GetRequestParameter<int>(this.Request.Params, WebRequestParamNames.MerchandiseId);
            orderAmount = RequestParametersHandler.GetRequestParameter<int>(this.Request.Params, WebRequestParamNames.OrderAmount);
            orderComment = RequestParametersHandler.GetRequestParameter<string>(this.Request.Params, WebRequestParamNames.OrderComment) ?? String.Empty;

            #endregion

            // Обновить заказ в БД
            ViewBag.ResponseMessage = this.service.UpdateMerchandiseInOrder(customerId, merchandiseId, orderAmount, orderComment);

            return View();
        }

        // POST: /Order/Delete
        // To protect from overposting attacks, please enable the specific properties you want to bind to, for 
        // more details see http://go.microsoft.com/fwlink/?LinkId=317598.
        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult Delete()
        {
            int merchandiseId;

            // прочитать из Cookie идентификатор клиента
            var customerId = CookieHandler.GetCookieValue<String>(this.Request.Cookies, this.Response, CookieNames.CustomerId, Guid.NewGuid().ToString(), DateTime.Now.AddYears(1));

            #region Прочитать параметры POST-запроса

            if (this.Request.Params.Count == 0)
            {
                ViewBag.ResponseMessage = "error: В запросе не переданы обязательные параметры заказа.";
                return View();
            }

            merchandiseId = RequestParametersHandler.GetRequestParameter<int>(this.Request.Params, WebRequestParamNames.MerchandiseId);

            #endregion

            // Удалить позицию из заказ в БД
            ViewBag.ResponseMessage = this.service.DeleteMerchandiseFromOrder(customerId, merchandiseId);

            return View();
        }

        // GET: /Order/Cancel
        public ActionResult Cancel()
        {
            // Проверка наличия в Cookie требуемых параметров - Идентификатор клиента
            var customerId = CookieHandler.GetCookieValue(this.Request.Cookies, this.Response, CookieNames.CustomerId, Guid.NewGuid().ToString(), DateTime.Now.AddYears(1));

            this.service.CancelActiveOrder(customerId);

            CookieHandler.SetCookieValue<bool>(this.Response, CookieNames.IsOrderNotEmpty, false, DateTime.Now.AddDays(1));

            return View("Main", PrepareOrderDetails());
        }

        // GET: /Order/CustomerConfirmation
        public ActionResult CustomerConfirmation()
        {
            // прочитать из Cookie идентификатор клиента
            var customerId = CookieHandler.GetCookieValue<String>(this.Request.Cookies, this.Response, CookieNames.CustomerId, Guid.NewGuid().ToString(), DateTime.Now.AddYears(1));

            // Проверить, что имеется активный заказ 
            var orderId = this.service.GetActiveOrderId(customerId);
            if (orderId <= 0)
                ViewBag.ErrorMessage = "Произошла ошибка - не удается найти активный заказ. Перейдите в раздел 'Каталог' и добавьте необходимые товары в заказ.";

            return View(this.service.GetCustomer(customerId));
        }

        // POST: /Order/OrderConfirmation
        // To protect from overposting attacks, please enable the specific properties you want to bind to, for 
        // more details see http://go.microsoft.com/fwlink/?LinkId=317598.
        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult OrderConfirmation()
        {
            // прочитать из Cookie идентификатор клиента
            var customerId = CookieHandler.GetCookieValue<String>(this.Request.Cookies, this.Response, CookieNames.CustomerId, Guid.NewGuid().ToString(), DateTime.Now.AddYears(1));

            // Проверить, что имеется активный заказ 
            var orderId = GetActiveOrderId(customerId);
            if (orderId <= 0)
            {
                ViewBag.ErrorMessage = "Произошла ошибка - не удается найти активный заказ. Перейдите в раздел 'Каталог' и добавьте необходимые товары в заказ.";
                return View();
            }

            #region Прочитать параметры POST-запроса (данные о клиенте) и сохранить их в БД            

            if (this.Request.Params.Count == 0)
            {
                ViewBag.ErrorMessage = "Произошла ошибка - в запросе не переданы обязательные параметры заказа.";
                return View();
            }

            var company = RequestParametersHandler.GetRequestParameter<String>(this.Request.Params, WebRequestParamNames.CustomerCompany) ?? String.Empty;
            if (String.IsNullOrEmpty(company))
            {
                ViewBag.ErrorMessage =
                    String.Format("Произошла ошибка - в POST-параметрах запроса не найден параметр с именем '{0}'.", 
                        WebRequestParamNames.CustomerCompany);
                return View();
            }

            var contactName = RequestParametersHandler.GetRequestParameter<String>(this.Request.Params, WebRequestParamNames.CustomerContactName) ?? String.Empty;

            var phone = RequestParametersHandler.GetRequestParameter<String>(this.Request.Params, WebRequestParamNames.CustomerPhoneNumber) ?? String.Empty;
            if (String.IsNullOrEmpty(phone))
            {
                ViewBag.ErrorMessage =
                    String.Format("Произошла ошибка - в POST-параметрах запроса не найден параметр с именем '{0}'.", 
                        WebRequestParamNames.CustomerPhoneNumber);
                return View();
            }

            var email = RequestParametersHandler.GetRequestParameter<String>(this.Request.Params, WebRequestParamNames.CustomerEmail) ?? String.Empty;
            if (String.IsNullOrEmpty(email))
            {
                ViewBag.ErrorMessage =
                    String.Format("Произошла ошибка - в POST-параметрах запроса не найден параметр с именем '{0}'.", 
                        WebRequestParamNames.CustomerEmail);
                return View();
            }

            var address = RequestParametersHandler.GetRequestParameter<String>(this.Request.Params, WebRequestParamNames.CustomerAddress) ?? String.Empty;
            var inn = RequestParametersHandler.GetRequestParameter<String>(this.Request.Params, WebRequestParamNames.CustomerINN) ?? String.Empty;

            #endregion

            this.service.ConfirmOrder(customerId, company, contactName, phone, email, address, inn);

            // сбросить флаг наличия товаров в заказе
            CookieHandler.SetCookieValue<bool>(this.Response, CookieNames.IsOrderNotEmpty, false, DateTime.Now.AddDays(1));

            return View();
        }

        #region Miscellaneous

        private IEnumerable<OrderDetail> PrepareOrderDetails()
        {
            return this.PrepareOrderDetailsGeneral(String.Empty);
        }

        private IEnumerable<OrderDetail> PrepareOrderDetailsBySearch(string searchText)
        {
            return this.PrepareOrderDetailsGeneral(searchText);
        }

        private IEnumerable<OrderDetail> PrepareOrderDetailsGeneral(string searchText)
        {
            // Проверка наличия в Cookie Идентификатора клиента
            var customerId = CookieHandler.GetCookieValue<String>(this.Request.Cookies, this.Response, CookieNames.CustomerId, Guid.NewGuid().ToString(), DateTime.Now.AddYears(1));

            // Проверка наличия открытого заказа
            var orderId = GetActiveOrderId(customerId);

            // Подготовить товары связанные с заказом
            PrepareOrderMerchandises(orderId, searchText);

            // Расчитать стоимость заказа
            CalculateOrderCosts(orderId);

            // Подготовить раздел навигации по сайту
            PrepareSiteMapNavigation(searchText);

            // Подготовка информации по скидкам и ценам
            PrepareDiscountsInformation();

            return this.service.GetActiveOrderItems(orderId);
        }

        private int GetActiveOrderId(string customerId)
        {
            var orderId = this.service.GetActiveOrderId(customerId);
            ViewBag.OrderId = orderId;

            return orderId;
        }

        private void PrepareOrderMerchandises(int orderId, string searchText) 
        {
            IEnumerable<Merchandise> result = null;
            if (!String.IsNullOrWhiteSpace(searchText))
            {
                result = this.service.Search(orderId, searchText);
                ViewBag.SearchText = searchText;
            }
            else
                result = this.service.GetActiveOrderMerchandises(orderId);

            ViewBag.Merchandises = result;
        }

        private void PrepareSiteMapNavigation(string searchText)
        {
            var siteMapNavigation = new List<Breadcrumb>() { new Breadcrumb() { Title = "Заказ", Url = "/Order/Main" } };

            if (!String.IsNullOrWhiteSpace(searchText))
            {
                siteMapNavigation.Add(
                    new Breadcrumb() { Title = "Поиск", Url = String.Format("/Order/Main?searchText={0}", searchText) });
            }
                
            ViewBag.Breadcrumbs = siteMapNavigation;
        }

        private void CalculateOrderCosts(int orderId)
        {
            double sum = default(double), sumDiscount = default(double);
            this.service.CalculateOrderOverallCost(orderId, out sum, out sumDiscount);

            ViewBag.Sum = sum;
            ViewBag.SumDiscount = sumDiscount;
        }

        private void PrepareDiscountsInformation()
        {
            ViewBag.Discounts = this.service.GetDiscountsInfo();
        }

        #endregion
    }
}
