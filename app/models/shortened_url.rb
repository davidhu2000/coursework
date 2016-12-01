class ShortenedUrl < ActiveRecord::Base
  validates :short_url, presence: true, uniqueness: true
  validates :submitter_id, presence: true
  validates :long_url, presence: true, length: { maximum: 1024 }
  validate :less_than_five_submissions_last_minute
  validate :only_premium_member_can_submit_more_than_five

  def less_than_five_submissions_last_minute
    user_id = self.submitter_id
    user_subs = self.class.submissions_last_minute.where(submitter_id: user_id).length

    if user_subs >= 5
      errors.add(:submitter, 'cannot submit more than 5 per minute.')
    end
  end

  def only_premium_member_can_submit_more_than_five
    user = User.find(submitter_id)
    num_subs = self.class.number_of_submissions_by_user(submitter_id)

    if num_subs >= 5 && !user.premium
      errors.add(:submitter, 'need to be premium to submit more than 5.')
    end
  end

  belongs_to :submitter,
    primary_key: :id,
    foreign_key: :submitter_id,
    class_name: :User

  has_many :visits,
    dependent: :destroy,
    primary_key: :id,
    foreign_key: :short_url_id,
    class_name: :Visit

  has_many :visitors,
    Proc.new { distinct },
    dependent: :destroy,
    through: :visits,
    source: :visitor

  has_many :tag_ids,
    dependent: :destroy,
    primary_key: :id,
    foreign_key: :url_id,
    class_name: :Tagging

  def self.random_code
    code = SecureRandom::urlsafe_base64

    while self.exists?(short_url: code)
      code = SecureRandom::urlsafe_base64
    end
    code
  end

  def self.prune
    urls = Visit.select(:short_url_id).where('created_at < ?', 10.seconds.ago)
    ids = urls.map(&:short_url_id).uniq
    ids.each { |id| ShortenedUrl.find(id).destroy }
  end

  def self.create_for_user_and_long_url!(user, long_url)
    self.create!(submitter_id: user.id, short_url: random_code, long_url: long_url)
  end

  def self.submissions_last_minute
    self.select(:submitter_id).where('created_at > ?', 1.minute.ago)
  end

  def self.number_of_submissions_by_user(id)
    self.select(:submitter_id).where(submitter_id: id).count
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
