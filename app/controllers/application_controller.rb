class ApplicationController < ActionController::Base

  before_action :configure_permitted_parameters, if: :devise_controller?
  before_action :search_post
  before_action :authenticate_user!, except: [:about, :top]

  def search_post
    @search = Post.ransack(params[:q])
    @results = @search.result
  end

  def search_shop
    @search = Shop.ransack(params[:q])
    @results = @search.result
  end

   private

  def after_sign_in_path_for(resource)
    current_user
  end

  def after_sign_out_path_for(resource)
    root_path
  end

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:email, :user_name, :password])
  end

end
