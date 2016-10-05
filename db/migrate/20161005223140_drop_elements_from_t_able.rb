class DropElementsFromTAble < ActiveRecord::Migration[5.0]
  def change
    remove_column :users, :first_name
    remove_column :users, :last_name
    remove_column :users, :team_name
    add_column :comments, :post_id, :integer
  end
end
