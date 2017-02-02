using System;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;

namespace Altech.Core.Models
{
    public class OrderDetail
    {
        [DatabaseGenerated(DatabaseGeneratedOption.Identity)]
        public int ID { get; set; }

        // идентификатор заказа из родительской таблицы Order (Foreign Key)
        public int OrderID { get; set; }

        // идентификатор товара (имеет название отличное от сущности Merchandise, чтобы не создавался Foreign Key)
        public int GoodsID { get; set; }

        // количество товара по данной позиции
        public int Quantity { get; set; }

        // комментарий к заказанной позиции (цвет, вид, ...)
        [MaxLength(100)]
        public string Comment { get; set; }

        // заказ в который входит данная позиция товара
        public virtual Order Order { get; set; }
    }
}
