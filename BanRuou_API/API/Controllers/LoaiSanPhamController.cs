using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using BLL;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;
using Microsoft.Extensions.Configuration;
using Model;


namespace API.Controllers
{
    [ApiController]
    [Route("api/loaisanpham")]

    public class LoaiSanPhamController : ControllerBase
    {
        private ILoaiSanPhamBLL _itemServices;
        public LoaiSanPhamController(ILoaiSanPhamBLL itemServices)
        {
            _itemServices = itemServices;
        }

        [Route("create")]
        [HttpPost]
        public LoaiSanPhamModel CreateItem([FromBody] LoaiSanPhamModel model)
        {

            _itemServices.Create(model);
            return model;
        }

        [Route("get-by-id/{id}")]
        [HttpGet]
        public LoaiSanPhamModel GetDatabyID(int id)
        {
            return _itemServices.GetDatabyID(id);
        }

        [Route("get-all")]
        [HttpGet]
        public IEnumerable<LoaiSanPhamModel> GetDatabAll()
        {
            return _itemServices.GetDataAll();
        }

        [Route("update")]
        [HttpPost]
        public LoaiSanPhamModel UpdateItem([FromBody] LoaiSanPhamModel model)
        {
            _itemServices.Update(model);
            return model;
        }


        [Route("delete")]
        [HttpPost]
        public IActionResult DeleteItem([FromBody] LoaiSanPhamModel model)
        {
            _itemServices.Delete(model.id);
            return Ok();
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
                string manufacturer = "";
                if (formData.Keys.Contains("manufacturer") && !string.IsNullOrEmpty(Convert.ToString(formData["manufacturer"]))) { manufacturer = Convert.ToString(formData["manufacturer"]); }
                long total = 0;
                var data = _itemServices.Search(page, pageSize, out total, manufacturer);
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
