class User::UsersController < ApplicationController
  before_action :ensure_guest_user, only: [:edit]
  before_action :authenticate_user!

  def show
    @user = User.find(params[:id])
    @posts = if params[:create]
                @user.posts.latest.page(params[:page]).per(6)
              elsif params[:rate]
                @user.posts.rated.page(params[:page]).per(6)
              elsif params[:impressions_count]
                @user.posts.views.page(params[:page]).per(6)
              elsif params[:favorite]
                Kaminari.paginate_array(@user.posts.post_favorites).page(params[:page]).per(6)
              elsif params[:post_comment]
                Kaminari.paginate_array(@user.posts.post_comments).page(params[:page]).per(6)
              else
                @user.posts.page(params[:page]).per(6)
    end
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
     redirect_to user_path(current_user),flash: {success: "ユーザー情報を更新しました"}
    else
     render :edit
    end
  end

  def defection
    @user = current_user
    @user.update(user_status: true)
    reset_session
    redirect_to root_path,flash: {danger: "退会しました"}
  end

  private

  def ensure_guest_user
    @user = User.find(params[:id])
    if @user.user_name == "guestuser"
      redirect_to user_path(current_user) ,flash: {danger: "ゲストユーザーはプロフィール編集画面へ移行できません"}
    end
  end

  def remember_me
    true
  end

  def user_params
    params.require(:user).permit(:user_name, :introduction, :profile_image, :email)
  end
end
