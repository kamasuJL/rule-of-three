class Public::SearchesController < ApplicationController
  before_action :authenticate_user!

  def search
    @model = params[:model]
		@content = params[:content]
		if @model == 'user'
			@records = User.search_for(@content)
		elsif @model == 'post'
			@records = Post.search_for(@content)
		else
			@records = Group.search_for(@content)
		end
  end

end
