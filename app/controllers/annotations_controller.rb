class AnnotationsController < ApplicationController
  def create
    expedition = current_user.expeditions.find(params[:expedition_id].to_i)
    annotation = expedition.attach_file(annotation_params)
    render json: {annotation: annotation, coordinate: annotation.coordinate}
  end

  # def update

  # end

  def destroy

  end

  private

  def annotation_params
    params.require(:annotation).permit(:image, :recording, :note)
  end
end
