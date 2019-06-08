class AddApiCocktailInfoIdToReviewsAndLikes < ActiveRecord::Migration[5.2]
  def change

    add_column :likes, :api_cocktail_info_id, :integer
    add_column :reviews, :api_cocktail_info_id, :integer
    
  end
end
