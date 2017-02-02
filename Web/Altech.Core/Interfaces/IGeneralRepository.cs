using Altech.Core.Models;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Altech.Core.Interfaces
{
    public interface IGeneralRepository: IDisposable
    {
        void AddOrUpdateGroup(Group g);
        void AddOrUpdateSubgroup(Subgroup s);
        void AddOrUpdateMerchandise(Merchandise m);
        void AddOrUpdateDiscount(Discount d);

        void DeleteGroup(int id);
        void DeleteSubgroup(int id);
        void DeleteMerchandise(int id);
        void DeleteDiscount(int id);
    }
}
