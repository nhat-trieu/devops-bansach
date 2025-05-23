CREATE DATABASE WebBanSach_SQL
GO
USE WebBanSach_SQL
GO
--
CREATE TABLE CATEGORY
(
	MaCate int identity(1,1) constraint CATEGORY_MaCate_PK primary key,
	TenDanhMuc nvarchar(250),
	TrangThai bit,
	ParentID int 
)
GO
CREATE TABLE LOAISACH
(
	MaLoaiSach int identity(1,1)constraint LOAISACH_MaLoaiSach_PK primary key,
	TenLoaiSach nvarchar(250)
)
GO
CREATE TABLE TACGIA
(
	MaTG int identity(1,1)constraint TACGIA_MaTG_PK primary key,
	TenTacGia nvarchar(250)
)
GO
CREATE TABLE NXB
(
	MaNXB int identity(1,1)constraint NXB_MaNXB_PK primary key,
	TenNXB nvarchar(250)
)
GO
CREATE TABLE NCC
(
	MaNCC int identity(1,1)constraint NCC_MaNCC_PK primary key,
	TenNCC nvarchar(250)
)
GO
CREATE TABLE DISCOUNT
(
	MaDisc int identity(1,1)constraint DISCOUNT_MaDisc_PK primary key,
	TenDisc nvarchar(250),
	PhanTram float,
	MoTa text,
	StartTime datetime,
	EndTime datetime
)
GO
CREATE TABLE SACH 
(
	MaSach int identity(1,1)constraint SACH_MaSach_PK primary key,
	TenSach nvarchar(200),
	HinhAnh varchar(200),
	GiaBan decimal,
	TrangThai bit,
	MoTa nvarchar(4000),
	MaNXB_SACH int,
	MaTG_SACH int,
	MaLoaiSach_SACH int,
	MaNCC_SACH int,
	MaCate_SACH int,
	MaDisc_SACH int,
	constraint SACH_MaNXB_FK foreign key (MaNXB_SACH) references NXB(MaNXB),
	constraint SACH_MaTG_FK foreign key (MaTG_SACH) references TacGia(MaTG),
	constraint SACH_MaLoaiSach_FK foreign key (MaLoaiSach_SACH) references	LOAISACH(MaLoaiSach),
	constraint SACH_MaNCC_FK foreign key (MaNCC_SACH) references NCC(MaNCC),
	constraint SACH_MaCate_FK foreign key (MaCate_SACH) references CATEGORY(MaCate),
	constraint SACH_MaDisc_FK foreign key (MaDisc_SACH) references DISCOUNT(MaDisc)
)
GO
CREATE TABLE PHIEUNHAPHANG
(
	MaPN int identity(1,1)constraint PHIEUNHAPHANG_MaPN_PK primary key,
	NgayNhap date,
	MaNCC_PN int,
	constraint PNH_MaNCC_FK foreign key (MaNCC_PN) references NCC(MaNCC)
)
GO
CREATE TABLE CHITIET_PHIEUNHAP
(
	MaPN_CTPN int,
	MaSach_CTPN int,
	GiaNhap decimal,
	SoLuong int,
	ThanhTien decimal,
	constraint CTPN_MaPN_MaSach_PK primary key (MaPN_CTPN, MaSach_CTPN),
	constraint CTPN_MaPN_FK foreign key (MaPN_CTPN) references PHIEUNHAPHANG(MaPN),
	constraint CTPN_MaSach_FK foreign key (MaSach_CTPN) references SACH(MaSach)
)
GO
CREATE TABLE KHACHHANG
(
	MaKH int identity(1,1)constraint KHACHHANG_MaKH_PK primary key,
	TenKH nvarchar(250),
	SDT varchar(15),
	Email varchar(200)
)
GO
CREATE TABLE GIOHANG
(
	MaGH int identity(1,1)constraint GIOHANG_MaGH_PK primary key,
	MaKH_GH int,
	constraint GIOHANG_MaKH_FK foreign key (MaKH_GH) references KHACHHANG(MaKH)
)
GO
CREATE TABLE CHITIET_GIOHANG
(
	MaGH_CTGH int,
	MaSach_CTGH int,
	SoLuong int,
	constraint CTGH_MaGH_MaSach_PK primary key (MaGH_CTGH, MaSach_CTGH),
	constraint CTGH_MaGH_FK foreign key (MaGH_CTGH) references GIOHANG(MaGH),
	constraint CTGH_MaSach_FK foreign key (MaSach_CTGH) references SACH(MaSach)
)
GO
CREATE TABLE DONHANG
(
	MaDH int identity(1,1)constraint DONHANG_MaDH_PK primary key,
	NgayDat date,
	NgayGiao date,
	TinhTrang bit,
	DiaChi_GiaoHang nvarchar(250),
	MaKH_DH int,
	constraint DONHANG_MaKH_FK foreign key (MaKH_DH) references KHACHHANG(MaKH)
)
GO
CREATE TABLE CHITIET_DONHANG
(
	MaDH_CTDH int,
	MaSach_CTDH int,
	SoLuong int,
	ThanhTien decimal,
	TinhTrangThanhToan bit,
	constraint CTDH_MaDH_MaSach_PK primary key (MaDH_CTDH, MaSach_CTDH),
	constraint CTDH_MaDH_FK foreign key (MaDH_CTDH) references DONHANG(MaDH),
	constraint CTDH_MaSach_FK foreign key (MaSach_CTDH) references SACH(MaSach)
	
)
GO
--

