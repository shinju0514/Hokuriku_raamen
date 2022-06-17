class User::FavoritesController < ApplicationController
  before_action :authenticate_user!

  # いいねする際の記述
  def create
    @post = Post.find(params[:post_id])
    favorite = current_user.favorites.new(post_id: @post.id)
    favorite.save
    @post.create_notification_favorite!(current_user)
  end
  # いいねを取り返す際の記述
  def destroy
    @post = Post.find(params[:post_id])
    favorite = current_user.favorites.find_by(post_id: @post.id)
    favorite.destroy
  end
end