using App.Common.Classes.DTO;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace App.Domain.Services.Product
{
    public interface IProductService
    {
        Task<IEnumerable<ProductDetailContract>> GetProductDetails();

        string AddProduct(ProductDetailContract request);
    }
}
