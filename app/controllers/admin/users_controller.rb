class Admin::UsersController < ApplicationController

  def index
    @users = User.page(params[:page]).per(10)
  end

  def show
    @user = User.find(params[:id])
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
   if @user.update(user_params)
     flash[:notice] = "更新しました"
     redirect_to admin_user_path(@user.id)
   else
     render :edit
   end
  end

  private

  def user_params
    params.require(:user).permit(:user_name, :email, :introduction, :user_image, :user_status)
  end
end
