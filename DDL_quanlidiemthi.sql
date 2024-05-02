use quanlydiemthi;
# Tạo Bảng
create table Student
(
    studentId   varchar(4) primary key not null,
    studentName varchar(100)           not null,
    birthday    date                   not null,
    gender      bit(1)                 not null,
    address     text                   not null,
    phoneNumber varchar(45) unique
);
create table Subject
(
    subjectId   varchar(4) primary key not null,
    subjectName varchar(45)            not null,
    priority    int(11)                not null
);
create table Mark
(
    subjectId varchar(4) not null,
    studentId varchar(4) not null,
    point     float    not null,
    primary key (subjectId, studentId)
);
# Tạo khóa ngoại
alter table Mark
    add constraint Student_StudentID_fk foreign key (studentId) references Student (studentId);
alter table Mark
    add constraint Subject_SubjectId_fk foreign key (subjectId) references Subject (subjectId);
#Nhập dữ liệu
#Nhập dữ liệu vào bảng Student
insert into Student(studentId, studentName, birthday, gender, address, phoneNumber)
values ('S001', 'Nguyễn Thế Anh', '1999-01-11', 1, 'Hà Nội', '984678082'),
       ('S002', 'Đặng Bảo Trâm', '1998-12-22', 0, 'Lào Cai', '904982654'),
       ('S003', 'Trần Hà Phương', '2000-05-05', 0, 'Nghệ An', '947645363'),
       ('S004', 'Đỗ Tiến Mạnh', '1999-03-26', 1, 'Hà Nội', '983665353'),
       ('S005', 'Phạm Duy Nhất', '1998-10-04', 1, 'Tuyên Quang', '987242678'),
       ('S006', 'Mai Văn Thái', '2002-06-22', 1, 'Nam Định', '982654268'),
       ('S007', 'Giang Gia Hân', '1996-11-10', 0, 'Phú Thọ', '982364753'),
       ('S008', 'Nguyễn Ngọc Bảo My', '1999-1-22', 0, 'Hà Nam', '927867453'),
       ('S009', 'Nguyễn Tiến Đạt', '1998-08-07', 1, 'Tuyên Quang', '989274673'),
       ('S010', 'Nguyễn Thiều Quang', '2000-09-18', 1, 'Hà Nội', '984378291');

#Nhập dữ liệu vào bảng Subject
insert into Subject(subjectId, subjectName, priority)
values ('MH01', 'Toán', 2),
       ('MH02', 'Vật Lý', 2),
       ('MH03', 'Hóa Học', 1),
       ('MH04', 'Ngữ Văn', 1),
       ('MH05', 'Tiếng Anh', 2);

#Nhập dữ liệu vào bảng Mark
insert into Mark(studentId, subjectId, point)
values ('S001', 'MH01', 8.5),
       ('S001', 'MH02', 7),
       ('S001', 'MH03', 9),
       ('S001', 'MH04', 9),
       ('S001', 'MH05', 5),
       ('S002', 'MH01', 9),
       ('S002', 'MH02', 8),
       ('S002', 'MH03', 6.5),
       ('S002', 'MH04', 8),
       ('S002', 'MH05', 6),
       ('S003', 'MH01', 7.5),
       ('S003', 'MH02', 6.5),
       ('S003', 'MH03', 8),
       ('S003', 'MH04', 7),
       ('S003', 'MH05', 7),
       ('S004', 'MH01', 6),
       ('S004', 'MH02', 7),
       ('S004', 'MH03', 5),
       ('S004', 'MH04', 6.5),
       ('S004', 'MH05', 8),
       ('S005', 'MH01', 5.5),
       ('S005', 'MH02', 8),
       ('S005', 'MH03', 7.5),
       ('S005', 'MH04', 8.5),
       ('S005', 'MH05', 9),
       ('S006', 'MH01', 8),
       ('S006', 'MH02', 10),
       ('S006', 'MH03', 9),
       ('S006', 'MH04', 7.5),
       ('S006', 'MH05', 6.5),
       ('S007', 'MH01', 9.5),
       ('S007', 'MH02', 9),
       ('S007', 'MH03', 6),
       ('S007', 'MH04', 9),
       ('S007', 'MH05', 4),
       ('S008', 'MH01', 10),
       ('S008', 'MH02', 8.5),
       ('S008', 'MH03', 8.5),
       ('S008', 'MH04', 6),
       ('S008', 'MH05', 9.5),
       ('S009', 'MH01', 7.5),
       ('S009', 'MH02', 7),
       ('S009', 'MH03', 9),
       ('S009', 'MH04', 5),
       ('S009', 'MH05', 10),
       ('S010', 'MH01', 6.5),
       ('S010', 'MH02', 8),
       ('S010', 'MH03', 5.5),
       ('S010', 'MH04', 4),
       ('S010', 'MH05', 7);

# Sửa tên sinh viên có mã `S004` thành “Đỗ Đức Mạnh”.
update student
set studentName = 'Đỗ Đức Mạnh'
where studentId = 'S004';

# Sửa tên và hệ số môn học có mã `MH05` thành “Ngoại Ngữ” và hệ số là 1.
update subject
set subjectName = 'Ngoại Ngữ'
where subjectId = 'MH05';

update subject
set priority = 1
where subjectId = 'MH05';

# Cập nhật lại điểm của học sinh có mã `S009` thành (MH01 : 8.5, MH02 : 7,MH03 : 5.5, MH04 : 6, MH05 : 9).
update mark
set point = 8.5
where studentId = 'S009' and subjectId = 'MH01';
update mark
set point = 7
where studentId = 'S009' and subjectId = 'MH02';
update mark
set point = 5.5
where studentId = 'S009' and subjectId = 'MH03';
update mark
set point = 6
where studentId = 'S009' and subjectId = 'MH04';
update mark
set point = 9
where studentId = 'S009' and subjectId = 'MH05';

# Xoá toàn bộ thông tin của học sinh có mã `S010` bao gồm điểm thi ở bảng MARK
# và thông tin học sinh này ở bảng STUDENT.

delete from Mark where studentId = 'S010';
delete from student where studentId = 'S010';

