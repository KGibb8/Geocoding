class Coordinate < ApplicationRecord
  belongs_to :expedition
  has_many :annotations
  reverse_geocoded_by :latitude, :longitude
  after_validation :geocode

  validates_presence_of :latitude, :longitude
  validate :ensure_new_location

  private

  def ensure_new_location
    last_coordinate = self.expedition.coordinates.last
    if last_coordinate && last_coordinate.id != self.id
      if self.latitude == last_coordinate.latitude && self.longitude == last_coordinate.longitude
        self.errors.add(:same_location, "A Coordinate requires a new location relative to its previous")
      end
    end
  end

end

