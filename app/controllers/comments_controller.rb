class CommentsController < ApplicationController
  def create
    @user = User.find(params[:user_id])
    @post = Post.find(params[:post_id])
    @comment = Comments.new(comment_params)
    @comment.author_id = @user.id
    @comment.post_id = @post.id

    if @comment.save
        redirect_to user_posts_path(@user.id)
      else
        render :new
    end
  end

  private
    def comment_params
      params.require(:comment).permit(:text)
    end
end