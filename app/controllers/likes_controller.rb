class LikesController < ApplicationController
  before_action :find_post

  def create
    @like = Like.new
    @like.post_id = @post.id
    @like.author_id = current_user.id

    redirect_to user_post_path(current_user.id, @post.id), notice: 'Liked it!' if @like.save
  end

  def find_post
    @post = Post.find(params[:post_id])
  end

  private

  def like_params
    params.require(:like).permit(:post_id, :author_id)
  end
end
