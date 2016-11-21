require 'rails_helper'

RSpec.describe Coordinate do

  before do
    @current_user = User.create(email: "current.user@expedition.net", password: "123456")
    @expedition = @current_user.expeditions.create(title: "Going on a Bear Hunt", description: "We're gonna catch a big one")
  end

  describe "creating a new Coordinate" do

    before do
      @coordinate = @expedition.coordinates.create(latitude: 51.1234567, longitude: -0.012345678)
    end

    it "should be valid when a new lat/lng is supplied" do
      coordinate_valid = @expedition.coordinates.create(latitude: 51.1233312, longitude: -1.012333376)
      expect(coordinate_valid).to be_valid
    end

    it "should not be valid if the new lat/lng is the same as the previous coordinate" do
      coordinate_not_valid = @expedition.coordinates.create(latitude: 51.1234567, longitude: -0.012345678)
      expect(coordinate_not_valid.errors.messages.keys).to include :same_location
      expect(coordinate_not_valid.errors.messages).equal? "A Coordinate requires a new location relative to its previous"
    end

  end

end