class AnnotationsController < ApplicationController
  def create
    expedition = current_user.expeditions.find(params[:expedition_id].to_i)
    annotation = expedition.attach_file(annotation_params)
    unless annotation.recording.file.nil?
      render json: {annotation: {url: annotation.recording.url, content_type: annotation.recording.content_type}, coordinate: annotation.coordinate}
    else
      render json: {annotation: annotation, coordinate: annotation.coordinate}
    end
  end

  def destroy

  end

  private

  def annotation_params
    params.require(:annotation).permit(:image, :recording, :note)
  end
end
