class UpdateUsers < ActiveRecord::Migration
  def change
    remove_column :users, :name
    remove_column :users, :email
    add_column :users, :username, null: false, unique: true
  end
end
