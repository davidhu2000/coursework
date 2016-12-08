# == Schema Information
#
# Table name: users
#
#  id              :integer          not null, primary key
#  username        :string           not null
#  password_digest :string           not null
#  session_token   :string           not null
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#

class User < ActiveRecord::Base
  validates :username, :password_digest, :session_token, presence: true

  has_many :cats
  has_many :cat_rental_requests

  after_initialize :ensure_session_token


  def ensure_session_token
    self.session_token ||= SecureRandom.urlsafe_base64(128)
  end

  def reset_session_token!
    self.session_token = SecureRandom.urlsafe_base64(128)
  end

  def password=(password)
    @password = password
    self.password_digest = BCrypt::Password.create(password)
  end

  def correct_password?(password)
    digest = BCrypt::Password.new(self.password_digest)
    digest.is_password?(password)
  end

  def self.find_by_credentials(username, password)
    user = User.find_by(username: username)
    return nil unless user
    user if user.correct_password?(password)
  end
end
