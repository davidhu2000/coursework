class User < ActiveRecord::Base
  validates :email, presence: true, uniqueness: true
  validates :premium, inclusion: { in: [true, false] }

  has_many :submitted_urls,
           dependent: :destroy,
           primary_key: :id,
           foreign_key: :submitter_id,
           class_name: :ShortenedUrl

  has_many :visits,
           dependent: :destroy,
           primary_key: :id,
           foreign_key: :visitor_id,
           class_name: :Visit

  has_many :visited_urls,
           proc { distinct },
           dependent: :destroy,
           through: :visits,
           source: :visited_url
end
