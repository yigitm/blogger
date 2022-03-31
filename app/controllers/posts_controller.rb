class PostsController < ApplicationController
  def index
    @user = current_user
    @posts = Post.last(3)
  end

  def show
    @post = current_user.posts.find(params[:id])
    @user = current_user
    @comments = @post.comments
  end

  def new
    @user = current_user
    @post = Post.new
  end

  def create
    @post = current_user.posts.new(post_params)
    @post.comments_counter = 0
    @post.likes_counter = 0

      if @post.save
        redirect_to user_posts_path(current_user.id)
      else
        redirect_to user_posts_path(current_user.id), alert: "Posts not created!"
      end
  end
  
  private
    def post_params
      params.require(:post).permit(:title, :text)
    end
end
