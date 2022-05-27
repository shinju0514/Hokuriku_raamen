class Admin::UsersController < ApplicationController
  before_action :authenticate_admin!

  def index
    @users = User.page(params[:page]).per(10)
  end

  # 新着順と更新順に並べ替える記述
  # モデルに定義したスコープを使用
  def show
    @user = User.find(params[:id])
    if params[(:created_at)||(:rate)]
      @posts = @user.posts.latest.page(params[:page]).per(6)
    elsif
      @posts = @user.posts.rated.page(params[:page]).per(6)
    else
      @posts = @user.posts.page(params[:page]).per(6)
    end
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
   if @user.update(user_params)
     redirect_to admin_user_path(@user.id),flash: {success: "ユーザー情報を更新しました"}
   else
     render :edit
   end
  end

  private

  def user_params
    params.require(:user).permit(:user_name, :email, :introduction, :profile_image, :user_status)
  end
end
