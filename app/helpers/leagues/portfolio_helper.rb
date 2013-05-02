module Leagues::PortfolioHelper

  def portfolio_return_class
    @user_league_association.portfolio_return > 0 ? 'up-arrow': 'down-arrow'
  end
end
