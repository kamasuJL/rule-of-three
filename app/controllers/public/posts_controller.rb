class Public::PostsController < ApplicationController
  def new
    @post = Post.new
  end
  
  def create
    @post = Post.new(post_params)
    @post.user_id = current_user.id
    @post.save
    redirect_to post_path(@post.id)
  end
  
  def show
    @post = Post.find(params[:id])
  end
  
  def index
    @posts = Post.all
  end
  
  private

  def post_params
    params.require(:post).permit(:title, :phase, :body, :way, :investment)
  end
end
