class User::HomesController < ApplicationController

  def top
    @posts = Post.all
    @search = Post.ransack(params[:q])
    @results = params[:tag_id].present? ? Tag.find(params[:tag_id]).posts : @search.result
    @search_shop = Shop.ransack(params[:q])
    @result_shops = @search_shop.result
  end

  def about
  end

  private

  def set_q
    @q = Post.ransack(params[:q])
  end
end
