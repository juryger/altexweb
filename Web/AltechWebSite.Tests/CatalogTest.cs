using System;
using NUnit.Framework;
using Altech.WebSite.Controllers;
using Altech.WebSite.Consts;
using System.Collections.Specialized;
using NSubstitute;
using System.Data.Entity;
using Altech.Core.Models;
using System.Collections.Generic;
using System.Linq;
using Altech.WebSite.Utilities;
using Altech.Core.Interfaces;
using Altech.DAL.Interfaces;
using Altech.DAL;

namespace Altech.WebSite.Tests
{
    [TestFixture]
    public class CatalogTest
    {
        [Test]
        public void RequestParameters_GetDefaultValues()
        {
            var collection = new NameValueCollection();

            var strValue = RequestParametersHandler.GetRequestParameter<string>(collection, WebRequestParamNames.SearchText);
            Assert.AreEqual(strValue, null);

            var intValue = RequestParametersHandler.GetRequestParameter<int>(collection, WebRequestParamNames.Page);
            Assert.AreEqual(intValue, 1);

            strValue = RequestParametersHandler.GetRequestParameter<string>(collection, WebRequestParamNames.SortField);
            Assert.AreEqual(strValue, WebRequestParamDefaults.SortField);

            strValue = RequestParametersHandler.GetRequestParameter<string>(collection, WebRequestParamNames.SortOrder);
            Assert.AreEqual(strValue, WebRequestParamDefaults.SortOrder);
        }

        [Test]
        public void RequestParameters_GetConcreteParametersValues()
        {
            var collection = new NameValueCollection();        

            collection.Add(WebRequestParamNames.CustomerEmail, "juryger@gmail.com");
            var strValue = RequestParametersHandler.GetRequestParameter<string>(collection, WebRequestParamNames.CustomerEmail);
            Assert.AreEqual(strValue, "juryger@gmail.com");

            collection.Add(WebRequestParamNames.MerchandiseId, "99");
            var intValue = RequestParametersHandler.GetRequestParameter<int>(collection, WebRequestParamNames.MerchandiseId);
            Assert.AreEqual(intValue, 99);
        }

        [Test]
        public void RequestParameters_GetMissingParameterValue_Exception()
        {
            var collection = new NameValueCollection();
            var strValue = RequestParametersHandler.GetRequestParameter<string>(collection, WebRequestParamNames.CustomerEmail);
            Assert.AreEqual(strValue, null);
        }

        [TestCase(6, 30, 1255, true)]
        [TestCase(30, 6, 1255, false)]
        public void CatalogModel_ClarifyGroupAndSubgroupIDs_Check(int gId, int sgId, int mId, bool expected)
        {
            int groupId, subgroupId;

            // Arrange
            var catalog = PrepareTestCatalogRepository();

            // Act
            catalog.ClarifyGroupAndSubgroupIDs(mId, out groupId, out subgroupId);

            // Assert
            if (expected)
            {
                Assert.AreEqual(groupId, gId);
                Assert.AreEqual(subgroupId, sgId);
            }
            else {
                Assert.AreNotEqual(groupId, gId);
                Assert.AreNotEqual(subgroupId, sgId);
            }
        }

        [Test]
        public void CatalogModel_Sort_Success()
        {
            // Arrange
            var catalog = PrepareTestCatalogRepository();
            IEnumerable<Merchandise> list = new List<Merchandise>
            {
                new Merchandise { ID = 1776, SubgroupID = 28, ImageName = "1776.jpg", Title = "Петля ПН-5 60 мм бел. цинк Н", Pack = 200, UnitMeasure = "шт", CostWhs1 = 10, CostWhs2 = 8.3, CostWhs3 = 6.1 },
                new Merchandise { ID = 1257, SubgroupID = 30, ImageName = "1257.jpg", Title = "Шпингалет полукруглый 60 см хром", Pack = 60, UnitMeasure = "шт", CostWhs1 = 26, CostWhs2 = 22, CostWhs3 = 19 },
                new Merchandise { ID = 1577, SubgroupID = 30, ImageName = "1577.jpg", Title = "Шпингалет полукруглый 100 см латунь", Pack = 40, UnitMeasure = "шт", CostWhs1 = 30, CostWhs2 = 24, CostWhs3 = 20 }
            };

            // Act
            catalog.Sort(ref list, "id", "desc");
            var maxId = list.First().ID;
            foreach (var item in list)
                maxId = Math.Max(item.ID, maxId);

            // Assert    
            Assert.AreEqual(list.First().ID, maxId);

            // Act
            catalog.Sort(ref list, "id", "asc");
            var minId = list.First().ID;
            foreach (var item in list)
                minId = Math.Min(item.ID, minId);

            // Assert    
            Assert.AreEqual(list.First().ID, minId);
        }

        [TestCase("1255", 1)]
        [TestCase("1256", 0)]
        [TestCase("шпингалет", 3)]
        [TestCase("100", 2)]
        public void CatalogModel_SearchWholeCatalog_Check(string text, int num)
        {
            // Arrange
            var catalog = PrepareTestCatalogRepository();
            
            // Act
            var merchandises = catalog.GetMerchandisesBySearch(null, null, text);

            // Assert
            Assert.AreEqual(merchandises.Count(), num);
        }

