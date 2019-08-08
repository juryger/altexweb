using System.Collections.Generic;
using System.ComponentModel.DataAnnotations.Schema;

namespace Altech.Core.Models
{
    public class Subgroup
    {
        [DatabaseGenerated(DatabaseGeneratedOption.None)]
        public int ID { get; set; }

        // идентификатор группы (Foreign Key)
        public int GroupID { get; set; }

        // название подгруппы
        public string Title { get; set; }

        public bool IsDeleted { get; set; }

        // группа в которую входит данная подгруппа
        public virtual Group Group { get; set; }

        // товары подгруппы
        public virtual ICollection<Merchandise> Merchandises { get; set; }
    }
}