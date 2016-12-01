class TagTopic < ActiveRecord::Base
  validates :topic, presence: true

  has_many :url_ids,
    dependent: :destroy,
    primary_key: :id,
    foreign_key: :tag_id,
    class_name: :Tagging
end
