using App.Common.Classes.DTO;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace App.Infraestructure.Repositories.Order
{
    public interface IOrderRepository
    {
        string AddOrders(List<OrderForSaveContract> request);

        Task<IEnumerable<OrderContract>> GetOrders();
    }
}
