class CreateReviews < ActiveRecord::Migration[5.2]
  def change
    create_table :reviews do |t|
      t.belongs_to    :user
      t.integer       :drink_id, default: nil
      t.integer       :api_drink_id, default: nil
      t.text          :content

      t.timestamps
    end
  end
end
