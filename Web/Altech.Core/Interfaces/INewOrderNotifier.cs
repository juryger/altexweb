using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Altech.Core.Interfaces
{
    /// <summary>
    /// Интерфейс для уведомления о размещении новой заявки на заказ.
    /// </summary>
    public interface INewOrderNotifier
    {
        // Уведомить о размещении нового заказа
        void Notify(int orderId);
    }
}
