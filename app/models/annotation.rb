require './app/uploaders/image_uploader.rb'
require './app/uploaders/recording_uploader.rb'

class Annotation < ApplicationRecord
  belongs_to :coordinate
  mount_uploader :image, ImageUploader
  mount_uploader :recording, RecordingUploader
  # mount_uploader :note, AnnotationUploader

  validate :presence_of_content

  private

  def presence_of_content
    if self.image.file.nil? && self.recording.file.nil?
      self.errors.add(:missing_content, "Must contain data for at least one column")
    end
  end
end