CREATE ROLE QuanLy
GRANT SELECT, INSERT, UPDATE, DELETE ON CATEGORY TO QuanLy
GRANT SELECT, INSERT, UPDATE, DELETE ON CHITIET_DONHANG TO QuanLy
GRANT SELECT, INSERT, UPDATE, DELETE ON CHITIET_PHIEUNHAP TO QuanLy
GRANT SELECT, INSERT, UPDATE, DELETE ON DISCOUNT TO QuanLy
GRANT SELECT, INSERT, UPDATE, DELETE ON DONHANG TO QuanLy
GRANT SELECT, INSERT, UPDATE, DELETE ON GIOHANG TO QuanLy
GRANT SELECT, INSERT, UPDATE, DELETE ON KHACHHANG TO QuanLy
GRANT SELECT, INSERT, UPDATE, DELETE ON LOAISACH TO QuanLy
GRANT SELECT, INSERT, UPDATE, DELETE ON NCC TO QuanLy
GRANT SELECT, INSERT, UPDATE, DELETE ON NXB TO QuanLy
GRANT SELECT, INSERT, UPDATE, DELETE ON PHIEUNHAPHANG TO QuanLy
GRANT SELECT, INSERT, UPDATE, DELETE ON SACH TO QuanLy
GRANT SELECT, INSERT, UPDATE, DELETE ON TACGIA TO QuanLy
GRANT SELECT, INSERT, UPDATE, DELETE ON CHITIET_GIOHANG TO QuanLy
GRANT EXEC to QuanLy

CREATE ROLE KhachHang
GRANT SELECT, INSERT, UPDATE ON CHITIET_DONHANG TO KhachHang
GRANT SELECT, INSERT, UPDATE ON DONHANG TO KhachHang
GRANT SELECT, INSERT, UPDATE ON GIOHANG TO KhachHang
GRANT SELECT, INSERT, UPDATE ON KHACHHANG TO KhachHang
GRANT SELECT ON LOAISACH TO KhachHang
GRANT SELECT ON NCC TO KhachHang
GRANT SELECT ON NXB TO KhachHang
GRANT SELECT ON SACH TO KhachHang
GRANT SELECT ON TACGIA TO KhachHang
GRANT SELECT, INSERT, UPDATE ON CHITIET_GIOHANG TO KhachHang
GRANT DELETE ON CHITIET_GIOHANG TO KhachHang
GRANT EXEC to KhachHang


