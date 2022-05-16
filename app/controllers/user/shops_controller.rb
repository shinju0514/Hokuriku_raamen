class User::ShopsController < ApplicationController

  def index
    @shops = Shop.page(params[:page]).per(6)
  end

  def show
    @shop = Shop.find(params[:id])
    @posts = @shop.posts
  end

  def edit
    @shop = Shop.find(params[:id])
  end

  def update
    @shop = Shop.find(params[:id])
    @shop.update(shop_params)
    redirect_to shop_path(@shop.id)
  end

  def new
    @shop = Shop.new
    @areas = Area.all
  end

  def create
    @shop = Shop.new(shop_params)
    @shop.save
    redirect_to shops_path
  end

  def search
    @search_shop = Shop.ransack(params[:q])
    @result_shops = @search_shop.result
  end

  private

  def set_q
    @q = Shop.ransack(params[:q])
  end

  def open_closed
    @shop = Shop.find_by(params[:id])
    @shop.open_closed! unless @shop.open_closed?
    redirect_to edit_ship_path(@shop.id)
  end

  def nonopen_closed
    @shop = Shop.find_by(params[:id])
    @shop.nonopen_closed! unless @shop.nonopen_closed?
    redirect_to edit_ship_path(@shop.id)
  end

  def shop_params
    params.require(:shop).permit(:shop_name, :shop_image, :bussiness_hour, :address, :shop_status, :area_id)
  end
end
