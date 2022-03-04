using DAL;
using Model;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace BLL
{
    public partial class HoaDonBLL : IHoaDonBLL
    {
        private IHoaDonDAL _res;
        public HoaDonBLL(IHoaDonDAL res)
        {
            _res = res;
        }
        public bool Create(HoaDonModel model)
        {
            return _res.Create(model);
        }
        public bool Update(HoaDonModel model)
        {
            return _res.Update(model);
        }
        public HoaDonModel GetDatabyID(string id)
        {
            return _res.GetDatabyID(id);
        }
        public List<HoaDonModel> Search(int pageIndex, int pageSize, out long total, string hoTen, string diaChiNhan)
        {
            return _res.Search(pageIndex, pageSize, out total, hoTen, diaChiNhan);
        }
    }

}
