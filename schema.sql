-- ===================================================
-- DATABASE SCHEMA: E-Commerce System
-- Engine: PostgreSQL / Universal SQL
-- ===================================================

-- 1. Table: Users
CREATE TABLE users (
    user_id SERIAL PRIMARY KEY,
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50) NOT NULL,
    email VARCHAR(100) NOT NULL UNIQUE,
    phone VARCHAR(20),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- 2. Table: Addresses (1:N relationship with Users)
CREATE TABLE addresses (
    address_id SERIAL PRIMARY KEY,
    user_id INT NOT NULL,
    street_address VARCHAR(150) NOT NULL,
    city VARCHAR(50) NOT NULL,
    county VARCHAR(50) NOT NULL,
    postal_code VARCHAR(10) NOT NULL,
    is_default BOOLEAN DEFAULT FALSE,
    CONSTRAINT fk_addresses_users FOREIGN KEY (user_id) REFERENCES users(user_id) ON DELETE CASCADE
);

-- 3. Table: Categories
CREATE TABLE categories (
    category_id SERIAL PRIMARY KEY,
    category_name VARCHAR(50) NOT NULL UNIQUE,
    description TEXT
);

-- 4. Table: Products
CREATE TABLE products (
    product_id SERIAL PRIMARY KEY,
    category_id INT NOT NULL,
    product_name VARCHAR(100) NOT NULL,
    sku VARCHAR(30) NOT NULL UNIQUE,
    price NUMERIC(10, 2) NOT NULL CHECK (price >= 0),
    stock_quantity INT NOT NULL CHECK (stock_quantity >= 0),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT fk_products_categories FOREIGN KEY (category_id) REFERENCES categories(category_id)
);

-- 5. Table: Orders
CREATE TABLE orders (
    order_id SERIAL PRIMARY KEY,
    user_id INT NOT NULL,
    shipping_address_id INT NOT NULL,
    order_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    status VARCHAR(20) NOT NULL CHECK (status IN ('Pending', 'Processing', 'Shipped', 'Delivered', 'Cancelled')),
    total_amount NUMERIC(10, 2) DEFAULT 0.00 CHECK (total_amount >= 0),
    CONSTRAINT fk_orders_users FOREIGN KEY (user_id) REFERENCES users(user_id),
    CONSTRAINT fk_orders_addresses FOREIGN KEY (shipping_address_id) REFERENCES addresses(address_id)
);

-- 6. Table: Order Items (Resolves M:N relationship between Orders and Products)
CREATE TABLE order_items (
    order_item_id SERIAL PRIMARY KEY,
    order_id INT NOT NULL,
    product_id INT NOT NULL,
    quantity INT NOT NULL CHECK (quantity > 0),
    unit_price NUMERIC(10, 2) NOT NULL CHECK (unit_price >= 0),
    CONSTRAINT fk_items_orders FOREIGN KEY (order_id) REFERENCES orders(order_id) ON DELETE CASCADE,
    CONSTRAINT fk_items_products FOREIGN KEY (product_id) REFERENCES products(product_id),
    CONSTRAINT uq_order_product UNIQUE (order_id, product_id)
);

-- 7. Table: Payments
CREATE TABLE payments (
    payment_id SERIAL PRIMARY KEY,
    order_id INT NOT NULL UNIQUE, -- 1:1 relationship with Orders
    payment_method VARCHAR(30) NOT NULL CHECK (payment_method IN ('Credit Card', 'PayPal', 'Bank Transfer', 'Cash on Delivery')),
    payment_status VARCHAR(20) NOT NULL CHECK (payment_status IN ('Pending', 'Completed', 'Failed', 'Refunded')),
    transaction_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    amount NUMERIC(10, 2) NOT NULL CHECK (amount >= 0),
    CONSTRAINT fk_payments_orders FOREIGN KEY (order_id) REFERENCES orders(order_id) ON DELETE CASCADE
);

-- 8. Table: Reviews
CREATE TABLE reviews (
    review_id SERIAL PRIMARY KEY,
    product_id INT NOT NULL,
    user_id INT NOT NULL,
    rating INT NOT NULL CHECK (rating BETWEEN 1 AND 5),
    comment TEXT,
    review_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT fk_reviews_products FOREIGN KEY (product_id) REFERENCES products(product_id) ON DELETE CASCADE,
    CONSTRAINT fk_reviews_users FOREIGN KEY (user_id) REFERENCES users(user_id) ON DELETE CASCADE,
    CONSTRAINT uq_user_product_review UNIQUE (user_id, product_id) -- A user can only review a product once
);