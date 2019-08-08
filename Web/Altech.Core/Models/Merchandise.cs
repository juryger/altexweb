using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;

namespace Altech.Core.Models
{
    public class Merchandise
    {
        [DatabaseGenerated(DatabaseGeneratedOption.None)]
        public int ID { get; set; }

        // идентификатор подгруппы в которую входит товар (Foreign Key)
        public int SubgroupID { get; set; }

        // название товара
        //////[Index]
        [MaxLength(100)]
        public string Title { get; set; }

        // единицы измерения
        public string UnitMeasure { get; set; }

        // количество товара в упаковке
        public int Pack { get; set; }

        // оптовая стоимость товара с учетом скидки 1
        public double CostWhs1 { get; set; }

        // оптовая стоимость товара с учетом скидки 2
        public double CostWhs2 { get; set; }

        // оптовая стоимость товара с учетом скидки 3
        public double CostWhs3 { get; set; }

        // имя файла с изображением товара
        public string ImageName { get; set; }

        public bool IsDeleted { get; set; }

        // группа в которую входит данный товар
        public virtual Subgroup Subgroup { get; set; }
    }
}