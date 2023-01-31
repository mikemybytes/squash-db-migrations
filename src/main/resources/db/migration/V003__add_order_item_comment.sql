-- Some people have allergies or some specific requests that have to be stored somewhere
ALTER TABLE customer_order_item ADD COLUMN comment VARCHAR(1024);
