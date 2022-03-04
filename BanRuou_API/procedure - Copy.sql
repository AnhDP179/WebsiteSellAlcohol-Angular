
CREATE PROCEDURE [dbo].[sp_sanPham_search] (@page_index  INT, 
                                       @page_size   INT,
									   @MaLoai int)
AS
    BEGIN
        DECLARE @RecordCount BIGINT;
        IF(@page_size <> 0)
            BEGIN
                SET NOCOUNT ON;
                        SELECT(ROW_NUMBER() OVER(
                              ORDER BY TenSP ASC)) AS RowNumber, 
                              i.MaSP, 
                              i.MaLoai, 
                              i.TenSP , 
                              i.HinhAnh, 
                              i.DonGia,
							  i.KichThuoc,
							  i.SoLuong,i.MauSac
                        INTO #Results1
                        FROM [sanPham] AS i
					    WHERE i.MaLoai = @MaLoai;                   
                        SELECT @RecordCount = COUNT(*)
                        FROM #Results1;
                        SELECT *, 
                               @RecordCount AS RecordCount
                        FROM #Results1
                        WHERE ROWNUMBER BETWEEN(@page_index - 1) * @page_size + 1 AND(((@page_index - 1) * @page_size + 1) + @page_size) - 1
                              OR @page_index = -1;
                        DROP TABLE #Results1; 
            END;
            ELSE
            BEGIN
                SET NOCOUNT ON;
                         SELECT(ROW_NUMBER() OVER(
                               ORDER BY TenSP ASC)) AS RowNumber, 
                              i.MaSP, 
                              i.MaLoai, 
                              i.TenSP , 
                              i.HinhAnh, 
                              i.DonGia,
							  i.KichThuoc,
							  i.SoLuong,i.MauSac
                        INTO #Results2
                        FROM [sanPham] AS i
						WHERE i.MaLoai = @MaLoai;  
                        SELECT @RecordCount = COUNT(*)
                        FROM #Results2;
                        SELECT *, 
                               @RecordCount AS RecordCount
                        FROM #Results2;
                        DROP TABLE #Results2;
        END;
    END;
GO

 
CREATE PROCEDURE [dbo].[sp_sanPham_get_by_id](@MaSP VARCHAR(50))
AS
    BEGIN
        SELECT *                      
        FROM SanPham
      where  SanPham.MaSP = @MaSP;
    END;
GO

create PROCEDURE [dbo].[sp_sanPham_create]
(@MaLoai  int, 
 @TenSP    nvarchar(50), 
 @SoLuong     int, 
 @DonGia    int  ,
 @MauSac nvarchar(10),
 @KichThuoc nvarchar(10),
 @HinhAnh nvarchar(255)
)
AS
    BEGIN
      INSERT INTO SanPham
                (MaLoai, 
                 TenSP, 
                 SoLuong, 
                 DonGia,MauSac,KichThuoc,HinhAnh                 
                )
                VALUES
                (@MaLoai, 
                 @TenSP, 
                 @SoLuong, 
                 @DonGia, @MauSac,@KichThuoc,@HinhAnh
                );
        SELECT '';
    END;
GO
create PROCEDURE [dbo].[sp_sanPham_all]
AS
    BEGIN
        SELECT *                        
        FROM SanPham 
    END;
GO

create PROCEDURE [dbo].[sp_sanPham_delete]
(@MaSP   int
)
AS
    BEGIN
		delete from sanPham where MaSP = @MaSP;
        SELECT '';
    END;
GO

CREATE PROCEDURE [dbo].[sp_sanPham_update]
(@MaSP      int, 
 @MaLoai  int, 
 @TenSP    nvarchar(50), 
 @SoLuong     int, 
 @DonGia    int  ,
 @MauSac nvarchar(10),
 @KichThuoc nvarchar(10),
 @HinhAnh nvarchar(255)
)
AS
    BEGIN
   update SanPham set 				       
				MaLoai= @MaLoai          ,
				TenSP= @TenSP           ,
				SoLuong= @SoLuong           ,
				DonGia= @DonGia   ,
				MauSac=@MauSac,
				KichThuoc=@KichThuoc,
				HinhAnh=@HinhAnh
				where MaSP = @MaSP;
			 
        SELECT '';
    END;
