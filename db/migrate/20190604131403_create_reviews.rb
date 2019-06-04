class CreateReviews < ActiveRecord::Migration[5.2]
  def change
    create_table :reviews do |t|
      t.belongs_to    :user
      t.integer       :cocktail_id
      t.integer       :api_cocktail_id
      t.text          :content

      t.timestamps
    end
  end
end
