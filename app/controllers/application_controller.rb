class ApplicationController < ActionController::Base
  protected

  def after_sign_in_path_for(resource)
    session[:requested_url] || root_path
  end
end
