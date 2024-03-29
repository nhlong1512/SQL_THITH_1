﻿-----------------------------------------------------------BUỔI 1-------------------------------------------------------------
CREATE DATABASE QLGV
DROP DATABASE QLGV
USE QLGV

--PHẦN 1
--CÂU 1: Tạo quan hệ , tạo 8 bảng 

CREATE TABLE KHOA(
	MAKHOA	VARCHAR(4),
	TENKHOA	NVARCHAR(40),
	NGTLAP	SMALLDATETIME,
	TRGKHOA	CHAR(4)
	PRIMARY KEY(MAKHOA)
)

CREATE TABLE MONHOC(
	MAMH	VARCHAR(10),
	TENMH	NVARCHAR(40),
	TCLT	TINYINT,
	TCTH	TINYINT,
	MAKHOA	VARCHAR(4),
	PRIMARY KEY(MAMH)
)

CREATE TABLE DIEUKIEN(
	MAMH		VARCHAR(10),
	MAMH_TRUOC	VARCHAR(10),
	PRIMARY KEY(MAMH,MAMH_TRUOC)
)

CREATE TABLE GIAOVIEN(
	MAGV		CHAR(4),
	HOTEN		NVARCHAR(40),
	HOCVI		NVARCHAR(10),
	HOCHAM		NVARCHAR(10),
	GIOITINH	NVARCHAR(3),
	NGSINH		SMALLDATETIME,
	NGVL		SMALLDATETIME,
	HESO		NUMERIC(4,2),
	MUCLUONG	MONEY,
	MAKHOA		VARCHAR(4),
	PRIMARY KEY(MAGV)
)

CREATE TABLE LOP(
	MALOP	CHAR(3),
	TENLOP	NVARCHAR(40),
	TRGLOP	CHAR(5),
	SISO	TINYINT,
	MAGVCN	CHAR(4),
	PRIMARY KEY(MALOP)
)

CREATE TABLE HOCVIEN(
	MAHV		CHAR(5),
	HO		NVARCHAR(40),
	TEN		NVARCHAR(10),
	NGSINH		SMALLDATETIME,
	GIOITINH	NVARCHAR(3),
	NOISINH		NVARCHAR(40),
	MALOP		CHAR(3),
	PRIMARY KEY(MAHV)
)


CREATE TABLE GIANGDAY(
	MALOP	CHAR(3),
	MAMH	VARCHAR(10),
	MAGV	CHAR(4),
	HOCKY	TINYINT,
	NAM	SMALLINT,
	TUNGAY	SMALLDATETIME,
	DENNGAY	SMALLDATETIME,
	PRIMARY KEY(MALOP,MAMH)
)

CREATE TABLE KETQUATHI(
	MAHV	CHAR(5),
	MAMH	VARCHAR(10),
	LANTHI	TINYINT,
	NGTHI	SMALLDATETIME,
	DIEM	NUMERIC(4,2),
	KQUA	NVARCHAR(10),
	PRIMARY KEY(MAHV,MAMH,LANTHI)
)


-- ========================= RANG BUOC KHOA NGOAI ===========================

ALTER TABLE KHOA ADD CONSTRAINT FK_KHOA FOREIGN KEY(TRGKHOA) REFERENCES GIAOVIEN(MAGV)


	
ALTER TABLE MONHOC ADD CONSTRAINT FK_MONHOC FOREIGN KEY(MAKHOA) REFERENCES KHOA(MAKHOA)


ALTER TABLE DIEUKIEN ADD CONSTRAINT FK1_DIEUKIEN FOREIGN KEY(MAMH) REFERENCES MONHOC(MAMH)
ALTER TABLE DIEUKIEN ADD CONSTRAINT FK2_DIEUKIEN FOREIGN KEY(MAMH_TRUOC) REFERENCES MONHOC(MAMH)



ALTER TABLE GIAOVIEN ADD CONSTRAINT FK_GIAOVIEN FOREIGN KEY(MAKHOA) REFERENCES KHOA(MAKHOA)



ALTER TABLE LOP ADD CONSTRAINT FK1_LOP FOREIGN KEY(TRGLOP) REFERENCES HOCVIEN(MAHV)
ALTER TABLE LOP ADD CONSTRAINT FK2_LOP FOREIGN KEY(MAGVCN) REFERENCES GIAOVIEN(MAGV)


ALTER TABLE HOCVIEN ADD CONSTRAINT FK_HOCVIEN FOREIGN KEY(MALOP) REFERENCES LOP(MALOP)



ALTER TABLE GIANGDAY ADD CONSTRAINT FK1_GIANGDAY FOREIGN KEY(MALOP) REFERENCES LOP(MALOP)
ALTER TABLE GIANGDAY ADD CONSTRAINT FK2_GIANGDAY FOREIGN KEY(MAMH) REFERENCES MONHOC(MAMH)

--------------------########-----------------------------

-- TABLE KETQUATHI
ALTER TABLE KETQUATHI ADD CONSTRAINT FK1_KETQUA FOREIGN KEY(MAHV) REFERENCES HOCVIEN(MAHV)
ALTER TABLE KETQUATHI ADD CONSTRAINT FK2_KETQUA FOREIGN KEY(MAMH) REFERENCES MONHOC(MAMH)

--$$$$-------------------------------------------------$$$

SET DATEFORMAT DMY -- xét định dạng ngày tháng theo ngày/ tháng/ năm


-- Nhập liệu bảng KHOA
INSERT INTO KHOA (MAKHOA, TENKHOA, NGTLAP) VALUES('KHMT',N'Khoa Học Máy Tính','7/6/2005')
INSERT INTO KHOA (MAKHOA, TENKHOA, NGTLAP) VALUES('HTTT',N'Hệ Thống Thông Tin','7/6/2005')
INSERT INTO KHOA (MAKHOA, TENKHOA, NGTLAP) VALUES('CNPM',N'Công Nghệ Phần Mềm','7/6/2005')
INSERT INTO KHOA (MAKHOA, TENKHOA, NGTLAP) VALUES('MTT',N'Mạng và Truyền thông','20/10/2005')
INSERT INTO KHOA (MAKHOA, TENKHOA, NGTLAP) VALUES('KTMT',N'Kỹ Thuật Máy Tính','20/12/2005')

-- Nhập liệu bảng LOP
INSERT INTO LOP ( MALOP,TENLOP, SISO) VALUES('K11',N'Lớp 1 khóa 1',11)
INSERT INTO LOP ( MALOP,TENLOP, SISO) VALUES('K12',N'Lớp 2 khóa 1',12)
INSERT INTO LOP ( MALOP,TENLOP, SISO) VALUES('K13',N'Lớp 3 khóa 1',12)

-- Nhập liệu bảng MONHOC
INSERT INTO MONHOC VALUES('THDC',N'Tin học đại cương',4,1,'KHMT')
INSERT INTO MONHOC VALUES('CTRR',N'Cấu trúc rời rạc',5,0,'KHMT')
INSERT INTO MONHOC VALUES('CSDL',N'Cơ sở dữ liệu',3,1,'HTTT')
INSERT INTO MONHOC VALUES('CTDLGT',N'Cấu trúc dữ liệu và giải thuật',3,1,'KHMT')
INSERT INTO MONHOC VALUES('PTTKTT',N'Phân tích thiết kế thuật toán',3,0,'KHMT')
INSERT INTO MONHOC VALUES('DHMT',N'Đồ họa máy tính',3,1,'KHMT')
INSERT INTO MONHOC VALUES('KTMT',N'Kiến trúc máy tính',3,0,'KTMT')
INSERT INTO MONHOC VALUES('TKCSDL',N'Thiết kế cơ sở dữ liệu',3,1,'HTTT')
INSERT INTO MONHOC VALUES('PTTKHTTT',N'Phân tích thiết kế hệ thống thông tin',4,1,'HTTT')
INSERT INTO MONHOC VALUES('HDH',N'Hệ điều hành',4,0,'KTMT')
INSERT INTO MONHOC VALUES('NMCNPM',N'Nhập môn công nghệ phần mềm',3,0,'CNPM')
INSERT INTO MONHOC VALUES('LTCFW',N'Lập trình C for win',3,1,'CNPM')
INSERT INTO MONHOC VALUES('LTHDT',N'Lập trình hướng đối tượng',3,1,'CNPM')


