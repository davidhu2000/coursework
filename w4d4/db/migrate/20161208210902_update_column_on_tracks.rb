class UpdateColumnOnTracks < ActiveRecord::Migration
  def change
    rename_column :albums, :title, :name
  end
end
