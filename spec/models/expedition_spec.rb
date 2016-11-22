require 'rails_helper'

RSpec.describe Expedition do

  before do
    @current_user = User.create(email: "current.user@expedition.net", password: "123456")
    @expedition = @current_user.expeditions.create(title: "Going on a Bear Hunt", description: "We're gonna catch a big one")
  end

  describe "finding out the total distance travelled so far on a given Expedition" do

    it "returns 0 if only one coordinate exists" do
      @expedition.coordinates.create(latitude: 51.1234567, longitude: -0.012345678)
      expect(@expedition.distance_travelled).to eq 0
    end

    it "determines the total distance travelled" do
      first = @expedition.coordinates.create(latitude: 51.1234567, longitude: -0.012345678)
      second = @expedition.coordinates.create(latitude: 51.1234581, longitude: -0.012345699, parent: first)
      expect(@expedition.distance_travelled).to eq 0.0967349
      @expedition.coordinates.create(latitude: 51.1234611, longitude: -0.012345714, parent: second)
      expect(@expedition.distance_travelled).to eq 0.3040158
    end

  end

end
