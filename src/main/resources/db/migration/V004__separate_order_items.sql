-- I'd not recommend this approach in a production system, but since it's just a demo
-- we don't have to care about the previously existing data that much (no data migration)
TRUNCATE TABLE customer_order_item CASCADE;
TRUNCATE TABLE customer_order CASCADE;

-- back to the point - we want to keep available items in a separate table
CREATE TABLE order_item(
    id INTEGER PRIMARY KEY GENERATED ALWAYS AS IDENTITY,
    name VARCHAR(128) NOT NULL,
    description VARCHAR(2048),
    CONSTRAINT qu_name UNIQUE (name)
);

ALTER TABLE customer_order_item DROP COLUMN item;
ALTER TABLE customer_order_item ADD COLUMN order_item_id INTEGER NOT NULL REFERENCES order_item(id);
