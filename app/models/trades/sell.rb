module Trades
  class Sell < Trade

    def shares
      -1 * amount
    end

    def total_cents_spent
      price_cents * -1
    end


    private

      def update_balance
        user_league_association.balance += price * amount
        user_league_association.save!
      end

  end
end