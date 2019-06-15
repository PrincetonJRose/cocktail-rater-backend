class AddUserImageColumnToReviewsAndComments < ActiveRecord::Migration[5.2]
  def change
    add_column :reviews, :user_avatar_image, :string
    add_column :comments, :user_avatar_image, :string
  end
end
