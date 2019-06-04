class CreateApiCocktailInfos < ActiveRecord::Migration[5.2]
  def change
    create_table :api_cocktail_infos do |t|
      t.integer   :api_cocktail_id
      t.string    :name
      t.string    :imageUrl
      t.text      :instructions
      t.string    :category
      t.string    :alcoholic
      t.string    :glass
      t.string    :videoUrl
      t.string    :ingredient_1
      t.string    :ingredient_2
      t.string    :ingredient_3
      t.string    :ingredient_4
      t.string    :ingredient_5
      t.string    :ingredient_6
      t.string    :ingredient_7
      t.string    :ingredient_8
      t.string    :ingredient_9
      t.string    :ingredient_10
      t.string    :ingredient_11
      t.string    :ingredient_12
      t.string    :ingredient_13
      t.string    :ingredient_14
      t.string    :ingredient_15
      t.string    :measurement_1
      t.string    :measurement_2
      t.string    :measurement_3
      t.string    :measurement_4
      t.string    :measurement_5
      t.string    :measurement_6
      t.string    :measurement_7
      t.string    :measurement_8
      t.string    :measurement_9
      t.string    :measurement_10
      t.string    :measurement_11
      t.string    :measurement_12
      t.string    :measurement_13
      t.string    :measurement_14
      t.string    :measurement_15

      t.timestamps
    end
  end
end
