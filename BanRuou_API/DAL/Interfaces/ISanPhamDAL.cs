using Model;
using System;
using System.Collections.Generic;
using System.Text;

namespace DAL
{
    public interface ISanPhamDAL
    {
        bool Create(SanPhamModel model);
        SanPhamModel GetDatabyID(int id);
        List<SanPhamModel> GetDataAll();
        List<SanPhamModel> Search(int pageIndex, int pageSize, out long total, string wine_name, string alcohol_concentration);
        List<SanPhamModel> SearchByCate(int pageIndex, int pageSize, out long total, int product_id);

        bool Update(SanPhamModel model);
        bool Delete(int id);
    }
}
