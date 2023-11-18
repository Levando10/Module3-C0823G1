use management_furama;
select * from  nhan_vien
WHERE ho_ten LIKE 'H%' OR ho_ten LIKE 'T%' OR ho_ten LIKE 'K%'
and length(ho_ten)<=15;

SELECT *
FROM nhan_vien
WHERE LOWER(SUBSTRING(ho_ten, -1)) IN ('h', 'k', 't');

SELECT *
FROM nhan_vien
WHERE ho_ten LIKE 'H%' OR ho_ten LIKE 'T%' OR ho_ten LIKE 'K%'
   AND LENGTH(ho_ten) <= 15;
   
   

