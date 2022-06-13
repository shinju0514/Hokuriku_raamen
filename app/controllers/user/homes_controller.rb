class User::HomesController < ApplicationController

# get_posts_sort_of_CreateDateはモデルで定義した記述
  def top
    @posts = Post.get_posts_sort_of_CreateDate(3)
    @search = Post.ransack(params[:q])
    @search.result.page(params[:page]).per(6)
    @search_shop = Shop.ransack(params[:q])
    @result_shops = @search_shop.result
    @maps = Shop.all
    @rank = Post.rated.limit(3)
    @favorites = Post.rated.limit(3)
    if Rails.env.development?
      @random_posts = Post.order("RANDOM()").limit(3)
    else
      @random_posts = Post.order("RAND()").limit(3)
    end
  end

  def rank
    if params[:status] == "new"
      p "new"
    elsif params[:status] == "rate"
      p "rate"
    elsif params[:status] == "favorite"
      p "favorite"
    else
    end
  end

  def about
  end

  private

  def set_q
    @q = Post.ransack(params[:q])
  end
end
