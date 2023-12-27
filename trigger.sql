-- При кожному видаленні чи оновленні даних у таблиці 'meal' тригер записує інформацію щодо змін у таблицю 'items_audit'

CREATE TABLE items_audit (
    audit_id SERIAL PRIMARY KEY,
    item_id INT,
    operation VARCHAR(10) NOT NULL,
    changed_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP
);


CREATE OR REPLACE FUNCTION log_items_change()
RETURNS TRIGGER LANGUAGE plpgsql
AS $$
BEGIN
    INSERT INTO items_audit (item_id, operation)
    VALUES (OLD.item_id, TG_OP);
    RETURN NEW;
END;
$$;


CREATE TRIGGER items__update_or_delete
AFTER UPDATE OR DELETE ON items
FOR EACH ROW
EXECUTE FUNCTION log_items_change();

-- CALL delete_meal(2);
-- UPDATE meal SET item_name = 'Bacon Cheddar' WHERE item_name = 'Bacon Cheddar McChicken';

