using BLL;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;
using Microsoft.Extensions.Configuration;
using Model;
using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Threading.Tasks;

// For more information on enabling Web API for empty projects, visit https://go.microsoft.com/fwlink/?LinkID=397860

namespace API.Controllers
{
    [Authorize]
    [Route("api/thongke")]
    [ApiController]
    public class ThongKeController : ControllerBase
    {
        private IThongKeBLL _spBusiness;
        private string _path;
        public ThongKeController(IThongKeBLL newBusiness, IConfiguration configuration)
        {
            _spBusiness = newBusiness;
            _path = configuration["AppSettings:PATH"];
        }

        [Route("get-sanpham-banchay")]
        [HttpPost]
        public ResponseModel GetSanPhamBanChay([FromBody] Dictionary<string, object> formData)
        {
            var response = new ResponseModel();
            try
            {
                var page = int.Parse(formData["page"].ToString());
                var pageSize = int.Parse(formData["pageSize"].ToString());
                string wine_name = "";
                if (formData.Keys.Contains("wine_name") && !string.IsNullOrEmpty(Convert.ToString(formData["wine_name"]))) { wine_name = Convert.ToString(formData["wine_name"]); }
                long total = 0;
                var data = _spBusiness.GetSanPhamBanChay(page, pageSize, out total, wine_name);
                response.TotalItems = total;
                response.Data = data;
                response.Page = page;
                response.PageSize = pageSize;
            }
            catch (Exception ex)
            {
                throw new Exception(ex.Message);
            }
            return response;
        }

        [Route("get-soluong-sanpham")]
        [HttpGet]
        public string GetSoLuongSanPham()
        {
            return _spBusiness.GetSoLuongSanPham();
        }

        [Route("get-soluong-loaisanpham")]
        [HttpGet]
        public string GetSoLuongLoaiSP()
        {
            return _spBusiness.GetSoLuongLoaiSP();
        }

        [Route("get-soluong-hoadon")]
        [HttpGet]
        public string GetSoLuongHoaDon()
        {
            return _spBusiness.GetSoLuongHoaDon();
        }

        [Route("get-soluong-nguoidung")]
        [HttpGet]
        public string GetSoLuongNguoiDung()
        {
            return _spBusiness.GetSoLuongNguoiDung();
        }

    }
}
