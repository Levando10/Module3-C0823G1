 -- bai tap ex1
    -- Hiển thị tất cả các thông tin môn học (bảng subject) có credit lớn nhất.
    
SELECT 
    *
FROM
    subject
GROUP BY subject.id
HAVING subject.credit >= ALL (SELECT 
        subject.credit
    FROM
        subject
    GROUP BY subject.id);
    
    
    -- ex 2
    -- Hiển thị các thông tin môn học có điểm thi lớn nhất.
    
 SELECT 
    subject.*, mark.mark
FROM
    subject
        JOIN
    mark ON mark.sub_id = subject.id
GROUP BY mark.id
HAVING mark.mark >= ALL (SELECT 
        mark.mark
    FROM
        mark
    GROUP BY mark.id);
    
    
    
    
    
    -- ex 3
    -- Hiển thị các thông tin sinh viên và điểm trung bình của mỗi sinh viên, xếp hạng theo thứ tự điểm giảm dần
    
  SELECT 
    student.*, AVG(mark.mark) AS diem_trung_binh
FROM
    student
        JOIN
    mark ON mark.student_id = student.id
GROUP BY student_id
ORDER BY AVG(mark.mark) DESC