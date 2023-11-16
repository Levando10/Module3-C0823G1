create database management_score_exem;

create table student(
student_id varchar(20) primary key,
student_name varchar(50),
student_date datetime,
student_class varchar(20),
student_decription varchar(20)

);

create table `subject`(
subject_id varchar(20) primary key,
subject_name varchar(50),
teacher_id varchar(20),
foreign key(teacher_id) references teacher(teacher_id)
);

create table score(
student_id varchar(20),
subject_id varchar(20),
score_exem int,
 date_exem DATETIME,
primary key(student_id ,subject_id),
foreign key(student_id) references student(student_id),
foreign key(subject_id) references subject(subject_id)

);

create table teacher(
teacher_id varchar(20) primary key,
teacher_name varchar(50),
teacher_date varchar(10)
);

ALTER TABLE teacher change column teacher_date teacher_phone varchar(10);

