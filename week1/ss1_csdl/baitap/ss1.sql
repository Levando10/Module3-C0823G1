
create database management_school;
use management_school;

create table student(
student_id int primary key auto_increment,
`name` varchar (50),
age int,
country varchar(50),
class_id int ,
foreign key(class_id) references class(class_id)
);


create table teacher(
teacher_id int primary key auto_increment,
class_id int ,
`name` varchar (50),
age int,
country int,
foreign key(class_id) references class(class_id)

);


create table class(
class_id int primary key auto_increment,
`name` varchar (50)
);


insert into student(`name`,age,country)
values("van bao",21,"viet nam"),
("van tung",29,"viet nam");	

SET SQL_SAFE_UPDATES = 1;
delete from student;

select age
from student
where age >= 29;
