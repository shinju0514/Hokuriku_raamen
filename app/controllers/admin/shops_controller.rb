class Admin::ShopsController < ApplicationController
  before_action :authenticate_admin!

  # 新着順と更新順に並べ替える記述
  # モデルに定義したスコープを使用
  def index
    if params[(:created_at)||(:updated_at)]
      @shops = Shop.latest.page(params[:page]).per(10)
    elsif
      @shops = Shop.updated.page(params[:page]).per(10)
    else
      @shops = Shop.page(params[:page]).per(10)
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
      redirect_to admin_shop_path(@shop.id),flash: {success: "店舗情報を更新しました" }
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
      redirect_to admin_shops_path,flash: {success: "店舗を新規投稿しました" }
    else
      @areas = Area.all
      render :new
    end
  end

  def destroy
    @shop = Shop.find(params[:id])
    @shop.destroy
    redirect_to admin_shops_path,flash: {danger: "店舗情報を削除しました" }
  end

  private

  def shop_params
    params.require(:shop).permit(:shop_name, :address, :bussiness_hour, :shop_image,:shop_status, :area_id)
  end
end
