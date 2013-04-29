class Leagues::DashboardController < Leagues::AbstractController

  def index

  end

  def search
    keywords = params[:keywords]
    @stocks = Stock.joins(:company).where("stocks.symbol LIKE :term OR companies.name LIKE :term", {term: "%#{params[:term]}%"}).all
    respond_to do |format|
      format.json {render json: @stocks}
    end
  end

  def select_stock
    @stock = Stock.find(params[:id])
    Jobs::Work.enqueue(Jobs::SaveSearchedStock.new(current_user.id, @stock.id, true))
    respond_to do |format|
      format.json {render json: {:status => 'success'}}
    end
  end

end