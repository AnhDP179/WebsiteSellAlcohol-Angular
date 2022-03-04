using Model;
using System;
using System.Collections.Generic;
using System.Text;

namespace DAL
{
    public partial interface IHoaDonDAL
    {
        bool Create(HoaDonModel model);
        bool Update(HoaDonModel model);
        HoaDonModel GetDatabyID(string id);
        List<HoaDonModel> Search(int pageIndex, int pageSize, out long total, string hoTen, string diaChiNhan);
    }
}
