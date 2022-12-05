using App.Common.Classes.DTO;
using App.Infrastructure.Database.Context;
using App.Infrastructure.Procedures;
using Microsoft.Extensions.Configuration;
using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace App.Infraestructure.Repositories.Order
{
    public class OrderRepository : IOrderRepository
    {
        private readonly ApplicationContext _context;
        private readonly IConfiguration _configuration;

        public OrderRepository(ApplicationContext context, IConfiguration configuration)
        {
            _configuration = configuration;
            _context = context;
        }

        public string AddOrders(List<OrderForSaveContract> request)
        {
            var cnn = _configuration.GetConnectionString("DefaultConnection");

            var parameters = new[] {
                new SqlParameter("@details", request ?? (object)DBNull.Value)
            };
            //No Dynamic
            StoredProcedures.ExecuteListParams(request, connectionString: cnn);
            return "ok";
        }

        public async Task<IEnumerable<OrderContract>> GetOrders()
        {
            var cnn = _configuration.GetConnectionString("DefaultConnection");
            var details = StoredProcedures.Execute($"exec Get_Orders ", connectionString: cnn)
                .Select(s => new
                {
                    OrderID = (int)s.OrderID,
                    ProductCode = (string)s.ProductCode,
                    ProductDescription = (string)s.ProductDescription,
                    Quantity = (int)s.Quantity,
                    UnitValue = (decimal)s.UnitValue,
                    CustomerDNI = (string)s.CustomerDNI,
                    CustomerAddress = (string)s.CustomerAddress,
                }).ToList();

            var result = details.Select(p => new OrderContract()
            {
                OrderID = p.OrderID,
                ProductCode = p.ProductCode,
                ProductDescription = p.ProductDescription,
                Quantity = p.Quantity,
                UnitValue = p.UnitValue,
                CustomerDNI = p.CustomerDNI,
                CustomerAddress = p.CustomerAddress
            }).ToList();

            return result;
        }
    }
}