-- Nhập liệu bảng GIAOVIEN
INSERT INTO GIAOVIEN VALUES('GV01',N'Hồ Thanh Sơn','PTS','GS','Nam','2/5/1950','11/1/2004',5.00,2250000,'KHMT')
INSERT INTO GIAOVIEN VALUES('GV02',N'Trần Tâm Thanh','TS','PGS','Nam','17/12/1965','20/4/2004',4.50,2025000,'HTTT')
INSERT INTO GIAOVIEN VALUES('GV03',N'Đỗ Nghiêm Phụng','TS','GS',N'Nữ','1/8/1950','23/9/2004',4.00,1800000,'CNPM')
INSERT INTO GIAOVIEN VALUES('GV04',N'Trần Nam Sơn','TS','PGS','Nam','22/2/1961','12/1/2005',4.50,2025000,'KTMT')
INSERT INTO GIAOVIEN VALUES('GV05',N'Mai Thành Danh','ThS','GV','Nam','12/3/1958','12/1/2005',3.00,1350000,'HTTT')
INSERT INTO GIAOVIEN VALUES('GV06',N'Trần Doãn Hưng','TS','GV','Nam','11/3/1958','12/1/2005',4.50,2025000,'KHMT')
INSERT INTO GIAOVIEN VALUES('GV07',N'Nguyễn Minh Tiến','ThS','GV','Nam','23/11/1971','1/3/2005',4.00,1800000,'KHMT')
INSERT INTO GIAOVIEN VALUES('GV08',N'Lê Thị Trân','KS','',N'Nữ','26/3/1974','1/3/2005',1.69,760500,'KHMT')
INSERT INTO GIAOVIEN VALUES('GV09',N'Nguyễn Tố Lân','ThS','GV',N'Nữ','31/12/1966','1/3/2005',4.00,1800000,'HTTT')
INSERT INTO GIAOVIEN VALUES('GV10',N'Lê Trần Ánh Loan','KS','',N'Nữ','17/7/1972','1/3/2005',1.86,837000,'CNPM')
INSERT INTO GIAOVIEN VALUES('GV11',N'Hồ Thanh Tùng','CN','GV','Nam','12/1/1980','15/5/2005',2.67,1201500,'MTT')
INSERT INTO GIAOVIEN VALUES('GV12',N'Trần Vạn Anh','CN','',N'Nữ','29/3/1981','15/5/2005',1.69,760500,'CNPM')
INSERT INTO GIAOVIEN VALUES('GV13',N'Nguyễn Linh Đan','CN','',N'Nữ','23/5/1980','15/5/2005',1.69,760500,'KTMT')
INSERT INTO GIAOVIEN VALUES('GV14',N'Trương Minh Châu','ThS','GV',N'Nữ','30/11/1976','15/5/2005',3.00,1350000,'MTT')
INSERT INTO GIAOVIEN VALUES('GV15',N'Lê Hà Thành','ThS','GV','Nam','4/5/1978','15/5/2005',3.00,1350000,'KHMT')
-----------------------------------------------------------------------------------------------------------------------
--Cập nhật thêm TRGKHOA cho bảng KHOA sau khi đã nhập liệu cho bảng GIAOVIEN
UPDATE KHOA SET TRGKHOA='GV01' WHERE MAKHOA = 'KHMT'
UPDATE KHOA SET TRGKHOA='GV02' WHERE MAKHOA = 'HTTT'
UPDATE KHOA SET TRGKHOA='GV04' WHERE MAKHOA = 'CNPM'
UPDATE KHOA SET TRGKHOA='GV03' WHERE MAKHOA = 'MTT'
--Cập nhật thêm MAGVCN cho bảng LOP sau khi đã nhập liệu cho bảng GIAOVIEN
UPDATE LOP SET MAGVCN = 'GV07' WHERE MALOP = 'K11'
UPDATE LOP SET MAGVCN = 'GV09' WHERE MALOP = 'K12'
UPDATE LOP SET MAGVCN = 'GV14' WHERE MALOP = 'K13'


