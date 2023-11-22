create database  demo_dB;
drop database demo_dB;
use demo_dB;


CREATE TABLE products (
    product_id INT PRIMARY KEY AUTO_INCREMENT,
    product_code VARCHAR(50),
    product_name VARCHAR(255),
    product_price DOUBLE,
    product_amount INT,
    product_description VARCHAR(500),
    product_status VARCHAR(50)
);

-- them du lieu 
insert into products (product_code, product_name , product_price , product_amount , product_description , product_status)
values ( 'P001', 'Xe đạp', 300000, 50, 'Xe chạy ngon', 'Active'),
( 'P002', 'Xe máy', 1560000, 30, 'Xe đẹp lắm', 'Active'),
( 'P003', 'Ô tô', 5000000, 10, 'Xe vip', 'Inactive'),
( 'P004', 'Xe đạp điện', 1000000, 40, 'Xe xịn', 'Active'),
( 'P005', 'Xe máy điện', 3000000, 10,'Xe ngon lắm', 'Active');

​-- Bước 3:
-- Tạo Unique Index trên bảng Products (sử dụng cột productCode để tạo chỉ mục)

create unique index index_product_code ON products(product_code);

-- tạo Composite Index trên bảng Products (sử dụng 2 cột productName và productPrice)

create index index_composite  ON products(product_name, product_price);

-- Sử dụng câu lệnh EXPLAIN để biết được câu lệnh SQL của bạn thực thi như nào
explain select * from products where product_code = 'P003';

-- So sánh câu truy vấn trước và sau khi tạo index
 select * 
from products
where product_code = 'P003';

explain select * from products where product_code = 'P003';
 
 -- Bước 4:
 -- Tạo view lấy về các thông tin: productCode, productName, productPrice, productStatus từ bảng products.
 
create view product_info as
select product_code, product_name , product_price, product_status 
from products;

-- Tiến hành sửa view
alter view product_info as
select product_code, product_name , product_price, product_status 
from products
where product_price > 1200000;

-- Tiến hành xoá view
drop view product_info;

-- Bước 5:
-- Tạo store procedure lấy tất cả thông tin của tất cả các sản phẩm trong bảng product

delimiter //
create procedure get_all_product()
begin
    select * from products;
end //
delimiter ;
call get_all_product();

-- Tạo store procedure thêm một sản phẩm mới

delimiter //
create procedure add_product(
    in product_code varchar(50),
    in product_name varchar(255),
    in product_price double,
    in product_amount int,
    in product_description varchar(500),
    in product_status varchar(50)
)
begin
    insert into products (product_code, product_name, product_price, product_amount, product_description, product_status)
    values (product_code, product_name, product_price, product_amount, product_description, product_status);
end //
delimiter ;

call add_product('P006','bmw',3452232,10,'xe vip lam',"san hang")

-- Stored Procedure sửa thông tin sản phẩm theo id
drop procedure update_product

delimiter //
create procedure update_product(in p_id int,
    in p_new_price double,
    in p_new_description varchar(500)
)
begin
    update products 
    set product_price = p_new_price, product_description = p_new_description
    where product_id = p_id;
end //
delimiter ;

call update_product(5,700000,"xe sua moi");

-- Tạo store procedure xoá sản phẩm theo id

delimiter //
create procedure delete_product(in p_id int)
begin
  delete from products  
    where product_id = p_id;
end //
delimiter ;

call delete_product(4);


