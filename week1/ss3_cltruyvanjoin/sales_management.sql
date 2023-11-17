create database management_supermarket_redo;
-- drop database management_supermarket_redo;
use management_supermarket_redo;

create table customer(
id int  auto_increment primary key,
`name` varchar(30) not null,
age int not null
);

create table `order`(
id int auto_increment primary key,
`day` date,
customer_id int not null,
total_price double,
foreign key (customer_id) references customer(id)
);


create table product(
id int primary key auto_increment,
`name` varchar(40),
price double check(price > 0)
);

create table order_detail(
product_id int not null,
order_id int not null,
quantity int check(quantity > 0),
PRIMARY KEY (product_id, order_id),
foreign key (order_id) references `order`(id),
foreign key (product_id) references product(id)
);

-- data customer

insert into customer(`name`,age) 
values("Văn bảo",21),
("Ngoc dan",22),
("Hong Linh",51),
("Minh Phuong",10);

insert into customer(`name`,age) 
values("Anh tuan",25);

-- data order
insert into `order`(`day`,customer_id,total_price) 
values("2023-2-16",1,null),
("2023-11-16",4,null),
("2023-6-21",2,null),
("2023-7-18",2,null),
("2023-9-20",4,null),
("2023-12-21",3,null),
("2023-7-12",1,null),
("2023-10-3",3,null),
("2023-5-20",1,null);

-- data product
insert into product(name,price)
values("May Giat",3),
("Tu Lanh",5),
("Dieu Hoa",7),
("Quat",2),
("Bep Dien",1);

-- data  OrderDetail
insert into order_detail(order_id,product_id,quantity)
values
(1,1,3),
(1,3,7),
(1,4,2),
(2,1,1),
(3,1,8),
(2,5,4),
(2,3,3);


select `order`.id
from customer
join `order` on `order`.customer_id = customer.id
;

select * from customer;
select * from `order`;
select * from order_detail;
select * from product;


-- exercise!!!
-- 1 Hiển thị các thông tin  gồm oID, oDate, oPrice của  
-- tất cả các hóa đơn trong bảng Order

select `order`.id,`order`.day,`order`.total_price
from `order`;

-- 2Hiển thị danh sách các khách hàng đã mua hàng, 
-- và danh sách sản phẩm được mua bởi các khách
select customer.*,product.name
from customer
join `order` on customer.id = `order`.customer_id
join order_detail on order_detail.order_id = `order`.id
join product on  order_detail.product_id = product_id;


-- 3 Hiển thị tên những khách hàng không mua bất kỳ một sản phẩm nào
select customer.name
from customer
 left join `order` on customer.id = `order`.customer_id
where `order`.customer_id  is  null

-- 4 Hiển thị mã hóa đơn, ngày bán và giá tiền của từng hóa đơn (giá một hóa đơn được tính bằng tổng giá bán của từng 
-- loại mặt hàng xuất hiện trong hóa đơn. Giá bán của từng loại được tính = odQTY*pPrice)

select `order`.id,`order`.day, sum(order_detail.quantity * product.price) as TotalPrice
from `order`
join order_detail on order_detail.order_id = `order`.id
join product on  order_detail.product_id = product.id
 group by `order`.id,`order`.day;








