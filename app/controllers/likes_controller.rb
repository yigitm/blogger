class LikesController < ApplicationController
  before_action :find_post

  def create
    @like = Like.new
    @like.post_id = @post.id
    @like.author_id = find_user.id

    flash[:notice] = 'Liked it!' if @like.save
    redirect_to user_post_path(find_user.id, @post.id)
  end

  def find_post
    @post = Post.find(params[:post_id])
  end

  def find_user
    User.find(params[:user_id])
  end

  private

  def like_params
    params.require(:like).permit(:post_id, :author_id)
  end
end
