class User::ShopsController < ApplicationController
  before_action :authenticate_user!

  def index
    if params[(:created_at)||(:updated_at)]
    @shops = Shop.latest.where(shop_status: false).page(params[:page]).per(6)
    elsif
    @shops = Shop.updated.where(shop_status: false).page(params[:page]).per(6)
    else
    @shops = Shop.page(params[:page]).per(6)
    end
  end

  def show
    @shop = Shop.find(params[:id])
    if params[(:created_at)||(:rate)]
      @posts = @shop.posts.latest.page(params[:page]).per(6)
    elsif
      @posts = @shop.posts.rated.page(params[:page]).per(6)
    else
      @posts = @shop.posts.page(params[:page]).per(6)
    end
  end

  def edit
    @shop = Shop.find(params[:id])
  end

  def update
    @shop = Shop.find(params[:id])
    if @shop.update(shop_params)
    redirect_to shop_path(@shop.id),flash: {success: "店舗情報を更新しました"}
    else
      render :edit
    end
  end

  def new
    @shop = Shop.new
    @areas = Area.all
  end

  def create
    @shop = Shop.new(shop_params)
    if @shop.save
    redirect_to shop_path(@shop.id),flash: {success: "店舗を新規作成しました"}
    else
      @areas = Area.all
      render :new
    end
  end

  def search
    @search_shop = Shop.ransack(params[:q])
    if params[(:created_at)]
      @result_shops = @search_shop.result.latest.where(shop_status: false).page(params[:page]).per(6)
    else
      @result_shops = @search_shop.result.where(shop_status: false).page(params[:page]).per(6)
    end
  end

  def map
    if params[(:created_at)||(:updated_at)]
      @maps = Shop.latest.page(params[:page]).per(12)
    elsif
      @maps = Shop.updated.page(params[:page]).per(12)
    else
      @maps = Shop.page(params[:page]).per(12)
    end
  end

  private

  def set_q
    @q = Shop.ransack(params[:q])
  end

  def shop_params
    params.require(:shop).permit(:shop_name, :shop_image, :bussiness_hour, :address, :shop_status, :area_id, :latitude, :longitude)
  end
end
