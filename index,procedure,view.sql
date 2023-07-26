-- Index : chỉ mục 
create table DEMO(
id int primary key ,
name varchar(50) 
);

insert into DEMO values
(4,"A"), 
(7,"A"), 
(8,"G"), 
(2,"B"), 
(1,"D"); 

-- tạo chỉ mục 
create unique index index_name on DEMO(name);

-- xóa chỉ mục 
drop index index_name on demo ;
-- sửa

-- tạo procedure thêm mới bản ghi 
DELIMITER //
create procedure insertDemo(idnew int,newName varchar(50))
begin
	insert into DEMO values(idnew, newName) ;
end;
// delimiter ;
-- goi procedure
call insertDemo(23,"Ban ghi so 23");

delimiter //
create procedure procdemo(in input int,out output varchar(50))
begin 
#      khái báo biến
#     declare  ucase  varchar(50);
#     gan giá trị cho biến
#     set  ucase = 'hung';
      if (input > 0) then 
      set output = "so duong";
      else 
      set output = "so am";
      end if;
end
// delimiter ;

-- view 
select id, name from product;
-- khoi tao view
create view V_supProduct as (select p.*,c.name as catalog_name from product p join catalogs c on p.catalogid = c.id);
select * from V_supProduct;

-- 1. Liệt kê danh sách sinh viên, gồm các thông tin sau: Mã sinh viên, Họ sinh 
-- viên, Tên sinh viên, Học bổng. Danh sách sẽ được sắp xếp theo thứ tự Mã 
-- sinh viên tăng dần
select masv,hosv,tensv,hocbong
from dmsv
order by masv;
create view V1 as ( select masv,hosv,tensv,hocbong from dmsv order by masv );
select * from V1;
-- 2. Danh sách các sinh viên gồm thông tin sau: Mã sinh viên, họ tên sinh viên, 
-- Phái, Ngày sinh. Danh sách sẽ được sắp xếp theo thứ tự Nam/Nữ.
select masv, concat(hosv, ' ',tensv) as tensinhvien,phai,ngaysinh 
from dmsv
order by phai;
create view V2 as(select masv, concat(hosv, ' ',tensv) as tensinhvien,phai,ngaysinh 
from dmsv
order by phai);
select* from V2;



-- 3. Thông tin các sinh viên gồm: Họ tên sinh viên, Ngày sinh, Học bổng. Thông 
-- tin sẽ được sắp xếp theo thứ tự Ngày sinh tăng dần và Học bổng giảm dần.
create view dataSV as select sv.hosv,sv.tensv,sv.ngaysinh,sv.hocbong from dmsv sv 
order by sv.hocbong desc, sv.ngaysinh asc;
select * from dataSV;

-- 4. Danh sách các môn học có tên bắt đầu bằng chữ T, gồm các thông tin: Mã 
-- môn, Tên môn, Số tiết.
select dmmh.TenMH, dmmh.MaMH,dmmh.SoTiet
from dmmh
where TenMH like "T%";
create view v4 as select dmmh.TenMH, dmmh.MaMH,dmmh.SoTiet
from dmmh
where TenMH like "T%";
select * from v4;

-- 5. Liệt kê danh sách những sinh viên có chữ cái cuối cùng trong tên là I, gồm 
-- các thông tin: Họ tên sinh viên, Ngày sinh, Phái.
create view  danhsanchsv as (select concat(hosv, ' ',tensv) as 'Ho ten SV', date(ngaysinh) as 'Ngay sinh', phai from dmsv
where tensv like '%i');
select * from danhsanchsv;

-- 6. Danh sách những khoa có ký tự thứ hai của tên khoa có chứa chữ N, gồm 
-- các thông tin: Mã khoa, Tên khoa.
create view tenkhoa_n as select *
from dmkhoa k
where k.TenKhoa like '_n%';
select * from tenkhoa_n;
-- 7. Liệt kê những sinh viên mà họ có chứa chữ Thị
create view subdmsv3 as select * from dmsv where hosv like '%thị%';
select * from subdmsv3;
-- 8. Cho biết danh sách các sinh viên có học bổng lớn hơn 100,000, gồm các 
-- thông tin: Mã sinh viên, Họ tên sinh viên, Mã khoa, Học bổng. Danh sách sẽ
-- được sắp xếp theo thứ tự Mã khoa giảm dần
DELIMITER //

