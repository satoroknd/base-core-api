using App.Common.Classes.DTO;
using App.Domain.Services.Product;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;

namespace base_core_api.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
    public class ProductController : ControllerBase
    {
        private IProductService _productService;
        public ProductController(IProductService productService)
        {
            _productService = productService;
        }

        [HttpGet("GetProducts")]
        public async Task<IEnumerable<ProductDetailContract>> GetProducts()
        {
            return await _productService.GetProductDetails();
        }

        [HttpPost("AddProduct")]
        public string AddProduct(ProductDetailContract productDetail)
        {
            return _productService.AddProduct(productDetail);
        }

    }
}
