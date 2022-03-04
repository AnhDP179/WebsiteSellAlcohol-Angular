using Model;
using System;
using System.Collections.Generic;
using System.Text;

namespace DAL
{
    public partial interface ICustomerDAL
    {
        List<CustomerModel> GetDataAll();
       CustomerModel GetCustomer(string username, string password);
        List<CustomerModel> Search(int pageIndex, int pageSize, out long total, string customerName, string email);
        bool Update(CustomerModel model);
        bool Delete(int id);
        CustomerModel GetDatabyID(int id);

        bool Create(CustomerModel model);
    }
}
