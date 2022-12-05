using App.Common.Classes.DTO;
using App.Domain.Services.Order;
using Microsoft.AspNetCore.Mvc;

namespace base_core_api.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
    public class OrderController : ControllerBase
    {
        private readonly IOrderService _orderService;

        public OrderController(IOrderService orderService)
        {
            _orderService = orderService;
        }

        [HttpPost("AddOrders")]
        public string AddOrders(List<OrderForSaveContract> details)
        {
            return _orderService.AddOrders(details);
        }

        [HttpGet("GetOrders")]
        public async Task<IEnumerable<OrderContract>> GetOrders()
        {
            return await _orderService.GetOrderDetails();
        }
    }
}
