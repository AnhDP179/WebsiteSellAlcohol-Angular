using System;
using System.Collections.Generic;
using System.Text;

namespace Model
{
    public class SanPhamModel
    {
        public int id{ get; set; }
        public int product_id { get; set; }
        public string wine_name { get; set; }
        public int amount { get; set; }
        public int price { get; set; }
        public string alcohol_concentration { get; set; }
        public string capacity { get; set; }
        public string picture { get; set; }


    }
}
