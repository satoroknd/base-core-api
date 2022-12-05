using App.Common.Classes.DTO;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace App.Infrastructure.Repositories.Product
{
    public interface IProductRepository
    {
        Task<IEnumerable<ProductDetailContract>> GetProducts();

        string AddProductDB(ProductDetailContract productPrice);
    }
}
