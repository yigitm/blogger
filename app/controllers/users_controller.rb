class UsersController < ApplicationController
  def index
    @users = User.all
  end

  def show 
    @user = User.find(params[:id])
  end

  private

  def user_params
    params.require(:user).permit(:id, :name, :photo, :bio, :post_counter)
  end
end
