using DAL.Helper;
using Model;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System;

namespace DAL
{
    public partial class ThongKeDAL : IThongKeDAL
    {
        private IDatabaseHelper _dbHelper;
        public ThongKeDAL(IDatabaseHelper dbHelper)
        {
            _dbHelper = dbHelper;
        }

        public List<ChiTietHoaDonModel> GetSanPhamBanChay(int pageIndex, int pageSize, out long total, string wine_name)
        {
            string msgError = "";
            total = 0;
            try
            {
                var dt = _dbHelper.ExecuteSProcedureReturnDataTable(out msgError, "sp_product_ban_chay",
                    "@page_index", pageIndex,
                    "@page_size", pageSize,
                    "@wine_name", wine_name);
                if (!string.IsNullOrEmpty(msgError))
                    throw new Exception(msgError);
                if (dt.Rows.Count > 0)
                {
                    total = (long)dt.Rows[0]["RecordCount"];
                }

                return dt.ConvertTo<ChiTietHoaDonModel>().ToList();
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }
        public List<ThongKeModel> Search(int pageIndex, int pageSize, out long total, string wine_name)
        {
            string msgError = "";
            total = 0;
            try
            {
                var dt = _dbHelper.ExecuteSProcedureReturnDataTable(out msgError, "sp_product_ban_chay",
                    "@page_index", pageIndex,
                    "@page_size", pageSize,
                    "@wine_name", wine_name);
                if (!string.IsNullOrEmpty(msgError))
                    throw new Exception(msgError);
                if (dt.Rows.Count > 0) total = (long)dt.Rows[0]["RecordCount"];
                return dt.ConvertTo<ThongKeModel>().ToList();
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }
        public string GetSoLuongSanPham()
        {
            string msgError = "";
            try
            {
                var dt = _dbHelper.ExecuteSProcedureReturnDataTable(out msgError, "sp_thongke_soluong_sanpham");
                if (!string.IsNullOrEmpty(msgError))
                    throw new Exception(msgError);
                return dt.Rows[0]["SLSP"].ToString();
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }
        public string GetSoLuongLoaiSP()
        {
            string msgError = "";
            try
            {
                var dt = _dbHelper.ExecuteSProcedureReturnDataTable(out msgError, "sp_thongke_soluong_loaisanpham");
                if (!string.IsNullOrEmpty(msgError))
                    throw new Exception(msgError);
                return dt.Rows[0]["SLLSP"].ToString();
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }
        public string GetSoLuongHoaDon()
        {
            string msgError = "";
            try
            {
                var dt = _dbHelper.ExecuteSProcedureReturnDataTable(out msgError, "sp_thongke_soluong_hoadon");
                if (!string.IsNullOrEmpty(msgError))
                    throw new Exception(msgError);
                return dt.Rows[0]["SLHD"].ToString();
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }
        public string GetSoLuongNguoiDung()
        {
            string msgError = "";
            try
            {
                var dt = _dbHelper.ExecuteSProcedureReturnDataTable(out msgError, "sp_thongke_soluong_nguoidung");
                if (!string.IsNullOrEmpty(msgError))
                    throw new Exception(msgError);
                return dt.Rows[0]["SLND"].ToString();
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }


    }
}
