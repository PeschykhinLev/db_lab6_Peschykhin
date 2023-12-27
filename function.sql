-- Враховуючи обрану категорію, функція повернає назву страви з найменшою кількістью калорій

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