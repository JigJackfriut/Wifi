class ApplicationController < ActionController::Base
protect_from_forgery with: :exception
before_action :configure_permitted_parameters, if: :devise_controller?
def home
 render ‘layouts/home’
 end
protected
 def configure_permitted_parameters
   devise_parameter_sanitizer.permit(:sign_up) { |u| u.permit(:email, :password, :first_name, :last_name ,:phone, :address1, :address2, :city, :state, :zip, :account_type, :admin)}
   devise_parameter_sanitizer.permit(:account_update) { |u| u.permit(:email, :password, :current_password, :first_name, :last_name ,:phone, :address1, :address2, :city, :state, :zip, :account_type, :admin) }
 end
end
