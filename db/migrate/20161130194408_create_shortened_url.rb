class CreateShortenedUrl < ActiveRecord::Migration
  def change
    create_table :shortened_urls do |t|
      t.integer :owner_id, null: false
      t.string :short_url, null: false
      t.string :long_url, null: false
      t.timestamps
    end

    add_index :shortened_urls, :owner_id
    add_index :shortened_urls, :short_url, unique: true
  end
end
