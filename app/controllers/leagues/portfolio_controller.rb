class Leagues::PortfolioController < Leagues::AbstractController


  def index
    @open_trades = @user_league_association.open_trades
    @pending_trades = @user_league_association.pending_trades
    @all_trades = @user_league_association.trades
  end

end
