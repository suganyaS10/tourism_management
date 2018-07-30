class Users::RegistrationsController < Devise::RegistrationsController
	before_action :configure_sign_up_params, only: [:create]
  before_action :configure_account_update_params, only: [:update]

	private

  def configure_sign_up_params
    devise_parameter_sanitizer.permit(:sign_up, keys: [:name, :date_of_birth, :age,
    	:email, :password, :password_confirmation, :role_id])
  end

  def configure_account_update_params
    devise_parameter_sanitizer.for(:account_update) { |u| u.permit(:name, :date_of_birth, :age, :email, :password, 
    	:password_confirmation, :current_password, :role_id) }
  end
end
