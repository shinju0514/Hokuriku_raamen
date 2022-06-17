class Admin::PostsController < ApplicationController
  before_action :authenticate_admin!

  # 評価順と投稿順に並べる記述
  # モデルに定義したスコープを使用している
  def index
        @posts = if params[:create]
              # 新着順に並べる
                Post.latest.page(params[:page]).per(10)
                 elsif params[:rate]
                # 評価順に並べる
                Post.rated.page(params[:page]).per(10)
                 elsif params[:update]
                # 更新順に並べる
                Post.updated.page(params[:page]).per(10)
                 else
                Post.page(params[:page]).per(10)
              end
  end

  def show
    @post = Post.find(params[:id])
    @user = @post.user
    @shop = @post.shop
  end

  def edit
    @post = Post.find(params[:id])
  end

  def update
    @post = Post.find(params[:id])
    if @post.update(post_params)
      redirect_to admin_post_path(@post.id),flash: {success: "レビューを更新しました"}
    else
      render :edit
    end
  end

  def destroy
    @post = Post.find(params[:id])
    @post.destroy
    redirect_to admin_posts_path,flash: {danger: "レビューを削除しました"}
  end

  def post_params
    params.require(:post).permit(:user_id, :menu, :body, :rate, :post_image, :shop_id, :area_id)
  end
end
