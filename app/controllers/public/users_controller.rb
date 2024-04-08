class Public::UsersController < ApplicationController
  def mypage
    @posts = current_user.posts
    @user = current_user
  end
  
  def edit
    @user = current_user
  end

end
