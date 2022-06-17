class User::ShopsController < ApplicationController
  before_action :authenticate_user!

  def index
    @shops = if params[:create]
              # 新着順に並べる
                 Shop.latest.where(shop_status: false).page(params[:page]).per(6)
               elsif params[:update]
              # 更新順に並べる
                 Shop.updated.where(shop_status: false).page(params[:page]).per(6)
               elsif params[:popular]
              # 店舗の投稿が多い順に並べる
                 Kaminari.paginate_array(Shop.where(shop_status: false).shop_popular).page(params[:page]).per(6)
               else
                 Shop.where(shop_status: false).page(params[:page]).per(6)
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
    @result_shops = if params[:create]
                    # 新着順に並べる
                      @search_shop.result.latest.where(shop_status: false).page(params[:page]).per(6)
                    elsif params[:update]
                    # 更新順に並べる
                      @search_shop.result.updated.where(shop_status: false).page(params[:page]).per(6)
                    elsif params[:popular]
                    # 店舗の投稿が多い順に並べる
                      Kaminari.paginate_array(@search_shop.result.where(shop_status: false).shop_popular).page(params[:page]).per(6)
                    else
                      @search_shop.result.where(shop_status: false).page(params[:page]).per(6)
                    end
  end

  def map
    @maps = Shop.all
  end

  private

  def set_q
    @q = Shop.ransack(params[:q])
  end

  def shop_params
    params.require(:shop).permit(:shop_name, :shop_image, :bussiness_hour, :address, :shop_status, :area_id, :latitude, :longitude)
  end
end
