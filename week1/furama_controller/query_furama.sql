use management_furama;
select * from  nhan_vien
where ho_ten like 'H%' or ho_ten like 'T%' or ho_ten like 'K%'
and length(ho_ten)<=15;

-- 3 thông tin khách hàng từ 18 đến 50 tuổi

select *,timestampdiff(year,khach_hang.ngay_sinh,curdate()) as age
from khach_hang
where (
    timestampdiff(year, khach_hang.ngay_sinh, curdate()) >= 18 
    and timestampdiff(year, khach_hang.ngay_sinh, curdate()) <= 50
)
and (
    khach_hang.dia_chi like "%Đà Nẵng%" 
    or khach_hang.dia_chi like "%Quảng Trị%"
);

-- 4   mỗi khách hàng đã từng đặt phòng bao nhiêu lần
select *
from hop_dong;

select hop_dong.ma_khach_hang, khach_hang.ho_ten,count(hop_dong.ma_khach_hang) as so_lan_dat_phong
from hop_dong
join khach_hang on khach_hang.ma_khach_hang = hop_dong.ma_khach_hang
where khach_hang.ma_loai_khach = 1
group by hop_dong.ma_khach_hang
order by so_lan_dat_phong asc;

-- 5.Hiển thị ma_khach_hang, ho_ten, ten_loai_khach, ma_hop_dong, ten_dich_vu, ngay_lam_hop_dong, 
 -- ngay_ket_thuc, tong_tien (Với tổng tiền được tính theo công thức như sau: Chi Phí Thuê + Số Lượng * Giá, 
 -- với Số Lượng và Giá là từ bảng dich_vu_di_kem,
--  hop_dong_chi_tiet) cho tất cả các khách hàng đã từng đặt phòng. (những khách hàng nào chưa từng đặt phòng cũng phải hiển thị ra). 

select khach_hang.ma_khach_hang, khach_hang.ho_ten ,loai_khach.ten_loai_khach,
hop_dong.ma_hop_dong , dich_vu.ten_dich_vu , hop_dong.ngay_lam_hop_dong, hop_dong.ngay_ket_thuc,
(ifnull(dich_vu.chi_phi_thue, 0) + sum(ifnull(hop_dong_chi_tiet.so_luong, 0) * ifnull(dich_vu_di_kem.gia, 0))) AS tong_tien
from khach_hang
left join hop_dong on khach_hang.ma_khach_hang = hop_dong.ma_khach_hang 
join loai_khach on loai_khach.ma_loai_khach = khach_hang.ma_loai_khach
left join dich_vu on dich_vu.ma_dich_vu = hop_dong.ma_dich_vu
left join
    hop_dong_chi_tiet ON hop_dong_chi_tiet.ma_hop_dong = hop_dong.ma_hop_dong
left join
    dich_vu_di_kem ON dich_vu_di_kem.ma_dich_vu_di_kem = hop_dong_chi_tiet.ma_dich_vu_di_kem
 group by
   khach_hang.ma_khach_hang,
    khach_hang.ho_ten,
    loai_khach.ten_loai_khach,
    hop_dong.ma_hop_dong,
    dich_vu.ten_dich_vu,
    hop_dong.ngay_lam_hop_dong,
    hop_dong.ngay_ket_thuc;
    
    -- 6









   

