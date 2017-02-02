using Altech.Core.Interfaces;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Altech.WebSite.Tests.Mocks
{
    public class FakeNewOrderNotifier : INewOrderNotifier
    {
        public string Response { get; set; }

        public void Notify(int orderId)
        {
            this.Response = String.Format("Заказ '{0}' направлен в обработку.", orderId);
        }
    }
}
