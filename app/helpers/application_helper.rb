module ApplicationHelper

  def available_cash
    humanized_money_with_symbol current_user.account.balance
  end

  def current_user_name(max_length)
    name = current_user.display_name
    name.length > max_length ? name[0, max_length-2]+'..' : name
  end

end
