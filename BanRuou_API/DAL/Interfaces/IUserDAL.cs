using Model;
using System;
using System.Collections.Generic;
using System.Text;

namespace DAL
{
    public interface IUserDAL
    {
        UserModel GetUser(string username, string password);
        List<UserModel> GetDataAll();
        UserModel GetDatabyID(int id);
        bool Create(UserModel model);
        bool Update(UserModel model);
        bool Delete(int id);
        List<UserModel> Search(int pageIndex, int pageSize, out long total, string hoten, string taikhoan);
    }
}
