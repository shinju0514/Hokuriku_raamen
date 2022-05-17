class User::UsersController < ApplicationController
  def show
    @user = User.find(params[:id])
    @posts = @user.posts
  end

  def edit
    @user = User.find(params[:id])
    if @user.id == current_user.id
      render :edit
    else
      redirect_to root_path
    end
  end

  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
     flash[:notice] = "更新しました"
     redirect_to user_path(current_user)
    else
     render :edit
    end
  end

  def unsubscribe
  end

  private

  def remember_me
    true
  end

  def user_params
    params.require(:user).permit(:user_name, :introduction, :profile_image)
  end
end
