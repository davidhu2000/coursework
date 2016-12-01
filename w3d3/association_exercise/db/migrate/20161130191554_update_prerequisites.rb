class UpdatePrerequisites < ActiveRecord::Migration
  def change
    change_column :prerequisites, :course_id, :integer, null: false
    change_column :prerequisites, :prereq_id, :integer, null: false
  end
end
