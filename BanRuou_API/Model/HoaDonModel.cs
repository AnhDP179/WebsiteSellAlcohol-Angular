using System;
using System.Collections.Generic;

namespace Model
{
    public class HoaDonModel
    {
        public string MaDonHang { get; set; }
        public string HoTen { get; set; }
        public string DiaChiNhan { get; set; }
        public string SDTNhan { get; set; }
        public string TinhTrang { get; set; }
        public string TongTien { get; set; }
        public string NgayDat { get; set; }
        public string NgayGiao { get; set; }
        public string Note { get; set; }

        public List<ChiTietHoaDonModel> listjson_chitiet { get; set; }
    }
}
