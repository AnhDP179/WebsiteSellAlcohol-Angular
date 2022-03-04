using Model;
using System;
using System.Collections.Generic;
using System.Text;

namespace DAL
{
    public interface IThongKeDAL
    {
        List<ChiTietHoaDonModel> GetSanPhamBanChay(int pageIndex, int pageSize, out long total, string wine_name);
        List<ThongKeModel> Search(int pageIndex, int pageSize, out long total, string wine_name);
        string GetSoLuongSanPham(); 
        string GetSoLuongLoaiSP(); 
        string GetSoLuongHoaDon(); 
        string GetSoLuongNguoiDung();
    }
}
