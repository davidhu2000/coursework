class UpdateNotes < ActiveRecord::Migration
  def change
    add_column :notes, :track_id, :integer, null: false
  end
end
