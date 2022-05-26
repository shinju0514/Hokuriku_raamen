class Admin::AreasController < ApplicationController
  before_action :authenticate_admin!
  def index
    @areas = Area.all
    @area = Area.new
  end

  def create
    @area = Area.new(area_params)
    if @area.save
    redirect_to admin_areas_path,flash: {success: "エリアを追加しました"}
    else
      @areas = Area.all
      render :index
    end
  end

  def destroy
    @area = Area.find(params[:id])
    @area.destroy
    redirect_to admin_areas_path,flash: {danger: "エリアを削除しました"}
  end

  private

  def area_params
    params.require(:area).permit(:prefecture)
  end
end
