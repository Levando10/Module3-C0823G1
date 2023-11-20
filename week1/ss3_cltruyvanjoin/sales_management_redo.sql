
select * from customer;
select * from `order`;
select * from order_detail;
select * from product;

-- exercise!!!
-- 1 Hiển thị các thông tin  gồm oID, oDate, oPrice của  
-- tất cả các hóa đơn trong bảng Order

select `order`.id,`order`.day,`order`.total_price
from `order`;

use management_supermarket_redo;
-- 2Hiển thị danh sách các khách hàng đã mua hàng, 
-- và danh sách sản phẩm được mua bởi các khách
select customer.id as "id khach hang" , customer.name ,customer.age, GROUP_CONCAT(product.name) as "danh_sach_san_pham"
from customer
join `order` on `order`.customer_id = customer.id
join order_detail on order_detail.order_id = `order`.id
join product on product.id = order_detail.product_id
group by customer.id;


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








