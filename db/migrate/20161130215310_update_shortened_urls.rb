class UpdateShortenedUrls < ActiveRecord::Migration
  def change
    rename_column :shortened_urls, :owner_id, :submitter_id
  end
end
