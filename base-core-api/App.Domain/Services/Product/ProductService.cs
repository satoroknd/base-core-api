using App.Common.Classes.DTO;
using App.Infrastructure.Repositories.Product;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace App.Domain.Services.Product
{
    public class ProductService : IProductService
    {
        private readonly IProductRepository _productRepository;
        public ProductService(IProductRepository productRepository)
        {
            _productRepository = productRepository;
        }
        public string AddProduct(ProductDetailContract request)
        {
            return _productRepository.AddProductDB(request);
        }

        public Task<IEnumerable<ProductDetailContract>> GetProductDetails()
        {
            return _productRepository.GetProducts();
        }
    }
}