GO

----------------------------------------------loaisp------------------------------------------------------
create PROCEDURE [dbo].[sp_loaiSanPham_all]
AS
    BEGIN
        SELECT *                        
        FROM LoaiSanPham 
    END;
	Go
create PROCEDURE [dbo].[sp_LoaiSanPham_create]
(@TenLoai nvarchar(50),
@MoTa ntext
)
AS
    BEGIN
      INSERT INTO LoaiSanPham
                (TenLoai, 
                 MoTa 
                                
                )
                VALUES
                (@TenLoai, 
                 @MoTa
                );
        SELECT '';
    END;
GO

CREATE PROCEDURE [dbo].[loaiSanPham_update]
(@MaLoai int,
 @TenLoai  nvarchar(50),
 @MoTa ntext
 
)
AS
    BEGIN
   update LoaiSanPham set 
   
				TenLoai= @TenLoai        ,
				MoTa= @MoTa         
				where MaLoai = @MaLoai;
			 
        SELECT '';
    END;
GO
create PROCEDURE [dbo].[sp_loaiSanPham_delete]
(@MaLoai             int 
)
AS
    BEGIN
		delete from LoaiSanPham where MaLoai = @MaLoai;
        SELECT '';
    END;
GO
----------------------------------------------customer------------------------------------------------------
create PROCEDURE [dbo].[sp_KhachHang_all]
AS
    BEGIN
        SELECT *                        
        FROM KhachHang
    END;
	Go
create PROCEDURE [dbo].[sp_KhachHang_create]
(@HoTen nvarchar(50),
@DiaChi nvarchar(50),
@Email nvarchar(50),
@SDT char(10)
)
AS
    BEGIN
      INSERT INTO KhachHang
                (HoTen, DiaChi,Email,SDT)
                VALUES
                (@HoTen, @DiaChi, @Email,@SDT);
        SELECT '';
    END;
GO

CREATE PROCEDURE [dbo].[KhachHang_update]
(@MaKH int,
 @HoTen  nvarchar(50),
 @DiaChi  nvarchar(50),
 @Email nvarchar(50),
 @SDT char(10)
 
)
AS
    BEGIN
   update KhachHang set 
   
				HoTen= @HoTen       ,
				DiaChi=@DiaChi ,
				Email=@Email,
				SDT=@SDT
				where MaKH = @MaKH;
			 
        SELECT '';
    END;
GO
create PROCEDURE [dbo].[sp_KhachHang_delete]
(@MaKH             int 
)
AS
    BEGIN
		delete from KhachHang where MaKH = @MaKH;
        SELECT '';
    END;
GO
----------------------------------------------hoadon------------------------------------------------------
CREATE PROCEDURE [dbo].[sp_hoa_don_create]
(@MaHDB             int, 
 @ho_ten          NVARCHAR(150), 
 @dia_chi          NVARCHAR(250),  
 @listjson_chitiet NVARCHAR(MAX)
)
AS
    BEGIN
        INSERT INTO hoa_don
                (ma_hoa_don, 
                 ho_ten, 
                 dia_chi               
                )
                VALUES
                (@ma_hoa_don, 
                 @ho_ten, 
                 @dia_chi
                );
                IF(@listjson_chitiet IS NOT NULL)
                    BEGIN
                        INSERT INTO chi_tiet_hoa_don
                        (ma_chi_tiet, 
                         ma_hoa_don, 
                         item_id, 
                         so_luong                       
                        )
                               SELECT JSON_VALUE(p.value, '$.ma_chi_tiet'), 
                                      @ma_hoa_don, 
                                      JSON_VALUE(p.value, '$.item_id'), 
                                      JSON_VALUE(p.value, '$.so_luong')    
                               FROM OPENJSON(@listjson_chitiet) AS p;
                END;
        SELECT '';
    END;
GO
----------------------------------------------chitiethoadon------------------------------------------------------

