class CoordinatesController < ApplicationController
  before_filter :authenticate_user!
  before_action :find_expedition, only: [:create]

  def create
    last_lat_lng = nil
    unless @expedition.coordinates.empty?
      last_coordinate = @expedition.coordinates.last
      last_lat_lng = { lat: last_coordinate.latitude, lng: last_coordinate.longitude }
    end
    # Need a better way of comparing!
    # Also maybe this is model logic?
    if last_lat_lng == lat_lng_params
      render json: {lat: last_coordinate.latitude, lng: last_coordinate.longitude}
    else
      coordinate = Coordinate.create(coordinate_params.merge(expedition: @expedition))
      render json: {lat: coordinate.latitude, lng: coordinate.longitude}
    end
  end

  private

  def find_expedition
    @expedition = Expedition.find(params[:expedition_id])
  end

  def coordinate_params
    coordinate_params = params.require(:coordinate).permit(:lat, :lng, :accuracy, :heading, :altitude)
    coordinate_params[:latitude] = coordinate_params.delete :lat
    coordinate_params[:longitude] = coordinate_params.delete :lng
    coordinate_params[:bearing] = coordinate_params.delete :heading
    coordinate_params.merge(geocoder_params)
  end

  def geocoder_params
    request.location.data.reject{|k, v| k == "metrocode" || k == "latitude" || k == "longitude" || k == "zipcode" }
  end

  def lat_lng_params
    lat_lng_params = params.require(:coordinate).permit(:lat, :lng)
    lat_lng_params.transform_keys!(&:to_sym)
    lat_lng_params.transform_values!(&:to_f)
  end

end
