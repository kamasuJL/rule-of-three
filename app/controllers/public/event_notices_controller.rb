class Public::EventNoticesController < ApplicationController
  before_action :ensure_correct_user

  def new
    @group = Group.find(params[:group_id])
  end

  def create
    @group = Group.find(params[:group_id])
    @title = params[:title]
    @body = params[:body]

    if @title.blank? || @body.blank?
      flash[:alert] = "タイトルと本文を入力してください"
      redirect_to request.referer || new_group_event_notice_path
    else

      event = {
        :group => @group,
        :title => @title,
        :body => @body
      }

      EventMailer.send_notifications_to_group(event)
      render :sent
    end
  end

  def sent
    redirect_to group_path(params[:group_id])
  end

  private

  def ensure_correct_user
    @group = Group.find(params[:group_id])
    unless @group.owner_id == current_user.id
      redirect_to group_path(@group), alert: "グループオーナーのみ可能な機能です"
    end
  end

end
