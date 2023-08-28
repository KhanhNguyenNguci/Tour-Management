CREATE DATABASE Assignment2;
USE Assignment2;
CREATE TABLE Chinhanh (
  MaCN CHAR(6) PRIMARY KEY,
  TenCN VARCHAR(50) NOT NULL UNIQUE,
  KhuVuc VARCHAR(50) NOT NULL,
  DiaChi VARCHAR(50) NOT NULL,
  Email VARCHAR(30) NOT NULL,
  Fax VARCHAR(20),
  MaNVQuanLy CHAR(6)
);

CREATE TABLE SoDienThoaiChiNhanh (
  MaCN VARCHAR(10) NOT NULL,
  DienThoai VARCHAR(11) NOT NULL 
);

CREATE TABLE NhanVien (
  MaNV CHAR(6) PRIMARY KEY,
  CMND VARCHAR(12) NOT NULL,
  HoTen VARCHAR(100) NOT NULL,
  DiaChi VARCHAR(200) NOT NULL,
  GioiTinh CHAR(1) NOT NULL,
  NgaySinh DATE NOT NULL,
  LoaiNV CHAR(1) NOT NULL,
  ViTri VARCHAR(50) NOT NULL,
  MaCNLamViec CHAR(6)
);
  
CREATE TABLE NgoaiNguNhanVien (
  MaNV CHAR(6),
  NgoaiNgu VARCHAR(50)  
);

CREATE TABLE KyNangNhanVien (
  MaNV CHAR(6),
  KyNang VARCHAR(50)
);

CREATE TABLE DiemDuLich (
  MaDiem INT AUTO_INCREMENT PRIMARY KEY,
  TenDiem VARCHAR(50) NOT NULL,
  DiaChi VARCHAR(50) NOT NULL,
  PhuongXa VARCHAR(20) NOT NULL,
  QuanHuyen VARCHAR(20) NOT NULL,
  TinhThanh VARCHAR(20) NOT NULL,
  Anh1 LONGBLOB NOT NULL,
  Anh2 LONGBLOB NOT NULL,
  Anh3 LONGBLOB NOT NULL,
  MoTa VARCHAR(50),
  GhiChu VARCHAR(50)
);

 
CREATE TABLE DonViCungCapDichVu (
  MaDV CHAR(6) PRIMARY KEY,
  TenDV VARCHAR(50),
  Email VARCHAR(30),
  DienThoai VARCHAR(11),
  TenNguoiDaiDien VARCHAR(20),
  DienThoaiNguoiDaiDien VARCHAR(11),
  DiaChi VARCHAR(50),
  PhuongXa VARCHAR(20),
  QuanHuyen VARCHAR(20),
  TinhThanh VARCHAR(20),
  Anh1 LONGBLOB NOT NULL,
  Anh2 LONGBLOB NOT NULL,
  Anh3 LONGBLOB NOT NULL,
  Anh4 LONGBLOB NOT NULL,
  Anh5 LONGBLOB NOT NULL,
  Loai CHAR(1) NOT NULL,
  GhiChu VARCHAR(50)
);

CREATE TABLE KhachHang (
  MaKH CHAR(6) PRIMARY KEY,
  CMND VARCHAR(12),
  HoTen VARCHAR(30) NOT NULL,
  Email VARCHAR(30),
  DienThoai VARCHAR(12),
  NgaySinh DATE NOT NULL,
  DiaChi VARCHAR(50) NOT NULL
);

CREATE TABLE KhachDoan (
  MaDoan CHAR(6) PRIMARY KEY,
  TenCoQuan VARCHAR(50) NOT NULL,
  Email VARCHAR(30) NOT NULL,
  DienThoai VARCHAR(12),
  DiaChi VARCHAR(50),
  MaDaiDien CHAR(6) NOT NULL
);



CREATE TABLE KhachDoanGomKhachLe (
  MaDoan CHAR(6),
  MaKH CHAR(6)
);

CREATE TABLE Tour (
  MaTour CHAR(13) PRIMARY KEY,
  TenTour VARCHAR(30) NOT NULL,
  image VARCHAR(255) NOT NULL,
  NgayBatDau VARCHAR(15) NOT NULL,
  SoKhachTourToiThieu INT NOT NULL,
  SoKhachTourToiDa INT NOT NULL,
  GiaVeLeNguoiLon DECIMAL(10, 2) NOT NULL,
  GiaVeLeTreEm DECIMAL(10, 2) NOT NULL,
  GiaVeDoanNguoiLon DECIMAL(10, 2) NOT NULL,
  GiaVeDoanTreEm DECIMAL(10, 2) NOT NULL,
  SoKhachDoanToiThieu INT NOT NULL,
  SoDem INT NOT NULL,
  SoNgay INT NOT NULL,
  MaCN CHAR(6) NOT NULL
);

CREATE TABLE NgayKhoiHanhTourDaiNgay(
  MaTour CHAR(13),
  Ngay INT
);

CREATE TABLE LichTrinhTour (
  MaTour CHAR(13),
  STTNgay INT
);

CREATE TABLE TourGomDiaDiemThamQuan (
  MaTour CHAR(13),
  STTNgay INT,
  MaDiem INT NOT NULL,
  ThoiGianBatDau TIME NOT NULL,
  ThoiGianKetThuc TIME NOT NULL,
  MoTa VARCHAR(50)
);

CREATE TABLE HanhDongLichTrinhTour (
  MaTour CHAR(13),
  STTNgay INT,
  LoaiHanhDong CHAR(1),
  GioBatDau TIME,
  GioKetThuc TIME,
  MoTa VARCHAR(50)
);

CREATE TABLE ChuyenDi (
  MaTour CHAR(13),
  NgayKhoiHanh DATE,
  NgayKetThuc DATE NOT NULL,
  TongGia DECIMAL(15, 2) NOT NULL DEFAULT 0
);


CREATE TABLE HuongDanVienDanChuyen (
  MaTour CHAR(13),
  NgayKhoiHanh DATE,
  MaHDV CHAR(6)
);

CREATE TABLE LichTrinhChuyen (
  MaTour CHAR(13),
  NgayKhoiHanh DATE,
  STTNgay INT
);

CREATE TABLE DonViCungCapDichVuChuyen (
  MaTour CHAR(13),
  NgayKhoiHanh DATE,
  STTNgay INT,
  LoaiDichVu CHAR(1),
  MaDV CHAR(6)
);


CREATE TABLE PhieuDangKy (
  MaPhieu VARCHAR(30) PRIMARY KEY,
  NgayDangKy DATE NOT NULL,
  GhiChu TEXT,
  MaNV CHAR(6),
  MaKHL VARCHAR(10),
  MaKHD VARCHAR(10),
  MaTour CHAR(13),
  NgayKhoiHanh DATE NOT NULL
);

CREATE TABLE DonViCungCapDichVuLienQuan (
  MaTour CHAR(13),
  MaDiem INT,
  MaDV CHAR(6)
);

DELIMITER //

