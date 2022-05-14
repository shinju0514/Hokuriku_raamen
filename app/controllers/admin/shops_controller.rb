class Admin::ShopsController < ApplicationController
  def index
    @shops = Shop.page(params[:page]).per(10)
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
    redirect_to admin_shop_path(@shop.id)
  end

  def new
    @shop = Shop.new
  end

  def create
    @shop = Shop.new(shop_params)
    @shop.save
    redirect_to admin_shops_path
  end

  def destroy
    @shop = Shop.find(params[:id])
    @shop.destroy
    redirect_to admin_shops_path
  end

  private

  def shop_params
    params.require(:shop).permit(:shop_name, :address, :bussiness_hour, :shop_image)
  end
end
