class CreateComments < ActiveRecord::Migration
  def change
    create_table :comments do |t|
      t.text :body, null: false
      t.references :comments, polymorphic: true, index: true
      t.timestamps null: false
    end
  end
end
