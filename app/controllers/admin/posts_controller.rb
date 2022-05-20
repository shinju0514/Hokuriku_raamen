class Admin::PostsController < ApplicationController
  def index
    if params[(:created_at)||(:rate)]
      @posts = Post.latest.page(params[:page]).per(10)
    elsif
      @posts = Post.rated.page(params[:page]).per(10)
    else
      @posts = Post.page(params[:page]).per(10)
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
    params.require(:post).permit(:user_id, :menu, :body, :rate, :post_image)
  end
end
