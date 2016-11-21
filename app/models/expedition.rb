class Expedition < ApplicationRecord
  belongs_to :user
  has_many :coordinates

  def attach_file(annotation)
    coordinate = self.coordinates.last
    coordinate.annotations.create(annotation)
  end
end
