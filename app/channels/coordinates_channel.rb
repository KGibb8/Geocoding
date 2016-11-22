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
    coordinate_params = data["coordinate"].merge(expedition: expedition)
    coordinate = Coordinate.create(coordinate_params)
    ActionCable.server.broadcast("coordinates_channel", {coordinate: coordinate, distance_travelled: expedition.distance_travelled})
  end


end
