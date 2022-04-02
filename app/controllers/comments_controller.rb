class CommentsController < ApplicationController
  def new
    @comment = Comment.new
  end

  def create
    @post = Post.find(params[:id])
    @comment = Comment.new(comment_params)
    @comment.author_id = current_user.id
    @comment.post_id = @post.id

    if @comment.save
      redirect_to user_post_path(current_user.id, @post.id)
    else
      redirect_to user_post_path(current_user.id, @post.id), alert: 'Comments not created!'
    end
  end

  private

  def comment_params
    params.require(:comment).permit(:text)
  end
end
