class Bench < ActiveRecord::Base
  validates :description, :lat, :lng, presence: true

  def self.in_bounds(bounds)
    if bounds
      max_lat = bounds['northEast']['lat'].to_f
      max_lng = bounds['northEast']['lng'].to_f
      min_lat = bounds['southWest']['lat'].to_f
      min_lng = bounds['southWest']['lng'].to_f
      self.where(lat: min_lat..max_lat, lng: min_lng...max_lng)
    else
      self.all
    end
  end
end
