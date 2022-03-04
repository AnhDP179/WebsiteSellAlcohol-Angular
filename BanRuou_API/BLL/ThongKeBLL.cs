using DAL;
using Microsoft.IdentityModel.Tokens;
using Model;
using System;
using System.Collections.Generic;
using System.IdentityModel.Tokens.Jwt;
using System.Linq;
using System.Security.Claims;
using System.Text;
using Microsoft.Extensions.Configuration;


namespace BLL
{
    public class ThongKeBLL : IThongKeBLL
    {
        private IThongKeDAL _res;
        private string Secret;
        public ThongKeBLL(IThongKeDAL res, IConfiguration configuration)
        {
            Secret = configuration["AppSettings:Secret"];
            _res = res;
        }
        public List<ChiTietHoaDonModel> GetSanPhamBanChay(int pageIndex, int pageSize, out long total, string wine_name)
        {
            return _res.GetSanPhamBanChay(pageIndex, pageSize, out total, wine_name);
        }
        public List<ThongKeModel> Search(int pageIndex, int pageSize, out long total, string wine_name)
        {
            return _res.Search(pageIndex, pageSize, out total, wine_name);
        }

        public string GetSoLuongSanPham()
        {
            return _res.GetSoLuongSanPham();
        }
        public string GetSoLuongLoaiSP()
        {
            return _res.GetSoLuongLoaiSP();
        }
        public string GetSoLuongHoaDon()
        {
            return _res.GetSoLuongHoaDon();
        }
        public string GetSoLuongNguoiDung()
        {
            return _res.GetSoLuongNguoiDung();
        }
    }
}
