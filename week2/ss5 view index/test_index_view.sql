CREATE DATABASE IF NOT EXISTS DemoDB;
USE DemoDB;

CREATE TABLE Products (
    prd_id INT PRIMARY KEY,
    prd_code VARCHAR(50) UNIQUE,
    prd_name VARCHAR(255),
    prd_price DECIMAL(10, 2),
    prd_amount INT,
    prd_description VARCHAR(500),
    prd_status VARCHAR(50)
);


-- Chèn dữ liệu mẫu
INSERT INTO Products VALUES
(1, 'P001', 'Cactus', 9.99, 50, 'Small green cactus', 'Active'),
(2, 'P002', 'Desert Rose', 14.99, 30, 'Pink flowering succulent', 'Active'),
(3, 'P003', 'Saguaro', 29.99, 10, 'Tall cactus native to the Sonoran Desert', 'Inactive'),
(4, 'P004', 'Aloe Vera', 12.99, 40, 'Medicinal succulent with soothing gel', 'Active'),
(5, 'P005', 'Agave', 19.99, 20, 'Used in the production of tequila', 'Active');

-- Unique Index trên cột productCode
CREATE UNIQUE INDEX IX_ProductCode ON Products(prd_code);

-- Composite Index trên cột productName và productPrice
CREATE INDEX IX_ProductNamePrice ON Products(prd_name, prd_price);

-- Sử dụng EXPLAIN để xem kế hoạch thực hiện câu lệnh SELECT
EXPLAIN SELECT * FROM Products WHERE prd_code = 'P001';

-- Tạo VIEW
CREATE VIEW ProductInfo AS
SELECT prd_code, prd_name, prd_price, prd_status FROM Products;

-- Sửa đổi VIEW
CREATE OR REPLACE VIEW ProductInfo AS
SELECT prd_code, prd_name, prd_price FROM Products WHERE prd_status = 'Active';

-- Xoá VIEW
DROP VIEW IF EXISTS ProductInfo;

-- Stored Procedure lấy tất cả thông tin sản phẩm
DELIMITER //
CREATE PROCEDURE GetAllProducts()
BEGIN
    SELECT * FROM Products;
END //
DELIMITER ;

-- Stored Procedure thêm sản phẩm mới
DELIMITER //
CREATE PROCEDURE AddProduct(
    IN p_Code VARCHAR(50),
    IN p_Name VARCHAR(255),
    IN p_Price DECIMAL(10, 2),
    IN p_Amount INT,
    IN p_Description VARCHAR(500),
    IN p_Status VARCHAR(50)
)
BEGIN
    INSERT INTO Products (prd_code, prd_name, prd_price, prd_amount, prd_description, prd_status)
    VALUES (p_Code, p_Name, p_Price, p_Amount, p_Description, p_Status);
END //
DELIMITER ;

-- Stored Procedure sửa thông tin sản phẩm theo id
DELIMITER //
CREATE PROCEDURE UpdateProduct(
    IN p_Id INT,
    IN p_NewPrice DECIMAL(10, 2),
    IN p_NewDescription VARCHAR(500)
)
BEGIN
    UPDATE Products SET prd_price = p_NewPrice, prd_description = p_NewDescription WHERE prd_id = p_Id;
END //
DELIMITER ;

-- Stored Procedure xoá sản phẩm theo id
DELIMITER //
CREATE PROCEDURE DeleteProduct(
    IN p_Id INT
)
BEGIN
    DELETE FROM Products WHERE prd_id = p_Id;
END //
DELIMITER ;