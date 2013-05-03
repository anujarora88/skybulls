module Bids
  class Buy < Bid
    def execute_trade!(price)
      return unless user_league_association.league.in_progress?
      trade = Trades::Buy.new(:price => price, :amount => amount, :stock => stock,
                               :user_league_association => user_league_association, :system_created => true)
      trade.save!
      self.trade_id = trade.id
      self.save!
    end
  end
end