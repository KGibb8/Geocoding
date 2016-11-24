class ExpeditionsController < ApplicationController
  before_filter :authenticate_user!
  before_action :find_expedition, only: [:show, :edit, :update]
  semantic_breadcrumb :index, :expeditions_path

  POLYCOLOUR = ["#003366", "#009933", "#99cc00", "#ffcc00", "#cc6699", "#9966ff", "#996600", "#cc99ff"]

  def index
    @my_expeditions = current_user.expeditions.order(:updated_at)
    @expedition = current_user.expeditions.build
  end

  def create
    expedition = current_user.expeditions.create(expedition_params)
    redirect_to edit_expedition_path(expedition)
  end

  def show

  end

  def edit
    coordinate = @expedition.coordinates.last
    if coordinate && (Time.now - 900 > coordinate.created_at)
      @expedition.segment += 1
      @expedition.save
    end
    @segment = @expedition.segment
    @coordinates = Coordinate.find_by_sql(
      "SELECT c.id, c.parent_id, c.latitude, c.longitude, c.segment, a.id AS annotation_id, a.image, a.recording
        FROM coordinates AS c
          LEFT OUTER JOIN annotations AS a ON a.coordinate_id = c.id
        WHERE c.expedition_id = #{@expedition.id}
        ORDER BY c.id, c.parent_id, c.segment;"
    ).to_json
    @poly_colour = POLYCOLOUR[@expedition.segment % 8]
    @annotation = Annotation.new
  end

  def update

  end

  def destroy

  end

  private

  def find_expedition
    @expedition = Expedition.find(params[:id])
  end

  def expedition_params
    params.require(:expedition).permit(:title, :description)
  end

end

