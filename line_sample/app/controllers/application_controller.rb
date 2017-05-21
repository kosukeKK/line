class ApplicationController < ActionController::Base
  protect_from_forgery with: :null_session
  before_action :configure_permitted_parameters, if: :devise_controller?

  def logged_in_user
    redirect_to new_user_session_path unless user_signed_in?
  end

  def configure_permitted_parameters
    added_attrs = [ :name, :email, :password, :password_confirmation　]
    devise_parameter_sanitizer.permit :sign_up, keys: added_attrs
    devise_parameter_sanitizer.permit :account_update, keys: added_attrs
    devise_parameter_sanitizer.permit :sign_in, keys: added_attrs
  end
end
