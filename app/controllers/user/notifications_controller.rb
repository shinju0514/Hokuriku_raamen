class User::NotificationsController < ApplicationController
  def index
    @notifications = current_user.passive_notifications.page(params[:page]).per(10)
    @notifications.where(checked: false).each do |notification|
      notification.checked = true
      notification.save
    end
  end

  def destroy
    #通知を全て削除する
    @notifications = current_user.passive_notifications.destroy_all
    redirect_to notifications_path
  end
end