--

CREATE PROCEDURE SP_GetRoleFromPhoneNumber (
	@PhoneNumber varchar(20)
)
AS
BEGIN
	DECLARE @u_Role varchar(20)
	SELECT @u_Role = r.name
	FROM sys.database_role_members rm 
	JOIN sys.database_principals r 
       ON rm.role_principal_id = r.principal_id
	JOIN sys.database_principals m 
       ON rm.member_principal_id = m.principal_id
	WHERE m.name = @PhoneNumber;
	SELECT @u_Role AS user_role
	IF (@u_Role is null)
	BEGIN
		RETURN 1
	END
		RETURN 0
	
END;
GO



--
CREATE PROCEDURE SP_CreateKhachHang (
	@TenLogin varchar(30),
	@SdtKH varchar(20),
	@PW varchar(20)
)
AS
BEGIN
	DECLARE @result int
	EXEC @result = SP_GetRoleFromPhoneNumber @PhoneNumber = @SdtKH
	IF (@result = 1)
	BEGIN
		EXEC sys.sp_addlogin
			@TenLogin,
			@PW
		EXEC sys.sp_adduser
			@TenLogin,
			@SdtKH
		EXEC sys.sp_addrolemember
			'KhachHang',
			@SdtKH
		RETURN 1
	END
	RETURN 0
END;
GO
--




-- Cat 1
INSERT INTO CATEGORY VALUES (N'SÁCH TRONG NƯỚC', 1, null)

-- Cat 2
INSERT INTO CATEGORY VALUES (N'SÁCH NƯỚC NGOÀI', 1, null)

-- Cat 1 - childs
INSERT INTO CATEGORY VALUES (N'VĂN HỌC', 1, 1) -- 3
INSERT INTO CATEGORY VALUES (N'TÂM LÝ KỸ NĂNG SỐNG', 1, 1)  -- 4
INSERT INTO CATEGORY VALUES (N'SÁCH THIẾU NHI', 1, 1)  -- 5

-- Cat 2 - childs
INSERT INTO CATEGORY VALUES (N'FICTION', 1, 2)  -- 6
INSERT INTO CATEGORY VALUES (N'BUSINESS', 1, 2)  -- 7
-- Cat 3 - Childs
INSERT INTO CATEGORY VALUES (N'TIỂU THUYẾT', 1, 3) -- 8
INSERT INTO CATEGORY VALUES (N'TRUYỆN NGẮN', 1, 3)  -- 9
INSERT INTO CATEGORY VALUES (N'NGÔN TÌNH', 1, 3)  -- 10

--Cat 4 - Childs
INSERT INTO CATEGORY VALUES (N'KỸ NĂNG SỐNG', 1, 4) -- 11
INSERT INTO CATEGORY VALUES (N'RÈN LUYỆN NHÂN CÁCH', 1, 4) -- 12
INSERT INTO CATEGORY VALUES (N'TÂM LÝ', 1, 4) -- 13
--Cat 5 -- childs
INSERT INTO CATEGORY VALUES (N'MANGA - COMIC', 1, 5) -- 14
INSERT INTO CATEGORY VALUES (N'VỪA HỌC - VỪA CHƠI', 1, 5) --15
--Cat 6 - childs
INSERT INTO CATEGORY VALUES (N'ROMANCE', 1, 6) --16
INSERT INTO CATEGORY VALUES (N'FANTASY', 1, 6) --17
--Cat 7 - childs
INSERT INTO CATEGORY VALUES (N'BISUNESS & MANAGEMENT', 1, 7) --18
INSERT INTO CATEGORY VALUES (N'ECONOMICS', 1, 7) -- 19
--


