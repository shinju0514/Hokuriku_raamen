class User::PostsController < ApplicationController
  before_action :authenticate_user!, except: [:show, :index]

  def index
    @posts = Post.page(params[:page]).per(6)
    # newのバリデーションを返す際indexに戻ろうとするためnew画面へ移行させる。
    redirect_to new_post_path
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
    @post.update(post_params)
    redirect_to post_path(@post.id)
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
      redirect_to posts_path
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
