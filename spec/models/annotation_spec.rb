require 'rails_helper'

RSpec.describe Annotation do
  before do
    @dave = User.create(email: "dave@dave.net", password: "123456")
    @fungi_finding = @dave.expeditions.create(title: "Fungi Funding", description: "Hunting for Fungi in Epping Forest")
    @epping = @fungi_finding.coordinates.create(latitude: 51.0242261, longitude: -0.01246278)
  end
  describe 'creating an Annotation' do
    context 'with valid creation criteria' do
      before do
        image_file = Rack::Test::UploadedFile.new(File.join(__dir__, "../assets", "bearded.jpg"))
        recording_file = Rack::Test::UploadedFile.new(File.join(__dir__, "../assets", "birdie.mp3"))
        note_file = Rack::Test::UploadedFile.new(File.join(__dir__, "../assets", "note.txt"))
        @image = @epping.annotations.create(image: image_file)
        @recording = @epping.annotations.create(recording: recording_file)
        @note = @epping.annotations.create(note: note_file)
      end
      it 'can contain an image' do
        expect(@image).to_not be_nil
      end
      it 'can contain a recording' do
        expect(@recording).to_not be_nil
      end
      it 'can contain a note' do
        expect(@note).to_not be_nil
      end
    end
    context 'with invalid creation criteria' do
      before do
        @invalid_annotation = @epping.annotations.create
      end
      it 'should be invalid if it does not contain content' do
        expect(@invalid_annotation).to_not be_valid
        expect(@invalid_annotation.errors.messages.keys).to include :missing_content
        expect(@invalid_annotation.errors.messages).equal? "Must contain data for at least one column"
      end
    end
  end
end

