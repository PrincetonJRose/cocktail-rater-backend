class CreateCocktailIngredients < ActiveRecord::Migration[5.2]
  def change
    create_table :cocktail_ingredients do |t|
      t.integer :cocktail_id
      t.integer :api_cocktail_id
      t.integer :ingredient_id
      t.integer :api_ingredient_id
      t.string  :measurement

      t.timestamps
    end
  end
end
