/*The answers
1. The collections for my data will be:
 - Recipe collections which will contain the embedded information:
    + recipe_name
    + number_of_gradients
    + ingredients
    + steps
    + category
 
 - Category collection which will contain the information
   embedded
    + category_name
   normalized
    + recipes(which is an array)

 - ingredients collection which will contain the information
   embedded
    + ingredient_name
   normalized
    + recipes(which is an array)

*/
    

const { MongoClient } = require('mongodb');

const url = 'mongodb+srv://molhamdatabase:molham123@databaseweek3.on73sc9.mongodb.net'
const dbName = 'recipeDatabase';

// samples of the recipes
const recipesData = [
    {
      recipe_name: 'No-Bake Cheesecake',
      number_of_gradients: 5,
      ingredients: [
        { ingredient_name: 'Condensed milk' },
        { ingredient_name: 'Cream Cheese' },
        { ingredient_name: 'Lemon juice' },
        { ingredient_name: 'Pie Crust' },
        { ingredient_name: 'Cherry Jam' },
      ],
      steps: [
        { step_description: 'Beat Cream Cheese' },
        { step_description: 'Add condensed Milk and blend' },
        { step_description: 'Add Lemon Juice and blend' },
        { step_description: 'Add the mix to the pie crust' },
        { step_description: 'Spread the Cherry Jam' },
        { step_description: 'Place in refrigerator for 3h.' },
      ],
      category: [
        { category_name: 'Cake' },
        { category_name: 'No-Bake' },
        { category_name: 'Vegetarian' },
      ],
    }
];

// sample of the category

const categoryData = [
    {
        category_name : 'Cake',
       recipes: ['No-Bake Cheesecake', 'cheesecake']
    }
];

//sample of the ingredient 

const ingredientData = [
    {
        ingredient_name:"flour",
        recipes:['No-Bake Cheesecake', 'cheesecake']
    }
];

async function main() {
    const client = new MongoClient(url, { useNewUrlParser: true, useUnifiedTopology: true });
  
    try {
    
      await client.connect();
  
   
      const db = client.db(dbName);
  
      
      const recipesCollection = db.collection('recipes');
      const categoriesCollection = db.collection('categories');
      const ingredientsCollection = db.collection('ingredients');

  
      
      await recipesCollection.insertMany(recipesData);
      await categoriesCollection.insertMany(categoryData);
      await ingredientsCollection.insertMany(ingredientData);
  
  
      console.log('Data inserted successfully.');
    } finally {
      
      client.close();
    }
  }
  
  main().catch(console.error);

  /*- What made you decide when to embed information? What assumptions did you make?

  the embedded information are linked directly to other information inside the document while normalized information can be shared with other documents


  - If you were given MySQL and MongoDB as choices to build the recipe's database at the beginning, which one would you
  choose and why?

  for this type of data which doesn't require massive rate of data transfer and low possibility to grow, in this case I prefer to use the SQL 
  */