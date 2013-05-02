module Trades
  class Buy < Trade
    def shares
      amount
    end

    def total_cents_spent
      price_cents
    end

    validate :check_balance

    private

    def update_balance
      user_league_association.balance -= price * amount
      user_league_association.save!
    end

    def check_balance
      errors.add(:base, "Not enough balance") if user_league_association.balance < Money.new(price_cents * amount, price_currency)
    end
  end
end