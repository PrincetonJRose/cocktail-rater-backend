class CreateCocktails < ActiveRecord::Migration[5.2]
  def change
    create_table :cocktails do |t|
      t.integer   :api_cocktail_id
      t.string    :name
      t.text      :instructions
      t.string    :category
      t.string    :alcoholic
      t.string    :glass
      t.string    :videoURL
      t.string    :imageUrl

      t.timestamps
    end
  end
end
