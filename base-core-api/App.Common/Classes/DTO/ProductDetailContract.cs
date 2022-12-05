using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace App.Common.Classes.DTO
{
    public class ProductDetailContract
    {
        public int ProductID { get; set; }
        public string ProductCode { get; set; }
        public string ProductDescription { get; set; }
        public decimal UnitValue { get; set; }
    }
}
