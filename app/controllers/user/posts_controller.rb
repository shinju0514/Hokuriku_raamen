class User::PostsController < ApplicationController
  before_action :correct_user, only: [:edit, :update]
  before_action :authenticate_user!

  # モデルに定義した記述を使用している
  def index
    @posts = if params[:create]
              # 新着順に並べる
                 Post.latest.page(params[:page]).per(6)
               elsif params[:rate]
              # 評価順に並べる
                 Post.rated.page(params[:page]).per(6)
               elsif params[:impressions_count]
              # 閲覧数順に並べる
                 Post.views.page(params[:page]).per(6)
               elsif params[:favorite]
              # いいね順に並べる
                 Kaminari.paginate_array(Post.post_favorites).page(params[:page]).per(6)
               elsif params[:post_comment]
              # コメント数順に並べる
                 Kaminari.paginate_array(Post.post_comments).page(params[:page]).per(6)
               else
                 Post.page(params[:page]).per(6)
               end
  end

  def show
    @post = Post.find(params[:id])
    # 閲覧数の記述　user_id1つにつき１回閲覧数が増える
    impressionist(@post, nil, unique: [:user_id])
    @user = @post.user
    @shop = @post.shop
    @post_comment = PostComment.new
  end

  def edit
    @shops = Shop.all
    @post = Post.find(params[:id])
    @user = @post.user
    if @user.id == current_user.id
      render :edit
    else
      redirect_to root_path
    end
  end

  def update
    @post = Post.find(params[:id])
    if @post.update(post_params)
      redirect_to post_path(@post.id),flash: {success: "レビューを更新しました"}
    else
      @user = @post.user
      render :edit
    end
  end

  def new
    @post = Post.new
    @shops = Shop.all
    @areas = Area.all
    @tags = Tag.all
  end

  def create
    @post = Post.new(post_params)
    @post.user_id = current_user.id
    if @post.save
      redirect_to post_path(@post.id),flash: {success: "レビューを投稿しました"}
    else
      @shops = Shop.all
      @areas = Area.all
      render :new
    end
  end

  def destroy
    @post = Post.find(params[:id])
    @post.destroy
    redirect_to posts_path,flash: {danger: "レビューを削除しました" }
  end

  def map
    @maps = Post.page(params[:page]).per(6)
  end

  # 評価順と投稿順に並べる記述
  # モデルに定義したスコープを使用している
  def search
    @search = Post.ransack(params[:q])
   @results = if params[:create]
                # 新着順に並べる
                  @search.result.latest.page(params[:page]).per(6)
                elsif params[:rate]
                # 評価順に並べる
                  @search.result.rated.page(params[:page]).per(6)
                elsif params[:impressions_count]
                # 閲覧数順に並べる
                 @search.result.views.page(params[:page]).per(6)
                elsif params[:favorite]
                # いいね順に並べる
                 Kaminari.paginate_array(@search.result.post_favorites).page(params[:page]).per(6)
                elsif params[:post_comment]
                # コメント順に並べる
                 Kaminari.paginate_array(@search.result.post_comments).page(params[:page]).per(6)
                else
                 @search.result.page(params[:page]).per(6)
                end
  end

  private

  def set_q
    @q = Post.ransack(params[:q])
  end

  def post_params
    params.require(:post).permit(:menu, :body, :rate, :post_image, :area_id,:shop_id, :address, :latitude, :longitude, tag_ids:[])
  end

  # 他人の編集画面へ遷移できない記述

  def correct_user
    @post = Post.find(params[:id])
    @user = @post.user
    redirect_to(posts_path) unless @user == current_user
  end
end
