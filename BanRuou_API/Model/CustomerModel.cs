using System;
using System.Collections.Generic;

namespace Model
{
    public class CustomerModel
    {
        public int id { get; set; }
        public string CustomerName { get; set; }
        public DateTime? DateOfBirth { get; set; }
        public string Address { get; set; }
        public string Phone { get; set; }
        public string Email { get; set; }
        public string Password { get; set; }
        public string role { get; set; }
        public string token { get; set; }

    }
}
