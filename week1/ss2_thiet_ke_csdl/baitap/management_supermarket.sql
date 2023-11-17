create database management_supermarket;
use management_supermarket;

create table customer(
customer_id int  auto_increment primary key,
customer_name varchar(30) not null,
customer_age int not null
);

create table `order`(
order_id int auto_increment primary key,
order_day date,
customer_id int not null,
order_total_price double,

foreign key (customer_id) references customer(customer_id)
);


create table product(
product_id int primary key auto_increment,
product_name varchar(40),
product_price double check(product_price > 0)
);

create table order_detail(
product_id int not null,
order_id int not null,
order_quantity int check(order_quantity > 0),
foreign key (order_id) references `order`(order_id),
foreign key (product_id) references product(product_id)
);
ALTER TABLE order_detail
ADD PRIMARY KEY (product_id, order_id);
-- data customer

insert into customer(customer_name,customer_age) 
values("Văn độ",21),
("Văn bảo",18),
("Văn tuấn",27),
("Trần lâm",18);

-- data order
insert into `order`(order_day,customer_id,order_total_price) 
values("2023-2-16",1,400000),
("2023-11-16",4,400000),
("2023-12-21",2,400000),
("2023-7-18",2,400000),
("2023-5-20",4,400000),
("2023-12-21",3,400000),
("2023-7-18",3,400000),
("2023-5-20",1,400000);

-- data product
insert into product(product_name,product_price)
values("bánh kẹo",5000),
("gối",120000),
("mì tôm",6000),
("nước ngọt",15000);

select*
from `order`
where customer_id = 2;


