class Public::PostsController < ApplicationController
  def new
    @post = Post.new
  end
  
  def create
    @post = Post.new(post_params)
    @post.user_id = current_user.id
    if @post.save
      redirect_to post_path(@post.id)
    else
      render 'new'
    end
  end
  
  def show
    @post = Post.find(params[:id])
    @user = @post.user
  end
  
  def index
    @posts = Post.all
  end
  
  def edit
    @post = Post.find(params[:id])
  end
  
  def update
    @post = Post.find(params[:id])
    if @post.update(post_params)
      redirect_to post_path(@post)
    else
      render "edit"
    end
  end
  
  
  
  private

  def post_params
    params.require(:post).permit(:title, :phase, :body, :way, :investment)
  end
end
