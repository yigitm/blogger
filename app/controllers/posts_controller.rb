class PostsController < ApplicationController
  def index
    @user = find_user
    @posts = Post.last(3)
  end

  def show
    @post = find_user.posts.find(params[:id])
  end

  def new
    @user = find_user
    @post = Post.new
  end

  def create
    @user = find_user
    @post = @user.posts.new(post_params)
    @post.comments_counter = 0
    @post.likes_counter = 0

      if @post.save
        redirect_to user_posts_path(@user)
      else
        flash[:alert] = 'Post can not created!'
        render :new
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