-- Nhập liệu bảng HOCVIEN
INSERT INTO HOCVIEN VALUES('K1101',N'Nguyễn Văn',N'A','27/1/1986','Nam','TpHCM','K11')
INSERT INTO HOCVIEN VALUES('K1102',N'Trần Ngọc',N'Hân','14/3/1986',N'Nữ',N'Kiên Giang','K11')
INSERT INTO HOCVIEN VALUES('K1103',N'Hà Duy',N'Lập','18/4/1986','Nam',N'Nghệ An','K11')
INSERT INTO HOCVIEN VALUES('K1104',N'Trần Ngọc',N'Linh','30/3/1986',N'Nữ',N'Tây Ninh','K11')
INSERT INTO HOCVIEN VALUES('K1105',N'Trần Minh',N'Long','27/2/1986','Nam','TpHCM','K11')
INSERT INTO HOCVIEN VALUES('K1106',N'Lê Nhật',N'Minh','24/1/1986','Nam','TpHCM','K11')
INSERT INTO HOCVIEN VALUES('K1107',N'Nguyễn Như',N'Nhứt','27/1/1986','Nam',N'Hà Nội','K11')
INSERT INTO HOCVIEN VALUES('K1108',N'Nguyễn Mạnh',N'Tâm','27/2/1986','Nam',N'Kiên Giang','K11')
INSERT INTO HOCVIEN VALUES('K1109',N'Phan Thị Thanh',N'Tâm','27/1/1986',N'Nữ',N'Vĩnh Long','K11')
INSERT INTO HOCVIEN VALUES('K1110',N'Lê Hoài',N'Thương','5/2/1986',N'Nữ',N'Cần Thơ','K11')
INSERT INTO HOCVIEN VALUES('K1111',N'Lê Hà',N'Vinh','25/12/1986','Nam',N'Vĩnh Long','K11')
INSERT INTO HOCVIEN VALUES('K1201',N'Nguyễn Văn',N'B','11/2/1986','Nam','TpHCM','K12')
INSERT INTO HOCVIEN VALUES('K1202',N'Nguyễn Thị Kim',N'Duyên','18/1/1986',N'Nữ','TpHCM','K12')
INSERT INTO HOCVIEN VALUES('K1203',N'Trần Thị Kim',N'Duyên','17/9/1986',N'Nữ','TpHCM','K12')
INSERT INTO HOCVIEN VALUES('K1204',N'Trương Mỹ',N'Hạnh','19/5/1986',N'Nữ',N'Đồng Nai','K12')
INSERT INTO HOCVIEN VALUES('K1205',N'Nguyễn Thành',N'Nam','17/4/1986','Nam','TpHCM','K12')
INSERT INTO HOCVIEN VALUES('K1206',N'Nguyễn Thị Trúc',N'Thanh','4/3/1986',N'Nữ',N'Kiên Giang','K12')
INSERT INTO HOCVIEN VALUES('K1207',N'Trần Thị Bích',N'Thúy','8/2/1986',N'Nữ',N'Nghệ An','K12')
INSERT INTO HOCVIEN VALUES('K1208',N'Huỳnh Thị Kim',N'Triều','8/4/1986',N'Nữ',N'Tây Ninh','K12')
INSERT INTO HOCVIEN VALUES('K1209',N'Phạm Thanh',N'Triều','23/2/1986','Nam','TpHCM','K12')
INSERT INTO HOCVIEN VALUES('K1210',N'Ngô Thanh',N'Tuấn','14/2/1986','Nam','TpHCM','K12')
INSERT INTO HOCVIEN VALUES('K1211',N'Đỗ Thị',N'Xuân','9/3/1986',N'Nữ',N'Hà Nội','K12')
INSERT INTO HOCVIEN VALUES('K1212',N'Lê Thị Phi',N'Yến','12/3/1986',N'Nữ','TpHCM','K12')
INSERT INTO HOCVIEN VALUES('K1301',N'Nguyễn Thị Kim',N'Cúc','9/6/1986',N'Nữ',N'Kiên Giang','K13')
INSERT INTO HOCVIEN VALUES('K1302',N'Trương Thị Mỹ',N'Hiền','18/3/1986',N'Nữ',N'Nghệ An','K13')
INSERT INTO HOCVIEN VALUES('K1303',N'Lê Đức',N'Hiển','21/3/1986','Nam',N'Tây Ninh','K13')
INSERT INTO HOCVIEN VALUES('K1304',N'Lê Quang',N'Hiên','18/4/1986','Nam','TpHCM','K13')
INSERT INTO HOCVIEN VALUES('K1305',N'Lê Thị',N'Hương','27/3/1986',N'Nữ','TpHCM','K13')
INSERT INTO HOCVIEN VALUES('K1306',N'Nguyễn Thái',N'Hữu','30/3/1986','Nam',N'Hà Nội','K13')
INSERT INTO HOCVIEN VALUES('K1307',N'Trần Minh',N'Mẫn','28/5/1986','Nam','TpHCM','K13')
INSERT INTO HOCVIEN VALUES('K1308',N'Nguyễn Hiếu',N'Nghĩa','8/4/1986','Nam','Kiên Giang','K13')
INSERT INTO HOCVIEN VALUES('K1309',N'Nguyễn Trung',N'Nghĩa','18/1/1987','Nam',N'Nghệ An','K13')
INSERT INTO HOCVIEN VALUES('K1310',N'Trần Thị Hồng',N'Thắm','22/4/1986',N'Nữ',N'Tây Ninh','K13')
INSERT INTO HOCVIEN VALUES('K1311',N'Trần Minh',N'Thức','4/4/1986','Nam','TpHCM','K13')
INSERT INTO HOCVIEN VALUES('K1312',N'Nguyễn Thị Kim',N'Yến','7/9/1986',N'Nữ','TpHCM','K13')

--Cập nhật thêm TRGLOP cho bảng LOP sau khi đã nhập liệu cho bảng HOCVIEN
UPDATE LOP SET TRGLOP = 'K1108' WHERE MALOP = 'K11'
UPDATE LOP SET TRGLOP = 'K1205' WHERE MALOP = 'K12'
UPDATE LOP SET TRGLOP = 'K1305' WHERE MALOP = 'K13'


-- Nhập liệu bảng GIANGDAY
INSERT INTO GIANGDAY VALUES('K11','THDC','GV07',1,2006,'2/1/2006','12/5/2006')
INSERT INTO GIANGDAY VALUES('K12','THDC','GV06',1,2006,'2/1/2006','12/5/2006')
INSERT INTO GIANGDAY VALUES('K13','THDC','GV15',1,2006,'2/1/2006','12/5/2006')
INSERT INTO GIANGDAY VALUES('K11','CTRR','GV02',1,2006,'9/1/2006','17/5/2006')
INSERT INTO GIANGDAY VALUES('K12','CTRR','GV02',1,2006,'9/1/2006','17/5/2006')
INSERT INTO GIANGDAY VALUES('K13','CTRR','GV08',1,2006,'9/1/2006','17/5/2006')
INSERT INTO GIANGDAY VALUES('K11','CSDL','GV05',2,2006,'1/6/2006','15/7/2006')
INSERT INTO GIANGDAY VALUES('K12','CSDL','GV09',2,2006,'1/6/2006','15/7/2006')
INSERT INTO GIANGDAY VALUES('K13','CTDLGT','GV15',2,2006,'1/6/2006','15/7/2006')
INSERT INTO GIANGDAY VALUES('K13','CSDL','GV05',3,2006,'1/8/2006','15/12/2006')
INSERT INTO GIANGDAY VALUES('K13','DHMT','GV07',3,2006,'1/8/2006','15/12/2006')
INSERT INTO GIANGDAY VALUES('K11','CTDLGT','GV15',3,2006,'1/8/2006','15/12/2006')
INSERT INTO GIANGDAY VALUES('K12','CTDLGT','GV15',3,2006,'1/8/2006','15/12/2006')
INSERT INTO GIANGDAY VALUES('K11','HDH','GV04',1,2007,'2/1/2007','18/2/2007')
INSERT INTO GIANGDAY VALUES('K12','HDH','GV04',1,2007,'2/1/2007','20/3/2007')
INSERT INTO GIANGDAY VALUES('K11','DHMT','GV07',1,2007,'18/2/2007','20/3/2007')


-- Nhập liệu bảng DIEUKIEN
INSERT INTO DIEUKIEN VALUES('CSDL','CTRR')
INSERT INTO DIEUKIEN VALUES('CSDL','CTDLGT')
INSERT INTO DIEUKIEN VALUES('CTDLGT','THDC')
INSERT INTO DIEUKIEN VALUES('PTTKTT','THDC')
INSERT INTO DIEUKIEN VALUES('PTTKTT','CTDLGT')
INSERT INTO DIEUKIEN VALUES('DHMT','THDC')
INSERT INTO DIEUKIEN VALUES('LTHDT','THDC')
INSERT INTO DIEUKIEN VALUES('PTTKHTTT','CSDL')


