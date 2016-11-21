# Be sure to restart your server when you modify this file. Action Cable runs in a loop that does not support auto reloading.
class CoordinatesChannel < ApplicationCable::Channel
  def subscribed
    stream_from "coordinates_channel"
  end

  def unsubscribed
    # Any cleanup needed when channel is unsubscribed
  end

  def create(data)
    coordinate_params = data["coordinate"].merge(expedition: Expedition.find(data["expedition"]["id"]))
    coordinate = Coordinate.create(coordinate_params)
    ActionCable.server.broadcast("coordinates_channel", coordinate: coordinate)
  end


end
