class ShortenedUrl < ActiveRecord::Base
  validates :owner_id, :short_url, presence: true, uniqueness: true
  validates :long_url, presence: true

  belongs_to :owner,
    primary_key: :id,
    foreign_key: :owner_id,
    class_name: :User

  def self.random_code
    code = SecureRandom::urlsafe_base64

    while self.exists?(short_url: code)
      code = SecureRandom::urlsafe_base64
    end
    code
  end

  def self.create_for_user_and_long_url!(user, long_url)
    self.create!(owner_id: user, short_url: random_code, long_url: long_url)
  end
end
