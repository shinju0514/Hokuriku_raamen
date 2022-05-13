class User::PostsController < ApplicationController
  before_action :authenticate_user!, except: [:show, :index]

  def index
    @posts = Post.page(params[:page]).per(6)
  end

  def show
    @post = Post.find(params[:id])
    @user = @post.user
    @shop = @post.shop
  end

  def edit
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
      redirect_to post_path(@post.id),notice: "レビューを更新しました。"
    else
      @user = @post.user
      render :edit
    end
  end

  def new
    @post = Post.new
    @shops = Shop.all
    @areas = Area.all
  end

  def create
    @post = Post.new(post_params)
    @post.user_id = current_user.id
    if @post.save
      redirect_to posts_path,notice: "レビューを投稿しました。"
    else
      @shops = Shop.all
      @areas = Area.all
      render :new
    end
  end

  def destroy
    @post = Post.find(params[:id])
    @post.destroy
    redirect_to posts_path
  end

  private

  def post_params
    params.require(:post).permit(:menu, :body, :rate, :post_image, :shop_id, :area_id)
  end
end
