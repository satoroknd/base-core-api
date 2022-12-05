using App.Common.Classes.DTO;
using App.Infrastructure.Database.Context;
using App.Infrastructure.Helpers;
using App.Infrastructure.Procedures;
using Microsoft.Extensions.Configuration;
using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace App.Infrastructure.Repositories.Product
{
    public class ProductRepository : IProductRepository
    {
        private readonly ApplicationContext _context;
        private readonly IConfiguration _configuration;

        public ProductRepository(ApplicationContext context, IConfiguration configuration)
        {
            _context = context;
            _configuration = configuration;
        }

        public string AddProductDB(ProductDetailContract request)
        {
            var cnn = _configuration.GetConnectionString("DefaultConnection");

            var parameters = new[] {
                new SqlParameter("@name", request.ProductCode ?? (object)DBNull.Value),
                new SqlParameter("@lastName", request.ProductDescription ?? (object)DBNull.Value),
                new SqlParameter("@address", request.UnitValue )
            };

            string param = HelperDatabase.PrepareParameters(parameters.ToList());
            StoredProcedures.Execute($"exec Add_Products {param}", connectionString: cnn);
            return "OK";
        }

        public async Task<IEnumerable<ProductDetailContract>> GetProducts()
        {
            var cnn = _configuration.GetConnectionString("DefaultConnection");
            var details = StoredProcedures.Execute($"exec Get_Products ", connectionString: cnn)
                .Select(s => new
                {
                    ProductID = (int)s.ProductID,
                    ProductCode = (string)s.ProductCode,
                    ProductDescription = (string)s.ProductDescription,
                    UnitValue = (decimal)s.UnitValue
                }).ToList();
            var result = details.Select(p => new ProductDetailContract()
            {
                ProductID = p.ProductID,
                ProductCode = p.ProductCode,
                ProductDescription = p.ProductDescription,
                UnitValue = p.UnitValue
            }).ToList();
            return result;
        }
    }
}
