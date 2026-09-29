Markdown
# E-Commerce Relational Database Design & Architecture

## Overview
This project presents a fully normalized relational database schema designed for a modern B2C E-Commerce platform. The system manages core retail operations including user profiles, multi-address management, product categorization, order processing, line-item tracking, payments, and product reviews.

---

## Entity-Relationship Diagram (ERD)
![ERD Diagram](./erd_diagram.png)

---

## Database Architecture & Schema Details

The schema consists of 8 interconnected tables designed to ensure data integrity and query efficiency:

1. `users` — Stores customer profile data.
2. `addresses` — Handles multiple shipping addresses per user (**1:N** relationship).
3. `categories` — Classifies products into distinct hierarchical groups.
4. `products` — Stores inventory details, pricing, and stock levels (**1:N** with categories).
5. `orders` — Tracks order metadata, current status, and total values (**1:N** with users).
6. `order_items` — Junction table resolving the **M:N** relationship between orders and products.
7. `payments` — Enforces transaction tracking with a strict **1:1** relationship to orders.
8. `reviews` — Contains product reviews and ratings (**M:N** junction between users and products with a unique constraint preventing duplicate reviews).

---

## Normalization Process (1NF to 3NF)

To eliminate redundancy and prevent insertion, update, and deletion anomalies, the architecture adheres strictly to **Third Normal Form (3NF)**:

### First Normal Form (1NF)
* **Atomic Values:** Every column contains indivisible values (e.g., `first_name` and `last_name` are split, addresses are separated into `street_address`, `city`, `county`, and `postal_code`).
* **Primary Keys:** Every table defines a unique primary key (`SERIAL / AUTO_INCREMENT`).
* **No Repeating Groups:** Order details are separated into individual line items (`order_items`) rather than comma-separated lists in the `orders` table.

### Second Normal Form (2NF)
* Meets all **1NF** requirements.
* **Full Functional Dependency:** In junction tables like `order_items`, attributes such as `unit_price` and `quantity` depend entirely on the surrogate composite identifier/key, avoiding partial dependencies on just `order_id` or `product_id`.

### Third Normal Form (3NF)
* Meets all **2NF** requirements.
* **No Transitive Dependencies:** Non-key attributes depend *only* on the primary key.
  * *Example:* Customer addresses were extracted into `addresses` rather than embedding city/county inside `orders`.
  * *Example:* Category descriptions reside in `categories`, preventing product records from duplicating category metadata.

---

## Key Constraints & Data Integrity

* **Primary & Foreign Keys:** Explicit referential integrity enforced across all relationships with cascading deletes where appropriate (e.g., deleting an order removes its `order_items`).
* **Check Constraints:** 
  * `price >= 0` and `stock_quantity >= 0` on `products`.
  * `quantity > 0` on `order_items`.
  * Restricted enum-like values for status fields (`orders.status`, `payments.payment_status`, `payments.payment_method`).
  * `rating BETWEEN 1 AND 5` on `reviews`.
* **Uniqueness Constraints:** `users.email`, `products.sku`, `categories.category_name`, and composite unique constraints (`user_id`, `product_id`) on `reviews`.

---

## Setup & Execution

1. Clone the repository:
   ```bash
   git clone [https://github.com/chivasebastian/ecommerce-relational-db-design.git](https://github.com/chivasebastian/ecommerce-relational-db-design.git)
   cd ecommerce-relational-db-design
   ```
2. Run the schema script:
   ```bash
   psql -U chivasebastian -d schema.sql -f schema.sql
   ```
3. Populate mock data:
   ```bash
   psql -U chivasebastian -d data_insertion.sql -f data_insertion.sql
   ```