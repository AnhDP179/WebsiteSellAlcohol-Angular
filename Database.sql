CREATE TABLE products (
  id int IDENTITY(1,1) PRIMARY KEY,
  manufacturer ntext  NOT NULL,
  _description ntext  NOT NULL,
  created_at DATETIME NULL DEFAULT NULL,
  updated_at DATETIME NULL DEFAULT NULL
)
CREATE TRIGGER tgr_modstamp
ON products
AFTER UPDATE AS
  UPDATE products
  SET updated_at = GETDATE()
  WHERE id IN (SELECT DISTINCT id FROM products)

INSERT INTO products ( manufacturer, _description, created_at, updated_at) VALUES
( 'Gin', N'Rượu Gin là một loại rượu có mặt trong các loại cocktail kinh điển. Rượu Gin không phổ biến và được nhiều người biết đến như Whisky, Rum hay Vodka. Tuy nhiên, ở phương Tây đây là một trong những loại rượu mạnh được ưa chuộng', NULL, NULL),
( 'Rum', N'Rum là một thức uống có cồn chưng cất được làm từ các sản phẩm phụ từ mía, chẳng hạn như mật, hoặc trực tiếp từ nước mía, bằng một quá trình lên men và chưng cất. Rượu chưng cất được, một chất lỏng trong suốt, sau đó thường được ủ trong thùng gỗ sồi.', NULL, NULL),
( 'Vodka', N'Vodka (tiếng Ba Lan: wódka Vutka, tiếng Nga: водка Votkə) là một loại đồ uống có cồn được chưng cất có nguồn gốc từ Ba Lan và Nga, bao gồm chủ yếu là nước và ethanol nhưng đôi khi có dấu vết của tạp chất và hương liệu. Theo truyền thống, rượu được tạo', NULL, NULL),
( 'Brandy', N'Brandy là một loại rượu chưng cất được sản xuất bằng cách chưng cất rượu vang. Brandy thường chứa 35–60% độ cồn (70–120 chứng nhận Hoa Kỳ) và thường được tiêu thụ như món trợ tiêu hóa sau bữa tối. Một số rượu brandy được ủ trong thùng gỗ. Một số khác được', NULL, NULL),
( 'Tequila', N'Tequila (phát âm như tê-ki-la) là một loại đồ uống chưng cất được làm từ cây agave tequilana, chủ yếu ở khu vực xung quanh thành phố Tequila 65 km (40 dặm) về phía tây bắc của Guadalajara, và trong cao nguyên Jaliscan (Los Altos de Jalisco) của trung tâm ', NULL, NULL),
( 'Liqueurs', N'Liqueurs( Mỹ : / l ɪ k ɜːr / ; Anh : / l ɪ k j ʊər / ; tiếng Pháp:  likœʁ ) là một thức uống có cồn gồm rượu chưng cất và hương liệu bổ sung như đường , trái cây , thảo mộc , và gia vị . Thường được phục vụ cùng hoặc sau món tráng miệng, chúng thường đư', NULL, NULL);
  

  CREATE TABLE product_singles (
  id int not null IDENTITY(1,1) PRIMARY KEY,
  product_id int FOREIGN KEY(product_id) REFERENCES products(id) ON DELETE CASCADE ON UPDATE CASCADE ,
  wine_name varchar(255) ,
  alcohol_concentration varchar(255) ,
  capacity varchar(255),
  amount int NOT NULL,
  price float not null,
  picture varchar(255) NOT NULL,
  created_at DATETIME NULL DEFAULT NULL,
  updated_at DATETIME NULL DEFAULT NULL
)

