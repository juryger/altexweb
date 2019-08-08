using System.Collections.Generic;
using System.ComponentModel.DataAnnotations.Schema;

namespace Altech.Core.Models
{
    public class Group
    {
        [DatabaseGenerated(DatabaseGeneratedOption.None)]
        public int ID { get; set; }

        // название группы
        public string Title { get; set; }

        public bool IsDeleted { get; set; }

        // подгруппы данной группы
        public virtual ICollection<Subgroup> Subgroups { get; set; }
    }
}