CREATE TRIGGER Before_ChiNhanh_Insert
BEFORE INSERT ON ChiNhanh
FOR EACH ROW
BEGIN
    DECLARE nextId INT;

    SELECT COALESCE(MAX(SUBSTRING(MaCN, 3) + 1), 1) INTO nextId FROM ChiNhanh;
    SET NEW.MaCN = CONCAT('CN', LPAD(nextId, 4, '0'));
END;

CREATE TRIGGER Before_NhanVien_Insert
BEFORE INSERT ON NhanVien
FOR EACH ROW
BEGIN
    DECLARE nextId INT;

    IF NEW.LoaiNV = '1' THEN
        SELECT COALESCE(MAX(SUBSTRING(MaNV, 3) + 1), 1) INTO nextId FROM NhanVien WHERE LoaiNV = '1';
        SET NEW.MaNV = CONCAT('VP', LPAD(nextId, 4, '0'));
    ELSEIF NEW.LoaiNV = '2' THEN
        SELECT COALESCE(MAX(SUBSTRING(MaNV, 3) + 1), 1) INTO nextId FROM NhanVien WHERE LoaiNV = '2';
        SET NEW.MaNV = CONCAT('HD', LPAD(nextId, 4, '0'));
    END IF;
END;

CREATE FUNCTION GenerateIncrementalNumber() RETURNS INT DETERMINISTIC
BEGIN
    DECLARE lastNumber INT;

    SELECT COALESCE(MAX(SUBSTRING(MaTour, -6)), 0) INTO lastNumber FROM Tour;
    RETURN lastNumber + 1;
END;

CREATE TRIGGER SetMaTourTrigger BEFORE INSERT ON Tour
FOR EACH ROW
BEGIN
    DECLARE incrementalNumber INT;

    SET incrementalNumber = GenerateIncrementalNumber();
    SET NEW.MaTour = CONCAT(NEW.MaCN, '-', LPAD(incrementalNumber, 6, '0'));
END;

CREATE FUNCTION GenerateIncrementalCode(dateOfRegistration DATE) RETURNS INT DETERMINISTIC
BEGIN
    DECLARE maxCount INT;
    DECLARE incrementalCode INT;

    SELECT COALESCE(MAX(RIGHT(MaPhieu, 9)), 0) INTO maxCount FROM PhieuDangKy WHERE NgayDangKy = dateOfRegistration;

    SET incrementalCode = maxCount + 1;

    RETURN incrementalCode;
END;

CREATE TRIGGER Before_PhieuDangKy_Insert
BEFORE INSERT ON PhieuDangKy
FOR EACH ROW
BEGIN
    SET NEW.MaPhieu = CONCAT(DATE_FORMAT(NEW.NgayDangKy, '%d%m%Y'), LPAD(GenerateIncrementalCode(NEW.NgayDangKy), 9, '0'));
END;
//
DELIMITER ;
INSERT INTO ChiNhanh (TenCN, KhuVuc, DiaChi, Email, Fax, MaNVQuanLy)
VALUES
	('Chi nhánh Sài Gòn MiniTour', 'Hồ Chí Minh', '1 Nguyễn Thái Bình, Quận 1', 'sg.tour@mntour.com', '1234567890', 'VP0001'),
	('Chi nhánh Hà Nội MiniTour', 'Hà Nội', '38 Tông Đản, Quận Hoàn Kiếm', 'hn.tour@mntour.com', '9876543210', 'VP0002'),
	('Chi nhánh Đà Năng MiniTour', 'Đà Nẵng', '23 Cao Thắng, Quận Hải Châu', 'dn.tour@mntour.com', '5551234567', 'VP0003'),
	('Chi nhánh Đà Lạt MiniTour', 'Đà Lạt', '123 Nguyễn Chí Thanh, Đà Lạt', 'dl.tour@mntour.com', '7778889999', 'VP0004');

INSERT INTO NhanVien (CMND, HoTen, DiaChi, GioiTinh, NgaySinh, LoaiNV, ViTri, MaCNLamViec)
VALUES 
	('079134002234', 'Trần Quỳnh', '123 Truong Chinh', 'F', '1990-01-15', '1', 'Quản Lý', 'CN0001'),
	('001012001235', 'Nguyễn Văn Tú', '456 Chua Lang', 'M', '1995-08-23', '1', 'Quản Lý', 'CN0002'),
	('048102001233', 'Nguyễn Vân Anh', '789 Office Rd', 'F', '1995-03-10', '2', 'Hướng dẫn viên', 'CN0003'),
	('068124468342', 'Phan Quang Anh', '123 Guide Ave', 'M', '1988-12-05', '2', 'Hướng dẫn viên', 'CN0004'),
	('048001223306', 'Văn Thanh Tú', '111 Office Rd', 'F', '1993-05-20', '1', 'Quản Lý', 'CN0003'),
	('068028223451', 'Nguyễn Thanh Tùng', '222 Main St', 'M', '1987-11-10', '1', 'Quản Lý', 'CN0004'),
	('079002335004', 'Phạm Thị Tâm', '333 Guide Ave', 'F', '1992-02-28', '2', 'Hướng dẫn viên', 'CN0001'),
	('079012223646', 'Nguyễn Văn Bình', '23 Nguyễn An Ninh', 'M', '1989-09-17', '2', 'Hướng dẫn viên', 'CN0002'),
	('077014213546', 'Nguyễn Thị Oanh', '231 Nguyễn Thái Bình', 'F', '1996-09-21', '1', 'Ke Toan', 'CN0001');
	
INSERT INTO SoDienThoaiChiNhanh (MaCN, DienThoai)
VALUES
  ('CN0001', '18001233'),
  ('CN0001', '18001234'),
  ('CN0002', '18001235'),
  ('CN0003', '18001236');
  
INSERT INTO NgoaiNguNhanVien (MaNV, NgoaiNgu) VALUES
 ('HD0001', 'Tiếng Anh'),
 ('HD0001', 'Tiếng Tây Ban Nha'),
 ('HD0002', 'Tiếng Pháp'),
 ('HD0003', 'Tiếng Đức');

INSERT INTO KyNangNhanVien (MaNV, KyNang)
VALUES
  ('HD0001', 'Giao tiếp'),
  ('HD0001', 'Xử lý tình huống'),
  ('HD0002', 'Làm việc nhóm'),
  ('HD0003', 'Lãnh đạo');
  
