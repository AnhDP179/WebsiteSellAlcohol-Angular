--lo?i s?n ph?m
create PROCEDURE [dbo].[sp_products_all]
AS
    BEGIN
        SELECT *                        
        FROM products
    END;
GO

create PROCEDURE [dbo].[sp_products_create]
(@manufacturer   ntext, 
 @_description   ntext
)
AS
    BEGIN
      INSERT INTO products
                (manufacturer  ,
				_description
                )
                VALUES
                (@manufacturer, 
                 @_description
                );
        SELECT '';
    END;
GO
--
create PROCEDURE [dbo].[sp_products_get_by_id](@id VARCHAR(50))
AS
    BEGIN
        SELECT  [id]               , 
					 manufacturer           ,
					 _description          
        FROM [products]
      where  [id] = @id;
    END;
--
create PROCEDURE [dbo].[sp_products_search] (@page_index  INT, 
                                       @page_size   INT,
									   @manufacturer nvarchar(250))
AS
    BEGIN
        DECLARE @RecordCount BIGINT;
        IF(@page_size <> 0)
            BEGIN
                SET NOCOUNT ON;
                        SELECT(ROW_NUMBER() OVER(
                              ORDER BY i.manufacturer ASC)) AS RowNumber, 
                              i.id,  
                              i.manufacturer , 
                              i._description
                        INTO #Results1
                        FROM [products] AS i
					    WHERE ((@manufacturer = '') OR (i.manufacturer LIKE '%' + @manufacturer + '%'));                   
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
                               ORDER BY i.manufacturer ASC)) AS RowNumber, 
                              i.id, 
                              i.manufacturer, 
                              i._description 
                        INTO #Results2
                        FROM [products] AS i
						WHERE ((@manufacturer = '') OR (i.manufacturer LIKE '%' + @manufacturer + '%'));  
                        SELECT @RecordCount = COUNT(*)
                        FROM #Results2;
                        SELECT *, 
                               @RecordCount AS RecordCount
                        FROM #Results2;
                        DROP TABLE #Results2;
        END;
    END;

create PROCEDURE [dbo].[sp_products_delete]
(@id   int
)
AS
    BEGIN
		delete from products where id = @id;
        SELECT '';
    END;
GO
ALTER TABLE products
DROP COLUMN _description nvarchar(250)

alter table products drop constraint [DF__products__update__5535A963];

ALTER TABLE products
DROP COLUMN updated_at;


CREATE PROCEDURE [dbo].[sp_products_update]
(@id     int, 
 @manufacturer   ntext, 
 @_description   ntext
)
AS
    BEGIN
   update products set 				       
				manufacturer = @manufacturer ,
				_description = @_description
				where id = @id;
			 
        SELECT '';
    END;
GO
-- s?n ph?m

create PROCEDURE [dbo].[sp_product_singles_get_by_cate] (@page_index  INT, 
                                       @page_size   INT,
									   @product_id int
									   )
AS
    BEGIN
        DECLARE @RecordCount BIGINT;
        IF(@page_size <> 0)
            BEGIN
                SET NOCOUNT ON;
                        SELECT(ROW_NUMBER() OVER(
                              ORDER BY wine_name ASC)) AS RowNumber, 
                              i.id, 
                              i.product_id, 
                              i.wine_name , 
                              i.picture, 
                              i.price,
							  i.capacity,
							  i.amount,
							  i.alcohol_concentration
                        INTO #Results1
                        FROM [product_singles] AS i
					    WHERE  ((@product_id = '') OR (i.product_id LIKE '%' + @product_id + '%'));                   
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
                               ORDER BY wine_name ASC)) AS RowNumber, 
                              i.id, 
                              i.product_id, 
                              i.wine_name , 
                              i.picture, 
                              i.price,
							  i.capacity,
							  i.amount,
							  i.alcohol_concentration
                        INTO #Results2
                        FROM [product_singles] AS i
					    WHERE  ((@product_id = '') OR (i.product_id LIKE '%' + @product_id + '%'));                   
                        SELECT @RecordCount = COUNT(*)
                        FROM #Results2;
                        SELECT *, 
                               @RecordCount AS RecordCount
                        FROM #Results2;
                        DROP TABLE #Results2;
        END;
    END;