        [TestCase(5, "1530", 1)]
        [TestCase(6, "шпингалет", 3)]
        [TestCase(22, "шпингалет", 3)]
        [TestCase(5, "1256", 0)]
        [TestCase(0, "Петля", 1)]
        public void CatalogModel_SearchInGroup_Check(int id, string text, int num)
        {
            // Arrange
            var catalog = PrepareTestCatalogRepository();
            
            // Act
            var merchandises = catalog.GetMerchandisesBySearch(id, null, text);

            // Assert
            Assert.AreEqual(merchandises.Count(), num);
        }

        [TestCase(5, 5, "1530", 1)]
        [TestCase(6, 30, "шпингалет", 3)]
        [TestCase(6, 5, "1256", 0)]
        [TestCase(22, 0, "Петля", 1)]
        [TestCase(0, 0, "Петля", 1)]
        public void CatalogModel_SearchInSubgroup_Check(int groupId, int subgroupId, string text, int num)
        {
            // Arrange
            var catalog = PrepareTestCatalogRepository();

            // Act
            var merchandises = catalog.GetMerchandisesBySearch(groupId, subgroupId, text);

            // Assert
            Assert.AreEqual(merchandises.Count(), num);
        }

        #region Internals

        private ICatalogRepository PrepareTestCatalogRepository()
        {
            var merchandises = new EnumerableQuery<Merchandise>(new List<Merchandise>
            {
                new Merchandise { ID = 1255, SubgroupID = 30, ImageName = "1255.jpg", Title = "Шпингалет автомат 100 мм латунь", Pack = 20, UnitMeasure = "шт", CostWhs1 = 30, CostWhs2 = 25, CostWhs3 = 20 },
                new Merchandise { ID = 1257, SubgroupID = 30, ImageName = "1257.jpg", Title = "Шпингалет полукруглый 60 см хром", Pack = 60, UnitMeasure = "шт", CostWhs1 = 26, CostWhs2 = 22, CostWhs3 = 19 },
                new Merchandise { ID = 1577, SubgroupID = 30, ImageName = "1577.jpg", Title = "Шпингалет полукруглый 100 см латунь", Pack = 40, UnitMeasure = "шт", CostWhs1 = 30, CostWhs2 = 24, CostWhs3 = 20 },
                new Merchandise { ID = 1530, SubgroupID = 5, ImageName = "1530.jpg", Title = "Хомут (12-20 мм) нерж ЗЕТ", Pack = 100, UnitMeasure = "шт", CostWhs1 = 9, CostWhs2 = 7.5, CostWhs3 = 6 },
                new Merchandise { ID = 1776, SubgroupID = 28, ImageName = "1776.jpg", Title = "Петля ПН-5 60 мм бел. цинк Н", Pack = 200, UnitMeasure = "шт", CostWhs1 = 10, CostWhs2 = 8.3, CostWhs3 = 6.1 },
            });

            var subgroups = new EnumerableQuery<Subgroup>(new List<Subgroup>
            {
                new Subgroup { ID = 5, GroupID = 5, Title = "(все хомуты)", Merchandises = merchandises.Where(m => m.SubgroupID == 5).ToArray() },
                new Subgroup { ID = 28, GroupID = 6, Title = "Петли накладные", Merchandises = merchandises.Where(m => m.SubgroupID == 28).ToArray() },
                new Subgroup { ID = 30, GroupID = 6, Title = "Шпингалеты", Merchandises = merchandises.Where(m => m.SubgroupID == 30).ToArray() },
                new Subgroup { ID = 37, GroupID = 6, Title = "Упоры Дверные", Merchandises = merchandises.Where(m => m.SubgroupID == 37).ToArray() },
                new Subgroup { ID = 7, GroupID = 22, Title = "(все хозтовары)", Merchandises = merchandises.Where(m => m.SubgroupID == 7).ToArray() }
            });

            var groups = new EnumerableQuery<Group>(new List<Group>
            {
                new Group { ID = 5, Title = "Хомуты", Subgroups = subgroups.Where(s => s.GroupID == 5).ToArray() },
                new Group { ID = 6, Title = "Фурнитура", Subgroups =  subgroups.Where(s => s.GroupID == 6).ToArray() },
                new Group { ID = 22, Title = "Хозтовары", Subgroups = subgroups.Where(s => s.GroupID == 22).ToArray() }
            });

            var mockSetGroups = Substitute.For<IDbSet<Group>>().Initialise(groups);
            var mockSetSubgroups = Substitute.For<IDbSet<Subgroup>>().Initialise(subgroups);
            var mockSetMerchandises = Substitute.For<IDbSet<Merchandise>>().Initialise(merchandises);

            var mockDbContext = Substitute.For<IDbGeneralContext>();
            mockDbContext.Groups.Returns(mockSetGroups);
            mockDbContext.Subgroups.Returns(mockSetSubgroups);
            mockDbContext.Merchandises.Returns(mockSetMerchandises);

            return new CatalogRepository() { Db = mockDbContext };
        }

        #endregion
    }
}
