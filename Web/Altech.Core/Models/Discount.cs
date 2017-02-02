using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations.Schema;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Altech.Core.Models
{
    public class Discount
    {
        [DatabaseGenerated(DatabaseGeneratedOption.None)]
        public int ID { get; set; }

        // стоимость заказа с которой начинает действовать скиидка
        public double StartSumm { get; set; }
    }
}
