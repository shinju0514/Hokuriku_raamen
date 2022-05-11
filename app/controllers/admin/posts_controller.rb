class Admin::PostsController < ApplicationController
  def index
    @posts = Post.page(params[:page]).per(10)
  end

  def show
  end

  def edit
  end

  def update
  end

  def destroy
  end
end
