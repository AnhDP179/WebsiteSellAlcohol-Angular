using BLL;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;
using Microsoft.Extensions.Configuration;
using Model;
using API.DTO;
using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Threading.Tasks;
using System.Net.Http.Headers;
using Microsoft.AspNetCore.Hosting;

namespace API.Controllers
{
    [Route("api/sanpham")]
    [ApiController]

    public class SanPhamController : ControllerBase
    {
        private string _path;
        private string _path1;
        private string _userContentFolder;


        private ISanPhamBLL _itemServices;

        public SanPhamController(ISanPhamBLL itemServices, IConfiguration configuration)
        {
            _itemServices = itemServices;
            _path = configuration["AppSettings:PATH"];
            _path1 = configuration["AppSettings:PATH1"];
            //_userContentFolder = Path.Combine(hostingEnvironment.WebRootPath, USER_CONTENT_FOLDER_NAME);


        }

        public string SaveFileFromBase64String(string RelativePathFileName, string dataFromBase64String)
        {
            if (dataFromBase64String.Contains("base64,"))
            {
                dataFromBase64String = dataFromBase64String.Substring(dataFromBase64String.IndexOf("base64,", 0) + 7);
            }
            return WriteFileToAuthAccessFolder(RelativePathFileName, dataFromBase64String);
        }
        public string WriteFileToAuthAccessFolder(string RelativePathFileName, string base64StringData)
        {
            try
            {
                string result = "";
                string serverRootPathFolder = _path;
                string fullPathFile = $@"{serverRootPathFolder}\{RelativePathFileName}";
                string fullPathFolder = System.IO.Path.GetDirectoryName(fullPathFile);
                if (!Directory.Exists(fullPathFolder))
                    Directory.CreateDirectory(fullPathFolder);
                System.IO.File.WriteAllBytes(fullPathFile, Convert.FromBase64String(base64StringData));
                return result;
            }
            catch (Exception ex)
            {
                return ex.Message;
            }
        }
        [Route("upload")]
        [HttpPost, DisableRequestSizeLimit]
        public async Task<IActionResult> Upload(IFormFile file)
        {
            try
            {
                if (file.Length > 0)
                {
                    string filePath = $"{file.FileName}";
                    var fullPath = CreatePathFile(filePath, _path);
                    using (var fileStream = new FileStream(fullPath, FileMode.Create))
                    {
                        await file.CopyToAsync(fileStream);
                    }
                    var fullPath1 = CreatePathFile(filePath, _path1);
                    using (var fileStream = new FileStream(fullPath1, FileMode.Create))
                    {
                        await file.CopyToAsync(fileStream);
                    }
                    return Ok(new { filePath });
                }
                else
                {
                    return BadRequest();
                }
            }
            catch (Exception)
            {
                return StatusCode(500, "Không tìm thây");
            }
        }

        //[NonAction]
        //private string CreatePathFile(string RelativePathFileName, string path)
        //{
        //    try
        //    {
        //        string serverRootPathFolder = path;
        //        string fullPathFile = $@"{serverRootPathFolder}\{RelativePathFileName}";
        //        string fullPathFolder = System.IO.Path.GetDirectoryName(fullPathFile);
        //        if (!Directory.Exists(fullPathFolder))
        //            Directory.CreateDirectory(fullPathFolder);
        //        return fullPathFile;
        //    }
        //    catch (Exception ex)
        //    {
        //        return ex.Message;
        //    }
        //}
        [NonAction]
        private string CreatePathFile(string RelativePathFileName, string path)
        {
            try
            {
                string serverRootPathFolder = path;
                string fullPathFile = $@"{serverRootPathFolder}\{RelativePathFileName}";
                string fullPathFolder = System.IO.Path.GetDirectoryName(fullPathFile);
                if (!Directory.Exists(fullPathFolder))
                    Directory.CreateDirectory(fullPathFolder);
                return fullPathFile;
            }
            catch (Exception ex)
            {
                return ex.Message;
            }
        }
    

        [Route("get-by-id/{id}")]
        [HttpGet]
        public SanPhamModel GetDatabyID(int id)
        {
            return _itemServices.GetDatabyID(id);
        }

        [Route("get-all")]
        [HttpGet]
        public IEnumerable<SanPhamModel> GetDatabAll()
        {
            return _itemServices.GetDataAll();
        }

        [Route("create")]
        [HttpPost]
        public SanPhamModel CreateItem([FromBody] SanPhamModel model)
        {

            _itemServices.Create(model);
            return model;
        }
        [Route("update")]
        [HttpPost]
        public SanPhamModel UpdateItem([FromBody] SanPhamModel model)
        {
            if (model.picture != null)
            {
                var arrData = model.picture.Split(';');
                if (arrData.Length == 3)
                {
                    var savePath = $@"assets/images/{arrData[0]}";
                    model.picture = $"{savePath}";
                    SaveFileFromBase64String(savePath, arrData[2]);
                }
            }
            _itemServices.Update(model);
            return model;
        }
        [Route("delete")]
        [HttpPost]
        public IActionResult DeleteItem([FromBody] SanPhamModel model)
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
                string wine_name = "";
                if (formData.Keys.Contains("wine_name") && !string.IsNullOrEmpty(Convert.ToString(formData["wine_name"]))) { wine_name = Convert.ToString(formData["wine_name"]); }
                string alcohol_concentration = "";
                if (formData.Keys.Contains("alcohol_concentration") && !string.IsNullOrEmpty(Convert.ToString(formData["alcohol_concentration"]))) { alcohol_concentration = Convert.ToString(formData["alcohol_concentration"]); }
                long total = 0;
                var data = _itemServices.Search(page, pageSize, out total, wine_name, alcohol_concentration);
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

        [Route("get-by-cate")]
        [HttpPost]
        public ResponseModel SearchByCate([FromBody] Dictionary<string, int> formData)
        {
            var response = new ResponseModel();
            try
            {
                var page = int.Parse(formData["page"].ToString());
                var pageSize = int.Parse(formData["pageSize"].ToString());
                var product_id = int.Parse(formData["product_id"].ToString());
                //string product_id = "";
                //if (formData.Keys.Contains("product_id") && !string.IsNullOrEmpty(Convert.ToString(formData["product_id"]))) { product_id = Convert.ToString(formData["product_id"]); }
                long total = 0;
                var data = _itemServices.SearchByCate(page, pageSize, out total, product_id);
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
