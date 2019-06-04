class CreateLikes < ActiveRecord::Migration[5.2]
  def change
    create_table :likes do |t|
      t.belongs_to  :user
      t.integer     :drink_id
      t.integer     :api_drink_id

      t.timestamps
    end
  end
end
