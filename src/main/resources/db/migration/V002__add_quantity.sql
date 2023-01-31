-- Oops... we forgot about the quantity!
ALTER TABLE customer_order_item ADD COLUMN quantity INTEGER NOT NULL DEFAULT 1;
