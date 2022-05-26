class User::HomesController < ApplicationController

  def top
    @posts = Post.get_posts_sort_of_CreateDate(3)
    @search = Post.ransack(params[:q])
    @search.result.page(params[:page]).per(6)
    @search_shop = Shop.ransack(params[:q])
    @result_shops = @search_shop.result
    @maps = Shop.all
  end

  def about
  end

  private

  def set_q
    @q = Post.ransack(params[:q])
  end
end
