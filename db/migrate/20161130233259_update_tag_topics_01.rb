class UpdateTagTopics01 < ActiveRecord::Migration
  def change
    change_column :tag_topics, :topic, :string, null: false
  end
end
