class User::HomesController < ApplicationController

  def top
    @posts = Post.order(created_at: :DESC).page(params[:page]).per(3)
    @search = Post.ransack(params[:q])
    @results = params[:tag_id].present? ? Tag.find(params[:tag_id]).posts : @search.result.page(params[:page]).per(6)
    @search_shop = Shop.ransack(params[:q])
    @result_shops = @search_shop.result
    @maps = Post.all
  end

  def about
  end

  private

  def set_q
    @q = Post.ransack(params[:q])
  end
end
