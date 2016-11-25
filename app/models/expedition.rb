class Expedition < ApplicationRecord
  belongs_to :user
  has_many :coordinates, dependent: :destroy

  def attach_file(annotation)
    coordinate = self.coordinates.last
    key = annotation.keys.first
    content_type = annotation[key].content_type
    full_path = "/uploads/annotation/#{key}/"
    new_annotation = coordinate.annotations.new(annotation.merge(content_type: content_type, full_path: full_path))
    coordinate.annotations.create(annotation.merge(content_type: content_type, full_path: full_path))
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
