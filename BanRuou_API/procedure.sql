
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
							  i.DungTich,
							  i.SoLuong,i.NongDoCon
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
							  i.DungTich,
							  i.SoLuong,i.NongDoCon
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
 @NongDoCon nvarchar(10),
 @DungTich nvarchar(10),
 @HinhAnh nvarchar(255)
)
AS
    BEGIN
      INSERT INTO SanPham
                (MaLoai, 
                 TenSP, 
                 SoLuong, 
                 DonGia,NongDoCon,DungTich,HinhAnh                 
                )
                VALUES
                (@MaLoai, 
                 @TenSP, 
                 @SoLuong, 
                 @DonGia, @NongDoCon,@DungTich,@HinhAnh
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
 @NongDoCon nvarchar(10),
 @DungTich nvarchar(10),
 @HinhAnh nvarchar(255)
)
AS
    BEGIN
   update SanPham set 				       
				MaLoai= @MaLoai          ,
				TenSP= @TenSP           ,
				SoLuong= @SoLuong           ,
				DonGia= @DonGia   ,
				NongDoCon = @NongDoCon,
				DungTich=@DungTich,
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

CREATE PROCEDURE [dbo].[sp_loaiSanPham_get_by_id](@MaLoai int)
AS
    BEGIN
        SELECT LoaiSanPham.MaLoai,LoaiSanPham.TenLoai,LoaiSanPham.MoTa                    
        FROM LoaiSanPham
      where  LoaiSanPham.MaLoai = @MaLoai;
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
CREATE PROCEDURE [dbo].[sp_HoaDon_create]
(@MaHDB  int,
 @MaKH            int, 
 @NgayTao          datetime, 
 @listjson_chitiet NVARCHAR(MAX)
)
AS
    BEGIN
        INSERT INTO HoaDonBan
                (MaHDB,
				 MaKH,
                 NgayTao
                )
                VALUES
                (@MaHDB,
				 @MaKH, 
                 @NgayTao
                );
                IF(@listjson_chitiet IS NOT NULL)
                    BEGIN
                        INSERT INTO ChiTietHDB
                        (MaCT, 
                         MaHDB, 
                         MaSP, 
                         SoLuong,
						 DonGia
                        )
                               SELECT JSON_VALUE(p.value, '$.MaCT'), 
                                      @MaHDB, 
									  JSON_VALUE(p.value, '$.MaSP'),
                                      JSON_VALUE(p.value, '$.SoLuong'), 
                                      JSON_VALUE(p.value, '$.DonGia')    
                               FROM OPENJSON(@listjson_chitiet) AS p;
                END;
        SELECT '';
    END;
GO
----------------------------------------------chitiethoadon------------------------------------------------------

----------------------------------------------user------------------------------------------------------
CREATE PROCEDURE [dbo].[sp_user_create]
(
 @hoten          nvarchar(150) ,
 @ngaysinh         date  ,
 @diachi          nvarchar(250)  ,
 @gioitinh         nvarchar(30)  ,
 @email          varchar(150) ,
 @taikhoan         varchar(30) ,
 @matkhau         varchar(60)  ,
 @role          varchar(30) 
)
AS
    BEGIN
      INSERT INTO [user]
                (
					 hoten           ,
					 ngaysinh          ,
					 diachi           ,
					 gioitinh           ,
					 email           ,
					 taikhoan         ,
					 matkhau           ,
					 role    
				)
                VALUES
                (
				 @hoten           ,
				 @ngaysinh          ,
				 @diachi           ,
				 @gioitinh           ,
				 @email           ,
				 @taikhoan         ,
				 @matkhau           ,
				 @role 
				);
        SELECT '';
    END;
GO
create PROCEDURE [dbo].[sp_user_all]
AS
    BEGIN
        SELECT *                        
        FROM [user]
    END;
GO
create PROCEDURE [dbo].[sp_user_delete]
(@ID              INT 
)
AS
    BEGIN
		delete from [user] where ID = @ID;
        SELECT '';
    END;
GO

CREATE PROCEDURE [dbo].[sp_user_get_by_id](@ID VARCHAR(50))
AS
    BEGIN
        SELECT  [ID]               , 
					 hoten           ,
					 ngaysinh          ,
					 diachi           ,
					 gioitinh           ,
					 email           ,
					 taikhoan         ,
					 matkhau           ,
					 role      
        FROM [user]
      where  [ID] = @ID;
    END;
GO

CREATE PROCEDURE [dbo].[sp_user_get_by_username_password](@taikhoan varchar(30), @matkhau varchar(60))
AS
    BEGIN
        SELECT  [ID]               , 
					 hoten           ,
					 ngaysinh          ,
					 diachi           ,
					 gioitinh           ,
					 email           ,
					 taikhoan         ,
					 role      
        FROM [user]
      where  taikhoan = @taikhoan and matkhau = @matkhau ;
    END;
GO

CREATE PROCEDURE [dbo].[sp_user_search] (@page_index  INT, 
                                       @page_size   INT,
									   @hoten nvarchar(150),
									    @taikhoan varchar(30)
									   )
AS
    BEGIN
        DECLARE @RecordCount BIGINT;
        IF(@page_size <> 0)
            BEGIN
                SET NOCOUNT ON;
                        SELECT(ROW_NUMBER() OVER(
                              ORDER BY u.hoten ASC)) AS RowNumber, 
                             u.ID              , 
							 u.hoten           ,
							 u.ngaysinh          ,
							 u.diachi           ,
							 u.gioitinh           ,
							 u.email           ,
							 u.taikhoan         ,
							 u.matkhau           ,
							 u.role  
                        INTO #Results1
                        FROM [user] AS u
						WHERE (u.taikhoan <> 'Admin') and ((@hoten = '') OR (u.hoten LIKE '%' + @hoten + '%')) and  ((@taikhoan = '') OR (u.taikhoan = @taikhoan));
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
                              ORDER BY u.hoten ASC)) AS RowNumber, 
                             u.ID              , 
							 u.hoten           ,
							 u.ngaysinh          ,
							 u.diachi           ,
							 u.gioitinh           ,
							 u.email           ,
							 u.taikhoan         ,
							 u.matkhau           ,
							 u.role       
                        INTO #Results2
                        FROM [user] AS u
						WHERE (u.taikhoan <> 'Admin') and ((@hoten = '') OR (u.hoten LIKE '%' + @hoten + '%')) and  ((@taikhoan = '') OR (u.taikhoan = @taikhoan));
                        SELECT @RecordCount = COUNT(*)
                        FROM #Results2;
                        SELECT *, 
                               @RecordCount AS RecordCount
                        FROM #Results2;
                        DROP TABLE #Results2;
        END;
    END;
GO

CREATE PROCEDURE [dbo].[sp_user_update]
(@ID              varchar(50), 
 @hoten          nvarchar(150) ,
 @ngaysinh         date  ,
 @diachi          nvarchar(250)  ,
 @gioitinh         nvarchar(30)  ,
 @email          varchar(150) ,
 @taikhoan         varchar(30) ,
 @matkhau         varchar(60)  ,
 @role          varchar(30)
)
AS
    BEGIN
   update [user] set 
				hoten= @hoten           ,
				ngaysinh= @ngaysinh          ,
				diachi= @diachi           ,
				gioitinh= @gioitinh           ,
				email= @email           ,
				matkhau = @matkhau           ,
				role= @role 
				where ID = @ID;
			 
        SELECT '';
    END;
GO