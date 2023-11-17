create database management_student_ex;
use management_student_ex;
create table class
(
    id   int        not null auto_increment primary key,
  `name` varchar(60)not null,
    start_date datetime   not null,
    `status`    bit
);
create table student
(
    id   int   not null auto_increment primary key,
    name varchar(30)not null,
    address     varchar(50),
    phone       varchar(20),
    `status`      bit,
    class_id     int        not null,
    foreign key (class_id) references class (id)
);
create table `subject`
(
     id int not null auto_increment primary key,
    `name` varchar(30)not null,
    credit  tinyint    not null default 1 check ( credit >= 1 ),
    `status`  bit default 1
);

create table mark
(
    id    int not null auto_increment primary key,
    sub_id     int not null,
    student_id int not null,
    mark      float   default 0 check ( mark between 0 and 100),
    exam_times tinyint default 1,
    unique (sub_id, student_id),
    foreign key (sub_id) references `subject` (id),
    foreign key (student_id) references student (id)
);

insert into class
values (1, 'A1', '2008-12-20', 1);
insert into class
values (2, 'A2', '2008-12-22', 1);
insert into class
values (3, 'B3', current_date, 0);



insert into student (`name`, address, phone, `status`, class_id)
values ('Hung', 'Ha Noi', '0912113113', 1, 1);
insert into student (`name`, address, `status`, class_id)
values ('Hoa', 'Hai phong', 1, 1);
insert into student (`name`, address, phone, `status`, class_id)
values ('Manh', 'HCM', '0123123123', 0, 2);
insert into student (`name`, address, `status`, class_id)
values ('Hoa', 'Hai phong', 1, 3),
('thanh', 'Hai phong', 1, 2),
('hien', 'Hai phong', 1, 2);

insert into `subject`
values (5, 'CF', 5, 1),
 (6, 'java', 6, 1),
 (7, 'HDJ', 5, 1),
  (8, 'codegym', 11, 1),
 (9, 'RDBMS', 10, 1);


insert into mark (sub_id, student_id, mark, exam_times)
values (10, 2, 8, 1),
 (11, 4, 10, 2),
 (11, 5, 10, 5),
 (11, 6, 10, 2),
 (13, 2, 12, 1);
 
 
    
    -- 1   Hiển thị tất cả các sinh viên có tên bắt đầu bảng ký tự ‘h’
    select *
    from student
    where student.name like'H%';
    
    -- 2 Hiển thị các thông tin lớp học có thời gian bắt đầu vào tháng 12.
     select *
    from class
    where month(class.start_date ) = 12;
    
     -- 3 Hiển thị tất cả các thông tin môn học có credit trong khoảng từ 3-5.
     
     select*
     from subject
     where subject.credit >= 3 and subject.credit <= 5;
     
     -- 4 Thay đổi mã lớp(ClassID) của sinh viên có tên ‘Hung’ là 2.
     set SQL_SAFE_UPDATES = 0;
      set SQL_SAFE_UPDATES = 1;
     
	update student
    set student.class_id = 2
    where student.name = "Hung";
    
    -- 5 Hiển thị các thông tin: StudentName, SubName, Mark. Dữ liệu 
    -- sắp xếp theo điểm thi (mark) giảm dần. nếu trùng sắp theo tên tăng dần.
    
   select student.name as student,subject.name as subject,mark.mark
   from student
    left join mark on student.id = mark.student_id
   join subject on mark.sub_id = subject.id
   order by 
    mark.mark desc, student.name asc;
   

  
    
 

 
