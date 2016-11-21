class Coordinate < ApplicationRecord
  belongs_to :expedition
  has_many :annotations
  reverse_geocoded_by :latitude, :longitude
  after_validation :geocode
end
