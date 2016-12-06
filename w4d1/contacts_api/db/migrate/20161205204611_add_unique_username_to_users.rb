class AddUniqueUsernameToUsers < ActiveRecord::Migration
  def change
    change_column :users, :username, :string, unique: true, null: false
  end
end