INSERT INTO DiemDuLich (TenDiem, DiaChi, PhuongXa, QuanHuyen, TinhThanh, Anh1, Anh2, Anh3, MoTa, GhiChu)
VALUES
  ('Ha Long', 'Do Si Hoa', 'Dao Reu', 'Thanh pho Ha Long', 'Tinh Quang Ninh', 'Image1', 'Image2', 'Image3', 'Description A', 'Note A'),
  ('Ho Tram', 'Bien Ho Tram', 'Phuoc Thuan', 'Xuyen Moc', 'Tinh Ba Ria Vung Tau', 'Image4', 'Image5', 'Image6', 'Description B', 'Note B'),
  ('Vinpearl Resort Nha Trang', '', 'Dao Hon Tre', 'Nha Trang', 'Tinh Khanh Hoa', 'Image7', 'Image8', 'Image9', 'Description C', 'Note C'),
  ('Vinpearl Resort Phu Quoc', 'Bai Dai', 'Ganh Dau', 'Phu Quoc', 'Tinh Kien Giang', 'Image10', 'Image11', 'Image12', 'Description D', 'Note D'),
  ('Đảo Yến (Hòn Nội)', '', 'Cam Hải Đông', 'Cam Ranh', 'Khánh Hoà', '', '', '', 'Description E', 'Note E'),
  ('Đảo Bình Ba', '', 'Cam Bình', 'Cam Ranh', 'Khánh Hoà', '', '', '', 'Description F', 'Note F'),
  ('Viện Hải Dương Học Nha Trang', '01 Cầu Đá', 'Vĩnh Nguyên', 'Nha Trang', 'Khánh Hoà', '', '', '', 'Description G', 'Note G'),
  ('Diving Club', '', 'Dao Hon Tre', 'Nha Trang', 'Tinh Khanh Hoa', 'Image7', 'Image8', 'Image9', 'Description C', 'Note C'),
  ('VinWonder', '', 'Dao Hon Tre', 'Nha Trang', 'Tinh Khanh Hoa', 'Image7', 'Image8', 'Image9', 'Description C', 'Note C');


INSERT INTO DonViCungCapDichVu (MaDV, TenDV, Email, DienThoai, TenNguoiDaiDien, DienThoaiNguoiDaiDien, DiaChi, PhuongXa, QuanHuyen, TinhThanh, Anh1, Anh2, Anh3, Anh4, Anh5, Loai, GhiChu)
VALUES
  ('DV0001', 'Vietnam Airlines', 'vnairlines@vietnamairlines.com', '038272289', 'Nguyễn Trí', '0123122528', '200 Nguyễn Sơn', 'Phường Bồ Đề', 'Quận Long Biên', 'Hà Nội', 'https://media.vov.vn/sites/default/files/styles/large/public/2023-05/1_1_5.jpg', 'https://media.vov.vn/sites/default/files/styles/large/public/2023-05/2_1_4.jpg', 'https://media.vov.vn/sites/default/files/styles/large/public/2023-05/may_bay.jpg', 'https://media.vov.vn/sites/default/files/styles/large/public/2023-05/anh_1_6_0.jpg', 'https://media.vov.vn/sites/default/files/styles/entity_browser_thumbnail/public/2023-03/hk18.jpg', '1', 'Note A'),
  ('DV0002', 'Vinpearl Resort', 'callcenter@vinpearl.com', '1900232389', 'Alen Nguyễn', '0880219188', 'Toa nha Symphony Duy Man', 'Vinhomes Riverside', 'Quận Long Biên', 'Ha Noi', 'https://statics.vinpearl.com/styles/218x218/public/2021_07/VCCNT_Facade6_1625819999.jpg.webp?itok=mGUirXiu', 'https://statics.vinpearl.com/styles/218x218/public/2021_07/VCCNT_Facade6_1625819999.jpg.webp?itok=mGUirXiu', 'https://statics.vinpearl.com/styles/218x218/public/2021_07/Convention%20Center%201_1625821349.jpg.webp?itok=vfw-N4Dq', 'https://vinpearl.com/themes/porto/images/new-homepage/vp-logo-blue.svg', 'https://statics.vinpearl.com/styles/images_1440_x_428/public/2021_07/Banner-1440x428%202_1626145963.jpg.webp?itok=JjiPw5fS', '2', 'Note B'),
  ('DV0003', 'Hồ Tràm Resort', 'info@meliahotram.com', '0254378900', 'Trần Tuyết', '0902262218', '', 'Phường Phước Thừa', 'Quận Xuyên Mộc', 'Tinh Ba Ria Vung Tau', 'Image11', 'Image12', 'Image13', 'Image14', 'Image15', '3', 'Note C'),
  ('DV0004', 'Xe Phương Trang', '', ' 19006067', 'Nguyễn Vân Anh', '0241224226', '1 Tô Hiến Thành', 'Phuong 1', 'Thành phố Đà Lạt', 'Tỉnh Lâm Đồng', 'Image16', 'Image17', 'Image18', 'Image19', 'Image20', '1', 'Note D'),
  ('DV0005', 'Kiwami Japanese Nha Trang', '', '', '', '', '', '', '', '', '', '', '', '', '', '2', 'Note E'),
  ('DV0006', 'Nhà Hàng Champa Garden', '', '', '', '', '304 Hai Tháng Tư', 'P. Vĩnh Thọ', 'Nha Trang', 'Khánh Hoà', '', '', '', '', '', '3', 'Note F'),
  ('DV0007', 'Nhà Hàng Yến Sào Khánh Hòa', '', '', '', '', 'Phạm Văn Đồng', 'Vĩnh Thọ', 'Thành phố Nha Trang', 'Khánh Hòa', '', '', '', '', '', '3', 'Note G'),
  ('DV0008', 'Louisiane Brewhouse', '', '', '', '', '', '', 'Nha Trang', 'Khánh Hoà', '', '', '', '', '', '3', 'Note H');


INSERT INTO KhachHang (MaKH, CMND, HoTen, Email, DienThoai, NgaySinh, DiaChi)
VALUES
  ('KH0001', '080405001113', 'Nguyễn Thị Hương', 'huong@gmail.com', '0262328812', '1990-05-15', '12 Đường Le Loi'),
  ('KH0002', '080116412214', 'Lê Minh Đức', 'duc@gmail.com', '0276243210', '1985-10-20', '6 Đường Tran Hung Dao'),
  ('KH0003', '080925437618', 'Trần Văn An', 'an@gmail.com', '5551234567', '1998-03-03', '45 Đường Nguyễn Huệ'),
  ('KH0004', '080743821590', 'Phạm Thị Linh', 'linh@gmail.com', '7778889999', '1982-07-12', '31 Đường Ngô Gia Tự'),
  ('KH0005', '080336918475', 'Võ Hải Nam', 'nam@yahoo.com', '5555555555', '1992-08-10', '79 Đường Lý Thường Kiệt'),
  ('KH0006', '080752872932', 'Nguyễn Thanh Hà', 'ha@gmail.com', '4444444444', '1987-02-18', '1241 Đường Lê Duẩn'),
  ('KH0007', '080850390724', 'Trần Bảo Ngọc', 'ngoc@gmail.com', '3333333333', '2000-11-30', '4 Đường Nguyễn Văn Trỗi'),
  ('KH0008', '080521543093', 'Lê Quang Huy', 'huy@gmail.com', '2222222222', '1989-04-25', '79 Đường Phan Chu Trinh'),
  ('KH0009', '080405001114', 'Nguyễn Thị Hồng', 'hong@gmail.com', '0262328813', '1991-05-16', '13 Đường Le Loi'),
  ('KH0010', '080116412215', 'Lê Minh Đăng', 'dang@gmail.com', '0276243211', '1986-10-21', '7 Đường Tran Hung Dao'),
  ('KH0011', '080925437619', 'Trần Văn Bình', 'binh@gmail.com', '5551234568', '1999-03-04', '46 Đường Nguyễn Huệ'),
  ('KH0012', '080743821591', 'Phạm Thị Mai', 'mai@gmail.com', '7778889990', '1983-07-13', '32 Đường Ngô Gia Tự'),
  ('KH0013', '080336918476', 'Võ Hải Dương', 'duong@yahoo.com', '5555555556', '1993-08-11', '80 Đường Lý Thường Kiệt'),
  ('KH0014', '080752872933', 'Nguyễn Thanh Hải', 'hai@gmail.com', '4444444445', '1988-02-19', '1242 Đường Lê Duẩn'),
  ('KH0015', '080850390725', 'Trần Bảo Nhiên', 'nhien@gmail.com', '3333333334', '2001-11-30', '5 Đường Nguyễn Văn Trỗi'),
  ('KH0016', '080521543094', 'Lê Quang Hùng','hung@gmail.com','2222222223','1990-04-26','80 Đường Phan Chu Trinh'),
  ('KH0017','080405001115','Nguyễn Thị Lan','lan@gmail.com','0262328814','1992-05-17','14 Đường Le Loi'),
  ('KH0018','080116412216','Lê Minh Hoàng','hoang@gmail.com','0276243212','1987-10-22','8 Đường Tran Hung Dao'),
  ('KH0019','080925437620','Trần Văn Cường','cuong@gmail.com','5551234569','2000-03-05','47 Đường Nguyễn Huệ'),
  ('KH0020','080743821592','Phạm Thị Nga','nga@gmail.com','7778889991','1984-07-14','33 Đường Ngô Gia Tự'),
  ('KH0021','080336918477','Võ Hải Long','long@yahoo.com','5555555557','1994-08-12','81 Đường Lý Thường Kiệt'),
  ('KH0022','080752872934','Nguyễn Thanh Hồng','hong@gmail.com','4444444446','1989-02-20','1243 Đường Lê Duẩn'),
  ('KH0023','080850390726','Trần Bảo Nga','nga@gmail.com','3333333335','2002-11-30','6 Đường Nguyễn Văn Trỗi');