-- Nhập liệu bảng KETQUATHI
INSERT INTO KETQUATHI VALUES('K1101','CSDL',1,'20/7/2006',10.00,N'Đạt')
INSERT INTO KETQUATHI VALUES('K1101','CTDLGT',1,'28/12/2006',9.00,N'Đạt')
INSERT INTO KETQUATHI VALUES('K1101','THDC',1,'20/5/2006',9.00,N'Đạt')
INSERT INTO KETQUATHI VALUES('K1101','CTRR',1,'13/5/2006',9.50,N'Đạt')
INSERT INTO KETQUATHI VALUES('K1102','CSDL',1,'20/7/2006',4.00,N'Không Đạt')
INSERT INTO KETQUATHI VALUES('K1102','CSDL',2,'27/7/2006',4.25,N'Không Đạt')
INSERT INTO KETQUATHI VALUES('K1102','CSDL',3,'10/8/2006',4.50,N'Không Đạt')
INSERT INTO KETQUATHI VALUES('K1102','CTDLGT',1,'28/12/2006',4.50,N'Không Đạt')
INSERT INTO KETQUATHI VALUES('K1102','CTDLGT',2,'5/1/2007',4.00,N'Không Đạt')
INSERT INTO KETQUATHI VALUES('K1102','CTDLGT',3,'15/1/2007',6.00,N'Đạt')
INSERT INTO KETQUATHI VALUES('K1102','THDC',1,'20/5/2006',5.00,N'Đạt')
INSERT INTO KETQUATHI VALUES('K1102','CTRR',1,'13/5/2006',7.00,N'Đạt')
INSERT INTO KETQUATHI VALUES('K1103','CSDL',1,'20/7/2006',3.50,N'Không Đạt')
INSERT INTO KETQUATHI VALUES('K1103','CSDL',2,'27/7/2006',8.25,N'Đạt')
INSERT INTO KETQUATHI VALUES('K1103','CTDLGT',1,'28/12/2006',7.00,N'Đạt')
INSERT INTO KETQUATHI VALUES('K1103','THDC',1,'20/5/2006',8.00,N'Đạt')
INSERT INTO KETQUATHI VALUES('K1103','CTRR',1,'13/5/2006',6.50,N'Đạt')
INSERT INTO KETQUATHI VALUES('K1104','CSDL',1,'20/7/2006',3.75,N'Không Đạt')
INSERT INTO KETQUATHI VALUES('K1104','CTDLGT',1,'28/12/2006',4.00,N'Không Đạt')
INSERT INTO KETQUATHI VALUES('K1104','THDC',1,'20/5/2006',4.00,N'Không Đạt')
INSERT INTO KETQUATHI VALUES('K1104','CTRR',1,'13/5/2006',4.00,N'Không Đạt')
INSERT INTO KETQUATHI VALUES('K1104','CTRR',2,'20/5/2006',3.50,N'Không Đạt')
INSERT INTO KETQUATHI VALUES('K1104','CTRR',3,'30/6/2006',4.00,N'Không Đạt')
INSERT INTO KETQUATHI VALUES('K1201','CSDL',1,'20/7/2006',6.00,N'Đạt')
INSERT INTO KETQUATHI VALUES('K1201','CTDLGT',1,'28/12/2006',5.00,N'Đạt')
INSERT INTO KETQUATHI VALUES('K1201','THDC',1,'20/5/2006',8.50,N'Đạt')
INSERT INTO KETQUATHI VALUES('K1201','CTRR',1,'13/5/2006',9.00,N'Đạt')
INSERT INTO KETQUATHI VALUES('K1202','CSDL',1,'20/7/2006',8.00,N'Đạt')
INSERT INTO KETQUATHI VALUES('K1202','CTDLGT',1,'28/12/2006',4.00,N'Không Đạt')
INSERT INTO KETQUATHI VALUES('K1202','CTDLGT',2,'5/1/2007',5.00,N'Đạt')
INSERT INTO KETQUATHI VALUES('K1202','THDC',1,'20/5/2006',4.00,N'Không Đạt')
INSERT INTO KETQUATHI VALUES('K1202','THDC',2,'27/5/2006',4.00,N'Không Đạt')
INSERT INTO KETQUATHI VALUES('K1202','CTRR',1,'13/5/2006',3.00,N'Không Đạt')
INSERT INTO KETQUATHI VALUES('K1202','CTRR',2,'20/5/2006',4.00,N'Không Đạt')
INSERT INTO KETQUATHI VALUES('K1202','CTRR',3,'30/6/2006',6.25,N'Đạt')
INSERT INTO KETQUATHI VALUES('K1203','CSDL',1,'20/7/2006',9.25,N'Đạt')
INSERT INTO KETQUATHI VALUES('K1203','CTDLGT',1,'28/12/2006',9.50,N'Đạt')
INSERT INTO KETQUATHI VALUES('K1203','THDC',1,'20/5/2006',10.00,N'Đạt')
INSERT INTO KETQUATHI VALUES('K1203','CTRR',1,'13/5/2006',10.00,N'Đạt')
INSERT INTO KETQUATHI VALUES('K1204','CSDL',1,'20/7/2006',8.50,N'Đạt')
INSERT INTO KETQUATHI VALUES('K1204','CTDLGT',1,'28/12/2006',6.75,N'Đạt')
INSERT INTO KETQUATHI VALUES('K1204','THDC',1,'20/5/2006',4.00,N'Không Đạt')
INSERT INTO KETQUATHI VALUES('K1204','CTRR',1,'13/5/2006',6.00,N'Đạt')
INSERT INTO KETQUATHI VALUES('K1301','CSDL',1,'20/12/2006',4.25,N'Không Đạt')
INSERT INTO KETQUATHI VALUES('K1301','CTDLGT',1,'25/7/2006',8.00,N'Đạt')
INSERT INTO KETQUATHI VALUES('K1301','THDC',1,'20/5/2006',7.75,N'Đạt')
INSERT INTO KETQUATHI VALUES('K1301','CTRR',1,'13/5/2006',8.00,N'Đạt')
INSERT INTO KETQUATHI VALUES('K1302','CSDL',1,'20/12/2006',6.75,N'Đạt')
INSERT INTO KETQUATHI VALUES('K1302','CTDLGT',1,'25/7/2006',5.00,N'Đạt')
INSERT INTO KETQUATHI VALUES('K1302','THDC',1,'20/5/2006',8.00,N'Đạt')
INSERT INTO KETQUATHI VALUES('K1302','CTRR',1,'13/5/2006',8.50,N'Đạt')
INSERT INTO KETQUATHI VALUES('K1303','CSDL',1,'20/12/2006',4.00,N'Không Đạt')
INSERT INTO KETQUATHI VALUES('K1303','CTDLGT',1,'25/7/2006',4.50,N'Không Đạt')
INSERT INTO KETQUATHI VALUES('K1303','CTDLGT',2,'7/8/2006',4.00,N'Không Đạt')
INSERT INTO KETQUATHI VALUES('K1303','CTDLGT',3,'15/8/2006',4.25,N'Không Đạt')
INSERT INTO KETQUATHI VALUES('K1303','THDC',1,'20/5/2006',4.50,N'Không Đạt')
INSERT INTO KETQUATHI VALUES('K1303','CTRR',1,'13/5/2006',3.25,N'Không Đạt')
INSERT INTO KETQUATHI VALUES('K1303','CTRR',2,'20/5/2006',5.00,N'Đạt')
INSERT INTO KETQUATHI VALUES('K1304','CSDL',1,'20/12/2006',7.75,N'Đạt')
INSERT INTO KETQUATHI VALUES('K1304','CTDLGT',1,'25/7/2006',9.75,N'Đạt')
INSERT INTO KETQUATHI VALUES('K1304','THDC',1,'20/5/2006',5.50,N'Đạt')
INSERT INTO KETQUATHI VALUES('K1304','CTRR',1,'13/5/2006',5.00,N'Đạt')
INSERT INTO KETQUATHI VALUES('K1305','CSDL',1,'20/12/2006',9.25,N'Đạt')
INSERT INTO KETQUATHI VALUES('K1305','CTDLGT',1,'25/7/2006',10.00,N'Đạt')
INSERT INTO KETQUATHI VALUES('K1305','THDC',1,'20/5/2006',8.00,N'Đạt')
INSERT INTO KETQUATHI VALUES('K1305','CTRR',1,'13/5/2006',10.00,N'Đạt')


------------------------------------------------------------------------
-- I/ 
-- câu 1: Thêm vào 3 thuộc tính GHICHU, DIEMTB, XEPLOAI cho quan hệ HOCVIEN.
ALTER TABLE HOCVIEN ADD GHICHU NVARCHAR(40)
ALTER TABLE HOCVIEN ADD DIEMTB NUMERIC(4,2)
ALTER TABLE HOCVIEN ADD XEPLOAI NVARCHAR(10)

