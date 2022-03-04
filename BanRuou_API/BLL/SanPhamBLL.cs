using DAL;
using Model;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace BLL
{
    public partial class SanPhamBLL : ISanPhamBLL
    {
        private ISanPhamDAL _res;
        public SanPhamBLL(ISanPhamDAL ItemGroupRes)
        {
            _res = ItemGroupRes;
        }
        public bool Create(SanPhamModel model)
        {
            return _res.Create(model);
        }
        public SanPhamModel GetDatabyID(int id)
        {
            return _res.GetDatabyID(id);
        }
        public List<SanPhamModel> GetDataAll()
        {
            return _res.GetDataAll();
        }
        public List<SanPhamModel> Search(int pageIndex, int pageSize, out long total, string wine_name, string alcohol_concentration)
        {
            return _res.Search(pageIndex, pageSize, out total,  wine_name,  alcohol_concentration);
        }
        public List<SanPhamModel> SearchByCate(int pageIndex, int pageSize, out long total, int product_id)
        {
            return _res.SearchByCate(pageIndex, pageSize, out total,  product_id);
        }
        public bool Delete(int id)
        {
            return _res.Delete(id);
        }

        public bool Update(SanPhamModel model)
        {
            return _res.Update(model);
        }

    }
}
