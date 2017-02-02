using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;

namespace Altech.Core.Models
{
    public class Order
    {
        [DatabaseGenerated(DatabaseGeneratedOption.Identity)]
        public int ID { get; set; }
        
        // идентификатор клиента на основе Cookies
        public string CustomerID { get; set; }

        // дата размещения заказа
        public DateTime Created { get; set; }

        // флаг завершения оформления заказа
        public bool Completed { get; set; }

        [MaxLength(100)]
        [DisplayName("Комментарий к заказу")]
        public string Comment { get; set; }

        // детали заказа    
        public virtual ICollection<OrderDetail> Details { get; set; }

        // клиент к которому относится данный заказ
        public virtual Customer Customer { get; set; }
    }
}