-- câu 2: Mã học viên là một chuỗi 5 ký tự, 3 ký tự đầu là mã lớp, 2 ký tự cuối cùng là số thứ tự học viên trong lớp.

ALTER TABLE HOCVIEN ADD CONSTRAINT CK_MAHV CHECK(LEN(MAHV) = 5 AND SUBSTRING(MAHV,1,3) = MALOP AND ISNUMERIC(SUBSTRING(MAHV,4,2)) = 1)


-- câu 3: Thuộc tính GIOITINH chỉ có giá trị là “Nam” hoặc “Nu”.
ALTER TABLE HOCVIEN ADD CONSTRAINT CK_GIOITINH CHECK(GIOITINH = 'Nam' OR GIOITINH = N'Nữ')


-- câu 4: Điểm số của một lần thi có giá trị từ 0 đến 10 và cần lưu đến 2 số lẽ.
ALTER TABLE KETQUATHI ADD CONSTRAINT  CK_DIEM CHECK(DIEM >= 0 AND DIEM <= 10)



-----------------------------------------------------------BUỔI 2-------------------------------------------------------------
--14/10/2021
-- II.1 Tăng hệ số lương thêm 0.2 cho những giáo viên là trưởng khoa
UPDATE GIAOVIEN
SET HESO = 0.2 + HESO
WHERE MAGV IN (SELECT TRGKHOA FROM KHOA)

-- II.2 Cập nhật giá trị điểm trung bình tất cả các môn học (DIEMTB) của mỗi học viên (tất cả các môn học đều có hệ số 1 và nếu học viên thi một môn nhiều lần, chỉ lấy điểm của lần thi sau cùng)
UPDATE HOCVIEN
SET DIEMTB =
(
	SELECT AVG(DIEM)
	FROM KETQUATHI
	WHERE LANTHI = (SELECT MAX(LANTHI) FROM KETQUATHI KQ WHERE MAHV = KETQUATHI.MAHV GROUP BY MAHV)
	GROUP BY MAHV
	HAVING MAHV = HOCVIEN.MAHV
)

-- II.3 Cập nhật giá trị cho cột GHICHU là “Cam thi” đối với trường hợp: học viên có một môn bất kỳ thi lần thứ 3 dưới 5 điểm
UPDATE HOCVIEN 
SET GHICHU =N'Cấm thi'  
WHERE EXISTS(  
SELECT MAHV 
FROM KETQUATHI 
WHERE HOCVIEN.MAHV= KETQUATHI.MAHV AND LANTHI = 3 AND DIEM < 5 
)

-- II.4 Cập nhật giá trị cho cột XEPLOAI trong quan hệ HOCVIEN như sau: 
-- Nếu DIEMTB >= 9 thì XEPLOAI = ”XS”
-- Nếu 8 <= DIEMTB < 9 thì XEPLOAI = “G”
-- Nếu 6.5 <= DIEMTB < 8 thì XEPLOAI = “K”
-- Nếu 5 <= DIEMTB < 6.5 thì XEPLOAI = “TB” 
-- Nếu DIEMTB < 5 thì XEPLOAI = ”Y” 

UPDATE HOCVIEN SET XEPLOAI='XS' WHERE DIEMTB >=9
UPDATE HOCVIEN SET XEPLOAI='G' WHERE DIEMTB >=8 AND DIEMTB <9
UPDATE HOCVIEN SET XEPLOAI='K' WHERE DIEMTB >=6.5 AND DIEMTB <8
UPDATE HOCVIEN SET XEPLOAI='TB' WHERE DIEMTB >=5 AND DIEMTB < 6.5
UPDATE HOCVIEN SET XEPLOAI='Y' WHERE DIEMTB <5

-- III.1 In ra danh sách (mã học viên, họ tên, ngày sinh, mã lớp) lớp trưởng của các lớp
SELECT MAHV,CONCAT (HO,' ',TEN) 
AS HOTEN, NGSINH, LOP.MALOP 
FROM HOCVIEN INNER JOIN LOP 
ON LOP.TRGLOP = HOCVIEN.MAHV

-- III.2 In ra bảng điểm khi thi (mã học viên, họ tên , lần thi, điểm số) môn CTRR của lớp “K12”, sắp xếp theo tên, họ học viên
SELECT HOCVIEN.MAHV, CONCAT ( HO , ' ', TEN) 
AS HOTEN , LANTHI, DIEM
FROM HOCVIEN INNER JOIN KETQUATHI 
ON HOCVIEN.MAHV = KETQUATHI.MAHV 
WHERE MALOP = 'K12' AND MAMH='CTRR' 
ORDER BY TEN,HO;

-- III.3 In ra danh sách những học viên (mã học viên, họ tên) và những môn học mà học viên đó thi lần thứ nhất đã đạt
SELECT HOCVIEN.MAHV, CONCAT( HO ,' ', TEN) 
AS HOTEN ,KETQUATHI.MAMH, TENMH
FROM KETQUATHI 
INNER JOIN HOCVIEN ON KETQUATHI.MAHV= HOCVIEN.MAHV
INNER JOIN MONHOC ON KETQUATHI.MAMH = MONHOC.MAMH
WHERE LANTHI = 1 AND KQUA = N'Đạt'

-- III.4 In ra danh sách học viên (mã học viên, họ tên) của lớp “K11” thi môn CTRR không đạt (ở lần thi 1)
SELECT HOCVIEN.MAHV , CONCAT(HO,' ', TEN) 
AS HOTEN
FROM HOCVIEN INNER JOIN KETQUATHI 
ON HOCVIEN.MAHV = KETQUATHI.MAHV
WHERE MALOP = 'K11' AND MAMH = 'CTRR' AND LANTHI = 1  AND KQUA = N'Không Đạt'





-----------------------------------------------------------BUỔI 3-------------------------------------------------------------


-- III.5 * Danh sách học viên (mã học viên, họ tên) của lớp “K” thi môn CTRR không đạt (ở tất cả các lần thi).

SELECT DISTINCT HOCVIEN.MAHV, HO, TEN
FROM KETQUATHI INNER JOIN dbo.HOCVIEN ON KETQUATHI.MAHV = HOCVIEN.MAHV
WHERE SUBSTRING(dbo.HOCVIEN.MALOP, 1, 1) = 'K'
	AND MAMH = 'CTRR'
	AND KQUA = N'Không Đạt'
	AND HOCVIEN.MAHV NOT IN 
	(
		SELECT DISTINCT MAHV
		FROM KETQUATHI
		WHERE MAMH = 'CTRR' AND KQUA = N'Đạt' AND LANTHI >=2
	)



-- III.6 Tìm tên những môn học mà giáo viên có tên “Trần Tâm Thanh” dạy trong học kỳ 1 năm 2006
SELECT DISTINCT dbo.MONHOC.MAMH, TENMH
FROM dbo.GIANGDAY
	INNER JOIN dbo.GIAOVIEN ON dbo.GIANGDAY.MAGV = dbo.GIAOVIEN.MAGV
	INNER JOIN dbo.MONHOC ON dbo.GIANGDAY.MAMH = dbo.MONHOC.MAMH
WHERE
	HOTEN = N'Trần Tâm Thanh' AND HOCKY = 1 AND NAM = 2006

