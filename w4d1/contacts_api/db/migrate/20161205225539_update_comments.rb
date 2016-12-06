class UpdateComments < ActiveRecord::Migration
  def change
    change_column :comments, :comments_id, :integer, null: false
    change_column :comments, :comments_type, :string, null: false
  end
end
