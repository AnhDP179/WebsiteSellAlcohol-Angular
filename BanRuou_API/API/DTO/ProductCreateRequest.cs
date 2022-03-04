using Microsoft.AspNetCore.Http;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;


namespace API.DTO
{
    public class ProductCreateRequest
    {
        public int id { get; set; }
        public int product_id { get; set; }
        public string wine_name { get; set; }
        public int amount { get; set; }
        public int price { get; set; }
        public string alcohol_concentration { get; set; }
        public string capacity { get; set; }
        public IFormFile picture { get; set; }


    }
}
