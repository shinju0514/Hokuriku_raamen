class User::AreasController < ApplicationController
  def index
    @areas = Area.all
  end

  def create
    @area_new= Area.new(area_params)
    @area_new.save
    redirect_to areas_path
  end

  def destroy
    @area = Area.find(params[:id])
    @area.destroy
    redirect_to areas_path
  end
end
