use demo_ss2;
select*
from student
where student_point > 5;

select*
from student;

select*
from student
where (student_name like"%hai") or (student_name like"%huynh");

select*
from student
where (student_name like"nguyen%");

select student.*,class.class_name
from student
left join class on class.class_id = student.class_id
where class.class_name = "c1121g1";



select student.student_id,
    student.student_name,
    student.student_birthday,
    student.student_gender,
    student.student_point,
    class.class_name
from student
left join class On student.class_id = class.class_id;



select 
class.class_name,
student.student_id,
    student.student_name,
    student.student_birthday,
    student.student_gender,
    student.student_point,
    student.class_id
from student
join
    class class on student.class_id = class.class_id
WHERE
    class.class_name = 'c1121g1'
    order by 
    student.student_name;


-- join class class On class.class_id = 1;
 -- right join class On student.class_id = class.class_id;


-- 1 lay ra  thong tin hoc vien dang hoc lop nao
select student.*,class.class_name
from student
 join class on class.class_id = student.class_id;
 
 -- 2 lay ra thong tin  tatt cac hoc vien ke ca nung ban chua co lop
 
 select student.*,class.class_name
from student
 left join class on class.class_id = student.class_id;
 
 -- 3 lay ra thong tin hoc sinh co ten hai va huynh
 
 select *
from student
where student.student_name like"% hai" or student.student_name like"% huynh";

-- 4 lay ra hoc vien co diem lon hon 5

select *
from student
where student_point > 5;

 -- 5 lay ra thong tin hoc sinh co ho la nguyen
 
 select *
from student
where student.student_name like"nguyen %";

-- 6 thong ke theo diem
select student_point,count(student.student_point) diemthi
from student
group by student_point;

-- 7 thong ke so luong diem va diem phai lon hon 5

select student_point,count(student.student_point) soluong
from student
where student_point > 5
group by student_point;

-- 8  Thông kế số lượng học sinh theo điểm lớn hơn 5 và chỉ hiện thị với số lượng>=2

select student_point,count(student.student_point) soluong
from student
where student_point > 5
group by student_point
having soluong >= 2;

-- 9   Lấy ra danh sách học viên của lớp c1121g1 và sắp xếp tên học viên theo alphabet.

select student.*,class.class_name
from student
 join class on class.class_id = student.class_id
 where class.class_name = "c1121g1"
 ;
 











