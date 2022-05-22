class Admin::ApplicationController < ActionController::Base
  before_action :authenticate_admin!, if: :admin_url

end