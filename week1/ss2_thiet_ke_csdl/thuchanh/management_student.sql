create database management_student;

create table class(
class_id int not null auto_increment primary key,
class_name varchar(60) not null,
start_date datetime not null,
class_status bit

);

create table student(
student_id int not null auto_increment primary key,
student_name varchar(30) not null,
student_address varchar(50) ,
student_phone varchar(20),
student_status bit,
class_id int not null,
foreign key(class_id) references class(class_id)
);

create table `subject`(
subject_id int not null primary key auto_increment,
subject_name varchar(30) not null,
subject_credit tinyint not null default 1 check (subject_credit >= 1),
subject_status bit default 1

);

create table mark (
mark_id int not null primary key auto_increment,
subject_id int not null,
student_id  int not null,
mark float default 0 check(mark between 0 and 100),
exam_time tinyint default 1,
unique(subject_id , student_id),
foreign key(student_id) references student(student_id),
foreign key(subject_id) references `subject`(subject_id)
);