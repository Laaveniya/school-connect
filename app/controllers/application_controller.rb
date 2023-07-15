class ApplicationController < ActionController::Base
  layout 'center_left_layout'

  protected

  def after_sign_in_path_for(resource)
    if resource.student?
      dashboard_path
    else
      root_path
    end
  end

  rescue_from CanCan::AccessDenied do |exception|
    redirect_to root_path, alert: 'Access denied.'
  end
end