INSERT INTO LOAISACH VALUES (N'TIEU TUYET')
INSERT INTO LOAISACH VALUES (N'TRUYEN NGAN')
INSERT INTO LOAISACH VALUES (N'NGON TINH')
INSERT INTO LOAISACH VALUES (N'KỸ NĂNG SỐNG')
INSERT INTO LOAISACH VALUES (N'RÈN LUYỆN NHÂN CÁCH')
INSERT INTO LOAISACH VALUES (N'TÂM LÝ')
INSERT INTO LOAISACH VALUES (N'MANGA - COMIC')
INSERT INTO LOAISACH VALUES (N'VỪA HỌC - VỪA CHƠI')
INSERT INTO LOAISACH VALUES (N'ROMANCE')
INSERT INTO LOAISACH VALUES (N'FANTASY')
INSERT INTO LOAISACH VALUES (N'BISUNESS & MANAGEMENT')
INSERT INTO LOAISACH VALUES (N'ECONOMICS')

INSERT INTO TACGIA VALUES (N'José Mauro de Vasconcelos')
INSERT INTO TACGIA VALUES (N'Nguyễn Nhật Ánh')
INSERT INTO TACGIA VALUES (N'Tớ là Mây')
INSERT INTO TACGIA VALUES (N'Châu Sa Đáy Mắt')
INSERT INTO TACGIA VALUES (N'Miêu Công Tử')
INSERT INTO TACGIA VALUES (N'Dele Carnegie')
INSERT INTO TACGIA VALUES (N'Bác sĩ Đỗ Hồng Ngọc')
INSERT INTO TACGIA VALUES (N'Nhiều tác giả')

INSERT INTO NXB VALUES (N'Giáo Dục Việt Nam')
INSERT INTO NXB VALUES (N'NXB Tổng Hợp TPHCM')
INSERT INTO NXB VALUES (N'NXB Hội Nhà Văn')
INSERT INTO NXB VALUES (N'NXB Trẻ')
INSERT INTO NXB VALUES (N'NXB Thế Giới')
INSERT INTO NXB VALUES (N'NXB Thanh Niên')
INSERT INTO NXB VALUES (N'NXB Dân trí')


INSERT INTO NCC VALUES (N'Giáo Dục Việt Nam')
INSERT INTO NCC VALUES (N'NXB Tổng Hợp TPHCM')
INSERT INTO NCC VALUES (N'NXB Hội Nhà Văn')
INSERT INTO NCC VALUES (N'NXB Trẻ')
INSERT INTO NCC VALUES (N'NXB Thế Giới')
INSERT INTO NCC VALUES (N'NXB Thanh Niên')
INSERT INTO NCC VALUES (N'NXB Dân trí')

INSERT INTO DISCOUNT VALUES (N'Christmas', 10, 'Giáng sinh An lành', '2023-12-13 00:00:00', '2023-12-31 00:00:00')

