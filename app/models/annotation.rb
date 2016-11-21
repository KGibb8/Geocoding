require './app/uploaders/image_uploader.rb'

class Annotation < ApplicationRecord
  belongs_to :coordinate
  # Probably having different uploaders in future project with different whitelists. Also mini_magick with image uploader
  mount_uploader :image, ImageUploader
  # mount_uploader :recording, AnnotationUploader
  # mount_uploader :note, AnnotationUploader

  validate :presence_of_content

  private

  def presence_of_content
    if self.image.file.nil? && self.recording.file.nil? && self.note.file.nil?
      self.errors.add(:missing_content, "Must contain data for at least one column")
    end
  end
end
