class AddUserIdColumnToCocktailsTable < ActiveRecord::Migration[5.2]
  def change
    add_column :cocktails, :user_id, :integer
  end
end
