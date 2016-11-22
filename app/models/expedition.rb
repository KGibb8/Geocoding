class Expedition < ApplicationRecord
  belongs_to :user
  has_many :coordinates, dependent: :destroy

  def attach_file(annotation)
    coordinate = self.coordinates.last
    coordinate.annotations.create(annotation)
  end

  def images
    self.coordinates.map(&:annotation).map(&:image)
  end

  def recordings
    self.coordinates.map(&:annotation).map(&:recording)
  end

  def distance_travelled
    self.coordinates.inject(0){|total_distance, coord| total_distance += coord.distance_to_last }
  end

end
