# frozen_string_literal: true

class User::SessionsController < Devise::SessionsController
  # before_action :configure_sign_in_params, only: [:create]
  before_action :authenticate_user!
  before_action :user_state, only: [:create]

  # GET /resource/sign_in
  # def new
  #   super
  # end

  # POST /resource/sign_in
  # def create
  #   super
  # end

  # DELETE /resource/sign_out
  # def destroy
  #   super
  # end

  # protected

  # If you have extra params to permit, append them to the sanitizer.
  # def configure_sign_in_params
  #   devise_parameter_sanitizer.permit(:sign_in, keys: [:attribute])
  # end
  # ユーザーステータスが"退会"ならログインできないようにする。
  def user_state
    user = User.find_by_email(params[:user][:email])
    return if !user
    if user.valid_password?(params[:user][:password]) && user.user_status == "退会"
      redirect_to new_user_registration_path
    end
  end

end
