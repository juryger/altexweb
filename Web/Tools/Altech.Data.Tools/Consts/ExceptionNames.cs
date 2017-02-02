using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace Altech.DAL.Consts
{
    internal sealed class ExceptionNames
    {
        public const string NoActiveOrder = "Не найден ни один открытый заказ для данного клиента: '{0}'";
        public const string NoCustomer = "Не найден клиент с указанным идентификатором: '{0}'";
        public const string NoMerchandiseById = "Не найден товар с указанным идентификатором: '{0}'";
    }
}