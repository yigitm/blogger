class PostsController < ApplicationController
  def index
    @user = User.find(params[:user_id])
    @posts = Post.last(3)
  end

  def show
  end
end
