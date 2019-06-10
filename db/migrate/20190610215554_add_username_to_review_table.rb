class AddUsernameToReviewTable < ActiveRecord::Migration[5.2]
  def change
    add_column :reviews, :user_name, :string
    add_column :likes, :user_name, :string
    add_column :comments, :user_name, :string
  end
end
