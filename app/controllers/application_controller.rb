class ApplicationController < ActionController::Base
  # 以下の記述をここに置くとログインエラー
  # before_action :configure_sign_up_params, if: :devise_controller?
  before_action :configure_permitted_parameters, if: :devise_controller?
  
  def after_sign_in_path_for(resource)
    case resource
      when Admin
        admin_root_path
      when User
        mypage_path
      else
        root_path
    end
  end
  
  def after_sign_out_path_for(resource_or_scope)
    if resource_or_scope == :admin
      admin_session_path
    else
      about_path
    end
  end
  
  protected
  
  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:name])
  end
end
