class Coordinate < ApplicationRecord
  belongs_to :expedition
  has_many :annotations, dependent: :destroy
  belongs_to :parent, class_name: "Coordinate", foreign_key: :parent_id, required: false

  reverse_geocoded_by :latitude, :longitude
  after_validation :geocode

  validates_presence_of :latitude, :longitude
  validate :ensure_new_location

  def siblings
    self.expedition.coordinates.order(:created_at)
  end

  private

  def ensure_new_location
    if self.parent
      if self.latitude == self.parent.latitude && self.longitude == self.parent.longitude
        self.errors.add(:same_location, "A Coordinate requires a different location to its parent")
      end
    end
  end

end
