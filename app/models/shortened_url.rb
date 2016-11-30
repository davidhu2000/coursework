class ShortenedUrl < ActiveRecord::Base
  validates :short_url, presence: true, uniqueness: true
  validates :submitter_id, :long_url, presence: true

  belongs_to :submitter,
    primary_key: :id,
    foreign_key: :submitter_id,
    class_name: :User

  has_many :visits,
    primary_key: :id,
    foreign_key: :short_url_id,
    class_name: :Visit

  has_many :visitors,
    Proc.new { distinct },
    through: :visits,
    source: :visitor

  def self.random_code
    code = SecureRandom::urlsafe_base64

    while self.exists?(short_url: code)
      code = SecureRandom::urlsafe_base64
    end
    code
  end

  def self.create_for_user_and_long_url!(user, long_url)
    self.create!(submitter_id: user.id, short_url: random_code, long_url: long_url)
  end

  def num_clicks
    get_all_visits.length
  end

  def num_uniques
    self.visitors.count
  end

  def num_recent_uniques
    get_all_visits.where("created_at > ?", 10.minutes.ago)
  end

  def get_all_visits
    Visit.select(:visitor_id).where(short_url_id: self.id)
  end
end