-- III.7. Tìm những môn học (mã môn học, tên môn học) mà giáo viên chủ nhiệm lớp “K11” dạy trong học kỳ 1 năm 2006.
-- Cách 1:
SELECT DISTINCT GIANGDAY.MAMH, TENMH
FROM 
	GIANGDAY INNER JOIN MONHOC ON GIANGDAY.MAMH = MONHOC.MAMH
WHERE 
	HOCKY = 1 
	AND NAM = 2006
	AND MAGV = (SELECT MAGVCN
			  FROM LOP WHERE MALOP ='K11')

--Cách 2:
SELECT DISTINCT MONHOC.MAMH, TENMH
FROM 
	MONHOC, LOP, GIANGDAY
WHERE 
	MONHOC.MAMH = GIANGDAY.MAMH 
	AND LOP.MAGVCN = GIANGDAY.MAGV 
	AND GIANGDAY.MALOP ='K11'
	AND HOCKY = 1
	AND NAM = 2006

--III.8. Tìm họ tên lớp trưởng của các lớp mà giáo viên có tên “Nguyen To Lan” dạy môn “Co So Du Lieu”.
--Cách 1:
SELECT DISTINCT (HO+' '+TEN) HOTEN
FROM 
	HOCVIEN INNER JOIN LOP ON HOCVIEN.MAHV = LOP.TRGLOP
WHERE
	LOP.MALOP = ( SELECT MALOP
				FROM GIANGDAY 
				WHERE MAGV = ( SELECT MAGV
								FROM GIAOVIEN
								WHERE HOTEN = N'Nguyễn Tố Lân'
							 )
					  AND MAMH = ( SELECT MAMH 
									FROM MONHOC
									WHERE TENMH = N'Cơ Sở Dữ Liệu'
								 )
				)

--III.9. In ra danh sách những môn học (mã môn học, tên môn học) phải học liền trước môn “Co So Du Lieu”.						
--Cách 1:
SELECT 
	MONHOC.MAMH, TENMH
FROM
	MONHOC INNER JOIN DIEUKIEN ON MONHOC.MAMH = DIEUKIEN.MAMH
WHERE
	MAMH_TRUOC = ( SELECT MONHOC.MAMH
					FROM MONHOC
					WHERE TENMH = N'Cơ Sở Dữ Liệu'
				)

--III.10. Môn “Cau Truc Roi Rac” là môn bắt buộc phải học liền trước những môn học (mã môn học, tên môn học) nào.
--Cách 1:
SELECT 
	MONHOC.MAMH, TENMH
FROM 
	MONHOC INNER JOIN DIEUKIEN ON MONHOC.MAMH = DIEUKIEN.MAMH
WHERE 
	MAMH_TRUOC = ( SELECT MONHOC.MAMH
					FROM MONHOC
					WHERE TENMH = N'Cấu trúc rời rạc'
				)

--III.11. Tìm họ tên giáo viên dạy môn CTRR cho cả hai lớp “K11” và “K12” trong cùng học kỳ 1 năm 2006.
--Cách 1:
SELECT DISTINCT 
	HOTEN
FROM 
	GIAOVIEN INNER JOIN GIANGDAY ON GIAOVIEN.MAGV = GIANGDAY.MAGV
WHERE 
	HOCKY = 1
	AND NAM = 2006
	AND MAMH = 'CTRR'
	AND MALOP = 'K11'
INTERSECT
SELECT DISTINCT 
	HOTEN
FROM 
	GIAOVIEN INNER JOIN GIANGDAY ON GIAOVIEN.MAGV = GIANGDAY.MAGV
WHERE 
	HOCKY = 1
	AND NAM = 2006
	AND MAMH = 'CTRR'
	AND MALOP = 'K11'

--III.12. Tìm những học viên (mã học viên, họ tên) thi không đạt môn CSDL ở lần thi thứ 1 nhưng chưa thi lại môn này.
--Cách 1:
SELECT
	HOCVIEN.MAHV, (HO+' '+TEN) HOTEN
FROM
	HOCVIEN INNER JOIN KETQUATHI ON HOCVIEN.MAHV = KETQUATHI.MAHV
WHERE
	MAMH = 'CSDL' AND LANTHI = 1 AND KQUA = N'Không Đạt'
EXCEPT
SELECT
	HOCVIEN.MAHV, (HO+' '+TEN) HOTEN
FROM
	HOCVIEN INNER JOIN KETQUATHI ON HOCVIEN.MAHV = KETQUATHI.MAHV
WHERE
	MAMH = 'CSDL' AND LANTHI > 1 

--III.13. Tìm giáo viên (mã giáo viên, họ tên) không được phân công giảng dạy bất kỳ môn học nào.
--Cách 1:
SELECT 
	GIAOVIEN.MAGV, HOTEN
FROM 
	GIAOVIEN
EXCEPT
SELECT 
	GIAOVIEN.MAGV, HOTEN
FROM 
	GIAOVIEN INNER JOIN GIANGDAY ON GIAOVIEN.MAGV = GIANGDAY.MAGV
	
--III.14. Tìm giáo viên (mã giáo viên, họ tên) không được phân công giảng dạy bất kỳ môn học nào thuộc khoa giáo viên đó phụ trách.
--Cách 1:
SELECT 
	GIAOVIEN.MAGV, HOTEN
FROM 
	GIAOVIEN 
EXCEPT
SELECT 
	GIAOVIEN.MAGV, HOTEN
FROM 
	GIAOVIEN INNER JOIN GIANGDAY ON GIAOVIEN.MAGV = GIANGDAY.MAGV
WHERE GIAOVIEN.MAKHOA = ( SELECT MAKHOA 
						  FROM MONHOC
						  WHERE GIANGDAY.MAMH = MONHOC.MAMH
						)


--III.15. Tìm họ tên các học viên thuộc lớp “K11” thi một môn bất kỳ quá 3 lần vẫn “Khong dat” hoặc thi lần thứ 2 môn CTRR được 5 điểm.	
--Cách 1: 
SELECT DISTINCT 
	(HO+' '+TEN) HOTEN
FROM 
	HOCVIEN INNER JOIN KETQUATHI ON HOCVIEN.MAHV = KETQUATHI.MAHV
WHERE 
	MALOP = 'K11' 
	AND LANTHI = 3 
	AND KQUA = N'Không Đạt'
UNION
SELECT DISTINCT 
	(HO+' '+TEN) HOTEN
FROM 
	HOCVIEN INNER JOIN KETQUATHI ON HOCVIEN.MAHV = KETQUATHI.MAHV
WHERE 
	MALOP = 'K11'
	AND LANTHI = 2
	AND MAMH = 'CTRR'
	AND DIEM = '5.00'

--III.16. Tìm họ tên giáo viên dạy môn CTRR cho ít nhất hai lớp trong cùng một học kỳ của một năm học.
--Cách 1:
SELECT DISTINCT
	HOTEN
FROM 
	GIAOVIEN INNER JOIN GIANGDAY ON GIAOVIEN.MAGV = GIANGDAY.MAGV
WHERE 
	MAMH = 'CTRR'
GROUP BY 
	GIAOVIEN.MAGV, HOTEN, HOCKY
HAVING 
	COUNT(*) >=2

--III.17. Danh sách học viên và điểm thi môn CSDL (chỉ lấy điểm của lần thi sau cùng).
--Cách 1:
SELECT DISTINCT
	HOCVIEN.MAHV, (HO+' '+TEN) HOTEN, DIEM
FROM 
	HOCVIEN INNER JOIN KETQUATHI ON HOCVIEN.MAHV = KETQUATHI.MAHV
