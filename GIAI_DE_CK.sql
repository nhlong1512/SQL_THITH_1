﻿-----------------------------------------------ĐỀ HK1 2019-2020 - DE1------------------------------------------------
--A)Liệt kê danh sách vận động viên (HoTen, NgSinh, GioiTinh) có Quốc tịch là ‘UK’ và sắp xếp danh sách theo (HoTen) tăng dần.
SELECT HOTEN, NGSINH, GIOITINH
FROM VANDONGVIEN
WHERE QUOCTICH = 'UK'
ORDER BY HOTEN
--B)In ra danh sách những vận động viên tham gia nội dung thi ‘Bắn Cung’ ở thế vận hội ‘Olympic Tokyo 2020’.
SELECT VANDONGVIEN.MAVDV, HOTEN
FROM VANDONGVIEN, THAMGIA, NOIDUNGTHI, THEVANHOI
WHERE VANDONGVIEN.MAVDV = THAMGIA.MAVDV AND
	  NOIDUNGTHI.MANDT = THAMGIA.MANDT AND
	  THEVANHOI.MATVH = THAMGIA.MATVH AND
	  TENNDT = N'Bắn Cung' AND
	  TENTVH = N'Olympic Tokyo 2020'

--C) Cho biết số lượng huy chương vàng mà các vận động viên ‘Nhật Bản’ đạt được ở thế vận hội diễn ra vào năm 2020.
SELECT COUNT(*) AS SL_HCV
FROM THAMGIA, THEVANHOI, QUOCGIA
WHERE THAMGIA.MATVH = THEVANHOI.MATVH AND
	  THEVANHOI.MAQG = QUOCGIA.MAQG AND
	  HUYCHUONG = 1 AND
	  TENQG = N'Nhật Bản' AND
	  NAM = 2020

--D) Liệt kê họ tên và quốc tịch của những vận động viên tham gia cả 2 nội dung thi ‘100m bơi ngửa’ và ‘200m tự do’
SELECT HOTEN, QUOCTICH
FROM VANDONGVIEN, THAMGIA, NOIDUNGTHI
WHERE VANDONGVIEN.MAVDV = THAMGIA.MAVDV AND
	  NOIDUNGTHI.MANDT = THAMGIA.MANDT AND
	  TENNDT = N'100m bơi ngửa'
INTERSECT 
SELECT HOTEN, QUOCTICH
FROM VANDONGVIEN, THAMGIA, NOIDUNGTHI
WHERE VANDONGVIEN.MAVDV = THAMGIA.MAVDV AND
	  NOIDUNGTHI.MANDT = THAMGIA.MANDT AND
	  TENNDT = N'200m tự do'
--E) In ra thông tin (MaVDV, HoTen) của những vận động viên Nữ người Anh (QuocTich=UK) tham gia tất cả các kỳ thế vận 
--hội từ năm 2008 tới nay
SELECT VANDONGVIEN.MAVDV, HOTEN
FROM VANDONGVIEN, THAMGIA, THEVANHOI
WHERE VANDONGVIEN.MAVDV = THAMGIA.MAVDV AND
	  THEVANHOI.MATVH = THAMGIA.MATVH AND
	  GIOITINH = N'Nữ' AND
	  QUOCTICH = 'UK' AND 
	  NAM >= 2008
GROUP BY VANDONGVIEN.MAVDV, HOTEN
HAVING COUNT(DISTINCT MATVH) = (
							SELECT COUNT(MATVH)
							FROM THEVANHOI 
							WHERE NAM >= 2008)

--F)Tìm vận đông viên (MaVDV, HoTen) đã đạt từ 2 huy chương vàng trở lên tại thế vận hội ‘Olympic Rio 2016’
SELECT VANDONGVIEN.MAVDV, HOTEN 
FROM VANDONGVIEN, THAMGIA, THEVANHOI
WHERE VANDONGVIEN.MAVDV = THAMGIA.MAVDV AND
	  THAMGIA.MATVH = THEVANHOI.MATVH AND
	  TENTVH = N'Olympic Rio 2016' AND 
	  HUYCHUONG = 1
GROUP BY VANDONGVIEN.MAVDV, HOTEN
HAVING COUNT(*) >=2

-------------------------------------------------XE ĐẠP -----------------------------------------------
--1.Tìm thông tin các hóa đơn có ngày giao hàng thực tế lớn hơn ngày giao hàng dự kiến
SELECT SOHOADON
FROM HOADON 
WHERE NGAYGHTHUCTE > NGAYGHDUKIEN

