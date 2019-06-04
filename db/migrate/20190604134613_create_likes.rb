class CreateLikes < ActiveRecord::Migration[5.2]
  def change
    create_table :likes do |t|
      t.belongs_to  :user
      t.integer     :cocktail_id
      t.integer     :api_cocktail_id

      t.timestamps
    end
  end
end
