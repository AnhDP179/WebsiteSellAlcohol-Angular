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
    [Route("api/customer")]
    [ApiController]
    public class CustomerController : ControllerBase
    {
        private ICustomerBLL _customerBLL;
        public CustomerController(ICustomerBLL customerBLL)
        {
            _customerBLL = customerBLL;
        }

        [Route("create")]
        [HttpPost]
        public CustomerModel CreateItem([FromBody] CustomerModel model)
        {
            _customerBLL.Create(model);
            return model;
        }
        [Route("get-all")]
        [HttpGet]
        public IEnumerable<CustomerModel> GetDatabAll()
        {
            return _customerBLL.GetDataAll();
        }
        [Route("get-by-id/{id}")]
        [HttpGet]
        public CustomerModel GetDatabyID(int id)
        {
            return _customerBLL.GetDatabyID(id);
        }

        [Route("update")]
        [HttpPost]
        public CustomerModel UpdateUser([FromBody] CustomerModel model)
        {
            _customerBLL.Update(model);
            return model;
        }
        [Route("delete")]
        [HttpPost]
        public IActionResult DeleteItem([FromBody] CustomerModel model)
        {
            _customerBLL.Delete(model.id);
            return Ok();
        }
        [AllowAnonymous]
        [HttpPost("authenticate")]
        public IActionResult Authenticate([FromBody] AuthenticateModel model)
        {
            var user = _customerBLL.Authenticate(model.Username, model.Password);

            if (user == null)
                return BadRequest(new { message = "Tài khoản hoặc mật khẩu sai" });

            return Ok(user);
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
                string customerName = "";
                if (formData.Keys.Contains("customerName") && !string.IsNullOrEmpty(Convert.ToString(formData["customerName"]))) { customerName = Convert.ToString(formData["customerName"]); }
                string email = "";
                if (formData.Keys.Contains("email") && !string.IsNullOrEmpty(Convert.ToString(formData["email"]))) { email = Convert.ToString(formData["email"]); }
                long total = 0;
                var data = _customerBLL.Search(page, pageSize, out total, customerName, email);
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
