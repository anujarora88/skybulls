module User::CashierHelper

  def available_cash
    humanized_money_with_symbol current_user.account.balance
  end

  def cash_in_play
    humanized_money_with_symbol Money.new(0)
  end

  def total_cash
    available_cash
  end


end