INSERT INTO SACH VALUES (N'Cây Cam Ngọt Của Tôi', 'https://vbookshop.com/wp-content/uploads/2022/03/Cay-cam-ngot-cua-toi.jpg', 80000, 1, N'Cây cam ngọt của tôi là một câu chuyện vô giá về tình yêu thương. Ta sẽ hiểu sự thấu cảm có thể tác động thế nào đến một con người để biết sống quan tâm, cảm thông hơn với mọi người, nhất là những người thân yêu.', 3, 1, 1, 3, 8, 1 )
INSERT INTO SACH VALUES (N'Mùa Hè Không Tên', 'https://cdnphoto.dantri.com.vn/JACiEwiQGbE-XDfjERcGHl6qUn0=/thumb_w/1020/2023/09/25/7bd5e8ab3320e67ebf3129-1695645000756.jpg', 100000, 1, N'"Ở mùa hè đặc biệt này tôi cần gì phải khoác một tên riêng khi mà mỗi lần đầu óc tôi quay ngược về thời kỳ đó, tôi luôn thấy lòng đầy xáo trộn. Nó đã khắc lên số phận tôi những dấu vết không thể phai mờ - như vết chàm mà con người ta phải mang theo cho đến tận cuối đời."', 4, 2, 1, 4, 8, 1 )
INSERT INTO SACH VALUES (N'Chưa Kịp Lớn Đã Trưởng Thành', 'https://tiki.vn/blog/wp-content/uploads/2023/03/review-sach-chua-kip-lon-da-phai-truong-thanh.jpg', 65000, 1, N'Cuốn sách “Chưa kịp lớn đã phải trưởng thành”  như một cuốn nhật ký nhỏ cho những người trẻ đang lạc lõng và cô đơn trong quá trình trưởng thành của mình, đang lênh đênh giữa những cảm xúc khó khăn. Cuốn sách không quá dài, cũng không quá ngắn, phong cách viết nhẹ nhàng, mộc mạc, chân thành mà giản dị, bài viết dưới góc nhìn đa chiều về các vấn đề chung của tuổi trẻ như: ước mơ, tự do, lỗi lầm và cả những điều khó khăn trên hành trình trưởng thành.', 7, 3, 1, 7, 8, 1 )
INSERT INTO SACH VALUES (N'Đám Trẻ Ở Đại Dương Đen', 'https://www.netabooks.vn/Data/Sites/1/media/sach-2023/dam-tre-o-dai-duong-den/dam-tre-o-dai-duong-den.jpg', 80000, 1, N'Trong Đám Trẻ Ở Đại Dương Đen, lần theo từng dòng nước mà tác giả Châu Sa Đáy Mắt vạch ra, ta tìm thấy những đứa trẻ cuộn mình trong dòng nước đen láy ấy, có vài đứa sẽ cố vùng vẫy, cũng có vài đứa chán nản bỏ mặc sự đời,… dẫu cảm xúc làm tê liệt người ta với hàng tá thất vọng, dẫu tồi tệ đến nhường nào thì những đứa trẻ mà tác giả viết nên, đều có gì đó đau đớn không ai thấu cảm ở quá khứ, không thể nói ra thì chỉ có thể mượn bút thay lời. Tác giả cũng nhắc nhẹ về một lời cảnh báo rằng, đại dương đen này là của chính tác giả, và dành cho những ai muốn tìm thấy đứa trẻ giống như mình, còn nếu chúng ta đã không thuộc về thì xin đừng nặng lời trách móc…', 5, 4, 2, 5, 9, 1 )
INSERT INTO SACH VALUES (N'999 Lá Thư Gửi Cho Chính Mình', 'https://salt.tikicdn.com/cache/w1200/ts/product/ed/9b/3b/6a31e0a4e3fa4337ad789961f9bcf6dc.jpg', 80000, 1, N'Thời gian qua đi không ngoảnh lại, tuổi trẻ trôi qua khó trở về, đó chính là quy luật khắc nghiệt của tạo hoá. Thế nên mỗi chúng ta không nên phí hoài tuổi trẻ, lãng phí thanh xuân. Hãy sống xứng đáng với tuổi trẻ của mình là thông điệp quý giá mà cuốn sách 999 lá thư gửi cho chính mình đem đến cho các bạn trẻ còn đang chênh vênh trên con đường đời đầy chông gai thử thách.', 6, 5, 2, 5, 9, 1 )
INSERT INTO SACH VALUES (N'Đắc Nhân Tâm', 'https://2.bp.blogspot.com/-abTdVhwytRo/W65r5F2bmqI/AAAAAAAAY-k/YCyANvoWLUI-3ZqD7vpCJe8CK0s_Q_H8wCKgBGAs/s1600/dac%2Bnhan%2Btam.jpg', 70000, 1, N'Chắc chắn một điều rằng, nếu bạn dành nhiều thời gian và trí tuệ để làm theo từng bước của những bài học này, thì trong tương lai bạn sẽ dễ dàng đạt được nhiều thành công trong giao tiếp, trong cuộc sống hàng ngày và quan trọng hơn là trong sự nghiệp công việc của bạn. Các bài học được hướng dẫn trong cuốn sách đều rất thực tế và gần gũi với cuộc sống đời thường của mỗi chúng ta, nên sẽ không gây ra bất kỳ những khó khăn, lạ lẫm nào cho những người lần đầu biết đến cuốn sách Đắc nhân tâm này.', 2, 6, 5, 2, 12, 1 )
INSERT INTO SACH VALUES (N'Có Một Con Mọt Sách', 'https://firstnews.com.vn/public/uploads/files/co-mot-con-mot-sach.jpg', 60000, 1, N'Có một con mọt sách là cuốn sách gồm 7 truyện tranh ngắn: Có một con mọt sách, Cá bảy màu, Giếng nước mùa xuân, Một cuộc du lịch kỳ quái, Có “chí” thì... hư, Cái mũi để chi, Nghỉ hè, nên làm gì? , bao gồm những kiến thức bổ ích về sức khỏe, về vệ sinh cá nhân được tác giả - bác sĩ Đỗ Hồng Ngọc lồng ghép trong những câu chuyện nhẹ nhàng.', 6, 7, 5, 6, 12, 1 )


