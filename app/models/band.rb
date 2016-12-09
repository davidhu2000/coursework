# == Schema Information
#
# Table name: bands
#
#  id         :integer          not null, primary key
#  name       :string           not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Band < ActiveRecord::Base
  has_many :albums, dependent: :destroy
  has_many :tracks, through: :albums, source: :tracks
  validates :name, presence: true, uniqueness: true

  def num_albums
    self.albums.count
  end
end
