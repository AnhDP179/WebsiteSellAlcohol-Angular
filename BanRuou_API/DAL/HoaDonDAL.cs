using DAL.Helper;
using Model;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace DAL
{
    public partial class HoaDonDAL : IHoaDonDAL
    {
        private IDatabaseHelper _dbHelper;
        public HoaDonDAL(IDatabaseHelper dbHelper)
        {
            _dbHelper = dbHelper;
        }

        public bool Create(HoaDonModel model)
        {
            string msgError = "";
            try
            {
                var result = _dbHelper.ExecuteScalarSProcedureWithTransaction(out msgError, "sp_hoa_don_create",
                "@maDonHang", model.MaDonHang,
                "@hoTen", model.HoTen,
                "@diaChiNhan", model.DiaChiNhan,
                "@sdtNhan", model.SDTNhan,
                "@tinhTrang", model.TinhTrang,
                "@tongTien", model.TongTien,
                "@ngayDat", model.NgayDat,
                "@ngayGiao", model.NgayGiao,
                "@note", model.Note,
                "@listjson_chitiet", model.listjson_chitiet != null ? MessageConvert.SerializeObject(model.listjson_chitiet) : null);
                if ((result != null && !string.IsNullOrEmpty(result.ToString())) || !string.IsNullOrEmpty(msgError))
                {
                    throw new Exception(Convert.ToString(result) + msgError);
                }
                return true;
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }

        public bool Update(HoaDonModel model)
        {
            string msgError = "";
            try
            {
                var result = _dbHelper.ExecuteScalarSProcedureWithTransaction(out msgError, "sp_hoa_don_update",
                "@maDonHang", model.MaDonHang,
                "@hoTen", model.HoTen,
                "@diaChiNhan", model.DiaChiNhan,
                "@sdtNhan", model.SDTNhan,
                "@tinhTrang", model.TinhTrang,
                "@tongTien", model.TongTien,
                "@ngayDat", model.NgayDat,
                "@ngayGiao", model.NgayGiao,
                "@note", model.Note,
                "@listjson_chitiet", model.listjson_chitiet != null ? MessageConvert.SerializeObject(model.listjson_chitiet) : null);
                if ((result != null && !string.IsNullOrEmpty(result.ToString())) || !string.IsNullOrEmpty(msgError))
                {
                    throw new Exception(Convert.ToString(result) + msgError);
                }
                return true;
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }



        public HoaDonModel GetDatabyID(string id)
        {
            string msgError = "";
            try
            {
                var dt = _dbHelper.ExecuteSProcedureReturnDataTable(out msgError, "sp_hoa_don_get_by_id",
                     "@maDonHang", id);
                if (!string.IsNullOrEmpty(msgError))
                    throw new Exception(msgError);
                return dt.ConvertTo<HoaDonModel>().FirstOrDefault();
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }

        public List<HoaDonModel> Search(int pageIndex, int pageSize, out long total, string hoTen, string diaChiNhan)
        {
            string msgError = "";
            total = 0;
            try
            {
                var dt = _dbHelper.ExecuteSProcedureReturnDataTable(out msgError, "sp_hoa_don_search",
                    "@page_index", pageIndex,
                    "@page_size", pageSize,
                    "@hoTen", hoTen,
                    "@diaChiNhan", diaChiNhan);
                if (!string.IsNullOrEmpty(msgError))
                    throw new Exception(msgError);
                if (dt.Rows.Count > 0) total = (long)dt.Rows[0]["RecordCount"];
                return dt.ConvertTo<HoaDonModel>().ToList();
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }

    }

}
