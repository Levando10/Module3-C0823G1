
use management_student_ex;
    
    -- 1   Hiển thị tất cả các sinh viên có tên bắt đầu bảng ký tự ‘h’
    select *
    from student
    where student.name like'H%';
    
    -- 2 Hiển thị các thông tin lớp học có thời gian bắt đầu vào tháng 12.
     select *
    from class
    where month(class.start_date ) = 12;
    
     -- 3 Hiển thị tất cả các thông tin môn học có credit trong khoảng từ 3-5.
     -- fix
       select*
     from subject
     where subject.credit between 3 and 5;
     
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
   

  
    
 

 