INSERT INTO KhachDoan (MaDoan, TenCoQuan, Email, DienThoai, DiaChi, MaDaiDien)
VALUES
  ('KD0001', 'Đoàn trường Lê Quý Đôn', 'lqdedu@gmail.com', '0555231232', 'Phường 6, Quận 3, Thành phố Hồ Chí Minh', 'KH0005'),
  ('KD0002', 'Đoàn công ty CP MvM', 'mvme@mvm.com', '01232263354', 'Quận 5, Thành phố Hồ Chí Minh', 'KH0006'),
  ('KD0003', 'Bảo Ngọc Group', 'ngoc@gmail.com', '0956198888', 'Đống Đa, Hà Nội', 'KH0007'),
  ('KD0004', 'Đoàn công ty SVN', 'svcontact@svn.com', '0248246247', 'Ấp 5, Xã Nhựt Chánh, Huyện Bến Lức, Tỉnh Long An', 'KH0008');

INSERT INTO KhachDoanGomKhachLe (MaDoan, MaKH) 
VALUES
  ('KD0001', 'KH0001'),
  ('KD0001', 'KH0005'),
  ('KD0002', 'KH0002'),
  ('KD0002', 'KH0006'),
  ('KD0003', 'KH0003'),
  ('KD0003', 'KH0007'),
  ('KD0004', 'KH0004'),
  ('KD0004', 'KH0008'),
  ('KD0001', 'KH0009'),
  ('KD0001', 'KH0010'),
  ('KD0001', 'KH0011'),
  ('KD0001', 'KH0012'),
  ('KD0002', 'KH0013'),
  ('KD0002', 'KH0014'),
  ('KD0002', 'KH0015'),
  ('KD0002', 'KH0016'),
  ('KD0003', 'KH0020'),
  ('KD0004', 'KH0018'),
  ('KD0004', 'KH0019'),
  ('KD0004', 'KH0021'),
  ('KD0004', 'KH0022');

INSERT INTO Tour (TenTour, image, NgayBatDau, SoKhachTourToiThieu, SoKhachTourToiDa, GiaVeLeNguoiLon, GiaVeLeTreEm, GiaVeDoanNguoiLon, GiaVeDoanTreEm, SoKhachDoanToiThieu, SoDem, SoNgay, MaCN)
VALUES
  ('Tour Nha Trang', 'ImageX', '2023-01-15', 5, 15, 120.00, 60.00, 110.00, 55.00, 3, 2, 6, 'CN0001'),
  ('Tour Đà Lạt', 'ImageY', '2023-02-20', 8, 18, 150.00, 75.00, 140.00, 70.00, 4, 3, 5, 'CN0002'),
  ('Tour Hạ Long', 'ImageB', '2023-06-20', 8, 18, 150.00, 75.00, 140.00, 70.00, 4, 3, 5, 'CN0001'),
  ('Tour Huế', 'ImageC', '2023-07-10', 10, 25, 180.00, 90.00, 170.00, 85.00, 5, 4, 8, 'CN0002');

INSERT INTO NgayKhoiHanhTourDaiNgay (MaTour, Ngay)
VALUES
  ('CN0001-000001', 1),
  ('CN0001-000003', 15),
  ('CN0002-000002', 5),
  ('CN0002-000004', 20);

INSERT INTO LichTrinhTour (MaTour, STTNgay)
VALUES
  ('CN0001-000001', 1),
  ('CN0001-000003', 2),
  ('CN0002-000002', 1),
  ('CN0002-000004', 2);

INSERT INTO TourGomDiaDiemThamQuan (MaTour, STTNgay, MaDiem, ThoiGianBatDau, ThoiGianKetThuc, MoTa)
VALUES
  ('CN0001-000001', 1, 8, '08:00:00', '10:00:00', 'Tham quan VinWonder'),
  ('CN0001-000003', 2, 2, '10:30:00', '12:00:00', 'Explore Park'),
  ('CN0002-000002', 1, 3, '09:00:00', '11:00:00', 'Historical Site'),
  ('CN0002-000004', 2, 4, '12:30:00', '15:00:00', 'Cultural Center');

#15
INSERT INTO HanhDongLichTrinhTour (MaTour, STTNgay, LoaiHanhDong, GioBatDau, GioKetThuc, MoTa)
VALUES
  ('CN0001-000001', 1, '1', '03:00:00', '07:00:00', ''),
  ('CN0001-000003', 2, '2', '09:30:00', '10:00:00', 'Lunch Break'),
  ('CN0002-000002', 1, '1', '09:00:00', '10:30:00', 'Introduction'),
  ('CN0002-000004', 2, '3', '13:00:00', '14:00:00', 'Workshop');
  
INSERT INTO ChuyenDi (MaTour, NgayKhoiHanh, NgayKetThuc)
VALUES
  ('CN0001-000001', '2023-01-15', '2023-01-16'),
  ('CN0001-000003', '2023-06-20', '2023-02-21'),
  ('CN0002-000002', '2023-02-20', '2023-6-22'),
  ('CN0002-000004', '2023-07-10', '2023-07-11');

