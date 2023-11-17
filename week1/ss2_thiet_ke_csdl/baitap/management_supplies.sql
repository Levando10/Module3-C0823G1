create database management_supplies; 
drop database management_supplies;

use management_supplies; 
create table bill_export(
id_bill_export int primary key auto_increment,
day_export date
);

alter table bill_export change column day_export day_export date not null;

create table supplies(
id_supplies varchar(20) primary key not null,
name_supplies varchar(30) not null
); 

-- chi tiet phieu xuat n-n
create table detail_export(
price_export double check(price_export > 0),
quantity_export int check(quantity_export >= 1),
id_supplies varchar(20)  not null,
id_bill_export int not null,
primary key(id_supplies ,id_bill_export),
foreign key(id_supplies) references supplies(id_supplies),
foreign key(id_bill_export) references bill_export(id_bill_export)
);


create table bill_import(
id_bill_import int auto_increment primary key,
day_import date not null
);

-- chi tiet don gia nhap n-n
create table detail_import(
price_import double check(price_import > 0),
quantity_import int check(quantity_import >= 1),
id_supplies varchar(20)  not null,
id_bill_import int not null,
primary key(id_supplies,id_bill_import ),
foreign key(id_supplies) references supplies(id_supplies),
foreign key(id_bill_import) references bill_import(id_bill_import)
);


create table order_supplies(
id_order_supplies int auto_increment primary key,
day_order date not null,
id_supplier VARCHAR(20),
    FOREIGN KEY (id_supplier) REFERENCES material_supplier(id_supplier)
);
-- chi tiet don hang
create table detail_order_supplies(
id_order_supplies int not null,
id_supplies varchar(20)  not null,
primary key(id_supplies ,id_order_supplies),
foreign key(id_supplies) references supplies(id_supplies),
foreign key(id_order_supplies) references order_supplies(id_order_supplies)

);

create table material_supplier(
id_supplier varchar(20) primary key not null,
name_supplier varchar(40),
address_supplier varchar(40),
phone_supplier varchar(10)
);
alter table material_supplier
drop column phone_supplier;
alter table  material_supplier
modify column name_supplier varchar(40) not null;
alter table material_supplier
modify column  address_supplier varchar(40) not null;

-- 1 - n phone
create table supplier_phone (
    id_phone int primary key,
    id_supplier VARCHAR(20) not null,
    phone_supplier VARCHAR(10),
    FOREIGN KEY (id_supplier) REFERENCES material_supplier(id_supplier)
);





