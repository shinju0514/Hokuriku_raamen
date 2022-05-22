class User::PostsController < ApplicationController
  before_action :authenticate_user!

  def index
    if params[(:created_at)||(:rate)]
      @posts = Post.latest.page(params[:page]).per(6)
    elsif
      @posts = Post.rated.page(params[:page]).per(6)
    else
      @posts = Post.page(params[:page]).per(6)
    end
  end

  def show
    @post = Post.find(params[:id])
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
      redirect_to posts_path,flash: {success: "レビューを投稿しました"}
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

  def map
    @maps = Post.page(params[:page]).per(6)
  end

  def search
    @search = Post.ransack(params[:q])
    if params[(:created_at)||(:rate)]
      @results = @search.result.latest.page(params[:page]).per(6)
    elsif
      @results = @search.result.rated.page(params[:page]).per(6)
    else
      @results = @search.result.page(params[:page]).per(6)
    end
  end

  private

  def set_q
    @q = Post.ransack(params[:q])
  end

  def post_params
    params.require(:post).permit(:menu, :body, :rate, :post_image, :area_id,:shop_id, :address, :latitude, :longitude, tag_ids:[])
  end
end
