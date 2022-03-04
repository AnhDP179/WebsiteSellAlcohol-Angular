using System;
using System.Collections.Generic;
using System.Text;

namespace Model
{
    public class ThongKeModel
    {
        public int id { get; set; }
        public string wine_name { get; set; }
        public int product_id { get; set; }
        public string manufacturer { get; set; }
        public string picture { get; set; }
        public float GiaBan { get; set; }
        public double SLBC { get; set; }
        public int page_index = 1;
        public int page_size = 5;

    }
}
