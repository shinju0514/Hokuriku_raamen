class User::ShopsController < ApplicationController
  def index
    @shops = Shop.page(params[:page]).per(6)
  end

  def show
    @shop = Shop.find(params[:id])
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
  end

  def create
    @shop = Shop.new(shop_params)
    @shop.save
    redirect_to shops_path
  end

  private

  def shop_params
    params.require(:shop).permit(:shop_name, :shop_image, :bussiness_hour, :address)
  end
end
