class CreatePrerequisites < ActiveRecord::Migration
  def change
    create_table :prerequisites do |t|
      t.integer :course_id
      t.integer :prereq_id
      t.timestamps
    end

    add_index :prerequisites, :course_id
    add_index :prerequisites, :prereq_id
  end
end