INSERT INTO product_singles (product_id, wine_name,alcohol_concentration, capacity, amount, price,picture, created_at, updated_at) VALUES
( 1, 'Gordons London Dry', '37,5%', '750ml', 100, 275000,'', NULL, NULL),
( 1, 'Plymount', '41.2%', '700ml', 100, 813520,'', NULL, NULL),
( 1, 'Slingsby Old Tom', '43%', '700ml', 100, 1244000,'', NULL, NULL),
( 1, 'Four Pillars Navy Strength', '58.8%', '500ml', 100, 1500000,'', NULL, NULL),
( 1, 'Sloe Gin', '50%', '700ml', 100, 5168000,'', NULL, NULL),
( 3, 'Bacardi Gold', '40%', '750ml', 100, 330000,'', NULL, NULL),
( 3, 'Malibu Coconut', '21%', '750ml', 100, 360000,'', NULL, NULL),
( 3, 'Rhum Chauvet', '39%', '1000ml', 100, 190000,'', NULL, NULL),
( 3, 'Captain Morgan', '35%', '750ml', 100, 300000,'', NULL, NULL),
( 3, 'Bundaberg', '37%', '700ml', 100, 430000,'', NULL, NULL),
( 4, 'Smirnoff Red', '39%', '700ml', 100, 230000,'', NULL, NULL),
( 4, 'Danzka Original', '40%', '1000ml', 100, 350000,'', NULL, NULL),
( 5, 'Remy Martin XO', '40%', '700ml', 100, 3600000,'', NULL, NULL),
( 5, 'Armagnac Delord 15 YO ', '40%', '750ml','', 100, 2100000, NULL, NULL),
( 5, 'Berta Villa Prato', '40%', '1000ml', 100, 974941,'', NULL, NULL),
( 6, 'El Jimador', '40%', '700ml', 100, 670000,'', NULL, NULL),
( 6, 'Corralejo Blanco', '39%', '700ml', 100, 668857,'', NULL, NULL),
( 6, 'Don Julio', '38%', '750ml', 100, 1650000,'', NULL, NULL),
( 6, 'Cazcanes No. 9 Blanco', '50%', '750ml', 100, 2007000,'', NULL, NULL),
( 6, 'Herradura Plata', '40%', '750ml', 100, 1900000,'', NULL, NULL),
( 6, 'La Luna Ensamble', '48%', '750ml', 100, 890000,'', NULL, NULL),
( 4, 'Absolut', '40%', '750ml', 100, 300000,'', '2021-05-02 07:59:11', '2021-05-02 08:01:11'),
( 1, 'Absolut1', '25%', '760ml', 100, 600000,'','2021-06-18 00:53:40', '2021-06-18 00:53:40');

CREATE TABLE customers (
  id int not null IDENTITY(1,1) PRIMARY KEY,
  CustomerName varchar(255)  NOT NULL,
  DateOfBirth date DEFAULT NULL,
  Address varchar(255)    NULL,
  Phone varchar(255)    NULL,
  Email varchar(255)   NOT NULL,
  Password varchar(255)  NOT  NULL
)

CREATE TABLE bills (
  MaDonHang varchar(50) PRIMARY KEY NOT NULL,
  HoTen         NVARCHAR(150),
  DiaChiNhan          NVARCHAR(250),  
  SDTNhan       NVARCHAR(250),  
  TinhTrang       NVARCHAR(250),  
  TongTien       float,  
  NgayDat       NVARCHAR(250),  
  NgayGiao       NVARCHAR(250),
  Note nvarchar(255)
)

CREATE TABLE bill_details (
  ma_chi_tiet varchar(50) PRIMARY KEY NOT NULL,
  MaDonHang varchar(50) FOREIGN KEY(MaDonHang) REFERENCES bills(MaDonHang) ON DELETE CASCADE ON UPDATE CASCADE NOT NULL,
  MaSanPham int FOREIGN KEY(MaSanPham) REFERENCES product_singles(id) ON DELETE CASCADE ON UPDATE CASCADE NOT NULL,
  SoLuong int NOT NULL DEFAULT 0,
  GiaBan float NOT NULL DEFAULT 0,
)

CREATE TABLE users (
  id int not null IDENTITY(1,1) PRIMARY KEY,
	hoten nvarchar(150) NULL,
	ngaysinh date NULL,
	diachi nvarchar(250) NULL,
	gioitinh nvarchar(30) NULL,
	email varchar(150) NULL,
	taikhoan varchar(30) NULL,
	matkhau varchar(60) NULL,
	role varchar(30) NULL,
	image_url varchar(300) NULL,
)