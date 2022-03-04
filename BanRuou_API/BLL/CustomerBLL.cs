using DAL;
using Microsoft.IdentityModel.Tokens;
using Model;
using System;
using DAL.Helper;
using System.Collections.Generic;
using System.IdentityModel.Tokens.Jwt;
using System.Linq;
using System.Security.Claims;
using System.Text;
using Microsoft.Extensions.Configuration;

namespace BLL
{
    public partial class CustomerBLL : ICustomerBLL
    {
        private ICustomerDAL _res;
        private string Secret;
        public CustomerBLL(ICustomerDAL res, IConfiguration configuration)
        {
            Secret = configuration["AppSettings:Secret"];
            _res = res;
        }
        public CustomerModel Authenticate(string username, string password)
        {
            var user = _res.GetCustomer(username, password);
            // return null if user not found
            if (user == null)
                return null;

            // authentication successful so generate jwt token
            var tokenHandler = new JwtSecurityTokenHandler();
            var key = Encoding.ASCII.GetBytes(Secret);
            var tokenDescriptor = new SecurityTokenDescriptor
            {
                Subject = new ClaimsIdentity(new Claim[]
                {
                    new Claim(ClaimTypes.Name, user.CustomerName.ToString()),
                    new Claim(ClaimTypes.StreetAddress, user.Address)
                }),
                Expires = DateTime.UtcNow.AddDays(7),
                SigningCredentials = new SigningCredentials(new SymmetricSecurityKey(key), SecurityAlgorithms.HmacSha256Signature)
            };
            var token = tokenHandler.CreateToken(tokenDescriptor);
            user.token = tokenHandler.WriteToken(token);

            return user;

        }
        public CustomerModel GetDatabyID(int id)
        {
            return _res.GetDatabyID(id);
        }

        public bool Create(CustomerModel model)
        {
            return _res.Create(model);
        }
        public List<CustomerModel> GetDataAll()
        {
            return _res.GetDataAll();
        }
        public List<CustomerModel> Search(int pageIndex, int pageSize, out long total, string customerName, string email)
        {
            return _res.Search(pageIndex, pageSize, out total, customerName, email);
        }
        public bool Delete(int id)
        {
            return _res.Delete(id);
        }
        public bool Update(CustomerModel model)
        {
            return _res.Update(model);
        }

    }

}
