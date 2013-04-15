module Users::CashierHelper

  def cash_in_play
    humanized_money_with_symbol Money.new(0)
  end

  def total_cash
    available_cash
  end


end
