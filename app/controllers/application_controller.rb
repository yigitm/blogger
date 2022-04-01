class ApplicationController < ActionController::Base
  add_flash_types :info, :error, :warning
  
  def current_user
    User.find(params[:user_id])
  end
end
