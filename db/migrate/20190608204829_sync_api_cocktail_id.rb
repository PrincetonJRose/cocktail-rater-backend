class SyncApiCocktailId < ActiveRecord::Migration[5.2]
  def change

    remove_column :cocktails, :api_drink_id
    add_column :cocktails, :api_cocktail_id, :integer

    remove_column :likes, :drink_id
    add_column :likes, :cocktail_id, :integer
    remove_column :likes, :api_drink_id
    add_column :likes, :api_cocktail_id, :integer

    remove_column :reviews, :api_drink_id
    add_column :reviews, :api_cocktail_id, :integer
    remove_column :reviews, :drink_id
    add_column :reviews, :cocktail_id, :integer

  end
end
