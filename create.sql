CREATE TABLE Meal
(
  item_id SERIAL PRIMARY KEY,
  item_name VARCHAR(100) NOT NULL
);

CREATE TABLE Category
(
  category_id SERIAL PRIMARY KEY,
  category_name VARCHAR(100) NOT NULL
);

CREATE TABLE Meal_Category
(
  item_id INT NOT NULL,
  category_id INT NOT NULL,
  FOREIGN KEY (item_id) REFERENCES Meal(item_id),
  FOREIGN KEY (category_id) REFERENCES Category(category_id)
);

CREATE TABLE Nutritional_Information
(
  Calories FLOAT NOT NULL,
  Calories_from_Fat FLOAT NOT NULL,
  Total_Fat FLOAT NOT NULL,
  Saturated_Fat FLOAT NOT NULL,
  Cholesterol FLOAT NOT NULL,
  Sodium FLOAT NOT NULL,
  Carbohydrates FLOAT NOT NULL,
  Dietary_Fiber FLOAT NOT NULL,
  Sugars FLOAT NOT NULL,
  Protein FLOAT NOT NULL,
  item_id FLOAT NOT NULL,
  PRIMARY KEY (item_id),
  FOREIGN KEY (item_id) REFERENCES Meal(item_id)
);

CREATE TABLE Daily_Values_on_the_Nutrition
(
  Total_Fat_Daily_Percentage INT NOT NULL,
  Saturated_Fat_Daily_Percentage INT NOT NULL,
  Cholesterol_Daily_Percentage INT NOT NULL,
  Sodium_Daily_Percentage INT NOT NULL,
  Carbohydrates_Daily_Percentage INT NOT NULL,
  Dietary_Fiber_Daily_Percentage INT NOT NULL,
  Vitamin_A_Daily_Percentage INT NOT NULL,
  Vitamin_C_Daily_Percentage INT NOT NULL,
  Calcium_Daily_Percentage INT NOT NULL,
  Iron_Daily_Percentage INT NOT NULL,
  item_id INT NOT NULL,
  PRIMARY KEY (item_id),
  FOREIGN KEY (item_id) REFERENCES Meal(item_id)
);

CREATE TABLE Serving_Size_Table
(
  Ounces FLOAT,
  Grams FLOAT,
  item_id INT,
  beverage_fl_oz_cup FLOAT,
  beverage_ml FLOAT,
  PRIMARY KEY (item_id),
  FOREIGN KEY (item_id) REFERENCES Meal(item_id)