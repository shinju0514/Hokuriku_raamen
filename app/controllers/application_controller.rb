class ApplicationController < ActionController::Base

  before_action :configure_permitted_parameters, if: :devise_controller?
  before_action :search_post
  add_flash_types :success, :info, :warning, :danger

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
    # if resource_or_scope.is_a?(Admin)
    #   admin_root_path
    # else
    #   current_user
    # end
    case resource
    when Admin
      admin_root_path
    when User
      current_user
    end
  end

  def after_sign_out_path_for(resource)
    case resource
    when :admin
      new_admin_session_path
    when :user
      root_path
    end
  end

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:email, :user_name, :password])
  end

end
