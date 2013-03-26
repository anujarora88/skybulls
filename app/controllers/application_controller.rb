class ApplicationController < ActionController::Base
  protect_from_forgery


  def after_sign_in_path_for(resource)
    request.env['omniauth.origin'] || stored_location_for(resource) || dashboard_path
  end

  def another_by_method
    if current_user.nil?
      "application_admin_layout"
    end

    else
      "application_layout"
  end

    end