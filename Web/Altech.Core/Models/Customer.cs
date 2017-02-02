using System.Collections.Generic;
using System.ComponentModel;
using System.ComponentModel.DataAnnotations.Schema;

namespace Altech.Core.Models
{
    public class Customer
    {
        [DatabaseGenerated(DatabaseGeneratedOption.None)]
        public string ID { get; set; }

        [DisplayName("Компания *")]
        public string Company { get; set; }

        [DisplayName("Контактное лицо")]
        public string ContactName { get; set; }

        [DisplayName("Контактный телефон *")]
        public string PhoneNumber { get; set; }

        [DisplayName("Электронная почта *")]
        public string EmailAddress { get; set; }

        [DisplayName("Юридический адрес")]
        public string Address { get; set; }

        [DisplayName("ИНН")]
        public string INN { get; set; }

        // заказы данного клиента
        public virtual ICollection<Order> Orders { get; set; }
    }
}
