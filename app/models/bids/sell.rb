module Bids
  class Sell < Bid

      def execute_trade!(price)
        raise "League Ended!!" unless user_league_association.league.in_progress?
        trade = Trades::Sell.new(:price => price, :amount => amount, :stock => stock,
                                 :user_league_association => user_league_association, :system_created => true)
        trade.save!
        self.trade_id = trade.id
        self.save!
      end

  end
end