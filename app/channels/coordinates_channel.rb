# Be sure to restart your server when you modify this file. Action Cable runs in a loop that does not support auto reloading.
class CoordinatesChannel < ApplicationCable::Channel
  def subscribed
    stream_from "coordinates_channel"
  end

  def unsubscribed
    # Any cleanup needed when channel is unsubscribed
  end

  def create(data)
    expedition = Expedition.find(data["expedition"]["id"])
    last_coord = expedition.coordinates.last
    # Calculate the distance in m between the previous coordinate and the last => If it the first coordinate in the sequence, set the distance to 0
    distance_in_m = (last_coord ? (Geocoder::Calculations.distance_between([last_coord.latitude, last_coord.longitude], [data["coordinate"]["latitude"], data["coordinate"]["longitude"]]) * 1000) : 0)
    coordinate_params = data["coordinate"].merge(expedition: expedition, distance_to_last: distance_in_m)
    expedition.coordinates.empty? ? coordinate = Coordinate.create(coordinate_params) : coordinate = Coordinate.create(coordinate_params.merge(parent: expedition.coordinates.last))
    ActionCable.server.broadcast("coordinates_channel", {coordinate: coordinate, distance_travelled: expedition.distance_travelled})
  end


end