create PROCEDURE [dbo].[sp_product_singles_all]
AS
    BEGIN
        SELECT *                        
        FROM product_singles
    END;
GO

CREATE PROCEDURE [dbo].[sp_product_singles_search] (@page_index  INT, 
                                       @page_size   INT,
									   @id int,
									   @product_id int)
AS
    BEGIN
        DECLARE @RecordCount BIGINT;
        IF(@page_size <> 0)
            BEGIN
                SET NOCOUNT ON;
                        SELECT(ROW_NUMBER() OVER(
                              ORDER BY wine_name ASC)) AS RowNumber, 
                              i.id, 
                              i.product_id, 
                              i.wine_name , 
                              i.picture, 
                              i.price,
							  i.capacity,
							  i.amount,
							  i.alcohol_concentration
                        INTO #Results1
                        FROM [product_singles] AS i
					    WHERE i.product_id = @product_id;                   
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
                               ORDER BY wine_name ASC)) AS RowNumber, 
                              i.id, 
                              i.product_id, 
                              i.wine_name , 
                              i.picture, 
                              i.price,
							  i.capacity,
							  i.amount,
							  i.alcohol_concentration
                        INTO #Results2
                        FROM [product_singles] AS i
						WHERE i.product_id = @product_id;  
                        SELECT @RecordCount = COUNT(*)
                        FROM #Results2;
                        SELECT *, 
                               @RecordCount AS RecordCount
                        FROM #Results2;
                        DROP TABLE #Results2;
        END;
    END;
GO

CREATE PROCEDURE [dbo].[sp_product_singles_get_by_id](@id int)
AS
    BEGIN
        SELECT *                      
        FROM product_singles
      where product_singles.id = @id;
    END;
GO

create PROCEDURE [dbo].[sp_product_singles_create]
(@product_id  int, 
 @wine_name    varchar(255), 
 @amount    int, 
 @price  float  ,
 @alcohol_concentration varchar(255),
 @capacity varchar(255),
 @picture varchar(255)
)
AS
    BEGIN
      INSERT INTO product_singles
                (product_id, 
                 wine_name , 
                 amount , 
                 price,
				 alcohol_concentration,
				 capacity,
				 picture                 
                )
                VALUES
                (@product_id, 
                 @wine_name, 
                 @amount, 
                 @price,
				 @alcohol_concentration,
				 @capacity,
				 @picture
                );
        SELECT '';
    END;
GO
create PROCEDURE [dbo].[sp_product_singles_delete]
(@id   int
)
AS
    BEGIN
		delete from product_singles where id = @id;
        SELECT '';
    END;
GO

CREATE PROCEDURE [dbo].[sp_product_singles_update]
(@id     int, 
 @product_id  int, 
 @wine_name    varchar(255), 
 @amount    int, 
 @price  float  ,
 @alcohol_concentration varchar(255),
 @capacity varchar(255),
 @picture varchar(255)
)
AS
    BEGIN
   update product_singles set 				       
				product_id= @product_id          ,
				wine_name= @wine_name           ,
				amount= @amount           ,
				alcohol_concentration = @alcohol_concentration,
				capacity=@capacity,
				picture=@picture
				where id = @id;
			 
        SELECT '';
    END;
GO
-- khách hàng
create PROCEDURE [dbo].[sp_customers_all]
AS
    BEGIN
        SELECT *                        
        FROM customers
    END;
GO

---
create PROCEDURE [dbo].[sp_customer_create]
(@CustomerName              varchar(255), 
 @DateOfBirth      date,
 @Address  varchar(255),
 @Phone varchar(255),
 @Email varchar(255),
 @Password varchar(255)
)
AS
    BEGIN
      INSERT INTO customers
                (CustomerName, 
                 DateOfBirth ,
				 Address,
				 Phone,
				 Email,
				 Password)
                VALUES
                (@CustomerName, 
                 @DateOfBirth ,
				 @Address,
				 @Phone,
				 @Email,
				 @Password);
        SELECT '';
    END;
	----

	create PROCEDURE [dbo].[sp_customer_get_by_username_password](@Email varchar(255), @Password varchar(255))