INSERT INTO HuongDanVienDanChuyen (MaTour, NgayKhoiHanh, MaHDV)
VALUES
  ('CN0001-000001', '2023-01-15', 'HD0001'),
  ('CN0001-000003', '2023-06-20', 'HD0002'),
  ('CN0002-000002', '2023-02-20', 'HD0003'),
  ('CN0002-000004', '2023-07-10', 'HD0004');

INSERT INTO LichTrinhChuyen (MaTour, NgayKhoiHanh, STTNgay)
VALUES
  ('CN0001-000001', '2023-01-15', 1),
  ('CN0001-000003', '2023-06-20', 1),
  ('CN0002-000002', '2023-02-20', 1),
  ('CN0002-000004', '2023-07-10', 1);

#17
INSERT INTO DonViCungCapDichVuChuyen (MaTour, NgayKhoiHanh, STTNgay, LoaiDichVu, MaDV)
VALUES
  ('CN0001-000001', '2023-01-15', 1, '1', 'DV0004'),
  ('CN0001-000003', '2023-06-20', 1, '2', 'DV0002'),
  ('CN0002-000002', '2023-02-20', 1, '1', 'DV0003'),
  ('CN0002-000004', '2023-07-10', 1, '3', 'DV0004');

INSERT INTO DonViCungCapDichVuLienQuan (MaTour, MaDiem, MaDV)
VALUES
  ('CN0001-000001', 1, 'DV0001'),
  ('CN0001-000003', 2, 'DV0002'),
  ('CN0002-000002', 3, 'DV0003'),
  ('CN0002-000004', 4, 'DV0004');
  
DELIMITER //
CREATE TRIGGER CapNhatTongGiaInsert
AFTER INSERT ON phieudangky
FOR EACH ROW
BEGIN
    DECLARE giave DECIMAL(15, 2);
    DECLARE VeLeNguoiLon DECIMAL(10, 2);
    DECLARE VeLeTreEm DECIMAL(10, 2);
    DECLARE VeDoanNguoiLon DECIMAL(10, 2);
    DECLARE VeDoanTreEm DECIMAL(10, 2);
    DECLARE tuoiKH INT;

    SELECT GiaVeLeNguoiLon, GiaVeLeTreEm, GiaVeDoanNguoiLon, GiaVeDoanTreEm
    INTO VeLeNguoiLon, VeLeTreEm, VeDoanNguoiLon, VeDoanTreEm
    FROM tour
    WHERE MaTour = NEW.MaTour;

    SET giave = 0;

    IF NEW.MaKHL IS NOT NULL THEN 
        SELECT TIMESTAMPDIFF(YEAR, KhachHang.NgaySinh, NEW.NgayKhoiHanh)
        INTO tuoiKH
        FROM KhachHang
        WHERE MaKH = NEW.MaKHL;
        IF tuoiKH <= 10 THEN
            SET giave = giave + VeLeTreEm;
        ELSE 
            SET giave = giave + VeLeNguoiLon;
        END IF;
    ELSE
        SELECT SUM(
            CASE 
                WHEN TIMESTAMPDIFF(YEAR, k.NgaySinh, NEW.NgayKhoiHanh) <= 10 THEN VeDoanTreEm
                ELSE VeDoanNguoiLon
            END
        ) INTO giave
        FROM khachhang k
        JOIN khachdoangomkhachle kdgkl ON kdgkl.MaKH = k.MaKH
        WHERE kdgkl.MaDoan = NEW.MaKHD;
    END IF;

    UPDATE chuyendi c
    SET c.TongGia = c.TongGia + giave
    WHERE c.MaTour = NEW.MaTour;
END;

//
DELIMITER ;

DELIMITER //
CREATE TRIGGER CapNhatTongGiaDelete
AFTER DELETE ON phieudangky
FOR EACH ROW
BEGIN
    DECLARE giave DECIMAL(15, 2);
    DECLARE VeLeNguoiLon DECIMAL(10, 2);
    DECLARE VeLeTreEm DECIMAL(10, 2);
    DECLARE VeDoanNguoiLon DECIMAL(10, 2);
    DECLARE VeDoanTreEm DECIMAL(10, 2);
    DECLARE tuoiKH INT;

    SELECT GiaVeLeNguoiLon, GiaVeLeTreEm, GiaVeDoanNguoiLon, GiaVeDoanTreEm
    INTO VeLeNguoiLon, VeLeTreEm, VeDoanNguoiLon, VeDoanTreEm
    FROM tour
    WHERE MaTour = OLD.MaTour;

    SET giave = 0;

    IF OLD.MaKHL IS NOT NULL THEN 
        SELECT TIMESTAMPDIFF(YEAR, KhachHang.NgaySinh, OLD.NgayKhoiHanh)
        INTO tuoiKH
        FROM KhachHang
        WHERE MaKH = OLD.MaKHL;
        IF tuoiKH <= 10 THEN
            SET giave = giave + VeLeTreEm;
        ELSE 
            SET giave = giave + VeLeNguoiLon;
        END IF;
    ELSE
        SELECT SUM(
            CASE 
                WHEN TIMESTAMPDIFF(YEAR, k.NgaySinh, OLD.NgayKhoiHanh) <= 10 THEN VeDoanTreEm
                ELSE VeDoanNguoiLon
            END
        ) INTO giave
        FROM khachhang k
        JOIN khachdoangomkhachle kdgkl ON kdgkl.MaKH = k.MaKH
        WHERE kdgkl.MaDoan = OLD.MaKHD;
    END IF;

    UPDATE chuyendi c
    SET c.TongGia = c.TongGia - giave
    WHERE c.MaTour = OLD.MaTour;
END;
//
DELIMITER ;

INSERT INTO PhieuDangKy (NgayDangKy, GhiChu, MaNV, MaKHL, MaKHD, MaTour, NgayKhoiHanh)
VALUES
  ('2021-08-15', 'Note A', 'VP0001', 'KH0001', NULL, 'CN0001-000001', '2023-01-15'),
  ('2021-09-20', 'Note B', 'VP0002', NULL, 'KD0002', 'CN0001-000003', '2023-06-20'),
  ('2021-10-10', 'Note C', 'VP0003', 'KH0003', NULL, 'CN0002-000002', '2023-02-20'),
  ('2021-11-05', 'Note D', 'VP0004', 'KH0004', NULL, 'CN0002-000004', '2023-07-10');

ALTER TABLE chinhanh
ADD FOREIGN KEY (MaNVQuanLy) REFERENCES NhanVien (MaNV);

ALTER TABLE SoDienThoaiChiNhanh
ADD PRIMARY KEY (MaCN, DienThoai),
ADD FOREIGN KEY (MaCN) REFERENCES ChiNhanh (MaCN);

ALTER TABLE NhanVien
ADD CHECK (GioiTinh IN ('F', 'M')),
ADD CHECK (LoaiNV IN ('1','2')),
ADD FOREIGN KEY (MaCNLamViec) REFERENCES ChiNhanh (MaCN);

ALTER TABLE ngoaingunhanvien
ADD PRIMARY KEY (MaNV, NgoaiNgu),
ADD FOREIGN KEY (MaNV) REFERENCES NhanVien (MaNV);

