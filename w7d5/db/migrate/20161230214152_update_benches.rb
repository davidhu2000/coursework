class UpdateBenches < ActiveRecord::Migration
  def change
    rename_column :benches, :descriptiopn, :description
  end
end
