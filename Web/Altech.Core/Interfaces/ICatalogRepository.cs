using Altech.Core.Models;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Altech.Core.Interfaces
{
    public interface ICatalogRepository
    {
        IEnumerable<Group> Groups { get; }
        string GetGroupTitle(int id);
        string GetSubgroupTitle(int id);
        string GetDiscountsInfo();
        void ClarifyGroupAndSubgroupIDs(int merchandiseId, out int groupId, out int subgroupId);
        IEnumerable<Merchandise> GetMerchandises(int? id, int? id2, int? id3, out Group group, out Subgroup subgroup);
        IEnumerable<Merchandise> GetMerchandisesBySearch(int? groupId, int? subgroupId, string searchText);
        void Sort(ref IEnumerable<Merchandise> merchandises, string sortField, string sortOrder);
    }
}
