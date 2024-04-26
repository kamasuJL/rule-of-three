# frozen_string_literal: true

class Public::SessionsController < Devise::SessionsController
  # before_action :configure_sign_in_params, only: [:create]
  before_action :reject_inactive_user, only: [:create]

  # GET /resource/sign_in
  # def new
  #   super
  # end

  # POST /resource/sign_in
  # def create
  #   super
  # end

  # DELETE /resource/sign_out
  # def destroy
  #   super
  # end
  def guest_sign_in
    user = User.guest
    sign_in user
    redirect_to mypage_path, notice: "guestuserでログインしました。"
  end

  protected
  
  # def after_sign_in_path_for(resource)
  #   mypage_path
  # end
  
  # def after_sign_out_path_for(resource)
  #   root_path
  # end
  
  # アクティブであるかを判断するメソッド
  def reject_inactive_user
    # 【処理内容1】 入力されたemailからアカウントを1件取得
    user = User.find_by(email: params[:user][:email])
    # 【処理内容2】 アカウントを取得できなかった場合、このメソッドを終了する
    return if user.nil?
    # 【処理内容3】 取得したアカウントのパスワードと入力されたパスワードが一致していない場合、このメソッドを終了する
    return unless user.valid_password?(params[:user][:password])
    # 【処理内容4】 アクティブでない会員に対する処理
    unless user.is_active
      flash[:alert] = "退会済みですので、新規登録をお願いいたします"
      redirect_to new_user_registration_path
    end
  end

  # If you have extra params to permit, append them to the sanitizer.
  # def configure_sign_in_params
  #   devise_parameter_sanitizer.permit(:sign_in, keys: [:attribute])
  # end
end
