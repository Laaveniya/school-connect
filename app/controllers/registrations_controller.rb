class RegistrationsController < Devise::RegistrationsController
  before_action :configure_sign_up_params, only: [:create]
  layout 'center_left_layout'

  protected

  def configure_sign_up_params
    devise_parameter_sanitizer.permit(:sign_up, keys: [:name])
  end
end