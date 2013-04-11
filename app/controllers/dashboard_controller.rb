class DashboardController < ApplicationController


  def index

    @leagues = League.all
      respond_to do |format|
        format.html {render :'dashboard/index'}
      end
    end

  end
