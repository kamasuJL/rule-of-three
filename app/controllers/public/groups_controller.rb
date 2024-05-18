class Public::GroupsController < ApplicationController
  before_action :authenticate_user!
  before_action :ensure_correct_user, only: [:edit, :update, :destroy, :permits]
  
  def new
    @group = Group.new
  end
  
  def create
    @group = Group.new(group_params)
    group_image = params[:group][:group_image]

    if group_image.nil?
      flash[:alert] = "画像ファイルをアップロードしてください。"
      render 'new' and return
    end

    begin
      # 画像からタグを取得
      tags = Vision.get_image_data(group_image)
    rescue => e
      flash[:alert] = "画像の解析に失敗しました: #{e.message}"
      render 'new' and return
    end

    @group.owner_id = current_user.id

    if @group.save
      tags.each do |tag|
        @group.tags.create(name: tag)
      end
      redirect_to groups_path, notice: 'グループが作成されました。'
    else
      render 'new'
    end
  end
  
  def show
    @group = Group.find(params[:id])
  end
  
  def index
    @groups = Group.all
  end
  
  def edit
  end
  
  def update
    if @group.update(group_params)
      redirect_to groups_path
    else
      render "edit"
    end
  end
  
  def permits
    @group = Group.find(params[:id])
    @permits = @group.permits.page(params[:page])
  end

  private
  
  def group_params
    params.require(:group).permit(:name, :introduction, :group_image)
  end

  def ensure_correct_user
    @group = Group.find(params[:id])
    unless @group.owner_id == current_user.id
      redirect_to group_path(@group), alert: "グループオーナーのみ編集が可能です"
    end
  end
end