AS
    BEGIN
        SELECT  [id]               , 
					 CustomerName           ,
					 DateOfBirth          ,
					 Address           ,
					 Phone           ,
					 Email           ,
				 	 Password         ,
					 role      
        FROM [customers]
      where  Email = @Email and Password = @Password ;
    END;
	---

	create PROCEDURE [dbo].[sp_customer_delete]
(@id   int
)
AS
    BEGIN
		delete from customers where id = @id;
        SELECT '';
    END;
	----

	create PROCEDURE [dbo].[sp_customer_update]
(@id     int, 
 @CustomerName   nvarchar(255), 
 @DateOfBirth   date,
 @Address varchar(255),
 @Phone varchar(255),
 @Email varchar(255),
 @Password varchar(255),
 @role          varchar(30)

)
AS
    BEGIN
   update customers set 				       
				CustomerName = @CustomerName ,
				DateOfBirth   = @DateOfBirth  ,
				Address   = @Address  ,
				Phone    = @Phone  ,
				role= @role ,
				Email=@Email,
				Password=@Password

				where id = @id;
			 
        SELECT '';
    END;
-- hóa ??n
create PROCEDURE [dbo].[sp_bills_all]
AS
    BEGIN
        SELECT *                        
        FROM bills
    END;
GO

-----
---
ALTER PROCEDURE [dbo].[sp_hoa_don_create]
(@madonhang              VARCHAR(50), 
 @hoten         NVARCHAR(150), 
 @diachinhan          NVARCHAR(250),  
 @sdtnhan       NVARCHAR(250),  
 @tinhtrang       NVARCHAR(250),  
 @tongtien       float,  
 @ngaydat       NVARCHAR(250),  
 @ngaygiao       NVARCHAR(250),
 @note       NVARCHAR(255),  
 @listjson_chitiet NVARCHAR(MAX)
)
AS
    BEGIN
        INSERT INTO bills
                (MaDonHang, HoTen, DiaChiNhan, SDTNhan, TinhTrang, TongTien, NgayDat, NgayGiao,Note)
                VALUES
                ( @madonhang, @hoten, @diachinhan,@sdtnhan,@tinhtrang,@tongtien,@ngaydat,@ngaygiao,@note);
                IF(@listjson_chitiet IS NOT NULL)
                    BEGIN
                        INSERT INTO bill_details
                        (ma_chi_tiet, 
                         MaDonHang, 
                         MaSanPham, 
                         SoLuong,
						 GiaBan
                        )
                               SELECT JSON_VALUE(p.value, '$.ma_chi_tiet'), 
                                      @madonhang, 
                                      JSON_VALUE(p.value, '$.maSanPham'), 
                                      JSON_VALUE(p.value, '$.soLuong'),    
                                      JSON_VALUE(p.value, '$.giaBan')   
                               FROM OPENJSON(@listjson_chitiet) AS p;
                END;
        SELECT '';
    END;