ALTER TABLE KyNangNhanVien
ADD PRIMARY KEY (MaNV, KyNang),
ADD FOREIGN KEY (MaNV) REFERENCES NhanVien (MaNV);

ALTER TABLE DonViCungCapDichVu
ADD CHECK (Loai IN ('1','2','3'));


ALTER TABLE KhachDoan
ADD FOREIGN KEY (MaDaiDien) REFERENCES KhachHang (MaKH);

ALTER TABLE KhachDoanGomKhachLe
ADD PRIMARY KEY (MaDoan, MaKH),
ADD FOREIGN KEY (MaDoan) REFERENCES KhachDoan (MaDoan),
ADD FOREIGN KEY (MaKH) REFERENCES KhachHang (MaKH);

ALTER TABLE Tour
ADD CHECK (SoKhachTourToiThieu > 0),
ADD CHECK (SoKhachTourToiDa > SoKhachTourToiThieu),
ADD CHECK (GiaVeDoanTreEm < GiaVeDoanNguoiLon),
ADD CHECK (GiaVeLeTreEm < GiaVeLeNguoiLon),
ADD CHECK (GiaVeDoanNguoiLon < GiaVeLeNguoiLon),
ADD CHECK (GiaVeDoanTreEm < GiaVeLeTreEm),
ADD CHECK (SoDem>0),
ADD CHECK (SoNgay>0),
ADD FOREIGN KEY (MaCN) REFERENCES ChiNhanh (MaCN);

ALTER TABLE NgayKhoiHanhTourDaiNgay
ADD CHECK (Ngay >=1 AND Ngay<=31),
ADD PRIMARY KEY (MaTour,Ngay),
ADD FOREIGN KEY (MaTour) REFERENCES Tour (MaTour); 

ALTER TABLE LichTrinhTour
ADD PRIMARY KEY (MaTour, STTNgay),
ADD FOREIGN KEY (MaTour) REFERENCES Tour (MaTour);

ALTER TABLE TourGomDiaDiemThamQuan
ADD CHECK (ThoiGianBatDau<ThoiGianKetThuc),
ADD PRIMARY KEY (MaTour, STTNgay, MaDiem),
ADD FOREIGN KEY (MaTour, STTNgay) REFERENCES LichTrinhTour (MaTour, STTNgay),
ADD FOREIGN KEY (MaDiem) REFERENCES DiemDuLich (MaDiem);

ALTER TABLE HanhDongLichTrinhTour
ADD CHECK (LoaiHanhDong IN (1,2,3,4,5,6,7)),
ADD PRIMARY KEY (MaTour, STTNgay, LoaiHanhDong),
ADD FOREIGN KEY (MaTour, STTNgay) REFERENCES LichTrinhTour (MaTour, STTNgay);

ALTER TABLE ChuyenDi
ADD PRIMARY KEY (MaTour, NgayKhoiHanh),
ADD FOREIGN KEY (MaTour) REFERENCES Tour (MaTour);

ALTER TABLE HuongDanVienDanChuyen
ADD PRIMARY KEY (MaTour, NgayKhoiHanh),
ADD FOREIGN KEY (MaTour, NgayKhoiHanh) REFERENCES ChuyenDi (MaTour, NgayKhoiHanh),
ADD FOREIGN KEY (MaHDV) REFERENCES NhanVien (MaNV);

ALTER TABLE LichTrinhChuyen
ADD PRIMARY KEY (MaTour, NgayKhoiHanh, STTNgay),
ADD FOREIGN KEY (MaTour, NgayKhoiHanh) REFERENCES ChuyenDi (MaTour, NgayKhoiHanh);

ALTER TABLE DonViCungCapDichVuChuyen
ADD CHECK (LoaiDichVu IN (1,2,3,4,5,6,7,8)),
ADD PRIMARY KEY (MaTour, NgayKhoiHanh, STTNgay, LoaiDichVu, MaDV),
ADD FOREIGN KEY (MaTour, NgayKhoiHanh, STTNgay) REFERENCES LichTrinhChuyen (MaTour, NgayKhoiHanh, STTNgay),
ADD FOREIGN KEY (MaDV) REFERENCES DonViCungCapDichVu (MaDV);

ALTER TABLE PhieuDangKy
ADD FOREIGN KEY (MaNV) REFERENCES NhanVien (MaNV),
ADD FOREIGN KEY (MaKHL) REFERENCES KhachHang (MaKH),
ADD FOREIGN KEY (MaKHD) REFERENCES KhachDoan (MaDoan),
ADD FOREIGN KEY (MaTour, NgayKhoiHanh) REFERENCES ChuyenDi (MaTour, NgayKhoiHanh);

ALTER TABLE DonViCungCapDichVuLienQuan
ADD PRIMARY KEY (MaTour, MaDiem, MaDV),
ADD FOREIGN KEY (MaTour) REFERENCES Tour (MaTour),
ADD FOREIGN KEY (MaDiem) REFERENCES DiemDuLich (MaDiem),
ADD FOREIGN KEY (MaDV) REFERENCES DonViCungCapDichVu (MaDV);

INSERT INTO LichTrinhTour (MaTour, STTNgay)
VALUES
	('CN0001-000001', 2),
	('CN0001-000003', 1),
	('CN0002-000004', 1);  

INSERT INTO LichTrinhChuyen (MaTour, NgayKhoiHanh, STTNgay)
VALUES
  ('CN0001-000001', '2023-01-15', 2),
  ('CN0001-000003', '2023-06-20', 2),
  ('CN0002-000004', '2023-07-10', 2);
  	
INSERT INTO TourGomDiaDiemThamQuan (MaTour, STTNgay, MaDiem, ThoiGianBatDau, ThoiGianKetThuc, MoTa)
VALUES
	('CN0001-000001', 1, 3, '14:00:00', '16:00:00', 'Sử dụng các dịch vụ vui chơi'),
  ('CN0001-000001', 1, 9, '16:30:00', '17:30:00', 'Lặn biển tại Diving Club'),
  ('CN0001-000001', 2, 7, '08:00:00', '11:00:00', 'Tham quan Viện Hải Dương học');
  
INSERT INTO HanhDongLichTrinhTour (MaTour, STTNgay, LoaiHanhDong, GioBatDau, GioKetThuc, MoTa)
VALUES
	('CN0001-000001', 1, '6', '07:00:00', '08:00:00', ''),
  ('CN0001-000001', 1, '4', '10:00:00', '12:00:00', ''),
  ('CN0001-000001', 1, '5', '18:00:00', '20:00:00', ''),
  ('CN0001-000001', 2, '3', '07:00:00', '08:00:00', ''),
  ('CN0001-000001', 2, '4', '10:00:00', '12:00:00', ''),
  ('CN0001-000001', 2, '7', '15:00:00', '16:00:00', ''),
  ('CN0001-000001', 2, '2', '16:00:00', '21:00:00', '');

