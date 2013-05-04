class PortfolioController < Users::AbstractController

  append_before_filter :initialize_user_leagues

  def show
    if @user_league_association
      @open_trades = @user_league_association.open_trades
      @pending_trades = @user_league_association.pending_trades
      @all_trades = @user_league_association.trades
    end
  end

  def initialize_user_leagues
    @leagues = current_user.leagues.order("end_time")
    unless @leagues.empty?
      @league = params[:id] == 'base'? @leagues.first : League.find(params[:id])
      @user_league_association = current_user.league_association(@league)
    end
  end

end