CREATE PROCEDURE hocbonglon(hongbongL float)
BEGIN
	SELECT masv, tensv, makhoa, hocbong    FROM dmsv where hocbong > hongbongL order by makhoa desc ;
END //

DELIMITER ;
call hocbonglon(150000)
-- 9. Liệt kê các sinh viên có học bổng từ 150,000 trở lên và sinh ở Hà Nội, gồm 
-- các thông tin: Họ tên sinh viên, Mã khoa, Nơi sinh, Học bổng.
-- 10.Danh sách các sinh viên của khoa Anh văn và khoa Vật lý, gồm các thông 
-- tin: Mã sinh viên, Mã khoa, Phái.
-- 11.Cho biết những sinh viên có ngày sinh từ ngày 01/01/1991 đến ngày 
-- 05/06/1992 gồm các thông tin: Mã sinh viên, Ngày sinh, Nơi sinh, Học 
-- bổng.
-- 12.Danh sách những sinh viên có học bổng từ 80.000 đến 150.000, gồm các 
-- thông tin: Mã sinh viên, Ngày sinh, Phái, Mã khoa.
-- 13.Cho biết những môn học có số tiết lớn hơn 30 và nhỏ hơn 45, gồm các thông 
-- tin: Mã môn học, Tên môn học, Số tiết.
-- 14.Liệt kê những sinh viên nam của khoa Anh văn và khoa tin học, gồm các 
-- thông tin: Mã sinh viên, Họ tên sinh viên, tên khoa, Phái.



-- 31.Cho biết những nơi nào có hơn 2 sinh viên đang theo học tại trường.
DELIMITER //

CREATE PROCEDURE b31()
BEGIN
	SELECT noisinh, count(noisinh) from dmsv
    group by noisinh
    having count(noisinh) > 1;
END //

DELIMITER ;
call b31();

-- 32.Cho biết những môn nào có trên 3 sinh viên dự thi.
DELIMITER //

CREATE PROCEDURE b32()
BEGIN
	SELECT dmmh.TenMH, count(distinct kq.masv) from dmmh
    join ketqua kq on dmmh.MaMH = kq.MaMH
    group by kq.MaMH
    having count(distinct kq.masv) > 3;
END //

DELIMITER ;
call b32();

-- 33.Cho biết những sinh viên thi lại trên 2 lần.
DELIMITER //

CREATE PROCEDURE b33()
BEGIN
	select dmsv.tensv, ketqua.Mamh,count(ketqua.lanthi) as `so lan thi` from ketqua 
    join dmsv on dmsv.masv = ketqua.masv
    group by ketqua.masv,ketqua.MaMH
    having count(ketqua.lanthi) >= 2;
END //

DELIMITER ;
call b33();


-- 34.Cho biết những sinh viên nữ có điểm trung bình lần 1 trên 7.0
DELIMITER //

CREATE PROCEDURE b34()
BEGIN
	select dmsv.tensv, avg(ketqua.Diem) `diem TB`
    from ketqua
    join dmsv on dmsv.masv = ketqua.masv
    where dmsv.phai = 'Nữ' and ketqua.lanthi = 1
    group by ketqua.masv
    having avg(ketqua.diem) > 7.0;
END //

DELIMITER ;
call b34();
-- 35.Cho biết danh sách các sinh viên rớt trên 2 môn ở lần thi 1.
DELIMITER //
create PROCEDURE task35()
begin
select MaSV, count(*) as 'so lan rot'
from ketqua
where Diem < 5 and lanthi = 1
group by MaSv
having count(*) > 1;
end //
DELIMITER ;
call task35()

-- 36.Cho biết danh sách những khoa có nhiều hơn 2 sinh viên nam
DELIMITER //
create PROCEDURE task36()
begin
select MaKhoa, count(*) as 'so luong sinh vien nam'
from dmsv
where phai = 'Nam'
group by MaSv
having count(*) > 2;
end //
DELIMITER ;
call task36();
-- 37.Cho biết những khoa có 2 sinh đạt học bổng từ 200.000 đến 300.000.
select kh.* from dmsv sv
join dmkhoa kh on sv.MaKhoa = kh.MaKhoa 
group by kh.MaKhoa
having count(case when sv.HocBong between 200000 and 300000 then sv.MaSV end) = 2;

