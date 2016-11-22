class Coordinate < ApplicationRecord
  belongs_to :expedition
  has_many :annotations, dependent: :destroy

  reverse_geocoded_by :latitude, :longitude
  after_validation :geocode

  before_create :set_last_coordinate
  before_create :set_distance_to_last

  validates_presence_of :latitude, :longitude
  validate :ensure_new_location

  def siblings
    self.expedition.coordinates.order(:created_at)
  end

  def distance_to_last
    @@distance_to_last
  end

  def previous_coordinate
    @previous_coordinate
  end

  private

  def set_last_coordinate
    @previous_coordinate = self.expedition.coordinates.last
  end

  def set_distance_to_last
    @@distance_to_last = 0
    unless @previous_coordinate.nil?
      distance_in_m = Geocoder::Calculations.distance_between([@previous_coordinate.latitude, @previous_coordinate.longitude], [self.latitude, self.longitude]) * 1000
      @@distance_to_last = distance_in_m.to_s[0..8].to_f
    end
  end

  def ensure_new_location
    last_coordinate = set_last_coordinate
    if last_coordinate && last_coordinate.id != self.id
      if self.latitude == last_coordinate.latitude && self.longitude == last_coordinate.longitude
        self.errors.add(:same_location, "A Coordinate requires a new location relative to its previous")
      end
    end
  end

end

  # DISTANCE_TO_LAST = siblings[Hash[siblings.map.with_index.to_a][self]]


  # def last_coordinate
  #  self.expedition.coordinates.last
  # end

  # def previous_coordinate
  #   # Set this as a constant?
  #   coords = self.expedition.coordinates.order(:created_at)
  #   ordered = Hash[coords.map.with_index.to_a]
  #   index = ordered[self]
  #   coords[index]
  # end

