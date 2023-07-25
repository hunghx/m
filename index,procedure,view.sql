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

