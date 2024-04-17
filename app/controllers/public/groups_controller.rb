class Public::GroupsController < ApplicationController
  before_action :authenticate_user!
  before_action :ensure_correct_user, only: [:edit, :update, :destroy]
  
  def new
  end
  
  def create
  end
  
  def show
  end
  
  def index
    @groups = Group.all
  end
  
  def edit
  end
  
  def update
  end
  
  def destroy
  end
  
  private
  
  def group_params
    params.require(:group).permit(:name, :introduction, :group_image)
  end

  def ensure_correct_user
    @group = Group.find(params[:id])
    unless @group.owner_id == current_user.id
      redirect_to groups_path
    end
  end
  
end
