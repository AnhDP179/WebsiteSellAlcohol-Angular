﻿
CREATE TABLE LoaiSanPham (
	MaLoai INT NOT NULL IDENTITY(1, 1) PRIMARY KEY, -- mã tự động tăng
	TenLoai NVARCHAR(50) NOT NULL,
	MoTa NTEXT,
)

CREATE TABLE SanPham (
	MaSP INT NOT NULL IDENTITY(1, 1) PRIMARY KEY, -- mã tự động tăng
	MaLoai INT FOREIGN KEY(MaLoai) REFERENCES LoaiSanPham(MaLoai) ON DELETE CASCADE ON UPDATE CASCADE, -- mã loại (khóa phụ)
	TenSP NVARCHAR(50) NOT NULL,
	SoLuong INT,
	DonGia INT,
	MauSac NVARCHAR(10),
	KichThuoc NVARCHAR(10),
	HinhAnh NVARCHAR(255),
)

CREATE TABLE NhaCungCap (
	MaNCC INT NOT NULL IDENTITY(1, 1) PRIMARY KEY, -- mã tự động tăng
	TenNCC NVARCHAR(50) NOT NULL,
	DiaChi NVARCHAR(50) NOT NULL,
	SDT CHAR(10),
)

CREATE TABLE KhachHang (
	MaKH INT NOT NULL IDENTITY(1, 1) PRIMARY KEY, -- mã tự động tăng
	HoTen NVARCHAR(50) NOT NULL,
	DiaChi NVARCHAR(50) NOT NULL,
	Email NVARCHAR(50) NOT NULL,
	SDT CHAR(10) NOT NULL,
)

CREATE TABLE HoaDonNhap (
	MaHDN INT NOT NULL IDENTITY(1, 1) PRIMARY KEY, -- mã tự động tăng
	MaNCC INT FOREIGN KEY(MaNCC) REFERENCES NhaCungCap(MaNCC) ON DELETE CASCADE ON UPDATE CASCADE,
	NgayTao DATETIME
)

CREATE TABLE ChiTietHDN (
	MaCT INT NOT NULL IDENTITY(1, 1) PRIMARY KEY, -- mã tự động tăng
	MaHDN INT FOREIGN KEY(MaHDN) REFERENCES HoaDonNhap(MaHDN) ON DELETE CASCADE ON UPDATE CASCADE,
	MaSP INT FOREIGN KEY(MaSP) REFERENCES SanPham(MaSP) ON DELETE CASCADE ON UPDATE CASCADE,
	SoLuong INT,
	DonGia INT,
)

CREATE TABLE HoaDonBan (
	MaHDB INT NOT NULL IDENTITY(1, 1) PRIMARY KEY, -- mã tự động tăng
	MaKH INT FOREIGN KEY(MaKH) REFERENCES KhachHang(MaKH) ON DELETE CASCADE ON UPDATE CASCADE,
	NgayTao DATETIME,
)

CREATE TABLE ChiTietHDB (
	MaCT INT NOT NULL IDENTITY(1, 1) PRIMARY KEY, -- mã tự động tăng
	MaHDB INT FOREIGN KEY(MaHDB) REFERENCES HoaDonBan(MaHDB) ON DELETE CASCADE ON UPDATE CASCADE,
	MaSP INT FOREIGN KEY(MaSP) REFERENCES SanPham(MaSP) ON DELETE CASCADE ON UPDATE CASCADE,
	SoLuong INT,
	DonGia INT,
)

CREATE TABLE TaiKhoan (
	MaTK INT NOT NULL IDENTITY(1, 1) PRIMARY KEY, -- mã tự động tăng
	Email NVARCHAR(50) NOT NULL,
	MatKhau NVARCHAR(20) NOT NULL,
	HoTen NVARCHAR(50) NOT NULL,
	SDT CHAR(10) NOT NULL,
	NgayTao DATETIME,
)