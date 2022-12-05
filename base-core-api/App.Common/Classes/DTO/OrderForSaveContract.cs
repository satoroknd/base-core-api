using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace App.Common.Classes.DTO
{
    public class OrderForSaveContract
    {
        public int ProductID { get; set; }
        public string ProductCode { get; set; }
        public string ProductDescription { get; set; }
        public int Quantity { get; set; }
        public int UnitValue { get; set; }
        public string CustomerDNI { get; set; }

        public string CustomerAddress { get; set; }
    }
}
