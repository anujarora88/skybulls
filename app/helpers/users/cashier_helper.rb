module Users::CashierHelper

  def cash_in_play
    humanized_money_with_symbol current_user.account.money_in_play
  end

  def total_cash
    humanized_money_with_symbol(current_user.account.balance + current_user.account.money_in_play)
  end




end
