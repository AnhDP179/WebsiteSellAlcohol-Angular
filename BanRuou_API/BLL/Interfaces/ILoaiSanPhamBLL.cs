using Model;
using System;
using System.Collections.Generic;
using System.Text;
namespace BLL
{
    public interface ILoaiSanPhamBLL
    {
        bool Create(LoaiSanPhamModel model);
        LoaiSanPhamModel GetDatabyID(int id);
        List<LoaiSanPhamModel> GetDataAll();
        List<LoaiSanPhamModel> Search(int page, int pageSize, out long total, string manufacturer);
        bool Update(LoaiSanPhamModel model);
        bool Delete(int id);
    }
}