--
create PROCEDURE [dbo].[sp_hoa_don_update]
(@madonhang              VARCHAR(50), 
 @hoten          NVARCHAR(150), 
 @diachinhan          NVARCHAR(250),  
 @sdtnhan       NVARCHAR(250),  
 @tinhtrang       NVARCHAR(250),  
 @tongtien       NVARCHAR(250),  
 @ngaydat       NVARCHAR(250),  
 @ngaygiao       NVARCHAR(250), 
  @note       NVARCHAR(255),  

 @listjson_chitiet NVARCHAR(MAX)
)
AS
    BEGIN
		UPDATE bills
		SET
			HoTen = @hoten,
			DiaChiNhan = @diachinhan,
			SDTNhan = @sdtnhan,
			TinhTrang = @tinhtrang,
			TongTien = @tongtien,
			NgayDat = @ngaydat,
			NgayGiao = @ngaygiao,
			Note = @note
		WHERE MaDonHang = @madonhang;
		
		IF(@listjson_chitiet IS NOT NULL) 
		BEGIN
			 -- Insert data to temp table 
		   SELECT
			  JSON_VALUE(p.value, '$.ma_chi_tiet') as ma_chi_tiet,
			  JSON_VALUE(p.value, '$.maDonHang') as MaDonHang,
			  JSON_VALUE(p.value, '$.maSanPham') as MaSanPham,
			  JSON_VALUE(p.value, '$.soLuong') as SoLuong,
			  JSON_VALUE(p.value, '$.giaBan') AS GiaBan,
			  JSON_VALUE(p.value, '$.status') AS status 
			  INTO #Results 
		   FROM OPENJSON(@listjson_chitiet) AS p;
		 
		 -- Insert data to table with STATUS = 1;
			INSERT INTO bill_details(ma_chi_tiet,MaDonHang,MaSanPham,SoLuong,GiaBan) 
			   SELECT
				  #Results.ma_chi_tiet,
				  @madonhang,
				  #Results.MaSanPham,
				  #Results.SoLuong,			 
				  #Results.GiaBan 
			   FROM  #Results 
			   WHERE #Results.status = '1' 
			
			-- Update data to table with STATUS = 2
			  UPDATE bill_details 
			  SET
				 SoLuong = #Results.SoLuong
			  FROM #Results 
			  WHERE  bill_details.ma_chi_tiet = #Results.ma_chi_tiet AND #Results.status = '2';
			
			-- Delete data to table with STATUS = 3
			DELETE C
			FROM bill_details C
			INNER JOIN #Results R
				ON C.ma_chi_tiet=R.ma_chi_tiet
			WHERE R.status = '3';
			DROP TABLE #Results;
		END;
        SELECT '';
    END
	--
	create PROCEDURE [dbo].[sp_user_all]
AS
    BEGIN
        SELECT *                        
        FROM [users]
    END;
	--
	create PROCEDURE [dbo].[sp_user_create]
(
 @hoten          nvarchar(150) ,
 @ngaysinh         date  ,
 @diachi          nvarchar(250)  ,
 @gioitinh         nvarchar(30)  ,
 @email          varchar(150) ,
 @taikhoan         varchar(30) ,
 @matkhau         varchar(60)  ,
 @role          varchar(30) ,
 @image_url varchar(300)
)
AS
    BEGIN
      INSERT INTO [users]
                (
					 hoten           ,
					 ngaysinh          ,
					 diachi           ,
					 gioitinh           ,
					 email           ,
					 taikhoan         ,
					 matkhau           ,
					 role    ,
					 image_url
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
				 @role ,
				 @image_url
				);
        SELECT '';
    END;
	--
	create PROCEDURE [dbo].[sp_user_delete]
(@id              INT 
)
AS
    BEGIN
		delete from [users] where id = @id;
        SELECT '';
    END;
	--
	create PROCEDURE [dbo].[sp_user_get_by_id](@id VARCHAR(50))
