# == Schema Information
#
# Table name: tracks
#
#  id         :integer          not null, primary key
#  album_id   :integer          not null
#  name       :string           default("[Untitled]")
#  category   :string           default("regular")
#  lyrics     :text
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Track < ActiveRecord::Base
  belongs_to :album

  has_one :band, through: :album, source: :band

  validates :album_id, presence: true
  validates :name, presence: true
  validates :category, inclusion: ['regular', 'bonus']

  delegate :name, to: :album, prefix: true
  delegate :name, to: :band, prefix: true

end
