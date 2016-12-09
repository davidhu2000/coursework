# == Schema Information
#
# Table name: albums
#
#  id         :integer          not null, primary key
#  band_id    :integer          not null
#  name       :text             not null
#  edition    :text             not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Album < ActiveRecord::Base
  belongs_to :band

  has_many :tracks, dependent: :destroy

  validates :band_id, presence: true
  validates :name, presence: true
  validates :edition, inclusion: ['live', 'studio']

  delegate :name, to: :band, prefix: true

  def num_tracks
    self.tracks.count
  end
end