INSERT INTO PHIEUNHAPHANG VALUES ('2023-10-10', 3)
INSERT INTO PHIEUNHAPHANG VALUES ('2023-10-10', 4)
INSERT INTO PHIEUNHAPHANG VALUES ('2023-10-10', 7)
INSERT INTO PHIEUNHAPHANG VALUES ('2023-10-10', 5)
INSERT INTO PHIEUNHAPHANG VALUES ('2023-10-10', 6)
INSERT INTO PHIEUNHAPHANG VALUES ('2023-10-10', 2)
INSERT INTO PHIEUNHAPHANG VALUES ('2023-10-10', 1)

INSERT INTO CHITIET_PHIEUNHAP VALUES (1, 8, 50000, 100, 5000000)
INSERT INTO CHITIET_PHIEUNHAP VALUES (2, 9, 50000, 100, 5000000)
INSERT INTO CHITIET_PHIEUNHAP VALUES (3, 10, 50000, 100, 5000000)
INSERT INTO CHITIET_PHIEUNHAP VALUES (4, 11, 50000, 100, 5000000)
INSERT INTO CHITIET_PHIEUNHAP VALUES (5, 12, 50000, 100, 5000000)
INSERT INTO CHITIET_PHIEUNHAP VALUES (6, 13, 50000, 100, 5000000)
INSERT INTO CHITIET_PHIEUNHAP VALUES (6, 14, 50000, 100, 5000000)

INSERT INTO KHACHHANG VALUES (N'Nguyễn Văn A', '0111111111', 'nva@gmail.com')
INSERT INTO KHACHHANG VALUES (N'Nguyễn Thị B', '0222222222', 'ntb@gmail.com')

INSERT INTO GIOHANG VALUES (1)
INSERT INTO GIOHANG VALUES (2)

INSERT INTO CHITIET_GIOHANG VALUES (1,8,1)
INSERT INTO CHITIET_GIOHANG VALUES (1,9,2)
INSERT INTO CHITIET_GIOHANG VALUES (2,10,1)

INSERT INTO DONHANG VALUES ('2023-11-12','2023-11-15',1, N'Quận 7 TPHCM', 1)
INSERT INTO DONHANG VALUES ('2023-11-15','2023-11-17',1, N'Quận 1 TPHCM', 2)

INSERT INTO CHITIET_DONHANG VALUES (1, 11, 1, 80000, 1)
INSERT INTO CHITIET_DONHANG VALUES (1, 12, 1, 100000, 1)
INSERT INTO CHITIET_DONHANG VALUES (2, 8, 1, 100000, 1)




