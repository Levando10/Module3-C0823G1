use management_furama; 

-- 11  Hiển thị thông tin các dịch vụ đi kèm đã được sử dụng bởi những khách hàng 
-- có ten_loai_khach là “Diamond” và có dia_chi ở “Vinh” hoặc “Quảng Ngãi”.
select  dvdc.ma_dich_vu_di_kem , dvdc.ten_dich_vu_di_kem 
from dich_vu_di_kem dvdc
join hop_dong_chi_tiet hdct on  hdct.ma_dich_vu_di_kem = dvdc.ma_dich_vu_di_kem
join hop_dong hd on hd.ma_hop_dong = hdct.ma_hop_dong
join khach_hang kh on kh.ma_khach_hang = hd.ma_khach_hang
join loai_khach lk on lk.ma_loai_khach = kh.ma_loai_khach
where lk.ma_loai_khach = 1 and (kh.dia_chi like"% Vinh" or kh.dia_chi = "% Quảng Ngãi")
;

-- 12 12.Hiển thị thông tin ma_hop_dong, ho_ten (nhân viên), ho_ten (khách hàng), so_dien_thoai (khách hàng), ten_dich_vu, so_luong_dich_vu_di_kem 
-- (được tính dựa trên việc sum so_luong ở dich_vu_di_kem), tien_dat_coc của tất cả các dịch vụ đã từng được khách hàng đặt vào 
-- 3 tháng cuối năm 2020 nhưng chưa từng được khách hàng đặt vào 6 tháng đầu năm 2021.

SELECT 
    hd.ma_hop_dong, nv.ho_ten as nhan_vien_ten, kh.ho_ten as khach_hang_ten, kh.so_dien_thoai, dv.ten_dich_vu,
    count(hdct.ma_hop_dong_chi_tiet)  AS so_luong_dich_vu_di_kem,
    hd.ma_dich_vu,hd.tien_dat_coc,
    QUARTER(hd.ngay_lam_hop_dong) AS quy
FROM
    hop_dong hd
        JOIN
    khach_hang kh ON kh.ma_khach_hang = hd.ma_khach_hang
        JOIN
    nhan_vien nv ON nv.ma_nhan_vien = hd.ma_nhan_vien
        LEFT JOIN
    hop_dong_chi_tiet hdct ON hdct.ma_hop_dong = hd.ma_hop_dong
        LEFT JOIN
    dich_vu dv ON dv.ma_dich_vu = hd.ma_dich_vu
        LEFT JOIN
    dich_vu_di_kem dvdk ON dvdk.ma_dich_vu_di_kem = hdct.ma_dich_vu_di_kem
WHERE
    QUARTER(hd.ngay_lam_hop_dong) = 4
        AND YEAR(hd.ngay_lam_hop_dong) = 2020
        AND hd.ma_dich_vu NOT IN (SELECT 
            ma_dich_vu
        FROM
            hop_dong hd
        WHERE
            YEAR(ngay_lam_hop_dong) = 2021
                AND QUARTER(ngay_lam_hop_dong) = 1
                OR QUARTER(ngay_lam_hop_dong) = 2)
GROUP BY hd.ma_hop_dong;


--  13.Hiển thị thông tin các Dịch vụ đi kèm được sử dụng nhiều nhất bởi các Khách hàng đã đặt phòng. 
-- (Lưu ý là có thể có nhiều dịch vụ có số lần sử dụng nhiều như nhau).
-- select dich_vu_di_kem.ma_dich_vu_di_kem , dich_vu_di_kem.ten_dich_vu_di_kem , 

select dvdk.ma_dich_vu_di_kem , dvdk.ten_dich_vu_di_kem , sum(hdct.so_luong)  as " so luong"
from dich_vu_di_kem dvdk
left join hop_dong_chi_tiet hdct on hdct.ma_dich_vu_di_kem = dvdk.ma_dich_vu_di_kem
group by dvdk.ma_dich_vu_di_kem
having sum(hdct.so_luong) = (select sum(so_luong) 
from hop_dong_chi_tiet hdct
group by hdct.ma_dich_vu_di_kem
order by  sum(so_luong) desc
limit 1);

-- 14.Hiển thị thông tin tất cả các Dịch vụ đi kèm chỉ mới được sử dụng một lần duy nhất. Thông tin hiển thị 
-- bao gồm ma_hop_dong, ten_loai_dich_vu, ten_dich_vu_di_kem, 
-- so_lan_su_dung (được tính dựa trên việc count các ma_dich_vu_di_kem).
select hd.ma_hop_dong , ldv.ten_loai_dich_vu , ten_dich_vu_di_kem , 1 as "Số lượng"
from hop_dong hd 
left join dich_vu dv on dv.ma_dich_vu = hd.ma_dich_vu 
left join loai_dich_vu ldv on ldv.ma_loai_dich_vu = dv.ma_loai_dich_vu
join hop_dong_chi_tiet hdct on hdct.ma_hop_dong = hd.ma_hop_dong
join dich_vu_di_kem dvdk on dvdk.ma_dich_vu_di_kem = hdct.ma_dich_vu_di_kem
where dvdk.ma_dich_vu_di_kem in (select dvdk.ma_dich_vu_di_kem
from hop_dong_chi_tiet hdct
left join dich_vu_di_kem dvdk on dvdk.ma_dich_vu_di_kem = hdct.ma_dich_vu_di_kem
group by hdct.ma_dich_vu_di_kem
having count(hdct.ma_dich_vu_di_kem) = 1)
order by hd.ma_hop_dong 
;

-- 15.Hiển thi thông tin của tất cả nhân viên bao gồm ma_nhan_vien, ho_ten, ten_trinh_do, 
-- ten_bo_phan, so_dien_thoai, dia_chi mới chỉ lập được tối đa 3 hợp đồng từ năm 2020 đến 2021.

select nv.ma_nhan_vien , nv.ho_ten , td.ten_trinh_do ,bp.ten_bo_phan , nv.so_dien_thoai , nv.dia_chi
from nhan_vien nv
 join trinh_do td on td.ma_trinh_do = nv.ma_trinh_do
 join bo_phan bp on bp.ma_bo_phan = nv.ma_bo_phan
 where nv.ma_nhan_vien in ( select hd.ma_nhan_vien
 from hop_dong hd
 where year(hd.ngay_lam_hop_dong) BETWEEN "2020-01-01" and "2021-01-01"
 group by ma_nhan_vien
 having count(ma_nhan_vien) <= 3)
 order by nv.ma_nhan_vien;
 
 -- 16.Xóa những Nhân viên chưa từng lập được hợp đồng nào từ năm 2019 đến năm 2021.
 -- delete from nhan_vien where ;
set sql_safe_updates = 0 ;
set sql_safe_updates = 1;
 delete from nhan_vien where nhan_vien.ma_nhan_vien not in (select hd.ma_nhan_vien
    from hop_dong hd 
    where year(hd.ngay_lam_hop_dong) between 2019 and 2021
    group by hd.ma_nhan_vien)
  
  select *
  from nhan_vien
 

 

 

 





