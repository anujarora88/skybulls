module Trades
  class Sell < Trade

    def shares
      -1 * amount
    end

  end
end