AS
    BEGIN
        SELECT  [id]               , 
					 hoten           ,
					 ngaysinh          ,
					 diachi           ,
					 gioitinh           ,
					 email           ,
					 taikhoan         ,
					 matkhau           ,
					 role     ,
					 image_url
        FROM [users]
      where  [id] = @id;
    END;
	--
	create PROCEDURE [dbo].[sp_user_search] (@page_index  INT, 
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
                             u.id              , 
							 u.hoten           ,
							 u.ngaysinh          ,
							 u.diachi           ,
							 u.gioitinh           ,
							 u.email           ,
							 u.taikhoan         ,
							 u.matkhau           ,
							 u.role  ,
							 u.image_url
                        INTO #Results1
                        FROM [users] AS u
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
                             u.id              , 
							 u.hoten           ,
							 u.ngaysinh          ,
							 u.diachi           ,
							 u.gioitinh           ,
							 u.email           ,
							 u.taikhoan         ,
							 u.matkhau           ,
							 u.role       ,
							 u.image_url
                        INTO #Results2
                        FROM [users] AS u
						WHERE (u.taikhoan <> 'Admin') and ((@hoten = '') OR (u.hoten LIKE '%' + @hoten + '%')) and  ((@taikhoan = '') OR (u.taikhoan = @taikhoan));
                        SELECT @RecordCount = COUNT(*)
                        FROM #Results2;
                        SELECT *, 
                               @RecordCount AS RecordCount
                        FROM #Results2;
                        DROP TABLE #Results2;
        END;
    END;
	--
	create PROCEDURE [dbo].[sp_user_update]
(@id             varchar(50), 
 @hoten          nvarchar(150) ,
 @ngaysinh         date  ,
 @diachi          nvarchar(250)  ,
 @gioitinh         nvarchar(30)  ,
 @email          varchar(150) ,
 @taikhoan         varchar(30) ,
 @matkhau         varchar(60)  ,
 @role          varchar(30),
 @image_url varchar(300)
)
AS
    BEGIN
   update [users] set 
				hoten= @hoten           ,
				ngaysinh= @ngaysinh          ,
				diachi= @diachi           ,
				gioitinh= @gioitinh           ,
				email= @email           ,
				matkhau = @matkhau           ,
				role= @role ,
				image_url=@image_url
				where id = @id;
			 
        SELECT '';
    END;
 -----thống kê

 create PROCEDURE [dbo].[sp_thongke_soluong_sanpham]
AS
    BEGIN
        SELECT count(*)    as SLSP                    
        FROM product_singles 
    END;
	 create PROCEDURE [dbo].[sp_thongke_soluong_loaisanpham]
AS
    BEGIN
        SELECT count(*)    as SLLSP                    
        FROM products
    END;

		 create PROCEDURE [dbo].[sp_thongke_soluong_hoadon]
AS
    BEGIN
        SELECT count(*)   as SLHD                     
        FROM bills
    END;
		exec sp_thongke_soluong_loaisanpham

				 create PROCEDURE [dbo].[sp_thongke_soluong_nguoidung]
AS
    BEGIN
        SELECT count(*)   as SLND                    
        FROM customers
    END;
		exec [sp_product_ban_chay] 1,100,''

		create PROCEDURE [dbo].[sp_product_ban_chay] (@page_index  INT, 
										   @page_size   INT,
										   @wine_name  varchar(255))
AS
    BEGIN
        DECLARE @RecordCount BIGINT;
        IF(@page_size <> 0)
            BEGIN
                SET NOCOUNT ON;
                        SELECT(ROW_NUMBER() OVER(
                              ORDER BY Sum(c.SoLuong) desc)) AS RowNumber, 
							  i.id,
                              i.wine_name , 
                              c.GiaBan,
							  i.picture,
                              Sum(c.SoLuong) as [SLBC]
                        INTO #Results1
                        FROM product_singles i join bill_details c on i.id = c.MaSanPham
					    WHERE (@wine_name = '' Or i.wine_name like N'%'+@wine_name+'%')
						Group by  i.id,
                              i.wine_name , 
                              c.GiaBan,
							  i.picture
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
                               ORDER BY Sum(c.SoLuong) desc)) AS RowNumber, 
                               i.id,
                              i.wine_name , 
                              c.GiaBan,
							  i.picture,
                              Sum(c.SoLuong) as [SLBC]
                        INTO #Results2
                           FROM product_singles i join bill_details c on i.id = c.MaSanPham
					    WHERE (@wine_name = '' Or i.wine_name like N'%'+@wine_name+'%')
						Group by  i.id,
                              i.wine_name , 
                              c.GiaBan,
							  i.picture
                        SELECT @RecordCount = COUNT(*)
                        FROM #Results2;
                        SELECT *, 
                               @RecordCount AS RecordCount
                        FROM #Results2;
                        DROP TABLE #Results2;
        END;
    END;