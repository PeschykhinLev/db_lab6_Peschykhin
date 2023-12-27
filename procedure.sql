-- Враховуючи id страви, функція видаляє всю інформацію про неї

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