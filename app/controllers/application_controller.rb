class ApplicationController < ActionController::Base
  protect_from_forgery

  def render_access_denied
    if html?
      render :template => 'errors/access_denied', :status => 401
    else
      render :text => '401 Access Denied', :status => 401
    end
  end

  def render_not_found(error)
    if html?
      render :template => 'errors/not_found', :status => 404
    else
      render :text => '404 Profile Not Found', :status => 404
    end
  end

  def after_sign_in_path_for(resource)
    if resource.instance_of?AdminUser
           admin_url
    else
     # request.env['omniauth.origin'] || stored_location_for(resource) || dashboard_path
      dashboard_path
    end
  end

end