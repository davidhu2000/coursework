class UpdatePrerequisites2 < ActiveRecord::Migration
  def change
    change_column :prerequisites, :prereq_id, :integer, null: false
  end
end
