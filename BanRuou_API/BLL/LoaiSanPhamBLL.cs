using DAL;
using Model;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace BLL
{
    public partial class LoaiSanPhamBLL : ILoaiSanPhamBLL
    {
        private ILoaiSanPhamDAL _res;
        public LoaiSanPhamBLL(ILoaiSanPhamDAL ItemGroupRes)
        {
            _res = ItemGroupRes;
        }
        public bool Create(LoaiSanPhamModel model)
        {
            return _res.Create(model);
        }
        public LoaiSanPhamModel GetDatabyID(int id)
        {
            return _res.GetDatabyID(id);
        }
        public List<LoaiSanPhamModel> GetDataAll()
        {
            return _res.GetDataAll();
        }
        public List<LoaiSanPhamModel> Search(int page, int pageSize, out long total, string manufacturer)
        {
            return _res.Search(page, pageSize, out total, manufacturer);
        }
        public bool Delete(int id)
        {
            return _res.Delete(id);
        }

        public bool Update(LoaiSanPhamModel model)
        {
            return _res.Update(model);
        }

    }
}
