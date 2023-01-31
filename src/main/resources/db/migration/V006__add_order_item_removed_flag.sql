-- Let's think about compatibility with existing data this time. Once some items could no longer
-- be available, we should remove them softly to keep the existing orders history.

ALTER TABLE order_item ADD COLUMN removed BOOLEAN NOT NULL DEFAULT false;

UPDATE order_item SET removed = true WHERE name in('Item 3', 'Item 4', 'Item 6');
