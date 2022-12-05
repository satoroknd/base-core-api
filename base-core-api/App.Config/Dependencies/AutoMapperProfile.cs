using AutoMapper;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace App.Config.Dependencies
{
    public class AutoMapperProfile : Profile
    {
        public AutoMapperProfile()
        {
            ///Example Mapping
            //CreateMap<CustomerEntity, CustomerContract>()
            //.ForMember(dest => dest.CustomerID, opt => opt.MapFrom(src => src.CustomerID))
            //.ReverseMap();
        }
    }
}
