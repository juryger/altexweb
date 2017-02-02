using Altech.Core.Interfaces;
using Altech.Core.Models;
using Altech.WebSite.Consts;
using Altech.WebSite.Models;
using Altech.WebSite.Utilities;
using PagedList;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Web.Mvc;

namespace Altech.WebSite.Controllers
{
    public class CatalogController : Controller
    {
        #region Fields

        private ICatalogRepository service;

        private const string CatalogPageUrl = "/Catalog/Main";
        private const string CatalogSearchPageUrl = "/Catalog/Search";

        #endregion

        #region Ctr & dstr

        public CatalogController(ICatalogRepository service)
        {
            this.service = service;
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

        //
        // GET: /Catalog/Main/id/id2/id3
        public ActionResult Main(int? id, int? id2, int? id3)
        {
            var searchText = RequestParametersHandler.GetRequestParameter<String>(this.Request.Params, WebRequestParamNames.SearchText) ?? String.Empty;
            if (!String.IsNullOrWhiteSpace(searchText))
                return View(PrepareCatalogBySearch(id, id2, searchText));
            return View(PrepareCatalog(id, id2, id3));
        }

        #region Internal methods

        private IEnumerable<Group> PrepareCatalog(int? groupId, int? subgroupId, int? merchandiseId)
        {
            return PrepareCatalogGeneral(groupId, subgroupId, merchandiseId, String.Empty);
        }

        private IEnumerable<Group> PrepareCatalogBySearch(int? groupId, int? subgroupId, string searchText)
        {
            return PrepareCatalogGeneral(groupId, subgroupId, null, searchText);
        }
        
        private IEnumerable<Group> PrepareCatalogGeneral(int? groupId, int? subgroupId, int? merchandiseId, string searchText)
        {
            #region Извлечь из веб-запроса необходимые параметры

            var sortField = RequestParametersHandler.GetRequestParameter<String>(this.Request.Params, WebRequestParamNames.SortField) ?? String.Empty;
            var sortOrder = RequestParametersHandler.GetRequestParameter<String>(this.Request.Params, WebRequestParamNames.SortOrder) ?? String.Empty;
            var page = String.IsNullOrWhiteSpace(searchText) ? RequestParametersHandler.GetRequestParameter<int>(this.Request.Params, WebRequestParamNames.Page) : 1;

            #endregion

            // Извлечь из хранилища товар в соответствии с выбранной категорией (и с учетом поиска)
            Group group = null;
            Subgroup subgroup = null;
            IEnumerable<Merchandise> merchandises = 
                String.IsNullOrWhiteSpace(searchText) ? 
                    this.service.GetMerchandises(groupId, subgroupId, merchandiseId, out group, out subgroup) :
                    this.service.GetMerchandisesBySearch(groupId, subgroupId, searchText);

            // Сортировка 
            this.service.Sort(ref merchandises, sortField, sortOrder);

            // Paging
            ApplyPagging(merchandises, page);

            // Построение строки навигации
            BuildNavigatioinPath(group, subgroup, sortField, sortOrder, searchText);

            // Подготовка информации по скидкам и ценам
            PrepareDiscountsInformation();

            // Инициализация параметров View
            SetViewParams(groupId, subgroupId, merchandiseId, sortField, sortOrder, searchText);

            return this.service.Groups;
        }

        private void PrepareDiscountsInformation()
        {
            ViewBag.Discounts = this.service.GetDiscountsInfo();
        }

        private void ApplyPagging(IEnumerable<Merchandise> merchandises, int currentPage)
        {
            if (merchandises != null && merchandises.Count() > 0)
            {
                int pageSize = CookieHandler.GetCookieValue<int>(this.Request.Cookies, this.Response, CookieNames.RecordsOnPage, 20, DateTime.Now.AddYears(1));

                var pagingList = merchandises.ToPagedList(currentPage, pageSize);
                
                ViewBag.Page = currentPage;
                ViewBag.PageCount = pagingList.PageCount;
                ViewBag.Merchandises = pagingList;
            }
            else
            {
                ViewBag.Page = 0;
                ViewBag.PageCount = 0;
                ViewBag.Merchandises = new List<Merchandise>().ToPagedList(1, 1);
            }
        }

        private void BuildNavigatioinPath(Group group, Subgroup subgroup, string sortField, string sortOrder, string searchText)
        {
            var siteMapNavigation = new List<Breadcrumb>() { new Breadcrumb() { Title = "Каталог", Url = CatalogPageUrl } };
            
            if (group != null)
            {
                siteMapNavigation.Add(
                    new Breadcrumb()
                    {
                        Title = group.Title.Length > 20 ? group.Title.Substring(0, 20) : group.Title,
                        Url = String.Format("{0}/{1}?{2}={5}&{3}={6}&{4}=1",
                                CatalogPageUrl,
                                group.ID,
                                WebRequestParamNames.SortField,
                                WebRequestParamNames.SortOrder,
                                WebRequestParamNames.Page,
                                sortField,
                                sortOrder)
                    });

                if (subgroup != null)
                {
                    siteMapNavigation.Add(
                        new Breadcrumb()
                        {
                            Title = subgroup.Title.Length > 20 ? subgroup.Title.Substring(0, 20) : subgroup.Title,
                            Url = String.Format("{0}/{1}/{2}?{3}={6}&{4}={7}&{5}=1",
                                    CatalogPageUrl,
                                    group.ID,
                                    subgroup.ID,
                                    WebRequestParamNames.SortField,
                                    WebRequestParamNames.SortOrder,
                                    WebRequestParamNames.Page,
                                    sortField,
                                    sortOrder)
                        });
                }
            }

            if (!String.IsNullOrWhiteSpace(searchText))
            {
                siteMapNavigation.Add(
                        new Breadcrumb()
                        {
                            Title = "Поиск",
                            Url = String.Format("{0}?{1}={4}&{2}={5}&{3}=1",
                                    CatalogPageUrl,
                                    WebRequestParamNames.SortField,
                                    WebRequestParamNames.SortOrder,
                                    WebRequestParamNames.Page,
                                    sortField,
                                    sortOrder)
                        });
            }

            // карта навигации по каталогу
            ViewBag.Breadcrumbs = siteMapNavigation;
        }

        private void SetViewParams(int? id, int? id2, int? id3, string sortField, string sortOrder, string searchText)
        {
            int pageSize;
            int showNavigation;
            int groupId = 0, subgroupId = 0;
            string title;

            #region Проверка наличия в Cookie требуемых параметров
                     
            // Задать идентификатор клиента в Cookies (если отсутствует)
            CookieHandler.GetCookieValue<String>(this.Request.Cookies, this.Response, CookieNames.CustomerId, Guid.NewGuid().ToString(), DateTime.Now.AddYears(1));

            // Количество записей на странице
            pageSize = CookieHandler.GetCookieValue<int>(this.Request.Cookies, this.Response, CookieNames.RecordsOnPage, 20, DateTime.Now.AddYears(1));
            
            // Флаг указывающий на состояние области навигации (отображается или скрыто)            
            showNavigation = CookieHandler.GetCookieValue<int>(this.Request.Cookies, this.Response, CookieNames.ShowNavigation, 1, DateTime.Now.AddYears(1));

            #endregion

            #region Определение идентификатора подргруппы и группы по идентификатору товара

            if (!id3.HasValue)
            {
                if (id.HasValue)
                    groupId = id.Value;

                if (id2.HasValue)
                    subgroupId = id2.Value;
            }
            else
                this.service.ClarifyGroupAndSubgroupIDs(id3.Value, out groupId, out subgroupId);
            
            #endregion

            #region Конструирование полных URL-путей в зависимости от выбранного контекста

            StringBuilder contextCatalogPageUrl = new StringBuilder(CatalogPageUrl);
            if (id.HasValue)
                contextCatalogPageUrl.Append(String.Format("/{0}", id.Value));
            if (id2.HasValue)
                contextCatalogPageUrl.Append(String.Format("/{0}", id2.Value));

            #endregion

            #region Определение заголовка страницы в зависимости от выбранного контекста

            if (groupId > 0)
            {
                title = this.service.GetGroupTitle(groupId);
                if (subgroupId > 0)
                {
                    title = String.Format("{0} - {1}", title, this.service.GetSubgroupTitle(subgroupId));
                }
            }
            else
                title = "Каталог"; 

            #endregion

            ViewBag.Title = title;
            
            ViewBag.GroupId = groupId;
            ViewBag.SubgroupId = subgroupId;

            ViewBag.CatalogPageUrl = CatalogPageUrl;
            ViewBag.ContextCatalogPageUrl = contextCatalogPageUrl.ToString();
            
            ViewBag.SearchText = searchText;
            ViewBag.SortOrder = sortOrder;
            ViewBag.SortField = sortField;
            ViewBag.ShowNavigation = showNavigation;
            
            ViewBag.RecordsOnPageCookieName = CookieNames.RecordsOnPage;
            ViewBag.ShowNavigationCookieName = CookieNames.ShowNavigation;            
        }

        #endregion
	}
}