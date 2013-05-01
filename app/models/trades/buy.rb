module Trades
  class Buy < Trade
    def shares
      amount
    end
  end
end