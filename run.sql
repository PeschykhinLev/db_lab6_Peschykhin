-- ФУНКЦІЯ --
CREATE OR REPLACE FUNCTION lowest_calory_meal(my_input VARCHAR)
RETURNS TABLE(item_name VARCHAR, calories FLOAT)
LANGUAGE plpgsql
AS $$
BEGIN
	RETURN QUERY
	SELECT meal.item_name, nutritional_information.calories
	FROM meal
	JOIN meal_category ON meal.item_id = meal_category.item_id
	JOIN category ON meal_category.category_id = category.category_id
	JOIN nutritional_information ON nutritional_information.item_id = meal.item_id
	WHERE category.category_name = my_input
	ORDER BY nutritional_information.calories ASC
	LIMIT 1;
END;
$$;

-- SELECT * FROM lowest_calory_meal('Breakfast');



-- ПРОЦЕДУРА --
CREATE OR REPLACE PROCEDURE delete_meal(meal_id INT)
LANGUAGE plpgsql
AS $$
BEGIN
    DELETE FROM meal_category WHERE item_id = meal_id;
    DELETE FROM nutritional_information WHERE item_id = meal_id;
    DELETE FROM daily_values_on_the_nutrition WHERE item_id = meal_id;
    DELETE FROM serving_size_table WHERE item_id = meal_id;
    DELETE FROM meal WHERE item_id = meal_id;
END;
$$;

-- CALL delete_meal(1);



-- ТРИГЕР --
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
-- SELECT * FROM items_audit
