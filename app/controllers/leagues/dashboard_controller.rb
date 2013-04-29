class Leagues::DashboardController < Leagues::AbstractController

  def index

  end

  def search
    keywords = params[:keywords]
    @stocks = Stock.joins(:company).where("stocks.symbol LIKE %?% OR companies.name LIKE %?%").all
  end

end