WHERE
	MAMH = 'CSDL'
	AND LANTHI = 
	(
		SELECT MAX(LANTHI) 
		FROM KETQUATHI
		WHERE MAMH = 'CSDL' AND KETQUATHI.MAHV = HOCVIEN.MAHV 
		GROUP BY MAHV
	)
	

---III.18. Danh sách học viên và điểm thi môn “Co So Du Lieu” (chỉ lấy điểm cao nhất của các lần thi).
SELECT DISTINCT
	HOCVIEN.MAHV, (HO+' '+TEN) HOTEN, DIEM
FROM 
	HOCVIEN INNER JOIN KETQUATHI ON HOCVIEN.MAHV = KETQUATHI.MAHV
WHERE
	MAMH = 'CSDL'
	AND DIEM = 
	(
		SELECT MAX(DIEM) 
		FROM KETQUATHI, MONHOC
		WHERE 
			  KETQUATHI.MAHV = HOCVIEN.MAHV 
			  AND KETQUATHI.MAMH = MONHOC.MAMH
			  AND TENMH = N'Cơ Sở Dữ Liệu'
		GROUP BY MAHV
	)
	
-------------------------------------------------------------------------BUỔI 3----------------------------------------------------------------------------
-- III.19. Khoa nào (mã khoa, tên khoa) được thành lập sớm nhất.
-- Mô tả:
-- Bảng: KHOA
-- Dễ
--KẾT QUẢ CUỐI CÙNG
SELECT MAKHOA,TENKHOA
FROM KHOA
WHERE NGTLAP = (SELECT MIN(NGTLAP)FROM KHOA)

-- III.20. Có bao nhiêu giáo viên có học hàm là “GS” hoặc “PGS”.
-- BẢNG: GIAOVIEN
-- VỪA
-- KẾT QUẢ CUỐI CÙNG
SELECT HOCHAM, COUNT(MAGV) AS SL_GIAO_VIEN
FROM GIAOVIEN
WHERE HOCHAM = 'GS' OR HOCHAM = 'PGS'
GROUP BY HOCHAM

--MỞ RỘNG: CÓ BAO NHIÊU GIẢNG VIÊN CHƯA LÀ GIÁO SƯ, PHÓ GIÁO SƯ
SELECT COUNT (MAGV) AS SL_GV
FROM GIAOVIEN 
WHERE MAGV NOT IN
	(
		SELECT MAGV 
		FROM GIAOVIEN
		WHERE HOCHAM ='GS' OR HOCHAM ='PGS'
	)

--MỞ RỘNG 2: CÓ BAO NHIÊU GIẢNG VIÊN CHƯA CÓ HỌC HÀM
SELECT COUNT (MAGV) AS SL_GV
FROM GIAOVIEN 
WHERE HOCHAM =''


-- III.21. Thống kê có bao nhiêu giáo viên có học vị là “CN”, “KS”, “Ths”, “TS”, “PTS” trong mỗi khoa.
--BẢNG: GIAOVIEN
-- VỪA
--TH1
SELECT MAKHOA, HOCVI, COUNT(MAGV) AS SO_GIAOVIEN
FROM GIAOVIEN
WHERE HOCVI IN('CN', 'KS', 'THS', 'TS', 'PTS')
GROUP BY HOCVI, MAKHOA

--TH2
SELECT GIAOVIEN.MAKHOA, TENKHOA, HOCVI, COUNT(MAGV) AS SO_GIAOVIEN
FROM GIAOVIEN INNER JOIN KHOA ON GIAOVIEN.MAKHOA = KHOA.MAKHOA
WHERE HOCVI IN('CN', 'KS', 'THS', 'TS', 'PTS')
GROUP BY GIAOVIEN.MAKHOA, TENKHOA, HOCVI

--BONUS 1: COI TS VÀ PTS LÀ GIỐNG NHAU VÀ THỐNG KÊ LẠI NHƯ CÂU 21
--KHÓ 

--BONUS 2: CẬP NHẬT PTS THÀNH TS, TS THÀNH TSKH
--UPDATE
UPDATE GIAOVIEN
SET HOCVI = 'TSKH'
WHERE HOCVI ='TS'

UPDATE GIAOVIEN 
SET HOCVI ='TS'
WHERE HOCVI ='PTS'

--BONUS 3: -- 3. 'CN' : 15, 'KS' : 15, 'Ths' : 22, 'TS' : 30, 'TSKH' : 30, 'PGS' : 40, 'GS': 60
-- Tính chỉ tiêu tuyển sinh?


-- III.22. Mỗi môn học thống kê số lượng học viên theo kết quả (đạt và không đạt).
SELECT MONHOC.MAMH,TENMH, KQUA, COUNT(MAHV) AS SL_HOCVIEN
FROM MONHOC INNER JOIN KETQUATHI ON MONHOC.MAMH = KETQUATHI.MAMH
GROUP BY MONHOC.MAMH, TENMH, KQUA  
ORDER BY MONHOC.MAMH

--BONUS 1: THỐNG KÊ SV ĐẠT, KHÔNG ĐẠT THEO TỪNG LỚP
--KQUA + LOP
--BONUS 2: MỖI MÔN HỌC (TENMH) THỐNG KÊ SV ĐẠT, KHÔNG ĐẠT THEO TỪNG LỚP

-- III.23. Tìm giáo viên (mã giáo viên, họ tên) là giáo viên chủ nhiệm của một lớp, đồng thời dạy cho lớp đó ít nhất một môn học.
--BẢNG:	GIAOVIEN, LOP, GIANGDAY
-- KHÁ KHÓ
-- DÙNG EXISTS (SUB QUERY)

-- III.24. Tìm họ tên lớp trưởng của lớp có sỉ số cao nhất.
-- BẢNG: HOCVIEN, LOP
SELECT (HO+' '+TEN) HOTEN 
FROM HOCVIEN INNER JOIN LOP ON HOCVIEN.MAHV = LOP.TRGLOP
WHERE  SISO IN ( SELECT MAX(SISO)
			FROM LOP)

-- III.25. * Tìm họ tên những LOPTRG thi không đạt quá 3 môn (mỗi môn đều thi không đạt ở tất cả các lần thi).
SELECT (HO+' '+TEN) HOTEN 
FROM HOCVIEN INNER JOIN LOP ON HOCVIEN.MAHV = LOP.TRGLOP
WHERE MAHV = (
	SELECT MAHV
	FROM (
		SELECT MAHV, MAMH
		FROM KETQUATHI
		WHERE KQUA = N'Không Đạt'
		EXCEPT 
		SELECT MAHV, MAMH
		FROM KETQUATHI
		WHERE KQUA = N'Đạt' AND LANTHI >=2) AS T
	GROUP BY MAHV 
	HAVING COUNT(MAHV) >3
	)

-- III.26. Tìm học viên (mã học viên, họ tên) có số môn đạt điểm 9,10 nhiều nhất.

SELECT HOCVIEN.MAHV, (HO+' '+TEN)HOTEN
FROM HOCVIEN INNER JOIN KETQUATHI ON HOCVIEN.MAHV = KETQUATHI.MAHV
WHERE DIEM = 9 OR DIEM = 10
GROUP BY HOCVIEN.MAHV, HO, TEN
HAVING COUNT(DIEM) = 
	(
	SELECT MAX(SL_DIEM)
	FROM (
		SELECT MAHV,COUNT(DIEM) AS SL_DIEM
		FROM KETQUATHI
		WHERE DIEM = 9 OR DIEM =10
		GROUP BY MAHV
		)AS T
	)

