class User::PostsController < ApplicationController
  def index
    @posts = Post.page(params[:page]).per(6)
  end

  def show

  end

  def edit
  end

  def update
  end

  def new
    @post = Post.new
  end

  def create
    @post = Post.new(post_params)
    @post.save
    redirect_to posts_path
  end

  def destroy
  end

  private

  def post_params
    params.require(:post).permit(:menu, :body, :rate)
  end
end
