class User < ActiveRecord::Base
  validates :email, presence: true, uniqueness: true

  has_many :short_urls,
    primary_key: :id,
    foreign_key: :owner_id,
    class_name: :ShortenedUrl

end