-- III.27. Trong từng lớp, tìm học viên (mã học viên, họ tên) có số môn đạt điểm 9,10 nhiều nhất.
SELECT TENLOP, MAHV, (HO+ ' '+ TEN)HOTEN
FROM HOCVIEN INNER JOIN LOP ON HOCVIEN.MALOP = LOP.MALOP
WHERE MAHV IN (
	SELECT KETQUATHI.MAHV
	FROM LOP INNER JOIN HOCVIEN ON LOP.MALOP = HOCVIEN.MALOP
			 INNER JOIN KETQUATHI ON KETQUATHI.MAHV = HOCVIEN.MAHV
	WHERE DIEM =9 OR DIEM = 10
	GROUP BY KETQUATHI.MAHV, HOCVIEN.MALOP
)
	

-- III.28. Trong từng học kỳ của từng năm, mỗi giáo viên phân công dạy bao nhiêu môn học, bao nhiêu lớp.
SELECT HOCKY, NAM, GIAOVIEN.MAGV, HOTEN, COUNT (DISTINCT MAMH) AS SO_MON_HOC, COUNT (DISTINCT MALOP) AS SO_MA_LOP
FROM GIANGDAY INNER JOIN GIAOVIEN ON GIANGDAY.MAGV = GIAOVIEN.MAGV
GROUP BY HOCKY, NAM, GIAOVIEN.MAGV, HOTEN
ORDER BY HOCKY, NAM, MAGV

-- III.29. Trong từng học kỳ của từng năm, tìm giáo viên (mã giáo viên, họ tên) giảng dạy nhiều nhất.


-- III.30. Tìm môn học (mã môn học, tên môn học) có nhiều học viên thi không đạt (ở lần thi thứ 1) nhất.
SELECT
	MONHOC.MAMH, TENMH
FROM
	MONHOC INNER JOIN KETQUATHI ON MONHOC.MAMH = KETQUATHI.MAMH
WHERE
	LANTHI = 1
	AND KQUA = N'Không Đạt'
GROUP BY 
	MONHOC.MAMH, TENMH
HAVING
	COUNT(*) >= ALL (SELECT COUNT(*) FROM KETQUATHI WHERE LANTHI = 1 AND KQUA = N'Không Đạt' GROUP BY MAMH)

-- III.31. Tìm học viên (mã học viên, họ tên) thi môn nào cũng đạt (chỉ xét lần thi thứ 1).
SELECT DISTINCT
	HOCVIEN.MAHV, (HO+' '+TEN) HOTEN
FROM
	HOCVIEN INNER JOIN KETQUATHI ON HOCVIEN.MAHV = KETQUATHI.MAHV
WHERE
	NOT EXISTS
	(
		SELECT *
		FROM KETQUATHI
		WHERE LANTHI = 1
		AND KQUA = N'Không Đạt'
		AND MAHV = HOCVIEN.MAHV
	)

-- III.32. * Tìm học viên (mã học viên, họ tên) thi môn nào cũng đạt (chỉ xét lần thi sau cùng).
SELECT DISTINCT
	HOCVIEN.MAHV, (HO+' '+TEN) HOTEN
FROM
	HOCVIEN INNER JOIN KETQUATHI ON HOCVIEN.MAHV = KETQUATHI.MAHV
WHERE
	NOT EXISTS
	(
		SELECT *
		FROM KETQUATHI
		WHERE LANTHI = (
			SELECT MAX(LANTHI) 
			FROM KETQUATHI
			WHERE MAHV = HOCVIEN.MAHV
			GROUP BY MAHV
		)
		AND KQUA = N'Không Đạt'
		AND MAHV = HOCVIEN.MAHV
	)

-- III.33. *Tìm học viên (mã học viên, họ tên) đã thi tất cả các môn đều đạt (chỉ xét lần thi thứ 1).

-- III.34. *Tìm học viên (mã học viên, họ tên) đã thi tất cả các môn đều đạt (chỉ xét lần thi sau cùng).

-- III.35. ** Tìm học viên (mã học viên, họ tên) có điểm thi cao nhất trong từng môn (lấy điểm ở lần thi sau cùng).
	


--========================================================================BUỔI 5=============================================================================

-- I.5. Kết quả thi là “Dat” nếu điểm từ 5 đến 10 và “Khong dat” nếu điểm nhỏ hơn 5.
ALTER TABLE KETQUATHI
ADD CONSTRAINT CHECKKETQUA CHECK
( 
	(KQUA = N'Đạt' AND (5<= DIEM AND 10>= DIEM))
	OR(KQUA =N'Không Đạt' AND DIEM <5)
)

--I.6. Học viên thi một môn tối đa 3 lần.
ALTER TABLE KETQUATHI 
ADD CONSTRAINT CHECKSOLANTHI CHECK (LANTHI <=3 AND LANTHI>=1)

--I.7. Học kỳ chỉ có giá trị từ 1 đến 3.
ALTER TABLE GIANGDAY
ADD CONSTRAINT CHECKHOCKY CHECK (HOCKY >=1 AND HOCKY <=3)

--I.8. Học vị của giáo viên chỉ có thể là “CN”, “KS”, “Ths”, ”TS”, ”TSKH”.
ALTER TABLE GIAOVIEN
ADD CONSTRAINT CHECK_HOCVI CHECK (HOCVI IN ('CN', 'KS', 'Ths', 'TS', 'TSKH'))
--I.9. Lớp trưởng của một lớp phải là học viên của lớp đó.
--BẢNG: LOP
--MỨC ĐỘ: DỄ
-- RB: TRGLOP
ALTER TABLE LOP ADD CONSTRAINT CK_LOPTRUONG CHECK(SUBSTRING(TRGLOP,1,3) = MALOP )

--I.10. Trưởng khoa phải là giáo viên thuộc khoa và có học vị “TS” hoặc “PTS”.

--I.11. Học viên ít nhất là 18 tuổi.
--BẢNG: HOCVIEN
--MỨC ĐỘ: 
--RB: 
ALTER TABLE HOCVIEN
ADD CONSTRAINT CK_TUOI CHECK
(
	YEAR(GETDATE()) - YEAR(NGSINH) >= 18 
)
--I.12. Giảng dạy một môn học ngày bắt đầu (TUNGAY) phải nhỏ hơn ngày kết thúc (DENNGAY).
--BẢNG: GIANGDAY
--RB: TUNGAY<DENNGAY
--VỀ XEM THÊM: PHÉP TRỪ THỜI GIAN
ALTER TABLE GIANGDAY
ADD CONSTRAINT CK_NGAY CHECK(TUNGAY < DENNGAY)
--I.13. Giáo viên khi vào làm ít nhất là 22 tuổi.
--BẢNG: GIAOVIEN
--RB: NGVL - NGSINH >=22
ALTER TABLE GIAOVIEN
ADD CONSTRAINT CK_TUOIGV CHECK(
	DATEDIFF(YEAR, NGSINH, NGVL) >=22
)
--I.14. Tất cả các môn học đều có số tín chỉ lý thuyết và tín chỉ thực hành chênh lệch nhau không quá 3.
UPDATE MONHOC SET TCLT =3 WHERE MAMH = 'HDH'
UPDATE MONHOC SET TCLT =3 WHERE MAMH='CTRR'
ALTER TABLE MONHOC
ADD CONSTRAINT CK_TINCHI CHECK(ABS(TCLT-TCTH) <=3)
--I.15. Học viên chỉ được thi một môn học nào đó khi lớp của học viên đã học xong môn học này.
--I.16. Mỗi học kỳ của một năm học, một lớp chỉ được học tối đa 3 môn.