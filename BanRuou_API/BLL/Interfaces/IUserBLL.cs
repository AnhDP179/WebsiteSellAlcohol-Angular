using Model;
using System;
using System.Collections.Generic;
using System.Text;
namespace BLL
{
    public partial interface IUserBLL
    {
        UserModel Authenticate(string username, string password);
        UserModel GetDatabyID(int id);
        List<UserModel> GetDataAll();
        bool Create(UserModel model);
        bool Update(UserModel model);
        bool Delete(int id);
        List<UserModel> Search(int pageIndex, int pageSize, out long total, string hoten, string taikhoan);
    }
}
