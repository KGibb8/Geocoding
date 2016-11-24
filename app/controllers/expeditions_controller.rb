class ExpeditionsController < ApplicationController
  before_filter :authenticate_user!
  before_action :find_expedition, only: [:show, :edit, :update]
  semantic_breadcrumb :index, :expeditions_path

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