-- 38.Cho biết số lượng sinh viên đậu và số lượng sinh viên rớt của từng môn 
-- trong lần thi 1.
select mh.TenMH,count(case when kq.Diem < 4 then kq.MaSV end) 'rớt môn',count(case when kq.Diem >= 4 then kq.MaSV end) 'qua môn' from ketqua kq 
join dmmh mh on mh.MaMH = kq.MaMH
where kq.LanThi = 1 group by mh.TenMH;

-- 39.Cho biết sinh viên nào có học bổng cao nhất.
DELIMITER //
create PROCEDURE sv39()
begin
select MaSV,HoSV,TenSV,HocBong from dmsv
where hocbong = (select max(HocBong) from dmsv) 
group by masv;
end //
DELIMITER ;
call sv39();
-- 40.Cho biết sinh viên nào có điểm thi lần 1 môn cơ sở dữ liệu cao nhất.
DELIMITER //
create PROCEDURE sv40()
begin
select dmsv.masv,dmsv.HoSV,dmsv.TenSV,kq.diem from dmsv 
join ketqua kq on kq.masv =dmsv.masv
join dmmh on dmmh.mamh = kq.mamh
where dmmh.tenmh = 'Cơ Sở Dữ Liệu' and kq.lanthi =1
order by kq.diem desc
limit 1 ;
end //
DELIMITER ;
call sv40();
-- 41.Cho biết sinh viên khoa anh văn có tuổi lớn nhất.
DELIMITER //
create PROCEDURE sv41()
begin
select dv.MaKhoa,year(now())-year(NgaySinh) as tuoisv from dmsv dv
where dv.Makhoa like 'AV'
order by tuoisv desc
limit 1;
end //
DELIMITER ;
call sv41();
-- 42.Cho biết khoa nào có đông sinh viên nhất.
DELIMITER //
create PROCEDURE sv42()
begin
select dv.MaKhoa,count(*) as sosv from dmsv dv
group by dv.MaKhoa
order by sosv desc
limit 1;
end //
DELIMITER ;
call sv42();
drop procedure sv42;
-- 43.Cho biết khoa nào có đông nữ nhất.
-- 44.Cho biết môn nào có nhiều sinh viên rớt lần 1 nhiều nhất.
-- 45.Cho biết sinh viên không học khoa anh văn có điểm thi môn phạm lớn hơn 
-- điểm thi văncủa sinh viên học khoa anh văn.
-- 46.Cho biết sinh viên có nơi sinh cùng với Hải.
-- 47.Cho biết những sinh viên nào có học bổng lớn hơn tất cả học bổng của
-- sinh viên thuộc khoa anh văn
-- 48.Cho biết những sinh viên có học bổng lớn hơn bất kỳ học bổng của sinh viên 
-- học khóa anh văn
-- 49. ho biết sinh viên nào có điểm thi môn cơ sở dữ liệu lần 2 lớn hơn tất cả điểm 
-- thi lần 1 môn cơ sở dữ liệu của những sinh viên khác.
-- 50.Cho biết những sinh viên đạt điểm cao nhất trong từng môn.
-- 51.Cho biết những khoa không có sinh viên học.
-- 52.Cho biết sinh viên chưa thi môn cơ sở dữ liệu.
-- 53.Cho biết sinh viên nào không thi lần 1 mà có dự thi lần 2.
-- 54.Cho biết môn nào không có sinh viên khoa anh văn học.
-- 55.Cho biết những sinh viên khoa anh văn chưa học môn văn phạm.
-- 56.Cho biết những sinh viên không rớt môn nào.
-- 57.Cho biết những sinh viên học khoa anh văn có học bổng và những sinh viên 
-- chưa bao giờ rớt.
-- 58.Cho biết khoa nào có đông sinh viên nhận học bổng nhất và khoa nào khoa 
-- nào có ít sinh viên nhận học bổng nhất.
-- 59.Cho biết 3 sinh viên có học nhiều môn nhất.
-- 60.Cho biết những môn được tất cả các sinh viên theo học.
-- 61.Cho biết những sinh viên học những môn giống sinh viên có mã số A02 học.
-- 62.Cho biết những sinh viên học những môn bằng đúng những môn mà sinh 
-- viên A02 học
