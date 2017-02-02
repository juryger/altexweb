using Altech.Core.Models;
using System;
using System.Collections.Generic;
using System.Globalization;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Altech.DAL.Utilities
{
    internal sealed class DiscountsInfo
    {
        public static string GetDescription(IEnumerable<Discount> discounts)
        {
            if (discounts == null)
                throw new ArgumentNullException("discounts");

            var sb = new StringBuilder();
            foreach (var item in discounts)
            {
                var cost = item.StartSumm.ToString("C", CultureInfo.CreateSpecificCulture("ru-RU"));
                sb.Append(String.Format(" Опт{0} - от {1} |", item.ID, cost.Substring(0, cost.Length - 1)));
            }

            return sb.Length > 0 ? sb.ToString().Substring(0, sb.Length - 1).Trim() : "Информация о скидках в настоящий момент не доступна.";
        }
    }
}
