use quanlydiemthi;
# Truy vấn dữ liệu
# 1. Lấy ra tất cả thông tin của sinh viên trong bảng Student .
select *
from student;

# 2. Hiển thị tên và mã môn học của những môn có hệ số bằng 1.
select subjectId MaMonHoc, subjectName TenMonHoc
from subject
where priority = 1;

# 3. Hiển thị thông tin học sinh bào gồm: mã học sinh, tên học sinh, tuổi (bằng năm hiện tại trừ
# năm sinh) , giới tính (hiển thị nam hoặc nữ) và quê quán của tất cả học sinh.
select studentId                                                     MaHocSinh,
       studentName                                                   TenHocSinh,
       (year(curdate()) - year(birthday)) as                         Tuoi,
       case when gender = 1 then 'Nam' when gender = 0 then 'Nữ' end GioiTinh,
       address                                                       QueQuan
from student;

# 4. Hiển thị thông tin bao gồm: tên học sinh, tên môn học , điểm thi của tất cả học sinh của môn
# Toán và sắp xếp theo điểm giảm dần.
select studentName TenHocSinh, subjectName TenMonHoc, point DiemThi
from mark M
         join student S on M.studentId = S.studentId
         join subject SJ on M.subjectId = SJ.subjectId
where subjectName like 'Toán'
order by point desc;

# 5. Thống kê số lượng học sinh theo giới tính ở trong bảng (Gồm 2 cột: giới tính và số lượng).
select case when gender = 1 then 'Nam' when gender = 0 then 'Nữ' end GioiTinh, count(studentId) SoLuong
from student
group by gender;

# 6. Tính tổng điểm và điểm trung bình của các môn học theo từng học sinh (yêu cầu sử dụng hàm
# để tính toán) , bảng gồm mã học sinh, tên hoc sinh, tổng điểm và điểm trung bình.
select M.studentId MaHocSinh, studentName TenHocSinh, sum(point) TongDiem, avg(point) DiemTrungBinh
from mark M
         join student S on M.studentId = S.studentId
group by M.studentId;

# Tạo View, Index, Procedure
# 1. Tạo VIEW có tên STUDENT_VIEW lấy thông tin sinh viên bao gồm : mã học sinh, tên học
# sinh, giới tính , quê quán .
create view STUDENT_VIEW as
select studentId                                                     MaHocSinh,
       studentName                                                   TenHocSinh,
       case when gender = 1 then 'Nam' when gender = 0 then 'Nữ' end GioiTinh,
       address                                                       QueQuan
from student;
select *
from STUDENT_VIEW;

# 2. Tạo VIEW có tên AVERAGE_MARK_VIEW lấy thông tin gồm:mã học sinh, tên học sinh,
# điểm trung bình các môn học .
create view AVERAGE_MARK_VIEW as
select S.studentId MaHocSinh, S.studentName TenHocSinh, avg(point) DiemTrungBinh
from mark M
         join student S on M.studentId = S.studentId
group by S.studentId, S.studentName;
select *
from AVERAGE_MARK_VIEW;

# 3. Đánh Index cho trường `phoneNumber` của bảng STUDENT.
create index index_student_phone_number on student (phoneNumber);

#Tạo Procedure
# Tạo PROC_INSERTSTUDENT dùng để thêm mới 1 học sinh bao gồm tất cả thông tin học sinh đó.
delimiter $$
create procedure PROC_INSERTSTUDENT(id_IN varchar(4), name_IN varchar(100), birthday_IN date, gender_IN bit(1),
                                    address_IN text, phoneNumber_IN varchar(45))
begin
    insert into student(studentId, studentName, birthday, gender, address, phoneNumber)
    VALUES (id_IN, name_IN,
            birthday_IN, gender_IN,
            address_IN,
            phoneNumber_IN);
end $$;

# - Tạo PROC_UPDATESUBJECT dùng để cập nhật tên môn học theo mã môn học.
delimiter $$
create procedure PROC_UPDATESUBJECT(id_IN varchar(4),name_IN varchar(100),priority_IN int)
begin
    update subject set subjectName = name_IN, priority = priority_IN
    where subjectId = id_IN;
end $$;

# - Tạo PROC_DELETEMARK dùng để xoá toàn bộ điểm các môn học theo mã học sinh.
delimiter $$
create procedure PROC_DELETEMARK(id_IN varchar(4))
begin
    delete from student
        where studentId = id_IN;
end $$

