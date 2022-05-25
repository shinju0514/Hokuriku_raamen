class Admin::AreasController < ApplicationController
  before_action :authenticate_admin!
  def index
    @areas = Area.all
  end

  def create
    @area_new= Area.new(area_params)
    @area_new.save
    redirect_to admin_areas_path
  end

  def destroy
    @area = Area.find(params[:id])
    @area.destroy
    redirect_to admin_areas_path
  end

  private

  def area_params
    params.permit(:prefecture)
  end
end
