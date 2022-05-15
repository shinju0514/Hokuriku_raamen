class User::SearchsController < ApplicationController

  def search
    @search = Post.ransack(params[:q])
    @results = params[:tag_id].present? ? Tag.find(params[:tag_id]).posts : @search.result
  end
end