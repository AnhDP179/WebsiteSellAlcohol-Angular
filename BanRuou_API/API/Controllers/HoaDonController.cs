using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using BLL;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;
using Microsoft.Extensions.Configuration;
using Model;

namespace API.Controllers
{
    [Route("api/hoadon")]
    [ApiController]
    public class HoaDonController : ControllerBase
    {
        private IHoaDonBLL _hoaDonBLL;
        public HoaDonController(IHoaDonBLL hoaDonBLL)
        {
            _hoaDonBLL = hoaDonBLL;
        }

        [Route("create")]
        [HttpPost]
        public HoaDonModel CreateItem([FromBody] HoaDonModel model)
        {
            model.MaDonHang = Guid.NewGuid().ToString();
            if (model.listjson_chitiet != null)
            {
                foreach (var item in model.listjson_chitiet)
                    item.ma_chi_tiet = Guid.NewGuid().ToString();
            }
            _hoaDonBLL.Create(model);
            return model;
        }

        [Route("update")]
        [HttpPost]
        public HoaDonModel UpdateItem([FromBody] HoaDonModel model)
        {
            if (model.listjson_chitiet != null)
            {
                foreach (var item in model.listjson_chitiet)
                    if (item.status == 1)
                        item.ma_chi_tiet = Guid.NewGuid().ToString();
            }
            _hoaDonBLL.Update(model);
            return model;
        }

        [Route("get-by-id/{id}")]
        [HttpGet]
        public HoaDonModel GetDatabyID(string id)
        {
            return _hoaDonBLL.GetDatabyID(id);
        }

        [Route("search")]
        [HttpPost]
        public ResponseModel Search([FromBody] Dictionary<string, object> formData)
        {
            var response = new ResponseModel();
            try
            {
                var page = int.Parse(formData["page"].ToString());
                var pageSize = int.Parse(formData["pageSize"].ToString());
                string hoTen = "";
                if (formData.Keys.Contains("hoTen") && !string.IsNullOrEmpty(Convert.ToString(formData["hoTen"]))) { hoTen = Convert.ToString(formData["hoTen"]); }
                string diaChiNhan = "";
                if (formData.Keys.Contains("diaChiNhan") && !string.IsNullOrEmpty(Convert.ToString(formData["diaChiNhan"]))) { diaChiNhan = Convert.ToString(formData["diaChiNhan"]); }
                long total = 0;
                var data = _hoaDonBLL.Search(page, pageSize, out total, hoTen, diaChiNhan);
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

    }
}
