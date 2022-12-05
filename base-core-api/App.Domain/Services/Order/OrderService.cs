using App.Common.Classes.DTO;
using App.Infraestructure.Repositories.Order;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace App.Domain.Services.Order
{
    public class OrderService : IOrderService
    {
        private readonly IOrderRepository _orderRepository;
        public OrderService(IOrderRepository orderRepository)
        {
            _orderRepository = orderRepository;
        }

        public string AddOrders(List<OrderForSaveContract> request)
        {
            return _orderRepository.AddOrders(request);
        }

        public async Task<IEnumerable<OrderContract>> GetOrderDetails()
        {
            return await _orderRepository.GetOrders();
        }
    }
}
