class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  before_action :configure_permitted_parameters, if: :devise_controller?

  protected

  def configure_permitted_parameters
  	devise_parameter_sanitizer.permit(:sign_up, keys: [:name, :email, :password, :password_confirmation])
  	devise_parameter_sanitizer.permit(:account_update, keys: [:name, :email, :password, :password_confirmation, :current_password])
  end

  # def after_sign_in_path_for(resource_or_scope)
  #   model = resource_or_scope.class.to_s.downcase
  #   if model == 'user'
  #     admin_dashboard_path
  #   elsif model == 'advertiser'
  #     advertisers_ads_path
  #   end
  # end

  def after_sign_out_path_for(resource_or_scope)
  	if resource_or_scope == :user
			admin_login_path
  	elsif resource_or_scope == :advertiser
  		root_path
  	end
  end
end
