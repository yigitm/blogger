class UsersController < ApplicationController
  def index
  end

  def show
    User.find(params[:id])
  end
end
