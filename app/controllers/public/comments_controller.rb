class Public::CommentsController < ApplicationController
  
  def create
    post = Post.find(params[:post_id])
    @comment = current_user.comments.new(comment_params)
    @comment.post_id = post.id
    unless @comment.save
      render 'error'
    end
  end
  
  def destroy
    @comment = Comment.find(params[:id])
    @comment.destroy
  end
  
  private
  def comment_params
    params.require(:comment).permit(:comment)
  end
end
