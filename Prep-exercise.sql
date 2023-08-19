-- entities to solve the problem
--  1. recipes: that contains the: recipe_id, recipe_name, number_of_gradients 
--  2. categories: that contains: category_id, category_name, description 
--  3. ingredients: that contains: ingredient_id, ingredient_name
--  4. steps: that contains: step_id, recipe_id, description 



--  crete the recipes table 
CREATE TABLE recipes ( 
    recipe_id INT PRIMARY KEY,
    recipe_name VARCHAR(50) NOT NULL,
    number_of_gradients INT
);

--  Create the categories table
CREATE TABLE categories (
    category_id INT PRIMARY KEY,
    category_name VARCHAR(50) NOT NULL,
    description TEXT NOT NULL
);

--  Create the ingredients table
CREATE TABLE ingredients (
    ingredient_id INT PRIMARY KEY,
    ingredient_name VARCHAR(50) NOT NULL
);

--  Create the steps table
CREATE TABLE steps (
    step_id INT PRIMARY KEY,
    recipe_id INT REFERENCES Recipe(recipe_id),
    description TEXT NOT NULL
);

--  The relation between entities 
-- 1. One Ingredient can be used in many recipes and one recipe can use many ingredients so it is many to many relation
-- 2. one recipe cna belong to more than one category and one category can contain many recipes so it is a many to many relation


-- 1. Create ingredient-recipes table

CREATE TABLE ingredient_recipes (
    ingredient_recipe_id INT PRIMARY KEY,
    ingredient_id INT REFERENCES ingredients (ingredient_id),
    recipe_id INT REFERENCES recipes (recipe_id)
);

-- 2. Create categories-recipes table

CREATE TABLE categories_recipes (
    category_recipe_id INT PRIMARY KEY,
    category_id INT REFERENCES categories (category_id),
    recipe_id INT REFERENCES recipes (recipe_id)
);