--2. Liệt kê các sản phẩm được hãng Strider sản xuất ra từ năm 2018 trở đi
SELECT SANPHAM.MASANPHAM, TENSANPHAM
FROM SANPHAM, NHASX
WHERE NHASX.MANHASX = SANPHAM.MANHASX
	  AND TENNHASX = 'STRIDER' AND NAM >= 2018
--3.In ra danh sách các khách hàng của các cửa hàng ở tiểu bang TX (Texas) 
SELECT KHACHHANG.MAKHACHHANG, (HO + ' ' + TEN) HOTEN
FROM KHACHHANG, HOADON, CUAHANG
WHERE KHACHHANG.MAKHACHHANG = HOADON.MAKHACHHANG 
      AND CUAHANG.MACUAHANG = HOADON.MACUAHANG
	  AND CUAHANG.BANGDIACHI = 'TEXAS'
--4.In ra danh sách các sản phẩm có giá từ 4000 trở lên do nhân viên có tên là Kali bán được 
SELECT SANPHAM.MASANPHAM, TENSANPHAM
FROM SANPHAM, CTHD, HOADON, NHANVIEN
WHERE SANPHAM.MASANPHAM = CTHD.MASANPHAM 
      AND CTHD.SOHOADON = HOADON.SOHOADON
	  AND HOADON.MANHANVIEN = NHANVIEN.MANHANVIEN
	  AND SANPHAM.GIABAN >= 4000 
	  AND NHANVIEN.TEN = 'KALI'
--5. Tìm khách hàng chỉ mua duy nhất những sản phẩm của nhà sản xuất Haro
--Tập A: Khách hàng mua sản phẩm của nhà sản xuất bất kỳ
--Tập B: Khách hàng không mua sản phẩm của nhà sản xuất Haro
--Kết quả = A - B
SELECT KHACHHANG.MAKHACHHANG
FROM KHACHHANG, HOADON
WHERE KHACHHANG.MAKHACHHANG = HOADON.MAKHACHHANG
EXCEPT
SELECT KHACHHANG.MAKHACHHANG
FROM KHACHHANG, HOADON, SANPHAM, NHASX, CTHD
WHERE KHACHHANG.MAKHACHHANG = HOADON.MAKHACHHANG
	  AND CTHD.SOHOADON = HOADON.SOHOADON
	  AND CTHD.MASANPHAM = SANPHAM.MASANPHAM
	  AND SANPHAM.MANHASX = NHASX.MANHASX
	  AND TENNHASX <> 'HARO'

--6. Tìm các nhân viên bán được ít xe đạp thuộc loại Cyclocross Bicycles nhất 
--CACH 1
SELECT NHANVIEN.MANHANVIEN, HO, TEN
FROM NHANVIEN, HOADON, CTHD, LOAISP, SANPHAM
WHERE NHANVIEN.MANHANVIEN = HOADON.MANHANVIEN
	AND HOADON.SOHOADON = CTHD.SOHOADON
	AND SANPHAM.MASANPHAM = CTHD.MASANPHAM
	AND SANPHAM.MALOAISP = LOAISP.MALOAISP
	AND TENLOAISP = 'Cyclocross Bicycles'
GROUP BY NHANVIEN.MANHANVIEN, HO, TEN
HAVING SUM(SOLUONG) <= ALL( SELECT SUM(SOLUONG)
							FROM HOADON, CTHD, LOAISP, SANPHAM
							WHERE HOADON.SOHOADON = CTHD.SOHOADON
								AND SANPHAM.MASANPHAM = CTHD.MASANPHAM
								AND SANPHAM.MALOAISP = LOAISP.MALOAISP
								AND TENLOAISP = 'Cyclocross Bicycles' 
							GROUP BY MANHANVIEN)

--CACH 2:
SELECT TOP 1 WITH TIES NHANVIEN.MANHANVIEN, HO, TEN
FROM NHANVIEN, HOADON, CTHD, LOAISP, SANPHAM
WHERE NHANVIEN.MANHANVIEN = HOADON.MANHANVIEN
	AND HOADON.SOHOADON = CTHD.SOHOADON
	AND SANPHAM.MASANPHAM = CTHD.MASANPHAM
	AND SANPHAM.MALOAISP = LOAISP.MALOAISP
	AND TENLOAISP = 'Cyclocross Bicycles'
