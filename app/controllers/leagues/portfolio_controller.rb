class Leagues::PortfolioController < Leagues::AbstractController


  def index
    @open_trades = @user_league_association.open_trades

  end

end
