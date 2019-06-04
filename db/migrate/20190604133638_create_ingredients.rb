class CreateIngredients < ActiveRecord::Migration[5.2]
  def change
    create_table :ingredients do |t|
      t.integer   :api_ingredient_id
      t.string    :name
      t.string    :category
      t.text      :description
      t.string    :imageUrl

      t.timestamps
    end
  end
end