GROUP BY NHANVIEN.MANHANVIEN, HO, TEN
ORDER BY SUM(SOLUONG) ASC

--7. Liệt kê những cửa hàng chứa trong kho tất cả các xe đạp của nhà sản xuất Sun Bicycles
SELECT CUAHANG.MACUAHANG, TENCUAHANG
FROM CUAHANG, KHO, SANPHAM, NHASX
WHERE CUAHANG.MACUAHANG = KHO.MACUAHANG
	AND KHO.MASANPHAM = SANPHAM.MASANPHAM
	AND SANPHAM.MANHASX = NHASX.MANHASX
	AND TENNHASX ='Sun Bicycles'
GROUP BY CUAHANG.MACUAHANG, TENCUAHANG
HAVING COUNT(SP.MASANPHAM) = (SELECT COUNT(SANPHAM.MASANPHAM)
							  FROM SANPHAM, NHASX
							  WHERE SANPHAM.MANHASX = NHASX.MANHASX
							  AND TENNHASX = 'Sun Bicycles')


-----------------------------------------------ĐỀ HK1 2017-2018 - DE1------------------------------------------------
--A)Hiển thị thông tin các tài khoản của các khách hàng (SoTK, TrangThai, SoDu) đã 
-- mở tài khoản vào ngày ‘01/01/2017’ (NgayMo) và sắp xếp kết quả theo số dư tăng dần. 
SELECT SOTK, TRANGTHAI, SODU
FROM TAIKHOAN
WHERE NGAYMO = '01/01/2017' 
ORDER BY SODU ASC

--B) Liệt kê mã loại giao dịch (MaLGD) cùng với tổng số tiền (SoTien) giao dịch của
--từng loại giao dịch.
SELECT MALGD , SUM(SOTIEN)
FROM GIAODICH
ORDER BY MALGD

--C) Cho biết những khách hàng (MaKH, HoTen, CMND) đã mở cả hai loại tài khoản:
--tiết kiệm (TenLTK= ‘Tiết kiệm’) và thanh toán (TenLTK= ‘Thanh toán’)
SELECT KHACHHANG.MAKH, HOTEN, CMND
FROM KHACHHANG, LOAITAIKHOAN, TAIKHOAN
WHERE KHACHHANG.MAKH = TAIKHOAN.MAKH
	AND LOAITAIKHOAN.MALTK = TAIKHOAN.MALTK
	AND TENLTK = N'Tiết kiệm'
INTERSECT
SELECT KHACHHANG.MAKH, HOTEN, CMND
FROM KHACHHANG, LOAITAIKHOAN, TAIKHOAN
WHERE KHACHHANG.MAKH = TAIKHOAN.MAKH
	AND LOAITAIKHOAN.MALTK = TAIKHOAN.MALTK
	AND TENLTK = N'Thanh toán'


--D)Liệt kê thông tin các giao dịch (MaGD, SoTK, MaLGD, NgayGD, SoTien,
--NoiDung) có số tiền lớn nhất trong tháng 12 năm 2017
SELECT TOP 1 WITH TIES *
FROM GIAODICH
WHERE MONTH(NGAYGD) = 12 AND YEAR(NGAYGD) = 2017
ORDER BY SOTIEN DESC

--E)Liệt kê danh sách các khách hàng (MaKH, HoTen, SoDT) đã mở tất cả các loại tài khoản.
SELECT KHACHHANNG.MAKH, HOTEN, SODT
FROM KHACHHANG, TAIKHOAN
WHERE KHACHHANG.MAKH = TAIKHOAN.MAKH
GROUP BY KHACHHANNG.MAKH, HOTEN, SODT
HAVING COUNT(DISTINCT MALTK) = (SELECT COUNT(MALTK)
								FROM LOAITAIKHOAN)
--F)Liệt kê những loại tài khoản (MaLTK, TenLTK) được mở nhiều nhất trong năm 2016
SELECT TOP 1 WITH TIES LOAITAIKHOAN.MALTK, TENLTK
FROM LOAITAIKHOAN, TAIKHOAN
WHERE LOAITAIKHOAN.MALTK = TAIKHOAN.MALTK
	AND YEAR(NGAYMO) = 2016
GROUP BY LOAITAIKHOAN.MALTK, TENLTK
ORDER BY COUNT(SOTK) DESC
