class User::SearchsController < ApplicationController

  def search
    @posts = Post.all
    @search = Post.ransack(params[:q])
    @results = @search.result
  end
end