INSERT INTO DonViCungCapDichVuChuyen (MaTour, NgayKhoiHanh, STTNgay, LoaiDichVu, MaDV)
VALUES  
  ('CN0001-000001', '2023-01-15', 1, '8', 'DV0004'),
  ('CN0001-000001', '2023-01-15', 1, '6', 'DV0002'),
  ('CN0001-000001', '2023-01-15', 1, '4', 'DV0002'),
  ('CN0001-000001', '2023-01-15', 1, '5', 'DV0002'),
  ('CN0001-000001', '2023-01-15', 2, '8', 'DV0004'),
  ('CN0001-000001', '2023-01-15', 2, '3', 'DV0006'),
  ('CN0001-000001', '2023-01-15', 2, '4', 'DV0008'),
  ('CN0001-000001', '2023-01-15', 2, '7', 'DV0002'),
  ('CN0001-000001', '2023-01-15', 2, '2', 'DV0004');
  
INSERT INTO PhieuDangKy (NgayDangKy, GhiChu, MaNV, MaKHL, MaKHD, MaTour, NgayKhoiHanh)
VALUES
	('2023-01-05', 'Note A', 'VP0003', 'KH0002', NULL, 'CN0001-000001', '2023-01-15'),
  ('2023-01-05', 'Note A', 'VP0003', 'KH0003', NULL, 'CN0001-000001', '2023-01-15'),
  ('2023-01-05', 'Note A', 'VP0003', 'KH0004', NULL, 'CN0001-000001', '2023-01-15'),
  ('2023-01-05', 'Note A', 'VP0003', 'KH0005', NULL, 'CN0001-000001', '2023-01-15'),
  ('2023-01-05', 'Note A', 'VP0003', 'KH0006', NULL, 'CN0001-000001', '2023-01-15'),
  ('2023-06-15', 'Note B', 'VP0001', NULL, 'KD0002', 'CN0001-000003', '2023-06-20'),
  ('2023-02-10', 'Note C', 'VP0001', NULL, 'KD0003', 'CN0002-000002', '2023-02-20');
  
  
DELIMITER //

CREATE FUNCTION soluongkhach(ma_tour VARCHAR(13), ngay_khoi_hanh DATE)
RETURNS INT DETERMINISTIC
BEGIN 
    DECLARE so_luong_khach INT;
    
    SELECT 
        IFNULL(SUM(CASE WHEN p.MaKHL IS NOT NULL THEN 1 ELSE 0 END), 0) +
        IFNULL(SUM(kdgkl.SoLuong), 0) AS TongSoKhach
    INTO so_luong_khach
    FROM phieudangky p
    LEFT JOIN (
        SELECT MaDoan, COUNT(*) AS SoLuong
        FROM khachdoangomkhachle
        GROUP BY MaDoan
    ) kdgkl ON p.MaKHD = kdgkl.MaDoan
    WHERE p.MaTour = ma_tour AND p.NgayKhoiHanh = ngay_khoi_hanh;
    
    RETURN so_luong_khach;
END //


DELIMITER ;

SELECT soluongkhach('CN0001-000001', '2023-01-15') AS TongSoKhach;


DELIMITER //

CREATE PROCEDURE ThongKeDoanhThu(IN namThongKe INT)
BEGIN
  DECLARE thang INT;
  DECLARE tongDoanhThu DECIMAL(15, 2);

  SET thang = 1;

  DROP TEMPORARY TABLE IF EXISTS TempThongKe;
  CREATE TEMPORARY TABLE TempThongKe (
    Thang INT,
    TongDoanhThu DECIMAL(15, 2)
  );

  WHILE thang <= 12 DO
    SET tongDoanhThu = (
      SELECT SUM(TongGia)
      FROM ChuyenDi
      WHERE YEAR(NgayKhoiHanh) = namThongKe
        AND MONTH(NgayKhoiHanh) = thang
    );

    INSERT INTO TempThongKe (Thang, TongDoanhThu)
    VALUES (thang, tongDoanhThu);

    SET thang = thang + 1;
  END WHILE;

  SELECT * FROM TempThongKe;

  DROP TEMPORARY TABLE IF EXISTS TempThongKe;
END;
//

DELIMITER ;

CALL ThongKeDoanhThu(2023);
DELIMITER //
CREATE TRIGGER CheckLichTrinhChuyen
BEFORE INSERT ON lichtrinhchuyen
FOR EACH ROW 
BEGIN 
	DECLARE existing_schedule INT;
	SELECT COUNT(*) INTO existing_schedule
	FROM lichtrinhtour l
	WHERE l.MaTour = NEW.MaTour AND l.STTNgay = NEW.STTNgay;
	
	if existing_schedule = 0 then 
		SIGNAL SQLSTATE '45000'
            SET MESSAGE_TEXT = 'Lich trinh chuyen khong ton tai trong tour';
    END IF;
END;
//
DELIMITER;

INSERT INTO LichTrinhTour (MaTour, STTNgay)
VALUES
	('CN0001-000001', 3);
	
INSERT INTO LichTrinhChuyen (MaTour, NgayKhoiHanh, STTNgay)
VALUES
  ('CN0001-000001', '2023-01-15', 3);	

DELIMITER //
CREATE TRIGGER CheckActivityExists
BEFORE INSERT ON DonViCungCapDichVuChuyen
FOR EACH ROW
BEGIN
    DECLARE activity_exists INT;
    SELECT COUNT(*) INTO activity_exists
    FROM HanhDongLichTrinhTour
    WHERE MaTour = NEW.MaTour AND STTNgay = NEW.STTNgay AND LoaiHanhDong = NEW.LoaiDichVu;
    IF activity_exists = 0 AND NEW.LoaiDichVu != '8' THEN
        SIGNAL SQLSTATE '45000'
            SET MESSAGE_TEXT = 'Loai hoat dong khong ton tai trong lich trinh tour';
    END IF;
END;
//
DELIMITER ;



INSERT INTO PhieuDangKy (NgayDangKy, GhiChu, MaNV, MaKHL, MaKHD, MaTour, NgayKhoiHanh)
VALUES
	('2023-01-05', 'Note A', 'VP0003', 'KH0022', NULL, 'CN0001-000001', '2023-01-15');

DELETE FROM phieudangky
WHERE MaPhieu = '05012023000000004';


