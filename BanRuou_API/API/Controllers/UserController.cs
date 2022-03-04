using System;
using System.Collections.Generic;
using System.Drawing;
using System.IO;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using BLL;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;
using Microsoft.Extensions.Configuration;
using Model;


namespace API.Controllers
{
    //[Authorize]
    [ApiController]
    [Route("api/users")]
    public class UsersController : ControllerBase
    {
        private string _path;

        private IUserBLL _itemServices;
        public UsersController(IUserBLL userBLL, IConfiguration configuration)
        {
            _itemServices = userBLL;
            _path = configuration["AppSettings:PATH"];

        }

        [AllowAnonymous]
        [HttpPost("authenticate")]
        public IActionResult Authenticate([FromBody] AuthenticateModel model)
        {
            var user = _itemServices.Authenticate(model.Username, model.Password);

            if (user == null)
                return BadRequest(new { message = "Tài khoản hoặc mật khẩu sai" });

            return Ok(user);
        }

        //[AllowAnonymous]
        //[HttpPost("login")]
        //public IActionResult Login([FromBody] AuthenticateModel model)
        //{
        //    var user = _itemServices.Authenticate(model.Username, model.Password);

        //    if (user == null)
        //        return BadRequest(new { message = "Tài khoản hoặc mật khẩu sai" });
        //    return Ok(new { id = user.id, hoten = user.hoten, taikhoan = user.taikhoan, token = user.token });
        //}
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

        [Route("get-all")]
        [HttpGet]
        public IEnumerable<UserModel> GetDatabAll()
        {
            return _itemServices.GetDataAll();
        }

        [Route("delete-user")]
        [HttpPost]
        public IActionResult DeleteItem([FromBody] UserModel model)
        {
            _itemServices.Delete(model.id);
            return Ok();
        }

        

        [Route("create-user")]
        [HttpPost]
        public UserModel CreateUser([FromBody] UserModel model)
        {
            _itemServices.Create(model);
            return model;
        }

        [Route("update-user")]
        [HttpPost]
        public UserModel UpdateUser([FromBody] UserModel model)
        {
            _itemServices.Update(model);
            return model;
        }

        [Route("get-by-id/{id}")]
        [HttpGet]
        public UserModel GetDatabyID(int id)
        {
            return _itemServices.GetDatabyID(id);
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
                string hoten = "";
                if (formData.Keys.Contains("hoten") && !string.IsNullOrEmpty(Convert.ToString(formData["hoten"]))) { hoten = Convert.ToString(formData["hoten"]); }
                string taikhoan = "";
                if (formData.Keys.Contains("taikhoan") && !string.IsNullOrEmpty(Convert.ToString(formData["taikhoan"]))) { taikhoan = Convert.ToString(formData["taikhoan"]); }
                long total = 0;
                var data = _itemServices.Search(page, pageSize, out total, hoten, taikhoan);
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
