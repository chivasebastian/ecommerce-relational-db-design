-- ===================================================
-- DATA INSERTION SCRIPT (MOCK DATA)
-- ===================================================

-- 1. Insert Categories
INSERT INTO categories (category_name, description) VALUES
('Electronics', 'Gadgets, laptops, phones, and electronic accessories'),
('Components', 'PC parts, RAM, Storage, Motherboards'),
('Peripherals', 'Keyboards, mice, monitors, and audio equipment'),
('Home Appliances', 'Smart home devices and kitchen accessories');

-- 2. Insert Users
INSERT INTO users (first_name, last_name, email, phone) VALUES
('Alexandru', 'Popa', 'alex.popa@email.com', '0721111222'),
('Elena', 'Ionescu', 'elena.ionescu@email.com', '0732222333'),
('Mihai', 'Radu', 'mihai.radu@email.com', '0743333444'),
('Andreea', 'Dumitrescu', 'andreea.d@email.com', '0754444555'),
('Cristian', 'Stoica', 'cristi.stoica@email.com', '0765555666');

-- 3. Insert Addresses
INSERT INTO addresses (user_id, street_address, city, county, postal_code, is_default) VALUES
(1, 'Str. Victoriei Nr. 12', 'Bucharest', 'Ilfov', '010071', TRUE),
(1, 'Bvd. Unirii Nr. 45', 'Bucharest', 'Ilfov', '030167', FALSE),
(2, 'Str. Republicii Nr. 5', 'Cluj-Napoca', 'Cluj', '400015', TRUE),
(3, 'Str. Ştefan cel Mare Nr. 88', 'Iași', 'Iași', '700063', TRUE),
(4, 'Str. Revoluției Nr. 10', 'Timișoara', 'Timiș', '300080', TRUE),
(5, 'Str. Transilvaniei Nr. 3', 'Brașov', 'Brașov', '500007', TRUE);

-- 4. Insert Products
INSERT INTO products (category_id, product_name, sku, price, stock_quantity) VALUES
(1, 'Smartphone Pixel 8', 'PHONE-PX8-128', 3499.99, 15),
(1, 'Laptop IdeaPad 3', 'LPT-IP3-512', 2299.00, 10),
(2, 'DDR4 RAM 16GB Kit', 'RAM-D4-16G', 189.50, 50),
(2, 'NVMe SSD 1TB', 'SSD-NV1-1000', 320.00, 30),
(3, 'Mechanical Gaming Keyboard', 'KB-MECH-RGB', 250.00, 25),
(3, 'Wireless Ergonomic Mouse', 'MS-WRL-ERG', 120.00, 40),
(3, '27-inch IPS Monitor 144Hz', 'MON-27-144', 899.99, 8);

-- 5. Insert Orders
INSERT INTO orders (user_id, shipping_address_id, status, total_amount) VALUES
(1, 1, 'Delivered', 3819.99),
(2, 3, 'Shipped', 2299.00),
(3, 4, 'Processing', 439.50),
(1, 2, 'Pending', 120.00),
(5, 6, 'Delivered', 899.99);

-- 6. Insert Order Items
INSERT INTO order_items (order_id, product_id, quantity, unit_price) VALUES
(1, 1, 1, 3499.99), -- Pixel 8
(1, 4, 1, 320.00),   -- SSD
(2, 2, 1, 2299.00),  -- Laptop
(3, 3, 1, 189.50),   -- RAM
(3, 5, 1, 250.00),   -- Keyboard
(4, 6, 1, 120.00),   -- Mouse
(5, 7, 1, 899.99);   -- Monitor

-- 7. Insert Payments
INSERT INTO payments (order_id, payment_method, payment_status, amount) VALUES
(1, 'Credit Card', 'Completed', 3819.99),
(2, 'PayPal', 'Completed', 2299.00),
(3, 'Credit Card', 'Completed', 439.50),
(4, 'Cash on Delivery', 'Pending', 120.00),
(5, 'Bank Transfer', 'Completed', 899.99);

-- 8. Insert Reviews
INSERT INTO reviews (product_id, user_id, rating, comment) VALUES
(1, 1, 5, 'Excelent telefon, bateria ține peste o zi!'),
(2, 2, 4, 'Raport calitate-preț foarte bun pentru lucru.'),
(4, 1, 5, 'Viteze excelente de citire/scriere.'),
(7, 5, 5, 'Culori superbe și rată de refresh excelentă.');