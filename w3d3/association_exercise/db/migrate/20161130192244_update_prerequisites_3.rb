class UpdatePrerequisites3 < ActiveRecord::Migration
  def change
    change_column :prerequisites, :prereq_id, :integer, null: true
  end
end
