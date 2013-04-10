class DashboardController < ApplicationController


  def index

      respond_to do |format|
        format.html {render :'dashboard/index'}
      end
    end

  end
