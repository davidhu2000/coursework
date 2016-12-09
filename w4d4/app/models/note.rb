# == Schema Information
#
# Table name: notes
#
#  id         :integer          not null, primary key
#  user_id    :integer          not null
#  body       :text             not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  track_id   :integer          not null
#

class Note < ActiveRecord::Base
  validates :user_id, :body, presence: true

  belongs_to :track

  belongs_to :user

  delegate :email, to: :user, prefix: true
end
