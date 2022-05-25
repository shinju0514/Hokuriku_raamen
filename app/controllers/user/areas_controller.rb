class User::AreasController < ApplicationController
  before_action :authenticate_user!
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

  def search
    @areas = Area.all
    @search_area = Area.ransack(params[:q])
    @result_areas = @search_area.result
  end

  def set_q
    @q = Area.ransack(params[:q])
  end
end
