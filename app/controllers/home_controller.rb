class HomeController < ApplicationController

  layout(false)

  def index

  end

  def error
    raise "testing";
  end

end
