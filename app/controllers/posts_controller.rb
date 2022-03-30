class PostsController < ApplicationController
  def index
    @user = find_user
    @posts = Post.last(3)
  end

  def show
    @post = find_user.posts.find(params[:id])
  end

  def find_user
    User.find(params[:user_id])
  end
end
