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

            int counter = 0;

            var sortedDiscounts = discounts.OrderBy(x => x.StartSumm);
            foreach (var item in sortedDiscounts)
            {
                counter += 1;

                // Note: first discount is just normal price
                if (counter == 1)
                    continue;

                var cost = item.StartSumm.ToString("C", CultureInfo.CreateSpecificCulture("ru-RU"));

                // Note: last discount should be represent as Special price, not visible for public.
                if (counter < sortedDiscounts.Count())
                    sb.Append(string.Format(" Опт - от {0} |", cost.Substring(0, cost.Length - 1)));
                else 
                    sb.Append(string.Format(" Спеццена - от {0}", cost.Substring(0, cost.Length - 1)));
            }

            return sb.Length > 0 ? sb.ToString().Substring(0, sb.Length - 1).Trim() : "Информация о скидках в настоящий момент не доступна.";
        }
    }
}
