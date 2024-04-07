class ApplicationController < ActionController::Base
  # 以下の記述をここに置くとログインエラー
  # before_action :configure_sign_up_params, if: :devise_controller?
  before_action :configure_permitted_parameters, if: :devise_controller?
  
  protected
  
  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:name])
  end
end
