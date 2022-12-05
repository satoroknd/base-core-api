using App.Common.Classes.DTO;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace App.Domain.Services.Order
{
    public interface IOrderService
    {
        string AddOrders(List<OrderForSaveContract> request);

        Task<IEnumerable<OrderContract>> GetOrderDetails();
    }
}
