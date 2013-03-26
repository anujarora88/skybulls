class DashboardController < ApplicationController

  def index
      if(current_admin_user)
        respond_to do |format|
            format.html {render :'admin/index' , :layout => 'league'}
      end
    else
      respond_to do |format|
        format.html {render :'dashboard/index'}
      end
    end
  end

  end