DELIMITER //
CREATE PROCEDURE LichTrinhChuyen(IN tour_id CHAR(13), IN departure_date DATE)
BEGIN
    DECLARE done INT DEFAULT 0;
    DECLARE action_id CHAR(13);
    DECLARE action_type INT;
    DECLARE start_time TIME;
    DECLARE end_time TIME;
    DECLARE location VARCHAR(255);
    DECLARE transport_unit VARCHAR(255);
    DECLARE stt_ngay INT;
    DECLARE branch CHAR(6);
    DECLARE output_text TEXT;

    DECLARE cur CURSOR FOR
    SELECT
        hdt.MaTour,
        hdt.LoaiHanhDong,
        hdt.GioBatDau,
        hdt.GioKetThuc,
        dd.TenDiem,
        tu.TenDV,
        ltc.STTNgay,
        tour.MaCN
   FROM
   	lichtrinhchuyen ltc
   INNER JOIN 
        HanhDongLichTrinhTour hdt ON ltc.MaTour =hdt.MaTour 
	INNER JOIN
        TourGomDiaDiemThamQuan tourdd ON hdt.MaTour = tourdd.MaTour AND hdt.STTNgay = tourdd.STTNgay
   INNER JOIN
        DiemDuLich dd ON tourdd.MaDiem = dd.MaDiem
   INNER JOIN
        tour ON hdt.MaTour = Tour.MaTour
   INNER JOIN
        DonViCungCapDichVuChuyen dvvc ON ltc.MaTour = dvvc.MaTour AND dvvc.NgayKhoiHanh = ltc.NgayKhoiHanh AND dvvc.STTNgay=hdt.STTNgay
   INNER JOIN 
        DonViCungCapDichVu tu ON dvvc.MaDV = tu.MaDV AND ltc.STTNgay=hdt.STTNgay AND hdt.LoaiHanhDong=dvvc.LoaiDichVu AND dvvc.MaTour=ltc.MaTour AND dvvc.NgayKhoiHanh=ltc.NgayKhoiHanh
   WHERE ltc.MaTour = tour_id AND ltc.NgayKhoiHanh = departure_date
   ORDER BY
        hdt.STTNgay, hdt.GioBatDau;
        
    DECLARE CONTINUE HANDLER FOR NOT FOUND SET done = 1;

    OPEN cur;

    SET @current_date = NULL;
    SET @current_transport_unit = NULL;
    SET output_text = '';
    SET @cur_start_branch= NULL;
    SET @cur_end_branch= NULL;
    SET @cur_num=NULL;


    read_loop: LOOP
        FETCH cur INTO action_id, action_type, start_time, end_time, location, transport_unit,stt_ngay, branch;

        IF done THEN
            LEAVE read_loop;
        END IF;

        IF @current_date IS NULL OR @current_date <> stt_ngay THEN
            SET @current_date = stt_ngay;
            SET output_text = CONCAT(output_text,'Ngày ', stt_ngay, ': đơn vị vận chuyển <<', transport_unit, '>>','\n');
        END IF;

        CASE action_type
            WHEN 1 THEN
            	IF @cur_start_branch IS NULL OR @cur_start_branch <> branch THEN
            	SET @cur_start_branch = branch;
            	SET output_text = CONCAT(output_text,TIME_FORMAT(start_time, '%H:%i'), ': khởi hành từ ', branch,'\n') ;
            	END IF;
            WHEN 2 THEN
            	IF @cur_end_branch IS NULL OR @cur_end_branch <> branch THEN
            	SET @cur_end_branch=branch;
               SET output_text = CONCAT(output_text,TIME_FORMAT(start_time, '%H:%i'), ': kết thúc tour tại ', branch,'\n');
               END IF;
            WHEN 3 THEN
            	IF @cur_num IS NULL OR @cur_num <> action_type THEN
            	SET @cur_num=action_type;
               SET output_text = CONCAT(output_text,TIME_FORMAT(start_time, '%H:%i'), ' → ', TIME_FORMAT(end_time, '%H:%i'), ': ăn sáng tại ', transport_unit,'\n');
               END IF;
            WHEN 4 THEN
            	IF @cur_num IS NULL OR @cur_num <> action_type THEN
            	SET @cur_num=action_type;
               SET output_text = CONCAT(output_text,TIME_FORMAT(start_time, '%H:%i'), ' → ', TIME_FORMAT(end_time, '%H:%i'), ': ăn trưa tại ', transport_unit,'\n');
               END IF;
            WHEN 5 THEN
            	IF @cur_num IS NULL OR @cur_num <> action_type THEN
            	SET @cur_num=action_type;
               SET output_text = CONCAT(output_text,TIME_FORMAT(start_time, '%H:%i'), ' → ', TIME_FORMAT(end_time, '%H:%i'), ': ăn tối tại ', transport_unit,'\n');
               END IF;
            WHEN 6 THEN
            	IF @cur_num IS NULL OR @cur_num <> action_type THEN
            	SET @cur_num=action_type;
					SET output_text = CONCAT(output_text,TIME_FORMAT(start_time, '%H:%i'), ' → ', TIME_FORMAT(end_time, '%H:%i'), ': check in tại khách sạn ', location,'\n');
					END IF;
            WHEN 7 THEN
            	IF @cur_num IS NULL OR @cur_num <> action_type THEN
            	SET @cur_num=action_type;
               SET output_text = CONCAT(output_text,TIME_FORMAT(start_time, '%H:%i'), ' → ', TIME_FORMAT(end_time, '%H:%i'), ': check out tại khách sạn ', location,'\n');
               END IF;
        END CASE;
    END LOOP;

    CLOSE cur;
    SELECT output_text AS output;
END;
//
DELIMITER ;
CALL LichTrinhChuyen('CN0001-000001', '2023-01-15');
DELIMITER //

CREATE PROCEDURE InsertLichTrinhTour(
  IN MaTour CHAR(13),
  IN STT_ngay INT
)
BEGIN
  INSERT INTO lichtrinhtour (MaTour,STTNgay)
  VALUES (MaTour,STT_ngay);

END;
//
DELIMITER ;
DELIMITER //
CREATE PROCEDURE InsertHanhDongLichTrinhTour(
    IN in_ma_tour VARCHAR(13),
    IN in_loai_hanh_dong INT,
    IN in_gio_bat_dau TIME,
    IN in_gio_ket_thuc TIME,
    IN in_stt_ngay INT
)
BEGIN
    INSERT INTO HanhDongLichTrinhTour (MaTour, LoaiHanhDong, GioBatDau, GioKetThuc, STTNgay)
    VALUES (in_ma_tour, in_loai_hanh_dong, in_gio_bat_dau, in_gio_ket_thuc, in_stt_ngay);
END;
//
DELIMITER ;

/* ------------*/
CREATE TABLE `tbl_admin` (
  `adminId` int(11) NOT NULL,
  `adminName` varchar(255) NOT NULL,
  `adminEmail` varchar(150) NOT NULL,
  `adminUser` varchar(255) NOT NULL,
  `adminPass` varchar(255) NOT NULL,
  `level` int(30) NOT NULL
);

INSERT INTO `tbl_admin` (`adminId`, `adminName`, `adminEmail`, `adminUser`, `adminPass`, `level`) VALUES
(2, 'Lê Khanh', 'khanh.nguyennlk41@hcmut.edu.vn', 'khanhadmin', 'fcea920f7412b5da7be0cf42b8c93759', 0),
(3, 'Ngọc Rạng', 'rang.thaik21@hcumt.edu.vn', 'RangAdmin', 'f0898af949a373e72a4f6a34b4de9090', 0);

ALTER TABLE `tbl_admin`
  ADD PRIMARY KEY (`adminId`);

ALTER TABLE `tbl_admin`
  MODIFY `adminId` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;
  
  
CREATE TABLE `tbl_schedule` (
  `ID` int(11) NOT NULL,
  `MaTour` varchar(255) NOT NULL,
  `LichTrinh` varchar(255) NOT NULL,
  `MoTa` varchar(255) NOT NULL
);


ALTER TABLE `tbl_schedule`
  ADD PRIMARY KEY (`ID`);

ALTER TABLE `tbl_schedule`
  MODIFY `ID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;