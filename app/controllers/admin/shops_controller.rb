class Admin::ShopsController < ApplicationController
  before_action :authenticate_admin!

  # 新着順と更新順に並べ替える記述
  # モデルに定義したスコープを使用
  def index
    if params[(:created_at)||(:updated_at)]
      # 新着順に並べる
      @shops = Shop.latest.page(params[:page]).per(10)
    elsif
      # 更新順に並べる
      @shops = Shop.updated.page(params[:page]).per(10)
    else
      @shops = Shop.page(params[:page]).per(10)
    end
  end

  def show
    @shop = Shop.find(params[:id])
    @posts = if params[:create]
              # 新着順に並べる
              @shop.posts.latest.page(params[:page]).per(6)
              elsif params[:rate]
              # 評価順に並べる
                @shop.posts.rated.page(params[:page]).per(6)
              elsif params[:impressions_count]
              # 閲覧数順に並べる
                @shop.posts.views.page(params[:page]).per(6)
              elsif params[:favorite]
              # いいね順に並べる
                Kaminari.paginate_array(@shop.posts.post_favorites).page(params[:page]).per(6)
              elsif params[:post_comment]
              # コメント数順に並べる
                Kaminari.paginate_array(@shop.posts.post_comments).page(params[:page]).per(6)
              else
                @shop.posts.page(params[:page]).per(6)
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
    params.require(:shop).permit(:shop_name, :address, :bussiness_hour, :shop_image,:shop_status, :area_id, :latitude, :longitude)
  end
end
