-- bai tap ex1
    -- Hiển thị tất cả các thông tin môn học (bảng subject) có credit lớn nhất.
    
SELECT *
FROM subject
WHERE credit IN (SELECT MAX(credit)
        FROM subject
        );
    
    -- ex 2
    -- Hiển thị các thông tin môn học có điểm thi lớn nhất.

SELECT subject.*
FROM subject 
JOIN mark ON subject.sub_id = mark.sub_id
WHERE mark.mark IN (SELECT MAX(mark.mark)
        FROM mark);
    

    -- ex 3
    -- Hiển thị các thông tin sinh viên và điểm trung bình của mỗi sinh viên, xếp hạng theo thứ tự điểm giảm dần
    
  SELECT student.*, AVG(mark.mark) AS diem_trung_binh
FROM student
        JOIN mark ON mark.student_id = student.id
GROUP BY student_id
ORDER BY AVG(mark.mark) DESC;