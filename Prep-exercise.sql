-- entities to solve the problem
--  1. recipes: that contains the: recipe_id, recipe_name, number_of_gradients 
--  2. categories: that contains: category_id, category_name, description 
--  3. ingredients: that contains: ingredient_id, ingredient_name
--  4. steps: that contains: step_id, recipe_id, description 



--  crete the recipes table 
CREATE TABLE recipe ( 
    recipe_id INT AUTO_INCREMENT PRIMARY KEY,
    recipe_name VARCHAR(50) NOT NULL,
    number_of_gradients INT
);

--  Create the categories table
CREATE TABLE category (
    category_id INT AUTO_INCREMENT PRIMARY KEY,
    category_name VARCHAR(50) NOT NULL
);

--  Create the ingredients table
CREATE TABLE ingredient (
    ingredient_id INT AUTO_INCREMENT PRIMARY KEY,
    ingredient_name VARCHAR(50) NOT NULL
);

--  Create the steps table
CREATE TABLE step (
    step_id INT AUTO_INCREMENT PRIMARY KEY,
    step_description TEXT
);

--  The relation between entities 
-- 1. One Ingredient can be used in many recipes and one recipe can use many ingredients so it is many to many relation
-- 2. one recipe cna belong to more than one category and one category can contain many recipes so it is a many to many relation
-- 3. one recipe can have many steps and one step can be used in many recipes so it is a  many to many relation 


-- 1. Create ingredient-recipes table

CREATE TABLE recipe_ingredient (
    recipe_ingredient_id INT AUTO_INCREMENT PRIMARY KEY,
    recipe_id INT REFERENCES recipes (recipe_id),
    ingredient_id INT REFERENCES ingredients (ingredient_id)
    
);

-- 2. Create categories-recipes table

CREATE TABLE recipe_category (
    recipe_category_id INT AUTO_INCREMENT PRIMARY KEY,
    recipe_id INT REFERENCES recipes (recipe_id),
    category_id INT REFERENCES categories (category_id)
    
);

-- 3. Create recipes_steps table

CREATE TABLE recipe_step (
    recipe_step_id INT AUTO_INCREMENT PRIMARY KEY,
    recipe_id INT REFERENCES recipes (recipe_id),
    step_id INT REFERENCES steps (step_id)
);


INSERT INTO recipe (recipe_name, number_of_gradients) 
VALUES 
   ('No-Bake Cheesecake', 5),
   ('Roasted Brussels Sprouts', 6),
   ('Mac & Cheese', 7),
   ('Tamagoyaki Japanese Omelette', 5);


INSERT INTO ingredient (ingredient_name)
VALUES
    ('Condensed milk'),
    ('Cream Cheese'),
    ('Pie Crust'),
    ('Cherry Jam'),
    ('Brussels Sprouts'),
    ('Lemon juice'),
    ('Sesame seeds'),
    ('Pepper'),
    ('Salt'),
    ('Olive oil'),
    ('Macaroni'),
    ('Butter'),
    ('Flour'),
    ('Milk'),
    ('Shredded Cheddar cheese'),
    ('Eggs'),
    ('Soy sauce'),
    ('Sugar');


INSERT INTO category (category_name)
VALUES
    ('Cake'),
    ('No-Bake'),
    ('Vegetarian'),
    ('Vegan'),
    ('Gluten-Free'),
    ('Japanese');


INSERT INTO step (step_description)
VALUES
    ('Beat Cream Cheese'),
    ('Add condensed Milk and blend'),
    ('Add Lemon Juice and blend'),
    ('Add the mix to the pie crust'),
    ('Spread the Cherry Jam'),
    ('Place in refrigerator for 3h.'),
    ('Preheat the oven'),
    ('Mix the ingredients in a bowl'),
    ('Spread the mix on baking sheet'),
    ('Bake for 30'),
    ('Cook Macaroni for 8'),
    ('Melt butter in a saucepan'),
    ('Add flour, salt, pepper and mix '),
    ('Add Milk and mix'),
    ('Cook until mix is smooth'),
    ('Add cheddar cheese'),
    ('Add the macaroni'),
    ('Beat the eggs'),
    ('Add soya sauce, sugar and salt'),
    ('Add oil to a sauce pan '),
    ('Bring to medium heat'),
    ('Add some mix to the sauce pan'),
    ('Let is cook for 1'),
    ('Remove pan from fire');


INSERT INTO recipe_ingredient (recipe_id, ingredient_id)
VALUES
    (1,1),
    (1,2),
    (1,6),
    (1,3),
    (1,4),
    (2,5),
    (2,6),
    (2,7),
    (2,8),
    (2,9),
    (2,10),
    (3,11),
    (3,12),
    (3,13),
    (3,9),
    (3,8),
    (3,14),
    (3,15),
    (4,16),
    (4,17),
    (4,18),
    (4,9),
    (4,10);


INSERT INTO recipe_category (recipe_id, category_id)
VALUES
    (1,1),
    (1,2),
    (1,3),
    (2,4),
    (2,5),
    (3,3),
    (4,3),
    (4,6);

INSERT INTO recipe_step (recipe_id, step_id)
VALUES
    (1,1),
    (1,2),
    (1,3),
    (1,4),
    (1,5),
    (1,6),
    (2,7),
    (2,8),
    (2,9),
    (2,10),
    (3,11),
    (3,12),
    (3,13),
    (3,14),
    (3,15),
    (3,16),
    (3,17),
    (4,18),
    (4,19),
    (4,20),
    (4,21),
    (4,22),
    (4,23),
    (4,20),
    (4,22),
    (4,23),
    (4,24);


-- My queries

-- All the vegetarian recipes with potatoes
    SELECT r.recipe_id, r.recipe_name;
    FROM recipe_ingredient ri
    JOIN recipe r ON ri.recipe_id = r.recipe_id
    WHERE ri.recipe_id IN (
        SELECT rc.recipe_id
        FROM recipe_category rc
        WHERE rc.category_id = 3) 
    AND ri.ingredient_id = 19;

--All the cakes that do not need baking
    SELECT DISTINCT r.recipe_id, r.recipe_name
    FROM recipe_step rs
    JOIN recipe r ON rs.recipe_id = r.recipe_id
    WHERE rs.recipe_id IN (
        SELECT rc.recipe_id
        FROM recipe_category rc
        WHERE rc.category_id = 1
    ) And rs.step_id != 10;

-- All the vegan and Japanese recipes
    SELECT DISTINCT rc.recipe_id, r.recipe_name
    FROM recipe_category rc
    JOIN recipe r ON rc.recipe_id = r.recipe_id
    WHERE rc.category_id = 4 OR rc.category_id = 6;

/* Week 3 Exercise
    Was your database already in 2NF / 3 NF?

    First 2NF: 
    To check if the database is in 2NF, it shouldn't contain any partial dependency which means the non-prime attribute shouldn't depend partially on the primary key and for all the tables in food database there is no partial dependency and for that it is already 2NF

    Second 3NF: 
    To check if hte database is in 3NF, it shouldn't contain any transitive dependency which means a non-prime attribute shouldn't depend indirectly on another non-prime attribute and in all  the tables of food database we can see that all non-prim attributes depend directly on the prime key and there is no transitive dependency of any type.

    Third: in case of adding thousands of recipes we will face a few challenges
    1. the time it's needed for each query will be more and the database will be slower
    2. updating the database (not adding new recipes) but changing the structure of the database will be very complicated due to the fixed structure nature of SQL databases and this can be fixed by using NOSQL databases 
    3. Backup and recovery will be more complex, bigger the data more difficult to backup 
    


   