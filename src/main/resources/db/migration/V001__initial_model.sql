CREATE TABLE customer_order (
    id INTEGER PRIMARY KEY GENERATED ALWAYS AS IDENTITY,
    customer VARCHAR(255)
);

CREATE TABLE customer_order_item (
    id INTEGER PRIMARY KEY GENERATED ALWAYS AS IDENTITY,
    order_id INTEGER NOT NULL REFERENCES customer_order(id),
    item VARCHAR(1024),
    amount_minor INTEGER,
    currency VARCHAR(3)
);
