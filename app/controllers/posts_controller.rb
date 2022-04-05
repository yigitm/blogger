class PostsController < ApplicationController
  def index
    @user = find_user
    @posts = Post.last(3)
  end

  def show
    @post = find_user.posts.find(params[:id])
    @user = find_user
    @comments = @post.comments
    @liked_post = Post.find(params[:id]).id
  end

  def new
    @user = find_user
    @post = Post.new
  end

  def create
    @post = find_user.posts.new(post_params)
    @post.comments_counter = 0
    @post.likes_counter = 0

    if @post.save
      redirect_to user_posts_path(find_user.id)
    else
      redirect_to user_post_path(find_user.id), alert: 'Post not created!'
    end
  end

  def find_user
    User.find(params[:user_id])
  end

  private

  def post_params
    params.require(:post).permit(:title, :text)
  end
end
