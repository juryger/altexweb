using Altech.Core.Interfaces;
using Altech.Core.Models;
using Altech.DAL.Interfaces;
using Altech.DAL.Utilities;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Altech.DAL
{
    internal sealed class CatalogRepository: ICatalogRepository
    {
        #region Fields

        private IDbGeneralContext db;
        private bool disposed;

        #endregion

        public IDbGeneralContext Db
        {
            set 
            {
                if (value != null)
                    this.db = value;
            }
        }

        #region Ctr & dstr

        public CatalogRepository()
        {
            this.db = new AltechContext();
        }

        public void Dispose()
        {
            if (this.disposed)
                return;

            this.db.Dispose();
            this.db = null;

            this.disposed = true;
        } 
        
        #endregion

        #region Public operations

        public IEnumerable<Group> Groups
        {
            get { return this.db.Groups.ToList(); }
        }

        public void ClarifyGroupAndSubgroupIDs(int merchandiseId, out int groupId, out int subgroupId)
        {
            groupId = subgroupId = 0;

            var m = this.db.Merchandises.SingleOrDefault(d => d.ID == merchandiseId);
            if (m != null)
            {
                subgroupId = m.SubgroupID;
                var s = this.db.Subgroups.SingleOrDefault(d => d.ID == m.SubgroupID);
                if (s != null)
                    groupId = s.GroupID;
            }
        }

        public IEnumerable<Merchandise> GetMerchandises(int? id, int? id2, int? id3, out Group group, out Subgroup subgroup)
        {
            group = null;
            subgroup = null;
            IEnumerable<Merchandise> result = null;

            if (!id.HasValue)
                result = GetAllMerchandise();
            else
            {
                group = this.db.Groups.FirstOrDefault(g => g.ID == id.Value);
                if (!id2.HasValue)
                    result = GetAllMerchandiseInGroup(id.Value);
                else
                {
                    subgroup = this.db.Subgroups.FirstOrDefault(s => s.ID == id2.Value);
                    if (!id3.HasValue)
                        result = GetAllMerchandiseInSubgroup(id2.Value);
                    else
                    {
                        var merchandise = this.db.Merchandises.FirstOrDefault(m => m.ID == id3.Value);
                        if (merchandise != null)
                            result = new List<Merchandise>() { merchandise };
                    }
                }
            }

            return result;
        }

        public IEnumerable<Merchandise> GetMerchandisesBySearch(int? groupId, int? subgroupId, string searchText)
        {
            if (String.IsNullOrEmpty(searchText))
                throw new ArgumentNullException("searchText");

            IEnumerable<Merchandise> result = null;

            if (subgroupId.HasValue)
            {
                result = SearchInSubgroup(subgroupId.Value, searchText);

                // если поиск в выбранной подгруппе закончился безрезультатно, выполнить поиск по товарам во всех категориях
                if (result == null || !result.Any())
                    result = SearchWholeCatalog(searchText);
            }
            else if (groupId.HasValue)
            {
                result = SearchInGroup(groupId.Value, searchText);

                // если поиск в выбранной подгруппе закончился безрезультатно, выполнить поиск по товарам во всех категориях
                if (result == null || !result.Any())
                    result = SearchWholeCatalog(searchText);
            }
            else
                result = SearchWholeCatalog(searchText); // поиск по всем группам

            return result;
        }

        public string GetGroupTitle(int id)
        {
            var g = this.db.Groups.FirstOrDefault(d => d.ID == id);
            return g != null ? g.Title : "Группа отсутствует";
        }

        public string GetSubgroupTitle(int id)
        {
            var g = this.db.Subgroups.FirstOrDefault(d => d.ID == id);
            return g != null ? g.Title : "Подгруппа отсутствует";
        }

        public string GetDiscountsInfo()
        {
            return DiscountsInfo.GetDescription(this.db.Discounts);
        }

        public void Sort(ref IEnumerable<Merchandise> merchandises, string sortField, string sortOrder)
        {
            if (merchandises == null)
                return;

            switch (String.Format("{0}_{1}", sortField ?? String.Empty, sortOrder ?? String.Empty))
            {
                case "id_asc":
                    merchandises = merchandises.OrderBy(m => m.ID).ToList();
                    break;
                case "id_desc":
                    merchandises = merchandises.OrderByDescending(m => m.ID).ToList();
                    break;
                case "title_asc":
                    merchandises = merchandises.OrderBy(m => m.Title).ToList();
                    break;
                case "title_desc":
                    merchandises = merchandises.OrderByDescending(m => m.Title).ToList();
                    break;
                default:
                    // по умолчанию сортировка по наименованию товара
                    merchandises = merchandises.OrderBy(m => m.Title).ToList();
                    break;
            }
        } 

        #endregion

        #region Private operations

        private IEnumerable<Merchandise> GetAllMerchandise()
        {
            var result = new List<Merchandise>();

            foreach (var groupItem in this.db.Groups)
                foreach (var subgroupItem in groupItem.Subgroups)
                    result.AddRange(subgroupItem.Merchandises);

            return result;
        }

        private IEnumerable<Merchandise> GetAllMerchandiseInGroup(int groupId)
        {
            var result = new List<Merchandise>();

            var group = this.db.Groups.First(g => g.ID == groupId);
            foreach (var item in group.Subgroups)
                result.AddRange(item.Merchandises);

            return result;
        }

        private IEnumerable<Merchandise> GetAllMerchandiseInSubgroup(int subgroupId)
        {
            var result = new List<Merchandise>();

            var subgroup = this.db.Subgroups.First(s => s.ID == subgroupId);
            result.AddRange(subgroup.Merchandises);

            return result;

        }

        private IEnumerable<Merchandise> SearchWholeCatalog(string searchText)
        {
            if (String.IsNullOrEmpty(searchText))
                throw new ArgumentNullException("searchText");

            int id = 0;
            Int32.TryParse(searchText, out id);

            return this.db.Merchandises.Where(m => m.ID == id || m.Title.ToUpper().Contains(searchText.ToUpper()));
        }

        private IEnumerable<Merchandise> SearchInGroup(int groupId, string searchText)
        {
            var group = this.db.Groups.FirstOrDefault(g => g.ID == groupId);
            if (group == null)
                return null;

            var merchandises = new List<Merchandise>();
            foreach (var subgroup in group.Subgroups)
            {
                var result = SearchInSubgroup(subgroup.ID, searchText);
                if (result != null && result.Any())
                    merchandises.AddRange(result);
            }

            return merchandises;
        }

        private IEnumerable<Merchandise> SearchInSubgroup(int subgroupId, string searchText)
        {
            var subgroup = this.db.Subgroups.FirstOrDefault(s => s.ID == subgroupId);
            if (subgroup == null)
                return null;

            int id = 0;
            Int32.TryParse(searchText, out id);

            return subgroup.Merchandises.Where(m => m.ID == id || m.Title.ToUpper().Contains(searchText.ToUpper())); ;
        }

        #endregion
    }
}
